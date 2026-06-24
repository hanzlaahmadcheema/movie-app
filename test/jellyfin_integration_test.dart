import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:movie_app/core/jellyfin/jellyfin_client.dart';
import 'package:movie_app/core/jellyfin/jellyfin_config.dart';
import 'package:movie_app/core/jellyfin/jellyfin_index.dart';
import 'package:movie_app/core/jellyfin/jellyfin_item.dart';
import 'package:movie_app/core/jellyfin/jellyfin_matcher.dart';
import 'package:movie_app/core/jellyfin/jellyfin_playback_info.dart';
import 'package:movie_app/core/jellyfin/jellyfin_repository.dart';
import 'package:movie_app/core/jellyfin/jellyfin_stream_url_builder.dart';
import 'package:movie_app/core/services/user_activity_repository.dart';
import 'package:movie_app/core/streaming/streaming_content_type.dart';
import 'package:movie_app/core/streaming/streaming_embed_request.dart';
import 'package:movie_app/core/streaming/streaming_provider_registry.dart';
import 'package:movie_app/core/streaming/streaming_repository.dart';
import 'package:movie_app/core/streaming/streaming_server.dart';

void main() {
  group('Jellyfin configuration', () {
    test('default server is blank and private HTTP is validated', () {
      const defaultConfig = JellyfinConfig();
      const privateHttp = JellyfinConfig(serverUrl: _testServerUrl);
      const invalid = JellyfinConfig(serverUrl: 'http://example.com:8096');

      expect(defaultConfig.serverUrl, kDefaultJellyfinServerUrl);
      expect(defaultConfig.serverUrl, isEmpty);
      expect(defaultConfig.validate(), contains('Enter a valid'));
      expect(privateHttp.validate(), isNull);
      expect(invalid.validate(), contains('HTTP is only allowed'));
    });

    test('redacts secrets', () {
      expect(redactJellyfinSecret('secret'), '********');
      expect(redactJellyfinSecret(''), '');
    });

    test('playback mode defaults to Auto and persists locally', () async {
      final store = MemoryJellyfinConfigStore();

      expect((await store.load()).playbackMode, JellyfinPlaybackMode.auto);

      await store.save(
        _enabledConfig.copyWith(playbackMode: JellyfinPlaybackMode.native),
      );

      expect((await store.load()).playbackMode, JellyfinPlaybackMode.native);
    });

    test('changing server URL requires re-login by clearing session', () async {
      final store = MemoryJellyfinConfigStore(_enabledConfig);

      await store.clearSession(serverUrl: 'http://100.64.0.11:8096');
      final config = await store.load();

      expect(config.serverUrl, 'http://100.64.0.11:8096');
      expect(config.accessToken, isEmpty);
      expect(config.userId, isEmpty);
    });

    test('logout clears token', () async {
      final store = MemoryJellyfinConfigStore(_enabledConfig);

      await store.clearSession(serverUrl: _enabledConfig.serverUrl);
      final config = await store.load();

      expect(config.accessToken, isEmpty);
      expect(config.userName, isEmpty);
    });
  });

  group('Jellyfin login', () {
    test('successful login stores token and user ID', () async {
      final repository = JellyfinRepository(
        configStore: MemoryJellyfinConfigStore(),
        clientFactory: _loginClient,
      );

      final result = await repository.login(
        serverUrl: _testServerUrl,
        username: 'hanzla',
        password: 'secret',
      );
      final config = await repository.loadConfig();

      expect(result.accessToken, 'token-123');
      expect(config.accessToken, 'token-123');
      expect(config.userId, 'user-1');
      expect(config.userName, 'hanzla');
    });

    test('invalid credentials map to auth error', () async {
      final client = JellyfinClient(
        config: const JellyfinConfig(serverUrl: _testServerUrl),
        httpClient: MockClient((request) async => http.Response('{}', 400)),
      );

      expect(
        client.login(username: 'bad', password: 'wrong'),
        throwsA(
          isA<JellyfinException>().having(
            (error) => error.message,
            'message',
            contains('Invalid Jellyfin username or password'),
          ),
        ),
      );
    });

    test('network failure maps to server unreachable', () async {
      final client = JellyfinClient(
        config: const JellyfinConfig(serverUrl: _testServerUrl),
        httpClient: MockClient((request) async {
          throw http.ClientException('offline');
        }),
      );

      expect(
        client.login(username: 'hanzla', password: 'secret'),
        throwsA(
          isA<JellyfinException>().having(
            (error) => error.message,
            'message',
            contains('Make sure Tailscale is connected'),
          ),
        ),
      );
    });
  });

  group('Jellyfin matching', () {
    final index = JellyfinIndex([
      const JellyfinItem(
        id: 'movie-tmdb',
        name: 'Fight Club',
        type: 'Movie',
        providerIds: {'Tmdb': '550', 'Imdb': 'tt0137523'},
      ),
      const JellyfinItem(
        id: 'movie-imdb',
        name: 'IMDb Only',
        type: 'Movie',
        providerIds: {'Imdb': 'tt1111111'},
      ),
      const JellyfinItem(
        id: 'series-1',
        name: 'Example Show',
        type: 'Series',
        providerIds: {'Tmdb': '1399', 'Imdb': 'tt0944947', 'Tvdb': '121361'},
      ),
      const JellyfinItem(
        id: 'episode-1',
        name: 'Pilot',
        type: 'Episode',
        seriesId: 'series-1',
        seasonNumber: 1,
        episodeNumber: 2,
      ),
    ]);
    final matcher = JellyfinMatcher(index);

    test('movie matches by TMDB ID', () {
      final match = matcher.findMovie(tmdbId: 550);

      expect(match.found, isTrue);
      expect(match.itemId, 'movie-tmdb');
      expect(match.reason, JellyfinMatchReason.matchedByTmdb);
    });

    test('movie matches by IMDb fallback', () {
      final match = matcher.findMovie(imdbId: 'tt1111111');

      expect(match.found, isTrue);
      expect(match.itemId, 'movie-imdb');
      expect(match.reason, JellyfinMatchReason.matchedByImdb);
    });
  });

  group('Jellyfin provider', () {
    test('disabled Jellyfin returns no private candidates', () async {
      final repository = StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [_server(id: 'vidsrc-1', priority: 0)],
        ),
        jellyfinRepository: JellyfinRepository(
          configStore: MemoryJellyfinConfigStore(),
          clientFactory: _itemsClient,
        ),
      );

      final candidates = await repository.buildCandidatesAsync(_movieRequest);

      expect(candidates, hasLength(1));
      expect(candidates.single.server.providerId, 'vidsrc');
    });

    test('missing token does not block public fallback', () async {
      final repository = StreamingRepository(
        registry: StreamingProviderRegistry(
          servers: [_server(id: 'vidsrc-1', priority: 0)],
        ),
        jellyfinRepository: JellyfinRepository(
          configStore: MemoryJellyfinConfigStore(
            _enabledConfig.copyWith(accessToken: ''),
          ),
          clientFactory: _itemsClient,
        ),
      );

      final candidates = await repository.buildCandidatesAsync(_movieRequest);

      expect(candidates, hasLength(1));
      expect(candidates.single.server.providerId, 'vidsrc');
    });

    test(
      'matched Jellyfin Native and Web appear before public providers',
      () async {
        final repository = StreamingRepository(
          registry: StreamingProviderRegistry(
            servers: [_server(id: 'vidsrc-1', priority: 0)],
          ),
          jellyfinRepository: JellyfinRepository(
            configStore: MemoryJellyfinConfigStore(_enabledConfig),
            clientFactory: _itemsClient,
          ),
        );

        final candidates = await repository.buildCandidatesAsync(_movieRequest);

        expect(candidates[0].server.providerId, 'jellyfin_native');
        expect(candidates[1].server.providerId, 'jellyfin_web');
        expect(candidates[0].jellyfinItemId, 'movie-tmdb');
        expect(candidates[0].jellyfinPlaybackMode, JellyfinPlaybackMode.native);
        expect(candidates[1].jellyfinPlaybackMode, JellyfinPlaybackMode.web);
        expect(candidates[2].server.providerId, 'vidsrc');
      },
    );
  });

  group('Jellyfin PlaybackInfo and native stream selection', () {
    test('PlaybackInfo uses user token header and never query token', () async {
      final client = JellyfinClient(
        config: _enabledConfig,
        httpClient: MockClient((request) async {
          expect(request.url.path, '/Items/item-1/PlaybackInfo');
          expect(request.url.query, isNot(contains('token-123')));
          expect(request.headers['X-Emby-Token'], 'token-123');
          return http.Response(
            '{"MediaSources":[{"Id":"source-1","Container":"mp4"}]}',
            200,
          );
        }),
      );

      final info = await client.getPlaybackInfo(
        itemId: 'item-1',
        userId: 'user-1',
      );

      expect(info.mediaSources.single.id, 'source-1');
    });

    test('builds native candidate with saved token', () {
      final candidate = const JellyfinStreamUrlBuilder().buildCandidate(
        config: _enabledConfig,
        itemId: 'item-1',
        playbackInfo: const JellyfinPlaybackInfo(
          mediaSources: [
            JellyfinMediaSource(
              id: 'source-1',
              container: 'mp4',
              directStreamUrl: '/Videos/item-1/stream.mp4',
              supportsDirectPlay: true,
              runtimeTicks: 900000000,
            ),
          ],
        ),
        resumePositionSeconds: 42,
      );

      expect(candidate.headers['X-Emby-Token'], 'token-123');
      expect(candidate.durationSeconds, 90);
      expect(candidate.resumePositionSeconds, 42);
    });

    test('getItem parses Jellyfin playback position ticks', () async {
      final client = JellyfinClient(
        config: _enabledConfig,
        httpClient: MockClient((request) async {
          expect(request.url.path, '/Users/user-1/Items/item-1');
          return http.Response(
            '{"Id":"item-1","Name":"Fight Club","Type":"Movie","UserData":{"PlaybackPositionTicks":420000000}}',
            200,
          );
        }),
      );

      final item = await client.getItem(itemId: 'item-1', userId: 'user-1');

      expect(item.id, 'item-1');
      expect(item.playbackPositionTicks, 420000000);
    });

    test('playback progress sync uses Jellyfin session endpoints', () async {
      final client = JellyfinClient(
        config: _enabledConfig,
        httpClient: MockClient((request) async {
          expect(request.url.path, '/Sessions/Playing/Progress');
          expect(request.headers['X-Emby-Token'], 'token-123');
          expect(request.body, contains('"ItemId":"item-1"'));
          expect(request.body, contains('"MediaSourceId":"source-1"'));
          expect(request.body, contains('"PositionTicks":310000000'));
          return http.Response('{}', 204);
        }),
      );

      await client.reportPlaybackProgress(
        itemId: 'item-1',
        mediaSourceId: 'source-1',
        positionSeconds: 31,
        playSessionId: 'play-1',
      );
    });

    test('random HTTP host remains blocked', () {
      expect(
        () => const JellyfinStreamUrlBuilder().buildCandidate(
          config: _enabledConfig,
          itemId: 'item-1',
          playbackInfo: const JellyfinPlaybackInfo(
            mediaSources: [
              JellyfinMediaSource(
                id: 'source-1',
                container: 'mp4',
                directStreamUrl: 'http://example.com/Videos/item-1/stream.mp4',
                supportsDirectPlay: true,
              ),
            ],
          ),
        ),
        throwsA(isA<JellyfinStreamSelectionException>()),
      );
    });

    test('configured Jellyfin HTTP host remains allowed', () {
      final candidate = const JellyfinStreamUrlBuilder().buildCandidate(
        config: _enabledConfig,
        itemId: 'item-1',
        playbackInfo: const JellyfinPlaybackInfo(
          mediaSources: [
            JellyfinMediaSource(
              id: 'source-1',
              container: 'mp4',
              directStreamUrl:
                  'http://100.64.0.10:8096/Videos/item-1/stream.mp4',
              supportsDirectPlay: true,
            ),
          ],
        ),
      );

      expect(candidate.streamUri.host, '100.64.0.10');
    });
  });

  test('activity payload does not include token', () {
    final payload = streamingActivityData(
      server: 'Jellyfin Private',
      providerId: 'jellyfin_private',
      jellyfinItemId: 'movie-tmdb',
    );

    expect(payload.containsKey('accessToken'), isFalse);
    expect(payload.containsKey('token'), isFalse);
  });
}

