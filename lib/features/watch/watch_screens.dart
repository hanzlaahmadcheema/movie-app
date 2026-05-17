import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../core/config/app_config.dart';
import '../../core/models/detail_item.dart';
import '../../core/models/movie_item.dart';
import '../../core/models/tmdb_season.dart';
import '../../core/models/tmdb_video.dart';
import '../../core/services/tmdb_repository.dart';
import '../../core/navigation/content_navigation.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/detail_widgets.dart';
import '../../widgets/network_art.dart';
import '../../widgets/poster_widgets.dart';

class MovieWatchScreen extends StatelessWidget {
  const MovieWatchScreen({this.item, super.key});

  final MovieItem? item;

  @override
  Widget build(BuildContext context) {
    return _WatchPage(item: item, isSeries: false);
  }
}

class SeriesWatchScreen extends StatelessWidget {
  const SeriesWatchScreen({this.item, super.key});

  final MovieItem? item;

  @override
  Widget build(BuildContext context) {
    return _WatchPage(item: item, isSeries: true);
  }
}

class _WatchPage extends StatefulWidget {
  const _WatchPage({required this.item, required this.isSeries});

  final MovieItem? item;
  final bool isSeries;

  @override
  State<_WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<_WatchPage> {
  late Future<TmdbDetail?> detailFuture = _loadDetail();
  int? selectedSeasonNumber;
  Future<List<Episode>>? episodesFuture;

  @override
  Widget build(BuildContext context) {
    if (widget.item == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<TmdbDetail?>(
            future: detailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: IconButton(
                    onPressed: () => setState(() {
                      detailFuture = _loadDetail();
                    }),
                    icon: const Icon(Icons.refresh, size: 28),
                  ),
                );
              }

              final detail = snapshot.data!;
              final item = detail.item;
              final trailer = detail.videos.isNotEmpty
                  ? detail.videos.first
                  : null;
              final related = _loopItems(detail.related, 10);
              final seasons = detail.seasons;

              if (widget.isSeries &&
                  selectedSeasonNumber == null &&
                  seasons.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  setState(() {
                    selectedSeasonNumber = seasons.first.number;
                    episodesFuture = _loadEpisodes(
                      item.id,
                      seasons.first.number,
                    );
                  });
                });
              }

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DetailBackdrop(
                    item: item,
                    child: SizedBox(
                      height: widget.isSeries ? 1125 : 760,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 125,
                            left: 15,
                            right: 15,
                            child: _TopIconRow(item: item),
                          ),
                          Positioned(
                            top: 155,
                            left: 15,
                            right: 15,
                            child: Text(
                              item.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Positioned(
                            top: 211,
                            left: 0,
                            right: 0,
                            child: WatchVideoPlayer(
                              item: item,
                              video: trailer,
                              onPlay: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      trailer == null
                                          ? 'No trailer available'
                                          : 'Trailer: ${trailer.name}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 495,
                            left: 38,
                            child: ReactionRow(
                              onChanged: (reaction) {
                                final message = switch (reaction) {
                                  ReactionState.like => 'Liked',
                                  ReactionState.unlike => 'Marked as unlike',
                                  ReactionState.none => 'Reaction cleared',
                                };
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              },
                            ),
                          ),
                          if (widget.isSeries && seasons.isNotEmpty) ...[
                            Positioned(
                              top: 580,
                              left: 0,
                              right: 0,
                              child: SeasonDropdownTile(
                                seasons: seasons,
                                selectedSeasonNumber:
                                    selectedSeasonNumber ??
                                    seasons.first.number,
                                onSelected: (season) {
                                  setState(() {
                                    selectedSeasonNumber = season.number;
                                    episodesFuture = _loadEpisodes(
                                      item.id,
                                      season.number,
                                    );
                                  });
                                },
                              ),
                            ),
                            Positioned(
                              top: 650,
                              left: 0,
                              right: 0,
                              child: FutureBuilder<List<Episode>>(
                                future: episodesFuture,
                                builder: (context, episodeSnapshot) {
                                  if (episodeSnapshot.connectionState !=
                                      ConnectionState.done) {
                                    return const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 40,
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  final episodes =
                                      episodeSnapshot.data ?? const <Episode>[];
                                  return EpisodeList(
                                    episodes: episodes,
                                    onEpisodeSelected: (episode) =>
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Playing ${episode.title}',
                                            ),
                                          ),
                                        ),
                                  );
                                },
                              ),
                            ),
                          ],
                          Positioned(
                            top: 495,
                            right: 38,
                            child: ServerSelector(
                              onServerSelected: (server) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Switched to $server'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: HorizontalPosterSection(
                      title: 'You may also like',
                      items: related,
                      itemCount: 10,
                      onItemTap: (item) => openDetailForItem(context, item),
                    ),
                  ),
                  const SizedBox(height: 36),
                  const FooterDetails(),
                ],
              );
            },
          ),
          const Positioned(top: 0, left: 0, right: 0, child: MovieAppBar()),
        ],
      ),
    );
  }

  Future<TmdbDetail?> _loadDetail() async {
    final item = widget.item;
    if (item == null || item.id == 0) {
      return null;
    }

    return TmdbRepository(config: AppConfig.fromEnv()).detail(item);
  }

  Future<List<Episode>> _loadEpisodes(int tvId, int seasonNumber) {
    return TmdbRepository(
      config: AppConfig.fromEnv(),
    ).tvSeasonEpisodes(tvId: tvId, seasonNumber: seasonNumber);
  }
}

