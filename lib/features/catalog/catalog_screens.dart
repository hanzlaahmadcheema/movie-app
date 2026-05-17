import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
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
  late Future<List<MovieItem>> catalogItems;
  FilterSelection? selection;

  @override
  void initState() {
    super.initState();
    catalogItems = _loadCatalogForSelection(null);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.kind == CatalogKind.movies ? 'Movies' : 'TV Series';

    return Scaffold(
      body: ListView(
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
              onApply: (value) {
                setState(() {
                  selection = value;
                  catalogItems = _loadCatalogForSelection(value);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 40, 5, 0),
            child: FutureBuilder<List<MovieItem>>(
              future: catalogItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: IconButton(
                      onPressed: () => setState(() {
                        catalogItems = _loadCatalogForSelection(selection);
                      }),
                      icon: const Icon(Icons.refresh, size: 28),
                    ),
                  );
                }

                return PosterGrid(items: snapshot.data!, itemCount: 10);
              },
            ),
          ),
          const SizedBox(height: 34),
          const FooterDetails(),
        ],
      ),
    );
  }

  Future<List<MovieItem>> _loadCatalogForSelection(
    FilterSelection? selection,
  ) async {
    final repository = TmdbRepository(config: AppConfig.fromEnv());
    final year = int.tryParse(selection?.releaseYear ?? '');

    if (widget.kind == CatalogKind.movies) {
      return repository.discoverMovieBrowse(
        genreId: int.tryParse(selection?.genreId ?? ''),
        country: selection?.countryCode,
        year: year,
        certification: selection?.rating,
      );
    }

    return repository.discoverSeriesBrowse(
      genreId: int.tryParse(selection?.genreId ?? ''),
      country: selection?.countryCode,
      year: year,
      certification: selection?.rating,
    );
  }
}
