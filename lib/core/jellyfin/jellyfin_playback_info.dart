class JellyfinPlaybackInfo {
  const JellyfinPlaybackInfo({
    required this.mediaSources,
    this.playbackSessionId,
  });

  final List<JellyfinMediaSource> mediaSources;
  final String? playbackSessionId;

  factory JellyfinPlaybackInfo.fromJson(Map<String, dynamic> json) {
    final sources = json['MediaSources'] is List
        ? (json['MediaSources'] as List)
              .whereType<Map<String, dynamic>>()
              .map(JellyfinMediaSource.fromJson)
              .where((source) => source.id.isNotEmpty)
              .toList(growable: false)
        : const <JellyfinMediaSource>[];
    return JellyfinPlaybackInfo(
      mediaSources: sources,
      playbackSessionId: json['PlaySessionId']?.toString(),
    );
  }
}

class JellyfinMediaSource {
  const JellyfinMediaSource({
    required this.id,
    this.container,
    this.videoCodec,
    this.audioCodec,
    this.bitrate,
    this.runtimeTicks,
    this.path,
    this.transcodingUrl,
    this.directStreamUrl,
    this.supportsDirectPlay = false,
    this.supportsDirectStream = false,
    this.supportsTranscoding = false,
    this.playMethod,
    this.mediaStreams = const [],
  });

  final String id;
  final String? container;
  final String? videoCodec;
  final String? audioCodec;
  final int? bitrate;
  final int? runtimeTicks;
  final String? path;
  final String? transcodingUrl;
  final String? directStreamUrl;
  final bool supportsDirectPlay;
  final bool supportsDirectStream;
  final bool supportsTranscoding;
  final String? playMethod;
  final List<JellyfinMediaStream> mediaStreams;

  factory JellyfinMediaSource.fromJson(Map<String, dynamic> json) {
    final streams = json['MediaStreams'] is List
        ? (json['MediaStreams'] as List)
              .whereType<Map<String, dynamic>>()
              .map(JellyfinMediaStream.fromJson)
              .toList(growable: false)
        : const <JellyfinMediaStream>[];
    final video = streams.where((stream) => stream.type == 'Video').firstOrNull;
    final audio = streams.where((stream) => stream.type == 'Audio').firstOrNull;
    return JellyfinMediaSource(
      id: (json['Id'] ?? '').toString(),
      container: json['Container']?.toString(),
      videoCodec: json['VideoCodec']?.toString() ?? video?.codec,
      audioCodec: json['AudioCodec']?.toString() ?? audio?.codec,
      bitrate: _asInt(json['Bitrate']),
      runtimeTicks: _asInt(json['RunTimeTicks']),
      path: json['Path']?.toString(),
      transcodingUrl: json['TranscodingUrl']?.toString(),
      directStreamUrl: json['DirectStreamUrl']?.toString(),
      supportsDirectPlay: json['SupportsDirectPlay'] == true,
      supportsDirectStream: json['SupportsDirectStream'] == true,
      supportsTranscoding: json['SupportsTranscoding'] == true,
      playMethod: json['PlayMethod']?.toString(),
      mediaStreams: streams,
    );
  }
}

class JellyfinMediaStream {
  const JellyfinMediaStream({
    this.index,
    this.type,
    this.codec,
    this.language,
    this.displayTitle,
    this.isExternal = false,
  });

  final int? index;
  final String? type;
  final String? codec;
  final String? language;
  final String? displayTitle;
  final bool isExternal;

  factory JellyfinMediaStream.fromJson(Map<String, dynamic> json) {
    return JellyfinMediaStream(
      index: _asInt(json['Index']),
      type: json['Type']?.toString(),
      codec: json['Codec']?.toString(),
      language: json['Language']?.toString(),
      displayTitle: json['DisplayTitle']?.toString(),
      isExternal: json['IsExternal'] == true,
    );
  }
}

int? _asInt(Object? value) {
  return switch (value) {
    int number => number,
    num number => number.toInt(),
    _ => int.tryParse(value?.toString() ?? ''),
  };
}
