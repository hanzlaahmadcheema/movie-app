import 'package:flutter/material.dart';

import '../../core/data/mock_data.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/filter_widgets.dart';
import '../../widgets/poster_widgets.dart';

enum CatalogKind { movies, series }

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({required this.kind, super.key});

  final CatalogKind kind;

  @override
  Widget build(BuildContext context) {
    final title = kind == CatalogKind.movies ? 'Movies' : 'TV Series';
    final items = kind == CatalogKind.movies ? movies : series;

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
            child: PosterGrid(items: items, itemCount: 8),
          ),
          const SizedBox(height: 34),
          const FooterDetails(),
        ],
      ),
    );
  }
}
