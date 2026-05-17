class TmdbPage<T> {
  const TmdbPage({
    required this.items,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });

  final List<T> items;
  final int page;
  final int totalPages;
  final int totalResults;

  bool get hasMultiplePages => totalPages > 1;
}
