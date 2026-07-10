import 'dart:async';
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../core/config/app_config.dart';
import '../../../core/local_db/recent_search_dao.dart';
import '../../../core/models/movie_item.dart';
import '../../../core/models/tmdb_page.dart';
import '../../../core/services/tmdb_repository.dart';
import '../../../widgets/state_views.dart';
import '../../../app/app_routes.dart';
import '../search_screens.dart';
import '../../../widgets/network_art.dart';
import '../../home/tv/tv_home_screen.dart'; // TvContentRow

class TvSearchScreen extends StatefulWidget {
  const TvSearchScreen({
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
  State<TvSearchScreen> createState() => _TvSearchScreenState();
}

class _TvSearchScreenState extends State<TvSearchScreen> {
  final _repository = TmdbRepository(config: AppConfig.fromEnv());
  final _controller = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final FocusNode _resultsFocus = FocusNode();

  Timer? _debounce;
  Future<TmdbPage<MovieItem>>? _itemsFuture;
  Future<List<RecentSearch>>? _recentSearchesFuture;
  Future<List<MovieItem>>? _trendingFuture;

  late final RecentSearchDao _recentSearchDao;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _recentSearchDao = widget.recentSearchDao ?? RecentSearchDao();
    _currentQuery = widget.mode == ExploreMode.search ? (widget.query ?? '') : (widget.query ?? widget.title);
    _controller.text = widget.mode == ExploreMode.search ? _currentQuery : '';
    
    if (widget.mode == ExploreMode.search) {
      _recentSearchesFuture = _recentSearchDao.list();
      _trendingFuture = _repository.trendingMovies();
    }
    _itemsFuture = _load();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _searchFocus.dispose();
    _resultsFocus.dispose();
    super.dispose();
  }

  Future<TmdbPage<MovieItem>> _load() async {
    if (_currentQuery.isEmpty && widget.mode == ExploreMode.search) {
      return const TmdbPage(page: 1, totalPages: 1, totalResults: 0, items: []);
    }
    if (widget.mode == ExploreMode.genre) {
      // Basic genre routing, not full filters for now
      return const TmdbPage(page: 1, totalPages: 1, totalResults: 0, items: []);
    }
    return _repository.searchPage(_currentQuery);
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted && _currentQuery != value) {
        setState(() {
          _currentQuery = value;
          _itemsFuture = _load();
        });
        if (value.isNotEmpty && widget.mode == ExploreMode.search) {
          _recentSearchDao.save(value);
        }
      }
    });
  }

  void _onSearchSubmitted(String value) {
    _onSearchChanged(value);
    _resultsFocus.requestFocus();
  }

  void _scrollToCenter(BuildContext context) {
    Scrollable.ensureVisible(
      context,
      alignment: 0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.mode == ExploreMode.search)
              _buildSearchBar()
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            Expanded(
              child: _currentQuery.isEmpty && widget.mode == ExploreMode.search
                  ? _buildEmptySearchState()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Focus(
        focusNode: _searchFocus,
        child: TextField(
          controller: _controller,
          autofocus: true,
          style: const TextStyle(fontSize: 24, color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search movies, series...',
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: const Icon(Icons.search, color: Colors.white, size: 32),
            filled: true,
            fillColor: Colors.white12,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          onChanged: _onSearchChanged,
          onSubmitted: _onSearchSubmitted,
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return ListView(
      children: [
        FutureBuilder<List<RecentSearch>>(
          future: _recentSearchesFuture,
          builder: (context, snapshot) {
            final recents = snapshot.data ?? [];
            if (recents.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recent Searches', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: recents.map((r) {
                    return _TvSearchChip(
                      label: r.query,
                      onTap: () {
                        _controller.text = r.query;
                        _onSearchSubmitted(r.query);
                      },
                      onFocus: _scrollToCenter,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
        FutureBuilder<List<MovieItem>>(
          future: _trendingFuture,
          builder: (context, snapshot) {
            final items = snapshot.data ?? [];
            if (items.isEmpty) return const SizedBox.shrink();
            return TvContentRow(
              title: 'Trending',
              items: items,
              onFocus: (context, _) => _scrollToCenter(context),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Focus(
      focusNode: _resultsFocus,
      child: FutureBuilder<TmdbPage<MovieItem>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const AppErrorView(title: 'Error', message: 'Could not load search results.');
          }
          final results = snapshot.data?.items ?? [];
          if (results.isEmpty) {
            return const AppEmptyState(
              title: 'No results found',
              message: 'Try a different search term.',
              icon: Icons.search_off,
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return _TvGridPoster(item: item, onFocus: _scrollToCenter);
            },
          );
        },
      ),
    );
  }
}

class _TvSearchChip extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Function(BuildContext) onFocus;

  const _TvSearchChip({required this.label, required this.onTap, required this.onFocus});

  @override
  State<_TvSearchChip> createState() => _TvSearchChipState();
}

class _TvSearchChipState extends State<_TvSearchChip> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (focused) widget.onFocus(context);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white : Colors.white12,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isFocused ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _TvGridPoster extends StatefulWidget {
  final MovieItem item;
  final Function(BuildContext) onFocus;

  const _TvGridPoster({required this.item, required this.onFocus});

  @override
  State<_TvGridPoster> createState() => _TvGridPosterState();
}

class _TvGridPosterState extends State<_TvGridPoster> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (focused) widget.onFocus(context);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.detailPathForItem(widget.item), arguments: widget.item);
        },
        child: AnimatedScale(
          scale: _isFocused ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isFocused ? Colors.white : Colors.transparent,
                width: 4,
              ),
              boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)] : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(tag: 'tv_search_${widget.item.id}', child: NetworkArt(url: widget.item.posterUrl)),
            ),
          ),
        ),
      ),
    );
  }
}
