// ignore_for_file: use_null_aware_elements

import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../core/models/movie_item.dart';
import '../features/movies/widgets/movie_card.dart';
import '../features/movies/widgets/movie_grid.dart';
import '../features/movies/widgets/movie_horizontal_list.dart';

class MoviePosterCard extends StatelessWidget {
  const MoviePosterCard({
    required this.item,
    this.watchlisted,
    this.onTap,
    this.onWatchlistTap,
    this.onWatchlistChanged,
    super.key,
  });

  final MovieItem item;
  final bool? watchlisted;
  final VoidCallback? onTap;
  final VoidCallback? onWatchlistTap;
  final ValueChanged<bool>? onWatchlistChanged;

  @override
  Widget build(BuildContext context) {
    return MovieCard(
      item: item,
      watchlisted: watchlisted,
      onTap: onTap,
      onWatchlistTap: onWatchlistTap,
      onWatchlistChanged: onWatchlistChanged,
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.onMore,
    this.trailing,
    super.key,
  });

  final String title;
  final VoidCallback? onMore;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final moreButton = onMore == null
        ? null
        : IconButton(
            onPressed: onMore,
            icon: const Icon(Icons.chevron_right, size: 20),
            visualDensity: VisualDensity.compact,
          );

    return Row(
      children: [
        Text(title, style: AppTextStyles.sectionTitle(context)),
        const Spacer(),
        if (trailing != null) trailing!,
        if (moreButton != null) moreButton,
      ],
    );
  }
}

class HorizontalPosterSection extends StatelessWidget {
  const HorizontalPosterSection({
    required this.title,
    required this.items,
    this.itemCount,
    this.onMore,
    this.onItemTap,
    this.onWatchlistTap,
    this.isWatchlisted,
    this.onWatchlistChanged,
    super.key,
  });

  final String title;
  final List<MovieItem> items;
  final int? itemCount;
  final VoidCallback? onMore;
  final ValueChanged<MovieItem>? onItemTap;
  final ValueChanged<MovieItem>? onWatchlistTap;
  final bool Function(MovieItem item)? isWatchlisted;
  final void Function(MovieItem item, bool active)? onWatchlistChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SectionHeader(title: title, onMore: onMore),
        ),
        const SizedBox(height: 8),
        MovieHorizontalList(
          items: items,
          itemCount: itemCount,
          onItemTap: onItemTap,
          onWatchlistTap: onWatchlistTap,
          isWatchlisted: isWatchlisted,
          onWatchlistChanged: onWatchlistChanged,
        ),
      ],
    );
  }
}

class PosterGrid extends StatelessWidget {
  const PosterGrid({
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
    return MovieGrid(
      items: items,
      itemCount: itemCount,
      onItemTap: onItemTap,
      onWatchlistTap: onWatchlistTap,
      isWatchlisted: isWatchlisted,
      onWatchlistChanged: onWatchlistChanged,
    );
  }
}

class TogglePills extends StatelessWidget {
  const TogglePills({required this.active, required this.onChanged, super.key});

  final int active;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Pill(
          label: 'Movies',
          selected: active == 0,
          onTap: () => onChanged(0),
        ),
        const SizedBox(width: 13),
        _Pill(
          label: 'TV Series',
          selected: active == 1,
          onTap: () => onChanged(1),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(29),
      child: Container(
        width: 90,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(29),
          border: selected ? null : Border.all(color: Colors.white, width: 0.5),
          boxShadow: selected
              ? null
              : const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
        ),
        child: Text(
          label,
          style: AppTextStyles.tag.copyWith(
            color: selected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
