enum StreamingContentType { movie, episode }

extension StreamingContentTypeValue on StreamingContentType {
  String get value => switch (this) {
    StreamingContentType.movie => 'movie',
    StreamingContentType.episode => 'episode',
  };

  static StreamingContentType? fromValue(Object? value) {
    return switch (value?.toString().toLowerCase()) {
      'movie' => StreamingContentType.movie,
      'episode' || 'tv' => StreamingContentType.episode,
      _ => null,
    };
  }
}
