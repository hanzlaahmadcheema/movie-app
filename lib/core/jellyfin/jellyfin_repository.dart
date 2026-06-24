import '../streaming/streaming_content_type.dart';
import '../streaming/streaming_embed_request.dart';
import '../streaming/streaming_embed_result.dart';
import '../streaming/streaming_server.dart';
import 'jellyfin_client.dart';
import 'jellyfin_config.dart';
import 'jellyfin_index.dart';
import 'jellyfin_item.dart';
import 'jellyfin_matcher.dart';
import 'jellyfin_stream_url_builder.dart';
import 'jellyfin_url_builder.dart';

class JellyfinRepository {
  JellyfinRepository({
    required JellyfinConfigStore configStore,
    JellyfinUrlBuilder urlBuilder = const JellyfinUrlBuilder(),
    JellyfinStreamUrlBuilder streamUrlBuilder =
        const JellyfinStreamUrlBuilder(),
    JellyfinClient Function(JellyfinConfig config)? clientFactory,
  }) : _configStore = configStore,
       _urlBuilder = urlBuilder,
       _streamUrlBuilder = streamUrlBuilder,
       _clientFactory =
           clientFactory ?? ((config) => JellyfinClient(config: config));

  factory JellyfinRepository.local() {
    return JellyfinRepository(configStore: SecureJellyfinConfigStore.instance);
  }

  final JellyfinConfigStore _configStore;
  final JellyfinUrlBuilder _urlBuilder;
  final JellyfinStreamUrlBuilder _streamUrlBuilder;
  final JellyfinClient Function(JellyfinConfig config) _clientFactory;

  Future<JellyfinConfig> loadConfig() => _configStore.load();

  Future<void> saveConfig(JellyfinConfig config) => _configStore.save(config);

  Future<void> clearConfig() => _configStore.clear();

  Future<void> clearSession({String? serverUrl}) {
    return _configStore.clearSession(serverUrl: serverUrl);
  }

  Future<JellyfinConnectionResult> testConnection(JellyfinConfig config) {
    return _clientFactory(config).testConnection();
  }

  Future<JellyfinLoginResult> login({
    required String serverUrl,
    required String username,
    required String password,
    JellyfinPlaybackMode playbackMode = JellyfinPlaybackMode.auto,
    bool enabled = true,
  }) async {
    final baseConfig = (await loadConfig()).copyWith(
      enabled: enabled,
      serverUrl: serverUrl.trim(),
      playbackMode: playbackMode,
    );
    final loginResult = await _clientFactory(
      baseConfig,
    ).login(username: username, password: password);
    final savedConfig = baseConfig.copyWith(
      accessToken: loginResult.accessToken,
      userId: loginResult.userId,
      userName: loginResult.userName,
      serverId: loginResult.serverId,
    );
    await saveConfig(savedConfig);
    return loginResult;
  }

  Future<JellyfinConfig> validateSavedSession() async {
    final config = await loadConfig();
    if (!config.enabled || !config.hasToken) {
      return config;
    }
    try {
      final user = await _clientFactory(config).validateSession();
      final updated = config.copyWith(userId: user.id, userName: user.name);
      await saveConfig(updated);
      return updated;
    } on JellyfinException catch (error) {
      if (error.debugReason == 'unauthorized') {
        final cleared = config.withoutSession();
        await saveConfig(cleared);
        return cleared;
      }
      rethrow;
    }
  }

  Future<JellyfinIndex> buildIndex(JellyfinConfig config) async {
    final items = await _clientFactory(config).getItems(config.userId);
    return JellyfinIndex(items);
  }

  Future<JellyfinItem?> getItem(String itemId) async {
    final config = await _configStore.load();
    if (!config.isConfigured) {
      throw const JellyfinException('Jellyfin login required.');
    }
    return _clientFactory(
      config,
    ).getItem(itemId: itemId, userId: config.userId);
  }

  Future<JellyfinConfig> resyncLibrary() async {
    final config = await loadConfig();
    if (!config.enabled || !config.hasToken) {
      throw const JellyfinException('Jellyfin login required.');
    }
    await buildIndex(config);
    final updated = config.copyWith(lastSyncAt: DateTime.now());
    await saveConfig(updated);
    return updated;
  }

  Future<JellyfinMatchResult> match(StreamingEmbedRequest request) async {
    final config = await _configStore.load();
    if (!config.enabled) {
      return const JellyfinMatchResult.miss(
        JellyfinMatchReason.jellyfinDisabled,
      );
    }
    if (config.validate() != null) {
      return const JellyfinMatchResult.miss(JellyfinMatchReason.invalidConfig);
    }
    if (!config.hasToken || config.userId.trim().isEmpty) {
      return const JellyfinMatchResult.miss(JellyfinMatchReason.invalidConfig);
    }

    try {
      final index = await buildIndex(config);
      final matcher = JellyfinMatcher(index);
      return switch (request.contentType) {
        StreamingContentType.movie => matcher.findMovie(
          tmdbId: request.tmdbId,
          imdbId: request.imdbId,
        ),
        StreamingContentType.episode => matcher.findEpisode(
          tmdbSeriesId: request.tmdbId,
          imdbSeriesId: request.imdbId,
          seasonNumber: request.seasonNumber,
          episodeNumber: request.episodeNumber,
        ),
      };
    } on JellyfinException {
      return const JellyfinMatchResult.miss(
        JellyfinMatchReason.jellyfinUnreachable,
      );
    }
  }

