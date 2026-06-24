import 'jellyfin_index.dart';
import 'jellyfin_item.dart';

enum JellyfinMatchReason {
  matchedByTmdb,
  matchedByImdb,
  jellyfinDisabled,
  jellyfinUnreachable,
  missingTmdbId,
  notInLibrary,
  seriesFoundEpisodeMissing,
  episodeNumberMissing,
  seasonNumberMissing,
  invalidConfig,
}

class JellyfinMatchResult {
  const JellyfinMatchResult({
    required this.found,
    required this.reason,
    this.itemId,
    this.itemType,
    this.title,
    this.matchedBy,
  });

  final bool found;
  final JellyfinMatchReason reason;
  final String? itemId;
  final String? itemType;
  final String? title;
  final String? matchedBy;

  factory JellyfinMatchResult.found(
    JellyfinItem item, {
    required JellyfinMatchReason reason,
    required String matchedBy,
  }) {
    return JellyfinMatchResult(
      found: true,
      reason: reason,
      itemId: item.id,
      itemType: item.type.toLowerCase(),
      title: item.name,
      matchedBy: matchedBy,
    );
  }

  const JellyfinMatchResult.miss(this.reason)
    : found = false,
      itemId = null,
      itemType = null,
      title = null,
      matchedBy = null;
}

class JellyfinMatcher {
  const JellyfinMatcher(this.index);

  final JellyfinIndex index;

  JellyfinMatchResult findMovie({int? tmdbId, String? imdbId}) {
    if (tmdbId != null && tmdbId > 0) {
      final item = index.moviesByTmdbId[tmdbId.toString()];
      if (item != null) {
        return JellyfinMatchResult.found(
          item,
          reason: JellyfinMatchReason.matchedByTmdb,
          matchedBy: 'tmdb',
        );
      }
    }
    final normalizedImdb = _normalizedImdb(imdbId);
    if (normalizedImdb != null) {
      final item = index.moviesByImdbId[normalizedImdb];
      if (item != null) {
        return JellyfinMatchResult.found(
          item,
          reason: JellyfinMatchReason.matchedByImdb,
          matchedBy: 'imdb',
        );
      }
    }
    return const JellyfinMatchResult.miss(JellyfinMatchReason.notInLibrary);
  }

  JellyfinMatchResult findEpisode({
    int? tmdbSeriesId,
    String? imdbSeriesId,
    required int? seasonNumber,
    required int? episodeNumber,
  }) {
    if (seasonNumber == null || seasonNumber <= 0) {
      return const JellyfinMatchResult.miss(
        JellyfinMatchReason.seasonNumberMissing,
      );
    }
    if (episodeNumber == null || episodeNumber <= 0) {
      return const JellyfinMatchResult.miss(
        JellyfinMatchReason.episodeNumberMissing,
      );
    }

    JellyfinItem? series;
    var matchedBy = 'none';
    var reason = JellyfinMatchReason.notInLibrary;
    if (tmdbSeriesId != null && tmdbSeriesId > 0) {
      series = index.seriesByTmdbId[tmdbSeriesId.toString()];
      matchedBy = 'tmdb';
      reason = JellyfinMatchReason.matchedByTmdb;
    }
    final normalizedImdb = _normalizedImdb(imdbSeriesId);
    if (series == null && normalizedImdb != null) {
      series = index.seriesByImdbId[normalizedImdb];
      matchedBy = 'imdb';
      reason = JellyfinMatchReason.matchedByImdb;
    }
    if (series == null) {
      return const JellyfinMatchResult.miss(JellyfinMatchReason.notInLibrary);
    }
    final episode = index.episodeFor(
      seriesId: series.id,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
    );
    if (episode == null) {
      return const JellyfinMatchResult.miss(
        JellyfinMatchReason.seriesFoundEpisodeMissing,
      );
    }
    return JellyfinMatchResult.found(
      episode,
      reason: reason,
      matchedBy: matchedBy,
    );
  }
}

String? _normalizedImdb(String? value) {
  final text = value?.trim();
  if (text == null || !RegExp(r'^tt\d+$').hasMatch(text)) return null;
  return text;
}
