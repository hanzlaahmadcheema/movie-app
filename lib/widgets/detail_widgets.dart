import 'dart:ui';

import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../core/models/detail_item.dart';
import '../core/models/movie_item.dart';
import '../core/navigation/content_navigation.dart';
import '../core/responsive/adaptive_container.dart';
import '../core/responsive/responsive_context.dart';
import '../core/services/local_image_cache_service.dart';
import 'buttons.dart';
import 'firebase_posters.dart';
import 'network_art.dart';

class DetailHero extends StatelessWidget {
  const DetailHero({
    required this.item,
    required this.onWatch,
    this.watchlisted = false,
    this.watched = false,
    this.onWatchlistChanged,
    this.onWatchedChanged,
    this.onTrailer,
    this.showBackground = true,
    super.key,
  });

  final MovieItem item;
  final VoidCallback onWatch;
  final bool watchlisted;
  final bool watched;
  final ValueChanged<bool>? onWatchlistChanged;
  final ValueChanged<bool>? onWatchedChanged;
  final VoidCallback? onTrailer;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return _DesktopDetailHero(
        item: item,
        onWatch: onWatch,
        watchlisted: watchlisted,
        watched: watched,
        onWatchlistChanged: onWatchlistChanged,
        onWatchedChanged: onWatchedChanged,
        onTrailer: onTrailer,
      );
    }
    return SizedBox(
      height: 665,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showBackground) ...[
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
              child: Opacity(
                opacity: 0.22,
                child: NetworkArt(
                  url: item.backdropUrl.isEmpty
                      ? item.posterUrl
                      : item.backdropUrl,
                  imageType: item.backdropUrl.isEmpty
                      ? LocalImageCacheService.imageTypePoster
                      : LocalImageCacheService.imageTypeBackdrop,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ],
          Positioned(
            top: 127,
            left: 0,
            right: 0,
            child: Center(
              child: NetworkArt(
                url: item.posterUrl,
                imageType: LocalImageCacheService.imageTypePoster,
                width: 167,
                height: 250,
              ),
            ),
          ),
          Positioned(
            top: 414,
            left: 16,
            right: 16,
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Positioned(
            top: 478,
            left: 20,
            right: 20,
            child: PrimaryButton(
              label: 'Watch Now',
              icon: Icons.play_arrow,
              height: 55,
              radius: 7,
              iconSize: 20,
              textStyle: AppTextStyles.medium.copyWith(
                color: Colors.black,
                fontSize: 16,
              ),
              onPressed: onWatch,
            ),
          ),
          Positioned(
            top: 575,
            left: 18,
            right: 18,
            child: Row(
              children: [
                Expanded(
                  child: _DetailAction(
                    icon: Icons.video_camera_back_outlined,
                    label: 'Trailer',
                    onTap: onTrailer,
                  ),
                ),
                Expanded(
                  child: _DetailAction(
                    icon: watched
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    iconColor: watched ? AppColors.primary : null,
                    label: watched ? 'Watched' : 'Watched?',
                    onTap: () => onWatchedChanged?.call(!watched),
                  ),
                ),
                Expanded(
                  child: _DetailWatchlistAction(
                    active: watchlisted,
                    onChanged: onWatchlistChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopDetailHero extends StatelessWidget {
  const _DesktopDetailHero({
    required this.item,
    required this.onWatch,
    required this.watchlisted,
    required this.watched,
    this.onWatchlistChanged,
    this.onWatchedChanged,
    this.onTrailer,
  });

  final MovieItem item;
  final VoidCallback onWatch;
  final bool watchlisted;
  final bool watched;
  final ValueChanged<bool>? onWatchlistChanged;
  final ValueChanged<bool>? onWatchedChanged;
  final VoidCallback? onTrailer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 570,
      child: AdaptiveContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 54),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 2 / 3,
                child: NetworkArt(
                  url: item.posterUrl,
                  imageType: LocalImageCacheService.imageTypePoster,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          TagChip(label: item.quality),
                          TagChip(label: item.year),
                          TagChip(label: item.type),
                          TagChip(label: 'IMDb ${item.rating}'),
                          TagChip(label: item.duration),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        item.title,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 46,
                          height: 1.08,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        item.description.isEmpty
                            ? 'No description is available for this title.'
                            : item.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.normal.copyWith(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: 160,
                            child: PrimaryButton(
                              label: 'Watch Now',
                              icon: Icons.play_arrow,
                              height: 50,
                              radius: AppRadius.pill,
                              onPressed: onWatch,
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: onTrailer,
                            icon: const Icon(Icons.video_camera_back_outlined),
                            label: const Text('Trailer'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () =>
                                onWatchlistChanged?.call(!watchlisted),
                            icon: Icon(
                              watchlisted
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                            ),
                            label: Text(
                              watchlisted ? 'In Watchlist' : 'Watchlist',
                            ),
                          ),
                          IconButton(
                            tooltip: watched
                                ? 'Remove watched status'
                                : 'Mark as watched',
                            onPressed: () => onWatchedChanged?.call(!watched),
                            icon: Icon(
                              watched
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              color: watched ? AppColors.primary : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailBackdrop extends StatelessWidget {
  const DetailBackdrop({required this.item, required this.child, super.key});

  final MovieItem item;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
            child: Opacity(
              opacity: 0.24,
              child: NetworkArt(
                url: item.backdropUrl.isEmpty
                    ? item.posterUrl
                    : item.backdropUrl,
                imageType: item.backdropUrl.isEmpty
                    ? LocalImageCacheService.imageTypePoster
                    : LocalImageCacheService.imageTypeBackdrop,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.background.withValues(alpha: 0.14),
                  AppColors.background,
                ],
                stops: const [0, 0.78, 1],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _DetailWatchlistAction extends StatelessWidget {
  const _DetailWatchlistAction({required this.active, this.onChanged});

  final bool active;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return _DetailAction(
      icon: active ? Icons.bookmark : Icons.bookmark_border,
      iconColor: active ? AppColors.primary : null,
      label: active ? 'Saved' : 'Watchlist',
      onTap: () {
        onChanged?.call(!active);
      },
    );
  }
}

class _DetailAction extends StatelessWidget {
  const _DetailAction({
    required this.icon,
    required this.label,
    this.iconColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.medium.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({
    required this.item,
    required this.info,
    required this.moreLikeThis,
    this.includeRelated = true,
    super.key,
  });

  final MovieItem item;
  final List<DetailInfo> info;
  final List<MovieItem> moreLikeThis;
  final bool includeRelated;

  @override
  Widget build(BuildContext context) {
    return AdaptiveContainer(
      maxWidth: 1100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Original Title', style: AppTextStyles.medium),
          const SizedBox(height: 16),
          Text(item.title, style: AppTextStyles.normal),
          const SizedBox(height: 34),
          Text('Description', style: AppTextStyles.medium),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Text(
              item.description,
              style: AppTextStyles.normal.copyWith(
                fontSize: context.isMobile ? 12 : 15,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 26),
          DetailInfoCarousel(items: info),
          if (includeRelated) ...[
            const SizedBox(height: 52),
            FirebaseHorizontalPosterSection(
              title: 'You may also like',
              items: moreLikeThis,
              onItemTap: (item) => openDetailForItem(context, item),
            ),
          ],
        ],
      ),
    );
  }
}

class RelatedPosterSection extends StatelessWidget {
  const RelatedPosterSection({required this.items, super.key});

  final List<MovieItem> items;

  @override
  Widget build(BuildContext context) {
    return FirebaseHorizontalPosterSection(
      title: 'You may also like',
      items: items,
      onItemTap: (item) => openDetailForItem(context, item),
    );
  }
}

class DetailInfoCarousel extends StatelessWidget {
  const DetailInfoCarousel({required this.items, super.key});

  final List<DetailInfo> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 153,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 22),
        itemBuilder: (context, index) => _BlurInfoCard(
          item: items[index],
          wide: index == 0 || index == items.length - 1,
          onTap: () => _handleInfoTap(context, items[index]),
          onSubItemTap: (subValue) =>
              _handleInfoTap(context, items[index], subValue),
        ),
      ),
    );
  }

  void _handleInfoTap(
    BuildContext context,
    DetailInfo item, [
    String? subValue,
  ]) {
    final label = item.label.toLowerCase();
    final valueToUse = subValue ?? item.value;

    if (label.contains('cast')) {
      final firstCast = valueToUse.split(',').first.trim();
      openCastDetail(context, firstCast);
      return;
    }
    if (label.contains('genre')) {
      openGenreBrowse(context, valueToUse.split(',').first.trim());
      return;
    }
    if (label.contains('country')) {
      openCountryBrowse(context, valueToUse.split(',').first.trim());
      return;
    }
    if (label.contains('production')) {
      openProductionBrowse(context, valueToUse.split(',').first.trim());
      return;
    }
    openSearchResult(context, valueToUse.split(',').first.trim());
  }
}

class _BlurInfoCard extends StatelessWidget {
  const _BlurInfoCard({
    required this.item,
    required this.wide,
    this.onTap,
    this.onSubItemTap,
  });

  final DetailInfo item;
  final bool wide;
  final VoidCallback? onTap;
  final void Function(String)? onSubItemTap;

  bool get _isClickable {
    final label = item.label.toLowerCase();
    return label.contains('cast') ||
        label.contains('genre') ||
        label.contains('country') ||
        label.contains('production');
  }

  @override
  Widget build(BuildContext context) {
    final clickable = _isClickable;
    return InkWell(
      onTap: clickable ? onTap : null,
      borderRadius: BorderRadius.circular(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(
            width: wide ? 240 : 186,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            color: Colors.black.withValues(alpha: 0.30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.label, style: AppTextStyles.medium),
                const SizedBox(height: 12),
                if (clickable && item.value.contains(','))
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: () {
                      final parts = item.value.split(',');
                      return parts.asMap().entries.map((entry) {
                        final isLast = entry.key == parts.length - 1;
                        final trimmed = entry.value.trim();
                        return GestureDetector(
                          onTap: () {
                            if (onSubItemTap != null) {
                              onSubItemTap!(trimmed);
                            }
                          },
                          child: Text(
                            trimmed + (isLast ? '' : ','),
                            style: AppTextStyles.normal.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        );
                      }).toList();
                    }(),
                  )
                else
                  Text(
                    item.value,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.normal.copyWith(
                      decoration: clickable
                          ? TextDecoration.underline
                          : TextDecoration.none,
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
