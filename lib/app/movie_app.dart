import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/navigation/app_navigation_observer.dart';
import 'app_routes.dart';
import 'app_theme.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key, this.navigationObserver});

  final AppNavigationObserver? navigationObserver;

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final AppNavigationObserver _navigationObserver =
      widget.navigationObserver ?? AppNavigationObserver();
  late final String _initialRoute = _resolveInitialRoute();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      debugPrint('MovieApp lifecycle: ${state.name}');
    }
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        unawaited(_navigationObserver.persistCurrentRoute());
        break;
      case AppLifecycleState.resumed:
        // Android can emit inactive/resumed for transient system UI such as the
        // notification shade. Resume must not navigate, remount MaterialApp, or
        // re-run splash/auth bootstrap; cold-start routing is handled only by
        // the initial splash route.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      debugPrint('MovieApp build');
    }
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'MovieApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      navigatorObservers: [_navigationObserver],
      initialRoute: _initialRoute,
      onGenerateInitialRoutes: _generateInitialRoutes,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }

  String _resolveInitialRoute() {
    final routeName = PlatformDispatcher.instance.defaultRouteName.trim();
    if (routeName.isEmpty || routeName == '/') {
      return AppRoutes.splash;
    }
    return routeName;
  }

  List<Route<dynamic>> _generateInitialRoutes(String initialRouteName) {
    final builder = AppRoutes.routes[initialRouteName];
    if (builder != null) {
      return [
        MaterialPageRoute<void>(
          settings: RouteSettings(name: initialRouteName),
          builder: builder,
        ),
      ];
    }
    return [AppRoutes.onGenerateRoute(RouteSettings(name: initialRouteName))];
  }
}
