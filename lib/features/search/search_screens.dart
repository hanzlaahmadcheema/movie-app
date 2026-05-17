import 'package:flutter/material.dart';

import '../../core/data/mock_data.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/poster_widgets.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const MovieAppBar(dark: true),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 56, 5, 0),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 46, 5, 0),
            child: PosterGrid(items: series, itemCount: 8),
          ),
          const SizedBox(height: 30),
          const _Pagination(),
          const SizedBox(height: 34),
          const FooterDetails(),
        ],
      ),
    );
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
