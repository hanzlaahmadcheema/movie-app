import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
import '../../core/data/mock_data.dart';
import '../../core/models/movie_item.dart';
import '../../core/services/tmdb_repository.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/poster_widgets.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({required this.title, super.key});

  final String title;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late final Future<List<MovieItem>> searchItems = _loadSearch();

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 46, 5, 0),
            child: FutureBuilder<List<MovieItem>>(
              future: searchItems,
              initialData: series,
              builder: (context, snapshot) {
                final items = snapshot.data?.isNotEmpty == true
                    ? snapshot.data!
                    : series;

                return PosterGrid(items: items, itemCount: 8);
              },
            ),
          ),
          const SizedBox(height: 30),
          const _Pagination(),
          const SizedBox(height: 34),
          const FooterDetails(),
        ],
      ),
    );
  }

  Future<List<MovieItem>> _loadSearch() async {
    try {
      return TmdbRepository(config: AppConfig.fromEnv()).search(widget.title);
    } catch (_) {
      return series;
    }
  }
}

class _Pagination extends StatelessWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Container(
          width: index == 2 ? 40 : 34,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: index == 2
                ? const Color(0xFF0FEFFD)
                : const Color(0xFF242426),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(color: index == 2 ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}
