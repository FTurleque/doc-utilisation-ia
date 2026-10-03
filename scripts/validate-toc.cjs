#!/usr/bin/env node
/* Vérification comportementale des sommaires du site construit.
 * Nécessite Playwright, Chromium et un serveur HTTP servant site/.
 * Usage : node scripts/validate-toc.cjs http://127.0.0.1:8765/
 * PLAYWRIGHT_CHROMIUM_EXECUTABLE permet de choisir un navigateur installé. */
const fs = require('node:fs');
const path = require('node:path');
const { chromium } = require('playwright');

function pages(directory) {
  return fs.readdirSync(directory, { withFileTypes: true }).flatMap(entry => {
    const file = path.join(directory, entry.name);
    if (entry.isDirectory()) return pages(file);
    return entry.name === 'index.html' ? [file] : [];
  });
}

(async () => {
  const base = process.argv[2] || 'http://127.0.0.1:8765/';
  const site = path.resolve(__dirname, '../site');
  const files = pages(site).filter(file => !path.relative(site, file).startsWith('assets'));
  const browser = await chromium.launch({
    headless: true,
    ...(process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE
      ? { executablePath: process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE } : {}),
  });
  const errors = [];
  const skippedResources = new Set();
  let count = 0;
  let completed = 0;
  try {
    for (const viewport of [{ width: 1920, height: 1080 }, { width: 390, height: 844 }]) {
      const jobs = [...files];
      await Promise.all(Array.from({ length: 4 }, async () => {
        const page = await browser.newPage({ viewport });
        await page.route('**/*', route => {
          if (new URL(route.request().url()).origin === new URL(base).origin) return route.continue();
          skippedResources.add(route.request().url());
          return route.abort();
        });
        page.on('pageerror', error => {
          // Material signale comme une erreur les CDN volontairement absents
          // de ce test hors ligne. Ne filtrer que la ressource effectivement bloquée.
          const prefix = 'Invalid script: ';
          if (error.message.startsWith(prefix) && skippedResources.has(error.message.slice(prefix.length))) return;
          errors.push({ viewport, error: error.message });
        });
        while (jobs.length) {
          const file = jobs.shift();
          const relative = path.relative(site, path.dirname(file)).replaceAll('\\', '/');
          await page.goto(new URL(relative + '/', base).href, { waitUntil: 'load' });
          const entries = await page.evaluate(() => {
            const toc = document.querySelector('.md-sidebar--secondary [data-md-component="toc"]');
            return [...(toc?.querySelectorAll('a[href^="#"]') || [])].map(link => link.hash);
          });
          const structure = await page.evaluate(hashes => {
            const targets = hashes.map(hash => document.getElementById(decodeURIComponent(hash.slice(1))));
            const issues = [];
            targets.forEach((target, index) => {
              if (!target || !target.closest('.md-content')) issues.push(`Ancre absente : ${hashes[index]}`);
              else if (index && targets[index - 1] &&
                  !(targets[index - 1].compareDocumentPosition(target) & Node.DOCUMENT_POSITION_FOLLOWING)) {
                issues.push(`Ordre incohérent : ${hashes[index]}`);
              }
            });
            const ids = [...document.querySelectorAll('.md-content h1[id], .md-content h2[id], .md-content h3[id], .md-content h4[id], .md-content h5[id], .md-content h6[id]')].map(h => h.id);
            if (new Set(ids).size !== ids.length) issues.push('Identifiants de titres dupliqués');
            return issues;
          }, entries);
          structure.forEach(error => errors.push({ relative, viewport, error }));
          for (const hash of entries) {
            await page.evaluate(hash => {
              const links = [...document.querySelectorAll('[data-md-component="toc"] a[href^="#"]')];
              const link = links.find(link => link.hash === hash);
              link.click();
            }, hash);
            await page.evaluate(() => new Promise(resolve => {
              requestAnimationFrame(() => requestAnimationFrame(() => requestAnimationFrame(resolve)));
            }));
            const state = await page.evaluate(hash => {
              const toc = document.querySelector('.md-sidebar--secondary [data-md-component="toc"]');
              const active = [...toc.querySelectorAll('.md-nav__link--active')].map(link => link.hash);
              return { hash: location.hash, active, current: toc.querySelector('[aria-current="location"]')?.hash };
            }, hash);
            count++;
            if (state.hash !== hash || state.active.length !== 1 || state.active[0] !== hash || state.current !== hash) {
              errors.push({ relative, viewport, expected: hash, state });
            }
          }
          // Après un clic, le défilement manuel doit libérer la sélection fixée.
          if (entries.length) {
            await page.evaluate(() => window.scrollTo(0, 0));
            await page.evaluate(() => new Promise(resolve => requestAnimationFrame(() => requestAnimationFrame(resolve))));
            const stale = await page.locator('[data-md-component="toc"] [aria-current="location"]').count();
            if (stale) errors.push({ relative, viewport, error: 'Sélection figée après défilement manuel' });
          }
          completed++;
          if (completed % 30 === 0) console.log(`${completed} pages/tailles, ${count} ancres contrôlées`);
        }
        await page.close();
      }));
    }
  } finally {
    await browser.close();
  }
  console.log(JSON.stringify({ pages: files.length, viewports: 2, anchors: count,
    offline: true, skippedResources: [...skippedResources], errors }, null, 2));
  process.exitCode = errors.length ? 1 : 0;
})().catch(error => { console.error(error); process.exitCode = 1; });
