import '../config/app_config.dart';
import '../models/detail_item.dart';
import '../models/movie_item.dart';
import '../models/tmdb_page.dart';
import '../models/tmdb_person.dart';
import '../models/tmdb_option.dart';
import '../models/tmdb_season.dart';
import '../models/tmdb_video.dart';
import '../models/tmdb_cast.dart';
import 'tmdb_api_client.dart';

class TmdbDetail {
  const TmdbDetail({
    required this.item,
    required this.info,
    required this.related,
    required this.videos,
    required this.seasons,
    required this.cast,
  });

  final MovieItem item;
  final List<DetailInfo> info;
  final List<MovieItem> related;
  final List<TmdbVideo> videos;
  final List<TmdbSeason> seasons;
  final List<TmdbCast> cast;
}

class TmdbRepository {
  TmdbRepository({required AppConfig config, TmdbApiClient? client})
    : _config = config,
      _client = client ?? TmdbApiClient(config: config);

  final AppConfig _config;
  final TmdbApiClient _client;

  Future<List<MovieItem>> trendingMovies() =>
      _list('/trending/movie/week', fallbackMediaType: MediaType.movie);

  Future<List<MovieItem>> trendingSeries() =>
      _list('/trending/tv/week', fallbackMediaType: MediaType.tv);

  Future<List<MovieItem>> latestMovies() =>
      _list('/movie/now_playing', fallbackMediaType: MediaType.movie);

  Future<List<MovieItem>> latestSeries() =>
      _list('/tv/on_the_air', fallbackMediaType: MediaType.tv);

  Future<List<MovieItem>> popularMovies() =>
      _list('/movie/popular', fallbackMediaType: MediaType.movie);

  Future<List<MovieItem>> popularSeries() =>
      _list('/tv/popular', fallbackMediaType: MediaType.tv);

  Future<List<MovieItem>> upcomingMovies() =>
      _list('/movie/upcoming', fallbackMediaType: MediaType.movie);

  Future<List<MovieItem>> topRatedMovies() =>
      _list('/movie/top_rated', fallbackMediaType: MediaType.movie);

  Future<List<MovieItem>> topRatedSeries() =>
      _list('/tv/top_rated', fallbackMediaType: MediaType.tv);

  Future<List<MovieItem>> discoverMovies() =>
      _list('/discover/movie', fallbackMediaType: MediaType.movie);

  Future<List<MovieItem>> discoverSeries() =>
      _list('/discover/tv', fallbackMediaType: MediaType.tv);

  Future<List<MovieItem>> discoverMovieBrowse({
    int? genreId,
    String? country,
    int? companyId,
    int? year,
    String? certification,
    double? ratingGte,
    String sortBy = 'popularity.desc',
  }) async {
    return (await discoverMovieBrowsePage(
      genreId: genreId,
      country: country,
      companyId: companyId,
      year: year,
      certification: certification,
      ratingGte: ratingGte,
      sortBy: sortBy,
    )).items;
  }

  Future<TmdbPage<MovieItem>> discoverMovieBrowsePage({
    int? genreId,
    String? country,
    int? companyId,
    int? year,
    String? certification,
    double? ratingGte,
    String sortBy = 'popularity.desc',
    int page = 1,
  }) {
    return _pagedList(
      '/discover/movie',
      fallbackMediaType: MediaType.movie,
      query: {
        'page': page.toString(),
        'with_genres': genreId?.toString(),
        'with_origin_country': country,
        'with_companies': companyId?.toString(),
        'primary_release_year': year?.toString(),
        'certification_country':
            certification != null && certification.isNotEmpty ? 'US' : null,
        'certification.lte': certification,
        'vote_average.gte': ratingGte?.toStringAsFixed(1),
        'sort_by': sortBy,
      },
    );
  }

  Future<List<MovieItem>> discoverSeriesBrowse({
    int? genreId,
    String? country,
    int? companyId,
    int? year,
    String? certification,
    double? ratingGte,
    String sortBy = 'popularity.desc',
  }) async {
    return (await discoverSeriesBrowsePage(
      genreId: genreId,
      country: country,
      companyId: companyId,
      year: year,
      certification: certification,
      ratingGte: ratingGte,
      sortBy: sortBy,
    )).items;
  }