class WatchVideoPlayer extends StatelessWidget {
  const WatchVideoPlayer({
    required this.item,
    required this.onPlay,
    this.video,
    super.key,
  });

  final MovieItem item;
  final VoidCallback onPlay;
  final TmdbVideo? video;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232,
      child: Stack(
        fit: StackFit.expand,
        children: [
          NetworkArt(url: item.posterUrl),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.20),
                  Colors.black.withValues(alpha: 0.55),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 14,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      '00:00',
                      style: AppTextStyles.small.copyWith(
                        color: Colors.white.withValues(alpha: 0.80),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          minHeight: 4,
                          value: 0.32,
                          backgroundColor: Colors.white.withValues(alpha: 0.20),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item.duration,
                      style: AppTextStyles.small.copyWith(
                        color: Colors.white.withValues(alpha: 0.80),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _PlayerIconButton(icon: Icons.skip_previous, onTap: () {}),
                    const SizedBox(width: 8),
                    _PlayerIconButton(icon: Icons.replay_10, onTap: () {}),
                    const Spacer(),
                    _PrimaryPlayButton(onTap: onPlay),
                    const Spacer(),
                    _PlayerIconButton(icon: Icons.forward_10, onTap: () {}),
                    const SizedBox(width: 8),
                    _PlayerIconButton(
                      icon: Icons.fullscreen,
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fullscreen preview')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 18,
            top: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.52),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.hd, color: AppColors.primary, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    video == null ? '${item.quality} Stream' : video!.name,
                    style: AppTextStyles.small.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryPlayButton extends StatelessWidget {
  const _PrimaryPlayButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 26,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(Icons.play_arrow, color: Colors.black, size: 36),
      ),
    );
  }
}

class _PlayerIconButton extends StatelessWidget {
  const _PlayerIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.38),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        ),
        child: Icon(icon, size: 19, color: Colors.white),
      ),
    );
  }
}

class ServerSelector extends StatefulWidget {
  const ServerSelector({required this.onServerSelected, super.key});

  final ValueChanged<String> onServerSelected;

  @override
  State<ServerSelector> createState() => _ServerSelectorState();
}

