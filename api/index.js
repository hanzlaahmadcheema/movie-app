const express = require('express');
const axios = require('axios');
const cheerio = require('cheerio');
const path = require('path');

const app = express();
//define api key here not dotenv
const apiKey = 'be61c0c4d2504f59b7dd5a83983d904c';

app.use(express.static(path.join(__dirname, '../public')));
app.use(express.json());

app.set('views', path.join(__dirname, '../views'));
app.set('view engine', 'ejs');


app.get('/', async (req, res) => {
  try {
      // Fetch trending content for slider (10 items)
      const fetchGenres = async (item) => {
        const type = item.media_type === 'movie' ? 'movie' : 'tv';
        const response = await axios.get(`https://api.themoviedb.org/3/${type}/${item.id}`, {
            params: {
                api_key: apiKey
            }
        });
        return response.data.genres;
    };

    const sliderResponse = await axios.get('https://api.themoviedb.org/3/trending/all/week', {
        params: {
            api_key: apiKey
        }
    });

    const trendingContent = await Promise.all(
        sliderResponse.data.results.slice(0, 10).map(async (item) => {
            const genres = await fetchGenres(item);
            return { ...item, genres };
        })
    );

      // Fetch trending movies (20 items)
      const moviesResponse = await axios.get('https://api.themoviedb.org/3/trending/movie/week', {
          params: {
              api_key: apiKey
          }
      });
      const trendingMovies = moviesResponse.data.results.slice(0, 20); // Limit to 20 results

      // Fetch trending TV series (20 items)
      const seriesResponse = await axios.get('https://api.themoviedb.org/3/trending/tv/week', {
          params: {
              api_key: apiKey
          }
      });
      const trendingSeries = seriesResponse.data.results.slice(0, 20); // Limit to 20 results

      
      // Fetch latest movies (20 items)
      const latestMoviesResponse = await axios.get('https://api.themoviedb.org/3/movie/now_playing', {
          params: {
              api_key: apiKey
          }
      });
      const latestMovies = latestMoviesResponse.data.results.slice(0, 20); // Limit to 20 results

      // Fetch latest TV series (20 items)
      const latestSeriesResponse = await axios.get('https://api.themoviedb.org/3/tv/airing_today', {
          params: {
              api_key: apiKey
          }
      });
      const latestSeries = latestSeriesResponse.data.results.slice(0, 20); // Limit to 20 results

      // Fetch top-rated movies (20 items)
      const topRatedMoviesResponse = await axios.get('https://api.themoviedb.org/3/movie/top_rated', {
          params: {
              api_key: apiKey
          }
      });
      const topRatedMovies = topRatedMoviesResponse.data.results.slice(0, 20); // Limit to 20 results

      // Fetch top-rated TV series (20 items)
      const topRatedSeriesResponse = await axios.get('https://api.themoviedb.org/3/tv/top_rated', {
          params: {
              api_key: apiKey
          }
      });
      const topRatedSeries = topRatedSeriesResponse.data.results.slice(0, 20); // Limit to 20 results
      // Render the index.ejs template with the data
      res.render('index', {
          trendingContent,
          trendingMovies,
          trendingSeries,
          latestMovies,
          latestSeries,
          topRatedMovies,
          topRatedSeries
      });
  } catch (error) {
      console.error('Error fetching content:', error.message);
      res.status(500).send('Error fetching content');
  }
});

