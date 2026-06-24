import '../config/app_config.dart';
import '../services/admin_repository.dart';
import '../jellyfin/jellyfin_repository.dart';
import 'embed_url_builder.dart';
import 'streaming_embed_request.dart';
import 'streaming_embed_result.dart';
import 'streaming_provider_registry.dart';
import 'streaming_server.dart';

class StreamingRequestException implements Exception {
  const StreamingRequestException(this.message);

  final String message;

  @override
  String toString() => message;
}

class StreamingRepository {
  const StreamingRepository({
    required this.registry,
    this.urlBuilder = const EmbedUrlBuilder(),
    this.jellyfinRepository,
    this.adminRepository,
    this.remoteConfigLoader,
    this.providerConfigLoader,
  });

  factory StreamingRepository.fromConfig(AppConfig config) {
    return StreamingRepository(
      registry: StreamingProviderRegistry.fromConfig(config),
      jellyfinRepository: JellyfinRepository.local(),
    );
  }

  final StreamingProviderRegistry registry;
  final EmbedUrlBuilder urlBuilder;
  final JellyfinRepository? jellyfinRepository;
  final AdminRepository? adminRepository;
  final Future<AppRemoteConfig> Function()? remoteConfigLoader;
  final Future<List<ProviderConfigRecord>> Function()? providerConfigLoader;

  List<StreamingEmbedResult> buildCandidates(StreamingEmbedRequest request) {
    final validationError = request.validate();
    if (validationError != null) {
      throw StreamingRequestException(validationError);
    }

    final seenUrls = <String>{};
    final candidates = <StreamingEmbedResult>[];
    for (final server in registry.serversFor(request.contentType)) {
      final url = urlBuilder.build(server, request);
      if (url == null || !seenUrls.add(url.toString())) {
        continue;
      }
      candidates.add(StreamingEmbedResult(server: server, url: url));
    }
    return List.unmodifiable(candidates);
  }

  Future<List<StreamingEmbedResult>> buildCandidatesAsync(
    StreamingEmbedRequest request,
  ) async {
    final admin = adminRepository ?? AdminRepository.instance;
    final remoteConfig = await (remoteConfigLoader?.call() ??
        admin.loadPublicAppConfig());
    final providerConfigs = await (providerConfigLoader?.call() ??
        admin.loadProviders());
    var publicCandidates = buildCandidates(request);
    final jellyfin = jellyfinRepository;
    if (jellyfin == null) {
      publicCandidates = _orderedByPreference(
        _applyProviderConfig(
          candidates: publicCandidates,
          providerConfigs: providerConfigs,
          remoteConfig: remoteConfig,
        ),
        request,
      );
      return publicCandidates;
    }
    var jellyfinCandidates = await jellyfin.buildCandidates(request);
    if (!remoteConfig.jellyfinEnabled) {
      jellyfinCandidates = const [];
    }
    if (jellyfinCandidates.isEmpty) {
      return _orderedByPreference(
        _applyProviderConfig(
          candidates: publicCandidates,
          providerConfigs: providerConfigs,
          remoteConfig: remoteConfig,
        ),
        request,
      );
    }
    final seenUrls = <String>{};
    final combined = <StreamingEmbedResult>[
      ...jellyfinCandidates.where(
        (candidate) => seenUrls.add(_candidateKey(candidate)),
      ),
      ...publicCandidates.where(
        (candidate) => seenUrls.add(_candidateKey(candidate)),
      ),
    ];
    return _orderedByPreference(
      _applyProviderConfig(
        candidates: combined,
        providerConfigs: providerConfigs,
        remoteConfig: remoteConfig,
      ),
      request,
    );
  }

  List<StreamingEmbedResult> _orderedByPreference(
    List<StreamingEmbedResult> candidates,
    StreamingEmbedRequest request,
  ) {
    final preferredProviderId = request.preferredProviderId?.trim();
    if (preferredProviderId == null || preferredProviderId.isEmpty) {
      return List.unmodifiable(candidates);
    }
    final ordered = [...candidates];
    ordered.sort((a, b) {
      final aPreferred = a.server.providerId == preferredProviderId ? 0 : 1;
      final bPreferred = b.server.providerId == preferredProviderId ? 0 : 1;
      return aPreferred.compareTo(bPreferred);
    });
    return List.unmodifiable(ordered);
  }

  String _candidateKey(StreamingEmbedResult candidate) {
    return '${candidate.server.providerId}|${candidate.jellyfinPlaybackMode.name}|${candidate.url}';
  }

  List<StreamingEmbedResult> _applyProviderConfig({
    required List<StreamingEmbedResult> candidates,
    required List<ProviderConfigRecord> providerConfigs,
    required AppRemoteConfig remoteConfig,
  }) {
    if (candidates.isEmpty) {
      return const [];
    }
    final configsByProvider = {
      for (final config in providerConfigs) config.providerId.trim(): config,
    };
    final filtered = <StreamingEmbedResult>[];
    for (final candidate in candidates) {
      if (!_isProviderAllowed(candidate.server.providerId, remoteConfig)) {
        continue;
      }
      final providerConfig = configsByProvider[candidate.server.providerId];
      if (providerConfig != null &&
          (!providerConfig.enabled || providerConfig.maintenanceMode)) {
        continue;
      }
      filtered.add(
        providerConfig == null
            ? candidate
            : candidate.copyWith(
                server: _serverWithConfig(candidate.server, providerConfig),
              ),
      );
    }
    filtered.sort((a, b) => a.server.priority.compareTo(b.server.priority));
    return List.unmodifiable(filtered);
  }

  bool _isProviderAllowed(String providerId, AppRemoteConfig remoteConfig) {
    return switch (providerId) {
      'jellyfin_native' => remoteConfig.jellyfinEnabled &&
          remoteConfig.jellyfinNativeEnabled,
      'jellyfin_web' => remoteConfig.jellyfinEnabled &&
          remoteConfig.jellyfinWebEnabled,
      _ => true,
    };
  }

  StreamingServer _serverWithConfig(
    StreamingServer server,
    ProviderConfigRecord config,
  ) {
    return StreamingServer(
      id: server.id,
      providerId: server.providerId,
      displayName: config.displayName.trim().isEmpty
          ? server.displayName
          : config.displayName.trim(),
      priority: config.priority,
      baseUri: server.baseUri,
      supportedContentTypes: server.supportedContentTypes,
      urlBuilderStrategy: server.urlBuilderStrategy,
      enabled: config.enabled,
      timeout: server.timeout,
      movieTemplate: server.movieTemplate,
      episodeTemplate: server.episodeTemplate,
      allowHttpNavigation: server.allowHttpNavigation,
      privateProvider: server.privateProvider,
    );
  }
}
