import '../jellyfin/jellyfin_config.dart';
import 'streaming_server.dart';

class StreamingResolvedEndpoint {
  const StreamingResolvedEndpoint({
    required this.endpointId,
    required this.url,
  });

  final String endpointId;
  final Uri url;
}

class StreamingEmbedResult {
  const StreamingEmbedResult({
    required this.server,
    required this.url,
    this.endpointId,
    this.endpoints = const [],
    this.jellyfinItemId,
    this.matchReason,
    this.jellyfinPlaybackMode = JellyfinPlaybackMode.auto,
  });

  final StreamingServer server;
  final Uri url;
  final String? endpointId;
  final List<StreamingResolvedEndpoint> endpoints;
  final String? jellyfinItemId;
  final String? matchReason;
  final JellyfinPlaybackMode jellyfinPlaybackMode;

  List<StreamingResolvedEndpoint> get resolvedEndpoints {
    if (endpoints.isNotEmpty) {
      return endpoints;
    }
    return [
      StreamingResolvedEndpoint(endpointId: endpointId ?? server.id, url: url),
    ];
  }

  StreamingEmbedResult withResolvedEndpoint(int index) {
    final resolved = resolvedEndpoints;
    if (index < 0 || index >= resolved.length) {
      return this;
    }
    final endpoint = resolved[index];
    return copyWith(url: endpoint.url, endpointId: endpoint.endpointId);
  }

  StreamingEmbedResult copyWith({
    StreamingServer? server,
    Uri? url,
    String? endpointId,
    List<StreamingResolvedEndpoint>? endpoints,
    String? jellyfinItemId,
    bool clearJellyfinItemId = false,
    String? matchReason,
    bool clearMatchReason = false,
    JellyfinPlaybackMode? jellyfinPlaybackMode,
  }) {
    return StreamingEmbedResult(
      server: server ?? this.server,
      url: url ?? this.url,
      endpointId: endpointId ?? this.endpointId,
      endpoints: endpoints ?? this.endpoints,
      jellyfinItemId: clearJellyfinItemId
          ? null
          : jellyfinItemId ?? this.jellyfinItemId,
      matchReason: clearMatchReason ? null : matchReason ?? this.matchReason,
      jellyfinPlaybackMode: jellyfinPlaybackMode ?? this.jellyfinPlaybackMode,
    );
  }
}
