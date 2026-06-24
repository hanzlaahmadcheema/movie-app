import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../app/app_routes.dart';
import '../auth/current_user_role.dart';
import '../config/app_config.dart';
import '../models/movie_item.dart';
import '../services/tmdb_repository.dart';
import 'watch_page_request.dart';

class NavigationRestoreTarget {
  const NavigationRestoreTarget({
    required this.route,
    this.arguments,
  });

  final String route;
  final Object? arguments;
}

class SavedNavigationState {
  const SavedNavigationState({
    required this.selectedBottomTab,
    required this.route,
    required this.routeArguments,
    required this.savedAt,
  });

  final String selectedBottomTab;
  final String route;
  final Map<String, dynamic> routeArguments;
  final DateTime savedAt;
}

class NavigationStateRepository {
  NavigationStateRepository({
    SharedPreferences? preferences,
    TmdbRepository Function()? tmdbRepositoryFactory,
    Future<MovieItem?> Function(int tmdbId)? movieLoader,
    Future<MovieItem?> Function(int tmdbId)? seriesLoader,
  }) : _preferencesOverride = preferences,
       _tmdbRepositoryFactory =
           tmdbRepositoryFactory ??
           (() => TmdbRepository(config: AppConfig.fromEnv())),
       _movieLoader = movieLoader,
       _seriesLoader = seriesLoader;

  static final NavigationStateRepository instance = NavigationStateRepository();

  static const _selectedBottomTabKey = 'nav_selected_bottom_tab';
  static const _routeKey = 'nav_last_route';
  static const _routeArgumentsKey = 'nav_last_route_args';
  static const _timestampKey = 'nav_last_route_timestamp';

  final SharedPreferences? _preferencesOverride;
  final TmdbRepository Function() _tmdbRepositoryFactory;
  final Future<MovieItem?> Function(int tmdbId)? _movieLoader;
  final Future<MovieItem?> Function(int tmdbId)? _seriesLoader;

  Future<SharedPreferences> get _prefs async =>
      _preferencesOverride ?? SharedPreferences.getInstance();

  static const Set<String> _bottomTabRoutes = {
    AppRoutes.home,
    AppRoutes.movies,
    AppRoutes.series,
    AppRoutes.search,
  };

  static const Set<String> _adminRoutes = {
    AppRoutes.admin,
    AppRoutes.adminFeatured,
    AppRoutes.adminBanners,
    AppRoutes.adminNotices,
    AppRoutes.adminProviders,
    AppRoutes.adminJellyfin,
    AppRoutes.adminUsers,
    AppRoutes.adminRequests,
    AppRoutes.adminPlaybackLogs,
    AppRoutes.adminAppConfig,
    AppRoutes.adminSecurity,
  };

  static const Set<String> _blockedRestoreRoutes = {
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.resetPassword,
    AppRoutes.phoneAuth,
    AppRoutes.splash,
    AppRoutes.streaming,
    AppRoutes.jellyfinNativePlayer,
    AppRoutes.jellyfinNativePlayerFullscreen,
    AppRoutes.jellyfinWebPlayer,
    AppRoutes.trailer,
  };

  Future<void> saveBottomTab(String route) async {
    if (!_bottomTabRoutes.contains(route)) {
      return;
    }
    final prefs = await _prefs;
    await prefs.setString(_selectedBottomTabKey, route);
  }

  Future<void> saveRouteState({
    required String route,
    Object? arguments,
  }) async {
    if (!_isRestorableRoute(route)) {
      return;
    }
    final encodedArguments = _encodeArguments(route, arguments);
    final prefs = await _prefs;
    await prefs.setString(_routeKey, route);
    await prefs.setString(_routeArgumentsKey, jsonEncode(encodedArguments));
    await prefs.setString(_timestampKey, DateTime.now().toIso8601String());
    if (_bottomTabRoutes.contains(route)) {
      await prefs.setString(_selectedBottomTabKey, route);
    }
  }

