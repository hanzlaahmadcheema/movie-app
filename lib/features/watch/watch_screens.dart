import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/config/app_config.dart';
import '../../core/models/detail_item.dart';
import '../../core/models/movie_item.dart';
import '../../core/models/tmdb_season.dart';
import '../../core/navigation/watch_page_request.dart';
import '../../core/navigation/navigation_state_repository.dart';
import '../../core/responsive/adaptive_container.dart';
import '../../core/responsive/responsive_context.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/tmdb_repository.dart';
import '../../core/services/user_activity_repository.dart';
import '../../core/streaming/streaming_embed_request.dart';
import '../../core/navigation/content_navigation.dart';
import 'widgets/embedded_watch_player_panel.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/detail_widgets.dart';
import '../../widgets/firebase_posters.dart';
import '../../widgets/state_views.dart';
import '../../core/responsive/device_detector.dart';
import '../home/tv/tv_home_screen.dart'; // for TvContentRow

class MovieWatchScreen extends StatelessWidget {
  const MovieWatchScreen({this.request, super.key});

  final WatchPageRequest? request;

  @override
  Widget build(BuildContext context) {
    return _WatchPage(request: request, isSeries: false);
  }
}

class SeriesWatchScreen extends StatelessWidget {
  const SeriesWatchScreen({this.request, super.key});

  final WatchPageRequest? request;

  @override
  Widget build(BuildContext context) {
    return _WatchPage(request: request, isSeries: true);
  }
}

class _WatchPage extends StatefulWidget {
  const _WatchPage({required this.request, required this.isSeries});

  final WatchPageRequest? request;
  final bool isSeries;

  @override
  State<_WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<_WatchPage> {
  late Future<TmdbDetail?> detailFuture = _loadDetail();
  int? selectedSeasonNumber;
  Future<List<Episode>>? episodesFuture;
  String? _openedContentKey;
  StreamingEmbedRequest? activeRequest;

  bool _showAutoPlayCountdown = false;
  Episode? _nextEpisodeToPlay;
  int? _nextSeasonNumberToPlay;

  MovieItem? get _item => widget.request?.item;

  // ignore: unused_element
  Future<void> _triggerNextEpisodeCountdown(
    MovieItem item,
    List<TmdbSeason> seasons,
  ) async {
    final req = activeRequest;
    if (!widget.isSeries ||
        req == null ||
        req.seasonNumber == null ||
        req.episodeNumber == null) {
      return;
    }
    final currentSeason = req.seasonNumber!;
    final currentEpNum = req.episodeNumber!;

    try {
      final currentEpisodes =
          await (episodesFuture ?? _loadEpisodes(item.id, currentSeason));
      final currentIndex = currentEpisodes.indexWhere(
        (e) => e.number == currentEpNum,
      );

      if (currentIndex >= 0 && currentIndex + 1 < currentEpisodes.length) {
        final nextEp = currentEpisodes[currentIndex + 1];
        if (mounted) {
          setState(() {
            _nextEpisodeToPlay = nextEp;
            _nextSeasonNumberToPlay = currentSeason;
            _showAutoPlayCountdown = true;
          });
        }
      } else {
        final nextSeasonObj = seasons.firstWhere(
          (s) => s.number > currentSeason,
          orElse: () => const TmdbSeason(number: -1, name: '', episodeCount: 0),
        );
        if (nextSeasonObj.number > 0) {
          final nextSeasonEps = await _loadEpisodes(
            item.id,
            nextSeasonObj.number,
          );
          if (nextSeasonEps.isNotEmpty && mounted) {
            setState(() {
              _nextEpisodeToPlay = nextSeasonEps.first;
              _nextSeasonNumberToPlay = nextSeasonObj.number;
              _showAutoPlayCountdown = true;
            });
          }
        }
      }
    } catch (_) {}
  }

  void _playNextEpisode(MovieItem item) {
    final ep = _nextEpisodeToPlay;
    final seasonNum = _nextSeasonNumberToPlay;
    setState(() {
      _showAutoPlayCountdown = false;
      _nextEpisodeToPlay = null;
      _nextSeasonNumberToPlay = null;
    });
    if (ep != null && seasonNum != null) {
      _setEpisode(item, seasonNum, ep);
    }
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
    _persistRouteState();
    final request = widget.request;
    final item = _item;
    if (widget.isSeries) {
      final seasonNum = request?.seasonNumber ?? 1;
      final episodeNum = request?.episodeNumber ?? 1;
      selectedSeasonNumber = seasonNum;
      if (item != null) {
        episodesFuture = _loadEpisodes(item.id, seasonNum);
        activeRequest =
            StreamingEmbedRequest.episode(
              item: item,
              seasonNumber: seasonNum,
              episodeNumber: episodeNum,
              episodeTitle: null,
            ).copyWith(
              preferredProviderId: request?.selectedProviderId,
              jellyfinPlaybackModeOverride: request?.playbackMode,
              resumePositionSeconds: request?.resumePositionSeconds,
              resumeDurationSeconds: request?.resumeDurationSeconds,
            );
      }
    } else if (item != null) {
      activeRequest = StreamingEmbedRequest.movie(item).copyWith(
        preferredProviderId: request?.selectedProviderId,
        jellyfinPlaybackModeOverride: request?.playbackMode,
        resumePositionSeconds: request?.resumePositionSeconds,
        resumeDurationSeconds: request?.resumeDurationSeconds,
      );
    }
  }

  void _persistRouteState() {
    final request = widget.request;
    final item = request?.item;
    if (item == null) {
      return;
    }
    unawaited(
      NavigationStateRepository.instance.saveRouteState(
        route: widget.isSeries ? AppRoutes.seriesWatch : AppRoutes.movieWatch,
        arguments: request,
      ),
    );
  }

  @override
  void dispose() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_item == null) {
      return const InvalidRouteScreen(
        message: 'Watch page requires a valid title.',
      );
    }

