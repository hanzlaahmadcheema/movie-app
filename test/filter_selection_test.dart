import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/widgets/filter_widgets.dart';

void main() {
  test('default filter has no implicit genre country year or rating', () {
    const selection = FilterSelection();

    expect(selection.type, FilterContentType.all);
    expect(selection.genreId, isNull);
    expect(selection.countryCode, isNull);
    expect(selection.releaseYear, isNull);
    expect(selection.ratingGte, isNull);
    expect(selection.hasActiveFilters, isFalse);
  });

  test('reset clears optional filters', () {
    const active = FilterSelection(
      type: FilterContentType.movies,
      genreId: '28',
      genreLabel: 'Action',
      countryCode: 'US',
      countryLabel: 'United States',
      releaseYear: 2026,
      ratingGte: 8,
    );

    final reset = active.copyWith(
      type: FilterContentType.all,
      genreId: null,
      genreLabel: null,
      countryCode: null,
      countryLabel: null,
      releaseYear: null,
      ratingGte: null,
    );

    expect(reset.hasActiveFilters, isFalse);
    expect(reset.genreDisplay, 'All genres');
    expect(reset.countryDisplay, 'All countries');
    expect(reset.yearDisplay, 'All years');
    expect(reset.ratingDisplay, 'Any rating');
  });

  test('dedicated screens can lock type', () {
    final locked = const FilterSelection().lockedTo(FilterContentType.series);

    expect(locked.type, FilterContentType.series);
  });
}
