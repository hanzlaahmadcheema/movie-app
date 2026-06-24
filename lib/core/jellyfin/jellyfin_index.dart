import 'jellyfin_item.dart';

class JellyfinIndex {
  JellyfinIndex(Iterable<JellyfinItem> items) {
    for (final item in items) {
      if (item.isMovie) {
        _put(moviesByTmdbId, item.tmdbId, item);
        _put(moviesByImdbId, item.imdbId, item);
      } else if (item.isSeries) {
        _put(seriesByTmdbId, item.tmdbId, item);
        _put(seriesByImdbId, item.imdbId, item);
        _put(seriesByTvdbId, item.tvdbId, item);
      } else if (item.isEpisode &&
          item.seriesId != null &&
          item.seasonNumber != null &&
          item.episodeNumber != null) {
        episodesBySeriesSeasonEpisode[episodeKey(
              item.seriesId!,
              item.seasonNumber!,
              item.episodeNumber!,
            )] =
            item;
      }
    }
  }

  final Map<String, JellyfinItem> moviesByTmdbId = {};
  final Map<String, JellyfinItem> moviesByImdbId = {};
  final Map<String, JellyfinItem> seriesByTmdbId = {};
  final Map<String, JellyfinItem> seriesByImdbId = {};
  final Map<String, JellyfinItem> seriesByTvdbId = {};
  final Map<String, JellyfinItem> episodesBySeriesSeasonEpisode = {};

  JellyfinItem? episodeFor({
    required String seriesId,
    required int seasonNumber,
    required int episodeNumber,
  }) {
    return episodesBySeriesSeasonEpisode[episodeKey(
      seriesId,
      seasonNumber,
      episodeNumber,
    )];
  }

  static String episodeKey(
    String seriesId,
    int seasonNumber,
    int episodeNumber,
  ) {
    return '$seriesId|$seasonNumber|$episodeNumber';
  }
}

void _put(Map<String, JellyfinItem> map, String? key, JellyfinItem item) {
  final value = key?.trim();
  if (value == null || value.isEmpty) return;
  map[value] = item;
}
