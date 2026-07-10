class DetailInfo {
  const DetailInfo({required this.label, required this.value});

  final String label;
  final String value;
}

class Episode {
  const Episode({
    required this.number,
    required this.title,
    required this.duration,
    this.overview = '',
    this.thumbnail = '',
    this.active = false,
  });

  final int number;
  final String title;
  final String duration;
  final String overview;
  final String thumbnail;
  final bool active;
}
