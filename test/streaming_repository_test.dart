import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/services/admin_repository.dart';
import 'package:movie_app/core/streaming/embed_url_builder.dart';
import 'package:movie_app/core/streaming/streaming_content_type.dart';
import 'package:movie_app/core/streaming/streaming_embed_request.dart';
import 'package:movie_app/core/streaming/streaming_navigation_policy.dart';
import 'package:movie_app/core/streaming/streaming_provider_registry.dart';
import 'package:movie_app/core/streaming/streaming_repository.dart';
import 'package:movie_app/core/streaming/streaming_server.dart';
import 'package:movie_app/features/streaming/presentation/streaming_player_controller.dart';
import 'package:movie_app/features/streaming/widgets/streaming_loading_view.dart';

void main() {
  const builder = EmbedUrlBuilder();

  test('builds VidSrc movie URL with TMDB ID', () {
    final url = builder.build(
      _server(id: 'vidsrc-1', priority: 0),
      const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Fight Club',
        tmdbId: 550,
      ),
    );

    expect(
      url.toString(),
      'https://vidsrc.example/embed/movie?tmdb=550&autoplay=1',
    );
  });

  test('builds VidSrc episode URL with season and episode', () {
    final url = builder.build(
      _server(id: 'vidsrc-1', priority: 0),
      const StreamingEmbedRequest(
        contentType: StreamingContentType.episode,
        title: 'Example Show',
        tmdbId: 1399,
        seasonNumber: 2,
        episodeNumber: 3,
      ),
    );

    expect(
      url.toString(),
      'https://vidsrc.example/embed/tv?tmdb=1399&season=2&episode=3&autoplay=1&autonext=1',
    );
  });

  test('builds configured 2Embed movie and episode routes', () {
    final server = _server(
      id: '2embed-1',
      priority: 100,
      strategy: StreamingUrlBuilderStrategy.template,
      domain: 'https://www.2embed.cc',
      movieTemplate: '{domain}/embed/{id}',
      episodeTemplate: '{domain}/embedtv/{id}&s={season}&e={episode}',
    );

    final movie = builder.build(
      server,
      const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Fight Club',
        tmdbId: 550,
      ),
    );
    final episode = builder.build(
      server,
      const StreamingEmbedRequest(
        contentType: StreamingContentType.episode,
        title: 'Example Show',
        tmdbId: 60735,
        seasonNumber: 1,
        episodeNumber: 2,
      ),
    );

    expect(movie.toString(), 'https://www.2embed.cc/embed/550');
    expect(episode.toString(), 'https://www.2embed.cc/embedtv/60735&s=1&e=2');
  });

  test(
    'provider registry and fallback controller preserve priority order',
    () async {
      final repository = StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [
            _server(
              id: '2embed-1',
              priority: 100,
              domain: 'https://twoembed.example',
            ),
            _server(
              id: 'vidsrc-2',
              priority: 10,
              domain: 'https://vidsrc-two.example',
            ),
            _server(
              id: 'vidsrc-1',
              priority: 0,
              domain: 'https://vidsrc-one.example',
            ),
          ],
        ),
      );
      final controller = StreamingPlayerController(
        request: const StreamingEmbedRequest(
          contentType: StreamingContentType.movie,
          title: 'Fight Club',
          tmdbId: 550,
        ),
        repository: repository,
      );

      await controller.initialize();
      expect(controller.candidates.map((candidate) => candidate.server.id), [
        'vidsrc-1',
        'vidsrc-2',
        '2embed-1',
      ]);
      final firstAttempt = controller.attempt;
      controller.failCurrent(firstAttempt, 'test failure');
      expect(controller.currentCandidate?.server.id, 'vidsrc-2');
      expect(controller.status, StreamingPlayerStatus.loading);
      expect(controller.message, 'Server 1 failed, switching to VidSrc...');
      controller.dispose();
    },
  );

  test(
    'admin provider config can disable Jellyfin and reprioritize public providers',
    () async {
      final repository = StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [
            _server(id: 'vidsrc-1', priority: 0),
            _server(
              id: '2embed-1',
              priority: 100,
              strategy: StreamingUrlBuilderStrategy.template,
              domain: 'https://twoembed.example',
              movieTemplate: '{domain}/embed/{id}',
              episodeTemplate: '{domain}/embedtv/{id}&s={season}&e={episode}',
            ),
          ],
        ),
        remoteConfigLoader: () async =>
            const AppRemoteConfig(jellyfinEnabled: false),
        providerConfigLoader: () async => const [
          ProviderConfigRecord(
            id: 'vidsrc',
            providerId: 'vidsrc',
            displayName: 'VidSrc',
            enabled: true,
            priority: 50,
            maintenanceMode: false,
            fallbackAllowed: true,
          ),
          ProviderConfigRecord(
            id: '2embed',
            providerId: '2embed',
            displayName: '2Embed',
            enabled: true,
            priority: -10,
            maintenanceMode: false,
            fallbackAllowed: true,
          ),
        ],
      );

      final candidates = await repository.buildCandidatesAsync(
        const StreamingEmbedRequest(
          contentType: StreamingContentType.movie,
          title: 'Fight Club',
          tmdbId: 550,
        ),
      );

      expect(candidates.map((candidate) => candidate.server.providerId), [
        '2embed',
        'vidsrc',
      ]);
    },
  );

  test('controller page load uses grace state before ready', () async {
    final controller = StreamingPlayerController(
      request: const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Fight Club',
        tmdbId: 550,
      ),
      repository: StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [_server(id: 'vidsrc-1', priority: 0)],
        ),
      ),
    );

    await controller.initialize();
    final attempt = controller.attempt;
    controller.markPageLoaded(attempt);

    expect(controller.status, StreamingPlayerStatus.pageLoaded);
    expect(controller.message, 'Checking VidSrc...');
    controller.dispose();
  });

  test('retry current, try next, and retry all use real candidates', () async {
    final controller = StreamingPlayerController(
      request: const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Fight Club',
        tmdbId: 550,
      ),
      repository: StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [
            _server(id: 'vidsrc-1', priority: 0),
            _server(
              id: 'vidsrc-2',
              priority: 10,
              domain: 'https://vidsrc-two.example',
            ),
          ],
        ),
      ),
    );

    await controller.initialize();
    controller.tryNextServer();
    expect(controller.currentCandidate?.server.id, 'vidsrc-2');
    controller.retryCurrent();
    expect(controller.currentCandidate?.server.id, 'vidsrc-2');
    controller.retryAll();
    expect(controller.currentCandidate?.server.id, 'vidsrc-1');
    controller.dispose();
  });

  test('exhausted fallback state is reached without infinite loops', () async {
    final controller = StreamingPlayerController(
      request: const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Fight Club',
        tmdbId: 550,
      ),
      repository: StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [_server(id: 'vidsrc-1', priority: 0)],
        ),
      ),
    );

    await controller.initialize();
    controller.failCurrent(controller.attempt, 'test failure');

    expect(controller.status, StreamingPlayerStatus.exhausted);
    expect(controller.message, contains('All streaming servers failed'));
    controller.dispose();
  });

  test('navigation policy blocks top-level HTTP and non-web schemes', () {
    const policy = StreamingNavigationPolicy();
    bool allowedHost(String host) => host == 'vidsrc.example';

    final httpDecision = policy.evaluate(
      uri: Uri.parse('http://vidsrc.example/embed/movie'),
      isMainFrame: true,
      isAllowedHost: allowedHost,
    );
    final intentDecision = policy.evaluate(
      uri: Uri.parse('intent://open'),
      isMainFrame: true,
      isAllowedHost: allowedHost,
    );
    final httpsDecision = policy.evaluate(
      uri: Uri.parse('https://vidsrc.example/embed/movie'),
      isMainFrame: true,
      isAllowedHost: allowedHost,
    );

    expect(httpDecision.allowed, isFalse);
    expect(httpDecision.causesFallback, isTrue);
    expect(intentDecision.allowed, isFalse);
    expect(httpsDecision.allowed, isTrue);
  });

  test(
    'navigation policy allows HTTP only for configured private provider host',
    () {
      const policy = StreamingNavigationPolicy();
      final jellyfinDecision = policy.evaluate(
        uri: Uri.parse('http://100.64.0.10:8096/web/'),
        isMainFrame: true,
        isAllowedHost: (host) => host == '100.64.0.10',
        isHttpAllowedHost: (host) => host == '100.64.0.10',
      );
      final randomHttpDecision = policy.evaluate(
        uri: Uri.parse('http://example.com/video'),
        isMainFrame: true,
        isAllowedHost: (host) => host == 'example.com',
        isHttpAllowedHost: (_) => false,
      );

      expect(jellyfinDecision.allowed, isTrue);
      expect(randomHttpDecision.allowed, isFalse);
    },
  );

  test('navigation policy keeps HTTP subframes permissive', () {
    const policy = StreamingNavigationPolicy();
    final decision = policy.evaluate(
      uri: Uri.parse('http://cdn.example/video.js'),
      isMainFrame: false,
      isAllowedHost: (_) => false,
    );

    expect(decision.allowed, isTrue);
  });

  test('diagnostics redact full stream URLs', () {
    final diagnostic = StreamingProviderDiagnostic(
      providerName: 'VidSrc',
      host: 'vidsrc.example',
      loadStartedAt: DateTime.utc(2026),
      fallbackReason: 'Provider returned HTTP 404',
    );
    final debugText = diagnostic.toRedactedDebugString();

    expect(debugText, contains('host=vidsrc.example'));
    expect(debugText, isNot(contains('/embed/movie')));
    expect(debugText, isNot(contains('?tmdb=')));
  });

  testWidgets('loading view does not show fake playback progress', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StreamingLoadingView(
            message: 'Trying VidSrc...',
            detail: 'Server 1 of 2 - VidSrc',
          ),
        ),
      ),
    );

    expect(find.text('Trying VidSrc...'), findsOneWidget);
    expect(find.textContaining('%'), findsNothing);
  });

  test('missing IDs and episode fields fail validation cleanly', () {
    expect(
      const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Missing ID',
      ).validate(),
      'Missing TMDB or IMDb ID',
    );
    expect(
      const StreamingEmbedRequest(
        contentType: StreamingContentType.episode,
        title: 'Missing Episode',
        tmdbId: 1,
      ).validate(),
      'Missing season number',
    );
  });

  test('unsupported content type is skipped', () {
    final movieOnlyServer = _server(
      id: 'movie-only',
      priority: 0,
      supportedTypes: const {StreamingContentType.movie},
    );
    final result = builder.build(
      movieOnlyServer,
      const StreamingEmbedRequest(
        contentType: StreamingContentType.episode,
        title: 'Example Show',
        tmdbId: 1,
        seasonNumber: 1,
        episodeNumber: 1,
      ),
    );

    expect(result, isNull);
  });

  test('route arguments validate supported and malformed input', () {
    final request = StreamingEmbedRequest.fromRouteArguments({
      'contentType': 'episode',
      'tmdbId': '1399',
      'seasonNumber': 1,
      'episodeNumber': 2,
      'title': 'Example Show',
    });

    expect(request?.validate(), isNull);
    expect(request?.tmdbId, 1399);
    expect(
      StreamingEmbedRequest.fromRouteArguments({
        'contentType': 'unsupported',
        'title': 'Bad Route',
      }),
      isNull,
    );
  });

  test('repository generates one candidate URL per configured server', () {
    final repository = StreamingRepository(
      registry: StreamingProviderRegistry(
        servers: [
          _server(id: 'vidsrc-1', priority: 0),
          _server(
            id: '2embed-1',
            priority: 100,
            strategy: StreamingUrlBuilderStrategy.template,
            domain: 'https://www.2embed.cc',
            movieTemplate: '{domain}/embed/{id}',
            episodeTemplate: '{domain}/embedtv/{id}&s={season}&e={episode}',
          ),
        ],
      ),
    );

    final candidates = repository.buildCandidates(
      const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Fight Club',
        tmdbId: 550,
      ),
    );

    expect(candidates, hasLength(2));
    expect(candidates.first.server.id, 'vidsrc-1');
    expect(candidates.last.url.host, 'www.2embed.cc');
  });
}

StreamingServer _server({
  required String id,
  required int priority,
  String domain = 'https://vidsrc.example',
  StreamingUrlBuilderStrategy strategy = StreamingUrlBuilderStrategy.vidSrc,
  Set<StreamingContentType> supportedTypes = const {
    StreamingContentType.movie,
    StreamingContentType.episode,
  },
  String? movieTemplate,
  String? episodeTemplate,
}) {
  return StreamingServer(
    id: id,
    providerId: id.split('-').first,
    displayName: id.startsWith('2embed') ? '2Embed' : 'VidSrc',
    priority: priority,
    baseUri: Uri.parse(domain),
    supportedContentTypes: supportedTypes,
    urlBuilderStrategy: strategy,
    enabled: true,
    timeout: const Duration(seconds: 10),
    movieTemplate: movieTemplate,
    episodeTemplate: episodeTemplate,
  );
}
