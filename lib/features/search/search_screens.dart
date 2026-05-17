import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
import '../../core/models/movie_item.dart';
import '../../core/models/tmdb_option.dart';
import '../../core/services/tmdb_repository.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/poster_widgets.dart';

enum ExploreMode { search, genre, country, production }

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    required this.title,
    this.mode = ExploreMode.search,
    this.query,
    super.key,
  });

  final String title;
  final ExploreMode mode;
  final String? query;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final _repository = TmdbRepository(config: AppConfig.fromEnv());
  final _controller = TextEditingController();
  Timer? _debounce;

  Future<List<MovieItem>>? _itemsFuture;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _currentQuery = widget.mode == ExploreMode.search
        ? (widget.query ?? '')
        : (widget.query ?? widget.title);
    _controller.text = widget.mode == ExploreMode.search ? _currentQuery : '';
    _itemsFuture = _load();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showSearchBar = widget.mode == ExploreMode.search;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const MovieAppBar(dark: true),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 56, 5, 0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          if (showSearchBar)
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 24, 17, 0),
              child: TextField(
                controller: _controller,
                onChanged: _scheduleSearch,
                onSubmitted: (value) => _runSearch(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search movies, shows, and people',
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 24, 5, 0),
            child: FutureBuilder<List<MovieItem>>(
              future: _itemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: IconButton(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh, size: 28),
                    ),
                  );
                }

                final items = snapshot.data ?? const <MovieItem>[];
                if (items.isEmpty) {
                  return Center(
                    child: IconButton(
                      onPressed: _reload,
                      icon: const Icon(Icons.search_off, size: 28),
                    ),
                  );
                }

                return PosterGrid(items: items, itemCount: 10);
              },
            ),
          ),
          const SizedBox(height: 34),
          const FooterDetails(),
        ],
      ),
    );
  }

  void _scheduleSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      _runSearch(value);
    });
  }

  void _runSearch(String value) {
    setState(() {
      _currentQuery = value.trim();
      _itemsFuture = _load();
    });
  }

  void _reload() {
    setState(() {
      _itemsFuture = _load();
    });
  }

  Future<List<MovieItem>> _load() async {
    final query = _currentQuery.trim();
    switch (widget.mode) {
      case ExploreMode.search:
        return _repository.search(query);
      case ExploreMode.genre:
        return _browseByGenre(query.isEmpty ? widget.title : query);
      case ExploreMode.country:
        return _browseByCountry(query.isEmpty ? widget.title : query);
      case ExploreMode.production:
        return _browseByProduction(query.isEmpty ? widget.title : query);
    }
  }

  Future<List<MovieItem>> _browseByGenre(String label) async {
    if (label.trim().isEmpty || label == 'Genres') {
      return [
        ...await _repository.discoverMovieBrowse(),
        ...await _repository.discoverSeriesBrowse(),
      ];
    }
    final options = <TmdbOption>[
      ...await _repository.movieGenres(),
      ...await _repository.tvGenres(),
    ];
    final matches = options.where((option) => option.label == label).toList();
    if (matches.isEmpty) {
      return const [];
    }

    final results = <MovieItem>[];
    for (final match in matches) {
      final genreId = int.tryParse(match.id);
      if (genreId == null) continue;
      final movies = await _repository.discoverMovieBrowse(genreId: genreId);
      final series = await _repository.discoverSeriesBrowse(genreId: genreId);
      results.addAll(movies);
      results.addAll(series);
    }
    return results;
  }

  Future<List<MovieItem>> _browseByCountry(String label) async {
    if (label.trim().isEmpty || label == 'Countries') {
      return [
        ...await _repository.discoverMovieBrowse(),
        ...await _repository.discoverSeriesBrowse(),
      ];
    }
    final options = await _repository.countries();
    final match = options.where((option) => option.label == label).toList();
    if (match.isEmpty) {
      return const [];
    }
    final code = match.first.id;
    final movies = await _repository.discoverMovieBrowse(country: code);
    final series = await _repository.discoverSeriesBrowse(country: code);
    return [...movies, ...series];
  }

  Future<List<MovieItem>> _browseByProduction(String label) async {
    if (label.trim().isEmpty || label == 'Production') {
      return [
        ...await _repository.discoverMovieBrowse(),
        ...await _repository.discoverSeriesBrowse(),
      ];
    }
    final company = await _repository.companyFromQuery(label);
    if (company == null) {
      return const [];
    }

    final companyId = int.tryParse(company.id);
    if (companyId == null) {
      return const [];
    }

    final movies = await _repository.discoverMovieBrowse(companyId: companyId);
    final series = await _repository.discoverSeriesBrowse(companyId: companyId);
    return [...movies, ...series];
  }
}
