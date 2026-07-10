import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  const AppConfig({
    required this.tmdbReadAccessToken,
    required this.tmdbImageBaseUrl,
    required this.streamingVideasyDomains,
    required this.streamingVideasyEnabled,
    required this.streamingVideasyMovieTemplate,
    required this.streamingVideasyEpisodeTemplate,
    required this.streamingStreamVaultDomains,
    required this.streamingStreamVaultEnabled,
    required this.streamingStreamVaultMovieTemplate,
    required this.streamingStreamVaultEpisodeTemplate,
    required this.streamingOneElevenMoviesDomains,
    required this.streamingOneElevenMoviesEnabled,
    required this.streamingOneElevenMoviesMovieTemplate,
    required this.streamingOneElevenMoviesEpisodeTemplate,
    required this.streamingVidKingDomains,
    required this.streamingVidKingEnabled,
    required this.streamingVidKingMovieTemplate,
    required this.streamingVidKingEpisodeTemplate,
    required this.streamingHindiPlayerDomains,
    required this.streamingHindiPlayerEnabled,
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
        _dotenvValue('TMDB_READ_ACCESS_TOKEN'),
      ),
      tmdbImageBaseUrl:
          _dotenvValue('TMDB_IMAGE_BASE_URL')?.trim() ??
          'https://image.tmdb.org/t/p',
      streamingVideasyDomains: _csv(
        _dotenvValue('STREAMING_VIDEASY_DOMAINS'),
        fallback: 'https://player.videasy.to,https://player.videasy.net',
      ),
      streamingVideasyEnabled: _bool(
        _dotenvValue('STREAMING_VIDEASY_ENABLED'),
        fallback: true,
      ),
      streamingVideasyMovieTemplate:
          _dotenvValue('STREAMING_VIDEASY_MOVIE_TEMPLATE')?.trim() ??
          '{domain}/movie/{id}',
      streamingVideasyEpisodeTemplate:
          _dotenvValue('STREAMING_VIDEASY_EPISODE_TEMPLATE')?.trim() ??
          '{domain}/tv/{id}/{season}/{episode}',
      streamingStreamVaultDomains: _csv(
        _dotenvValue('STREAMING_STREAMVAULT_DOMAINS'),
        fallback: 'https://streamvaultsrc.click',
      ),
      streamingStreamVaultEnabled: _bool(
        _dotenvValue('STREAMING_STREAMVAULT_ENABLED'),
        fallback: true,
      ),
      streamingStreamVaultMovieTemplate:
          _dotenvValue('STREAMING_STREAMVAULT_MOVIE_TEMPLATE')?.trim() ??
          '{domain}/embed/movie/{id}',
      streamingStreamVaultEpisodeTemplate:
          _dotenvValue('STREAMING_STREAMVAULT_EPISODE_TEMPLATE')?.trim() ??
          '{domain}/embed/tv/{id}/{season}/{episode}',
      streamingOneElevenMoviesDomains: _csv(
        _dotenvValue('STREAMING_111MOVIES_DOMAINS'),
        fallback: 'https://111movies.net',
      ),
      streamingOneElevenMoviesEnabled: _bool(
        _dotenvValue('STREAMING_111MOVIES_ENABLED'),
        fallback: true,
      ),
      streamingOneElevenMoviesMovieTemplate:
          _dotenvValue('STREAMING_111MOVIES_MOVIE_TEMPLATE')?.trim() ??
          '{domain}/movie/{id}',
      streamingOneElevenMoviesEpisodeTemplate:
          _dotenvValue('STREAMING_111MOVIES_EPISODE_TEMPLATE')?.trim() ??
          '{domain}/tv/{id}/{season}/{episode}',
      streamingVidKingDomains: _csv(
        _dotenvValue('STREAMING_VIDKING_DOMAINS'),
        fallback: 'https://www.vidking.net',
      ),
      streamingVidKingEnabled: _bool(
        _dotenvValue('STREAMING_VIDKING_ENABLED'),
        fallback: true,
      ),
      streamingVidKingMovieTemplate:
          _dotenvValue('STREAMING_VIDKING_MOVIE_TEMPLATE')?.trim() ??
          '{domain}/embed/movie/{id}',
      streamingVidKingEpisodeTemplate:
          _dotenvValue('STREAMING_VIDKING_EPISODE_TEMPLATE')?.trim() ??
          '{domain}/embed/tv/{id}/{season}/{episode}',
      streamingHindiPlayerDomains: _csv(
        _dotenvValue('STREAMING_HINDI_PLAYER_DOMAINS'),
        fallback: 'https://allmovieland.link,https://gemma416okl.com',
      ),
      streamingHindiPlayerEnabled: _bool(
        _dotenvValue('STREAMING_HINDI_PLAYER_ENABLED'),
        fallback: true,
      ),
      streamingVidSrcDomains: _csv(
        _dotenvValue('STREAMING_VIDSRC_DOMAINS'),
        fallback:
            'https://vidsrcme.su,https://vsembed.ru,https://vidsrc-embed.ru,'
            'https://vidsrc-embed.su,https://vsrc.su',
      ),
      streamingVidSrcEnabled: _bool(
        _dotenvValue('STREAMING_VIDSRC_ENABLED'),
        fallback: true,
      ),
      streamingTwoEmbedDomains: _csv(
        _dotenvValue('STREAMING_2EMBED_DOMAINS'),
        fallback: 'https://www.2embed.cc,https://www.2embed.skin',
      ),
      streamingTwoEmbedEnabled: _bool(
        _dotenvValue('STREAMING_2EMBED_ENABLED'),
        fallback: true,
      ),
      streamingTwoEmbedMovieTemplate:
          _dotenvValue('STREAMING_2EMBED_MOVIE_TEMPLATE')?.trim() ??
          '{domain}/embed/{id}',
      streamingTwoEmbedEpisodeTemplate:
          _dotenvValue('STREAMING_2EMBED_EPISODE_TEMPLATE')?.trim() ??
          '{domain}/embedtv/{id}&s={season}&e={episode}',
      streamingAllowedHosts: _csv(_dotenvValue('STREAMING_ALLOWED_HOSTS')),
      streamingTimeoutSeconds: _positiveInt(
        _dotenvValue('STREAMING_TIMEOUT_SECONDS'),
        fallback: 18,
      ),
    );
  }

  final String tmdbReadAccessToken;
  final String tmdbImageBaseUrl;
  final List<String> streamingVideasyDomains;
  final bool streamingVideasyEnabled;
  final String streamingVideasyMovieTemplate;
  final String streamingVideasyEpisodeTemplate;
  final List<String> streamingStreamVaultDomains;
  final bool streamingStreamVaultEnabled;
  final String streamingStreamVaultMovieTemplate;
  final String streamingStreamVaultEpisodeTemplate;
  final List<String> streamingOneElevenMoviesDomains;
  final bool streamingOneElevenMoviesEnabled;
  final String streamingOneElevenMoviesMovieTemplate;
  final String streamingOneElevenMoviesEpisodeTemplate;
  final List<String> streamingVidKingDomains;
  final bool streamingVidKingEnabled;
  final String streamingVidKingMovieTemplate;
  final String streamingVidKingEpisodeTemplate;
  final List<String> streamingHindiPlayerDomains;
  final bool streamingHindiPlayerEnabled;
  final List<String> streamingVidSrcDomains;
  final bool streamingVidSrcEnabled;
  final List<String> streamingTwoEmbedDomains;
  final bool streamingTwoEmbedEnabled;
  final String streamingTwoEmbedMovieTemplate;
  final String streamingTwoEmbedEpisodeTemplate;
  final List<String> streamingAllowedHosts;
  final int streamingTimeoutSeconds;

  bool get hasTmdbReadAccessToken => tmdbReadAccessToken.isNotEmpty;

  String posterUrl(String? posterPath) => imageUrl('w500', posterPath);

  String backdropUrl(String? backdropPath) => imageUrl('w1280', backdropPath);

  String imageUrl(String size, String? path) {
    if (path == null || path.isEmpty) {
      return '';
    }
    return '$tmdbImageBaseUrl/$size$path';
  }
}

String? _dotenvValue(String key) {
  try {
    return dotenv.env[key];
  } on Object {
    return null;
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
