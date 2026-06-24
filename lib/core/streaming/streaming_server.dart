import 'streaming_content_type.dart';

enum StreamingUrlBuilderStrategy { vidSrc, template, jellyfinWeb }

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

  bool supports(StreamingContentType contentType) {
    return supportedContentTypes.contains(contentType);
  }
}
