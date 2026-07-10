import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../app/app_routes.dart';
import '../../../app/app_theme.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/movie_item.dart';
import '../../../core/models/detail_item.dart';
import '../../../core/models/tmdb_season.dart';
import '../../../core/services/tmdb_repository.dart';
import '../../../core/trailer/trailer_picker.dart';
import '../../../widgets/state_views.dart';
import '../../../widgets/network_art.dart';
import '../../home/tv/tv_home_screen.dart'; // For TvContentRow

class TvSeriesDetailsScreen extends StatefulWidget {
  const TvSeriesDetailsScreen({this.item, super.key});
  final MovieItem? item;

  @override
  State<TvSeriesDetailsScreen> createState() => _TvSeriesDetailsScreenState();
}

class _TvSeriesDetailsScreenState extends State<TvSeriesDetailsScreen> {
  late Future<TmdbDetail?> tmdbDetail;
  late ScrollController _scrollController;
  TmdbSeason? _selectedSeason;

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
    final detail = await TmdbRepository(config: AppConfig.fromEnv()).detail(item);
    if (detail.seasons.isNotEmpty && mounted) {
      setState(() => _selectedSeason = detail.seasons.first);
    }
    return detail;
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
      return const Scaffold(body: Center(child: Text('Invalid Series')));
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
          return ListView(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 60),
            children: [
              _buildHero(context, detail),
              const SizedBox(height: 40),
              if (detail.seasons.isNotEmpty) _buildSeasonSelector(detail),
              if (_selectedSeason != null) _buildEpisodeList(detail, _selectedSeason!),
              const SizedBox(height: 40),
              if (detail.related.isNotEmpty)
                TvContentRow(title: 'More Like This', items: detail.related, onFocus: _scrollToCenter),
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
                    const SizedBox(width: 16),
                    Text('${detail.seasons.length} Seasons', style: const TextStyle(fontSize: 22, color: Colors.white70)),
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
                      title: 'Watch Latest',
                      icon: Icons.play_arrow,
                      isPrimary: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.watchPathForItem(item), arguments: item);
                      },
                    ),
                    const SizedBox(width: 16),
                    _TvButton(title: 'Trailer', icon: Icons.videocam, onTap: () => _openTrailer(context, detail)),
                    const SizedBox(width: 16),
                    _TvButton(title: 'Watchlist', icon: Icons.add, onTap: () {}),
                    const SizedBox(width: 16),
                    _TvButton(title: 'Share', icon: Icons.share, onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonSelector(TmdbDetail detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 60, bottom: 16),
          child: Text('Seasons', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 52),
            itemCount: detail.seasons.length,
            itemBuilder: (context, index) {
              final season = detail.seasons[index];
              final isSelected = _selectedSeason == season;
              return _TvSeasonTab(
                season: season,
                isSelected: isSelected,
                onSelect: () => setState(() => _selectedSeason = season),
                onFocus: _scrollToCenter,
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildEpisodeList(TmdbDetail detail, TmdbSeason season) {
    return FutureBuilder<List<Episode>>(
      future: TmdbRepository(config: AppConfig.fromEnv()).tvSeasonEpisodes(
        tvId: detail.item.id,
        seasonNumber: season.number,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 300, child: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox(height: 300, child: Center(child: Text('No episodes found.')));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 60, bottom: 16),
              child: Text(season.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            SizedBox(
              height: 350,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 52),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final episode = snapshot.data![index];
                  return _TvEpisodeCard(
                    episode: episode,
                    seasonNumber: season.number,
                    item: detail.item,
                    onFocus: _scrollToCenter,
                  );
                },
              ),
            ),
          ],
        );
      },
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

class _TvSeasonTab extends StatefulWidget {
  final TmdbSeason season;
  final bool isSelected;
  final VoidCallback onSelect;
  final Function(BuildContext) onFocus;

  const _TvSeasonTab({required this.season, required this.isSelected, required this.onSelect, required this.onFocus});

  @override
  State<_TvSeasonTab> createState() => _TvSeasonTabState();
}

class _TvSeasonTabState extends State<_TvSeasonTab> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (focused) widget.onFocus(context);
      },
      child: GestureDetector(
        onTap: widget.onSelect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white : (widget.isSelected ? Colors.white24 : Colors.transparent),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: _isFocused ? Colors.white : (widget.isSelected ? Colors.white54 : Colors.transparent)),
          ),
          child: Center(
            child: Text(
              widget.season.name,
              style: TextStyle(
                color: _isFocused ? Colors.black : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TvEpisodeCard extends StatefulWidget {
  final Episode episode;
  final int seasonNumber;
  final MovieItem item;
  final Function(BuildContext) onFocus;

  const _TvEpisodeCard({required this.episode, required this.seasonNumber, required this.item, required this.onFocus});

  @override
  State<_TvEpisodeCard> createState() => _TvEpisodeCardState();
}

class _TvEpisodeCardState extends State<_TvEpisodeCard> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (focused) widget.onFocus(context);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.watchPathForItem(widget.item), arguments: widget.item);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: _isFocused ? 320 : 300,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withOpacity(0.6), blurRadius: 15, spreadRadius: 3)] : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      NetworkArt(
                        url: widget.episode.thumbnail,
                        fit: BoxFit.cover,
                      ),
                      const Positioned(
                        bottom: 8,
                        right: 8,
                        child: Icon(Icons.play_circle_fill, color: Colors.white, size: 36),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.episode.number}. ${widget.episode.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.episode.duration,
                        style: const TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.episode.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
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
