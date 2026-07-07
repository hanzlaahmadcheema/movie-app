import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:movie_app/core/config/app_config.dart';
import 'package:movie_app/core/services/tmdb_api_client.dart';

void main() {
  test('calls direct TMDB API with bearer token', () async {
    Uri? capturedUri;
    Map<String, String>? capturedHeaders;
    final client = TmdbApiClient(
      config: _config(token: 'token-123'),
      httpClient: MockClient((request) async {
        capturedUri = request.url;
        capturedHeaders = request.headers;
        return http.Response('{"results":[]}', 200);
      }),
    );

    await client.get('/trending/movie/week', query: {'page': '1'});

    expect(
      capturedUri.toString(),
      'https://api.themoviedb.org/3/trending/movie/week?page=1',
    );
    expect(capturedHeaders?['accept'], 'application/json');
    expect(capturedHeaders?['Authorization'], 'Bearer token-123');
  });

  test('missing TMDB token fails before network request', () async {
    var requestCount = 0;
    final client = TmdbApiClient(
      config: _config(token: ''),
      httpClient: MockClient((request) async {
        requestCount += 1;
        return http.Response('{}', 200);
      }),
    );

    expect(
      () => client.get('/trending/movie/week'),
      throwsA(
        isA<TmdbApiException>().having(
          (error) => error.message,
          'message',
          'TMDB read access token is not configured',
        ),
      ),
    );
    expect(requestCount, 0);
  });

  test('invalid TMDB response maps to TmdbApiException', () async {
    final client = TmdbApiClient(
      config: _config(token: 'token-123'),
      httpClient: MockClient((request) async {
        return http.Response('', 200);
      }),
    );

    expect(
      () => client.get('/trending/movie/week'),
      throwsA(
        isA<TmdbApiException>().having(
          (error) => error.message,
          'message',
          'Invalid TMDB response',
        ),
      ),
    );
  });
}

AppConfig _config({required String token}) {
  return AppConfig(
    tmdbReadAccessToken: token,
    tmdbImageBaseUrl: 'https://image.tmdb.org/t/p',
    streamingVideasyDomains: const [],
    streamingVideasyEnabled: true,
    streamingVideasyMovieTemplate: '',
    streamingVideasyEpisodeTemplate: '',
    streamingStreamVaultDomains: const [],
    streamingStreamVaultEnabled: true,
    streamingStreamVaultMovieTemplate: '',
    streamingStreamVaultEpisodeTemplate: '',
    streamingOneElevenMoviesDomains: const [],
    streamingOneElevenMoviesEnabled: true,
    streamingOneElevenMoviesMovieTemplate: '',
    streamingOneElevenMoviesEpisodeTemplate: '',
    streamingHindiPlayerDomains: const [],
    streamingHindiPlayerEnabled: true,
    streamingVidSrcDomains: const [],
    streamingVidSrcEnabled: true,
    streamingTwoEmbedDomains: const [],
    streamingTwoEmbedEnabled: true,
    streamingTwoEmbedMovieTemplate: '',
    streamingTwoEmbedEpisodeTemplate: '',
    streamingAllowedHosts: const [],
    streamingTimeoutSeconds: 15,
  );
}
