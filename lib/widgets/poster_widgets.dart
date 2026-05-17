// ignore_for_file: use_null_aware_elements

import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../core/navigation/content_navigation.dart';
import '../core/models/movie_item.dart';
import 'buttons.dart';
import 'network_art.dart';

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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => openDetailForItem(context, item),
        borderRadius: BorderRadius.circular(2),
        child: AspectRatio(
          aspectRatio: 195 / 293,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Stack(
              fit: StackFit.expand,
              children: [
                NetworkArt(url: item.posterUrl),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0x991E1E1E)],
                      stops: [0.65, 1],
                    ),
                  ),
                ),
                Positioned(
                  top: 7,
                  left: 6,
                  child: Text(
                    item.quality,
                    style: AppTextStyles.medium.copyWith(color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: WatchlistButton(
                    active: watchlisted,
                    onChanged: onWatchlistChanged,
                    onTap: onWatchlistTap,
                  ),
                ),
                Positioned(
                  left: 8,
                  right: 8,
                  bottom: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TagChip(label: item.type),
                          const SizedBox(width: 5),
                          TagChip(label: item.year),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.medium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
        Text(title, style: Theme.of(context).textTheme.titleLarge),
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
    this.onMore,
    this.onItemTap,
    this.onWatchlistTap,
    this.isWatchlisted,
    this.onWatchlistChanged,
    super.key,
  });

  final String title;
  final List<MovieItem> items;
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
        SizedBox(
          height: 293,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 6),
            itemBuilder: (context, index) => SizedBox(
              width: 195,
              child: MoviePosterCard(
                item: items[index],
                watchlisted: isWatchlisted?.call(items[index]),
                onTap: onItemTap == null
                    ? null
                    : () => onItemTap!(items[index]),
                onWatchlistTap: onWatchlistTap == null
                    ? null
                    : () => onWatchlistTap!(items[index]),
                onWatchlistChanged: onWatchlistChanged == null
                    ? null
                    : (active) => onWatchlistChanged!(items[index], active),
              ),
            ),
          ),
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
    final count = itemCount ?? items.length;
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 195 / 293,
      ),
      itemBuilder: (context, index) => MoviePosterCard(
        item: items[index % items.length],
        watchlisted: isWatchlisted?.call(items[index % items.length]),
        onTap: onItemTap == null
            ? null
            : () => onItemTap!(items[index % items.length]),
        onWatchlistTap: onWatchlistTap == null
            ? null
            : () => onWatchlistTap!(items[index % items.length]),
        onWatchlistChanged: onWatchlistChanged == null
            ? null
            : (active) =>
                  onWatchlistChanged!(items[index % items.length], active),
      ),
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
