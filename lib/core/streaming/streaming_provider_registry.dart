import '../config/app_config.dart';
import 'streaming_content_type.dart';
import 'streaming_server.dart';

class StreamingProviderRegistry {
  StreamingProviderRegistry({
    required List<StreamingServer> servers,
    Iterable<String> additionalAllowedHosts = const [],
  }) : _servers = List.unmodifiable(servers),
       _additionalAllowedHosts = Set.unmodifiable(
         additionalAllowedHosts
             .map(_normalizeHost)
             .where((host) => host.isNotEmpty),
       );

  factory StreamingProviderRegistry.fromConfig(AppConfig config) {
    final timeout = Duration(seconds: config.streamingTimeoutSeconds);
    final servers = <StreamingServer>[];

    final videasyEndpoints = _endpointsFor(
      providerId: 'videasy',
      domains: config.streamingVideasyDomains,
    );
    if (videasyEndpoints.isNotEmpty) {
      servers.add(
        StreamingServer(
          id: 'videasy',
          providerId: 'videasy',
          displayName: 'Videasy',
          priority: 200,
          baseUri: videasyEndpoints.first.url,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.template,
          enabled:
              config.streamingVideasyEnabled &&
              config.streamingVideasyMovieTemplate.trim().isNotEmpty &&
              config.streamingVideasyEpisodeTemplate.trim().isNotEmpty,
          timeout: timeout,
          movieTemplate: config.streamingVideasyMovieTemplate,
          episodeTemplate: config.streamingVideasyEpisodeTemplate,
          endpoints: videasyEndpoints,
        ),
      );
    }

    final streamVaultEndpoints = _endpointsFor(
      providerId: 'streamvault',
      domains: config.streamingStreamVaultDomains,
    );
    if (streamVaultEndpoints.isNotEmpty) {
      servers.add(
        StreamingServer(
          id: 'streamvault',
          providerId: 'streamvault',
          displayName: 'StreamVault',
          priority: 300,
          baseUri: streamVaultEndpoints.first.url,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.template,
          enabled:
              config.streamingStreamVaultEnabled &&
              config.streamingStreamVaultMovieTemplate.trim().isNotEmpty &&
              config.streamingStreamVaultEpisodeTemplate.trim().isNotEmpty,
          timeout: timeout,
          movieTemplate: config.streamingStreamVaultMovieTemplate,
          episodeTemplate: config.streamingStreamVaultEpisodeTemplate,
          endpoints: streamVaultEndpoints,
        ),
      );
    }

    final oneElevenMoviesEndpoints = _endpointsFor(
      providerId: '111movies',
      domains: config.streamingOneElevenMoviesDomains,
    );
    if (oneElevenMoviesEndpoints.isNotEmpty) {
      servers.add(
        StreamingServer(
          id: '111movies',
          providerId: '111movies',
          displayName: '111Movies',
          priority: 400,
          baseUri: oneElevenMoviesEndpoints.first.url,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.template,
          enabled:
              config.streamingOneElevenMoviesEnabled &&
              config.streamingOneElevenMoviesMovieTemplate.trim().isNotEmpty &&
              config.streamingOneElevenMoviesEpisodeTemplate.trim().isNotEmpty,
          timeout: timeout,
          movieTemplate: config.streamingOneElevenMoviesMovieTemplate,
          episodeTemplate: config.streamingOneElevenMoviesEpisodeTemplate,
          endpoints: oneElevenMoviesEndpoints,
        ),
      );
    }

    final vidKingEndpoints = _endpointsFor(
      providerId: 'vidking',
      domains: config.streamingVidKingDomains,
    );
    if (vidKingEndpoints.isNotEmpty) {
      servers.add(
        StreamingServer(
          id: 'vidking',
          providerId: 'vidking',
          displayName: 'VidKing',
          priority: 450,
          baseUri: vidKingEndpoints.first.url,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.template,
          enabled:
              config.streamingVidKingEnabled &&
              config.streamingVidKingMovieTemplate.trim().isNotEmpty &&
              config.streamingVidKingEpisodeTemplate.trim().isNotEmpty,
          timeout: timeout,
          movieTemplate: config.streamingVidKingMovieTemplate,
          episodeTemplate: config.streamingVidKingEpisodeTemplate,
          endpoints: vidKingEndpoints,
        ),
      );
    }

    final hindiPlayerEndpoints = _endpointsFor(
      providerId: 'hindi_player',
      domains: config.streamingHindiPlayerDomains,
    );
    if (hindiPlayerEndpoints.isNotEmpty) {
      servers.add(
        StreamingServer(
          id: 'hindi_player',
          providerId: 'hindi_player',
          displayName: 'Hindi Player',
          priority: 500,
          baseUri: hindiPlayerEndpoints.first.url,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.indStream,
          enabled: config.streamingHindiPlayerEnabled,
          timeout: timeout,
          endpoints: hindiPlayerEndpoints,
        ),
      );
    }

    final nxshaEndpoints = _endpointsFor(
      providerId: 'nxsha',
      domains: config.streamingNxshaDomains,
    );
    if (nxshaEndpoints.isNotEmpty) {
      servers.add(
        StreamingServer(
          id: 'nxsha',
          providerId: 'nxsha',
          displayName: 'HA Player',
          priority: -10, // Default player
          baseUri: nxshaEndpoints.first.url,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.template,
          enabled:
              config.streamingNxshaEnabled &&
              config.streamingNxshaMovieTemplate.trim().isNotEmpty &&
              config.streamingNxshaEpisodeTemplate.trim().isNotEmpty,
          timeout: timeout,
          movieTemplate: config.streamingNxshaMovieTemplate,
          episodeTemplate: config.streamingNxshaEpisodeTemplate,
          endpoints: nxshaEndpoints,
        ),
      );
    }

    final vidSrcEndpoints = _endpointsFor(
      providerId: 'vidsrc',
      domains: config.streamingVidSrcDomains,
    );
    if (vidSrcEndpoints.isNotEmpty) {
      servers.add(
        StreamingServer(
          id: 'vidsrc',
          providerId: 'vidsrc',
          displayName: 'VidSrc',
          priority: 0,
          baseUri: vidSrcEndpoints.first.url,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.vidSrc,
          enabled: config.streamingVidSrcEnabled,
          timeout: timeout,
          endpoints: vidSrcEndpoints,
        ),
      );
    }

    final twoEmbedEndpoints = _endpointsFor(
      providerId: '2embed',
      domains: config.streamingTwoEmbedDomains,
    );
    if (twoEmbedEndpoints.isNotEmpty) {
      servers.add(
        StreamingServer(
          id: '2embed',
          providerId: '2embed',
          displayName: '2Embed',
          priority: 100,
          baseUri: twoEmbedEndpoints.first.url,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.template,
          enabled:
              config.streamingTwoEmbedEnabled &&
              config.streamingTwoEmbedMovieTemplate.trim().isNotEmpty &&
              config.streamingTwoEmbedEpisodeTemplate.trim().isNotEmpty,
          timeout: timeout,
          movieTemplate: config.streamingTwoEmbedMovieTemplate,
          episodeTemplate: config.streamingTwoEmbedEpisodeTemplate,
          endpoints: twoEmbedEndpoints,
        ),
      );
    }

    return StreamingProviderRegistry(
      servers: servers,
      additionalAllowedHosts: config.streamingAllowedHosts,
    );
  }

