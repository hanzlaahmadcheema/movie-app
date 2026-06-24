import '../jellyfin/jellyfin_config.dart';
import 'streaming_server.dart';

class StreamingEmbedResult {
  const StreamingEmbedResult({
    required this.server,
    required this.url,
    this.jellyfinItemId,
    this.matchReason,
    this.jellyfinPlaybackMode = JellyfinPlaybackMode.auto,
  });

  final StreamingServer server;
  final Uri url;
  final String? jellyfinItemId;
  final String? matchReason;
  final JellyfinPlaybackMode jellyfinPlaybackMode;

  StreamingEmbedResult copyWith({
    StreamingServer? server,
    Uri? url,
    String? jellyfinItemId,
    bool clearJellyfinItemId = false,
    String? matchReason,
    bool clearMatchReason = false,
    JellyfinPlaybackMode? jellyfinPlaybackMode,
  }) {
    return StreamingEmbedResult(
      server: server ?? this.server,
      url: url ?? this.url,
      jellyfinItemId: clearJellyfinItemId
          ? null
          : jellyfinItemId ?? this.jellyfinItemId,
      matchReason: clearMatchReason ? null : matchReason ?? this.matchReason,
      jellyfinPlaybackMode:
          jellyfinPlaybackMode ?? this.jellyfinPlaybackMode,
    );
  }
}
