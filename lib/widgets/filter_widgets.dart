import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../core/config/app_config.dart';
import '../core/models/tmdb_option.dart';
import '../core/services/tmdb_repository.dart';
import 'buttons.dart';
import 'state_views.dart';

enum FilterContentType { all, movies, series }

extension FilterContentTypeLabel on FilterContentType {
  String get label {
    return switch (this) {
      FilterContentType.all => 'All',
      FilterContentType.movies => 'Movies',
      FilterContentType.series => 'TV Series',
    };
  }
}

class FilterSelection {
  const FilterSelection({
    this.type = FilterContentType.all,
    this.genreId,
    this.genreLabel,
    this.countryCode,
    this.countryLabel,
    this.releaseYear,
    this.ratingGte,
  });

  final FilterContentType type;
  final String? genreId;
  final String? genreLabel;
  final String? countryCode;
  final String? countryLabel;
  final int? releaseYear;
  final double? ratingGte;

  bool get hasActiveFilters =>
      type != FilterContentType.all ||
      genreId != null ||
      countryCode != null ||
      releaseYear != null ||
      ratingGte != null;

  String get genreDisplay => genreLabel ?? 'All genres';
  String get countryDisplay => countryLabel ?? 'All countries';
  String get yearDisplay => releaseYear?.toString() ?? 'All years';
  String get ratingDisplay =>
      ratingGte == null ? 'Any rating' : '${ratingGte!.toStringAsFixed(0)}+';

  FilterSelection copyWith({
    FilterContentType? type,
    Object? genreId = _sentinel,
    Object? genreLabel = _sentinel,
    Object? countryCode = _sentinel,
    Object? countryLabel = _sentinel,
    Object? releaseYear = _sentinel,
    Object? ratingGte = _sentinel,
  }) {
    return FilterSelection(
      type: type ?? this.type,
      genreId: identical(genreId, _sentinel)
          ? this.genreId
          : genreId as String?,
      genreLabel: identical(genreLabel, _sentinel)
          ? this.genreLabel
          : genreLabel as String?,
      countryCode: identical(countryCode, _sentinel)
          ? this.countryCode
          : countryCode as String?,
      countryLabel: identical(countryLabel, _sentinel)
          ? this.countryLabel
          : countryLabel as String?,
      releaseYear: identical(releaseYear, _sentinel)
          ? this.releaseYear
          : releaseYear as int?,
      ratingGte: identical(ratingGte, _sentinel)
          ? this.ratingGte
          : ratingGte as double?,
    );
  }

  FilterSelection lockedTo(FilterContentType type) => copyWith(type: type);
}

const Object _sentinel = Object();

class FilterPanel extends StatefulWidget {
  const FilterPanel({
    this.initialSelection = const FilterSelection(),
    this.allowedTypes = const [
      FilterContentType.all,
      FilterContentType.movies,
      FilterContentType.series,
    ],
    this.onApply,
    super.key,
  });

  final FilterSelection initialSelection;
  final List<FilterContentType> allowedTypes;
  final ValueChanged<FilterSelection>? onApply;

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  final _repository = TmdbRepository(config: AppConfig.fromEnv());

  late Future<_FilterData> _data = _load();
  late FilterSelection selection = _normalized(widget.initialSelection);

