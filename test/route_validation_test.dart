import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/app_routes.dart';
import 'package:movie_app/widgets/state_views.dart';

void main() {
  testWidgets('unknown route returns NotFoundScreen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        onUnknownRoute: AppRoutes.onUnknownRoute,
        initialRoute: '/missing',
      ),
    );

    await tester.pump();

    expect(find.byType(NotFoundScreen), findsOneWidget);
    expect(find.text('Page not found'), findsOneWidget);
  });

  testWidgets('movie detail missing item returns InvalidRouteScreen', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.movieDetail,
      ),
    );

    await tester.pump();

    expect(find.byType(InvalidRouteScreen), findsOneWidget);
    expect(find.text('Invalid route'), findsOneWidget);
  });

  testWidgets('trailer missing key returns InvalidRouteScreen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.trailer,
      ),
    );

    await tester.pump();

    expect(find.byType(InvalidRouteScreen), findsOneWidget);
  });

  testWidgets(
    'Jellyfin native player missing item returns InvalidRouteScreen',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: AppRoutes.jellyfinNativePlayer,
        ),
      );

      await tester.pump();

      expect(find.byType(InvalidRouteScreen), findsOneWidget);
      expect(find.text('Invalid route'), findsOneWidget);
    },
  );

  testWidgets(
    'Jellyfin fullscreen player missing item returns InvalidRouteScreen',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: AppRoutes.jellyfinNativePlayerFullscreen,
        ),
      );

      await tester.pump();

      expect(find.byType(InvalidRouteScreen), findsOneWidget);
      expect(find.text('Invalid route'), findsOneWidget);
    },
  );

  testWidgets('Jellyfin login route renders', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.jellyfinLogin,
      ),
    );

    await tester.pump();

    expect(find.text('Login to Jellyfin'), findsOneWidget);
  });
}
