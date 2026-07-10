class TmdbCast {
  const TmdbCast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  final int id;
  final String name;
  final String character;
  final String profilePath;

  factory TmdbCast.fromJson(Map<String, dynamic> json) {
    return TmdbCast(
      id: json['id'] as int? ?? 0,
      name: json['name']?.toString() ?? '',
      character: json['character']?.toString() ?? '',
      profilePath: json['profile_path']?.toString() ?? '',
    );
  }
}
