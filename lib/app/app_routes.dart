import 'package:flutter/material.dart';

import '../features/account/account_screens.dart';
import '../features/admin/admin_screens.dart';
import '../features/auth/auth_screens.dart';
import '../features/catalog/catalog_screens.dart';
import '../features/details/detail_screens.dart';
import '../features/home/home_screen.dart';
import '../features/legal/legal_screens.dart';
import '../features/search/search_screens.dart';
import '../features/jellyfin/player/jellyfin_native_player_screen.dart';
import '../features/settings/jellyfin_login_screen.dart';
import '../features/settings/jellyfin_settings_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/streaming/presentation/streaming_player_screen.dart';
import '../features/trailer/trailer_player_screen.dart';
import '../features/watch/watch_screens.dart';
import '../core/models/movie_item.dart';
import '../core/auth/current_user_role.dart';
import '../core/auth/user_role_service.dart';
import '../core/navigation/watch_page_request.dart';
import '../core/config/app_config.dart';
import '../core/services/admin_repository.dart';
import '../core/services/auth_service.dart';
import '../core/services/tmdb_repository.dart';
import '../core/streaming/streaming_embed_request.dart';
import '../core/trailer/trailer_picker.dart';
import '../widgets/state_views.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/';
  static const movies = '/movies';
  static const series = '/series';
  static const tvSeries = '/tv-series';
  static const movieDetail = '/movie-detail';
  static const seriesDetail = '/series-detail';
  static const castDetail = '/cast-detail';
  static const movieWatch = '/movie-watch';
  static const seriesWatch = '/series-watch';
  static const watchMovies = '/watch-movies';
  static const watchSeries = '/watch-series';
  static const streaming = '/streaming';
  static const jellyfinNativePlayer = '/jellyfin-native-player';
  static const jellyfinNativePlayerFullscreen =
      '/jellyfin-native-player-fullscreen';
  static const jellyfinWebPlayer = '/jellyfin-web-player';
  static const trailer = '/trailer';
  static const search = '/search';
  static const genre = '/genre';
  static const country = '/country';
  static const production = '/production';
  static const topRated = '/top-rated';
  static const login = '/login';
  static const register = '/register';
  static const resetPassword = '/reset-password';
  static const verifyEmail = '/verify-email';
  static const phoneAuth = '/phone-auth';
  static const profile = '/profile';
  static const watchlist = '/watchlist';
  static const watched = '/watched';
  static const activity = '/activity';
  static const continueWatching = '/continue-watching';
  static const contact = '/contact';
  static const terms = '/terms';
  static const privacy = '/privacy';
  static const jellyfinSettings = '/jellyfin-settings';
  static const jellyfinLogin = '/jellyfin-login';
  static const admin = '/admin';
  static const adminFeatured = '/admin/featured';
  static const adminBanners = '/admin/banners';
  static const adminNotices = '/admin/notices';
  static const adminProviders = '/admin/providers';
  static const adminJellyfin = '/admin/jellyfin';
  static const adminUsers = '/admin/users';
  static const adminRequests = '/admin/requests';
  static const adminPlaybackLogs = '/admin/playback-logs';
  static const adminAppConfig = '/admin/app-config';
  static const adminSecurity = '/admin/security';
  static const supportRequest = '/support-request';

  static String detailPathForItem(MovieItem item) {
    return _isSeriesItem(item) ? '/series/${item.id}' : '/movie/${item.id}';
  }

  static String watchPathForItem(MovieItem item) {
    return _isSeriesItem(item)
        ? '/watch-series/${item.id}'
        : '/watch-movies/${item.id}';
  }

  static String watchPathForRequest(WatchPageRequest request) {
    final item = request.item;
    if (!_isSeriesItem(item)) {
      return '/watch-movies/${item.id}';
    }
    final season = request.seasonNumber;
    final episode = request.episodeNumber;
    if (season != null && episode != null) {
      return '/watch-series/${item.id}/$season/$episode';
    }
    return '/watch-series/${item.id}';
  }

  static bool _isSeriesItem(MovieItem item) {
    return item.mediaType == MediaType.tv ||
        item.type.toLowerCase().contains('series');
  }

  static final Set<String> allRoutes = {
    splash,
    home,
    movies,
    series,
    tvSeries,
    movieDetail,
    seriesDetail,
    castDetail,
    movieWatch,
    seriesWatch,
    watchMovies,
    watchSeries,
    streaming,
    jellyfinNativePlayer,
    jellyfinNativePlayerFullscreen,
    jellyfinWebPlayer,
    trailer,
    search,
    genre,
    country,
    production,
    topRated,
    login,
    register,
    resetPassword,
    verifyEmail,
    phoneAuth,
    profile,
    watchlist,
    watched,
    activity,
    continueWatching,
    contact,
    terms,
    privacy,
    jellyfinSettings,
    jellyfinLogin,
    admin,
    adminFeatured,
    adminBanners,
    adminNotices,
    adminProviders,
    adminJellyfin,
    adminUsers,
    adminRequests,
    adminPlaybackLogs,
    adminAppConfig,
    adminSecurity,
    supportRequest,
  };

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (_) => const SplashScreen(),
      home: (_) => _appScreen(const HomeScreen()),
      movies: (_) => _appScreen(const CatalogScreen(kind: CatalogKind.movies)),
      series: (_) => _appScreen(const CatalogScreen(kind: CatalogKind.series)),
      tvSeries: (_) =>
          _appScreen(const CatalogScreen(kind: CatalogKind.series)),
      login: (_) => const LoginScreen(),
      register: (_) =>
          _featureGate(child: const RegisterScreen(), requiresSignup: true),
      resetPassword: (_) => const ResetPasswordScreen(),
      verifyEmail: (_) => const VerifyEmailScreen(),
      phoneAuth: (_) => _featureGate(
        child: const PhoneAuthScreen(),
        requiresPhoneLogin: true,
      ),
      profile: (_) => _authenticated(const ProfileScreen()),
      watchlist: (_) => _authenticated(const WatchlistScreen()),
      watched: (_) => _authenticated(const WatchedScreen()),
      activity: (_) => _authenticated(const ActivityScreen()),
      continueWatching: (_) => _authenticated(const ContinueWatchingScreen()),
      contact: (_) => _appScreen(const ContactScreen()),
      terms: (_) => _appScreen(const TermsScreen()),
      privacy: (_) => _appScreen(const PrivacyScreen()),
      jellyfinSettings: (_) => _appScreen(const JellyfinSettingsScreen()),
      jellyfinLogin: (_) => const JellyfinLoginScreen(),
      supportRequest: (_) => _authenticated(const ContentRequestFormScreen()),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final uri = Uri.tryParse(settings.name ?? '');
    final path = uri?.path ?? settings.name;
    final pathSegments = uri?.pathSegments ?? const <String>[];
    final searchQuery = _searchQueryFromUri(uri);
    final item = settings.arguments is MovieItem
        ? settings.arguments as MovieItem
        : null;
    final watchRequest = WatchPageRequest.fromRouteArguments(
      settings.arguments,
    );

    if (path == search) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _appScreen(
          SearchResultScreen(
            title: 'Search',
            query: settings.arguments is String
                ? settings.arguments as String
                : searchQuery,
          ),
        ),
      );
    }

    if (_matchesIdRoute(pathSegments, 'watch-movies')) {
      if (_hasValidItem(watchRequest?.item)) {
        return _movieWatchRoute(settings, watchRequest);
      }
      final tmdbId = int.tryParse(pathSegments[1]);
      return _tmdbItemRoute(
        settings: settings,
        tmdbId: tmdbId,
        mediaType: MediaType.movie,
        destination: _TmdbRouteDestination.watch,
      );
    }

    if (_matchesSeriesWatchRoute(pathSegments)) {
      if (_hasValidItem(watchRequest?.item)) {
        return _seriesWatchRoute(settings, watchRequest);
      }
      final tmdbId = int.tryParse(pathSegments[1]);
      final seasonNumber = int.tryParse(pathSegments[2]);
      final episodeNumber = int.tryParse(pathSegments[3]);
      return _tmdbItemRoute(
        settings: settings,
        tmdbId: tmdbId,
        mediaType: MediaType.tv,
        destination: _TmdbRouteDestination.watch,
        seasonNumber: seasonNumber,
        episodeNumber: episodeNumber,
      );
    }

    if (_matchesIdRoute(pathSegments, 'movie')) {
      if (_hasValidItem(item)) {
        return _movieDetailRoute(settings, item);
      }
      return _tmdbItemRoute(
        settings: settings,
        tmdbId: int.tryParse(pathSegments[1]),
        mediaType: MediaType.movie,
        destination: _TmdbRouteDestination.detail,
      );
    }

    if (_matchesIdRoute(pathSegments, 'series') ||
        _matchesIdRoute(pathSegments, 'tv')) {
      if (_hasValidItem(item)) {
        return _seriesDetailRoute(settings, item);
      }
      return _tmdbItemRoute(
        settings: settings,
        tmdbId: int.tryParse(pathSegments[1]),
        mediaType: MediaType.tv,
        destination: _TmdbRouteDestination.detail,
      );
    }

    return switch (path) {
      movieDetail => _movieDetailRoute(settings, item),
      seriesDetail => _seriesDetailRoute(settings, item),
      movieWatch => _movieWatchRoute(settings, watchRequest),
      seriesWatch => _seriesWatchRoute(settings, watchRequest),
      streaming => _streamingRoute(settings),
      jellyfinNativePlayer => _jellyfinNativeRoute(settings),
      jellyfinNativePlayerFullscreen => _jellyfinNativeRoute(settings),
      jellyfinWebPlayer => _jellyfinWebRoute(settings),
      admin => _adminRoute(settings, const AdminDashboardScreen()),
      adminFeatured => _adminRoute(settings, const AdminFeaturedScreen()),
      adminBanners => _adminRoute(settings, const AdminBannersScreen()),
      adminNotices => _adminRoute(settings, const AdminNoticesScreen()),
      adminProviders => _adminRoute(settings, const AdminProvidersScreen()),
      adminJellyfin => _adminRoute(settings, const AdminJellyfinScreen()),
      adminUsers => _adminRoute(settings, const AdminUsersScreen()),
      adminRequests => _adminRoute(settings, const AdminRequestsScreen()),
      adminPlaybackLogs => _adminRoute(
        settings,
        const AdminPlaybackLogsScreen(),
      ),
      adminAppConfig => _adminRoute(settings, const AdminAppConfigScreen()),
      adminSecurity => _adminRoute(settings, const AdminSecurityScreen()),
      trailer => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) {
          final trailer = PlayableTrailer.fromRouteArguments(
            settings.arguments,
          );
          return trailer == null
              ? const InvalidRouteScreen(
                  message:
                      'Trailer route is missing a supported site or video key.',
                )
              : _appScreen(TrailerPlayerScreen(trailer: trailer));
        },
      ),
      castDetail => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) {
          final query = settings.arguments as String?;
          return query == null || query.trim().isEmpty
              ? const InvalidRouteScreen(
                  message: 'Cast detail requires a valid cast name.',
                )
              : _appScreen(CastDetailScreen(query: query));
        },
      ),
      genre => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _appScreen(
          const SearchResultScreen(title: 'Genres', mode: ExploreMode.genre),
        ),
      ),
      country => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _appScreen(
          const SearchResultScreen(
            title: 'Countries',
            mode: ExploreMode.country,
          ),
        ),
      ),
      production => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _appScreen(
          const SearchResultScreen(
            title: 'Production',
            mode: ExploreMode.production,
          ),
        ),
      ),
      topRated => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _appScreen(
          const SearchResultScreen(
            title: 'Top IMDb',
            mode: ExploreMode.topRated,
          ),
        ),
      ),
      _ => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => NotFoundScreen(routeName: settings.name),
      ),
    };
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => NotFoundScreen(routeName: settings.name),
    );
  }

  static bool _hasValidItem(MovieItem? item) => item != null && item.id > 0;

  static bool _matchesIdRoute(List<String> segments, String prefix) {
    return segments.length == 2 &&
        segments.first == prefix &&
        int.tryParse(segments[1]) != null;
  }

  static bool _matchesSeriesWatchRoute(List<String> segments) {
    return (segments.length == 2 || segments.length == 4) &&
        segments.first == 'watch-series' &&
        int.tryParse(segments[1]) != null &&
        (segments.length == 2 ||
            (int.tryParse(segments[2]) != null &&
                int.tryParse(segments[3]) != null));
  }

  static String? _searchQueryFromUri(Uri? uri) {
    if (uri == null || uri.path != search || uri.query.isEmpty) {
      return null;
    }
    final namedQuery =
        uri.queryParameters['q'] ??
        uri.queryParameters['query'] ??
        uri.queryParameters['s'];
    if (namedQuery != null && namedQuery.trim().isNotEmpty) {
      return namedQuery.trim();
    }
    return Uri.decodeQueryComponent(uri.query.replaceAll('+', ' ')).trim();
  }

  static Route<dynamic> _tmdbItemRoute({
    required RouteSettings settings,
    required int? tmdbId,
    required MediaType mediaType,
    required _TmdbRouteDestination destination,
    int? seasonNumber,
    int? episodeNumber,
  }) {
    if (tmdbId == null || tmdbId <= 0) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => InvalidRouteScreen(
          message: 'Route ${settings.name ?? ''} requires a valid TMDB ID.',
        ),
      );
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _appScreen(
        _TmdbItemRouteScreen(
          tmdbId: tmdbId,
          mediaType: mediaType,
          destination: destination,
          seasonNumber: seasonNumber,
          episodeNumber: episodeNumber,
        ),
      ),
    );
  }

  static Route<dynamic> _movieDetailRoute(
    RouteSettings settings,
    MovieItem? item,
  ) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _hasValidItem(item)
          ? _appScreen(MovieDetailScreen(item: item))
          : const InvalidRouteScreen(
              message: 'Movie detail requires a valid movie item.',
            ),
    );
  }

  static Route<dynamic> _seriesDetailRoute(
    RouteSettings settings,
    MovieItem? item,
  ) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _hasValidItem(item)
          ? _appScreen(SeriesDetailScreen(item: item))
          : const InvalidRouteScreen(
              message: 'Series detail requires a valid series item.',
            ),
    );
  }

  static Route<dynamic> _movieWatchRoute(
    RouteSettings settings,
    WatchPageRequest? request,
  ) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _hasValidItem(request?.item)
          ? _appScreen(MovieWatchScreen(request: request))
          : const InvalidRouteScreen(
              message: 'Movie watch requires a valid movie item.',
            ),
    );
  }

  static Route<dynamic> _seriesWatchRoute(
    RouteSettings settings,
    WatchPageRequest? request,
  ) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _hasValidItem(request?.item)
          ? _appScreen(SeriesWatchScreen(request: request))
          : const InvalidRouteScreen(
              message: 'Series watch requires a valid series item.',
            ),
    );
  }

  static Widget _authenticated(Widget child) {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      return const LoginScreen();
    }
    return _appScreen(child);
  }

  static Widget _appScreen(Widget child) {
    final user = AuthService.instance.currentUser;
    if (user != null && AuthService.instance.requiresEmailVerification(user)) {
      return const VerifyEmailScreen();
    }
    return _ProtectedAppScreen(child: child);
  }

  static Widget _featureGate({
    required Widget child,
    bool requiresSignup = false,
    bool requiresPhoneLogin = false,
  }) {
    return _PublicConfigGate(
      requiresSignup: requiresSignup,
      requiresPhoneLogin: requiresPhoneLogin,
      child: child,
    );
  }

  static Route<dynamic> _streamingRoute(RouteSettings settings) {
    final request = StreamingEmbedRequest.fromRouteArguments(
      settings.arguments,
    );
    final validationError = request == null
        ? 'Missing streaming request'
        : request.validate();
    if (validationError != null) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => InvalidRouteScreen(
          message: 'Streaming route is invalid: $validationError.',
        ),
      );
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _appScreen(StreamingPlayerScreen(request: request)),
    );
  }

  static Route<dynamic> _jellyfinNativeRoute(RouteSettings settings) {
    final request = JellyfinNativePlayerRequest.fromRouteArguments(
      settings.arguments,
    );
    if (request == null) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const InvalidRouteScreen(
          message: 'Native Jellyfin playback requires a valid item.',
        ),
      );
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _appScreen(JellyfinNativePlayerScreen(request: request)),
    );
  }

  static Route<dynamic> _jellyfinWebRoute(RouteSettings settings) {
    final request = StreamingEmbedRequest.fromRouteArguments(
      settings.arguments,
    )?.copyWith(jellyfinPlaybackModeOverride: 'web');
    final validationError = request == null
        ? 'Missing Jellyfin Web playback request'
        : request.validate();
    if (validationError != null) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => InvalidRouteScreen(
          message: 'Jellyfin Web route is invalid: $validationError.',
        ),
      );
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _appScreen(StreamingPlayerScreen(request: request)),
    );
  }

  static Route<dynamic> _adminRoute(RouteSettings settings, Widget child) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) {
        final user = AuthService.instance.currentUser;
        if (user == null) {
          return const LoginScreen();
        }
        if (AuthService.instance.requiresEmailVerification(user)) {
          return const VerifyEmailScreen();
        }
        return AdminRouteGate(child: child);
      },
    );
  }
}