// Define the search route
app.get('/search', async (req, res) => {
    const keyword = req.query.keyword || '';
    const page = parseInt(req.query.page, 10) || 1;
    
    try {
        const response = await fetch(`https://api.themoviedb.org/3/search/multi?api_key=${apiKey}&query=${encodeURIComponent(keyword)}&page=${page}`);
        const data = await response.json();
  
        const combinedResults = data.results;
        const totalPages = data.total_pages;
        const currentPage = data.page;
  
        // Default image
        let imageUrl = 'https://ha-entertainment.vercel.app/images/logo.png';
  
        // Check if there are results and use the image of the first result
        if (combinedResults.length > 0) {
            const firstResult = combinedResults[0];
            if (firstResult.backdrop_path) {
                imageUrl = `https://image.tmdb.org/t/p/original${firstResult.backdrop_path}`;
            } else if (firstResult.poster_path) {
                imageUrl = `https://image.tmdb.org/t/p/original${firstResult.poster_path}`;
            }
        }
  
        res.render('search', {
            searchName: keyword.replace(/\+/g, ' '),  // Replace '+' with space for display
            combinedResults,
            totalPages,
            currentPage,
            keyword,
            imageUrl
        });
    } catch (error) {
        console.error('Error fetching search results:', error);
        res.status(500).send('An error occurred while searching.');
    }
  });
  

app.get('/search/suggest', async (req, res) => {
  const keyword = req.query.keyword || '';
  
  try {
      const response = await fetch(`https://api.themoviedb.org/3/search/multi?api_key=${apiKey}&query=${encodeURIComponent(keyword)}&page=1`);
      const data = await response.json();
      
      // Return the top results
      res.json({
          results: data.results
      });
  } catch (error) {
      console.error('Error fetching search suggestions:', error);
      res.status(500).json({ error: 'An error occurred while fetching search suggestions.' });
  }
});

app.get('/terms', (req, res) => {
    res.render('terms');
});

app.get('/player', (req, res) => {
    res.render('player');
});

app.get('/contact-us', (req, res) => {
  res.render('contact-us');
});

// Route to fetch movies with pagination
app.get('/movies', async (req, res) => {
  let currentPage = parseInt(req.query.page) || 1;
  const resultsPerPage = 20; // Number of results per page
  const maxPages = 500; // TMDb allows up to 500 pages

  // Validate the page number
  if (isNaN(currentPage) || currentPage < 1 || currentPage > maxPages) {
      return res.status(400).send('Invalid page number.');
  }

  try {
      // Fetch movies from TMDb API
      const response = await axios.get(`https://api.themoviedb.org/3/discover/movie`, {
          params: {
              api_key: apiKey,
              language: 'en-US',
              page: currentPage
          }
      });

      const movies = response.data.results;
      const totalPages = response.data.total_pages;

      res.render('movies', {
          movies: movies,
          currentPage: currentPage,
          totalPages: totalPages,
          maxPagesToShow: 5 // Adjust this based on how many page links you want to show
      });
  } catch (error) {
      console.error('Error fetching movies:', error.message);
      res.status(500).send('Error fetching movies');
  }
});

// Route to fetch TV series with pagination
app.get('/tv-series', async (req, res) => {
  let currentPage = parseInt(req.query.page) || 1;
  const resultsPerPage = 20; // Number of results per page
  const maxPages = 500; // TMDb allows up to 500 pages

  // Validate the page number
  if (isNaN(currentPage) || currentPage < 1 || currentPage > maxPages) {
      return res.status(400).send('Invalid page number.');
  }

  try {
      // Fetch TV series from TMDb API
      const response = await axios.get(`https://api.themoviedb.org/3/discover/tv`, {
          params: {
              api_key: apiKey,
              language: 'en-US',
              page: currentPage
          }
      });

      const tvSeries = response.data.results;
      const totalPages = response.data.total_pages;

      res.render('tv-series', {
          tvSeries: tvSeries,
          currentPage: currentPage,
          totalPages: totalPages,
          maxPagesToShow: 5 // Adjust this based on how many page links you want to show
      });
  } catch (error) {
      console.error('Error fetching TV series:', error.message);
      res.status(500).send('Error fetching TV series');
  }
});

