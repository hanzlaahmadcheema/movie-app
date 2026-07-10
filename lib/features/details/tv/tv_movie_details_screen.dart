import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../app/app_routes.dart';
import '../../../app/app_theme.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/movie_item.dart';
import '../../../core/services/tmdb_repository.dart';
import '../../../core/trailer/trailer_picker.dart';
import '../../../widgets/state_views.dart';
import '../../../widgets/network_art.dart';
import '../../home/tv/tv_home_screen.dart'; // for TvContentRow if reusable, or we redefine TvCastRow

class TvMovieDetailsScreen extends StatefulWidget {
  const TvMovieDetailsScreen({this.item, super.key});
  final MovieItem? item;

  @override
  State<TvMovieDetailsScreen> createState() => _TvMovieDetailsScreenState();
}

class _TvMovieDetailsScreenState extends State<TvMovieDetailsScreen> {
  late Future<TmdbDetail?> tmdbDetail;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    tmdbDetail = _loadDetail();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<TmdbDetail?> _loadDetail() async {
    final item = widget.item;
    if (item == null || item.id == 0) return null;
    return TmdbRepository(config: AppConfig.fromEnv()).detail(item);
  }

  void _scrollToCenter(BuildContext context, [MovieItem? item]) {
    Scrollable.ensureVisible(
      context,
      alignment: 0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _openTrailer(BuildContext context, TmdbDetail detail) {
    final trailer = TrailerPicker.pick(detail.videos, title: detail.item.title);
    if (trailer == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Trailer unavailable')));
      return;
    }
    Navigator.pushNamed(context, AppRoutes.trailer, arguments: trailer.toRouteArguments());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item == null) {
      return const Scaffold(body: Center(child: Text('Invalid Movie')));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<TmdbDetail?>(
        future: tmdbDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return AppErrorView(
              title: 'Could not load details',
              message: 'Please try again later.',
              onRetry: () => setState(() => tmdbDetail = _loadDetail()),
            );
          }

          final detail = snapshot.data!;
          final item = detail.item;

          return ListView(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 60),
            children: [
              _buildHero(context, detail),
              const SizedBox(height: 40),
              if (detail.cast.isNotEmpty) _buildCastRow(detail),
              if (detail.related.isNotEmpty) _buildRecommendationsRow(detail),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHero(BuildContext context, TmdbDetail detail) {
    final item = detail.item;
    return SizedBox(
      height: 600,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'tv_poster_${item.id}',
            child: NetworkArt(
              url: item.backdropUrl.isNotEmpty ? item.backdropUrl : item.posterUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.transparent, Colors.black],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 60,
            right: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('${item.voteAverage.toStringAsFixed(1)} ★', style: const TextStyle(fontSize: 22, color: Colors.amber)),
                    const SizedBox(width: 16),
                    Text(item.releaseDate, style: const TextStyle(fontSize: 22, color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 800,
                  child: Text(
                    item.overview,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20, color: Colors.white70, height: 1.4),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    _TvButton(
                      title: 'Watch',
                      icon: Icons.play_arrow,
                      isPrimary: true,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.watchPathForItem(item),
                          arguments: item,
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    _TvButton(
                      title: 'Trailer',
                      icon: Icons.videocam,
                      onTap: () => _openTrailer(context, detail),
                    ),
                    const SizedBox(width: 16),
                    _TvButton(
                      title: 'Watchlist',
                      icon: Icons.add,
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    _TvButton(
                      title: 'Share',
                      icon: Icons.share,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCastRow(TmdbDetail detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 60, bottom: 16),
          child: Text('Cast', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 52),
            itemCount: detail.cast.length,
            itemBuilder: (context, index) {
              final cast = detail.cast[index];
              return _TvCastCard(cast: cast, onFocus: _scrollToCenter);
            },
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildRecommendationsRow(TmdbDetail detail) {
    return TvContentRow(
      title: 'More Like This',
      items: detail.related,
      onFocus: _scrollToCenter,
    );
  }
}

class _TvButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _TvButton({required this.title, required this.icon, this.isPrimary = false, required this.onTap});

  @override
  State<_TvButton> createState() => _TvButtonState();
}

class _TvButtonState extends State<_TvButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white : (widget.isPrimary ? AppColors.primary : Colors.white24),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)] : [],
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: _isFocused ? Colors.black : Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: TextStyle(
                  color: _isFocused ? Colors.black : Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TvCastCard extends StatefulWidget {
  final dynamic cast;
  final Function(BuildContext) onFocus;

  const _TvCastCard({required this.cast, required this.onFocus});

  @override
  State<_TvCastCard> createState() => _TvCastCardState();
}

class _TvCastCardState extends State<_TvCastCard> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (focused) widget.onFocus(context);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: _isFocused ? 150 : 130,
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withOpacity(0.6), blurRadius: 10, spreadRadius: 2)] : [],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: NetworkArt(
                  url: widget.cast.profilePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    widget.cast.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.cast.character,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
