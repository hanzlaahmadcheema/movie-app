import 'package:flutter/material.dart';

import '../../../app/app_routes.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/movie_item.dart';
import '../../../core/models/tmdb_page.dart';
import '../../../core/services/tmdb_repository.dart';
import '../../../widgets/firebase_posters.dart';
import '../../../widgets/filter_widgets.dart';
import '../../../widgets/state_views.dart';
import '../catalog_screens.dart';

class TvCatalogScreen extends StatefulWidget {
  const TvCatalogScreen({required this.kind, super.key});

  final CatalogKind kind;

  @override
  State<TvCatalogScreen> createState() => _TvCatalogScreenState();
}

class _TvCatalogScreenState extends State<TvCatalogScreen> {
  final _repository = TmdbRepository(config: AppConfig.fromEnv());
  late Future<TmdbPage<MovieItem>> _catalogItems;
  FilterSelection? _selection;
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  final List<MovieItem> _items = [];
  bool _isLoadingMore = false;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    _catalogItems = _loadCatalogForSelection(null);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<TmdbPage<MovieItem>> _loadCatalogForSelection(FilterSelection? sel) {
    _selection = sel;
    _currentPage = 1;
    _items.clear();
    return _repository.discover(
      page: _currentPage,
      selection: sel,
      mediaType: widget.kind == CatalogKind.movies ? MediaType.movie : MediaType.tv,
    ).then((page) {
      if (mounted) {
        setState(() {
          _items.addAll(page.results);
          _totalPages = page.totalPages;
        });
      }
      return page;
    });
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || _currentPage >= _totalPages) return;
    setState(() => _isLoadingMore = true);

    _currentPage++;
    try {
      final page = await _repository.discover(
        page: _currentPage,
        selection: _selection,
        mediaType: widget.kind == CatalogKind.movies ? MediaType.movie : MediaType.tv,
      );
      if (mounted) {
        setState(() {
          _items.addAll(page.results);
          _totalPages = page.totalPages;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
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
    final title = widget.kind == CatalogKind.movies ? 'Movies' : 'TV Series';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: FilterPanel(
                initialSelection: _selection ?? const FilterSelection(),
                allowedTypes: [
                  widget.kind == CatalogKind.movies ? FilterContentType.movies : FilterContentType.series,
                ],
                onApply: (newSelection) {
                  setState(() {
                    _catalogItems = _loadCatalogForSelection(newSelection);
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: FutureBuilder<TmdbPage<MovieItem>>(
                future: _catalogItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && _items.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError && _items.isEmpty) {
                    return const AppErrorView(title: 'Error', message: 'Could not load items.');
                  }
                  if (_items.isEmpty) {
                    return const AppEmptyState(
                      title: 'No results found',
                      message: 'Try adjusting your filters.',
                      icon: Icons.movie_filter,
                    );
                  }

                  return GridView.builder(
                    controller: _scrollController,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _items.length + (_currentPage < _totalPages ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _items.length) {
                        return Focus(
                          onFocusChange: (focused) {
                            if (focused) _loadMore();
                          },
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      }
                      final item = _items[index];
                      return _TvGridPoster(item: item, onFocus: _scrollToCenter);
                    },
                  );
                },
              ),
            ),
          ],
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
              boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)] : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FirebasePoster(item: widget.item, heroTag: 'tv_catalog_${widget.item.id}'),
            ),
          ),
        ),
      ),
    );
  }
}
