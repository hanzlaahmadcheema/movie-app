const axios = require('axios');
const cheerio = require('cheerio');

// Function to fetch iframe URL from a webpage
async function fetchIframeUrl(pageUrl) {
    try {
        // Fetch the page content
        const response = await axios.get(pageUrl);
        const $ = cheerio.load(response.data);

        // Find the first iframe on the page
        const iframe = $('iframe').first();
        
        // Try different attributes to get the iframe source
        const iframeSrc = iframe.attr('src') || iframe.attr('data-lazy-src') || iframe.attr('data-src');

        if (iframeSrc) {
            console.log(`Found iframe with src: ${iframeSrc}`);
            return iframeSrc;
        } else {
            console.log('Iframe found but does not have a src attribute.');
            return null;
        }
    } catch (err) {
        console.error(`Error fetching page: ${err.message}`);
        return null;
    }
}

// Example usage
const url = 'https://hindilinks4u.show/auron-mein-kahan-dum-tha-2024-Watch-online-full-movie/';
fetchIframeUrl(url).then(iframeUrl => {
    if (iframeUrl) {
        console.log(`Iframe URL: ${iframeUrl}`);
    } else {
        console.log('No iframe URL found.');
    }
});
