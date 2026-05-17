import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/config/app_config.dart';
import '../../core/data/mock_data.dart';
import '../../core/models/movie_item.dart';
import '../../core/navigation/content_navigation.dart';
import '../../core/services/tmdb_repository.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/buttons.dart';
import '../../widgets/network_art.dart';
import '../../widgets/poster_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int trendingTab = 0;
  final watchlistedItems = <String>{};
  late final Future<_HomeData> homeData = _loadHomeData();

  bool _isWatchlisted(MovieItem item) =>
      watchlistedItems.contains(_itemKey(item));

  void _setWatchlisted(MovieItem item, bool active) {
    setState(() {
      final key = _itemKey(item);
      if (active) {
        watchlistedItems.add(key);
      } else {
        watchlistedItems.remove(key);
      }
    });
  }

  String _itemKey(MovieItem item) => '${item.type}:${item.title}:${item.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<_HomeData>(
            future: homeData,
            initialData: _HomeData.fallback(),
            builder: (context, snapshot) {
              final data = snapshot.data ?? _HomeData.fallback();
              final trendingItems = trendingTab == 0
                  ? data.trendingMovies
                  : data.trendingSeries;

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  _HeroCarousel(items: data.heroItems),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 18, 5, 0),
                    child: SectionHeader(
                      title: 'Trending',
                      trailing: TogglePills(
                        active: trendingTab,
                        onChanged: (value) =>
                            setState(() => trendingTab = value),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                    child: PosterGrid(
                      items: trendingItems,
                      itemCount: 4,
                      isWatchlisted: _isWatchlisted,
                      onWatchlistChanged: _setWatchlisted,
                    ),
                  ),
                  const SizedBox(height: 18),
                  HorizontalPosterSection(
                    title: 'Latest Movies',
                    items: data.latestMovies,
                    onMore: () =>
                        Navigator.pushNamed(context, AppRoutes.movies),
                    isWatchlisted: _isWatchlisted,
                    onWatchlistChanged: _setWatchlisted,
                  ),
                  const SizedBox(height: 18),
                  HorizontalPosterSection(
                    title: 'Latest TV Series',
                    items: data.latestSeries,
                    onMore: () =>
                        Navigator.pushNamed(context, AppRoutes.series),
                    isWatchlisted: _isWatchlisted,
                    onWatchlistChanged: _setWatchlisted,
                  ),
                  const SizedBox(height: 22),
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

  Future<_HomeData> _loadHomeData() async {
    try {
      final repository = TmdbRepository(config: AppConfig.fromEnv());
      final trendingMovies = await repository.trendingMovies();
      final trendingSeries = await repository.trendingSeries();
      final latestMovies = await repository.latestMovies();
      final latestSeries = await repository.latestSeries();

      return _HomeData(
        heroItems: trendingMovies.take(3).toList(),
        trendingMovies: trendingMovies,
        trendingSeries: trendingSeries,
        latestMovies: latestMovies,
        latestSeries: latestSeries,
      ).withFallbacks();
    } catch (_) {
      return _HomeData.fallback();
    }
  }
}

class _HeroCarousel extends StatefulWidget {
  const _HeroCarousel({required this.items});

  final List<MovieItem> items;

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
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
      height: 383,
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
            left: 15,
            bottom: 42,
            width: 125,
            child: PrimaryButton(
              label: 'Watch Now',
              icon: Icons.play_arrow,
              height: 40,
              radius: 25,
              onPressed: () =>
                  openDetailForItem(context, widget.items[activeIndex]),
            ),
          ),
          Positioned(
            right: 21,
            top: 161,
            child: Column(
              children: List.generate(
                widget.items.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
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
          left: 15,
          right: 80,
          bottom: 95,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TagChip(label: item.quality),
                  const SizedBox(width: 5),
                  TagChip(label: item.type),
                  const SizedBox(width: 5),
                  TagChip(label: item.year),
                ],
              ),
              const SizedBox(height: 12),
              Text(item.title, style: AppTextStyles.medium),
              const SizedBox(height: 8),
              Text(
                item.description.isEmpty
                    ? 'Stream this title in high quality and add it to your list for later.'
                    : item.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.normal,
              ),
            ],
          ),
        ),
      ],
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

class _HomeData {
  const _HomeData({
    required this.heroItems,
    required this.trendingMovies,
    required this.trendingSeries,
    required this.latestMovies,
    required this.latestSeries,
  });

  factory _HomeData.fallback() {
    return _HomeData(
      heroItems: [heroMovie, movies[1], series[1]],
      trendingMovies: movies,
      trendingSeries: series,
      latestMovies: movies,
      latestSeries: series,
    );
  }

  final List<MovieItem> heroItems;
  final List<MovieItem> trendingMovies;
  final List<MovieItem> trendingSeries;
  final List<MovieItem> latestMovies;
  final List<MovieItem> latestSeries;

  _HomeData withFallbacks() {
    final fallback = _HomeData.fallback();
    return _HomeData(
      heroItems: heroItems.isEmpty ? fallback.heroItems : heroItems,
      trendingMovies: trendingMovies.isEmpty
          ? fallback.trendingMovies
          : trendingMovies,
      trendingSeries: trendingSeries.isEmpty
          ? fallback.trendingSeries
          : trendingSeries,
      latestMovies: latestMovies.isEmpty ? fallback.latestMovies : latestMovies,
      latestSeries: latestSeries.isEmpty ? fallback.latestSeries : latestSeries,
    );
  }
}
