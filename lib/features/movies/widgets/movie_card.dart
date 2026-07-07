import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../core/models/movie_item.dart';
import '../../../core/navigation/content_navigation.dart';
import '../../../core/responsive/responsive_context.dart';
import '../../../core/services/local_image_cache_service.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/network_art.dart';

enum MovieCardVariant { poster, landscape, compact, continueWatching }

class MovieCard extends StatefulWidget {
  const MovieCard({
    required this.item,
    this.variant = MovieCardVariant.poster,
    this.watchlisted,
    this.progress,
    this.onTap,
    this.onWatchlistTap,
    this.onWatchlistChanged,
    super.key,
  });

  final MovieItem item;
  final MovieCardVariant variant;
  final bool? watchlisted;
  final double? progress;
  final VoidCallback? onTap;
  final VoidCallback? onWatchlistTap;
  final ValueChanged<bool>? onWatchlistChanged;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final landscape =
        widget.variant == MovieCardVariant.landscape ||
        widget.variant == MovieCardVariant.continueWatching;
    final enableHover = context.isDesktop;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: enableHover ? (_) => setState(() => _hovered = true) : null,
      onExit: enableHover ? (_) => setState(() => _hovered = false) : null,
      child: AnimatedScale(
        scale: enableHover && _hovered ? 1.025 : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap:
                widget.onTap ?? () => openDetailForItem(context, widget.item),
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  NetworkArt(
                    url: landscape
                        ? (widget.item.backdropUrl.isEmpty
                              ? widget.item.posterUrl
                              : widget.item.backdropUrl)
                        : widget.item.posterUrl,
                    imageType: landscape && widget.item.backdropUrl.isNotEmpty
                        ? LocalImageCacheService.imageTypeBackdrop
                        : LocalImageCacheService.imageTypePoster,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xE6121315)],
                        stops: [0.48, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        child: Text(
                          widget.item.quality,
                          style: AppTextStyles.tag.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!landscape)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: WatchlistButton(
                        active: widget.watchlisted,
                        onChanged: widget.onWatchlistChanged,
                        onTap: widget.onWatchlistTap,
                        showFeedback: widget.onWatchlistChanged == null,
                      ),
                    ),
                  if (enableHover)
                    IgnorePointer(
                      child: AnimatedOpacity(
                        opacity: _hovered ? 1 : 0,
                        duration: const Duration(milliseconds: 160),
                        child: ColoredBox(
                          color: Colors.black.withValues(alpha: 0.28),
                          child: const Center(
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.primary,
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.black,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: widget.progress == null ? 10 : 19,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.title,
                          maxLines: landscape ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.medium.copyWith(
                            color: Colors.white,
                            fontSize: context.isMobile ? 13 : 15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${widget.item.year}  •  ${widget.item.type}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.small.copyWith(
                            color: Colors.white70,
                            fontSize: context.isMobile ? 10 : 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.progress != null)
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: LinearProgressIndicator(
                          value: widget.progress!.clamp(0, 1),
                          minHeight: 4,
                          backgroundColor: Colors.white24,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
