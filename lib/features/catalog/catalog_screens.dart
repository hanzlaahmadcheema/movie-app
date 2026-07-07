import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
import '../../core/models/movie_item.dart';
import '../../core/models/tmdb_page.dart';
import '../../core/responsive/adaptive_container.dart';
import '../../core/services/tmdb_repository.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/firebase_posters.dart';
import '../../widgets/filter_widgets.dart';
import '../../widgets/pagination.dart';
import '../../widgets/state_views.dart';

enum CatalogKind { movies, series }

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({required this.kind, super.key});

  final CatalogKind kind;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late Future<TmdbPage<MovieItem>> catalogItems;
  FilterSelection? selection;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    catalogItems = _loadCatalogForSelection(null);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.kind == CatalogKind.movies ? 'Movies' : 'TV Series';

    return AppShell(
      body: AdaptiveContainer(
        padding: EdgeInsets.zero,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const MovieAppBar(dark: true),
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 43, 17, 0),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(17, 26, 17, 0),
              child: FilterPanel(
                initialSelection: _selectionForPanel,
                allowedTypes: [
                  widget.kind == CatalogKind.movies
                      ? FilterContentType.movies
                      : FilterContentType.series,
                ],
                onApply: (value) {
                  final locked = _lockSelection(value);
                  setState(() {
                    selection = locked;
                    currentPage = 1;
                    catalogItems = _loadCatalogForSelection(locked);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 40, 5, 0),
              child: FutureBuilder<TmdbPage<MovieItem>>(
                future: catalogItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (snapshot.hasError) {
                    return AppErrorView(
                      title: 'Could not load $title',
                      message: userMessageForError(snapshot.error),
                      onRetry: () => setState(() {
                        catalogItems = _loadCatalogForSelection(selection);
                      }),
                    );
                  }
                  final page = snapshot.data;
                  final items =
                      page?.items.take(20).toList() ?? const <MovieItem>[];
                  if (page == null || items.isEmpty) {
                    return AppEmptyState(
                      title: 'No results',
                      message: selection?.hasActiveFilters == true
                          ? 'No titles match these filters.'
                          : 'No catalog titles are available right now.',
                      icon: Icons.movie_filter_outlined,
                      actionLabel: 'Reset Filters',
                      onAction: () => setState(() {
                        selection = null;
                        currentPage = 1;
                        catalogItems = _loadCatalogForSelection(null);
                      }),
                    );
                  }

                  return Column(
                    children: [
                      FirebasePosterGrid(items: items, itemCount: items.length),
                      if (page.hasMultiplePages) ...[
                        const SizedBox(height: 28),
                        PaginationBar(
                          currentPage: currentPage,
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
      ),
    );
  }

  Future<TmdbPage<MovieItem>> _loadCatalogForSelection(
    FilterSelection? selection,
  ) async {
    final repository = TmdbRepository(config: AppConfig.fromEnv());
    final activeSelection = selection == null
        ? null
        : _lockSelection(selection);

    if (widget.kind == CatalogKind.movies) {
      return repository.discoverMovieBrowsePage(
        genreId: int.tryParse(activeSelection?.genreId ?? ''),
        country: activeSelection?.countryCode,
        year: activeSelection?.releaseYear,
        ratingGte: activeSelection?.ratingGte,
        page: currentPage,
      );
    }

    return repository.discoverSeriesBrowsePage(
      genreId: int.tryParse(activeSelection?.genreId ?? ''),
      country: activeSelection?.countryCode,
      year: activeSelection?.releaseYear,
      ratingGte: activeSelection?.ratingGte,
      page: currentPage,
    );
  }

  FilterSelection get _selectionForPanel {
    return _lockSelection(selection ?? const FilterSelection());
  }

  FilterSelection _lockSelection(FilterSelection value) {
    return value.lockedTo(
      widget.kind == CatalogKind.movies
          ? FilterContentType.movies
          : FilterContentType.series,
    );
  }

  void _goToPage(int page) {
    setState(() {
      currentPage = page;
      catalogItems = _loadCatalogForSelection(selection);
    });
  }
}