class _ServerSelectorState extends State<ServerSelector> {
  String selectedServer = 'Servers';
  bool opened = false;
  final servers = const ['Server 1', 'Server 2', 'Server 3'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 138,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => opened = !opened),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(selectedServer, style: AppTextStyles.medium),
                const SizedBox(width: 7),
                Icon(
                  opened ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 20,
                ),
              ],
            ),
          ),
          if (opened) ...[
            const SizedBox(height: 8),
            Container(
              width: 128,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: servers
                    .map(
                      (server) => InkWell(
                        onTap: () {
                          setState(() {
                            selectedServer = server;
                            opened = false;
                          });
                          widget.onServerSelected(server);
                        },
                        child: Container(
                          height: 36,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            server,
                            style: AppTextStyles.normal.copyWith(
                              color: selectedServer == server
                                  ? AppColors.primary
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class SeasonDropdownTile extends StatefulWidget {
  const SeasonDropdownTile({
    required this.seasons,
    required this.selectedSeasonNumber,
    required this.onSelected,
    super.key,
  });

  final List<TmdbSeason> seasons;
  final int selectedSeasonNumber;
  final ValueChanged<TmdbSeason> onSelected;

  @override
  State<SeasonDropdownTile> createState() => _SeasonDropdownTileState();
}

class _SeasonDropdownTileState extends State<SeasonDropdownTile> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    final selectedSeason = widget.seasons.firstWhere(
      (season) => season.number == widget.selectedSeasonNumber,
      orElse: () => widget.seasons.first,
    );

    return SizedBox(
      height: opened ? 190 : 70,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 70,
            color: Colors.black.withValues(alpha: 0.30),
            child: Stack(
              children: [
                Positioned(
                  left: 18,
                  top: 17,
                  child: _SeasonDropdownButton(
                    label: selectedSeason.name,
                    opened: opened,
                    onTap: () => setState(() => opened = !opened),
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      'Episode ${selectedSeason.episodeCount}',
                      style: AppTextStyles.normal.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (opened)
            Positioned(
              left: 18,
              top: 58,
              child: _SeasonDropdownMenu(
                seasons: widget.seasons,
                selectedSeason: selectedSeason,
                onSelected: (season) {
                  setState(() => opened = false);
                  widget.onSelected(season);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _SeasonDropdownButton extends StatelessWidget {
  const _SeasonDropdownButton({
    required this.label,
    required this.opened,
    required this.onTap,
  });

  final String label;
  final bool opened;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: 130,
        height: 35,
        padding: const EdgeInsets.only(left: 14, right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.normal.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            ),
            Icon(
              opened ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _SeasonDropdownMenu extends StatelessWidget {
  const _SeasonDropdownMenu({
    required this.seasons,
    required this.selectedSeason,
    required this.onSelected,
  });

  final List<TmdbSeason> seasons;
  final TmdbSeason selectedSeason;
  final ValueChanged<TmdbSeason> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: seasons
            .map(
              (season) => InkWell(
                onTap: () => onSelected(season),
                child: Container(
                  height: 35,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    season.name,
                    style: AppTextStyles.normal.copyWith(
                      color: selectedSeason.number == season.number
                          ? AppColors.primary
                          : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    required this.episodes,
    required this.onEpisodeSelected,
    super.key,
  });

  final List<Episode> episodes;
  final ValueChanged<Episode> onEpisodeSelected;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  int selectedEpisode = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 434,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: widget.episodes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 2),
        itemBuilder: (context, index) => EpisodeTile(
          episode: widget.episodes[index],
          displayNumber: index + 1,
          subtitle: widget.episodes[index].title,
          selected: index == selectedEpisode,
          onTap: () {
            setState(() => selectedEpisode = index);
            widget.onEpisodeSelected(widget.episodes[index]);
          },
        ),
      ),
    );
  }
}

class EpisodeTile extends StatelessWidget {
  const EpisodeTile({
    required this.episode,
    required this.displayNumber,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final Episode episode;
  final int displayNumber;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: selected ? 0.30 : 0.10),
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withValues(alpha: 0.18),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              Icons.play_arrow,
              size: 10,
              color: selected
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.55),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Episode $displayNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.normal.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.normal.copyWith(
                      color: Colors.white.withValues(alpha: 0.60),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

List<T> _loopItems<T>(List<T> items, int count) {
  if (items.isEmpty) {
    return items;
  }
  return List.generate(count, (index) => items[index % items.length]);
}

class _TopIconRow extends StatefulWidget {
  const _TopIconRow({required this.item});

  final MovieItem item;

  @override
  State<_TopIconRow> createState() => _TopIconRowState();
}

class _TopIconRowState extends State<_TopIconRow> {
  bool watchlisted = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: _WatchTopIconAction(
              icon: Icons.info,
              label: 'Detail',
              onTap: () => openDetailForItem(context, widget.item),
            ),
          ),
          Positioned(
            left: 80,
            child: _WatchTopIconAction(
              icon: Icons.send,
              label: 'Share',
              onTap: () => _showMessage('Share option selected'),
            ),
          ),
          Positioned(
            left: 160,
            child: _WatchTopIconAction(
              icon: Icons.code,
              label: 'Embed',
              onTap: () => _showMessage('Embed option selected'),
            ),
          ),
          Positioned(
            left: 240,
            child: _WatchTopIconAction(
              icon: watchlisted ? Icons.bookmark : Icons.bookmark_border,
              iconColor: watchlisted ? AppColors.primary : Colors.white,
              label: 'Add to Watchlist',
              onTap: () {
                setState(() => watchlisted = !watchlisted);
                _showMessage(
                  watchlisted ? 'Added to watchlist' : 'Removed from watchlist',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _WatchTopIconAction extends StatelessWidget {
  const _WatchTopIconAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: iconColor),
            const SizedBox(width: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: AppTextStyles.normal.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionRow extends StatefulWidget {
  const ReactionRow({required this.onChanged, super.key});

  final ValueChanged<ReactionState> onChanged;

  @override
  State<ReactionRow> createState() => _ReactionRowState();
}

enum ReactionState { none, like, unlike }

class _ReactionRowState extends State<ReactionRow> {
  ReactionState selected = ReactionState.none;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Reaction(
          icon: Icons.thumb_up_alt_outlined,
          label: 'Like',
          selected: selected == ReactionState.like,
          onTap: () {
            setState(() {
              selected = selected == ReactionState.like
                  ? ReactionState.none
                  : ReactionState.like;
            });
            widget.onChanged(selected);
          },
        ),
        const SizedBox(width: 18),
        _Reaction(
          icon: Icons.thumb_down_alt_outlined,
          label: 'Unlike',
          selected: selected == ReactionState.unlike,
          onTap: () {
            setState(() {
              selected = selected == ReactionState.unlike
                  ? ReactionState.none
                  : ReactionState.unlike;
            });
            widget.onChanged(selected);
          },
        ),
      ],
    );
  }
}

class _Reaction extends StatelessWidget {
  const _Reaction({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: selected ? AppColors.primary : null),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.normal.copyWith(
              color: selected ? AppColors.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
