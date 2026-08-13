import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../app/app_routes.dart';
import '../../../core/models/movie_item.dart';
import '../../../core/services/tmdb_repository.dart';
import '../../../app/app_theme.dart';
import '../../../core/config/app_config.dart';
import '../../../core/navigation/content_navigation.dart';
import '../../../core/services/admin_repository.dart';
import '../../../core/services/auth_service.dart';
import '../../../widgets/app_shell.dart';
import '../../../widgets/continue_watching.dart';
import '../../../widgets/state_views.dart';
import '../../../widgets/network_art.dart';
import '../../../core/services/local_image_cache_service.dart';
import '../../../core/auth/user_role_service.dart';
import '../../../core/auth/current_user_role.dart';


class TvHomeScreen extends StatefulWidget {
  const TvHomeScreen({super.key});

  @override
  State<TvHomeScreen> createState() => _TvHomeScreenState();
}

class _TvHomeScreenState extends State<TvHomeScreen> {
  late Future<TvHomeContentData> homeData;
  late ScrollController _verticalScrollController;
  MovieItem? _focusedItem;

  void _scrollToCenter(BuildContext context, MovieItem item) {
    if (_focusedItem?.id != item.id) {
      setState(() => _focusedItem = item);
    }
    Scrollable.ensureVisible(
      context,
      alignment: 0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _verticalScrollController = ScrollController();
    homeData = _loadHomeData();
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    super.dispose();
  }

  Future<TvHomeContentData> _loadHomeData() async {
    final config = AppConfig.fromEnv();
    final adminRepository = AdminRepository.instance;
    final repository = TmdbRepository(config: config);

    final futures = await Future.wait<dynamic>([
      repository.trendingMovies(),
      repository.popularMovies(),
      repository.popularSeries(),
      repository.topRatedMovies(),
      repository.upcomingMovies(),
      repository.latestMovies(), // Now Playing
      adminRepository.loadActiveBanners(),
      adminRepository.loadEnabledFeaturedContent(),
    ]);

    final trendingMovies = futures[0] as List<MovieItem>;
    final popularMovies = futures[1] as List<MovieItem>;
    final popularSeries = futures[2] as List<MovieItem>;
    final topRatedMovies = futures[3] as List<MovieItem>;
    final upcomingMovies = futures[4] as List<MovieItem>;
    final nowPlaying = futures[5] as List<MovieItem>;
    final banners = futures[6] as List<AdminBanner>;
    final featured = futures[7] as List<FeaturedContentConfig>;

    final heroItems = await _resolveAdminItems(
      repository: repository,
      ids: banners
          .map((b) => (tmdbId: b.tmdbId, contentType: b.contentType))
          .toList(),
    );
    final featuredItems = await _resolveAdminItems(
      repository: repository,
      ids: featured
          .map((item) => (tmdbId: item.tmdbId, contentType: item.contentType))
          .toList(),
    );

    final tvHomeData = TvHomeContentData(
      heroItems: heroItems.isNotEmpty ? heroItems : trendingMovies.take(5).toList(),
      featuredItems: featuredItems,
      trendingMovies: trendingMovies,
      popularMovies: popularMovies,
      popularSeries: popularSeries,
      topRatedMovies: topRatedMovies,
      upcomingMovies: upcomingMovies,
      nowPlaying: nowPlaying,
    );

    // Preload hero images intelligently
    for (final item in tvHomeData.heroItems) {
      if (item.backdropUrl.isNotEmpty) {
        LocalImageCacheService.instance.cachedFileFor(remoteUrl: item.backdropUrl, imageType: LocalImageCacheService.imageTypeBackdrop);
      }
    }

    return tvHomeData;
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



  @override
  Widget build(BuildContext context) {
    return AppShell(
      enablePullToRefresh: false,
      body: Stack(
        children: [
          FutureBuilder<TvHomeContentData>(
            future: homeData,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || snapshot.data == null) {
                return AppErrorView(
                  title: "Couldn't load content.",
                  message: 'Please try again later.',
                  onRetry: () => setState(() {
                    homeData = _loadHomeData();
                  }),
                );
              }

              final data = snapshot.data!;
              return Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 800),
                    child: _focusedItem != null && _focusedItem!.backdropUrl.isNotEmpty
                        ? Stack(
                            key: ValueKey(_focusedItem!.id),
                            fit: StackFit.expand,
                            children: [
                              NetworkArt(url: _focusedItem!.backdropUrl, fit: BoxFit.cover),
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.black54, Colors.black],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  ListView(
                    controller: _verticalScrollController,
                    // ignore: deprecated_member_use
                    cacheExtent: 1500, // Preload previous and next rows
                    padding: const EdgeInsets.only(bottom: 60),
                    children: [
                      TvHeroBanner(items: data.heroItems),
                      const SizedBox(height: 32),
                      TvContentRow(title: 'Trending', items: data.trendingMovies, onFocus: _scrollToCenter),
                      TvContentRow(title: 'Popular Movies', items: data.popularMovies, onFocus: _scrollToCenter),
                      TvContentRow(title: 'Popular Series', items: data.popularSeries, onFocus: _scrollToCenter),
                      TvContentRow(title: 'Top Rated', items: data.topRatedMovies, onFocus: _scrollToCenter),
                      TvContentRow(title: 'Now Playing', items: data.nowPlaying, onFocus: _scrollToCenter),
                      TvContentRow(title: 'Upcoming', items: data.upcomingMovies, onFocus: _scrollToCenter),
                      if (data.featuredItems.isNotEmpty)
                        TvContentRow(title: 'Featured', items: data.featuredItems, onFocus: _scrollToCenter),
                    ],
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: 20,
            right: 40,
            child: TvTopBar(),
          ),
        ],
      ),
    );
  }
}

class TvHomeContentData {
  final List<MovieItem> heroItems;
  final List<MovieItem> featuredItems;
  final List<MovieItem> trendingMovies;
  final List<MovieItem> popularMovies;
  final List<MovieItem> popularSeries;
  final List<MovieItem> topRatedMovies;
  final List<MovieItem> upcomingMovies;
  final List<MovieItem> nowPlaying;

  TvHomeContentData({
    required this.heroItems,
    required this.featuredItems,
    required this.trendingMovies,
    required this.popularMovies,
    required this.popularSeries,
    required this.topRatedMovies,
    required this.upcomingMovies,
    required this.nowPlaying,
  });
}

class TvTopBar extends StatelessWidget {
  const TvTopBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TvIconButton(icon: Icons.search, onTap: () => Navigator.pushNamed(context, AppRoutes.search)),
        const SizedBox(width: 16),
        _TvIconButton(icon: Icons.notifications, onTap: () => Navigator.pushNamed(context, AppRoutes.notifications)),
        const SizedBox(width: 16),
        _TvIconButton(icon: Icons.settings, onTap: () => Navigator.pushNamed(context, AppRoutes.settings)),
        const SizedBox(width: 16),
        _TvProfileMenuButton(),
      ],
    );
  }
}

