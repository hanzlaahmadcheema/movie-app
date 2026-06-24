import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../core/config/app_config.dart';
import '../../core/local_db/recent_search_dao.dart';
import '../../core/models/movie_item.dart';
import '../../core/models/tmdb_page.dart';
import '../../core/services/tmdb_repository.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/firebase_posters.dart';
import '../../widgets/filter_widgets.dart';
import '../../widgets/pagination.dart';
import '../../widgets/state_views.dart';

enum ExploreMode { search, genre, country, production }

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    required this.title,
    this.mode = ExploreMode.search,
    this.query,
    this.recentSearchDao,
    super.key,
  });

  final String title;
  final ExploreMode mode;
  final String? query;
  final RecentSearchDao? recentSearchDao;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final _repository = TmdbRepository(config: AppConfig.fromEnv());
  final _controller = TextEditingController();
  Timer? _debounce;

  Future<TmdbPage<MovieItem>>? _itemsFuture;
  Future<List<RecentSearch>>? _recentSearchesFuture;
  late final RecentSearchDao _recentSearchDao;
  String _currentQuery = '';
  int _currentPage = 1;
  late FilterSelection _selection;

  @override
  void initState() {
    super.initState();
    _recentSearchDao = widget.recentSearchDao ?? RecentSearchDao();
    _currentQuery = widget.mode == ExploreMode.search
        ? (widget.query ?? '')
        : (widget.query ?? widget.title);
    _selection =
        widget.mode == ExploreMode.genre &&
            _currentQuery.isNotEmpty &&
            _currentQuery != 'Genres'
        ? FilterSelection(genreLabel: _currentQuery)
        : const FilterSelection();
    _controller.text = widget.mode == ExploreMode.search ? _currentQuery : '';
    if (widget.mode == ExploreMode.search) {
      _recentSearchesFuture = _recentSearchDao.list();
    }
    _itemsFuture = _load();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showSearchBar = widget.mode == ExploreMode.search;
    final showFilters =
        widget.mode == ExploreMode.search || widget.mode == ExploreMode.genre;

    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const MovieAppBar(dark: true),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 56, 5, 0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          if (showSearchBar)
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 24, 17, 0),
              child: SizedBox(
                height: 44,
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {});
                    _scheduleSearch(value);
                  },
                  onSubmitted: _runSearch,
                  textInputAction: TextInputAction.search,
                  style: AppTextStyles.normal.copyWith(fontSize: 13),
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColors.surfaceAlt,
                    hintText: 'Search titles',
                    hintStyle: AppTextStyles.normal.copyWith(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(Icons.search, size: 18),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 42,
                      minHeight: 44,
                    ),
                    suffixIcon: _controller.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _controller.clear();
                              _runSearch('');
                            },
                            icon: const Icon(Icons.close, size: 17),
                            tooltip: 'Clear search',
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 11,
                    ),
                  ),
                ),
              ),
            ),
          if (showSearchBar) _buildRecentSearchesPanel(),
          if (showFilters)
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 18, 17, 0),
              child: FilterPanel(
                initialSelection: _selection,
                onApply: (selection) {
                  setState(() {
                    _selection = selection;
                    if (widget.mode == ExploreMode.genre) {
                      _currentQuery =
                          selection.genreLabel ?? widget.query ?? widget.title;
                    }
                    _currentPage = 1;
                    _itemsFuture = _load();
                  });
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 24, 5, 0),
            child: FutureBuilder<TmdbPage<MovieItem>>(
              future: _itemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return AppErrorView(
                    title: 'Could not load results',
                    message: userMessageForError(snapshot.error),
                    onRetry: _reload,
                  );
                }

                final page = snapshot.data;
                final items =
                    page?.items.take(20).toList() ?? const <MovieItem>[];
                if (items.isEmpty) {
                  return AppEmptyState(
                    title: 'No results',
                    message: _currentQuery.trim().isEmpty
                        ? 'No titles are available right now.'
                        : 'No titles matched "$_currentQuery".',
                    icon: Icons.search_off,
                    actionLabel: 'Retry',
                    onAction: _reload,
                  );
                }

                return Column(
                  children: [
                    FirebasePosterGrid(items: items, itemCount: items.length),
                    if (page != null && page.hasMultiplePages) ...[
                      const SizedBox(height: 28),
                      PaginationBar(
                        currentPage: _currentPage,
                        totalPages: page.totalPages,
                        onPageChanged: _goToPage,
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _scheduleSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      _runSearch(value);
    });
  }

  void _runSearch(String value) {
    final query = value.trim();
    setState(() {
      _currentQuery = query;
      _currentPage = 1;
      _itemsFuture = _load();
    });
    if (widget.mode == ExploreMode.search && query.isNotEmpty) {
      unawaited(_saveRecentSearch(query));
    }
  }

  void _reload() {
    setState(() {
      _itemsFuture = _load();
    });
  }

  Future<TmdbPage<MovieItem>> _load() async {
    final query = _currentQuery.trim();
    switch (widget.mode) {
      case ExploreMode.search:
        return _loadSearch(query);
      case ExploreMode.genre:
        return _browseByGenre(query.isEmpty ? widget.title : query);
      case ExploreMode.country:
        return _browseByCountry(query.isEmpty ? widget.title : query);
      case ExploreMode.production:
        return _browseByProduction(query.isEmpty ? widget.title : query);
    }
  }

  Future<TmdbPage<MovieItem>> _loadSearch(String query) async {
    if (query.isEmpty && _selection.type != FilterContentType.all) {
      final page = _selection.type == FilterContentType.movies
          ? await _repository.discoverMovieBrowsePage(
              genreId: int.tryParse(_selection.genreId ?? ''),
              country: _selection.countryCode,
              year: _selection.releaseYear,
              ratingGte: _selection.ratingGte,
              page: _currentPage,
            )
          : await _repository.discoverSeriesBrowsePage(
              genreId: int.tryParse(_selection.genreId ?? ''),
              country: _selection.countryCode,
              year: _selection.releaseYear,
              ratingGte: _selection.ratingGte,
              page: _currentPage,
            );
      return page;
    }

    final page = switch (_selection.type) {
      FilterContentType.movies => await _repository.searchMoviePage(
        query,
        page: _currentPage,
      ),
      FilterContentType.series => await _repository.searchSeriesPage(
        query,
        page: _currentPage,
      ),
      FilterContentType.all => await _repository.searchPage(
        query,
        page: _currentPage,
      ),
    };

    return _filterSearchPage(page);
  }

  TmdbPage<MovieItem> _filterSearchPage(TmdbPage<MovieItem> page) {
    final genreId = int.tryParse(_selection.genreId ?? '');
    final filtered = page.items.where((item) {
      if (_selection.ratingGte != null &&
          item.voteAverage < _selection.ratingGte!) {
        return false;
      }
      if (_selection.releaseYear != null &&
          int.tryParse(item.year) != _selection.releaseYear) {
        return false;
      }
      if (genreId != null && !item.genreIds.contains(genreId)) {
        return false;
      }
      return true;
    }).toList();

    return TmdbPage<MovieItem>(
      items: filtered,
      page: page.page,
      totalPages: page.totalPages,
      totalResults: filtered.length,
    );
  }

  Future<TmdbPage<MovieItem>> _browseByGenre(String label) async {
    if (label.trim().isEmpty || label == 'Genres') {
      return _combinedPage(
        await _repository.discoverMovieBrowsePage(page: _currentPage),
        await _repository.discoverSeriesBrowsePage(page: _currentPage),
      );
    }
    final movieOptions = await _repository.movieGenres();
    final tvOptions = await _repository.tvGenres();
    final movieMatches = movieOptions
        .where((option) => option.label == label)
        .toList();
    final tvMatches = tvOptions
        .where((option) => option.label == label)
        .toList();
    if (movieMatches.isEmpty && tvMatches.isEmpty) {
      return _emptyPage();
    }

    TmdbPage<MovieItem>? combined;
    if (_selection.type != FilterContentType.series) {
      for (final match in movieMatches) {
        final genreId = int.tryParse(match.id);
        if (genreId == null) continue;
        final page = await _repository.discoverMovieBrowsePage(
          genreId: genreId,
          country: _selection.countryCode,
          year: _selection.releaseYear,
          ratingGte: _selection.ratingGte,
          page: _currentPage,
        );
        combined = combined == null ? page : _combinedPage(combined, page);
      }
    }
    if (_selection.type != FilterContentType.movies) {
      for (final match in tvMatches) {
        final genreId = int.tryParse(match.id);
        if (genreId == null) continue;
        final page = await _repository.discoverSeriesBrowsePage(
          genreId: genreId,
          country: _selection.countryCode,
          year: _selection.releaseYear,
          ratingGte: _selection.ratingGte,
          page: _currentPage,
        );
        combined = combined == null ? page : _combinedPage(combined, page);
      }
    }
    return combined ?? _emptyPage();
  }

  Future<TmdbPage<MovieItem>> _browseByCountry(String label) async {
    if (label.trim().isEmpty || label == 'Countries') {
      return _combinedPage(
        await _repository.discoverMovieBrowsePage(page: _currentPage),
        await _repository.discoverSeriesBrowsePage(page: _currentPage),
      );
    }
    final options = await _repository.countries();
    final match = options.where((option) => option.label == label).toList();
    if (match.isEmpty) {
      return _emptyPage();
    }
    final code = match.first.id;
    final movies = await _repository.discoverMovieBrowsePage(
      country: code,
      page: _currentPage,
    );
    final series = await _repository.discoverSeriesBrowsePage(
      country: code,
      page: _currentPage,
    );
    return _combinedPage(movies, series);
  }

  Future<TmdbPage<MovieItem>> _browseByProduction(String label) async {
    if (label.trim().isEmpty || label == 'Production') {
      return _combinedPage(
        await _repository.discoverMovieBrowsePage(page: _currentPage),
        await _repository.discoverSeriesBrowsePage(page: _currentPage),
      );
    }
    final company = await _repository.companyFromQuery(label);
    if (company == null) {
      return _emptyPage();
    }

    final companyId = int.tryParse(company.id);
    if (companyId == null) {
      return _emptyPage();
    }

    final movies = await _repository.discoverMovieBrowsePage(
      companyId: companyId,
      page: _currentPage,
    );
    final series = await _repository.discoverSeriesBrowsePage(
      companyId: companyId,
      page: _currentPage,
    );
    return _combinedPage(movies, series);
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
      _itemsFuture = _load();
    });
  }

  Widget _buildRecentSearchesPanel() {
    if (_controller.text.trim().isNotEmpty) {
      return const SizedBox.shrink();
    }
    return FutureBuilder<List<RecentSearch>>(
      future: _recentSearchesFuture,
      builder: (context, snapshot) {
        final searches = snapshot.data ?? const <RecentSearch>[];
        if (searches.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(17, 12, 17, 0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Recent Searches',
                        style: AppTextStyles.small.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: _clearRecentSearches,
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final search in searches)
                        ActionChip(
                          label: Text(search.query),
                          avatar: const Icon(Icons.history, size: 16),
                          onPressed: () => _selectRecentSearch(search.query),
                          backgroundColor: AppColors.surfaceAlt,
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                          labelStyle: AppTextStyles.small,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveRecentSearch(String query) async {
    await _recentSearchDao.save(query);
    if (!mounted) return;
    setState(() {
      _recentSearchesFuture = _recentSearchDao.list();
    });
  }

  void _selectRecentSearch(String query) {
    _debounce?.cancel();
    _controller.text = query;
    _runSearch(query);
  }

  Future<void> _clearRecentSearches() async {
    await _recentSearchDao.clear();
    if (!mounted) return;
    setState(() {
      _recentSearchesFuture = _recentSearchDao.list();
    });
  }

  TmdbPage<MovieItem> _combinedPage(
    TmdbPage<MovieItem> first,
    TmdbPage<MovieItem> second,
  ) {
    final merged = <MovieItem>[];
    final maxLength = first.items.length > second.items.length
        ? first.items.length
        : second.items.length;
    for (var index = 0; index < maxLength; index += 1) {
      if (index < first.items.length) {
        merged.add(first.items[index]);
      }
      if (index < second.items.length) {
        merged.add(second.items[index]);
      }
    }

    return TmdbPage<MovieItem>(
      items: merged.take(20).toList(),
      page: _currentPage,
      totalPages: first.totalPages > second.totalPages
          ? first.totalPages
          : second.totalPages,
      totalResults: first.totalResults + second.totalResults,
    );
  }

  TmdbPage<MovieItem> _emptyPage() {
    return TmdbPage<MovieItem>(
      items: const [],
      page: _currentPage,
      totalPages: 1,
      totalResults: 0,
    );
  }
}
