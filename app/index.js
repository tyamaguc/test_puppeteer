const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({executablePath: '/usr/bin/chromium-browser', args: ['--no-sandbox', '--disable-dev-shm-usage']});
  const page = await browser.newPage();
  await page.goto('https://google.com');
  await browser.close();
})();
