import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  const AppConfig({
    required this.tmdbReadAccessToken,
    required this.tmdbImageBaseUrl,
    required this.streamingVidSrcDomains,
    required this.streamingVidSrcEnabled,
    required this.streamingTwoEmbedDomains,
    required this.streamingTwoEmbedEnabled,
    required this.streamingTwoEmbedMovieTemplate,
    required this.streamingTwoEmbedEpisodeTemplate,
    required this.streamingAllowedHosts,
    required this.streamingTimeoutSeconds,
  });

  factory AppConfig.fromEnv() {
    const tmdbReadAccessToken = String.fromEnvironment(
      'TMDB_READ_ACCESS_TOKEN',
    );

    return AppConfig(
      tmdbReadAccessToken: _firstNonEmpty(
        tmdbReadAccessToken,
        dotenv.env['TMDB_READ_ACCESS_TOKEN'],
      ),
      tmdbImageBaseUrl:
          dotenv.env['TMDB_IMAGE_BASE_URL']?.trim() ??
          'https://image.tmdb.org/t/p',
      streamingVidSrcDomains: _csv(
        dotenv.env['STREAMING_VIDSRC_DOMAINS'],
        fallback:
            'https://vidsrcme.su,https://vsembed.ru,https://vidsrc-embed.ru,'
            'https://vidsrc-embed.su,https://vsrc.su',
      ),
      streamingVidSrcEnabled: _bool(
        dotenv.env['STREAMING_VIDSRC_ENABLED'],
        fallback: true,
      ),
      streamingTwoEmbedDomains: _csv(
        dotenv.env['STREAMING_2EMBED_DOMAINS'],
        fallback: 'https://www.2embed.cc,https://www.2embed.skin',
      ),
      streamingTwoEmbedEnabled: _bool(
        dotenv.env['STREAMING_2EMBED_ENABLED'],
        fallback: true,
      ),
      streamingTwoEmbedMovieTemplate:
          dotenv.env['STREAMING_2EMBED_MOVIE_TEMPLATE']?.trim() ??
          '{domain}/embed/{id}',
      streamingTwoEmbedEpisodeTemplate:
          dotenv.env['STREAMING_2EMBED_EPISODE_TEMPLATE']?.trim() ??
          '{domain}/embedtv/{id}&s={season}&e={episode}',
      streamingAllowedHosts: _csv(dotenv.env['STREAMING_ALLOWED_HOSTS']),
      streamingTimeoutSeconds: _positiveInt(
        dotenv.env['STREAMING_TIMEOUT_SECONDS'],
        fallback: 18,
      ),
    );
  }

  final String tmdbReadAccessToken;
  final String tmdbImageBaseUrl;
  final List<String> streamingVidSrcDomains;
  final bool streamingVidSrcEnabled;
  final List<String> streamingTwoEmbedDomains;
  final bool streamingTwoEmbedEnabled;
  final String streamingTwoEmbedMovieTemplate;
  final String streamingTwoEmbedEpisodeTemplate;
  final List<String> streamingAllowedHosts;
  final int streamingTimeoutSeconds;

  bool get hasTmdbReadAccessToken => tmdbReadAccessToken.isNotEmpty;

  String posterUrl(String? posterPath) => imageUrl('original', posterPath);

  String backdropUrl(String? backdropPath) =>
      imageUrl('original', backdropPath);

  String imageUrl(String size, String? path) {
    if (path == null || path.isEmpty) {
      return '';
    }
    return '$tmdbImageBaseUrl/$size$path';
  }
}

String _firstNonEmpty(String first, String? second, {String fallback = ''}) {
  final trimmedFirst = first.trim();
  if (trimmedFirst.isNotEmpty) {
    return trimmedFirst;
  }
  final trimmedSecond = second?.trim() ?? '';
  if (trimmedSecond.isNotEmpty) {
    return trimmedSecond;
  }
  return fallback;
}

List<String> _csv(String? value, {String fallback = ''}) {
  final source = value?.trim().isNotEmpty == true ? value!.trim() : fallback;
  return source
      .split(',')
      .map((entry) => entry.trim())
      .where((entry) => entry.isNotEmpty)
      .toList(growable: false);
}

int _positiveInt(String? value, {required int fallback}) {
  final parsed = int.tryParse(value?.trim() ?? '');
  return parsed != null && parsed > 0 ? parsed : fallback;
}

bool _bool(String? value, {required bool fallback}) {
  return switch (value?.trim().toLowerCase()) {
    'true' || '1' || 'yes' => true,
    'false' || '0' || 'no' => false,
    _ => fallback,
  };
}
