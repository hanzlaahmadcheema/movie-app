# Player Routes Documentation

## Overview
The movie-app now supports enhanced player routes that can fetch movie details from TMDB and play M3U8 streams.

## Available Routes

### 1. Standard Movie Player
```
GET /player/:tmdb
```
- Automatically fetches M3U8 stream from VidSrc
- Uses existing functionality
- Example: `/player/12345`

### 2. TV Episode Player
```
GET /player/:tmdb/season/:season/episode/:episode
```
- Automatically fetches M3U8 stream for TV episodes
- Uses existing functionality
- Example: `/player/67890/season/1/episode/5`

### 3. Enhanced Player with TMDB Details (NEW)
```
GET /player/details/:tmdbId?m3u8Link=<url>
```
- Fetches movie details (title, poster) from TMDB API
- Accepts custom M3U8 link as query parameter
- Example: `/player/details/12345?m3u8Link=https://example.com/video.m3u8`

## Parameters

### Required Parameters
- `tmdbId`: The Movie Database ID for the content
- `m3u8Link`: Direct link to the M3U8 stream (for details route)

### Optional Parameters (Template Variables)
- `title`: Movie/episode title (fetched from TMDB for details route)
- `posterPath`: Poster image path (fetched from TMDB for details route)
- `contentType`: 'movie' or 'tv'
- `season`: Season number (TV shows only)
- `episode`: Episode number (TV shows only)

## Setup

### 1. Install Dependencies
```bash
npm install axios
```

### 2. Configure TMDB API Key
Create a `.env` file in your project root:
```env
TMDB_API_KEY=your_api_key_here
```

To get a TMDB API key:
1. Visit https://www.themoviedb.org/
2. Create an account
3. Go to Settings > API
4. Request an API key

### 3. Load Environment Variables
Make sure your main app loads environment variables:
```javascript
require('dotenv').config();
```

## Usage Examples

### Basic Movie Player
```javascript
// Redirect to standard player
window.location.href = '/player/550'; // Fight Club
```

### TV Episode Player
```javascript
// Redirect to TV episode player
window.location.href = '/player/1399/season/1/episode/1'; // Game of Thrones S01E01
```

### Enhanced Player with Custom Stream
```javascript
// Redirect to enhanced player with custom M3U8
const tmdbId = '550';
const m3u8Url = 'https://example.com/stream.m3u8';
window.location.href = `/player/details/${tmdbId}?m3u8Link=${encodeURIComponent(m3u8Url)}`;
```

## Template Variables

The player template (`player-embed-ha.ejs`) now supports these variables:

### Standard Variables
- `title`: Content title
- `tmdbId`: TMDB ID
- `videoUrl` or `m3u8Link`: Video stream URL
- `contentType`: 'movie' or 'tv'

### Enhanced Variables (for details route)
- `posterPath`: TMDB poster path (automatically prefixed with TMDB image URL)

### Backward Compatibility
The template maintains backward compatibility with existing variables:
- `splashimgurl`: Legacy poster URL
- `videoUrl`: Legacy video URL
- All existing progress tracking variables

## API Endpoints

### Get M3U8 Link Only (JSON)
```
GET /player/api/m3u8/:tmdb
GET /player/api/m3u8/:tmdb/season/:season/episode/:episode
```

Returns:
```json
{
  "success": true,
  "m3u8Link": "https://example.com/stream.m3u8",
  "vidsrcUrl": "https://vidsrc.xyz/embed/movie?tmdb=12345"
}
```

## Error Handling

The routes include comprehensive error handling:
- Invalid TMDB IDs
- Missing M3U8 links
- TMDB API failures
- Stream not found scenarios

## Player Features

The enhanced player includes:
- Full-screen video playback
- Progress tracking and resume functionality
- Beautiful resume modal
- TMDB poster integration
- Responsive design
- Mobile-friendly controls

## Notes

- The player uses PlayerJS for video playback
- Progress tracking requires user authentication
- The player is optimized for M3U8 streams
- Poster images are automatically fetched from TMDB at 500px width
