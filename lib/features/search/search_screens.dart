import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
import '../../core/models/movie_item.dart';
import '../../core/models/tmdb_option.dart';
import '../../core/models/tmdb_page.dart';
import '../../core/services/tmdb_repository.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/pagination.dart';
import '../../widgets/poster_widgets.dart';

enum ExploreMode { search, genre, country, production }

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    required this.title,
    this.mode = ExploreMode.search,
    this.query,
    super.key,
  });

  final String title;
  final ExploreMode mode;
  final String? query;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final _repository = TmdbRepository(config: AppConfig.fromEnv());
  final _controller = TextEditingController();
  Timer? _debounce;

  Future<TmdbPage<MovieItem>>? _itemsFuture;
  String _currentQuery = '';
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _currentQuery = widget.mode == ExploreMode.search
        ? (widget.query ?? '')
        : (widget.query ?? widget.title);
    _controller.text = widget.mode == ExploreMode.search ? _currentQuery : '';
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

    return Scaffold(
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
              child: TextField(
                controller: _controller,
                onChanged: _scheduleSearch,
                onSubmitted: (value) => _runSearch(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search movies, shows, and people',
                ),
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
                  return Center(
                    child: IconButton(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh, size: 28),
                    ),
                  );
                }

                final page = snapshot.data;
                final items =
                    page?.items.take(20).toList() ?? const <MovieItem>[];
                if (items.isEmpty) {
                  return Center(
                    child: IconButton(
                      onPressed: _reload,
                      icon: const Icon(Icons.search_off, size: 28),
                    ),
                  );
                }

                return Column(
                  children: [
                    PosterGrid(items: items, itemCount: items.length),
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
          const SizedBox(height: 34),
          const FooterDetails(),
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
    setState(() {
      _currentQuery = value.trim();
      _currentPage = 1;
      _itemsFuture = _load();
    });
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
        return _repository.searchPage(query, page: _currentPage);
      case ExploreMode.genre:
        return _browseByGenre(query.isEmpty ? widget.title : query);
      case ExploreMode.country:
        return _browseByCountry(query.isEmpty ? widget.title : query);
      case ExploreMode.production:
        return _browseByProduction(query.isEmpty ? widget.title : query);
    }
  }

  Future<TmdbPage<MovieItem>> _browseByGenre(String label) async {
    if (label.trim().isEmpty || label == 'Genres') {
      return _combinedPage(
        await _repository.discoverMovieBrowsePage(page: _currentPage),
        await _repository.discoverSeriesBrowsePage(page: _currentPage),
      );
    }
    final options = <TmdbOption>[
      ...await _repository.movieGenres(),
      ...await _repository.tvGenres(),
    ];
    final matches = options.where((option) => option.label == label).toList();
    if (matches.isEmpty) {
      return _emptyPage();
    }

    TmdbPage<MovieItem>? combined;
    for (final match in matches) {
      final genreId = int.tryParse(match.id);
      if (genreId == null) continue;
      final movies = await _repository.discoverMovieBrowsePage(
        genreId: genreId,
        page: _currentPage,
      );
      final series = await _repository.discoverSeriesBrowsePage(
        genreId: genreId,
        page: _currentPage,
      );
      final page = _combinedPage(movies, series);
      combined = combined == null ? page : _combinedPage(combined, page);
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
