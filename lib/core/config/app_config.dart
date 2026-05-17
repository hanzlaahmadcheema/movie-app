import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  const AppConfig({
    required this.tmdbReadAccessToken,
    required this.tmdbBaseUrl,
    required this.tmdbImageBaseUrl,
  });

  factory AppConfig.fromEnv() {
    return AppConfig(
      tmdbReadAccessToken: dotenv.env['TMDB_READ_ACCESS_TOKEN']?.trim() ?? '',
      tmdbBaseUrl:
          dotenv.env['TMDB_BASE_URL']?.trim() ?? 'https://api.themoviedb.org/3',
      tmdbImageBaseUrl:
          dotenv.env['TMDB_IMAGE_BASE_URL']?.trim() ??
          'https://image.tmdb.org/t/p',
    );
  }

  final String tmdbReadAccessToken;
  final String tmdbBaseUrl;
  final String tmdbImageBaseUrl;

  bool get hasTmdbToken => tmdbReadAccessToken.isNotEmpty;

  String posterUrl(String? posterPath) => imageUrl('w500', posterPath);

  String backdropUrl(String? backdropPath) => imageUrl('w780', backdropPath);

  String imageUrl(String size, String? path) {
    if (path == null || path.isEmpty) {
      return '';
    }
    return '$tmdbImageBaseUrl/$size$path';
  }
}
