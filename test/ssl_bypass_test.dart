import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/config/app_config.dart';
import 'package:movie_app/core/services/admin_repository.dart';
import 'package:movie_app/core/streaming/streaming_content_type.dart';
import 'package:movie_app/core/streaming/streaming_embed_request.dart';
import 'package:movie_app/core/streaming/streaming_provider_registry.dart';
import 'package:movie_app/core/streaming/streaming_repository.dart';
import 'package:movie_app/features/streaming/presentation/streaming_player_controller.dart';

void main() {
  test('StreamingPlayerController initializes and transitions to ready without SSL failure', () async {
    const config = AppConfig(
      tmdbReadAccessToken: '',
      tmdbImageBaseUrl: 'https://image.tmdb.org/t/p',
      streamingVidSrcDomains: ['https://vidsrc.example'],
      streamingVidSrcEnabled: true,
      streamingVideasyDomains: ['https://player.videasy.to'],
      streamingVideasyEnabled: true,
      streamingVideasyMovieTemplate: '{domain}/movie/{id}',
      streamingVideasyEpisodeTemplate: '{domain}/tv/{id}/{season}/{episode}',
      streamingStreamVaultDomains: ['https://streamvaultsrc.click'],
      streamingStreamVaultEnabled: true,
      streamingStreamVaultMovieTemplate: '{domain}/embed/movie/{id}',
      streamingStreamVaultEpisodeTemplate: '{domain}/embed/tv/{id}/{season}/{episode}',
      streamingOneElevenMoviesDomains: ['https://111movies.net'],
      streamingOneElevenMoviesEnabled: true,
      streamingOneElevenMoviesMovieTemplate: '{domain}/movie/{id}',
      streamingOneElevenMoviesEpisodeTemplate: '{domain}/tv/{id}/{season}/{episode}',
      streamingVidKingDomains: ['https://www.vidking.net'],
      streamingVidKingEnabled: true,
      streamingVidKingMovieTemplate: '{domain}/embed/movie/{id}',
      streamingVidKingEpisodeTemplate: '{domain}/embed/tv/{id}/{season}/{episode}',
      streamingHindiPlayerDomains: ['https://allmovieland.link'],
      streamingHindiPlayerEnabled: true,
      streamingNxshaDomains: ['https://nxsha.space'],
      streamingNxshaEnabled: true,
      streamingNxshaMovieTemplate: '{domain}/embed/movie/{id}',
      streamingNxshaEpisodeTemplate: '{domain}/embed/tv/{id}/{season}/{episode}',
      streamingTwoEmbedDomains: ['https://twoembed.example'],
      streamingTwoEmbedEnabled: true,
      streamingTwoEmbedMovieTemplate: '{domain}/embed/{id}',
      streamingTwoEmbedEpisodeTemplate: '{domain}/embedtv/{id}&s={season}&e={episode}',
      streamingAllowedHosts: [],
      streamingTimeoutSeconds: 10,
    );

    final repository = StreamingRepository(
      registry: StreamingProviderRegistry.fromConfig(config),
      remoteConfigLoader: () async => const AppRemoteConfig(),
      providerConfigLoader: () async => AdminRepository.defaultProviderConfigs,
    );

    const request = StreamingEmbedRequest(
      contentType: StreamingContentType.movie,
      title: 'Test Movie',
      tmdbId: 550,
    );

    final controller = StreamingPlayerController(
      request: request,
      repository: repository,
    );

    await controller.initialize();

    expect(controller.status, equals(StreamingPlayerStatus.loading));
    expect(controller.candidates.isNotEmpty, isTrue);

    // Simulate WebView page load (where SSL warning is bypassed via error.proceed())
    controller.markPageLoaded(controller.attempt);

    expect(controller.status, equals(StreamingPlayerStatus.ready));
    expect(controller.message, isNull);
  });
}
