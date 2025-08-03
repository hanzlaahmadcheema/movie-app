const { fetchM3U8FromVidSrc, constructMovieUrl, constructTVUrl } = require('./api/m3u8-fetcher');

console.log('🎬 Testing M3U8 Fetcher...\n');

async function testMovieExtraction() {
    console.log('=== MOVIE TEST ===');
    const movieTmdbId = '550'; // Fight Club
    const vidsrcUrl = constructMovieUrl(movieTmdbId);
    
    console.log(`🎥 Testing movie: Fight Club (TMDB: ${movieTmdbId})`);
    console.log(`🔗 VidSrc URL: ${vidsrcUrl}`);
    console.log('⏳ Fetching m3u8 link...\n');
    
    try {
        const m3u8Link = await fetchM3U8FromVidSrc(vidsrcUrl);
        
        if (m3u8Link) {
            console.log('✅ SUCCESS! M3U8 link found:');
            console.log(`📺 ${m3u8Link}`);
        } else {
            console.log('❌ No m3u8 link found');
        }
    } catch (error) {
        console.log('💥 Error:', error.message);
    }
    
    console.log('\n' + '='.repeat(50) + '\n');
}

async function testTVExtraction() {
    console.log('=== TV SERIES TEST ===');
    const tvTmdbId = '1399'; // Game of Thrones
    const season = '1';
    const episode = '1';
    const vidsrcUrl = constructTVUrl(tvTmdbId, season, episode);
    
    console.log(`📺 Testing TV: Game of Thrones S${season}E${episode} (TMDB: ${tvTmdbId})`);
    console.log(`🔗 VidSrc URL: ${vidsrcUrl}`);
    console.log('⏳ Fetching m3u8 link...\n');
    
    try {
        const m3u8Link = await fetchM3U8FromVidSrc(vidsrcUrl);
        
        if (m3u8Link) {
            console.log('✅ SUCCESS! M3U8 link found:');
            console.log(`📺 ${m3u8Link}`);
        } else {
            console.log('❌ No m3u8 link found');
        }
    } catch (error) {
        console.log('💥 Error:', error.message);
    }
    
    console.log('\n' + '='.repeat(50) + '\n');
}

async function runTests() {
    console.log('🚀 Starting M3U8 extraction tests...\n');
    
    await testMovieExtraction();
    await testTVExtraction();
    
    console.log('🏁 Tests completed!');
    console.log('\n📋 Summary:');
    console.log('- If you see m3u8 links above, the system is working correctly');
    console.log('- You can now start the server and test the routes:');
    console.log('  • Movie: http://localhost:3000/player/550');
    console.log('  • TV: http://localhost:3000/player/1399/season/1/episode/1');
}

// Run the tests
runTests().catch(console.error);
