import '../models/movie_item.dart';
import 'streaming_content_type.dart';

class StreamingEmbedRequest {
  const StreamingEmbedRequest({
    required this.contentType,
    required this.title,
    this.tmdbId,
    this.imdbId,
    this.seasonNumber,
    this.episodeNumber,
    this.episodeTitle,
    this.posterUrl,
    this.backdropUrl,
    this.sourceItem,
    this.preferredProviderId,
    this.jellyfinPlaybackModeOverride,
    this.resumePositionSeconds,
    this.resumeDurationSeconds,
    this.skipJellyfin = false,
  });

  final StreamingContentType contentType;
  final String title;
  final int? tmdbId;
  final String? imdbId;
  final int? seasonNumber;
  final int? episodeNumber;
  final String? episodeTitle;
  final String? posterUrl;
  final String? backdropUrl;
  final MovieItem? sourceItem;
  final String? preferredProviderId;
  final String? jellyfinPlaybackModeOverride;
  final int? resumePositionSeconds;
  final int? resumeDurationSeconds;
  final bool skipJellyfin;

  factory StreamingEmbedRequest.movie(MovieItem item, {String? imdbId}) {
    return StreamingEmbedRequest(
      contentType: StreamingContentType.movie,
      title: item.title,
      tmdbId: item.id > 0 ? item.id : null,
      imdbId: imdbId,
      posterUrl: item.posterUrl,
      backdropUrl: item.backdropUrl,
      sourceItem: item,
    );
  }

  factory StreamingEmbedRequest.episode({
    required MovieItem item,
    required int seasonNumber,
    required int episodeNumber,
    String? episodeTitle,
    String? imdbId,
  }) {
    return StreamingEmbedRequest(
      contentType: StreamingContentType.episode,
      title: item.title,
      tmdbId: item.id > 0 ? item.id : null,
      imdbId: imdbId,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      episodeTitle: episodeTitle,
      posterUrl: item.posterUrl,
      backdropUrl: item.backdropUrl,
      sourceItem: item,
    );
  }

  static StreamingEmbedRequest? fromRouteArguments(Object? arguments) {
    if (arguments is StreamingEmbedRequest) {
      return arguments;
    }
    if (arguments is! Map) {
      return null;
    }

    final contentType = StreamingContentTypeValue.fromValue(
      arguments['contentType'],
    );
    if (contentType == null) {
      return null;
    }

    return StreamingEmbedRequest(
      contentType: contentType,
      title: arguments['title']?.toString() ?? '',
      tmdbId: _asPositiveInt(arguments['tmdbId']),
      imdbId: arguments['imdbId']?.toString(),
      seasonNumber: _asPositiveInt(arguments['seasonNumber']),
      episodeNumber: _asPositiveInt(arguments['episodeNumber']),
      episodeTitle: arguments['episodeTitle']?.toString(),
      posterUrl: arguments['posterUrl']?.toString(),
      backdropUrl: arguments['backdropUrl']?.toString(),
      preferredProviderId: arguments['preferredProviderId']?.toString(),
      jellyfinPlaybackModeOverride: arguments['jellyfinPlaybackMode']
          ?.toString(),
      resumePositionSeconds: _asNonNegativeInt(
        arguments['resumePositionSeconds'],
      ),
      resumeDurationSeconds: _asPositiveInt(arguments['resumeDurationSeconds']),
      skipJellyfin: arguments['skipJellyfin'] == true,
    );
  }

  StreamingEmbedRequest copyWith({
    String? preferredProviderId,
    String? jellyfinPlaybackModeOverride,
    int? resumePositionSeconds,
    int? resumeDurationSeconds,
    bool? skipJellyfin,
  }) {
    return StreamingEmbedRequest(
      contentType: contentType,
      title: title,
      tmdbId: tmdbId,
      imdbId: imdbId,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      episodeTitle: episodeTitle,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      sourceItem: sourceItem,
      preferredProviderId: preferredProviderId ?? this.preferredProviderId,
      jellyfinPlaybackModeOverride:
          jellyfinPlaybackModeOverride ?? this.jellyfinPlaybackModeOverride,
      resumePositionSeconds:
          resumePositionSeconds ?? this.resumePositionSeconds,
      resumeDurationSeconds:
          resumeDurationSeconds ?? this.resumeDurationSeconds,
      skipJellyfin: skipJellyfin ?? this.skipJellyfin,
    );
  }

  Map<String, Object?> toRouteArguments() {
    return {
      'contentType': contentType.value,
      'title': title,
      'tmdbId': tmdbId,
      'imdbId': imdbId,
      'seasonNumber': seasonNumber,
      'episodeNumber': episodeNumber,
      'episodeTitle': episodeTitle,
      'posterUrl': posterUrl,
      'backdropUrl': backdropUrl,
      'preferredProviderId': preferredProviderId,
      'jellyfinPlaybackMode': jellyfinPlaybackModeOverride,
      'resumePositionSeconds': resumePositionSeconds,
      'resumeDurationSeconds': resumeDurationSeconds,
      'skipJellyfin': skipJellyfin,
    };
  }

  String? validate() {
    if (title.trim().isEmpty) {
      return 'Missing title';
    }
    if (!hasUsableId) {
      return 'Missing TMDB or IMDb ID';
    }
    if (contentType == StreamingContentType.episode) {
      if (seasonNumber == null || seasonNumber! <= 0) {
        return 'Missing season number';
      }
      if (episodeNumber == null || episodeNumber! <= 0) {
        return 'Missing episode number';
      }
    }
    return null;
  }

  bool get hasUsableId =>
      (tmdbId != null && tmdbId! > 0) || normalizedImdbId != null;

  String? get normalizedImdbId {
    final value = imdbId?.trim();
    if (value == null || !RegExp(r'^tt\d+$').hasMatch(value)) {
      return null;
    }
    return value;
  }

  String? get preferredId {
    if (tmdbId != null && tmdbId! > 0) {
      return tmdbId.toString();
    }
    return normalizedImdbId;
  }

  MovieItem get activityItem {
    return sourceItem ??
        MovieItem(
          id: tmdbId ?? 0,
          title: title,
          type: contentType == StreamingContentType.movie ? 'Movie' : 'Series',
          year: 'N/A',
          quality: 'HD',
          posterUrl: posterUrl ?? '',
          backdropUrl: backdropUrl ?? '',
          mediaType: contentType == StreamingContentType.movie
              ? MediaType.movie
              : MediaType.tv,
        );
  }
}

int? _asPositiveInt(Object? value) {
  final parsed = switch (value) {
    int number => number,
    num number => number.toInt(),
    _ => int.tryParse(value?.toString() ?? ''),
  };
  return parsed != null && parsed > 0 ? parsed : null;
}

int? _asNonNegativeInt(Object? value) {
  final parsed = switch (value) {
    int number => number,
    num number => number.toInt(),
    _ => int.tryParse(value?.toString() ?? ''),
  };
  return parsed != null && parsed >= 0 ? parsed : null;
}
