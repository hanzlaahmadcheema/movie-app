class JellyfinItem {
  const JellyfinItem({
    required this.id,
    required this.name,
    required this.type,
    this.providerIds = const {},
    this.seriesId,
    this.seasonId,
    this.parentId,
    this.seasonNumber,
    this.episodeNumber,
    this.productionYear,
    this.playbackPositionTicks,
    this.playedPercentage,
    this.imageTags = const {},
  });

  final String id;
  final String name;
  final String type;
  final Map<String, String> providerIds;
  final String? seriesId;
  final String? seasonId;
  final String? parentId;
  final int? seasonNumber;
  final int? episodeNumber;
  final int? productionYear;
  final int? playbackPositionTicks;
  final double? playedPercentage;
  final Map<String, String> imageTags;

  String? get tmdbId => _provider('Tmdb');
  String? get imdbId => _provider('Imdb');
  String? get tvdbId => _provider('Tvdb');
  bool get isMovie => type == 'Movie';
  bool get isSeries => type == 'Series';
  bool get isEpisode => type == 'Episode';

  factory JellyfinItem.fromJson(Map<String, dynamic> json) {
    return JellyfinItem(
      id: (json['Id'] ?? '').toString(),
      name: (json['Name'] ?? '').toString(),
      type: (json['Type'] ?? '').toString(),
      providerIds: _stringMap(json['ProviderIds']),
      seriesId: _nonEmpty(json['SeriesId']),
      seasonId: _nonEmpty(json['SeasonId']),
      parentId: _nonEmpty(json['ParentId']),
      seasonNumber: _asInt(json['ParentIndexNumber']),
      episodeNumber: _asInt(json['IndexNumber']),
      productionYear: _asInt(json['ProductionYear']),
      playbackPositionTicks: _asInt(json['UserData']?['PlaybackPositionTicks']),
      playedPercentage: _asDouble(json['UserData']?['PlayedPercentage']),
      imageTags: _stringMap(json['ImageTags']),
    );
  }

  String? _provider(String key) {
    return providerIds.entries
        .where((entry) => entry.key.toLowerCase() == key.toLowerCase())
        .map((entry) => entry.value.trim())
        .where((value) => value.isNotEmpty)
        .firstOrNull;
  }
}

Map<String, String> _stringMap(Object? value) {
  if (value is! Map) return const {};
  return value.map(
    (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
  )..removeWhere((key, value) => value.trim().isEmpty);
}

String? _nonEmpty(Object? value) {
  final text = value?.toString().trim();
  return text == null || text.isEmpty ? null : text;
}

int? _asInt(Object? value) {
  return switch (value) {
    int number => number,
    num number => number.toInt(),
    _ => int.tryParse(value?.toString() ?? ''),
  };
}

double? _asDouble(Object? value) {
  return switch (value) {
    double number => number,
    num number => number.toDouble(),
    _ => double.tryParse(value?.toString() ?? ''),
  };
}
