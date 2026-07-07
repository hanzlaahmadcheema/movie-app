import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/config/app_config.dart';
import '../../core/models/movie_item.dart';
import '../../core/navigation/content_navigation.dart';
import '../../core/responsive/adaptive_container.dart';
import '../../core/responsive/responsive_context.dart';
import '../../core/services/local_image_cache_service.dart';
import '../../core/services/admin_repository.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/tmdb_repository.dart';
import '../../core/services/user_activity_repository.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/buttons.dart';
import '../../widgets/continue_watching.dart';
import '../../widgets/filter_widgets.dart';
import '../../widgets/network_art.dart';
import '../../widgets/poster_widgets.dart';
import '../../widgets/state_views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.dataLoader});

  final Future<HomeContentData> Function()? dataLoader;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int trendingTab = 0;
  late Future<HomeContentData> homeData;

  @override
  void initState() {
    super.initState();
    homeData = _createHomeDataFuture();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      enablePullToRefresh: false,
      body: Stack(
        children: [
          StreamBuilder(
            stream: AuthService.instance.authStateChanges,
            builder: (context, authSnapshot) {
              final user = authSnapshot.data;
              return StreamBuilder<Set<String>>(
                stream: UserActivityRepository.instance.watchlistKeysStream(
                  user,
                ),
                builder: (context, watchlistSnapshot) {
                  final watchlistKeys =
                      watchlistSnapshot.data ?? const <String>{};
                  return FutureBuilder<HomeContentData>(
                    future: homeData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError || snapshot.data == null) {
                        return AppErrorView(
                          title: 'Could not load Home',
                          message: snapshot.hasError
                              ? userMessageForError(snapshot.error)
                              : 'Home content is unavailable right now.',
                          onRetry: () => setState(() {
                            homeData = _createHomeDataFuture();
                          }),
                        );
                      }

                      final data = snapshot.data!;
                      final trendingItems = trendingTab == 0
                          ? data.trendingMovies
                          : data.trendingSeries;
                      final heroItems = data.heroItems.isNotEmpty
                          ? data.heroItems
                          : _loopItems(data.trendingMovies, 10);

                      return RefreshIndicator(
                        onRefresh: () async {
                          final future = _createHomeDataFuture();
                          setState(() {
                            homeData = future;
                          });
                          await future;
                        },
                        edgeOffset: 90, // offset below the app bar
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            if (heroItems.isNotEmpty)
                              HeroCarouselSection(
                                items: _loopItems(heroItems, 10),
                              )
                            else
                              const SizedBox(height: 220),
                            AdaptiveContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  const ContinueWatchingSection(),
                                  if (data.notices.isNotEmpty) ...[
                                    const SizedBox(height: 18),
                                    Column(
                                      children: data.notices
                                          .map(
                                            (notice) =>
                                                _NoticeCard(notice: notice),
                                          )
                                          .toList(growable: false),
                                    ),
                                  ],
                                  if (data.featuredItems.isNotEmpty) ...[
                                    const SizedBox(height: 32),
                                    HorizontalPosterSection(
                                      title: 'Featured',
                                      items: _loopItems(data.featuredItems, 10),
                                      itemCount: data.featuredItems.length
                                          .clamp(0, 10),
                                      isWatchlisted: (item) => watchlistKeys
                                          .contains(contentKeyFor(item)),
                                      onWatchlistChanged: (item, active) =>
                                          _setWatchlisted(item, active),
                                    ),
                                  ],
                                  const SizedBox(height: 34),
                                  TrendingSection(
                                    items: _loopItems(trendingItems, 10),
                                    activeTab: trendingTab,
                                    onTabChanged: (value) =>
                                        setState(() => trendingTab = value),
                                    isWatchlisted: (item) => watchlistKeys
                                        .contains(contentKeyFor(item)),
                                    onWatchlistChanged: (item, active) =>
                                        _setWatchlisted(item, active),
                                  ),
                                  const SizedBox(height: 36),
                                  GenreSection(
                                    onSelected: (genre) =>
                                        openGenreBrowse(context, genre),
                                  ),
                                  const SizedBox(height: 36),
                                  LatestMoviesSection(
                                    items: _loopItems(data.latestMovies, 10),
                                    onMore: () => Navigator.pushNamed(
                                      context,
                                      AppRoutes.movies,
                                    ),
                                    isWatchlisted: (item) => watchlistKeys
                                        .contains(contentKeyFor(item)),
                                    onWatchlistChanged: (item, active) =>
                                        _setWatchlisted(item, active),
                                  ),
                                  const SizedBox(height: 36),
                                  LatestSeriesSection(
                                    items: _loopItems(data.latestSeries, 10),
                                    onMore: () => Navigator.pushNamed(
                                      context,
                                      AppRoutes.series,
                                    ),
                                    isWatchlisted: (item) => watchlistKeys
                                        .contains(contentKeyFor(item)),
                                    onWatchlistChanged: (item, active) =>
                                        _setWatchlisted(item, active),
                                  ),
                                  const SizedBox(height: 40),
                                  const HomeFooter(),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ],
                        ),
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

  Future<HomeContentData> _createHomeDataFuture() {
    final dataLoader = widget.dataLoader;
    return Future<HomeContentData>.microtask(() {
      if (dataLoader != null) {
        return dataLoader();
      }
      return _loadHomeData();
    });
  }

  Future<void> _setWatchlisted(MovieItem item, bool active) async {
    final firebaseUser = AuthService.instance.currentUser;
    if (firebaseUser == null) {
      _requireLogin();
      return;
    }

    try {
      await UserActivityRepository.instance.setWatchlisted(
        user: firebaseUser,
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

  void _requireLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login to use your watchlist')),
    );
    Navigator.pushNamed(context, AppRoutes.login);
  }

  Future<HomeContentData> _loadHomeData() async {
    final config = AppConfig.fromEnv();
    final adminRepository = AdminRepository.instance;
    if (!config.hasTmdbReadAccessToken) {
      final notices = await adminRepository.loadActiveNotices();
      return HomeContentData(
        heroItems: const [],
        featuredItems: const [],
        trendingMovies: const [],
        trendingSeries: const [],
        latestMovies: const [],
        latestSeries: const [],
        notices: notices,
      );
    }

    final repository = TmdbRepository(config: config);
    final futures = await Future.wait<dynamic>([
      repository.trendingMovies(),
      repository.trendingSeries(),
      repository.latestMovies(),
      repository.latestSeries(),
      adminRepository.loadActiveBanners(),
      adminRepository.loadEnabledFeaturedContent(),
      adminRepository.loadActiveNotices(),
    ]);
    final trendingMovies = futures[0] as List<MovieItem>;
    final trendingSeries = futures[1] as List<MovieItem>;
    final latestMovies = futures[2] as List<MovieItem>;
    final latestSeries = futures[3] as List<MovieItem>;
    final banners = futures[4] as List<AdminBanner>;
    final featured = futures[5] as List<FeaturedContentConfig>;
    final notices = futures[6] as List<AdminNotice>;

    final heroItems = await _resolveAdminItems(
      repository: repository,
      ids: banners
          .map(
            (banner) =>
                (tmdbId: banner.tmdbId, contentType: banner.contentType),
          )
          .toList(growable: false),
    );
    final featuredItems = await _resolveAdminItems(
      repository: repository,
      ids: featured
          .map((item) => (tmdbId: item.tmdbId, contentType: item.contentType))
          .toList(growable: false),
    );

    return HomeContentData(
      heroItems: heroItems,
      featuredItems: featuredItems,
      trendingMovies: trendingMovies,
      trendingSeries: trendingSeries,
      latestMovies: latestMovies,
      latestSeries: latestSeries,
      notices: notices,
    );
  }

  Future<List<MovieItem>> _resolveAdminItems({
    required TmdbRepository repository,
    required List<({int tmdbId, AdminContentType contentType})> ids,
  }) async {
    final items = <MovieItem>[];
    for (final entry in ids) {
      final item = entry.contentType == AdminContentType.series
          ? await repository.seriesById(entry.tmdbId)
          : await repository.movieById(entry.tmdbId);
      if (item != null) {
        items.add(item);
      }
    }
    return items;
  }
}

class HeroCarouselSection extends StatefulWidget {
  const HeroCarouselSection({required this.items, super.key});

  final List<MovieItem> items;

  @override
  State<HeroCarouselSection> createState() => _HeroCarouselState();
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.notice});

  final AdminNotice notice;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (notice.type) {
      NoticeType.warning => (Icons.warning_amber_rounded, Colors.amber),
      NoticeType.danger => (Icons.error_outline, Colors.redAccent),
      NoticeType.success => (Icons.check_circle_outline, Colors.greenAccent),
      _ => (Icons.info_outline, AppColors.primary),
    };
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notice.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (notice.message.trim().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    notice.message,
                    style: AppTextStyles.small.copyWith(color: Colors.white70),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCarouselState extends State<HeroCarouselSection> {
  static const autoPlayDuration = Duration(milliseconds: 3500);
  final pageController = PageController();
  int activeIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(autoPlayDuration, (_) {
      if (!mounted || !pageController.hasClients) {
        return;
      }

      final nextIndex = (activeIndex + 1) % widget.items.length;
      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _goToSlide(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
    _startTimer();
  }

  void _handlePageChanged(int index) {
    setState(() => activeIndex = index);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.isMobile ? 350 : (context.isTablet ? 470 : 610),
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: widget.items.length,
            onPageChanged: _handlePageChanged,
            itemBuilder: (context, index) =>
                _HeroSlide(item: widget.items[index]),
          ),
          Positioned(
            right: context.isMobile ? 18 : 32,
            bottom: context.isMobile ? 14 : 42,
            child: Row(
              children: List.generate(
                widget.items.length.clamp(0, 10),
                (index) => Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: _Dot(
                    active: activeIndex == index,
                    onTap: () => _goToSlide(index),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSlide extends StatelessWidget {
  const _HeroSlide({required this.item});

  final MovieItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        NetworkArt(
          url: item.backdropUrl.isEmpty ? item.posterUrl : item.backdropUrl,
          imageType: item.backdropUrl.isEmpty
              ? LocalImageCacheService.imageTypePoster
              : LocalImageCacheService.imageTypeBackdrop,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x33000000),
                Colors.transparent,
                AppColors.background,
              ],
              stops: [0.1, 0.5, 0.95],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: context.isMobile ? 34 : 48,
          child: AdaptiveContainer(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: context.isMobile ? double.infinity : 640,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 7,
                      runSpacing: 7,
                      children: [
                        TagChip(label: item.quality),
                        TagChip(label: item.type),
                        TagChip(label: item.year),
                      ],
                    ),
                    SizedBox(height: context.isMobile ? 10 : 18),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.title.copyWith(
                        fontSize: context.isMobile
                            ? 24
                            : (context.isTablet ? 36 : 48),
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.description.isEmpty
                          ? 'Stream this title in high quality and add it to your list for later.'
                          : item.description,
                      maxLines: context.isMobile ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.normal.copyWith(
                        color: Colors.white70,
                        fontSize: context.isMobile ? 12 : 15,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: context.isMobile ? 14 : 24),
                    Row(
                      children: [
                        SizedBox(
                          width: context.isMobile ? 126 : 154,
                          child: PrimaryButton(
                            label: 'Watch Now',
                            icon: Icons.play_arrow,
                            height: context.isMobile ? 40 : 48,
                            radius: AppRadius.pill,
                            onPressed: () => openWatchForItem(context, item),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          onPressed: () => openDetailForItem(context, item),
                          icon: const Icon(Icons.info_outline, size: 18),
                          label: const Text('Details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GenreSection extends StatelessWidget {
  const GenreSection({required this.onSelected, super.key});

  final ValueChanged<String> onSelected;

  static const genres = [
    'Action',
    'Drama',
    'Comedy',
    'Thriller',
    'Science Fiction',
    'Animation',
    'Horror',
    'Romance',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Browse Genres'),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final genre in genres)
              GenreChip(
                label: genre,
                selected: false,
                onSelected: () => onSelected(genre),
              ),
          ],
        ),
      ],
    );
  }
}

class TrendingSection extends StatelessWidget {
  const TrendingSection({
    required this.items,
    required this.activeTab,
    required this.onTabChanged,
    required this.isWatchlisted,
    required this.onWatchlistChanged,
    super.key,
  });

  final List<MovieItem> items;
  final int activeTab;
  final ValueChanged<int> onTabChanged;
  final bool Function(MovieItem item) isWatchlisted;
  final void Function(MovieItem item, bool active) onWatchlistChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Trending',
          trailing: TogglePills(active: activeTab, onChanged: onTabChanged),
        ),
        const SizedBox(height: 14),
        PosterGrid(
          items: items,
          itemCount: 10,
          isWatchlisted: isWatchlisted,
          onWatchlistChanged: onWatchlistChanged,
        ),
      ],
    );
  }
}

class LatestMoviesSection extends StatelessWidget {
  const LatestMoviesSection({
    required this.items,
    required this.onMore,
    required this.isWatchlisted,
    required this.onWatchlistChanged,
    super.key,
  });

  final List<MovieItem> items;
  final VoidCallback onMore;
  final bool Function(MovieItem item) isWatchlisted;
  final void Function(MovieItem item, bool active) onWatchlistChanged;

  @override
  Widget build(BuildContext context) {
    return HorizontalPosterSection(
      title: 'Latest Movies',
      items: items,
      itemCount: 10,
      onMore: onMore,
      isWatchlisted: isWatchlisted,
      onWatchlistChanged: onWatchlistChanged,
    );
  }
}

class LatestSeriesSection extends StatelessWidget {
  const LatestSeriesSection({
    required this.items,
    required this.onMore,
    required this.isWatchlisted,
    required this.onWatchlistChanged,
    super.key,
  });

  final List<MovieItem> items;
  final VoidCallback onMore;
  final bool Function(MovieItem item) isWatchlisted;
  final void Function(MovieItem item, bool active) onWatchlistChanged;

  @override
  Widget build(BuildContext context) {
    return HorizontalPosterSection(
      title: 'Latest TV Series',
      items: items,
      itemCount: 10,
      onMore: onMore,
      isWatchlisted: isWatchlisted,
      onWatchlistChanged: onWatchlistChanged,
    );
  }
}

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 16,
          children: [
            Text(
              'MovieApp',
              style: AppTextStyles.medium.copyWith(color: AppColors.primary),
            ),
            Wrap(
              spacing: 8,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.contact),
                  child: const Text('Contact'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.terms),
                  child: const Text('Terms'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.privacy),
                  child: const Text('Privacy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: active ? 8 : 6,
        height: active ? 8 : 6,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: active ? 1 : 0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class HomeContentData {
  const HomeContentData({
    required this.heroItems,
    required this.featuredItems,
    required this.trendingMovies,
    required this.trendingSeries,
    required this.latestMovies,
    required this.latestSeries,
    required this.notices,
  });

  final List<MovieItem> heroItems;
  final List<MovieItem> featuredItems;
  final List<MovieItem> trendingMovies;
  final List<MovieItem> trendingSeries;
  final List<MovieItem> latestMovies;
  final List<MovieItem> latestSeries;
  final List<AdminNotice> notices;
}

List<MovieItem> _loopItems(List<MovieItem> items, int count) {
  if (items.isEmpty) {
    return items;
  }
  return List.generate(count, (index) => items[index % items.length]);
}