const _testServerUrl = 'http://100.64.0.10:8096';

const _enabledConfig = JellyfinConfig(
  enabled: true,
  serverUrl: _testServerUrl,
  accessToken: 'token-123',
  userId: 'user-1',
  userName: 'hanzla',
  serverId: 'server-1',
);

const _movieRequest = StreamingEmbedRequest(
  contentType: StreamingContentType.movie,
  title: 'Fight Club',
  tmdbId: 550,
  imdbId: 'tt0137523',
);

JellyfinClient _itemsClient(JellyfinConfig config) {
  return JellyfinClient(
    config: config,
    httpClient: MockClient((request) async {
      expect(request.headers['X-Emby-Token'], 'token-123');
      expect(request.url.query, isNot(contains('token-123')));
      return http.Response(
        '{"Items":[{"Id":"movie-tmdb","Name":"Fight Club","Type":"Movie","ProviderIds":{"Tmdb":"550","Imdb":"tt0137523"}}]}',
        200,
      );
    }),
  );
}

JellyfinClient _loginClient(JellyfinConfig config) {
  return JellyfinClient(
    config: config,
    httpClient: MockClient((request) async {
      expect(request.url.path, '/Users/AuthenticateByName');
      expect(request.headers['X-Emby-Authorization'], contains('MovieApp'));
      expect(request.body, contains('"Username":"hanzla"'));
      expect(request.body, isNot(contains('token-123')));
      return http.Response(
        '{"AccessToken":"token-123","ServerId":"server-1","User":{"Id":"user-1","Name":"hanzla"}}',
        200,
      );
    }),
  );
}

StreamingServer _server({required String id, required int priority}) {
  return StreamingServer(
    id: id,
    providerId: 'vidsrc',
    displayName: 'VidSrc',
    priority: priority,
    baseUri: Uri.parse('https://vidsrc.example'),
    supportedContentTypes: const {
      StreamingContentType.movie,
      StreamingContentType.episode,
    },
    urlBuilderStrategy: StreamingUrlBuilderStrategy.vidSrc,
    enabled: true,
    timeout: const Duration(seconds: 10),
  );
}
