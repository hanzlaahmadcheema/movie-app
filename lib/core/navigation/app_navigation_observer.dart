import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'navigation_state_repository.dart';

class AppNavigationObserver extends NavigatorObserver {
  AppNavigationObserver({NavigationStateRepository? repository})
    : _repository = repository ?? NavigationStateRepository.instance;

  final NavigationStateRepository _repository;
  RouteSettings? _currentSettings;

  RouteSettings? get currentSettings => _currentSettings;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _updateCurrent(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _updateCurrent(previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _updateCurrent(newRoute);
    }
  }

  Future<void> persistCurrentRoute() async {
    final settings = _currentSettings;
    final routeName = settings?.name;
    if (routeName == null || routeName.trim().isEmpty) {
      return;
    }
    if (kDebugMode) {
      debugPrint('Navigation persist current route: $routeName');
    }
    await _repository.saveRouteState(
      route: routeName,
      arguments: settings?.arguments,
    );
  }

  void _updateCurrent(Route<dynamic> route) {
    if (route is! PageRoute<dynamic>) {
      return;
    }
    final settings = route.settings;
    final routeName = settings.name;
    if (routeName == null || routeName.trim().isEmpty) {
      return;
    }
    _currentSettings = settings;
    if (kDebugMode) {
      debugPrint('Navigation current route: $routeName');
    }
    unawaited(
      _repository.saveRouteState(
        route: routeName,
        arguments: settings.arguments,
      ),
    );
  }
}
