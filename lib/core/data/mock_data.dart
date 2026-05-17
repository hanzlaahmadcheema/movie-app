import '../constants/app_assets.dart';
import '../models/detail_item.dart';
import '../models/movie_item.dart';

const heroMovie = MovieItem(
  title: 'Guardians of the Galaxy Vol. 3',
  type: 'Movie',
  year: '2023',
  quality: 'HD',
  posterUrl: AppAssets.hero,
  description:
      'The beloved misfits embark on one last adventure, confronting their past and facing a new threat to the universe they call home.',
);

const movies = <MovieItem>[
  MovieItem(
    title: "Widow's Bay",
    type: 'Movie',
    year: '2026',
    quality: 'HD',
    posterUrl: AppAssets.posterBlue,
  ),
  MovieItem(
    title: 'Apex',
    type: 'Movie',
    year: '2025',
    quality: 'SD',
    posterUrl: AppAssets.posterApex,
    description:
        "A grieving woman pushing her limits on a solo adventure in the Australian wild is ensnared in a twisted game with a cunning killer who thinks she's prey.",
  ),
  MovieItem(
    title: 'Hoppers',
    type: 'Movie',
    year: '2024',
    quality: 'SD',
    posterUrl: AppAssets.posterHoppers,
  ),
  MovieItem(
    title: 'Your Heart Will Be Broken',
    type: 'Movie',
    year: '2023',
    quality: 'HD',
    posterUrl: AppAssets.posterRomance,
  ),
];

const series = <MovieItem>[
  MovieItem(
    title: 'Breaking Bad',
    type: 'Series',
    year: '2008',
    quality: 'HD',
    posterUrl: AppAssets.posterBreaking,
  ),
  MovieItem(
    title: 'Game of Thrones',
    type: 'Series',
    year: '2011',
    quality: 'HD',
    posterUrl: AppAssets.posterGame,
  ),
  MovieItem(
    title: 'Apex',
    type: 'Series',
    year: '2025',
    quality: 'SD',
    posterUrl: AppAssets.posterApex,
  ),
  MovieItem(
    title: "Widow's Bay",
    type: 'Series',
    year: '2026',
    quality: 'HD',
    posterUrl: AppAssets.posterBlue,
  ),
];

const detailInfo = <DetailInfo>[
  DetailInfo(
    label: 'Casts',
    value: 'Charlize Theron, Taron Egerton, Eric Bana, Caitlin Stasey',
  ),
  DetailInfo(label: 'Genre', value: 'Thriller, Action'),
  DetailInfo(label: 'Duration', value: '104min'),
  DetailInfo(label: 'Country', value: 'United States Of America, Iceland'),
  DetailInfo(label: 'IMDB', value: '7.8'),
  DetailInfo(label: 'Release', value: '2026-04-24'),
  DetailInfo(label: 'Production', value: 'Chernin Entertainment, RVK Studios'),
];

const episodes = <Episode>[
  Episode(number: 1, title: 'Episode 1', duration: '58min', active: true),
  Episode(number: 2, title: 'Episode 2', duration: '51min'),
  Episode(number: 3, title: 'Episode 3', duration: '54min'),
  Episode(number: 4, title: 'Episode 4', duration: '49min'),
];