    final content = Stack(
        children: [
          FutureBuilder<TmdbDetail?>(
            future: detailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || snapshot.data == null) {
                return AppErrorView(
                  title: 'Could not load watch page',
                  message: snapshot.hasError
                      ? userMessageForError(snapshot.error)
                      : 'This title was not found.',
                  onRetry: () => setState(() {
                    detailFuture = _loadDetail();
                  }),
                );
              }

              final detail = snapshot.data!;
              final item = detail.item;
              final related = _loopItems(detail.related, 10);
              final seasons = detail.seasons;
              final currentUser = AuthService.instance.currentUser;
              final contentKey = contentKeyFor(item);

              if (currentUser != null && _openedContentKey != contentKey) {
                _openedContentKey = contentKey;
                UserActivityRepository.instance.markOpened(
                  user: currentUser,
                  item: item,
                );
              }

              return StreamBuilder(
                stream: AuthService.instance.authStateChanges,
                builder: (context, authSnapshot) {
                  final user = authSnapshot.data;
                  return StreamBuilder<UserActivity>(
                    stream: UserActivityRepository.instance.activityStream(
                      user,
                      item,
                    ),
                    builder: (context, activitySnapshot) {
                      final activity =
                          activitySnapshot.data ?? const UserActivity();
                      return StreamBuilder<bool>(
                        stream: UserActivityRepository.instance
                            .watchlistStateStream(user, item),
                        builder: (context, watchlistSnapshot) {
                          final watchlisted = watchlistSnapshot.data ?? false;
                          if (widget.isSeries &&
                              activeRequest == null &&
                              widget.request?.autoPlay != false &&
                              selectedSeasonNumber == null &&
                              seasons.isNotEmpty) {
                            WidgetsBinding.instance.addPostFrameCallback((_) async {
                              if (!mounted) return;
                              final autoSeason = activity.seasonNumber ?? seasons.first.number;
                              setState(() {
                                selectedSeasonNumber = autoSeason;
                                episodesFuture = _loadEpisodes(item.id, autoSeason);
                              });
                              
                              final actSeason = activity.seasonNumber;
                              final actEpisode = activity.episodeNumber;
                              if (actSeason != null && actEpisode != null) {
                                setState(() {
                                  activeRequest = StreamingEmbedRequest.episode(
                                    item: item,
                                    seasonNumber: actSeason,
                                    episodeNumber: actEpisode,
                                    episodeTitle: activity.episodeTitle,
                                  ).copyWith(
                                    preferredProviderId: widget.request?.selectedProviderId,
                                    jellyfinPlaybackModeOverride: widget.request?.playbackMode,
                                    resumePositionSeconds: widget.request?.resumePositionSeconds,
                                    resumeDurationSeconds: widget.request?.resumeDurationSeconds,
                                  );
                                });
                              } else {
                                try {
                                  final eps = await _loadEpisodes(item.id, autoSeason);
                                  if (eps.isNotEmpty && mounted && activeRequest == null) {
                                    final actSeason = activity.seasonNumber;
                                    final actEpisode = activity.episodeNumber;
                                    if (actSeason != null && actEpisode != null) {
                                      setState(() {
                                        activeRequest = StreamingEmbedRequest.episode(
                                          item: item,
                                          seasonNumber: actSeason,
                                          episodeNumber: actEpisode,
                                          episodeTitle: activity.episodeTitle,
                                        ).copyWith(
                                          preferredProviderId: widget.request?.selectedProviderId,
                                          jellyfinPlaybackModeOverride: widget.request?.playbackMode,
                                          resumePositionSeconds: widget.request?.resumePositionSeconds,
                                          resumeDurationSeconds: widget.request?.resumeDurationSeconds,
                                        );
                                      });
                                    } else {
                                      setState(() {
                                        activeRequest = StreamingEmbedRequest.episode(
                                          item: item,
                                          seasonNumber: autoSeason,
                                          episodeNumber: eps.first.number,
                                          episodeTitle: eps.first.title,
                                        );
                                      });
                                    }
                                  }
                                } catch (_) {}
                              }
                            });
                          }
                          return StreamBuilder<bool>(
                            stream: UserActivityRepository.instance
                                .watchedStateStream(user, item),
                            builder: (context, watchedSnapshot) {
                              final watched = watchedSnapshot.data ?? false;
                              if (DeviceDetector.instance.isTv) {
                                return _buildTvWatchPage(
                                  item: item,
                                  related: related,
                                  seasons: seasons,
                                  activity: activity,
                                );
                              }
                              if (context.isDesktop) {
                                return _buildDesktopWatchPage(
                                  item: item,
                                  related: related,
                                  seasons: seasons,
                                  activity: activity,
                                  watchlisted: watchlisted,
                                  watched: watched,
                                );
                              }
                              if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
                                return Scaffold(
                                  backgroundColor: Colors.black,
                                  endDrawer: widget.isSeries ? Drawer(
                                    child: SafeArea(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: SeasonDropdownTile(
                                              seasons: seasons,
                                              selectedSeasonNumber: selectedSeasonNumber ?? seasons.first.number,
                                              selectedEpisodeNumber: _selectedEpisodeNumber(activity) ?? 1,
                                              onSelected: (season) async {
                                                final episodesFutureLocal = _loadEpisodes(item.id, season.number);
                                                setState(() {
                                                  selectedSeasonNumber = season.number;
                                                  activeRequest = null;
                                                  episodesFuture = episodesFutureLocal;
                                                });
                                                await _setSeason(item, season.number);
                                                try {
                                                  final episodes = await episodesFutureLocal;
                                                  if (episodes.isNotEmpty && mounted) {
                                                    await _setEpisode(item, season.number, episodes.first);
                                                  }
                                                } catch (_) {}
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: FutureBuilder<List<Episode>>(
                                              future: episodesFuture,
                                              builder: (context, episodeSnapshot) {
                                                if (episodeSnapshot.connectionState != ConnectionState.done) {
                                                  return const Center(child: CircularProgressIndicator());
                                                }
                                                final episodes = episodeSnapshot.data ?? const <Episode>[];
                                                if (episodeSnapshot.hasError) {
                                                  return const Center(child: Text('Error loading episodes'));
                                                }
                                                return EpisodeList(
                                                  episodes: episodes,
                                                  selectedEpisodeNumber: _selectedEpisodeNumber(activity),
                                                  onEpisodeSelected: (episode) => _setEpisode(
                                                    item,
                                                    selectedSeasonNumber ?? seasons.first.number,
                                                    episode,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ) : null,
                                  body: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      EmbeddedWatchPlayerPanel(
                                        request: activeRequest,
                                        selectionPrompt: widget.isSeries
                                            ? 'Select an episode from the menu to start playback.'
                                            : 'Preparing player...',
                                        topRightActions: const [],
                                      ),
                                       if (_showAutoPlayCountdown &&
                                           _nextEpisodeToPlay != null &&
                                           _nextSeasonNumberToPlay != null)
                                         NextEpisodeCountdownOverlay(
                                           nextEpisodeTitle: _nextEpisodeToPlay!.title,
                                           nextSeasonNumber: _nextSeasonNumberToPlay!,
                                           nextEpisodeNumber: _nextEpisodeToPlay!.number,
                                           onPlayNow: () => _playNextEpisode(item),
                                           onCancel: () => setState(() {
                                             _showAutoPlayCountdown = false;
                                             _nextEpisodeToPlay = null;
                                             _nextSeasonNumberToPlay = null;
                                           }),
                                         ),
                                    ],
                                  ),
                                );
                              }
                              return ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  DetailBackdrop(
                                    item: item,
                                    child: SizedBox(
                                      height: widget.isSeries ? 1173 : 671,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 173,
                                            left: 15,
                                            right: 15,
                                            child: Text(
                                              item.title,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleLarge,
                                            ),
                                          ),
                                          Positioned(
                                            top: 214,
                                            left: 15,
                                            right: 15,
                                            child: _TopIconRow(
                                              item: item,
                                              watchlisted: watchlisted,
                                              watched: watched,
                                              onWatchlistChanged: (active) =>
                                                  _setWatchlisted(item, active),
                                              onWatchedChanged: (active) =>
                                                  _setWatched(item, active),
                                            ),
                                          ),
                                          Positioned(
                                            top: 259,
                                            left: 0,
                                            right: 0,
                                            child: EmbeddedWatchPlayerPanel(
                                              request: activeRequest,
                                              selectionPrompt: widget.isSeries
                                                  ? 'Select an episode to start playback.'
                                                  : 'Preparing player...',
                                            ),
                                          ),
                                          Positioned(
                                            top: 610,
                                            left: 38,
                                            child: ReactionRow(
                                              selected:
                                                  _reactionStateFromActivity(
                                                    activity.reaction,
                                                  ),
                                              onChanged: (reaction) async {
                                                final saved =
                                                    await _setReaction(
                                                      item,
                                                      reaction,
                                                    );
                                                if (!context.mounted ||
                                                    !saved) {
                                                  return;
                                                }
                                                final message =
                                                    switch (reaction) {
                                                      ReactionState.like =>
                                                        'Liked',
                                                      ReactionState.unlike =>
                                                        'Marked as unlike',
                                                      ReactionState.none =>
                                                        'Reaction cleared',
                                                    };
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(message),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          if (widget.isSeries &&
                                              seasons.isNotEmpty) ...[
                                            Positioned(
                                              top: 725,
                                              left: 0,
                                              right: 0,
                                              child: FutureBuilder<List<Episode>>(
                                                future: episodesFuture,
                                                builder: (context, episodeSnapshot) {
                                                  if (episodeSnapshot
                                                          .connectionState !=
                                                      ConnectionState.done) {
                                                    return const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 40,
                                                          ),
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  }

                                                  final episodes =
                                                      episodeSnapshot.data ??
                                                      const <Episode>[];
                                                  if (episodeSnapshot
                                                      .hasError) {
                                                    return AppErrorView(
                                                      title:
                                                          'Could not load episodes',
                                                      message:
                                                          userMessageForError(
                                                            episodeSnapshot
                                                                .error,
                                                          ),
                                                      onRetry: () => setState(() {
                                                        episodesFuture =
                                                            _loadEpisodes(
                                                              item.id,
                                                              selectedSeasonNumber ??
                                                                  seasons
                                                                      .first
                                                                      .number,
                                                            );
                                                      }),
                                                    );
                                                  }
                                                  return EpisodeList(
                                                    episodes: episodes,
                                                    selectedEpisodeNumber:
                                                        _selectedEpisodeNumber(
                                                          activity,
                                                        ),
                                                    onEpisodeSelected:
                                                        (
                                                          episode,
                                                        ) => _setEpisode(
                                                          item,
                                                          selectedSeasonNumber ??
                                                              seasons
                                                                  .first
                                                                  .number,
                                                          episode,
                                                        ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Positioned(
                                              top: 655,
                                              left: 0,
                                              right: 0,
                                              child: SeasonDropdownTile(
                                                seasons: seasons,
                                                selectedSeasonNumber:
                                                    selectedSeasonNumber ??
                                                    seasons.first.number,
                                                selectedEpisodeNumber:
                                                    _selectedEpisodeNumber(
                                                          activity,
                                                        ) ??
                                                        1,
                                                onSelected: (season) async {
                                                  final episodesFutureLocal =
                                                      _loadEpisodes(
                                                        item.id,
                                                        season.number,
                                                      );
                                                  setState(() {
                                                    selectedSeasonNumber =
                                                        season.number;
                                                    activeRequest = null;
                                                    episodesFuture =
                                                        episodesFutureLocal;
                                                  });
                                                  await _setSeason(
                                                    item,
                                                    season.number,
                                                  );
                                                  try {
                                                    final episodes =
                                                        await episodesFutureLocal;
                                                    if (episodes.isNotEmpty &&
                                                        mounted) {
                                                      await _setEpisode(
                                                        item,
                                                        season.number,
                                                        episodes.first,
                                                      );
                                                    }
                                                  } catch (_) {}
                                                },
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: FirebaseHorizontalPosterSection(
                                      title: 'You may also like',
                                      items: related,
                                      itemCount: 10,
                                      onItemTap: (item) =>
                                          openDetailForItem(context, item),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS))
            const Positioned(top: 0, left: 0, right: 0, child: MovieAppBar()),
        ],
      );
      
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      return content;
    }
    return AppShell(body: content);
  }

  Widget _buildTvWatchPage({
    required MovieItem item,
    required List<MovieItem> related,
    required List<TmdbSeason> seasons,
    required UserActivity activity,
  }) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 60),
        children: [
          Hero(
            tag: 'tv_poster_${item.id}',
            child: SizedBox(
              height: 600,
              width: double.infinity,
              child: EmbeddedWatchPlayerPanel(
                request: activeRequest,
                selectionPrompt: widget.isSeries
                    ? 'Select an episode to start playback.'
                    : 'Preparing player...',
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  item.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          if (related.isNotEmpty)
            TvContentRow(
              title: 'Recommendations',
              items: related,
              onFocus: (context, _) {
                Scrollable.ensureVisible(
                  context,
                  alignment: 0.5,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildDesktopWatchPage({
    required MovieItem item,
    required List<MovieItem> related,
    required List<TmdbSeason> seasons,
    required UserActivity activity,
    required bool watchlisted,
    required bool watched,
  }) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AdaptiveContainer(
          maxWidth: 1400,
          child: Padding(
            padding: const EdgeInsets.only(top: 34, bottom: 44),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 32,
                          height: 1.15,
                        ),
                      ),
                    ),
                    _TopIconRow(
                      item: item,
                      watchlisted: watchlisted,
                      watched: watched,
                      onWatchlistChanged: (active) =>
                          _setWatchlisted(item, active),
                      onWatchedChanged: (active) => _setWatched(item, active),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      child: EmbeddedWatchPlayerPanel(
                        request: activeRequest,
                        selectionPrompt: widget.isSeries
                            ? 'Select an episode to start playback.'
                            : 'Preparing player...',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ReactionRow(
                  selected: _reactionStateFromActivity(activity.reaction),
                  onChanged: (reaction) => _setReaction(item, reaction),
                ),
                if (widget.isSeries && seasons.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  SeasonDropdownTile(
                    seasons: seasons,
                    selectedSeasonNumber:
                        selectedSeasonNumber ?? seasons.first.number,
                    selectedEpisodeNumber:
                        _selectedEpisodeNumber(activity) ?? 1,
                    onSelected: (season) =>
                        _selectSeason(item, seasons, season),
                  ),
                  FutureBuilder<List<Episode>>(
                    future: episodesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError) {
                        return AppErrorView(
                          title: 'Could not load episodes',
                          message: userMessageForError(snapshot.error),
                          onRetry: () => setState(() {
                            episodesFuture = _loadEpisodes(
                              item.id,
                              selectedSeasonNumber ?? seasons.first.number,
                            );
                          }),
                        );
                      }
                      final episodes = snapshot.data ?? const <Episode>[];
                      return EpisodeList(
                        episodes: episodes,
                        selectedEpisodeNumber: _selectedEpisodeNumber(
                          activity,
                        ),
                        onEpisodeSelected: (episode) => _setEpisode(
                          item,
                          selectedSeasonNumber ?? seasons.first.number,
                          episode,
                        ),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 34),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 850),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About this title',
                        style: AppTextStyles.sectionTitle(context),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.description.isEmpty
                            ? 'No description is available for this title.'
                            : item.description,
                        style: AppTextStyles.normal.copyWith(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.55,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                FirebaseHorizontalPosterSection(
                  title: 'You may also like',
                  items: related,
                  itemCount: 10,
                  onItemTap: (item) => openDetailForItem(context, item),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectSeason(
    MovieItem item,
    List<TmdbSeason> seasons,
    TmdbSeason season,
  ) async {
    final future = _loadEpisodes(item.id, season.number);
    setState(() {
      selectedSeasonNumber = season.number;
      activeRequest = null;
      episodesFuture = future;
    });
    await _setSeason(item, season.number);
    try {
      final episodes = await future;
      if (episodes.isNotEmpty && mounted) {
        await _setEpisode(item, season.number, episodes.first);
      }
    } catch (_) {}
  }

  Future<TmdbDetail?> _loadDetail() async {
    final item = _item;
    if (item == null || item.id == 0) {
      return null;
    }

    return TmdbRepository(config: AppConfig.fromEnv()).detail(item);
  }

  static final Map<String, List<Episode>> _episodesCache = {};

  Future<List<Episode>> _loadEpisodes(int tvId, int seasonNumber) async {
    final cacheKey = '$tvId-$seasonNumber';
    if (_episodesCache.containsKey(cacheKey)) {
      return _episodesCache[cacheKey]!;
    }
    final episodes = await TmdbRepository(
      config: AppConfig.fromEnv(),
    ).tvSeasonEpisodes(tvId: tvId, seasonNumber: seasonNumber);
    _episodesCache[cacheKey] = episodes;
    return episodes;
  }

  Future<bool> _requireUser(String message) async {
    if (AuthService.instance.currentUser != null) {
      return true;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    await Navigator.pushNamed(context, AppRoutes.login);
    return false;
  }

  Future<void> _setWatchlisted(MovieItem item, bool active) async {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      await _requireUser('Login to use your watchlist');
      return;
    }

    try {
      await UserActivityRepository.instance.setWatchlisted(
        user: user,
        item: item,
        active: active,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            active ? 'Added to watchlist' : 'Removed from watchlist',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save. Try again.')),
      );
    }
  }

  Future<void> _setWatched(MovieItem item, bool active) async {
    final user = AuthService.instance.currentUser;
    if (user == null) return;

    try {
      await UserActivityRepository.instance.setWatched(
        user: user,
        item: item,
        active: active,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(active ? 'Marked as watched' : 'Removed from watched'),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save. Try again.')),
      );
    }
  }

  Future<bool> _setReaction(MovieItem item, ReactionState reaction) async {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      await _requireUser('Login to save reactions');
      return false;
    }

    final userReaction = switch (reaction) {
      ReactionState.like => UserReaction.like,
      ReactionState.unlike => UserReaction.unlike,
      ReactionState.none => null,
    };
    try {
      await UserActivityRepository.instance.setReaction(
        user: user,
        item: item,
        reaction: userReaction,
      );
      return true;
    } catch (_) {
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save. Try again.')),
      );
      return false;
    }
  }

  Future<void> _setSeason(MovieItem item, int seasonNumber) async {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      await _requireUser('Login to save episode progress');
      return;
    }

    try {
      await UserActivityRepository.instance.setSelectedSeason(
        user: user,
        item: item,
        seasonNumber: seasonNumber,
      );
    } catch (_) {
      // Background sync, fail silently
    }
  }

  Future<void> _setEpisode(
    MovieItem item,
    int seasonNumber,
    Episode episode,
  ) async {
    final user = AuthService.instance.currentUser;
    if (user != null) {
      try {
        await UserActivityRepository.instance.setSelectedEpisode(
          user: user,
          item: item,
          seasonNumber: seasonNumber,
          episode: episode,
        );
      } catch (_) {
        // Background sync, fail silently
      }
    }

    if (!mounted) return;
    setState(() {
      activeRequest =
          StreamingEmbedRequest.episode(
            item: item,
            seasonNumber: seasonNumber,
            episodeNumber: episode.number,
            episodeTitle: episode.title,
          ).copyWith(
            preferredProviderId: activeRequest?.preferredProviderId,
            jellyfinPlaybackModeOverride:
                activeRequest?.jellyfinPlaybackModeOverride,
          );
    });
    _replaceSeriesWatchUrl(
      item: item,
      seasonNumber: seasonNumber,
      episodeNumber: episode.number,
    );
  }

  int? _selectedEpisodeNumber(UserActivity activity) {
    return activeRequest?.episodeNumber ??
        widget.request?.episodeNumber ??
        activity.episodeNumber;
  }

  void _replaceSeriesWatchUrl({
    required MovieItem item,
    required int seasonNumber,
    required int episodeNumber,
  }) {
    if (!widget.isSeries) {
      return;
    }
    final request = WatchPageRequest(
      item: item,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      autoPlay: true,
    );
    final path = AppRoutes.watchPathForRequest(request);
    SystemNavigator.routeInformationUpdated(uri: Uri.parse(path), replace: true);
    unawaited(
      NavigationStateRepository.instance.saveRouteState(
        route: AppRoutes.seriesWatch,
        arguments: request,
      ),
    );
  }
}

ReactionState _reactionStateFromActivity(UserReaction? reaction) {
  return switch (reaction) {
    UserReaction.like => ReactionState.like,
    UserReaction.unlike => ReactionState.unlike,
    null => ReactionState.none,
  };
}

class SeasonDropdownTile extends StatefulWidget {
  const SeasonDropdownTile({
    required this.seasons,
    required this.selectedSeasonNumber,
    required this.selectedEpisodeNumber,
    required this.onSelected,
    super.key,
  });

  final List<TmdbSeason> seasons;
  final int selectedSeasonNumber;
  final int selectedEpisodeNumber;
  final ValueChanged<TmdbSeason> onSelected;

  @override
  State<SeasonDropdownTile> createState() => _SeasonDropdownTileState();
}

class _SeasonDropdownTileState extends State<SeasonDropdownTile> {
  static const double _collapsedHeight = 70;
  static const double _menuTop = 58;
  static const double _menuItemHeight = 35;
  static const int _maxVisibleSeasonRows = 8;

  bool opened = false;

  @override
  Widget build(BuildContext context) {
    final selectedSeason = widget.seasons.firstWhere(
      (season) => season.number == widget.selectedSeasonNumber,
      orElse: () => widget.seasons.first,
    );
    final visibleSeasonRows = widget.seasons.length
        .clamp(1, _maxVisibleSeasonRows)
        .toDouble();
    final menuHeight = visibleSeasonRows * _menuItemHeight;
    final expandedHeight = _menuTop + menuHeight;

    return SizedBox(
      height: opened ? expandedHeight : _collapsedHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: _collapsedHeight,
            color: Colors.black.withValues(alpha: 0.30),
            child: Stack(
              children: [
                Positioned(
                  left: 18,
                  top: 17,
                  child: _SeasonDropdownButton(
                    label: _seasonDropdownLabel(selectedSeason),
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
                      'Episode ${widget.selectedEpisodeNumber}',
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
              top: _menuTop,
              child: _SeasonDropdownMenu(
                seasons: widget.seasons,
                selectedSeason: selectedSeason,
                height: menuHeight,
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
    required this.height,
    required this.onSelected,
  });

  final List<TmdbSeason> seasons;
  final TmdbSeason selectedSeason;
  final double height;
  final ValueChanged<TmdbSeason> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: height,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemExtent: _SeasonDropdownTileState._menuItemHeight,
          itemCount: seasons.length,
          itemBuilder: (context, index) {
            final season = seasons[index];
            return InkWell(
              onTap: () => onSelected(season),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  _seasonDropdownLabel(season),
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
            );
          },
        ),
      ),
    );
  }
}

String _seasonDropdownLabel(TmdbSeason season) => 'Season ${season.number}';

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    required this.episodes,
    required this.onEpisodeSelected,
    this.selectedEpisodeNumber,
    super.key,
  });

  final List<Episode> episodes;
  final ValueChanged<Episode> onEpisodeSelected;
  final int? selectedEpisodeNumber;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  int selectedEpisode = 0;

  @override
  void initState() {
    super.initState();
    _syncSelection();
  }

  @override
  void didUpdateWidget(covariant EpisodeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedEpisodeNumber != oldWidget.selectedEpisodeNumber ||
        widget.episodes != oldWidget.episodes) {
      _syncSelection();
    }
  }

  void _syncSelection() {
    final selectedNumber = widget.selectedEpisodeNumber;
    if (selectedNumber == null) {
      return;
    }
    final index = widget.episodes.indexWhere(
      (episode) => episode.number == selectedNumber,
    );
    if (index >= 0) {
      selectedEpisode = index;
    }
  }

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
  const _TopIconRow({
    required this.item,
    required this.watchlisted,
    required this.watched,
    required this.onWatchlistChanged,
    required this.onWatchedChanged,
  });

  final MovieItem item;
  final bool watchlisted;
  final bool watched;
  final ValueChanged<bool> onWatchlistChanged;
  final ValueChanged<bool> onWatchedChanged;

  @override
  State<_TopIconRow> createState() => _TopIconRowState();
}

class _TopIconRowState extends State<_TopIconRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _WatchTopIconAction(
            icon: Icons.info,
            label: 'Detail',
            onTap: () => openDetailForItem(context, widget.item),
          ),
          const SizedBox(width: 24),
          _WatchTopIconAction(
            icon: widget.watched
                ? Icons.check_circle
                : Icons.check_circle_outline,
            iconColor: widget.watched ? AppColors.primary : Colors.white,
            label: widget.watched ? 'Watched' : 'Mark Watched',
            onTap: () => widget.onWatchedChanged(!widget.watched),
          ),
          const SizedBox(width: 24),
          _WatchTopIconAction(
            icon: widget.watchlisted ? Icons.bookmark : Icons.bookmark_border,
            iconColor: widget.watchlisted ? AppColors.primary : Colors.white,
            label: widget.watchlisted ? 'Saved' : 'Watchlist',
            onTap: () => widget.onWatchlistChanged(!widget.watchlisted),
          ),
        ],
      ),
    );
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
        height: 26,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: iconColor),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: AppTextStyles.normal.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionRow extends StatefulWidget {
  const ReactionRow({
    required this.onChanged,
    this.selected = ReactionState.none,
    super.key,
  });

  final ValueChanged<ReactionState> onChanged;
  final ReactionState selected;

  @override
  State<ReactionRow> createState() => _ReactionRowState();
}

enum ReactionState { none, like, unlike }

class _ReactionRowState extends State<ReactionRow> {
  ReactionState selected = ReactionState.none;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  void didUpdateWidget(covariant ReactionRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      selected = widget.selected;
    }
  }

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

class NextEpisodeCountdownOverlay extends StatefulWidget {
  const NextEpisodeCountdownOverlay({
    required this.nextEpisodeTitle,
    required this.nextSeasonNumber,
    required this.nextEpisodeNumber,
    required this.onPlayNow,
    required this.onCancel,
    super.key,
  });

  final String nextEpisodeTitle;
  final int nextSeasonNumber;
  final int nextEpisodeNumber;
  final VoidCallback onPlayNow;
  final VoidCallback onCancel;

  @override
  State<NextEpisodeCountdownOverlay> createState() =>
      _NextEpisodeCountdownOverlayState();
}

class _NextEpisodeCountdownOverlayState
    extends State<NextEpisodeCountdownOverlay> {
  int _secondsRemaining = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining <= 1) {
        timer.cancel();
        widget.onPlayNow();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      right: 24,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 340,
          decoration: BoxDecoration(
            color: const Color(0xEE1A1A1D),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 44,
                        height: 44,
                        child: CircularProgressIndicator(
                          value: _secondsRemaining / 5.0,
                          color: AppColors.primary,
                          backgroundColor: Colors.white24,
                          strokeWidth: 3,
                        ),
                      ),
                      Text(
                        '$_secondsRemaining',
                        style: AppTextStyles.title.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Up Next in ${_secondsRemaining}s',
                          style: AppTextStyles.tag.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'S${widget.nextSeasonNumber} E${widget.nextEpisodeNumber} • ${widget.nextEpisodeTitle}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.medium.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: widget.onCancel,
                    style: OutlinedButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      foregroundColor: Colors.white70,
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  FilledButton.icon(
                    onPressed: widget.onPlayNow,
                    style: FilledButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      backgroundColor: AppColors.primary,
                    ),
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Play Now'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