class _ProtectedAppScreen extends StatelessWidget {
  const _ProtectedAppScreen({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppRemoteConfig>(
      future: AdminRepository.instance.loadPublicAppConfig(),
      builder: (context, configSnapshot) {
        if (!configSnapshot.hasData) {
          if (configSnapshot.hasError) {
            return child;
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final config = configSnapshot.data!;
        if (!config.maintenanceMode) {
          return child;
        }
        final user = AuthService.instance.currentUser;
        return FutureBuilder<CurrentUserRole>(
          future: UserRoleService.instance.loadRole(user),
          builder: (context, roleSnapshot) {
            if (!roleSnapshot.hasData) {
              if (roleSnapshot.hasError) {
                return child;
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            final role = roleSnapshot.data!;
            if (role.isAdmin) {
              return child;
            }
            return Scaffold(
              body: AppErrorView(
                title: 'Maintenance mode',
                message: config.maintenanceMessage.trim().isEmpty
                    ? 'The app is temporarily unavailable. Please try again later.'
                    : config.maintenanceMessage,
              ),
            );
          },
        );
      },
    );
  }
}

class _PublicConfigGate extends StatelessWidget {
  const _PublicConfigGate({
    required this.child,
    this.requiresSignup = false,
    this.requiresPhoneLogin = false,
  });

  final Widget child;
  final bool requiresSignup;
  final bool requiresPhoneLogin;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppRemoteConfig>(
      future: AdminRepository.instance.loadPublicAppConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          if (snapshot.hasError) {
            return child;
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final config = snapshot.data!;
        if (requiresSignup && !config.signupEnabled) {
          return const AccessDeniedScreen(
            message: 'New account creation is currently disabled.',
          );
        }
        if (requiresPhoneLogin && !config.phoneLoginEnabled) {
          return const AccessDeniedScreen(
            message: 'Phone login is currently unavailable.',
          );
        }
        return child;
      },
    );
  }
}

enum _TmdbRouteDestination { detail, watch }

class _TmdbItemRouteScreen extends StatefulWidget {
  const _TmdbItemRouteScreen({
    required this.tmdbId,
    required this.mediaType,
    required this.destination,
    this.seasonNumber,
    this.episodeNumber,
  });

  final int tmdbId;
  final MediaType mediaType;
  final _TmdbRouteDestination destination;
  final int? seasonNumber;
  final int? episodeNumber;

  @override
  State<_TmdbItemRouteScreen> createState() => _TmdbItemRouteScreenState();
}

class _TmdbItemRouteScreenState extends State<_TmdbItemRouteScreen> {
  late Future<MovieItem?> _itemFuture = _loadItem();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieItem?>(
      future: _itemFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return AppErrorView(
            title: 'Could not open title',
            message: snapshot.hasError
                ? userMessageForError(snapshot.error)
                : 'This TMDB title was not found.',
            onRetry: () => setState(() {
              _itemFuture = _loadItem();
            }),
          );
        }

        final item = snapshot.data!;
        if (widget.destination == _TmdbRouteDestination.detail) {
          return widget.mediaType == MediaType.tv
              ? SeriesDetailScreen(item: item)
              : MovieDetailScreen(item: item);
        }

        final request = WatchPageRequest(
          item: item,
          seasonNumber: widget.seasonNumber,
          episodeNumber: widget.episodeNumber,
          autoPlay: widget.mediaType != MediaType.tv ||
              (widget.seasonNumber != null && widget.episodeNumber != null),
        );
        return widget.mediaType == MediaType.tv
            ? SeriesWatchScreen(request: request)
            : MovieWatchScreen(request: request);
      },
    );
  }

  Future<MovieItem?> _loadItem() {
    final repository = TmdbRepository(config: AppConfig.fromEnv());
    return widget.mediaType == MediaType.tv
        ? repository.seriesById(widget.tmdbId)
        : repository.movieById(widget.tmdbId);
  }
}
