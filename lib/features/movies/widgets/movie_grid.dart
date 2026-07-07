import 'package:flutter/material.dart';

import '../../../core/models/movie_item.dart';
import 'movie_card.dart';

int getMovieGridColumns(double width) {
  if (width < 480) return 2;
  if (width < 700) return 3;
  if (width < 1000) return 4;
  if (width < 1300) return 5;
  if (width < 1600) return 6;
  return 7;
}

class MovieGrid extends StatelessWidget {
  const MovieGrid({
    required this.items,
    this.itemCount,
    this.onItemTap,
    this.onWatchlistTap,
    this.isWatchlisted,
    this.onWatchlistChanged,
    super.key,
  });

  final List<MovieItem> items;
  final int? itemCount;
  final ValueChanged<MovieItem>? onItemTap;
  final ValueChanged<MovieItem>? onWatchlistTap;
  final bool Function(MovieItem item)? isWatchlisted;
  final void Function(MovieItem item, bool active)? onWatchlistChanged;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final count = itemCount ?? items.length;
        return GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getMovieGridColumns(constraints.maxWidth),
            mainAxisSpacing: constraints.maxWidth < 600 ? 12 : 20,
            crossAxisSpacing: constraints.maxWidth < 600 ? 12 : 18,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (context, index) {
            final item = items[index % items.length];
            return MovieCard(
              item: item,
              watchlisted: isWatchlisted?.call(item),
              onTap: onItemTap == null ? null : () => onItemTap!(item),
              onWatchlistTap: onWatchlistTap == null
                  ? null
                  : () => onWatchlistTap!(item),
              onWatchlistChanged: onWatchlistChanged == null
                  ? null
                  : (active) => onWatchlistChanged!(item, active),
            );
          },
        );
      },
    );
  }
}
