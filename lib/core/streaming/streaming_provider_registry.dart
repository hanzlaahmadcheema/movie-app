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

    for (var index = 0; index < config.streamingVidSrcDomains.length; index++) {
      final baseUri = _httpsUri(config.streamingVidSrcDomains[index]);
      if (baseUri == null) continue;
      servers.add(
        StreamingServer(
          id: 'vidsrc-${index + 1}',
          providerId: 'vidsrc',
          displayName: 'VidSrc',
          priority: index,
          baseUri: baseUri,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.vidSrc,
          enabled: config.streamingVidSrcEnabled,
          timeout: timeout,
        ),
      );
    }

    for (
      var index = 0;
      index < config.streamingTwoEmbedDomains.length;
      index++
    ) {
      final baseUri = _httpsUri(config.streamingTwoEmbedDomains[index]);
      if (baseUri == null) continue;
      servers.add(
        StreamingServer(
          id: '2embed-${index + 1}',
          providerId: '2embed',
          displayName: '2Embed',
          priority: 100 + index,
          baseUri: baseUri,
          supportedContentTypes: StreamingContentType.values.toSet(),
          urlBuilderStrategy: StreamingUrlBuilderStrategy.template,
          enabled:
              config.streamingTwoEmbedEnabled &&
              config.streamingTwoEmbedMovieTemplate.trim().isNotEmpty &&
              config.streamingTwoEmbedEpisodeTemplate.trim().isNotEmpty,
          timeout: timeout,
          movieTemplate: config.streamingTwoEmbedMovieTemplate,
          episodeTemplate: config.streamingTwoEmbedEpisodeTemplate,
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
          .map((server) => _normalizeHost(server.baseUri.host)),
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
          _normalizeHost(server.baseUri.host) == normalized,
    );
  }
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