  @override
  void didUpdateWidget(covariant FilterPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSelection != widget.initialSelection ||
        oldWidget.allowedTypes != widget.allowedTypes) {
      selection = _normalized(widget.initialSelection);
    }
  }

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
        if (snapshot.hasError) {
          return AppErrorView(
            title: 'Could not load filters',
            message: userMessageForError(snapshot.error),
            onRetry: () => setState(() => _data = _load()),
          );
        }
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!;
        final genreOptions = _genreOptionsFor(data);
        final yearOptions = _yearOptions();
        final ratingOptions = _ratingOptions();

        return Column(
          children: [
            if (widget.allowedTypes.length > 1) ...[
              FilterTile(
                label: 'Type',
                value: selection.type.label,
                options: widget.allowedTypes.map((type) => type.label).toList(),
                onSelected: (value) => setState(() {
                  selection = selection.copyWith(
                    type: _typeFromLabel(value),
                    genreId: null,
                    genreLabel: null,
                  );
                }),
              ),
              const SizedBox(height: 10),
            ],
            FilterTile(
              label: 'Genre',
              value: selection.genreDisplay,
              options: const [
                'All genres',
              ].followedBy(genreOptions.map((option) => option.label)).toList(),
              onSelected: (value) => setState(() {
                if (value == 'All genres') {
                  selection = selection.copyWith(
                    genreId: null,
                    genreLabel: null,
                  );
                  return;
                }
                final option = genreOptions.firstWhere(
                  (item) => item.label == value,
                );
                selection = selection.copyWith(
                  genreId: option.id,
                  genreLabel: option.label,
                );
              }),
            ),
            const SizedBox(height: 10),
            FilterTile(
              label: 'Country',
              value: selection.countryDisplay,
              options: const ['All countries']
                  .followedBy(data.countries.map((option) => option.label))
                  .toList(),
              onSelected: (value) => setState(() {
                if (value == 'All countries') {
                  selection = selection.copyWith(
                    countryCode: null,
                    countryLabel: null,
                  );
                  return;
                }
                final option = data.countries.firstWhere(
                  (item) => item.label == value,
                );
                selection = selection.copyWith(
                  countryCode: option.id,
                  countryLabel: option.label,
                );
              }),
            ),
            const SizedBox(height: 10),
            FilterTile(
              label: 'Release Year',
              value: selection.yearDisplay,
              options: yearOptions,
              onSelected: (value) => setState(() {
                selection = selection.copyWith(
                  releaseYear: value == 'All years' ? null : int.parse(value),
                );
              }),
            ),
            const SizedBox(height: 10),
            FilterTile(
              label: 'Rating',
              value: selection.ratingDisplay,
              options: ratingOptions,
              onSelected: (value) => setState(() {
                selection = selection.copyWith(
                  ratingGte: value == 'Any rating'
                      ? null
                      : double.parse(value.replaceAll('+', '')),
                );
              }),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() {
                      selection = _normalized(const FilterSelection());
                      widget.onApply?.call(selection);
                    }),
                    icon: const Icon(Icons.clear),
                    label: const Text('Reset Filters'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
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
                      widget.onApply?.call(selection);
                    },
                  ),
                ),
              ],
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
    return _FilterData(
      movieGenres: movieGenres,
      tvGenres: tvGenres,
      countries: countries,
    );
  }

  FilterSelection _normalized(FilterSelection input) {
    final allowedTypes = widget.allowedTypes.isEmpty
        ? const [FilterContentType.all]
        : widget.allowedTypes;
    final type = allowedTypes.contains(input.type)
        ? input.type
        : allowedTypes.first;
    return input.copyWith(type: type);
  }

  List<TmdbOption> _genreOptionsFor(_FilterData data) {
    return switch (selection.type) {
      FilterContentType.series => data.tvGenres,
      FilterContentType.movies || FilterContentType.all => data.movieGenres,
    };
  }

  FilterContentType _typeFromLabel(String label) {
    return widget.allowedTypes.firstWhere(
      (type) => type.label == label,
      orElse: () => widget.allowedTypes.first,
    );
  }

  List<String> _yearOptions() {
    final current = DateTime.now().year;
    return ['All years', ...List.generate(10, (index) => '${current - index}')];
  }

  List<String> _ratingOptions() => const [
    'Any rating',
    '5+',
    '6+',
    '7+',
    '8+',
    '9+',
  ];
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
  });

  final List<TmdbOption> movieGenres;
  final List<TmdbOption> tvGenres;
  final List<TmdbOption> countries;
}
