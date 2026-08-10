import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/app_routes.dart';
import 'package:movie_app/core/auth/current_user_role.dart';
import 'package:movie_app/core/models/movie_item.dart';
import 'package:movie_app/core/navigation/navigation_state_repository.dart';
import 'package:movie_app/core/navigation/watch_page_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const movie = MovieItem(
    id: 101,
    title: 'Movie',
    type: 'Movie',
    year: '2026',
    quality: 'HD',
    posterUrl: 'poster',
  );

  const series = MovieItem(
    id: 202,
    title: 'Series',
    type: 'Series',
    year: '2026',
    quality: 'HD',
    posterUrl: 'poster',
    mediaType: MediaType.tv,
  );

  Future<NavigationStateRepository> createRepository() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    return NavigationStateRepository(
      preferences: prefs,
      movieLoader: (tmdbId) async => tmdbId == movie.id ? movie : null,
      seriesLoader: (tmdbId) async => tmdbId == series.id ? series : null,
    );
  }

  test('selected bottom tab route restores', () async {
    final repository = await createRepository();

    await repository.saveBottomTab(AppRoutes.movies);
    await repository.saveRouteState(route: AppRoutes.movies);
    final target = await repository.buildRestoreTarget(
      role: const CurrentUserRole.signedOut()
          .copyWithForTest(uid: 'u1', role: UserRoleValue.user),
    );

    expect(target.route, AppRoutes.movies);
    expect(target.arguments, isNull);
  });

  test('movie watch page restores', () async {
    final repository = await createRepository();

    await repository.saveRouteState(
      route: AppRoutes.movieWatch,
      arguments: const WatchPageRequest(
        item: movie,
        selectedProviderId: 'vidsrc',
      ),
    );
    final target = await repository.buildRestoreTarget(
      role: const CurrentUserRole.signedOut()
          .copyWithForTest(uid: 'u1', role: UserRoleValue.user),
    );

    expect(target.route, AppRoutes.movieWatch);
    final request = target.arguments as WatchPageRequest;
    expect(request.item.id, movie.id);
    expect(request.selectedProviderId, 'vidsrc');
    expect(request.autoPlay, isTrue);
  });

  test('exact episode watch page restores', () async {
    final repository = await createRepository();

    await repository.saveRouteState(
      route: AppRoutes.seriesWatch,
      arguments: const WatchPageRequest(
        item: series,
        seasonNumber: 3,
        episodeNumber: 7,
        selectedProviderId: 'jellyfin_native',
        playbackMode: 'native',
        jellyfinItemId: 'jf-7',
      ),
    );
    final target = await repository.buildRestoreTarget(
      role: const CurrentUserRole.signedOut()
          .copyWithForTest(uid: 'u1', role: UserRoleValue.user),
    );

    expect(target.route, AppRoutes.seriesWatch);
    final request = target.arguments as WatchPageRequest;
    expect(request.item.id, series.id);
    expect(request.seasonNumber, 3);
    expect(request.episodeNumber, 7);
    expect(request.selectedProviderId, 'jellyfin_native');
    expect(request.playbackMode, 'native');
    expect(request.jellyfinItemId, 'jf-7');
  });

  test('admin page restores only for admin', () async {
    final repository = await createRepository();

    await repository.saveRouteState(route: AppRoutes.admin);
    final target = await repository.buildRestoreTarget(
      role: const CurrentUserRole(
        uid: 'admin-1',
        role: UserRoleValue.admin,
        status: UserAccountStatus.active,
        isVerified: true,
      ),
    );

    expect(target.route, AppRoutes.admin);
  });

  test('admin route falls back home for normal user', () async {
    final repository = await createRepository();

    await repository.saveRouteState(route: AppRoutes.admin);
    final target = await repository.buildRestoreTarget(
      role: const CurrentUserRole(
        uid: 'user-1',
        role: UserRoleValue.user,
        status: UserAccountStatus.active,
        isVerified: true,
      ),
    );

    expect(target.route, AppRoutes.home);
  });

  test('invalid saved route falls back home', () async {
    SharedPreferences.setMockInitialValues({
      'nav_last_route': '/old-route',
      'nav_last_route_args': '{}',
      'nav_last_route_timestamp': DateTime.now().toIso8601String(),
      'nav_selected_bottom_tab': AppRoutes.series,
    });
    final prefs = await SharedPreferences.getInstance();
    final repository = NavigationStateRepository(
      preferences: prefs,
      movieLoader: (tmdbId) async => null,
      seriesLoader: (tmdbId) async => null,
    );

    final target = await repository.buildRestoreTarget(
      role: const CurrentUserRole(
        uid: 'user-1',
        role: UserRoleValue.user,
        status: UserAccountStatus.active,
        isVerified: true,
      ),
    );

    expect(target.route, AppRoutes.home);
  });

  test('fullscreen and raw player routes are not restored', () async {
    SharedPreferences.setMockInitialValues({
      'nav_last_route': AppRoutes.jellyfinNativePlayerFullscreen,
      'nav_last_route_args': '{}',
      'nav_last_route_timestamp': DateTime.now().toIso8601String(),
      'nav_selected_bottom_tab': AppRoutes.home,
    });
    var prefs = await SharedPreferences.getInstance();
    var repository = NavigationStateRepository(
      preferences: prefs,
      movieLoader: (tmdbId) async => null,
      seriesLoader: (tmdbId) async => null,
    );

    var target = await repository.buildRestoreTarget(
      role: const CurrentUserRole(
        uid: 'user-1',
        role: UserRoleValue.user,
        status: UserAccountStatus.active,
        isVerified: true,
      ),
    );
    expect(target.route, AppRoutes.home);

    SharedPreferences.setMockInitialValues({
      'nav_last_route': AppRoutes.streaming,
      'nav_last_route_args': '{}',
      'nav_last_route_timestamp': DateTime.now().toIso8601String(),
      'nav_selected_bottom_tab': AppRoutes.home,
    });
    prefs = await SharedPreferences.getInstance();
    repository = NavigationStateRepository(
      preferences: prefs,
      movieLoader: (tmdbId) async => null,
      seriesLoader: (tmdbId) async => null,
    );
    target = await repository.buildRestoreTarget(
      role: const CurrentUserRole(
        uid: 'user-1',
        role: UserRoleValue.user,
        status: UserAccountStatus.active,
        isVerified: true,
      ),
    );
    expect(target.route, AppRoutes.home);
  });
}

extension on CurrentUserRole {
  CurrentUserRole copyWithForTest({
    required String uid,
    required UserRoleValue role,
  }) {
    return CurrentUserRole(
      uid: uid,
      role: role,
      status: UserAccountStatus.active,
      isVerified: true,
    );
  }
}
