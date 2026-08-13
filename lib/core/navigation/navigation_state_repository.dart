import 'package:shared_preferences/shared_preferences.dart';

import '../../app/app_routes.dart';
import '../auth/current_user_role.dart';

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
  }) : _preferencesOverride = preferences;

  static final NavigationStateRepository instance = NavigationStateRepository();

  static const _selectedBottomTabKey = 'nav_selected_bottom_tab';
  static const _routeKey = 'nav_last_route';
  static const _routeArgumentsKey = 'nav_last_route_args';
  static const _timestampKey = 'nav_last_route_timestamp';

  final SharedPreferences? _preferencesOverride;

  Future<SharedPreferences> get _prefs async =>
      _preferencesOverride ?? SharedPreferences.getInstance();

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

  Future<void> saveBottomTab(String route) async {}

  Future<void> saveRouteState({
    required String route,
    Object? arguments,
  }) async {}

  Future<SavedNavigationState?> loadState() async {
    return null;
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
    await clear();
    return const NavigationRestoreTarget(route: AppRoutes.home);
  }

  bool canRestoreRoute(String route) => _isRestorableRoute(route);

  String fallbackRouteForState(SavedNavigationState? state) => AppRoutes.home;

  bool _isRestorableRoute(String route) =>
      route.trim().isNotEmpty &&
      AppRoutes.allRoutes.contains(route) &&
      !_blockedRestoreRoutes.contains(route);
}
