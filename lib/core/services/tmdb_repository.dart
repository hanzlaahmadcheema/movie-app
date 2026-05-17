import '../config/app_config.dart';
import '../models/detail_item.dart';
import '../models/movie_item.dart';
import 'tmdb_api_client.dart';

class TmdbDetail {
  const TmdbDetail({
    required this.item,
    required this.info,
    required this.related,
  });

  final MovieItem item;
  final List<DetailInfo> info;
  final List<MovieItem> related;
}

class TmdbRepository {
  TmdbRepository({required AppConfig config, TmdbApiClient? client})
    : _config = config,
      _client = client ?? TmdbApiClient(config: config);

  final AppConfig _config;
  final TmdbApiClient _client;

  Future<List<MovieItem>> trendingMovies() => _list('/trending/movie/week');

  Future<List<MovieItem>> trendingSeries() => _list('/trending/tv/week');

  Future<List<MovieItem>> latestMovies() => _list('/movie/now_playing');

  Future<List<MovieItem>> latestSeries() => _list('/tv/on_the_air');

  Future<List<MovieItem>> discoverMovies() => _list('/discover/movie');

  Future<List<MovieItem>> discoverSeries() => _list('/discover/tv');

  Future<List<MovieItem>> search(String query) async {
    if (query.trim().isEmpty) {
      return trendingMovies();
    }
    return _list('/search/multi', query: {'query': query.trim()});
  }

  Future<TmdbDetail> detail(MovieItem seed) async {
    final mediaType = seed.mediaType == MediaType.tv ? 'tv' : 'movie';
    final data = await _client.get('/$mediaType/${seed.id}');
    final credits = await _client.get('/$mediaType/${seed.id}/credits');
    final similar = await _list('/$mediaType/${seed.id}/similar');
    final item = _itemFromJson(data, fallbackMediaType: seed.mediaType);

    return TmdbDetail(
      item: item.copyWith(
        posterUrl: item.posterUrl.isEmpty ? seed.posterUrl : null,
      ),
      info: _detailInfo(data, credits, item),
      related: similar.isEmpty ? [seed] : similar,
    );
  }

  Future<List<MovieItem>> _list(
    String path, {
    Map<String, String?> query = const {},
  }) async {
    final data = await _client.get(path, query: query);
    final results = data['results'];
    if (results is! List) {
      return const [];
    }

    return results
        .whereType<Map<String, dynamic>>()
        .map(_itemFromJson)
        .where((item) => item.title.isNotEmpty && item.posterUrl.isNotEmpty)
        .toList();
  }

  MovieItem _itemFromJson(
    Map<String, dynamic> json, {
    MediaType? fallbackMediaType,
  }) {
    final mediaType = _mediaType(
      json['media_type'] as String?,
      fallbackMediaType,
    );
    final title = (json['title'] ?? json['name'] ?? '').toString();
    final releaseDate = (json['release_date'] ?? json['first_air_date'] ?? '')
        .toString();
    final posterPath = json['poster_path']?.toString();
    final backdropPath = json['backdrop_path']?.toString();
    final runtime = json['runtime'] ?? json['episode_run_time'];
    final genreIds = json['genre_ids'] is List
        ? (json['genre_ids'] as List).whereType<int>().toList()
        : const <int>[];

    return MovieItem(
      id: json['id'] is int ? json['id'] as int : 0,
      title: title,
      type: mediaType == MediaType.tv ? 'Series' : 'Movie',
      mediaType: mediaType,
      year: releaseDate.length >= 4 ? releaseDate.substring(0, 4) : 'N/A',
      quality: 'HD',
      posterUrl: _config.posterUrl(posterPath),
      backdropUrl: _config.backdropUrl(backdropPath),
      posterPath: posterPath,
      backdropPath: backdropPath,
      genreIds: genreIds,
      releaseDate: releaseDate,
      description: (json['overview'] ?? '').toString(),
      rating: ((json['vote_average'] as num?) ?? 0).toStringAsFixed(1),
      voteAverage: ((json['vote_average'] as num?) ?? 0).toDouble(),
      duration: _duration(runtime),
    );
  }

  MediaType _mediaType(String? mediaType, MediaType? fallback) {
    if (mediaType == 'tv') {
      return MediaType.tv;
    }
    if (mediaType == 'movie') {
      return MediaType.movie;
    }
    return fallback ?? MediaType.movie;
  }

  String _duration(Object? runtime) {
    if (runtime is int && runtime > 0) {
      return '${runtime}min';
    }
    if (runtime is List && runtime.isNotEmpty && runtime.first is int) {
      return '${runtime.first}min';
    }
    return 'N/A';
  }

  List<DetailInfo> _detailInfo(
    Map<String, dynamic> data,
    Map<String, dynamic> credits,
    MovieItem item,
  ) {
    final cast =
        (credits['cast'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .take(4)
            .map((person) => person['name']?.toString() ?? '')
            .where((name) => name.isNotEmpty)
            .join(', ') ??
        '';
    final genres =
        (data['genres'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .map((genre) => genre['name']?.toString() ?? '')
            .where((name) => name.isNotEmpty)
            .join(', ') ??
        '';
    final countries =
        (data['production_countries'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .map((country) => country['name']?.toString() ?? '')
            .where((name) => name.isNotEmpty)
            .join(', ') ??
        '';
    final companies =
        (data['production_companies'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .take(3)
            .map((company) => company['name']?.toString() ?? '')
            .where((name) => name.isNotEmpty)
            .join(', ') ??
        '';

    return [
      DetailInfo(label: 'Casts', value: cast.isEmpty ? 'N/A' : cast),
      DetailInfo(label: 'Genre', value: genres.isEmpty ? 'N/A' : genres),
      DetailInfo(label: 'Duration', value: item.duration),
      DetailInfo(
        label: 'Country',
        value: countries.isEmpty ? 'N/A' : countries,
      ),
      DetailInfo(label: 'IMDB', value: item.rating),
      DetailInfo(
        label: 'Release',
        value: item.releaseDate.isEmpty ? 'N/A' : item.releaseDate,
      ),
      DetailInfo(
        label: 'Production',
        value: companies.isEmpty ? 'N/A' : companies,
      ),
    ];
  }
}
