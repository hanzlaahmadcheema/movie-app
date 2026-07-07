import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../features/search/search_screens.dart';
import '../models/movie_item.dart';
import 'watch_page_request.dart';
import '../services/user_activity_repository.dart';
import '../streaming/streaming_embed_request.dart';

String detailRouteForItem(MovieItem item) {
  return AppRoutes.detailPathForItem(item);
}

String watchRouteForItem(MovieItem item) {
  return AppRoutes.watchPathForItem(item);
}

void openDetailForItem(BuildContext context, MovieItem item) {
  Navigator.pushNamed(context, detailRouteForItem(item), arguments: item);
}

void openWatchForItem(BuildContext context, MovieItem item) {
  Navigator.pushNamed(
    context,
    watchRouteForItem(item),
    arguments: WatchPageRequest(item: item),
  );
}

void openMovieStream(BuildContext context, MovieItem item) {
  Navigator.pushNamed(
    context,
    AppRoutes.streaming,
    arguments: StreamingEmbedRequest.movie(item),
  );
}

void openEpisodeStream(
  BuildContext context, {
  required MovieItem item,
  required int seasonNumber,
  required int episodeNumber,
  String? episodeTitle,
}) {
  Navigator.pushNamed(
    context,
    AppRoutes.streaming,
    arguments: StreamingEmbedRequest.episode(
      item: item,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      episodeTitle: episodeTitle,
    ),
  );
}

ContinueWatchingDestination continueWatchingDestinationForRecord(
  UserContentRecord record,
) {
  final item = record.item;
  final activity = record.activity;
  if (item.mediaType == MediaType.movie) {
    return ContinueWatchingDestination.movieWatch;
  }
  if (activity.seasonNumber != null && activity.episodeNumber != null) {
    return ContinueWatchingDestination.episodeStream;
  }
  return ContinueWatchingDestination.seriesSelection;
}

void openContinueWatchingRecord(
  BuildContext context,
  UserContentRecord record,
) {
  final request = watchPageRequestForRecord(record);
  switch (continueWatchingDestinationForRecord(record)) {
    case ContinueWatchingDestination.movieWatch:
      Navigator.pushNamed(
        context,
        AppRoutes.watchPathForRequest(request),
        arguments: request,
      );
    case ContinueWatchingDestination.episodeStream:
      Navigator.pushNamed(
        context,
        AppRoutes.watchPathForRequest(request),
        arguments: request,
      );
    case ContinueWatchingDestination.seriesSelection:
      Navigator.pushNamed(
        context,
        AppRoutes.watchPathForRequest(request),
        arguments: request,
      );
  }
}

enum ContinueWatchingDestination { movieWatch, episodeStream, seriesSelection }

WatchPageRequest watchPageRequestForRecord(UserContentRecord record) {
  final item = record.item;
  final activity = record.activity;
  final selectedProviderId = _preferredProviderIdForActivity(activity);
  return switch (continueWatchingDestinationForRecord(record)) {
    ContinueWatchingDestination.movieWatch => WatchPageRequest(
      item: item,
      autoPlay: true,
      selectedProviderId: selectedProviderId,
      jellyfinItemId: activity.jellyfinItemId,
      playbackMode: activity.playbackMode,
      resumePositionSeconds: activity.positionSeconds,
      resumeDurationSeconds: activity.durationSeconds,
    ),
    ContinueWatchingDestination.episodeStream => WatchPageRequest(
      item: item,
      seasonNumber: activity.seasonNumber,
      episodeNumber: activity.episodeNumber,
      autoPlay: true,
      selectedProviderId: selectedProviderId,
      jellyfinItemId: activity.jellyfinItemId,
      playbackMode: activity.playbackMode,
      resumePositionSeconds: activity.positionSeconds,
      resumeDurationSeconds: activity.durationSeconds,
    ),
    ContinueWatchingDestination.seriesSelection => WatchPageRequest(
      item: item,
      seasonNumber: activity.seasonNumber,
      autoPlay: false,
      selectedProviderId: selectedProviderId,
      jellyfinItemId: activity.jellyfinItemId,
      playbackMode: activity.playbackMode,
      resumePositionSeconds: activity.positionSeconds,
      resumeDurationSeconds: activity.durationSeconds,
    ),
  };
}

void openSearchResult(BuildContext context, String title) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (_) => SearchResultScreen(title: title, query: title),
    ),
  );
}

void openGenreBrowse(BuildContext context, String title) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (_) => SearchResultScreen(
        title: title,
        mode: ExploreMode.genre,
        query: title,
      ),
    ),
  );
}

void openCountryBrowse(BuildContext context, String title) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (_) => SearchResultScreen(
        title: title,
        mode: ExploreMode.country,
        query: title,
      ),
    ),
  );
}

void openProductionBrowse(BuildContext context, String title) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (_) => SearchResultScreen(
        title: title,
        mode: ExploreMode.production,
        query: title,
      ),
    ),
  );
}

void openCastDetail(BuildContext context, String query) {
  Navigator.pushNamed(context, AppRoutes.castDetail, arguments: query);
}

String? _preferredProviderIdForActivity(UserActivity activity) {
  if (activity.providerId == 'jellyfin_native' ||
      activity.providerId == 'jellyfin_web') {
    return activity.providerId;
  }
  if (activity.providerId == 'jellyfin_private') {
    return activity.playbackMode == 'web' ? 'jellyfin_web' : 'jellyfin_native';
  }
  return activity.providerId;
}
