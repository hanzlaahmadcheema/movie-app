import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../core/config/app_config.dart';
import '../core/models/tmdb_option.dart';
import '../core/services/tmdb_repository.dart';
import 'buttons.dart';

class FilterSelection {
  const FilterSelection({
    required this.type,
    required this.genre,
    required this.releaseYear,
    required this.rating,
    required this.genreId,
    required this.countryCode,
  });

  final String type;
  final String genre;
  final String releaseYear;
  final String rating;
  final String? genreId;
  final String? countryCode;
}

class FilterPanel extends StatefulWidget {
  const FilterPanel({this.onApply, super.key});

  final ValueChanged<FilterSelection>? onApply;

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  final _repository = TmdbRepository(config: AppConfig.fromEnv());

  late final Future<_FilterData> _data = _load();

  String type = 'Movies';
  String? genreId;
  String genre = '';
  String? countryCode;
  String country = '';
  String releaseYear = DateTime.now().year.toString();
  String rating = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_FilterData>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!;
        final genreOptions = type == 'Movies'
            ? data.movieGenres
            : data.tvGenres;
        final ratingOptions = type == 'Movies'
            ? data.movieRatings
            : data.tvRatings;

        genreId ??= genreOptions.isNotEmpty ? genreOptions.first.id : null;
        genre = genreOptions
            .firstWhere(
              (option) => option.id == genreId,
              orElse: () => genreOptions.isNotEmpty
                  ? genreOptions.first
                  : const TmdbOption(id: '', label: ''),
            )
            .label;
        countryCode ??= data.countries.isNotEmpty
            ? data.countries.first.id
            : null;
        country = data.countries
            .firstWhere(
              (option) => option.id == countryCode,
              orElse: () => data.countries.isNotEmpty
                  ? data.countries.first
                  : const TmdbOption(id: '', label: ''),
            )
            .label;
        rating = ratingOptions.contains(rating)
            ? rating
            : (ratingOptions.isNotEmpty ? ratingOptions.first : '');

        final years = _yearOptions();
        if (!years.contains(releaseYear)) {
          releaseYear = years.first;
        }

        return Column(
          children: [
            FilterTile(
              label: 'Type',
              value: type,
              options: const ['Movies', 'TV Series'],
              onSelected: (value) => setState(() {
                type = value;
                genreId = null;
                genre = '';
                rating = '';
              }),
            ),
            const SizedBox(height: 10),
            FilterTile(
              label: 'Genre',
              value: genre.isEmpty ? 'Select genre' : genre,
              options: genreOptions.map((option) => option.label).toList(),
              onSelected: (value) => setState(() {
                final option = genreOptions.firstWhere(
                  (item) => item.label == value,
                );
                genreId = option.id;
                genre = option.label;
              }),
            ),
            const SizedBox(height: 10),
            FilterTile(
              label: 'Country',
              value: country.isEmpty ? 'Select country' : country,
              options: data.countries.map((option) => option.label).toList(),
              onSelected: (value) => setState(() {
                final option = data.countries.firstWhere(
                  (item) => item.label == value,
                );
                countryCode = option.id;
                country = option.label;
              }),
            ),
            const SizedBox(height: 10),
            FilterTile(
              label: 'Release Year',
              value: releaseYear,
              options: years,
              onSelected: (value) => setState(() => releaseYear = value),
            ),
            const SizedBox(height: 10),
            FilterTile(
              label: 'Rating',
              value: rating.isEmpty ? 'Select rating' : rating,
              options: ratingOptions,
              onSelected: (value) => setState(() => rating = value),
            ),
            const SizedBox(height: 14),
            PrimaryButton(
              label: 'Filter',
              icon: Icons.filter_alt,
              height: 53,
              radius: 25,
              iconSize: 16,
              textStyle: AppTextStyles.medium.copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
              onPressed: () {
                final selection = FilterSelection(
                  type: type,
                  genre: genre,
                  releaseYear: releaseYear,
                  rating: rating,
                  genreId: genreId,
                  countryCode: countryCode,
                );

                if (widget.onApply != null) {
                  widget.onApply!(selection);
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Filtering ${selection.type.toLowerCase()} by ${selection.genre}',
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<_FilterData> _load() async {
    final movieGenres = await _repository.movieGenres();
    final tvGenres = await _repository.tvGenres();
    final countries = await _repository.countries();
    final movieRatings = await _repository.movieCertifications();
    final tvRatings = await _repository.tvCertifications();
    return _FilterData(
      movieGenres: movieGenres,
      tvGenres: tvGenres,
      countries: countries,
      movieRatings: movieRatings,
      tvRatings: tvRatings,
    );
  }

  List<String> _yearOptions() {
    final current = DateTime.now().year;
    return List.generate(10, (index) => (current - index).toString());
  }
}

class FilterTile extends StatelessWidget {
  const FilterTile({
    required this.label,
    required this.value,
    required this.options,
    required this.onSelected,
    super.key,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showOptions(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 53,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.tag.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.normal.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 22),
          ],
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: options
              .map(
                (option) => ListTile(
                  title: Text(
                    option,
                    style: AppTextStyles.normal.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                  trailing: option == value
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    onSelected(option);
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _FilterData {
  const _FilterData({
    required this.movieGenres,
    required this.tvGenres,
    required this.countries,
    required this.movieRatings,
    required this.tvRatings,
  });

  final List<TmdbOption> movieGenres;
  final List<TmdbOption> tvGenres;
  final List<TmdbOption> countries;
  final List<String> movieRatings;
  final List<String> tvRatings;
}
