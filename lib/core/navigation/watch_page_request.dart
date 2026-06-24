import '../models/movie_item.dart';

class WatchPageRequest {
  const WatchPageRequest({
    required this.item,
    this.seasonNumber,
    this.episodeNumber,
    this.autoPlay = false,
    this.selectedProviderId,
    this.jellyfinItemId,
    this.playbackMode,
    this.resumePositionSeconds,
    this.resumeDurationSeconds,
  });

  final MovieItem item;
  final int? seasonNumber;
  final int? episodeNumber;
  final bool autoPlay;
  final String? selectedProviderId;
  final String? jellyfinItemId;
  final String? playbackMode;
  final int? resumePositionSeconds;
  final int? resumeDurationSeconds;

  static WatchPageRequest? fromRouteArguments(Object? arguments) {
    if (arguments is WatchPageRequest) {
      return arguments;
    }
    if (arguments is MovieItem) {
      return WatchPageRequest(item: arguments);
    }
    return null;
  }
}
