const axios = require('axios');
const puppeteer = require('puppeteer');

// Function to fetch m3u8 link from VidSrc embed page
async function fetchM3U8FromVidSrc(vidsrcUrl) {
    try {
        console.log(`Fetching m3u8 from: ${vidsrcUrl}`);
        
        // Launch Puppeteer
        const browser = await puppeteer.launch();
        const page = await browser.newPage();

        // Set user agent to avoid blocking
        await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36');
        
        // Intercept network requests to capture m3u8 links
        let m3u8Link = null;
        const foundUrls = new Set();
        
        await page.setRequestInterception(true);
        
        // Listen for requests
        page.on('request', (request) => {
            const url = request.url();
            if (url.includes('.m3u8') || url.includes('m3u8')) {
                m3u8Link = url;
                foundUrls.add(url);
                console.log(`Found m3u8 link in request: ${url}`);
            }
            request.continue();
        });
        
        // Listen for responses
        page.on('response', async (response) => {
            const url = response.url();
            if (url.includes('.m3u8') || url.includes('m3u8')) {
                m3u8Link = url;
                foundUrls.add(url);
                console.log(`Found m3u8 link in response: ${url}`);
            }
            
            // Also check response headers for m3u8 content
            const contentType = response.headers()['content-type'];
            if (contentType && (contentType.includes('application/x-mpegURL') || contentType.includes('application/vnd.apple.mpegurl'))) {
                m3u8Link = url;
                foundUrls.add(url);
                console.log(`Found m3u8 link by content-type: ${url}`);
            }
        });

        console.log('Loading VidSrc page and waiting for network requests...');
        await page.goto(vidsrcUrl, { waitUntil: 'networkidle2', timeout: 30000 });
        
        // Wait additional time for any delayed m3u8 requests
        await new Promise(resolve => setTimeout(resolve, 10000));
        
        // Try to trigger any play buttons or video elements that might load m3u8
        try {
            await page.evaluate(() => {
                // Look for play buttons and click them
                const playButtons = document.querySelectorAll('button, .play-btn, [class*="play"], [id*="play"]');
                playButtons.forEach(btn => {
                    if (btn.textContent.toLowerCase().includes('play') || btn.className.toLowerCase().includes('play')) {
                        btn.click();
                    }
                });
                
                // Look for video elements and try to play them
                const videos = document.querySelectorAll('video');
                videos.forEach(video => {
                    try {
                        const playPromise = video.play();
                        if (playPromise !== undefined) {
                            playPromise.catch(error => console.log('Video playback prevented:', error));
                        }
                    } catch (e) {
                        // Ignore play errors
                    }
                });
            });
            
            // Wait a bit more after clicking play buttons
            await new Promise(resolve => setTimeout(resolve, 5000));
        } catch (e) {
            console.log('Could not trigger play elements:', e.message);
        }

        await browser.close();
        
        // Return the first found m3u8 link
        if (foundUrls.size > 0) {
            m3u8Link = Array.from(foundUrls)[0];
        }
        
        
        if (m3u8Link) {
            // Clean the URL if needed
            m3u8Link = m3u8Link.trim();
            console.log(`Successfully found m3u8 link: ${m3u8Link}`);
            return m3u8Link;
        } else {
            console.log('No m3u8 link found in VidSrc page');
            return null;
        }
        
    } catch (err) {
        console.error(`Error fetching m3u8 from VidSrc: ${err.message}`);
        return null;
    }
}

// Function to construct VidSrc URL for movies
function constructMovieUrl(tmdbId) {
    return `https://vidsrc.xyz/embed/movie?tmdb=${tmdbId}&ds_lang=en`;
}

// Function to construct VidSrc URL for TV shows
function constructTVUrl(tmdbId, season, episode) {
    return `https://vidsrc.xyz/embed/tv?tmdb=${tmdbId}&season=${season}&episode=${episode}`;
}

module.exports = {
    fetchM3U8FromVidSrc,
    constructMovieUrl,
    constructTVUrl
};
