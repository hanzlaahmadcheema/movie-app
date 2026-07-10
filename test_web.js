const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ args: ['--no-sandbox', '--disable-setuid-sandbox'] });
  const page = await browser.newPage();
  
  // Capture console logs
  page.on('console', msg => console.log('BROWSER CONSOLE:', msg.text()));
  page.on('pageerror', error => console.error('BROWSER ERROR:', error.message));

  page.on('console', msg => console.log('PAGE LOG:', msg.text()));
  page.on('pageerror', err => console.log('PAGE ERROR:', err.toString()));

  console.log('Navigating to http://localhost:33063/');
  await page.goto('http://localhost:33063/', { waitUntil: 'domcontentloaded' });
  
  console.log('Navigating to search page...');
  await page.goto('http://localhost:33063/#/search', { waitUntil: 'domcontentloaded' });

  // Wait a little for flutter to render
  await page.waitForTimeout(3000);
  
  // Try to find the search input
  const inputs = await page.$$('input');
  console.log('Found ' + inputs.length + ' inputs');
  if (inputs.length > 0) {
    await inputs[0].type('batman');
    console.log('Typed batman');
    await page.waitForTimeout(3000);
  }

  console.log('Wait 5s to see if errors appear...');
  await page.waitForTimeout(5000);
  
  await browser.close();
})();