  Future<SavedNavigationState?> loadState() async {
    final prefs = await _prefs;
    final route = prefs.getString(_routeKey);
    if (route == null || route.trim().isEmpty) {
      return null;
    }
    final bottomTab = prefs.getString(_selectedBottomTabKey) ?? AppRoutes.home;
    final rawArgs = prefs.getString(_routeArgumentsKey);
    final rawTimestamp = prefs.getString(_timestampKey);
    Map<String, dynamic> routeArguments = const {};
    if (rawArgs != null && rawArgs.trim().isNotEmpty) {
      final decoded = jsonDecode(rawArgs);
      if (decoded is Map<String, dynamic>) {
        routeArguments = decoded;
      } else if (decoded is Map) {
        routeArguments = decoded.map(
          (key, value) => MapEntry(key.toString(), value),
        );
      }
    }
    return SavedNavigationState(
      selectedBottomTab: bottomTab,
      route: route,
      routeArguments: routeArguments,
      savedAt:
          DateTime.tryParse(rawTimestamp ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Future<void> clear() async {
    final prefs = await _prefs;
    await prefs.remove(_selectedBottomTabKey);
    await prefs.remove(_routeKey);
    await prefs.remove(_routeArgumentsKey);
    await prefs.remove(_timestampKey);
  }

  Future<NavigationRestoreTarget> buildRestoreTarget({
    required CurrentUserRole role,
  }) async {
    final state = await loadState();
    if (state == null) {
      return const NavigationRestoreTarget(route: AppRoutes.home);
    }
    final route = state.route;
    if (!_isRestorableRoute(route)) {
      return NavigationRestoreTarget(route: _fallbackRouteFor(state));
    }
    if (_adminRoutes.contains(route) && !role.isAdmin) {
      return NavigationRestoreTarget(route: _fallbackRouteFor(state));
    }
    if (route == AppRoutes.movieWatch || route == AppRoutes.seriesWatch) {
      final request = await _restoreWatchRequest(
        route: route,
        arguments: state.routeArguments,
      );
      if (request == null) {
        return NavigationRestoreTarget(route: _fallbackRouteFor(state));
      }
      return NavigationRestoreTarget(route: route, arguments: request);
    }
    return NavigationRestoreTarget(route: route);
  }

  bool canRestoreRoute(String route) => _isRestorableRoute(route);

  String fallbackRouteForState(SavedNavigationState? state) =>
      _fallbackRouteFor(state);

  bool _isRestorableRoute(String route) =>
      route.trim().isNotEmpty &&
      AppRoutes.allRoutes.contains(route) &&
      !_blockedRestoreRoutes.contains(route);

  String _fallbackRouteFor(SavedNavigationState? state) {
    return AppRoutes.home;
  }

  Map<String, dynamic> _encodeArguments(String route, Object? arguments) {
    if (route == AppRoutes.movieWatch || route == AppRoutes.seriesWatch) {
      final request = WatchPageRequest.fromRouteArguments(arguments);
      final item = request?.item;
      if (item == null || item.id <= 0) {
        return const {};
      }
      return {
        'tmdbId': item.id,
        'contentType': route == AppRoutes.seriesWatch ? 'series' : 'movie',
        'seasonNumber': request?.seasonNumber,
        'episodeNumber': request?.episodeNumber,
        'providerId': request?.selectedProviderId,
        'playbackMode': request?.playbackMode,
        'jellyfinItemId': request?.jellyfinItemId,
      };
    }
    return const {};
  }

  Future<WatchPageRequest?> _restoreWatchRequest({
    required String route,
    required Map<String, dynamic> arguments,
  }) async {
    final tmdbId = _toInt(arguments['tmdbId']);
    if (tmdbId == null || tmdbId <= 0) {
      return null;
    }
    final isSeries =
        (arguments['contentType'] ?? '').toString() == 'series' ||
        route == AppRoutes.seriesWatch;
    final item = isSeries
        ? await (_seriesLoader?.call(tmdbId) ??
            _tmdbRepositoryFactory().seriesById(tmdbId))
        : await (_movieLoader?.call(tmdbId) ??
            _tmdbRepositoryFactory().movieById(tmdbId));
    if (item == null || item.id <= 0) {
      return null;
    }
    return WatchPageRequest(
      item: item,
      seasonNumber: _toInt(arguments['seasonNumber']),
      episodeNumber: _toInt(arguments['episodeNumber']),
      autoPlay: true,
      selectedProviderId: _toTrimmed(arguments['providerId']),
      playbackMode: _toTrimmed(arguments['playbackMode']),
      jellyfinItemId: _toTrimmed(arguments['jellyfinItemId']),
    );
  }

  int? _toInt(Object? value) {
    return switch (value) {
      int number => number,
      num number => number.toInt(),
      _ => int.tryParse(value?.toString() ?? ''),
    };
  }

  String? _toTrimmed(Object? value) {
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? null : text;
  }
}
