const express = require('express');
const router = express.Router();
const axios = require('axios');
const { fetchM3U8FromVidSrc, constructMovieUrl, constructTVUrl } = require('../api/m3u8-fetcher');

// Route for movie player: /player/:tmdb
router.get('/:tmdb', async (req, res) => {
    try {
        const { tmdb } = req.params;
        
        // Validate TMDB ID
        if (!tmdb || isNaN(tmdb)) {
            return res.status(400).render('error', { 
                contentType: 'movie',
                error: 'Invalid TMDB ID provided'
            });
        }

        console.log(`Processing movie request for TMDB ID: ${tmdb}`);
        
        // Construct VidSrc URL for movie
        const vidsrcUrl = constructMovieUrl(tmdb);
        console.log(`Constructed VidSrc URL: ${vidsrcUrl}`);
        
        // Fetch m3u8 link from VidSrc
        const m3u8Link = await fetchM3U8FromVidSrc(vidsrcUrl);
        
        if (!m3u8Link) {
            return res.status(404).render('error', {
                contentType: 'movie',
                error: 'Stream not found for this movie'
            });
        }

        // Render the player with the m3u8 link
        res.render('players/player-embed-ha', {
            title: `Movie Player - ${tmdb}`,
            videoUrl: m3u8Link,
            contentType: 'movie',
            tmdbId: tmdb,
            vidsrcUrl: vidsrcUrl
        });

    } catch (error) {
        console.error('Error in movie player route:', error);
        res.status(500).render('error', {
            contentType: 'movie',
            error: 'Internal server error while loading movie'
        });
    }
});

// Route for TV episode player: /player/:tmdb/season/:season/episode/:episode
router.get('/:tmdb/season/:season/episode/:episode', async (req, res) => {
    try {
        const { tmdb, season, episode } = req.params;
        
        // Validate parameters
        if (!tmdb || isNaN(tmdb)) {
            return res.status(400).render('error', { 
                contentType: 'TV show',
                error: 'Invalid TMDB ID provided'
            });
        }
        
        if (!season || isNaN(season) || season < 0) {
            return res.status(400).render('error', { 
                contentType: 'TV show',
                error: 'Invalid season number provided'
            });
        }
        
        if (!episode || isNaN(episode) || episode < 0) {
            return res.status(400).render('error', { 
                contentType: 'TV show',
                error: 'Invalid episode number provided'
            });
        }

        console.log(`Processing TV episode request for TMDB ID: ${tmdb}, Season: ${season}, Episode: ${episode}`);
        
        // Construct VidSrc URL for TV episode
        const vidsrcUrl = constructTVUrl(tmdb, season, episode);
        console.log(`Constructed VidSrc URL: ${vidsrcUrl}`);
        
        // Fetch m3u8 link from VidSrc
        const m3u8Link = await fetchM3U8FromVidSrc(vidsrcUrl);
        
        if (!m3u8Link) {
            return res.status(404).render('error', {
                contentType: 'TV show',
                error: `Stream not found for Season ${season}, Episode ${episode}`
            });
        }

        // Render the player with the m3u8 link
        res.render('players/player-embed-ha', {
            title: `TV Player - S${season}E${episode}`,
            videoUrl: m3u8Link,
            contentType: 'tv',
            tmdbId: tmdb,
            season: season,
            episode: episode,
            vidsrcUrl: vidsrcUrl
        });

    } catch (error) {
        console.error('Error in TV episode player route:', error);
        res.status(500).render('error', {
            contentType: 'TV show',
            error: 'Internal server error while loading episode'
        });
    }
});

// API endpoint to get m3u8 link directly (for AJAX requests)
router.get('/api/m3u8/:tmdb', async (req, res) => {
    try {
        const { tmdb } = req.params;
        const vidsrcUrl = constructMovieUrl(tmdb);
        const m3u8Link = await fetchM3U8FromVidSrc(vidsrcUrl);
        
        if (m3u8Link) {
            res.json({ 
                success: true, 
                m3u8Link: m3u8Link,
                vidsrcUrl: vidsrcUrl
            });
        } else {
            res.status(404).json({ 
                success: false, 
                error: 'M3U8 link not found' 
            });
        }
    } catch (error) {
        console.error('Error in API m3u8 endpoint:', error);
        res.status(500).json({ 
            success: false, 
            error: 'Internal server error' 
        });
    }
});

// API endpoint to get m3u8 link for TV episodes
router.get('/api/m3u8/:tmdb/season/:season/episode/:episode', async (req, res) => {
    try {
        const { tmdb, season, episode } = req.params;
        const vidsrcUrl = constructTVUrl(tmdb, season, episode);
        const m3u8Link = await fetchM3U8FromVidSrc(vidsrcUrl);
        
        if (m3u8Link) {
            res.json({ 
                success: true, 
                m3u8Link: m3u8Link,
                vidsrcUrl: vidsrcUrl
            });
        } else {
            res.status(404).json({ 
                success: false, 
                error: 'M3U8 link not found' 
            });
        }
    } catch (error) {
        console.error('Error in API m3u8 TV endpoint:', error);
        res.status(500).json({ 
            success: false, 
            error: 'Internal server error' 
        });
    }
});

// Route to fetch movie details and render player
router.get('/details/:tmdbId', async (req, res) => {
    const { tmdbId } = req.params;
    const m3u8Link = req.query.m3u8Link || '';
    
    const apiKey = 'be61c0c4d2504f59b7dd5a83983d904c';
    const url = `https://api.themoviedb.org/3/movie/${tmdbId}?api_key=${apiKey}`;
    
    if (!m3u8Link) {
        return res.status(400).send('M3U8 Link is required as query parameter. Example: ?m3u8Link=https://example.com/video.m3u8');
    }

    try {
        const response = await axios.get(url);
        const { title, poster_path, release_date, overview } = response.data;
        
        const renderData = {
            title,
            m3u8Link,
            tmdbId,
            posterPath: poster_path,
            domain: 'https://ha-entertainment.vercel.app',
            seriesId: tmdbId,
            season: 1,
            episode: 1,
            contentType: 'movie', 
            duration: '',
            splashimgurl: poster_path ? `https://image.tmdb.org/t/p/w500${poster_path}` : ''
        };

        res.render('players/player-embed-ha', renderData);
        
    } catch (error) {
        console.error('Error fetching TMDB details:', error.message);
        res.status(500).send('Internal server error: ' + error.message);
    }
});

module.exports = router;
