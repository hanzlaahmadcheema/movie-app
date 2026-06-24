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
import '../core/services/admin_repository.dart';
import '../core/services/auth_service.dart';
import '../core/streaming/streaming_embed_request.dart';
import '../core/trailer/trailer_picker.dart';
import '../widgets/state_views.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/';
  static const movies = '/movies';
  static const series = '/series';
  static const movieDetail = '/movie-detail';
  static const seriesDetail = '/series-detail';
  static const castDetail = '/cast-detail';
  static const movieWatch = '/movie-watch';
  static const seriesWatch = '/series-watch';
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
  static const login = '/login';
  static const register = '/register';
  static const resetPassword = '/reset-password';
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

  static final Set<String> allRoutes = {
    splash,
    home,
    movies,
    series,
    movieDetail,
    seriesDetail,
    castDetail,
    movieWatch,
    seriesWatch,
    streaming,
    jellyfinNativePlayer,
    jellyfinNativePlayerFullscreen,
    jellyfinWebPlayer,
    trailer,
    search,
    genre,
    country,
    production,
    login,
    register,
    resetPassword,
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
      home: (_) => _protected(const HomeScreen()),
      movies: (_) => _protected(const CatalogScreen(kind: CatalogKind.movies)),
      series: (_) => _protected(const CatalogScreen(kind: CatalogKind.series)),
      login: (_) => const LoginScreen(),
      register: (_) =>
          _featureGate(child: const RegisterScreen(), requiresSignup: true),
      resetPassword: (_) => const ResetPasswordScreen(),
      phoneAuth: (_) => _featureGate(
        child: const PhoneAuthScreen(),
        requiresPhoneLogin: true,
      ),
      profile: (_) => _protected(const ProfileScreen()),
      watchlist: (_) => _protected(const WatchlistScreen()),
      watched: (_) => _protected(const WatchedScreen()),
      activity: (_) => _protected(const ActivityScreen()),
      continueWatching: (_) => _protected(const ContinueWatchingScreen()),
      contact: (_) => _protected(const ContactScreen()),
      terms: (_) => _protected(const TermsScreen()),
      privacy: (_) => _protected(const PrivacyScreen()),
      jellyfinSettings: (_) => _protected(const JellyfinSettingsScreen()),
      jellyfinLogin: (_) => const JellyfinLoginScreen(),
      supportRequest: (_) => _protected(const ContentRequestFormScreen()),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final item = settings.arguments is MovieItem
        ? settings.arguments as MovieItem
        : null;
    final watchRequest = WatchPageRequest.fromRouteArguments(
      settings.arguments,
    );

    return switch (settings.name) {
      movieDetail => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _hasValidItem(item)
            ? _protected(MovieDetailScreen(item: item))
            : const InvalidRouteScreen(
                message: 'Movie detail requires a valid movie item.',
              ),
      ),
      seriesDetail => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _hasValidItem(item)
            ? _protected(SeriesDetailScreen(item: item))
            : const InvalidRouteScreen(
                message: 'Series detail requires a valid series item.',
              ),
      ),
      movieWatch => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _hasValidItem(watchRequest?.item)
            ? _protected(MovieWatchScreen(request: watchRequest))
            : const InvalidRouteScreen(
                message: 'Movie watch requires a valid movie item.',
              ),
      ),
      seriesWatch => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _hasValidItem(watchRequest?.item)
            ? _protected(SeriesWatchScreen(request: watchRequest))
            : const InvalidRouteScreen(
                message: 'Series watch requires a valid series item.',
              ),
      ),
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
              : _protected(TrailerPlayerScreen(trailer: trailer));
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
              : _protected(CastDetailScreen(query: query));
        },
      ),
      search => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _protected(const SearchResultScreen(title: 'Search')),
      ),
      genre => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _protected(
          const SearchResultScreen(title: 'Genres', mode: ExploreMode.genre),
        ),
      ),
      country => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _protected(
          const SearchResultScreen(
            title: 'Countries',
            mode: ExploreMode.country,
          ),
        ),
      ),
      production => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _protected(
          const SearchResultScreen(
            title: 'Production',
            mode: ExploreMode.production,
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

  static Widget _protected(Widget child) {
    return AuthService.instance.currentUser == null
        ? const LoginScreen()
        : _ProtectedAppScreen(child: child);
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
      builder: (_) => _protected(StreamingPlayerScreen(request: request)),
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
      builder: (_) => _protected(JellyfinNativePlayerScreen(request: request)),
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
      builder: (_) => _protected(StreamingPlayerScreen(request: request)),
    );
  }

  static Route<dynamic> _adminRoute(RouteSettings settings, Widget child) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => AuthService.instance.currentUser == null
          ? const LoginScreen()
          : AdminRouteGate(child: child),
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
