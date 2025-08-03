# M3U8 Streaming System Setup Guide

This guide will help you integrate the new m3u8 streaming system into your movie-app.

## Files Created/Updated

1. **api/m3u8-fetcher.js** - Core m3u8 extraction functionality
2. **routes/player.js** - Player routes for movies and TV episodes
3. **views/players/player-embed-ha.ejs** - Updated player template
4. **public/js/playerjs.js** - Updated (by you)

## Integration Steps

### 1. Install Required Dependencies

Make sure these packages are installed in your movie-app:

```bash
npm install axios cheerio express
```

### 2. Update your main app.js file

Add the player routes to your main application file:

```javascript
// In your app.js or main server file
const playerRoutes = require('./routes/player');

// Mount the player routes
app.use('/player', playerRoutes);
```

### 3. Route Structure

The system will handle these routes:

- **Movies**: `GET /player/:tmdb` 
  - Example: `/player/12345`
  - Constructs: `https://vidsrc.xyz/embed/movie?tmdb=12345&ds_lang=en`

- **TV Episodes**: `GET /player/:tmdb/season/:season/episode/:episode`
  - Example: `/player/67890/season/1/episode/5`
  - Constructs: `https://vidsrc.xyz/embed/tv?tmdb=67890&season=1&episode=5`

- **API Endpoints** (for AJAX requests):
  - `GET /player/api/m3u8/:tmdb`
  - `GET /player/api/m3u8/:tmdb/season/:season/episode/:episode`

### 4. How It Works

1. **User visits** a player URL (e.g., `/player/12345`)
2. **System constructs** VidSrc URL based on parameters
3. **Fetches VidSrc page** using multiple extraction methods:
   - Searches JavaScript for m3u8 URLs
   - Checks iframe sources
   - Looks for video element sources
4. **Renders player** with extracted m3u8 link using playerjs
5. **Streams video** directly in the browser

### 5. Error Handling

The system includes comprehensive error handling:
- Invalid TMDB IDs
- Invalid season/episode numbers
- Stream not found scenarios
- Network errors during m3u8 extraction

### 6. Testing

Test the system by visiting:
- `http://localhost:3000/player/550` (Fight Club movie)
- `http://localhost:3000/player/1399/season/1/episode/1` (Game of Thrones S01E01)

### 7. Debugging

Check the browser console and server logs for debugging information:
- Player initialization status
- m3u8 extraction attempts
- VidSrc URL construction
- API responses

### 8. Customization

You can customize the system by:
- Modifying extraction patterns in `m3u8-fetcher.js`
- Adding additional VidSrc parameters
- Customizing the player template
- Adding caching mechanisms
- Implementing request counting

## API Response Format

### Success Response
```json
{
  "success": true,
  "m3u8Link": "https://example.com/video.m3u8",
  "vidsrcUrl": "https://vidsrc.xyz/embed/movie?tmdb=12345&ds_lang=en"
}
```

### Error Response
```json
{
  "success": false,
  "error": "M3U8 link not found"
}
```

## Notes

- The system works without API request counting (as requested)
- No caching is implemented (as requested)
- All m3u8 extraction happens server-side
- The player template is fully responsive and includes progress tracking
- Error pages should be created for proper error handling

## Next Steps

1. Test with real TMDB IDs
2. Add error pages if needed
3. Implement request counting if desired later
4. Add caching for better performance if needed
5. Monitor VidSrc for any changes in their structure
