class TmdbVideo {
  const TmdbVideo({
    required this.name,
    required this.key,
    required this.site,
    required this.type,
    required this.official,
  });

  final String name;
  final String key;
  final String site;
  final String type;
  final bool official;

  String get youtubeUrl => site.toLowerCase() == 'youtube'
      ? 'https://www.youtube.com/watch?v=$key'
      : '';
}