  Future<List<StreamingEmbedResult>> buildCandidates(
    StreamingEmbedRequest request,
  ) async {
    final config = await _configStore.load();
    if (!config.enabled || !config.isConfigured) return const [];
    if (request.skipJellyfin) return const [];
    final baseUri = config.baseUri;
    if (baseUri == null) return const [];
    final match = await this.match(request);
    if (!match.found || match.itemId == null) return const [];
    final displayName = config.displayName.trim().isEmpty
        ? 'Jellyfin Private'
        : config.displayName.trim();
    final nativeServer = StreamingServer(
      id: 'jellyfin-native',
      providerId: 'jellyfin_native',
      displayName: '$displayName Native',
      priority: -101,
      baseUri: baseUri,
      supportedContentTypes: StreamingContentType.values.toSet(),
      urlBuilderStrategy: StreamingUrlBuilderStrategy.jellyfinWeb,
      enabled: true,
      timeout: const Duration(seconds: 12),
      allowHttpNavigation: baseUri.scheme == 'http',
      privateProvider: true,
    );
    final webServer = StreamingServer(
      id: 'jellyfin-web',
      providerId: 'jellyfin_web',
      displayName: '$displayName Web',
      priority: -100,
      baseUri: baseUri,
      supportedContentTypes: StreamingContentType.values.toSet(),
      urlBuilderStrategy: StreamingUrlBuilderStrategy.jellyfinWeb,
      enabled: true,
      timeout: const Duration(seconds: 12),
      allowHttpNavigation: baseUri.scheme == 'http',
      privateProvider: true,
    );
    final candidates = <StreamingEmbedResult>[
      StreamingEmbedResult(
        server: nativeServer,
        url: _urlBuilder.itemDetail(baseUri, match.itemId!),
        jellyfinItemId: match.itemId,
        matchReason: match.reason.name,
        jellyfinPlaybackMode: JellyfinPlaybackMode.native,
      ),
      StreamingEmbedResult(
        server: webServer,
        url: _urlBuilder.itemDetail(baseUri, match.itemId!),
        jellyfinItemId: match.itemId,
        matchReason: match.reason.name,
        jellyfinPlaybackMode: JellyfinPlaybackMode.web,
      ),
    ];
    final preferredProviderId = request.preferredProviderId;
    if (preferredProviderId != null && preferredProviderId.trim().isNotEmpty) {
      candidates.sort((a, b) {
        final aPreferred = a.server.providerId == preferredProviderId ? 0 : 1;
        final bPreferred = b.server.providerId == preferredProviderId ? 0 : 1;
        return aPreferred.compareTo(bPreferred);
      });
      return candidates;
    }
    if (config.playbackMode == JellyfinPlaybackMode.web) {
      return [candidates[1], candidates[0]];
    }
    return candidates;
  }

  Future<JellyfinNativePlaybackCandidate> buildNativePlaybackCandidate({
    required String itemId,
  }) async {
    final config = await _configStore.load();
    if (!config.isConfigured) {
      throw const JellyfinException('Jellyfin login required.');
    }
    final client = _clientFactory(config);
    final playbackInfo = await client.getPlaybackInfo(
      itemId: itemId,
      userId: config.userId,
    );
    int? resumePositionSeconds;
    try {
      final item = await client.getItem(itemId: itemId, userId: config.userId);
      final ticks = item.playbackPositionTicks;
      if (ticks != null && ticks > 0) {
        resumePositionSeconds = (ticks / 10000000).floor();
      }
    } on JellyfinException {
      resumePositionSeconds = null;
    }
    return _streamUrlBuilder.buildCandidate(
      config: config,
      itemId: itemId,
      playbackInfo: playbackInfo,
      resumePositionSeconds: resumePositionSeconds,
    );
  }

  Future<void> reportPlaybackStart({
    required String itemId,
    required String mediaSourceId,
    required int positionSeconds,
    String? playSessionId,
    bool isPaused = false,
  }) async {
    final config = await _configStore.load();
    if (!config.isConfigured) {
      throw const JellyfinException('Jellyfin login required.');
    }
    await _clientFactory(config).reportPlaybackStart(
      itemId: itemId,
      mediaSourceId: mediaSourceId,
      positionSeconds: positionSeconds,
      playSessionId: playSessionId,
      isPaused: isPaused,
    );
  }

  Future<void> reportPlaybackProgress({
    required String itemId,
    required String mediaSourceId,
    required int positionSeconds,
    String? playSessionId,
    bool isPaused = false,
  }) async {
    final config = await _configStore.load();
    if (!config.isConfigured) {
      throw const JellyfinException('Jellyfin login required.');
    }
    await _clientFactory(config).reportPlaybackProgress(
      itemId: itemId,
      mediaSourceId: mediaSourceId,
      positionSeconds: positionSeconds,
      playSessionId: playSessionId,
      isPaused: isPaused,
    );
  }

  Future<void> reportPlaybackStopped({
    required String itemId,
    required String mediaSourceId,
    required int positionSeconds,
    String? playSessionId,
  }) async {
    final config = await _configStore.load();
    if (!config.isConfigured) {
      throw const JellyfinException('Jellyfin login required.');
    }
    await _clientFactory(config).reportPlaybackStopped(
      itemId: itemId,
      mediaSourceId: mediaSourceId,
      positionSeconds: positionSeconds,
      playSessionId: playSessionId,
    );
  }
}