// Route to fetch combined top IMDb movies and TV series with pagination
app.get('/top-imdb', async (req, res) => {
  const currentPage = parseInt(req.query.page) || 1; // Current page from query parameter
  const resultsPerPage = 20; // Number of results per page

  try {
      // Fetch top-rated movies from TMDb
      const moviesResponse = await axios.get('https://api.themoviedb.org/3/movie/top_rated', {
          params: {
              api_key: apiKey,
              language: 'en-US',
              page: currentPage
          }
      });

      // Fetch top-rated TV series from TMDb
      const tvSeriesResponse = await axios.get('https://api.themoviedb.org/3/tv/top_rated', {
          params: {
              api_key: apiKey,
              language: 'en-US',
              page: currentPage
          }
      });

      // Get the results
      const topMovies = moviesResponse.data.results;
      const topTvSeries = tvSeriesResponse.data.results;
      const totalPagesMovies = moviesResponse.data.total_pages;
      const totalPagesTvSeries = tvSeriesResponse.data.total_pages;

      // Combine movies and TV series into a single array with a type indicator
      const combinedContent = [
          ...topMovies.map(movie => ({ ...movie, type: 'movie' })),
          ...topTvSeries.map(series => ({ ...series, type: 'tv' }))
      ];

      // Calculate total pages for combined content
      const totalPages = Math.max(totalPagesMovies, totalPagesTvSeries);

      res.render('top-imdb', {
          combinedContent: combinedContent,
          currentPage: currentPage,
          totalPages: totalPages
      });
  } catch (error) {
      console.error('Error fetching top IMDb content:', error.message);
      res.status(500).send('Error fetching top IMDb content');
  }
});

app.get('/movie/:id', async (req, res) => {
  const movieId = req.params.id;
  try {
      // Fetch movie details, related movies, and cast information
      const [moviesResponse, moviesrelatedResponse, moviescreditsResponse] = await Promise.all([
          axios.get(`https://api.themoviedb.org/3/movie/${movieId}?api_key=${apiKey}&language=en-US`),
          axios.get(`https://api.themoviedb.org/3/movie/${movieId}/recommendations?api_key=${apiKey}&language=en-US`),
          axios.get(`https://api.themoviedb.org/3/movie/${movieId}/credits?api_key=${apiKey}&language=en-US`)
      ]);

      const movie = moviesResponse.data;
      const relatedMovies = moviesrelatedResponse.data.results;
      const cast = moviescreditsResponse.data.cast;
      

      // Attach cast information to the movie object
      movie.cast = cast.slice(0, 7); // Limit to top 5 cast members

      // Define getRatingClass function
      const getRatingClass = (rating) => {
          const starRating = Math.round(rating / 2);
          return `fill-${starRating}`;
      };


      res.render('movie', { movie, relatedMovies, getRatingClass });
  } catch (error) {
      console.error('Error fetching movie data:', error);
      res.status(500).send('Error fetching movie data');
  }
});

app.get('/series/:id', async (req, res) => {
    const tvId = req.params.id;
    try {
        // Fetch TV series details, related TV series, and cast information
        const [tvResponse, tvRelatedResponse, tvCreditsResponse, tvVideosResponse] = await Promise.all([
            axios.get(`https://api.themoviedb.org/3/tv/${tvId}?api_key=${apiKey}&language=en-US`),
            axios.get(`https://api.themoviedb.org/3/tv/${tvId}/recommendations?api_key=${apiKey}&language=en-US`),
            axios.get(`https://api.themoviedb.org/3/tv/${tvId}/credits?api_key=${apiKey}&language=en-US`),
            axios.get(`https://api.themoviedb.org/3/tv/${tvId}/videos?api_key=${apiKey}&language=en-US`)
        ]);
  
        const tv = tvResponse.data;
        const relatedTv = tvRelatedResponse.data.results;
        const cast = tvCreditsResponse.data.cast;
        const videos = tvVideosResponse.data.results;
  
        const trailerId = videos.find(video => video.type === 'Trailer' && video.site === 'YouTube')?.key || null;
  
        tv.cast = cast.slice(0, 5); // Limit to top 5 cast members
  
        // Define getRatingClass function
        const getRatingClass = (rating) => {
            const starRating = Math.round(rating / 2);
            return `fill-${starRating}`;
        };
  
        res.render('series', { tv, relatedTv, getRatingClass, trailerId, cast });
    } catch (error) {
        console.error('Error fetching TV data:', error);
        res.status(500).send('Error fetching TV data');
    }
  });  

