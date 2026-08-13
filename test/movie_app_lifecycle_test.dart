import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/movie_app.dart';
import 'package:movie_app/core/navigation/app_navigation_observer.dart';
import 'package:movie_app/features/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _RecordingNavigationObserver extends AppNavigationObserver {
  int persistCalls = 0;
  final routeNames = <String>[];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeNames.add(route.settings.name ?? '');
    super.didPush(route, previousRoute);
  }

  @override
  Future<void> persistCurrentRoute() async {
    persistCalls += 1;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('notification shade lifecycle does not reopen splash', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final observer = _RecordingNavigationObserver();

    await tester.pumpWidget(MovieApp(navigationObserver: observer));
    await tester.pumpAndSettle();
    expect(find.byType(SplashScreen), findsNothing);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(milliseconds: 100));

    expect(observer.persistCalls, 1);
    expect(find.byType(SplashScreen), findsNothing);
  });

  testWidgets('paused lifecycle saves state without navigating', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final observer = _RecordingNavigationObserver();

    await tester.pumpWidget(MovieApp(navigationObserver: observer));
    await tester.pumpAndSettle();

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(milliseconds: 100));

    expect(observer.persistCalls, 5);
    expect(find.byType(SplashScreen), findsNothing);
  });
}
