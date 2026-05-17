import 'dart:ui';

import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../core/models/detail_item.dart';
import '../core/models/movie_item.dart';
import '../core/navigation/content_navigation.dart';
import 'buttons.dart';
import 'network_art.dart';
import 'poster_widgets.dart';

class DetailHero extends StatelessWidget {
  const DetailHero({
    required this.item,
    required this.onWatch,
    this.showBackground = true,
    super.key,
  });

  final MovieItem item;
  final VoidCallback onWatch;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 620,
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
              child: NetworkArt(url: item.posterUrl, width: 167, height: 250),
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
            top: 584,
            left: 32,
            right: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _DetailAction(
                  icon: Icons.video_camera_back_outlined,
                  label: 'Watch Trailer',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Trailer playback is not wired yet'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                  child: VerticalDivider(color: Colors.white54),
                ),
                const _DetailWatchlistAction(),
              ],
            ),
          ),
        ],
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

class _DetailWatchlistAction extends StatefulWidget {
  const _DetailWatchlistAction();

  @override
  State<_DetailWatchlistAction> createState() => _DetailWatchlistActionState();
}

class _DetailWatchlistActionState extends State<_DetailWatchlistAction> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return _DetailAction(
      icon: active ? Icons.bookmark : Icons.bookmark_border,
      iconColor: active ? AppColors.primary : null,
      label: active ? 'In Watchlist' : 'Add to Watchlist',
      onTap: () {
        setState(() => active = !active);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              active ? 'Added to watchlist' : 'Removed from watchlist',
            ),
          ),
        );
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
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 7),
            Text(label, style: AppTextStyles.medium.copyWith(fontSize: 14)),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Original Title', style: AppTextStyles.medium),
          const SizedBox(height: 16),
          Text(item.title, style: AppTextStyles.normal),
          const SizedBox(height: 34),
          Text('Description', style: AppTextStyles.medium),
          const SizedBox(height: 10),
          Text(item.description, style: AppTextStyles.normal),
          const SizedBox(height: 26),
          DetailInfoCarousel(items: info),
          if (includeRelated) ...[
            const SizedBox(height: 52),
            HorizontalPosterSection(
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
    return HorizontalPosterSection(
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
        ),
      ),
    );
  }

  void _handleInfoTap(BuildContext context, DetailInfo item) {
    final label = item.label.toLowerCase();
    if (label.contains('cast')) {
      final firstCast = item.value.split(',').first.trim();
      openCastDetail(context, firstCast);
      return;
    }
    if (label.contains('genre')) {
      openGenreBrowse(context, item.value);
      return;
    }
    if (label.contains('country')) {
      openCountryBrowse(context, item.value);
      return;
    }
    if (label.contains('production')) {
      openProductionBrowse(context, item.value);
      return;
    }
    openSearchResult(context, item.value);
  }
}

class _BlurInfoCard extends StatelessWidget {
  const _BlurInfoCard({
    required this.item,
    required this.wide,
    required this.onTap,
  });

  final DetailInfo item;
  final bool wide;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                Text(
                  item.value,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.normal.copyWith(
                    decoration: TextDecoration.underline,
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
