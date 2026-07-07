import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/config/app_config.dart';
import 'package:movie_app/core/models/movie_item.dart';
import 'package:movie_app/core/services/admin_repository.dart';
import 'package:movie_app/core/services/user_activity_repository.dart';
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

  test('builds Videasy movie and episode routes', () {
    final server = _server(
      id: 'videasy',
      priority: 200,
      strategy: StreamingUrlBuilderStrategy.template,
      domain: 'https://player.videasy.to',
      movieTemplate: '{domain}/movie/{id}',
      episodeTemplate: '{domain}/tv/{id}/{season}/{episode}',
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

    expect(movie.toString(), 'https://player.videasy.to/movie/550');
    expect(episode.toString(), 'https://player.videasy.to/tv/60735/1/2');
  });

  test('builds StreamVault movie and episode routes', () {
    final server = _server(
      id: 'streamvault',
      priority: 300,
      strategy: StreamingUrlBuilderStrategy.template,
      domain: 'https://streamvaultsrc.click',
      movieTemplate: '{domain}/embed/movie/{id}',
      episodeTemplate: '{domain}/embed/tv/{id}/{season}/{episode}',
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

    expect(movie.toString(), 'https://streamvaultsrc.click/embed/movie/550');
    expect(
      episode.toString(),
      'https://streamvaultsrc.click/embed/tv/60735/1/2',
    );
  });

  test('builds 111Movies movie and episode routes', () {
    final server = _server(
      id: '111movies',
      priority: 400,
      strategy: StreamingUrlBuilderStrategy.template,
      domain: 'https://111movies.net',
      movieTemplate: '{domain}/movie/{id}',
      episodeTemplate: '{domain}/tv/{id}/{season}/{episode}',
    );

    final movie = builder.build(
      server,
      const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Deadpool & Wolverine',
        tmdbId: 533535,
        imdbId: 'tt6263850',
      ),
    );
    final episode = builder.build(
      server,
      const StreamingEmbedRequest(
        contentType: StreamingContentType.episode,
        title: 'Example Show',
        tmdbId: 240411,
        seasonNumber: 1,
        episodeNumber: 5,
      ),
    );

    expect(movie.toString(), 'https://111movies.net/movie/533535');
    expect(episode.toString(), 'https://111movies.net/tv/240411/1/5');
  });

  test('builds Hindi Player generated HTML with IMDb source', () {
    final url = builder.build(
      _server(
        id: 'hindi_player',
        priority: -2,
        strategy: StreamingUrlBuilderStrategy.indStream,
        domain: 'https://allmovieland.link',
      ),
      const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Fight Club',
        tmdbId: 550,
        imdbId: 'tt0137523',
      ),
    );

    expect(url?.scheme, 'data');
    final html = url!.data!.contentAsString();
    expect(html, contains("src: 'tt0137523'"));
    expect(html, contains('https://allmovieland.link/player.js?v=401'));
    expect(html, contains('IndStreamPlayer'));
  });

  test(
    'provider registry deduplicates visible providers with internal endpoints',
    () {
      final registry = StreamingProviderRegistry.fromConfig(
        _config(
          vidSrcDomains: const [
            'https://vidsrc-primary.example',
            'https://vidsrc-mirror.example',
            'https://vidsrc-backup.example',
          ],
          twoEmbedDomains: const [
            'https://2embed-primary.example',
            'https://2embed-mirror.example',
          ],
        ),
      );

      final servers = registry.serversFor(StreamingContentType.movie);

      expect(servers.map((server) => server.displayName), [
        'VidSrc',
        '2Embed',
        'Videasy',
        'StreamVault',
        '111Movies',
        'Hindi Player',
      ]);
      expect(
        servers.where((server) => server.providerId == 'hindi_player'),
        hasLength(1),
      );
      expect(
        servers.where((server) => server.providerId == '111movies'),
        hasLength(1),
      );
      expect(
        servers.where((server) => server.providerId == 'streamvault'),
        hasLength(1),
      );
      expect(
        servers.where((server) => server.providerId == 'videasy'),
        hasLength(1),
      );
      expect(
        servers.where((server) => server.providerId == 'vidsrc'),
        hasLength(1),
      );
      expect(
        servers.where((server) => server.providerId == '2embed'),
        hasLength(1),
      );
      expect(servers.first.enabledEndpoints(), hasLength(3));
      expect(servers[1].enabledEndpoints(), hasLength(2));
    },
  );

  test('Hindi Player is primary only for Indian content', () async {
    final repository = StreamingRepository(
      registry: StreamingProviderRegistry.fromConfig(
        _config(
          vidSrcDomains: const ['https://vidsrc.example'],
          twoEmbedDomains: const ['https://twoembed.example'],
        ),
      ),
      remoteConfigLoader: () async =>
          const AppRemoteConfig(jellyfinEnabled: false),
      providerConfigLoader: () async => AdminRepository.defaultProviderConfigs,
    );

    final indianCandidates = await repository.buildCandidatesAsync(
      StreamingEmbedRequest.movie(
        const MovieItem(
          id: 550,
          title: 'Indian Movie',
          type: 'Movie',
          year: '2026',
          quality: 'HD',
          posterUrl: '',
          imdbId: 'tt0137523',
          originCountryCodes: ['IN'],
        ),
      ),
    );
    final genericCandidates = await repository.buildCandidatesAsync(
      StreamingEmbedRequest.movie(
        const MovieItem(
          id: 550,
          title: 'Generic Movie',
          type: 'Movie',
          year: '2026',
          quality: 'HD',
          posterUrl: '',
          imdbId: 'tt0137523',
          originCountryCodes: ['US'],
        ),
      ),
    );

    expect(indianCandidates.first.server.providerId, 'hindi_player');
    expect(genericCandidates.first.server.providerId, 'vidsrc');
  });

  test(
    'provider registry and fallback controller preserve group priority order',
    () async {
      final repository = StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [
            _server(
              id: '2embed',
              priority: 100,
              domain: 'https://twoembed.example',
            ),
            _server(
              id: 'vidsrc',
              priority: 0,
              domain: 'https://vidsrc.example',
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
        'vidsrc',
        '2embed',
      ]);
      final firstAttempt = controller.attempt;
      controller.failCurrent(firstAttempt, 'test failure');
      expect(controller.currentCandidate?.server.id, '2embed');
      expect(controller.status, StreamingPlayerStatus.loading);
      expect(controller.message, 'Server 1 failed, switching to 2Embed...');
      controller.dispose();
    },
  );

  test(
    'admin provider config can disable Jellyfin and reprioritize public providers',
    () async {
      final repository = StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [
            _server(
              id: 'vidsrc',
              priority: 0,
              endpoints: [
                StreamingEndpoint(
                  endpointId: 'vidsrc_primary',
                  url: Uri(scheme: 'https', host: 'vidsrc-primary.example'),
                  priority: 0,
                  enabled: true,
                ),
                StreamingEndpoint(
                  endpointId: 'vidsrc_backup_2',
                  url: Uri(scheme: 'https', host: 'vidsrc-backup.example'),
                  priority: 1,
                  enabled: true,
                ),
              ],
            ),
            _server(
              id: '2embed',
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
      expect(
        candidates.where(
          (candidate) => candidate.server.providerId == 'vidsrc',
        ),
        hasLength(1),
      );
      expect(candidates.last.resolvedEndpoints, hasLength(2));
    },
  );

  test('selecting VidSrc tries internal endpoints in priority order', () async {
    final controller = StreamingPlayerController(
      request: const StreamingEmbedRequest(
        contentType: StreamingContentType.movie,
        title: 'Fight Club',
        tmdbId: 550,
      ),
      repository: StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [
            _server(
              id: 'vidsrc',
              priority: 0,
              endpoints: [
                StreamingEndpoint(
                  endpointId: 'vidsrc_primary',
                  url: Uri(scheme: 'https', host: 'primary.example'),
                  priority: 0,
                  enabled: true,
                ),
                StreamingEndpoint(
                  endpointId: 'vidsrc_mirror_1',
                  url: Uri(scheme: 'https', host: 'mirror.example'),
                  priority: 1,
                  enabled: true,
                ),
              ],
            ),
            _server(
              id: '2embed',
              priority: 100,
              domain: 'https://twoembed.example',
            ),
          ],
        ),
      ),
    );

    await controller.initialize();

    expect(controller.candidates, hasLength(2));
    expect(controller.currentCandidate?.server.providerId, 'vidsrc');
    expect(controller.currentCandidate?.endpointId, 'vidsrc_primary');
    expect(controller.currentCandidate?.url.host, 'primary.example');

    controller.failCurrent(controller.attempt, 'primary failed');

    expect(controller.currentCandidate?.server.providerId, 'vidsrc');
    expect(controller.currentCandidate?.endpointId, 'vidsrc_mirror_1');
    expect(controller.currentCandidate?.url.host, 'mirror.example');

    controller.dispose();
  });

  test(
    'if first VidSrc endpoint works, second endpoint is not tried',
    () async {
      final controller = StreamingPlayerController(
        request: const StreamingEmbedRequest(
          contentType: StreamingContentType.movie,
          title: 'Fight Club',
          tmdbId: 550,
        ),
        repository: StreamingRepository(
          registry: StreamingProviderRegistry(
            servers: [
              _server(
                id: 'vidsrc',
                priority: 0,
                endpoints: [
                  StreamingEndpoint(
                    endpointId: 'vidsrc_primary',
                    url: Uri(scheme: 'https', host: 'primary.example'),
                    priority: 0,
                    enabled: true,
                  ),
                  StreamingEndpoint(
                    endpointId: 'vidsrc_mirror_1',
                    url: Uri(scheme: 'https', host: 'mirror.example'),
                    priority: 1,
                    enabled: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await controller.initialize();
      controller.markReady(controller.attempt);

      expect(controller.status, StreamingPlayerStatus.ready);
      expect(controller.currentEndpointIndex, 0);
      expect(controller.currentCandidate?.endpointId, 'vidsrc_primary');
      controller.dispose();
    },
  );

  test(
    'if all VidSrc endpoints fail, fallback moves to next provider',
    () async {
      final controller = StreamingPlayerController(
        request: const StreamingEmbedRequest(
          contentType: StreamingContentType.movie,
          title: 'Fight Club',
          tmdbId: 550,
        ),
        repository: StreamingRepository(
          registry: StreamingProviderRegistry(
            servers: [
              _server(
                id: 'vidsrc',
                priority: 0,
                endpoints: [
                  StreamingEndpoint(
                    endpointId: 'vidsrc_primary',
                    url: Uri(scheme: 'https', host: 'primary.example'),
                    priority: 0,
                    enabled: true,
                  ),
                  StreamingEndpoint(
                    endpointId: 'vidsrc_backup_2',
                    url: Uri(scheme: 'https', host: 'backup.example'),
                    priority: 1,
                    enabled: true,
                  ),
                ],
              ),
              _server(
                id: '2embed',
                priority: 100,
                domain: 'https://twoembed.example',
              ),
            ],
          ),
        ),
      );

      await controller.initialize();
      controller.failCurrent(controller.attempt, 'primary failed');
      controller.failCurrent(controller.attempt, 'backup failed');

      expect(controller.currentCandidate?.server.providerId, '2embed');
      expect(controller.currentIndex, 1);
      expect(controller.currentEndpointIndex, 0);
      controller.dispose();
    },
  );

  test('Continue Watching stores provider group ID, not endpoint ID', () {
    final data = streamingActivityData(server: 'VidSrc', providerId: 'vidsrc');

    expect(data['providerId'], 'vidsrc');
    expect(data['providerId'], isNot('vidsrc_backup_2'));
  });

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
            _server(id: 'vidsrc', priority: 0),
            _server(
              id: '2embed',
              priority: 10,
              domain: 'https://twoembed.example',
            ),
          ],
        ),
      ),
    );

    await controller.initialize();
    controller.tryNextServer();
    expect(controller.currentCandidate?.server.id, '2embed');
    controller.retryCurrent();
    expect(controller.currentCandidate?.server.id, '2embed');
    controller.retryAll();
    expect(controller.currentCandidate?.server.id, 'vidsrc');
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

  test('Videasy registry allows primary and redirect hosts', () {
    final registry = StreamingProviderRegistry.fromConfig(
      _config(vidSrcDomains: const [], twoEmbedDomains: const []),
    );

    expect(registry.isAllowedNavigationHost('player.videasy.to'), isTrue);
    expect(registry.isAllowedNavigationHost('player.videasy.net'), isTrue);
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

  test('repository generates one candidate URL per provider group', () {
    final repository = StreamingRepository(
      registry: StreamingProviderRegistry(
        servers: [
          _server(id: 'vidsrc', priority: 0),
          _server(
            id: '2embed',
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
    expect(candidates.first.server.id, 'vidsrc');
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
  List<StreamingEndpoint> endpoints = const [],
}) {
  return StreamingServer(
    id: id,
    providerId: id.split('-').first,
    displayName: switch (id.split('-').first) {
      '2embed' => '2Embed',
      'videasy' => 'Videasy',
      'streamvault' => 'StreamVault',
      '111movies' => '111Movies',
      'hindi_player' => 'Hindi Player',
      _ => 'VidSrc',
    },
    priority: priority,
    baseUri: Uri.parse(domain),
    supportedContentTypes: supportedTypes,
    urlBuilderStrategy: strategy,
    enabled: true,
    timeout: const Duration(seconds: 10),
    movieTemplate: movieTemplate,
    episodeTemplate: episodeTemplate,
    endpoints: endpoints,
  );
}

AppConfig _config({
  required List<String> vidSrcDomains,
  required List<String> twoEmbedDomains,
}) {
  return AppConfig(
    tmdbReadAccessToken: '',
    tmdbImageBaseUrl: 'https://image.tmdb.org/t/p',
    streamingVidSrcDomains: vidSrcDomains,
    streamingVidSrcEnabled: true,
    streamingVideasyDomains: const [
      'https://player.videasy.to',
      'https://player.videasy.net',
    ],
    streamingVideasyEnabled: true,
    streamingVideasyMovieTemplate: '{domain}/movie/{id}',
    streamingVideasyEpisodeTemplate: '{domain}/tv/{id}/{season}/{episode}',
    streamingStreamVaultDomains: const ['https://streamvaultsrc.click'],
    streamingStreamVaultEnabled: true,
    streamingStreamVaultMovieTemplate: '{domain}/embed/movie/{id}',
    streamingStreamVaultEpisodeTemplate:
        '{domain}/embed/tv/{id}/{season}/{episode}',
    streamingOneElevenMoviesDomains: const ['https://111movies.net'],
    streamingOneElevenMoviesEnabled: true,
    streamingOneElevenMoviesMovieTemplate: '{domain}/movie/{id}',
    streamingOneElevenMoviesEpisodeTemplate:
        '{domain}/tv/{id}/{season}/{episode}',
    streamingHindiPlayerDomains: const [
      'https://allmovieland.link',
      'https://gemma416okl.com',
    ],
    streamingHindiPlayerEnabled: true,
    streamingTwoEmbedDomains: twoEmbedDomains,
    streamingTwoEmbedEnabled: true,
    streamingTwoEmbedMovieTemplate: '{domain}/embed/{id}',
    streamingTwoEmbedEpisodeTemplate:
        '{domain}/embedtv/{id}&s={season}&e={episode}',
    streamingAllowedHosts: const [],
    streamingTimeoutSeconds: 10,
  );
}