  final List<StreamingServer> _servers;
  final Set<String> _additionalAllowedHosts;

  List<StreamingServer> serversFor(StreamingContentType contentType) {
    final servers = _servers
        .where((server) => server.enabled && server.supports(contentType))
        .toList();
    servers.sort((a, b) => a.priority.compareTo(b.priority));
    return List.unmodifiable(servers);
  }

  Set<String> get allowedNavigationHosts {
    return {
      ..._servers
          .where((server) => server.enabled)
          .expand(
            (server) => server.enabledEndpoints().map(
              (endpoint) => _normalizeHost(endpoint.url.host),
            ),
          ),
      ..._additionalAllowedHosts,
    }..removeWhere((host) => host.isEmpty);
  }

  bool isAllowedNavigationHost(String host) {
    final normalized = _normalizeHost(host);
    return allowedNavigationHosts.any(
      (allowed) => normalized == allowed || normalized.endsWith('.$allowed'),
    );
  }

  bool isAllowedHttpNavigationHost(String host) {
    final normalized = _normalizeHost(host);
    return _servers.any(
      (server) =>
          server.enabled &&
          server.allowHttpNavigation &&
          server.enabledEndpoints().any(
            (endpoint) => _normalizeHost(endpoint.url.host) == normalized,
          ),
    );
  }
}

List<StreamingEndpoint> _endpointsFor({
  required String providerId,
  required List<String> domains,
}) {
  final seenHosts = <String>{};
  final endpoints = <StreamingEndpoint>[];
  for (final domain in domains) {
    final baseUri = _httpsUri(domain);
    if (baseUri == null) continue;
    final normalizedHost = _normalizeHost(baseUri.host);
    if (!seenHosts.add(normalizedHost)) continue;
    final index = endpoints.length;
    endpoints.add(
      StreamingEndpoint(
        endpointId: index == 0
            ? '${providerId}_primary'
            : '${providerId}_mirror_$index',
        url: baseUri,
        priority: index,
        enabled: true,
      ),
    );
  }
  return List.unmodifiable(endpoints);
}

Uri? _httpsUri(String value) {
  final uri = Uri.tryParse(value.trim());
  if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
    return null;
  }
  return uri;
}

String _normalizeHost(String value) {
  final parsed = Uri.tryParse(value.trim());
  return (parsed?.host.isNotEmpty == true ? parsed!.host : value)
      .trim()
      .toLowerCase()
      .replaceFirst(RegExp(r'^www\.'), '');
}
