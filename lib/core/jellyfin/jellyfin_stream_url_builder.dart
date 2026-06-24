import 'jellyfin_config.dart';
import 'jellyfin_playback_info.dart';

class JellyfinNativePlaybackCandidate {
  const JellyfinNativePlaybackCandidate({
    required this.streamUri,
    required this.headers,
    required this.itemId,
    required this.mediaSourceId,
    this.playbackSessionId,
    this.isTranscoding = false,
    this.isDirectStream = false,
    this.container,
    this.videoCodec,
    this.audioCodec,
    this.durationSeconds,
    this.resumePositionSeconds,
  });

  final Uri streamUri;
  final Map<String, String> headers;
  final String itemId;
  final String mediaSourceId;
  final String? playbackSessionId;
  final bool isTranscoding;
  final bool isDirectStream;
  final String? container;
  final String? videoCodec;
  final String? audioCodec;
  final int? durationSeconds;
  final int? resumePositionSeconds;
}

class JellyfinStreamSelectionException implements Exception {
  const JellyfinStreamSelectionException(this.message);

  final String message;

  @override
  String toString() => message;
}

class JellyfinStreamUrlBuilder {
  const JellyfinStreamUrlBuilder();

  JellyfinNativePlaybackCandidate buildCandidate({
    required JellyfinConfig config,
    required String itemId,
    required JellyfinPlaybackInfo playbackInfo,
    int? resumePositionSeconds,
  }) {
    final baseUri = config.baseUri;
    if (baseUri == null) {
      throw const JellyfinStreamSelectionException(
        'Invalid Jellyfin server URL.',
      );
    }
    if (playbackInfo.mediaSources.isEmpty) {
      throw const JellyfinStreamSelectionException(
        'No Jellyfin media sources found.',
      );
    }
    final source = _select(playbackInfo.mediaSources);
    final streamUri = _streamUri(baseUri, itemId, source);
    if (!_isAllowedStreamUri(baseUri, streamUri)) {
      throw const JellyfinStreamSelectionException(
        'Jellyfin stream host is not allowed.',
      );
    }
    return JellyfinNativePlaybackCandidate(
      streamUri: streamUri,
      headers: {'X-Emby-Token': config.accessToken.trim()},
      itemId: itemId,
      mediaSourceId: source.id,
      playbackSessionId: playbackInfo.playbackSessionId,
      isTranscoding: source.transcodingUrl?.trim().isNotEmpty == true,
      isDirectStream:
          source.directStreamUrl?.trim().isNotEmpty == true ||
          source.supportsDirectStream,
      container: source.container,
      videoCodec: source.videoCodec,
      audioCodec: source.audioCodec,
      durationSeconds: source.runtimeTicks == null
          ? null
          : (source.runtimeTicks! / 10000000).round(),
      resumePositionSeconds: resumePositionSeconds,
    );
  }

  JellyfinMediaSource _select(List<JellyfinMediaSource> sources) {
    final compatibleDirect = sources.where(_canDirectPlay).firstOrNull;
    if (compatibleDirect != null) return compatibleDirect;
    final transcoding = sources
        .where((source) => source.transcodingUrl?.trim().isNotEmpty == true)
        .firstOrNull;
    if (transcoding != null) return transcoding;
    final firstPlayable = sources
        .where((source) => source.directStreamUrl?.trim().isNotEmpty == true)
        .firstOrNull;
    if (firstPlayable != null) return firstPlayable;
    throw const JellyfinStreamSelectionException(
      'No native-compatible Jellyfin media source found.',
    );
  }

  bool _canDirectPlay(JellyfinMediaSource source) {
    final container = source.container?.toLowerCase() ?? '';
    return (source.supportsDirectPlay || source.supportsDirectStream) &&
        (container.contains('mp4') ||
            container.contains('m4v') ||
            container.contains('mov'));
  }

  Uri _streamUri(Uri baseUri, String itemId, JellyfinMediaSource source) {
    final relative = source.transcodingUrl?.trim().isNotEmpty == true
        ? source.transcodingUrl!.trim()
        : source.directStreamUrl?.trim().isNotEmpty == true
        ? source.directStreamUrl!.trim()
        : '/Videos/${Uri.encodeComponent(itemId)}/stream?Static=true&MediaSourceId=${Uri.encodeQueryComponent(source.id)}';
    final parsed = Uri.tryParse(relative);
    if (parsed != null && parsed.hasScheme) return parsed;
    return baseUri.resolve(relative.startsWith('/') ? relative : '/$relative');
  }

  bool _isAllowedStreamUri(Uri baseUri, Uri streamUri) {
    if (streamUri.host.toLowerCase() != baseUri.host.toLowerCase()) {
      return false;
    }
    if (streamUri.scheme == 'https') return true;
    return streamUri.scheme == 'http' &&
        baseUri.scheme == 'http' &&
        isAllowedPrivateHttpHost(streamUri.host);
  }
}

String redactedJellyfinStreamDebug(Uri uri) {
  return '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}${uri.path}';
}
