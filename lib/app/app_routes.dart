import 'package:flutter/material.dart';

import '../features/auth/auth_screens.dart';
import '../features/catalog/catalog_screens.dart';
import '../features/details/detail_screens.dart';
import '../features/home/home_screen.dart';
import '../features/search/search_screens.dart';
import '../features/watch/watch_screens.dart';
import '../core/models/movie_item.dart';

class AppRoutes {
  static const home = '/';
  static const movies = '/movies';
  static const series = '/series';
  static const movieDetail = '/movie-detail';
  static const seriesDetail = '/series-detail';
  static const castDetail = '/cast-detail';
  static const movieWatch = '/movie-watch';
  static const seriesWatch = '/series-watch';
  static const search = '/search';
  static const genre = '/genre';
  static const country = '/country';
  static const production = '/production';
  static const login = '/login';
  static const register = '/register';
  static const resetPassword = '/reset-password';
  static const snackbarStates = '/snackbars';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (_) => const HomeScreen(),
      movies: (_) => const CatalogScreen(kind: CatalogKind.movies),
      series: (_) => const CatalogScreen(kind: CatalogKind.series),
      castDetail: (_) => const CastDetailScreen(),
      movieWatch: (_) => const MovieWatchScreen(),
      seriesWatch: (_) => const SeriesWatchScreen(),
      search: (_) => const SearchResultScreen(title: 'searched keyword'),
      genre: (_) => const SearchResultScreen(title: 'Sci-Fi & Fantasy'),
      country: (_) => const SearchResultScreen(title: 'Pakistan'),
      production: (_) => const SearchResultScreen(title: 'Television 360'),
      login: (_) => const LoginScreen(),
      register: (_) => const RegisterScreen(),
      resetPassword: (_) => const ResetPasswordScreen(),
      snackbarStates: (_) => const SnackbarStatesScreen(),
    };
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final item = settings.arguments is MovieItem
        ? settings.arguments as MovieItem
        : null;

    return switch (settings.name) {
      movieDetail => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => MovieDetailScreen(item: item),
      ),
      seriesDetail => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => SeriesDetailScreen(item: item),
      ),
      _ => null,
    };
  }
}
