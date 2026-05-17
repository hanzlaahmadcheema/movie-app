import 'movie_item.dart';

class TmdbPerson {
  const TmdbPerson({
    required this.id,
    required this.name,
    required this.biography,
    required this.profilePath,
    required this.knownFor,
    required this.birthday,
    required this.placeOfBirth,
  });

  final int id;
  final String name;
  final String biography;
  final String profilePath;
  final List<MovieItem> knownFor;
  final String birthday;
  final String placeOfBirth;
}
