import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
import '../../core/data/mock_data.dart';
import '../../core/models/movie_item.dart';
import '../../core/services/tmdb_repository.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/filter_widgets.dart';
import '../../widgets/poster_widgets.dart';

enum CatalogKind { movies, series }

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({required this.kind, super.key});

  final CatalogKind kind;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late final Future<List<MovieItem>> catalogItems = _loadCatalog();

  @override
  Widget build(BuildContext context) {
    final title = widget.kind == CatalogKind.movies ? 'Movies' : 'TV Series';
    final fallbackItems = widget.kind == CatalogKind.movies ? movies : series;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const MovieAppBar(dark: true),
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 43, 17, 0),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(17, 26, 17, 0),
            child: FilterPanel(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 40, 5, 0),
            child: FutureBuilder<List<MovieItem>>(
              future: catalogItems,
              initialData: fallbackItems,
              builder: (context, snapshot) {
                final items = snapshot.data?.isNotEmpty == true
                    ? snapshot.data!
                    : fallbackItems;

                return PosterGrid(items: items, itemCount: 8);
              },
            ),
          ),
          const SizedBox(height: 34),
          const FooterDetails(),
        ],
      ),
    );
  }

  Future<List<MovieItem>> _loadCatalog() async {
    try {
      final repository = TmdbRepository(config: AppConfig.fromEnv());
      return widget.kind == CatalogKind.movies
          ? repository.discoverMovies()
          : repository.discoverSeries();
    } catch (_) {
      return widget.kind == CatalogKind.movies ? movies : series;
    }
  }
}
