/* Conserver la rubrique demandée lorsque plusieurs ancres sont visibles en bas
 * de page. Dès que l'utilisateur défile, Material reprend son suivi natif. */
(() => {
  let pinned = null;
  let pending = 0;
  let observer;

  function syncSelection() {
    if (!pinned) return;
    document.querySelectorAll('[data-md-component="toc"] a[href^="#"]').forEach(link => {
      const selected = link.hash === pinned.hash;
      if (link.classList.contains('md-nav__link--active') !== selected) {
        link.classList.toggle('md-nav__link--active', selected);
      }
      if (selected) {
        if (link.getAttribute('aria-current') !== 'location') {
          link.setAttribute('aria-current', 'location');
        }
      } else if (link.hasAttribute('aria-current')) {
        link.removeAttribute('aria-current');
      }
    });
  }

  function release() {
    pinned = null;
    document.querySelectorAll('[data-md-component="toc"] [aria-current="location"]')
      .forEach(link => link.removeAttribute('aria-current'));
  }

  function selectHash(hash) {
    let target;
    try {
      target = document.getElementById(decodeURIComponent(hash.slice(1)));
    } catch {
      return;
    }
    if (!hash || !target || !target.closest('.md-content')) return;
    const request = ++pending;
    // Laisser le saut d'ancre et le suivi natif du thème se terminer.
    requestAnimationFrame(() => requestAnimationFrame(() => {
      if (request !== pending) return;
      pinned = { hash, y: window.scrollY };
      syncSelection();
    }));
  }

  function initialize() {
    release();
    observer?.disconnect();
    observer = new MutationObserver(syncSelection);
    document.querySelectorAll('[data-md-component="toc"]').forEach(toc => {
      observer.observe(toc, { subtree: true, attributes: true, attributeFilter: ['class'] });
    });
    if (location.hash) selectHash(location.hash);
  }

  document.addEventListener('click', event => {
    const link = event.target.closest?.('[data-md-component="toc"] a[href^="#"]');
    if (!link || event.defaultPrevented || event.button !== 0 ||
        event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) return;
    selectHash(link.hash);
  });
  window.addEventListener('hashchange', () => {
    release();
    selectHash(location.hash);
  });
  window.addEventListener('scroll', () => {
    if (pinned && Math.abs(window.scrollY - pinned.y) > 1) release();
  }, { passive: true });
  window.addEventListener('resize', release);

  if (typeof document$ !== 'undefined') document$.subscribe(initialize);
  else if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initialize, { once: true });
  } else initialize();
})();