class _TvIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TvIconButton({required this.icon, required this.onTap});

  @override
  State<_TvIconButton> createState() => _TvIconButtonState();
}

class _TvIconButtonState extends State<_TvIconButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Semantics(
          button: true,
          focusable: true,
          label: 'Navigation Icon',
          onTap: widget.onTap,
          child: AnimatedScale(
            scale: _isFocused ? 1.08 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isFocused ? Colors.white : Colors.black45,
                shape: BoxShape.circle,
                boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)] : [],
              ),
              child: Icon(widget.icon, color: _isFocused ? Colors.black : Colors.white, size: 28),
            ),
          ),
        ),
      ),
    );
  }
}

class _TvProfileMenuButton extends StatefulWidget {
  @override
  State<_TvProfileMenuButton> createState() => _TvProfileMenuButtonState();
}

class _TvProfileMenuButtonState extends State<_TvProfileMenuButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: GestureDetector(
        onTap: () {
          // Open profile menu bottom sheet or dialog
          showDialog(context: context, builder: (_) => TvProfileMenu());
        },
        child: AnimatedScale(
          scale: _isFocused ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _isFocused ? Colors.white : Colors.black45,
              shape: BoxShape.circle,
              boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)] : [],
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class TvProfileMenu extends StatelessWidget {
  const TvProfileMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TvMenuButton(title: 'Continue Watching', onTap: () => Navigator.pop(context)),
              _TvMenuButton(title: 'Watchlist', onTap: () => Navigator.pop(context)),
              _TvMenuButton(title: 'Downloads', onTap: () => Navigator.pop(context)),
              _TvMenuButton(title: 'Jellyfin Settings', onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.adminJellyfin)),
              _TvMenuButton(title: 'Settings', onTap: () => Navigator.pop(context)),
              StreamBuilder<CurrentUserRole>(
              stream: UserRoleService.instance.watchCurrentUserRole(),
              builder: (context, roleSnapshot) {
                  if (roleSnapshot.hasData && roleSnapshot.data!.isAdmin) {
                    return _TvMenuButton(
                      title: 'Admin Panel',
                      onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.admin),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              _TvMenuButton(title: 'Logout', onTap: () async {
                await AuthService.instance.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _TvMenuButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  const _TvMenuButton({required this.title, required this.onTap});

  @override
  State<_TvMenuButton> createState() => _TvMenuButtonState();
}

class _TvMenuButtonState extends State<_TvMenuButton> {
  bool _isFocused = false;
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isFocused ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: _isFocused ? Colors.white : Colors.white10,
              borderRadius: BorderRadius.circular(8),
              boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)] : [],
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                color: _isFocused ? Colors.black : Colors.white,
                fontSize: 18,
                fontWeight: _isFocused ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TvHeroBanner extends StatefulWidget {
  final List<MovieItem> items;
  const TvHeroBanner({super.key, required this.items});

  @override
  State<TvHeroBanner> createState() => _TvHeroBannerState();
}

class _TvHeroBannerState extends State<TvHeroBanner> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (!_isFocused && widget.items.isNotEmpty) {
        _currentIndex = (_currentIndex + 1) % widget.items.length;
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox(height: 400);
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (focused) {
          _timer?.cancel();
        } else {
          _startTimer();
        }
      },
      child: SizedBox(
        height: 500,
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return Stack(
              fit: StackFit.expand,
              children: [
                NetworkArt(
                  url: item.backdropUrl.isNotEmpty ? item.backdropUrl : item.posterUrl,
                  fit: BoxFit.cover,
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
                  bottom: 60,
                  left: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text('${item.voteAverage.toStringAsFixed(1)} ★', style: const TextStyle(fontSize: 20, color: Colors.amber)),
                          const SizedBox(width: 16),
                          Text(item.releaseDate, style: const TextStyle(fontSize: 20, color: Colors.white70)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 600,
                        child: Text(
                          item.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _TvActionButton(title: 'Watch', icon: Icons.play_arrow, isPrimary: true, onTap: () => openDetailForItem(context, item)),
                          const SizedBox(width: 16),
                          _TvActionButton(title: 'Trailer', icon: Icons.videocam, onTap: () {}),
                          const SizedBox(width: 16),
                          _TvActionButton(title: 'Watchlist', icon: Icons.add, onTap: () {}),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TvActionButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _TvActionButton({required this.title, required this.icon, this.isPrimary = false, required this.onTap});

  @override
  State<_TvActionButton> createState() => _TvActionButtonState();
}

class _TvActionButtonState extends State<_TvActionButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isFocused ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: _isFocused ? Colors.white : (widget.isPrimary ? AppColors.primary : Colors.white24),
              borderRadius: BorderRadius.circular(8),
              boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)] : [],
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: _isFocused ? Colors.black : Colors.white),
                const SizedBox(width: 8),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: _isFocused ? Colors.black : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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

class TvContentRow extends StatelessWidget {
  final String title;
  final List<MovieItem> items;
  final void Function(BuildContext, MovieItem) onFocus;

  const TvContentRow({super.key, required this.title, required this.items, required this.onFocus});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60, bottom: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // ignore: deprecated_member_use
            cacheExtent: 1500, // Preload next 10 items
            padding: const EdgeInsets.symmetric(horizontal: 52),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return TvMoviePoster(item: items[index], onFocus: onFocus);
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class TvMoviePoster extends StatefulWidget {
  final MovieItem item;
  final void Function(BuildContext, MovieItem) onFocus;

  const TvMoviePoster({super.key, required this.item, required this.onFocus});

  @override
  State<TvMoviePoster> createState() => _TvMoviePosterState();
}

class _TvMoviePosterState extends State<TvMoviePoster> {
  bool _isFocused = false;
  Timer? _previewTimer;
  bool _isPreviewing = false; // Architecture for Auto Preview

  void _startPreviewTimer() {
    _previewTimer?.cancel();
    _previewTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _isFocused) {
        setState(() => _isPreviewing = true);
        // Future: Initialize video player and start muted trailer preview
      }
    });
  }

  void _cancelPreview() {
    _previewTimer?.cancel();
    if (_isPreviewing) {
      setState(() => _isPreviewing = false);
      // Future: Dispose or pause preview player
    }
  }

  @override
  void dispose() {
    _previewTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (focused) {
          widget.onFocus(context, widget.item);
          _startPreviewTimer();
        } else {
          _cancelPreview();
        }
      },
      child: GestureDetector(
        onTap: () => openDetailForItem(context, widget.item),
        child: Semantics(
          label: 'Movie Poster: ${widget.item.title}',
          button: true,
          focusable: true,
          focused: _isFocused,
          onTap: () => openDetailForItem(context, widget.item),
          child: AnimatedScale(
            scale: _isFocused ? 1.08 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isFocused ? Colors.white : Colors.transparent, width: 4),
                boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withValues(alpha: 0.6), blurRadius: 15, spreadRadius: 3)] : [],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'tv_poster_${widget.item.id}',
                      child: NetworkArt(
                        url: widget.item.posterUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (_isFocused)
                      Positioned(
                        bottom: 0, left: 0, right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.black87,
                          child: Text(
                            widget.item.title,
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TvContinueWatchingRow extends StatelessWidget {
  const TvContinueWatchingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Padding(
        padding: const EdgeInsets.only(left: 60, right: 60),
        child: const ContinueWatchingSection(),
      ),
    );
  }
}
