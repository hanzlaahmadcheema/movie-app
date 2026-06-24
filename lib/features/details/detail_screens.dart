import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/constants/app_assets.dart';
import '../../core/config/app_config.dart';
import '../../core/models/movie_item.dart';
import '../../core/models/tmdb_person.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/tmdb_repository.dart';
import '../../core/services/user_activity_repository.dart';
import '../../core/trailer/trailer_picker.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/detail_widgets.dart';
import '../../widgets/firebase_posters.dart';
import '../../widgets/network_art.dart';
import '../../widgets/pagination.dart';
import '../../widgets/poster_widgets.dart';
import '../../widgets/state_views.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({this.item, super.key});

  final MovieItem? item;

  @override
  Widget build(BuildContext context) {
    return _DetailPage(item: item, isSeries: false);
  }
}

class SeriesDetailScreen extends StatelessWidget {
  const SeriesDetailScreen({this.item, super.key});

  final MovieItem? item;

  @override
  Widget build(BuildContext context) {
    return _DetailPage(item: item, isSeries: true);
  }
}

class _DetailPage extends StatefulWidget {
  const _DetailPage({required this.item, required this.isSeries});

  final MovieItem? item;
  final bool isSeries;

  @override
  State<_DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<_DetailPage> {
  late Future<TmdbDetail?> tmdbDetail = _loadDetail();

  @override
  Widget build(BuildContext context) {
    if (widget.item == null) {
      return const InvalidRouteScreen(
        message: 'Movie detail requires a valid movie item.',
      );
    }

    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      body: Stack(
        children: [
          FutureBuilder<TmdbDetail?>(
            future: tmdbDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || snapshot.data == null) {
                return AppErrorView(
                  title: 'Could not load details',
                  message: snapshot.hasError
                      ? userMessageForError(snapshot.error)
                      : 'This title was not found.',
                  onRetry: () => setState(() {
                    tmdbDetail = _loadDetail();
                  }),
                );
              }

              final detail = snapshot.data!;
              final item = detail.item;
              final info = detail.info;
              final related = detail.related;
              final trailer = TrailerPicker.pick(
                detail.videos,
                title: item.title,
              );

              return StreamBuilder(
                stream: AuthService.instance.authStateChanges,
                builder: (context, authSnapshot) {
                  final user = authSnapshot.data;
                  return StreamBuilder<bool>(
                    stream: UserActivityRepository.instance
                        .watchlistStateStream(user, item),
                    builder: (context, watchlistSnapshot) {
                      final watchlisted = watchlistSnapshot.data ?? false;
                      return StreamBuilder<bool>(
                        stream: UserActivityRepository.instance
                            .watchedStateStream(user, item),
                        builder: (context, watchedSnapshot) {
                          final watched = watchedSnapshot.data ?? false;
                          return ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              DetailBackdrop(
                                item: item,
                                child: Column(
                                  children: [
                                    DetailHero(
                                      item: item,
                                      showBackground: false,
                                      watchlisted: watchlisted,
                                      watched: watched,
                                      onWatchlistChanged: (active) =>
                                          _setWatchlisted(item, active),
                                      onWatchedChanged: (active) =>
                                          _setWatched(item, active),
                                      onTrailer: () =>
                                          _openTrailer(context, trailer),
                                      onWatch: () => widget.isSeries
                                          ? Navigator.pushNamed(
                                              context,
                                              AppRoutes.seriesWatch,
                                              arguments: item,
                                            )
                                          : Navigator.pushNamed(
                                              context,
                                              AppRoutes.movieWatch,
                                              arguments: item,
                                            ),
                                    ),
                                    const SizedBox(height: 12),
                                    DetailBody(
                                      item: item,
                                      info: info,
                                      moreLikeThis: related,
                                      includeRelated: false,
                                    ),
                                    const SizedBox(height: 42),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                ),
                                child: FirebaseHorizontalPosterSection(
                                  title: 'You may also like',
                                  items: related,
                                  itemCount: 10,
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

  void _openTrailer(BuildContext context, PlayableTrailer? trailer) {
    if (trailer == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Trailer unavailable')));
      return;
    }
    Navigator.pushNamed(
      context,
      AppRoutes.trailer,
      arguments: trailer.toRouteArguments(),
    );
  }

  Future<void> _setWatchlisted(MovieItem item, bool active) async {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login to use your watchlist')),
      );
      Navigator.pushNamed(context, AppRoutes.login);
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
}

class CastDetailScreen extends StatefulWidget {
  const CastDetailScreen({this.query, super.key});

  final String? query;

  @override
  State<CastDetailScreen> createState() => _CastDetailScreenState();
}

class _CastDetailScreenState extends State<CastDetailScreen> {
  late Future<TmdbPerson?> personFuture = _loadPerson();
  int _knownForPage = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.query == null || widget.query!.trim().isEmpty) {
      return const InvalidRouteScreen(
        message: 'Cast detail requires a valid cast name.',
      );
    }

    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      body: Stack(
        children: [
          FutureBuilder<TmdbPerson?>(
            future: personFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || snapshot.data == null) {
                return AppErrorView(
                  title: 'Could not load cast details',
                  message: snapshot.hasError
                      ? userMessageForError(snapshot.error)
                      : 'This cast member was not found.',
                  onRetry: () => setState(() {
                    personFuture = _loadPerson();
                  }),
                );
              }

              final person = snapshot.data!;
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 888,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 35,
                              sigmaY: 35,
                            ),
                            child: Opacity(
                              opacity: 0.24,
                              child: NetworkArt(
                                url: person.profilePath.isEmpty
                                    ? AppAssets.cast
                                    : 'https://image.tmdb.org/t/p/w342${person.profilePath}',
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
                        Positioned(
                          top: 127,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: NetworkArt(
                              url: person.profilePath.isEmpty
                                  ? AppAssets.cast
                                  : 'https://image.tmdb.org/t/p/w342${person.profilePath}',
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
                            person.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Positioned(
                          top: 536,
                          left: 13,
                          right: 13,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Biography', style: AppTextStyles.medium),
                              const SizedBox(height: 12),
                              Text(
                                person.biography.isEmpty
                                    ? 'No biography available.'
                                    : person.biography,
                                style: AppTextStyles.normal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SectionHeader(title: 'Known For'),
                  ),
                  if (person.knownFor.isNotEmpty)
                    _KnownForPage(
                      items: person.knownFor,
                      currentPage: _knownForPage,
                      onPageChanged: (page) {
                        setState(() => _knownForPage = page);
                      },
                    )
                  else
                    const AppEmptyState(
                      title: 'No known titles',
                      message:
                          'No catalog titles are available for this cast member.',
                      icon: Icons.movie_filter_outlined,
                    ),
                ],
              );
            },
          ),
          const Positioned(top: 0, left: 0, right: 0, child: MovieAppBar()),
        ],
      ),
    );
  }

  Future<TmdbPerson?> _loadPerson() {
    return TmdbRepository(
      config: AppConfig.fromEnv(),
    ).personByQuery(widget.query!.trim());
  }
}

class _KnownForPage extends StatelessWidget {
  const _KnownForPage({
    required this.items,
    required this.currentPage,
    required this.onPageChanged,
  });

  final List<MovieItem> items;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    const pageSize = 20;
    final totalPages = (items.length / pageSize).ceil().clamp(1, 500);
    final normalizedPage = currentPage.clamp(1, totalPages);
    final start = (normalizedPage - 1) * pageSize;
    final pageItems = items.skip(start).take(pageSize).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Column(
        children: [
          FirebasePosterGrid(items: pageItems, itemCount: pageItems.length),
          if (totalPages > 1) ...[
            const SizedBox(height: 28),
            PaginationBar(
              currentPage: normalizedPage,
              totalPages: totalPages,
              onPageChanged: onPageChanged,
            ),
          ],
        ],
      ),
    );
  }
}
