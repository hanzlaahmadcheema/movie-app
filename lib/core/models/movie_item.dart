enum MediaType { movie, tv }

class MovieItem {
  const MovieItem({
    this.id = 0,
    required this.title,
    required this.type,
    required this.year,
    required this.quality,
    required this.posterUrl,
    this.mediaType = MediaType.movie,
    this.backdropUrl = '',
    this.posterPath,
    this.backdropPath,
    this.imdbId,
    this.originCountryCodes = const [],
    this.genreIds = const [],
    this.voteAverage = 0,
    this.releaseDate = '',
    this.description = '',
    this.rating = '7.8',
    this.duration = '104min',
  });

  final int id;
  final String title;
  final String type;
  final String year;
  final String quality;
  final String posterUrl;
  final MediaType mediaType;
  final String backdropUrl;
  final String? posterPath;
  final String? backdropPath;
  final String? imdbId;
  final List<String> originCountryCodes;
  final List<int> genreIds;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String rating;
  final String duration;

  MovieItem copyWith({
    int? id,
    String? title,
    String? type,
    String? year,
    String? quality,
    String? posterUrl,
    MediaType? mediaType,
    String? backdropUrl,
    String? posterPath,
    String? backdropPath,
    String? imdbId,
    List<String>? originCountryCodes,
    List<int>? genreIds,
    double? voteAverage,
    String? releaseDate,
    String? description,
    String? rating,
    String? duration,
  }) {
    return MovieItem(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      year: year ?? this.year,
      quality: quality ?? this.quality,
      posterUrl: posterUrl ?? this.posterUrl,
      mediaType: mediaType ?? this.mediaType,
      backdropUrl: backdropUrl ?? this.backdropUrl,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      imdbId: imdbId ?? this.imdbId,
      originCountryCodes: originCountryCodes ?? this.originCountryCodes,
      genreIds: genreIds ?? this.genreIds,
      voteAverage: voteAverage ?? this.voteAverage,
      releaseDate: releaseDate ?? this.releaseDate,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      duration: duration ?? this.duration,
    );
  }
}
