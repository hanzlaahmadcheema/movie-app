import '../models/movie_item.dart';

class ShareTextBuilder {
  const ShareTextBuilder._();

  static String forItem(MovieItem item) {
    final buffer = StringBuffer()
      ..write('Watch ${item.title}')
      ..write(' on MovieApp.');

    final details = <String>[
      item.mediaType == MediaType.tv ? 'TV Series' : 'Movie',
      if (item.year.trim().isNotEmpty) item.year.trim(),
      if (_rating(item).isNotEmpty) 'Rating ${_rating(item)}/10',
    ];

    if (details.isNotEmpty) {
      buffer
        ..write('\n')
        ..write(details.join(' • '));
    }

    buffer.write('\nBrowse it in the MovieApp catalog.');
    return buffer.toString();
  }

  static String _rating(MovieItem item) {
    if (item.voteAverage > 0) {
      return item.voteAverage.toStringAsFixed(1);
    }
    final rating = item.rating.trim();
    if (rating.isEmpty || rating == '0') {
      return '';
    }
    return rating;
  }
}
