import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/constants/app_assets.dart';
import '../../core/data/mock_data.dart';
import '../../core/models/movie_item.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/detail_widgets.dart';
import '../../widgets/network_art.dart';
import '../../widgets/poster_widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _DetailPage(
      item: movies[1],
      watchRoute: AppRoutes.movieWatch,
      isSeries: false,
    );
  }
}

class SeriesDetailScreen extends StatelessWidget {
  const SeriesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _DetailPage(
      item: series[2],
      watchRoute: AppRoutes.seriesWatch,
      isSeries: true,
    );
  }
}

class _DetailPage extends StatelessWidget {
  const _DetailPage({
    required this.item,
    required this.watchRoute,
    required this.isSeries,
  });

  final MovieItem item;
  final String watchRoute;
  final bool isSeries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              DetailBackdrop(
                item: item,
                child: Column(
                  children: [
                    DetailHero(
                      item: item,
                      showBackground: false,
                      onWatch: () => Navigator.pushNamed(context, watchRoute),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -12),
                      child: DetailBody(
                        item: item,
                        info: detailInfo,
                        moreLikeThis: isSeries ? series : movies,
                        includeRelated: false,
                      ),
                    ),
                    const SizedBox(height: 42),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: RelatedPosterSection(items: isSeries ? series : movies),
              ),
              const SizedBox(height: 36),
              const FooterDetails(),
            ],
          ),
          const Positioned(top: 0, left: 0, right: 0, child: MovieAppBar()),
        ],
      ),
    );
  }
}

class CastDetailScreen extends StatelessWidget {
  const CastDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 888,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          image: const DecorationImage(
                            image: AssetImage(AppAssets.cast),
                            fit: BoxFit.cover,
                            opacity: 0.14,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 127,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: NetworkArt(
                          url: AppAssets.cast,
                          width: 167,
                          height: 250,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 414,
                      left: 16,
                      right: 16,
                      child: Text(
                        'Peter Dinklage',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Positioned(
                      top: 463,
                      left: 71,
                      right: 71,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 536,
                      left: 13,
                      right: 13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Biography', style: AppTextStyles.medium),
                          const SizedBox(height: 12),
                          Text(
                            'Peter Hayden Dinklage is an American actor. Portraying Tyrion Lannister on the HBO television series Game of Thrones, Dinklage won the Primetime Emmy Award for Outstanding Supporting Actor in a Drama Series a record four times.',
                            style: AppTextStyles.normal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SectionHeader(title: 'Known For'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: PosterGrid(items: series, itemCount: 8),
              ),
              const SizedBox(height: 32),
              const FooterDetails(),
            ],
          ),
          const Positioned(top: 0, left: 0, right: 0, child: MovieAppBar()),
        ],
      ),
    );
  }
}
