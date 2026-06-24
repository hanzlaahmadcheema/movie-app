import '../models/tmdb_video.dart';

class PlayableTrailer {
  const PlayableTrailer({
    required this.site,
    required this.key,
    required this.title,
    required this.name,
  });

  final String site;
  final String key;
  final String title;
  final String name;

  Uri get embedUri {
    final normalizedSite = site.toLowerCase();
    if (normalizedSite == 'youtube') {
      return Uri.https('www.youtube.com', '/embed/$key', {
        'autoplay': '1',
        'rel': '0',
      });
    }
    if (normalizedSite == 'vimeo') {
      return Uri.https('player.vimeo.com', '/video/$key', {'autoplay': '1'});
    }
    return Uri();
  }

  Map<String, String> toRouteArguments() => {
    'site': site,
    'key': key,
    'title': title,
    'name': name,
  };

  static PlayableTrailer? fromRouteArguments(Object? arguments) {
    if (arguments is PlayableTrailer) {
      return arguments.isValid ? arguments : null;
    }
    if (arguments is! Map) {
      return null;
    }

    final site = arguments['site']?.toString().trim() ?? '';
    final key = arguments['key']?.toString().trim() ?? '';
    final title = arguments['title']?.toString().trim() ?? '';
    final name = arguments['name']?.toString().trim() ?? '';
    final trailer = PlayableTrailer(
      site: site,
      key: key,
      title: title.isEmpty ? 'Trailer' : title,
      name: name.isEmpty ? 'Trailer' : name,
    );
    return trailer.isValid ? trailer : null;
  }

  bool get isValid =>
      key.isNotEmpty &&
      (site.toLowerCase() == 'youtube' || site.toLowerCase() == 'vimeo') &&
      embedUri.isScheme('https');
}

class TrailerPicker {
  const TrailerPicker._();

  static PlayableTrailer? pick(
    List<TmdbVideo> videos, {
    required String title,
  }) {
    final playable = videos
        .where((video) => video.key.trim().isNotEmpty)
        .where((video) => _isSupportedSite(video.site))
        .toList();

    if (playable.isEmpty) {
      return null;
    }

    final selected =
        _firstWhereOrNull(playable, _isOfficialTrailer) ??
        _firstWhereOrNull(playable, _isTrailer) ??
        _firstWhereOrNull(playable, _isTeaser) ??
        playable.first;

    return PlayableTrailer(
      site: selected.site,
      key: selected.key,
      title: title,
      name: selected.name.isEmpty ? 'Trailer' : selected.name,
    );
  }

  static bool _isSupportedSite(String site) {
    final normalized = site.toLowerCase();
    return normalized == 'youtube' || normalized == 'vimeo';
  }

  static bool _isOfficialTrailer(TmdbVideo video) =>
      video.official && _isTrailer(video);

  static bool _isTrailer(TmdbVideo video) =>
      video.type.toLowerCase() == 'trailer';

  static bool _isTeaser(TmdbVideo video) =>
      video.type.toLowerCase() == 'teaser';

  static TmdbVideo? _firstWhereOrNull(
    List<TmdbVideo> videos,
    bool Function(TmdbVideo video) test,
  ) {
    for (final video in videos) {
      if (test(video)) {
        return video;
      }
    }
    return null;
  }
}