app.get('/watch-movie/:id', async (req, res) => {
    try {
      const movieId = req.params.id;
      const movieDetails = await getMovieDetails(movieId);
      const trailerId = await getTrailerId(movieId); // Function to fetch trailer ID
      const castDetails = await getCastDetails(movieId); // Function to fetch cast details
      
      res.render('watch-movie', {
        movie: movieDetails.movie,
        servers: movieDetails.servers,
        relatedMovies: movieDetails.relatedMovies,
        trailerId: trailerId,  // Pass trailer ID to the template
        cast: castDetails      // Pass cast details to the template
      });
    } catch (error) {
      console.error('Error fetching movie details:', error);
      res.status(500).send('Internal Server Error');
    }
  });
  

  async function encodeMovieTitle(title) {
    return title
        .toLowerCase()
        .replace(/[^a-z0-9\s]/g, '')
        .trim()
        .replace(/\s+/g, '-')
        .replace(/-+/g, '-');
}

async function fetchIframeUrl(encodedTitle) {
    const url = `https://w1.nites.is/movies/${encodedTitle}/`;

    try {
        const response = await axios.get(url);
        const $ = cheerio.load(response.data);

        const iframe = $('iframe').first();
        const iframeSrc = iframe.attr('data-lazy-src') || iframe.attr('src');

        if (iframeSrc) {
            return iframeSrc;
        } else {
            // console.log('Iframe found but does not have a src attribute.');
            return null;
        }
    } catch (err) {
        // console.error(`Error fetching page: ${err.message}`);
        return null;
    }
}

