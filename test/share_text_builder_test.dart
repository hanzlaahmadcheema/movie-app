import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/models/movie_item.dart';
import 'package:movie_app/core/share/share_text_builder.dart';

void main() {
  test('builds safe movie share text', () {
    const item = MovieItem(
      id: 1,
      title: 'Example Movie',
      type: 'Movie',
      year: '2026',
      quality: 'HD',
      posterUrl: 'poster',
      voteAverage: 8.4,
    );

    final text = ShareTextBuilder.forItem(item);

    expect(text, contains('Example Movie'));
    expect(text, contains('Movie'));
    expect(text, contains('2026'));
    expect(text, contains('Rating 8.4/10'));
    expect(text, isNot(contains('Bearer')));
    expect(text, isNot(contains('vidsrc')));
    expect(text, isNot(contains('2embed')));
  });

  test('builds series text with missing metadata fallback', () {
    const item = MovieItem(
      id: 2,
      title: 'Example Series',
      type: 'Series',
      year: '',
      quality: 'HD',
      posterUrl: 'poster',
      mediaType: MediaType.tv,
      rating: '',
    );

    final text = ShareTextBuilder.forItem(item);

    expect(text, contains('Example Series'));
    expect(text, contains('TV Series'));
    expect(text, isNot(contains('Rating')));
  });
}