  Future<TmdbPage<MovieItem>> discoverSeriesBrowsePage({
    int? genreId,
    String? country,
    int? companyId,
    int? year,
    String? certification,
    double? ratingGte,
    String sortBy = 'popularity.desc',
    int page = 1,
  }) {
    return _pagedList(
      '/discover/tv',
      fallbackMediaType: MediaType.tv,
      query: {
        'page': page.toString(),
        'with_genres': genreId?.toString(),
        'with_origin_country': country,
        'with_companies': companyId?.toString(),
        'first_air_date_year': year?.toString(),
        'certification_country':
            certification != null && certification.isNotEmpty ? 'US' : null,
        'certification.lte': certification,
        'vote_average.gte': ratingGte?.toStringAsFixed(1),
        'sort_by': sortBy,
      },
    );
  }

  Future<List<MovieItem>> search(String query) async {
    return (await searchPage(query)).items;
  }

  Future<TmdbPage<MovieItem>> searchPage(String query, {int page = 1}) async {
    if (query.trim().isEmpty) {
      return _pagedList(
        '/trending/movie/week',
        fallbackMediaType: MediaType.movie,
        query: {'page': page.toString()},
      );
    }
    return _pagedList(
      '/search/multi',
      query: {'query': query.trim(), 'page': page.toString()},
    );
  }

  Future<TmdbPage<MovieItem>> searchMoviePage(
    String query, {
    int page = 1,
  }) async {
    if (query.trim().isEmpty) {
      return discoverMovieBrowsePage(page: page);
    }
    return _pagedList(
      '/search/movie',
      fallbackMediaType: MediaType.movie,
      query: {'query': query.trim(), 'page': page.toString()},
    );
  }

  Future<TmdbPage<MovieItem>> searchSeriesPage(
    String query, {
    int page = 1,
  }) async {
    if (query.trim().isEmpty) {
      return discoverSeriesBrowsePage(page: page);
    }
    return _pagedList(
      '/search/tv',
      fallbackMediaType: MediaType.tv,
      query: {'query': query.trim(), 'page': page.toString()},
    );
  }