async function getMovieDetails(movieId) {
    try {
        const response = await axios.get(`https://api.themoviedb.org/3/movie/${movieId}?api_key=${apiKey}&language=en-US`);
        const movie = response.data;

        const recommendationsResponse = await axios.get(`https://api.themoviedb.org/3/movie/${movieId}/recommendations?api_key=${apiKey}&language=en-US`);
        const relatedMovies = recommendationsResponse.data.results;

        const movieDetails = {
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            backdropPath: movie.backdrop_path,
            posterPath: movie.poster_path,
            genres: movie.genres,
            release_date: movie.release_date,
            runtime: movie.runtime,
            vote_average: movie.vote_average,
            vote_count: movie.vote_count
            // Add any other movie details you need
        };

        const encodedTitle = await encodeMovieTitle(movie.title);
        const iframeUrl = await fetchIframeUrl(encodedTitle);

        const servers = [
            { id: '1', name: 'English', url: iframeUrl },
            { id: '2', name: 'Urdu/Hindi', url: `https://ha-entertainment.netlify.app/embed/watch-embed?id=${movieId}` },
            { id: '3', name: 'Urdu/Hindi', url: `https://ha-entertainment.netlify.app/embed/watch-embed2?id=${movieId}` },
            { id: '4', name: 'English', url: `https://moviesapi.club/movie/${movieId}` },
            { id: '5', name: 'English', url: `https://multiembed.mov/?video_id=${movieId}&tmdb=1` },
            { id: '6', name: 'English', url: `https://vidsrc.xyz/embed/movie?tmdb=${movieId}` },
            { id: '7', name: 'English', url: `https://www.2embed.cc/embed/${movieId}` },
        ];

        return { movie: movieDetails, servers: servers, relatedMovies: relatedMovies };
    } catch (error) {
        console.error('Error fetching movie details from TMDb:', error);
        throw new Error('Failed to fetch movie details');
    }
}

  // Function to fetch trailer ID
  async function getTrailerId(movieId) {
    try {
      const response = await axios.get(`https://api.themoviedb.org/3/movie/${movieId}/videos?api_key=${apiKey}&language=en-US`);
      const videos = response.data.results;
      
      const trailer = videos.find(video => video.type === 'Trailer' && video.site === 'YouTube');
      return trailer ? trailer.key : null;
    } catch (error) {
      console.error('Error fetching trailer ID:', error);
      return null;
    }
  }
  
  // Function to fetch cast details
  async function getCastDetails(movieId) {
    try {
      const response = await axios.get(`https://api.themoviedb.org/3/movie/${movieId}/credits?api_key=${apiKey}&language=en-US`);
      const cast = response.data.cast; // Get the cast details
  
      // Map cast details to include required fields
      const castDetails = cast.map(person => ({
        id: person.id,
        name: person.name,
        character: person.character,
        profilePath: person.profile_path
      }));
  
      return castDetails;
    } catch (error) {
      console.error('Error fetching cast details:', error);
      return [];
    }
  } 

  app.get('/watch-series/:id/season/:season/episode/:episode', async (req, res) => {
    const { id, season, episode } = req.params;

    try {
        // Fetch series details
        const seriesResponse = await axios.get(`https://api.themoviedb.org/3/tv/${id}?api_key=${apiKey}`);
        const series = seriesResponse.data;

        // Fetch all seasons
        const seasons = series.seasons;

        // Fetch episodes for the selected season
        const episodesResponse = await axios.get(`https://api.themoviedb.org/3/tv/${id}/season/${season}?api_key=${apiKey}`);
        const episodes = episodesResponse.data.episodes;

        // Get the current episode ID or the first episode in the season by default
        const currentEpisode = episodes.find(ep => ep.episode_number == episode) || episodes[0];

        // Servers data with URLs
        const servers = [
            { name: 'English', url: `https://moviesapi.club/tv/${id}-${season}-${currentEpisode.episode_number}` },
            { name: 'Hindi/Urdu', url: `https://ha-entertainment.netlify.app/embed/watch-embed?id=${currentEpisode.id}` },
            { name: 'Hindi/Urdu', url: `https://ha-entertainment.netlify.app/embed/watch-embed2?id=${currentEpisode.id}` },
            { name: 'English', url: `https://multiembed.mov/?video_id=${id}&tmdb=1&s=${season}&e=${currentEpisode.episode_number}` },
            { name: 'English', url: `https://vidsrc.xyz/embed/tv?tmdb=${id}&season=${season}&episode=${currentEpisode.episode_number}` },
            { name: 'English', url: `https://www.2embed.cc/embedtv/${id}&s=${season}&e=${currentEpisode.episode_number}` },
            { name: 'English', url: `https://movieuniverse.lol/embedtv/${id}&season=${season}&episode=${currentEpisode.episode_number}` }
        ];

        // Render the EJS template with series, seasons, episodes, and servers data
        res.render('watch-series', {
            series,
            seasons,
            episodes,
            selectedSeason: season,
            currentEpisode,
            servers
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error fetching series data');
    }
});

app.get('/watch-series/:id', (req, res) => {
    const { id } = req.params;
    res.redirect(`/watch-series/${id}/season/1/episode/1`);
});

app.get('/watch-series/:id/season/:season', (req, res) => {
    const { id, season } = req.params;
    res.redirect(`/watch-series/${id}/season/${season}/episode/1`);
});

// Route to capture cast details
app.get('/cast/:id', async (req, res) => {
  try {
      const castId = req.params.id;
      const currentPage = parseInt(req.query.page) || 1; // Get current page from query params
      const itemsPerPage = 12; // Number of items per page

      // Fetch cast details
      const castResponse = await axios.get(`https://api.themoviedb.org/3/person/${castId}`, {
          params: { api_key: apiKey }
      });
      const cast = castResponse.data;

      // Fetch cast's known for movies/shows
      const castCreditsResponse = await axios.get(`https://api.themoviedb.org/3/person/${castId}/combined_credits`, {
          params: { api_key: apiKey }
      });
      const allMovies = castCreditsResponse.data.cast;

      // Pagination calculations
      const totalItems = allMovies.length;
      const totalPages = Math.ceil(totalItems / itemsPerPage);
      const paginatedMovies = allMovies.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage);

      // Render the template with pagination data
      res.render('cast', {
          cast,
          known_for: paginatedMovies,
          totalPages,
          currentPage
      });
  } catch (error) {
      console.error('Error fetching cast details:', error);
      res.status(500).send('Internal Server Error');
  }
});

app.get('/genre/:id', async (req, res) => {
  try {
      const genreId = req.params.id;
      const page = parseInt(req.query.page) || 1;

      // Validate the page number
      if (isNaN(page) || page < 1 || page > 500) {
          return res.status(400).send('Invalid page number.');
      }

      // Fetch movies by genre
      const moviesResponse = await axios.get(`https://api.themoviedb.org/3/discover/movie`, {
          params: {
              api_key: apiKey,
              with_genres: genreId,
              page: page,
              language: 'en-US'
          }
      });
      const movies = moviesResponse.data.results;
      const totalMoviesPages = Math.min(moviesResponse.data.total_pages, 500);

      // Fetch TV shows by genre
      const tvShowsResponse = await axios.get(`https://api.themoviedb.org/3/discover/tv`, {
          params: {
              api_key: apiKey,
              with_genres: genreId,
              page: page,
              language: 'en-US'
          }
      });
      const tvShows = tvShowsResponse.data.results;
      const totalTvShowsPages = Math.min(tvShowsResponse.data.total_pages, 500);

      // Combine movie and TV show data
      const combinedResults = [
          ...movies.map(movie => ({ ...movie, media_type: 'movie' })),
          ...tvShows.map(tvShow => ({ ...tvShow, media_type: 'tv' }))
      ];
      const totalPages = Math.max(totalMoviesPages, totalTvShowsPages);

      // Fetch genre name from the genre list
      const [moviesGenresResponse, tvGenresResponse] = await Promise.all([
          axios.get('https://api.themoviedb.org/3/genre/movie/list', {
              params: { api_key: apiKey, language: 'en-US' }
          }),
          axios.get('https://api.themoviedb.org/3/genre/tv/list', {
              params: { api_key: apiKey, language: 'en-US' }
          })
      ]);
      const genreList = [...moviesGenresResponse.data.genres, ...tvGenresResponse.data.genres];
      const genre = genreList.find(g => g.id.toString() === genreId);

      res.render('genre', {
          genreId,
          genreName: genre ? genre.name : 'Unknown Genre',
          combinedResults,
          totalPages,
          currentPage: page
      });
  } catch (error) {
      console.error('Error fetching genre details:', error);
      res.status(500).send('Internal Server Error');
  }
});

app.get('/country/:code', async (req, res) => {
  try {
      const countryCode = req.params.code;
      const page = parseInt(req.query.page) || 1;

      // Validate the page number
      if (isNaN(page) || page < 1 || page > 500) {
          return res.status(400).send('Invalid page number.');
      }

      // Fetch country names
      const countriesResponse = await axios.get(`https://api.themoviedb.org/3/configuration/countries`, {
          params: {
              api_key: apiKey
          }
      });
      const countries = countriesResponse.data;
      const country = countries.find(c => c.iso_3166_1 === countryCode);
      const countryName = country ? country.english_name : countryCode;

      // Fetch movies by country
      const moviesResponse = await axios.get(`https://api.themoviedb.org/3/discover/movie`, {
          params: {
              api_key: apiKey,
              with_origin_country: countryCode,
              page: page,
              language: 'en-US'
          }
      });
      const movies = moviesResponse.data.results;
      const totalMoviesPages = Math.min(moviesResponse.data.total_pages, 500);

      // Fetch TV shows by country
      const tvShowsResponse = await axios.get(`https://api.themoviedb.org/3/discover/tv`, {
          params: {
              api_key: apiKey,
              with_origin_country: countryCode,
              page: page,
              language: 'en-US'
          }
      });
      const tvShows = tvShowsResponse.data.results;
      const totalTvShowsPages = Math.min(tvShowsResponse.data.total_pages, 500);

      // Combine movie and TV show data
      const combinedResults = [
          ...movies.map(movie => ({ ...movie, media_type: 'movie' })),
          ...tvShows.map(tvShow => ({ ...tvShow, media_type: 'tv' }))
      ];
      const totalPages = Math.max(totalMoviesPages, totalTvShowsPages);

      res.render('country', {
          countryCode,
          countryName,
          combinedResults,
          totalPages,
          currentPage: page
      });
  } catch (error) {
      console.error('Error fetching country details:', error);
      res.status(500).send('Internal Server Error');
  }
});

// Route to fetch movies and TV series by production company
app.get('/production/:id', async (req, res) => {
  try {
      const productionId = req.params.id;

      // Fetch movies by production company
      const moviesResponse = await axios.get(`https://api.themoviedb.org/3/discover/movie`, {
          params: {
              api_key: apiKey,
              with_companies: productionId,
              page: req.query.page || 1,
              language: 'en-US'
          }
      });
      const movies = moviesResponse.data.results;
      const totalMoviesPages = moviesResponse.data.total_pages;

      // Fetch TV shows by production company
      const tvShowsResponse = await axios.get(`https://api.themoviedb.org/3/discover/tv`, {
          params: {
              api_key: apiKey,
              with_companies: productionId,
              page: req.query.page || 1,
              language: 'en-US'
          }
      });
      const tvShows = tvShowsResponse.data.results;
      const totalTvShowsPages = tvShowsResponse.data.total_pages;

      // Combine movie and TV show data
      const combinedResults = [
          ...movies.map(movie => ({ ...movie, media_type: 'movie' })),
          ...tvShows.map(tvShow => ({ ...tvShow, media_type: 'tv' }))
      ];
      const totalPages = Math.max(totalMoviesPages, totalTvShowsPages);

      // Fetch production company details
      const productionResponse = await axios.get(`https://api.themoviedb.org/3/company/${productionId}`, {
          params: { api_key: apiKey }
      });
      const productionName = productionResponse.data.name;
      const Logo = productionResponse.data.logo_path;

      res.render('production', {
          productionId,
          productionName,
          Logo,
          combinedResults,
          totalPages,
          currentPage: parseInt(req.query.page) || 1
      });
  } catch (error) {
      console.error('Error fetching production details:', error);
      res.status(500).send('Internal Server Error');
  }
});

app.get('/filter', async (req, res) => {
  const { type, genre, country, quality, year, sort, page } = req.query;
  const pageNumber = parseInt(page) || 1; // Default to page 1 if not provided

  try {
      let movies = [];
      let tvSeries = [];
      
      // Base API URL
      let apiUrl = `https://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&sort_by=${sort || 'popularity.desc'}&page=${pageNumber}`;

      if (type.includes('1')) {
          // Fetch movies
          if (genre) apiUrl += `&with_genres=${genre}`;
          if (country) apiUrl += `&with_origin_country=${country}`;
          if (quality) apiUrl += `&quality=hd`;
          if (year) apiUrl += `&primary_release_year=${year}`;
          
          const response = await axios.get(apiUrl);
          movies = response.data.results;
      }

      if (type.includes('2')) {
          // Fetch TV series
          apiUrl = `https://api.themoviedb.org/3/discover/tv?api_key=${apiKey}&sort_by=${sort || 'popularity.desc'}&page=${pageNumber}`;
          
          if (genre) apiUrl += `&with_genres=${genre}`;
          if (country) apiUrl += `&with_origin_country=${country}`;
          if (quality) apiUrl += `&quality=hd`;
          if (year) apiUrl += `&first_air_date_year=${year}`;
          
          const response = await axios.get(apiUrl);
          tvSeries = response.data.results;
      }

      res.render('filter', {
          type: type || '',
          genre: genre || '',
          country: country || '',
          quality: quality || '',
          year: year || '',
          sort: sort || '',
          movies,
          tvSeries,
          currentPage: pageNumber,
          totalPages: 1
      });
  } catch (error) {
      console.error(error);
      res.status(500).send('Error fetching data');
  }
});


module.exports = app;