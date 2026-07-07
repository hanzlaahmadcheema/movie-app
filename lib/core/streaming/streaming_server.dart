import 'streaming_content_type.dart';

enum StreamingUrlBuilderStrategy { vidSrc, template, indStream, jellyfinWeb }

class StreamingEndpoint {
  const StreamingEndpoint({
    required this.endpointId,
    required this.url,
    required this.priority,
    required this.enabled,
  });

  final String endpointId;
  final Uri url;
  final int priority;
  final bool enabled;
}

class StreamingServer {
  const StreamingServer({
    required this.id,
    required this.providerId,
    required this.displayName,
    required this.priority,
    required this.baseUri,
    required this.supportedContentTypes,
    required this.urlBuilderStrategy,
    required this.enabled,
    required this.timeout,
    this.movieTemplate,
    this.episodeTemplate,
    this.allowHttpNavigation = false,
    this.privateProvider = false,
    this.endpoints = const [],
  });

  final String id;
  final String providerId;
  final String displayName;
  final int priority;
  final Uri baseUri;
  final Set<StreamingContentType> supportedContentTypes;
  final StreamingUrlBuilderStrategy urlBuilderStrategy;
  final bool enabled;
  final Duration timeout;
  final String? movieTemplate;
  final String? episodeTemplate;
  final bool allowHttpNavigation;
  final bool privateProvider;
  final List<StreamingEndpoint> endpoints;

  bool supports(StreamingContentType contentType) {
    return supportedContentTypes.contains(contentType);
  }

  List<StreamingEndpoint> enabledEndpoints() {
    final configuredEndpoints = endpoints.isEmpty
        ? [
            StreamingEndpoint(
              endpointId: id,
              url: baseUri,
              priority: priority,
              enabled: enabled,
            ),
          ]
        : endpoints;
    final enabledEndpoints = configuredEndpoints
        .where((endpoint) => endpoint.enabled)
        .toList();
    enabledEndpoints.sort((a, b) => a.priority.compareTo(b.priority));
    return List.unmodifiable(enabledEndpoints);
  }
}