  Future<List<MovieItem>> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      return trendingMovies();
    }
    return _list('/search/movie', query: {'query': query.trim()});
  }

  Future<List<MovieItem>> searchSeries(String query) async {
    if (query.trim().isEmpty) {
      return trendingSeries();
    }
    return _list('/search/tv', query: {'query': query.trim()});
  }

  Future<List<MovieItem>> searchPeople(String query) async {
    if (query.trim().isEmpty) {
      return const [];
    }
    return _list('/search/person', query: {'query': query.trim()});
  }

  Future<List<TmdbOption>> searchCompanies(String query) async {
    if (query.trim().isEmpty) {
      return const [];
    }
    final data = await _client.get(
      '/search/company',
      query: {'query': query.trim()},
    );
    final results = data['results'];
    if (results is! List) {
      return const [];
    }
    return results
        .whereType<Map<String, dynamic>>()
        .map(
          (item) => TmdbOption(
            id: (item['id'] ?? '').toString(),
            label: (item['name'] ?? '').toString(),
          ),
        )
        .where((option) => option.id.isNotEmpty && option.label.isNotEmpty)
        .toList();
  }

  Future<TmdbDetail> detail(MovieItem seed) async {
    final mediaType = seed.mediaType == MediaType.tv ? 'tv' : 'movie';
    final data = await _client.get(
      '/$mediaType/${seed.id}',
      query: {'append_to_response': 'credits,videos,external_ids'},
    );
    final credits = data['credits'] is Map<String, dynamic>
        ? data['credits'] as Map<String, dynamic>
        : await _client.get('/$mediaType/${seed.id}/credits');
    final recommendations = await _list(
      '/$mediaType/${seed.id}/recommendations',
      fallbackMediaType: seed.mediaType,
    );
    final similar = await _list(
      '/$mediaType/${seed.id}/similar',
      fallbackMediaType: seed.mediaType,
    );
    final related = _dedupeItems([...recommendations, ...similar]);
    final item = _itemFromJson(data, fallbackMediaType: seed.mediaType);

    final parsedCast = (credits['cast'] as List?)
        ?.whereType<Map<String, dynamic>>()
        .map((p) => TmdbCast.fromJson(p))
        .toList() ?? [];

    return TmdbDetail(
      item: item.copyWith(
        posterUrl: item.posterUrl.isEmpty ? seed.posterUrl : null,
      ),
      info: _detailInfo(data, credits, item),
      related: related.isEmpty ? [seed] : related,
      videos: _videosFromDetail(data),
      seasons: _seasonsFromDetail(data),
      cast: parsedCast,
    );
  }

  static final Map<String, dynamic> _apiMemoryCache = {};

  Future<MovieItem?> movieById(int tmdbId) async {
    if (tmdbId <= 0) {
      return null;
    }
    final cacheKey = 'movie_$tmdbId';
    final cached = _apiMemoryCache[cacheKey];
    if (cached is MovieItem) return cached;

    final data = await _client.get('/movie/$tmdbId');
    final item = _itemFromJson(data, fallbackMediaType: MediaType.movie);
    _apiMemoryCache[cacheKey] = item;
    return item;
  }

  Future<MovieItem?> seriesById(int tmdbId) async {
    if (tmdbId <= 0) {
      return null;
    }
    final cacheKey = 'tv_$tmdbId';
    final cached = _apiMemoryCache[cacheKey];
    if (cached is MovieItem) return cached;

    final data = await _client.get('/tv/$tmdbId');
    final item = _itemFromJson(data, fallbackMediaType: MediaType.tv);
    _apiMemoryCache[cacheKey] = item;
    return item;
  }

  Future<List<TmdbOption>> movieGenres() async {
    return _options('/genre/movie/list');
  }

  Future<List<TmdbOption>> tvGenres() async {
    return _options('/genre/tv/list');
  }

  Future<List<String>> movieCertifications() async {
    return _certifications('/certification/movie/list');
  }

  Future<List<String>> tvCertifications() async {
    return _certifications('/certification/tv/list');
  }

  Future<List<TmdbOption>> countries() async {
    final data = await _client.get('/configuration/countries');
    final List<dynamic> raw;
    if (data is List) {
      raw = data;
    } else if (data is Map<String, dynamic>) {
      raw =
          (data['results'] ?? data['countries']) as List<dynamic>? ?? const [];
    } else {
      return const [];
    }
    return raw
        .whereType<Map<String, dynamic>>()
        .map(
          (item) => TmdbOption(
            id: (item['iso_3166_1'] ?? '').toString(),
            label: (item['english_name'] ?? item['native_name'] ?? '')
                .toString(),
          ),
        )
        .where((option) => option.id.isNotEmpty && option.label.isNotEmpty)
        .toList();
  }

  Future<TmdbOption?> companyFromQuery(String query) async {
    final results = await searchCompanies(query);
    if (results.isEmpty) {
      return null;
    }
    final item = results.first;
    return TmdbOption(id: item.id, label: item.label);
  }

  Future<List<Episode>> tvSeasonEpisodes({
    required int tvId,
    required int seasonNumber,
  }) async {
    final data = await _client.get('/tv/$tvId/season/$seasonNumber');
    final results = data['episodes'];
    if (results is! List) {
      return const [];
    }

    return results
        .whereType<Map<String, dynamic>>()
        .map(
          (episode) => Episode(
            number: episode['episode_number'] is int
                ? episode['episode_number'] as int
                : 0,
            title: (episode['name'] ?? '').toString(),
            duration: episode['runtime'] is int
                ? '${episode['runtime']}min'
                : 'N/A',
            overview: (episode['overview'] ?? '').toString(),
            thumbnail: episode['still_path'] != null
                ? 'https://image.tmdb.org/t/p/w500${episode['still_path']}'
                : '',
          ),
        )
        .toList();
  }

  Future<TmdbPerson?> personByQuery(String query) async {
    final results = await _client.get(
      '/search/person',
      query: {'query': query},
    );
    final list = results['results'];
    if (list is! List || list.isEmpty) {
      return null;
    }
    final firstItems = list.whereType<Map<String, dynamic>>();
    if (firstItems.isEmpty) {
      return null;
    }
    final first = firstItems.first;

    final personId = first['id'];
    if (personId is! int) {
      return null;
    }

    final data = await _client.get(
      '/person/$personId',
      query: {'append_to_response': 'combined_credits'},
    );
    final credits = data['combined_credits'] is Map<String, dynamic>
        ? data['combined_credits'] as Map<String, dynamic>
        : const <String, dynamic>{};

    return TmdbPerson(
      id: personId,
      name: (data['name'] ?? first['name'] ?? '').toString(),
      biography: (data['biography'] ?? '').toString(),
      profilePath: (data['profile_path'] ?? '').toString(),
      birthday: (data['birthday'] ?? '').toString(),
      placeOfBirth: (data['place_of_birth'] ?? '').toString(),
      knownFor: _combinedCreditsToItems(credits),
    );
  }

  Future<List<MovieItem>> _list(
    String path, {
    Map<String, String?> query = const {},
    MediaType fallbackMediaType = MediaType.movie,
  }) async {
    return (await _pagedList(
      path,
      query: query,
      fallbackMediaType: fallbackMediaType,
    )).items;
  }

  Future<TmdbPage<MovieItem>> _pagedList(
    String path, {
    Map<String, String?> query = const {},
    MediaType fallbackMediaType = MediaType.movie,
  }) async {
    final queryStr = query.entries.map((e) => '${e.key}=${e.value}').join('&');
    final cacheKey = 'paged:$path?$queryStr';
    final cached = _apiMemoryCache[cacheKey];
    if (cached is TmdbPage<MovieItem>) {
      return cached;
    }

    dynamic data;
    try {
      data = await _client.get(path, query: query);
    } catch (_) {
      return const TmdbPage<MovieItem>(
        items: [],
        page: 1,
        totalPages: 1,
        totalResults: 0,
      );
    }
    if (data is! Map<String, dynamic>) {
      return const TmdbPage<MovieItem>(
        items: [],
        page: 1,
        totalPages: 1,
        totalResults: 0,
      );
    }
    final results = data['results'];
    if (results is! List) {
      return TmdbPage<MovieItem>(
        items: const [],
        page: _asInt(data['page'], fallback: 1),
        totalPages: _normalizedTotalPages(data['total_pages']),
        totalResults: _asInt(data['total_results'], fallback: 0),
      );
    }

    final items = results
        .whereType<Map<String, dynamic>>()
        .where((json) => json['media_type'] != 'person')
        .map(
          (json) => _itemFromJson(json, fallbackMediaType: fallbackMediaType),
        )
        .where((item) => item.title.isNotEmpty && item.posterUrl.isNotEmpty)
        .toList();

    final page = TmdbPage<MovieItem>(
      items: items,
      page: _asInt(data['page'], fallback: 1),
      totalPages: _normalizedTotalPages(data['total_pages']),
      totalResults: _asInt(data['total_results'], fallback: items.length),
    );
    _apiMemoryCache[cacheKey] = page;
    return page;
  }

  Future<List<TmdbOption>> _options(String path) async {
    final data = await _client.get(path);
    final results = data['genres'];
    if (results is! List) {
      return const [];
    }
    return results
        .whereType<Map<String, dynamic>>()
        .map(
          (item) => TmdbOption(
            id: (item['id'] ?? '').toString(),
            label: (item['name'] ?? '').toString(),
          ),
        )
        .where((option) => option.id.isNotEmpty && option.label.isNotEmpty)
        .toList();
  }

  Future<List<String>> _certifications(String path) async {
    final data = await _client.get(path);
    final map = data['certifications'];
    if (map is! Map<String, dynamic>) {
      return const [];
    }

    final region = map['US'];
    final items = region is List
        ? region.whereType<Map<String, dynamic>>().toList()
        : map.values
              .whereType<List>()
              .expand((value) => value.whereType<Map<String, dynamic>>())
              .toList();

    return items
        .map((item) => (item['certification'] ?? '').toString())
        .where((value) => value.isNotEmpty)
        .toList();
  }

  int _asInt(Object? value, {required int fallback}) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return fallback;
  }

  int _normalizedTotalPages(Object? value) {
    final total = _asInt(value, fallback: 1);
    if (total < 1) {
      return 1;
    }
    return total > 500 ? 500 : total;
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
    final originCountryCodes = _originCountryCodes(json);

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
      imdbId: (json['imdb_id'] ?? (json['external_ids'] as Map?)?['imdb_id'])
          ?.toString(),
      originCountryCodes: originCountryCodes,
      genreIds: genreIds,
      releaseDate: releaseDate,
      description: (json['overview'] ?? '').toString(),
      rating: ((json['vote_average'] as num?) ?? 0).toStringAsFixed(1),
      voteAverage: ((json['vote_average'] as num?) ?? 0).toDouble(),
      duration: _duration(runtime),
    );
  }

  List<String> _originCountryCodes(Map<String, dynamic> json) {
    final codes = <String>{};
    final originCountries = json['origin_country'];
    if (originCountries is List) {
      for (final country in originCountries) {
        final value = country?.toString().trim().toUpperCase();
        if (value != null && value.isNotEmpty) {
          codes.add(value);
        }
      }
    }
    final productionCountries = json['production_countries'];
    if (productionCountries is List) {
      for (final country in productionCountries.whereType<Map>()) {
        final value = country['iso_3166_1']?.toString().trim().toUpperCase();
        if (value != null && value.isNotEmpty) {
          codes.add(value);
        }
      }
    }
    return List.unmodifiable(codes);
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

  List<TmdbVideo> _videosFromDetail(Map<String, dynamic> data) {
    final videos = data['videos'];
    final results = videos is Map<String, dynamic> ? videos['results'] : null;
    if (results is! List) {
      return const [];
    }

    return results
        .whereType<Map<String, dynamic>>()
        .map(
          (video) => TmdbVideo(
            name: (video['name'] ?? '').toString(),
            key: (video['key'] ?? '').toString(),
            site: (video['site'] ?? '').toString(),
            type: (video['type'] ?? '').toString(),
            official: video['official'] == true,
          ),
        )
        .where((video) => video.key.isNotEmpty && video.site.isNotEmpty)
        .toList();
  }

  List<TmdbSeason> _seasonsFromDetail(Map<String, dynamic> data) {
    final seasons = data['seasons'];
    if (seasons is! List) {
      return const [];
    }

    return seasons
        .whereType<Map<String, dynamic>>()
        .map(
          (season) => TmdbSeason(
            number: season['season_number'] is int
                ? season['season_number'] as int
                : 0,
            name: (season['name'] ?? '').toString(),
            episodeCount: season['episode_count'] is int
                ? season['episode_count'] as int
                : 0,
          ),
        )
        .where((season) => season.number > 0)
        .toList();
  }

  List<MovieItem> _combinedCreditsToItems(Map<String, dynamic> data) {
    final credits = <Map<String, dynamic>>[];
    for (final key in ['cast', 'crew']) {
      final entries = data[key];
      if (entries is List) {
        credits.addAll(entries.whereType<Map<String, dynamic>>());
      }
    }

    return credits
        .map(_itemFromCredit)
        .where((item) => item.title.isNotEmpty && item.posterUrl.isNotEmpty)
        .toList();
  }

  List<MovieItem> _dedupeItems(List<MovieItem> items) {
    final seen = <String>{};
    final deduped = <MovieItem>[];
    for (final item in items) {
      final key = '${item.mediaType.name}:${item.id}';
      if (seen.add(key)) {
        deduped.add(item);
      }
    }
    return deduped;
  }

  MovieItem _itemFromCredit(Map<String, dynamic> json) {
    final mediaType = _mediaType(json['media_type'] as String?, null);
    final title = (json['title'] ?? json['name'] ?? '').toString();
    final releaseDate = (json['release_date'] ?? json['first_air_date'] ?? '')
        .toString();
    return MovieItem(
      id: json['id'] is int ? json['id'] as int : 0,
      title: title,
      type: mediaType == MediaType.tv ? 'Series' : 'Movie',
      mediaType: mediaType,
      year: releaseDate.length >= 4 ? releaseDate.substring(0, 4) : 'N/A',
      quality: 'HD',
      posterUrl: _config.posterUrl(json['poster_path']?.toString()),
      backdropUrl: _config.backdropUrl(json['backdrop_path']?.toString()),
      posterPath: json['poster_path']?.toString(),
      backdropPath: json['backdrop_path']?.toString(),
      genreIds: const [],
      releaseDate: releaseDate,
      description: (json['overview'] ?? '').toString(),
      rating: ((json['vote_average'] as num?) ?? 0).toStringAsFixed(1),
      voteAverage: ((json['vote_average'] as num?) ?? 0).toDouble(),
      duration: 'N/A',
    );
  }
}
