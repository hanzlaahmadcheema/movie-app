import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/models/tmdb_video.dart';
import 'package:movie_app/core/trailer/trailer_picker.dart';

void main() {
  test('selects official trailer first', () {
    final trailer = TrailerPicker.pick(const [
      TmdbVideo(
        name: 'Teaser',
        key: 'teaser-key',
        site: 'YouTube',
        type: 'Teaser',
        official: true,
      ),
      TmdbVideo(
        name: 'Official Trailer',
        key: 'official-key',
        site: 'YouTube',
        type: 'Trailer',
        official: true,
      ),
    ], title: 'Movie');

    expect(trailer?.key, 'official-key');
    expect(trailer?.embedUri.toString(), contains('youtube.com/embed'));
  });

  test('falls back to teaser and first playable video', () {
    final teaser = TrailerPicker.pick(const [
      TmdbVideo(
        name: 'Featurette',
        key: 'feature-key',
        site: 'YouTube',
        type: 'Featurette',
        official: false,
      ),
      TmdbVideo(
        name: 'Teaser',
        key: 'teaser-key',
        site: 'YouTube',
        type: 'Teaser',
        official: false,
      ),
    ], title: 'Movie');

    expect(teaser?.key, 'teaser-key');
  });

  test('unsupported and empty video lists return unavailable', () {
    expect(TrailerPicker.pick(const [], title: 'Movie'), isNull);
    expect(
      TrailerPicker.pick(const [
        TmdbVideo(
          name: 'Clip',
          key: 'abc',
          site: 'Unsupported',
          type: 'Trailer',
          official: true,
        ),
      ], title: 'Movie'),
      isNull,
    );
  });

  test('route validation rejects missing site or key', () {
    expect(
      PlayableTrailer.fromRouteArguments({'site': 'YouTube', 'title': 'Movie'}),
      isNull,
    );
    expect(
      PlayableTrailer.fromRouteArguments({'key': 'abc', 'title': 'Movie'}),
      isNull,
    );
    expect(
      PlayableTrailer.fromRouteArguments({
        'site': 'YouTube',
        'key': 'abc',
        'title': 'Movie',
      })?.isValid,
      isTrue,
    );
  });
}
