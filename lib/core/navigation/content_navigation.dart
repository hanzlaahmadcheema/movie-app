import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../features/search/search_screens.dart';
import '../models/movie_item.dart';

String detailRouteForItem(MovieItem item) {
  return item.type.toLowerCase().contains('series')
      ? AppRoutes.seriesDetail
      : AppRoutes.movieDetail;
}

String watchRouteForItem(MovieItem item) {
  return item.type.toLowerCase().contains('series')
      ? AppRoutes.seriesWatch
      : AppRoutes.movieWatch;
}

void openDetailForItem(BuildContext context, MovieItem item) {
  Navigator.pushNamed(context, detailRouteForItem(item), arguments: item);
}

void openWatchForItem(BuildContext context, MovieItem item) {
  Navigator.pushNamed(context, watchRouteForItem(item));
}

void openSearchResult(BuildContext context, String title) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => SearchResultScreen(title: title)),
  );
}
