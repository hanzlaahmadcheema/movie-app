import 'package:flutter/material.dart';

import '../../../core/models/movie_item.dart';
import '../../../core/responsive/responsive_context.dart';
import 'movie_card.dart';

class MovieHorizontalList extends StatefulWidget {
  const MovieHorizontalList({
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
  State<MovieHorizontalList> createState() => _MovieHorizontalListState();
}

class _MovieHorizontalListState extends State<MovieHorizontalList> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    final width = context.isMobile ? 150.0 : (context.isTablet ? 178.0 : 205.0);
    return SizedBox(
      height: width * 1.5,
      child: Stack(
        children: [
          ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.itemCount ?? widget.items.length,
            separatorBuilder: (_, _) =>
                SizedBox(width: context.isMobile ? 10 : 16),
            itemBuilder: (context, index) {
              final item = widget.items[index % widget.items.length];
              return SizedBox(
                width: width,
                child: MovieCard(
                  item: item,
                  watchlisted: widget.isWatchlisted?.call(item),
                  onTap: widget.onItemTap == null
                      ? null
                      : () => widget.onItemTap!(item),
                  onWatchlistTap: widget.onWatchlistTap == null
                      ? null
                      : () => widget.onWatchlistTap!(item),
                  onWatchlistChanged: widget.onWatchlistChanged == null
                      ? null
                      : (active) => widget.onWatchlistChanged!(item, active),
                ),
              );
            },
          ),
          if (context.isDesktop) ...[
            _ScrollArrow(
              alignment: Alignment.centerLeft,
              icon: Icons.chevron_left,
              onPressed: () => _scrollBy(-720),
            ),
            _ScrollArrow(
              alignment: Alignment.centerRight,
              icon: Icons.chevron_right,
              onPressed: () => _scrollBy(720),
            ),
          ],
        ],
      ),
    );
  }

  void _scrollBy(double offset) {
    if (!_scrollController.hasClients) return;
    final target = (_scrollController.offset + offset).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }
}

class _ScrollArrow extends StatelessWidget {
  const _ScrollArrow({
    required this.alignment,
    required this.icon,
    required this.onPressed,
  });

  final Alignment alignment;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: IconButton.filled(
          onPressed: onPressed,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withValues(alpha: 0.72),
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
