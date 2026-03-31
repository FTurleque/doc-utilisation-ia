/* ============================================================
   Sidebar Toggle — collapse/expand on all screens
   Overlay scrim on mobile for better UX
   State is persisted in localStorage
   ============================================================ */

(function () {
  var STORAGE_KEY = 'sidebar-collapsed';
  var COLLAPSED_CLASS = 'sidebar-collapsed';
  var SCRIM_CLASS = 'sidebar-scrim';

  function applyState(collapsed) {
    if (collapsed) {
      document.body.classList.add(COLLAPSED_CLASS);
      removeScrim();
    } else {
      document.body.classList.remove(COLLAPSED_CLASS);
      createScrimIfMobile();
    }
  }

  function createToggleButton() {
    var btn = document.createElement('button');
    btn.id = 'sidebar-toggle-btn';
    btn.setAttribute('aria-label', 'Replier/déplier la navigation');
    btn.setAttribute('title', 'Replier/déplier la navigation');
    btn.innerHTML =
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">' +
      '<path d="M3 6h18v2H3V6zm0 5h18v2H3v-2zm0 5h18v2H3v-2z"/>' +
      '</svg>';
    return btn;
  }

  function createScrimIfMobile() {
    // Ne créer le scrim que sur mobile (< 76.25em)
    if (window.innerWidth < 1220) {
      var existingScrim = document.querySelector('.' + SCRIM_CLASS);
      if (!existingScrim) {
        var scrim = document.createElement('div');
        scrim.className = SCRIM_CLASS;
        scrim.setAttribute('aria-hidden', 'true');
        document.body.appendChild(scrim);
        
        scrim.addEventListener('click', function () {
          document.body.classList.add(COLLAPSED_CLASS);
          localStorage.setItem(STORAGE_KEY, 'true');
          removeScrim();
        });
      }
    }
  }

  function removeScrim() {
    var scrim = document.querySelector('.' + SCRIM_CLASS);
    if (scrim) {
      scrim.remove();
    }
  }

  function init() {
    // Restore persisted state
    var collapsed = localStorage.getItem(STORAGE_KEY) === 'true';
    applyState(collapsed);

    // Create and inject the button into the MkDocs header
    var header = document.querySelector('.md-header__inner');
    if (!header) return;

    var btn = createToggleButton();
    // Insert as first child of header inner (before logo/title)
    header.insertBefore(btn, header.firstChild);

    btn.addEventListener('click', function () {
      var isCollapsed = document.body.classList.toggle(COLLAPSED_CLASS);
      localStorage.setItem(STORAGE_KEY, isCollapsed ? 'true' : 'false');
      applyState(isCollapsed);
    });
  }

  // MkDocs Material uses instant navigation — re-run on page change
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  // Re-inject button after SPA navigation (MkDocs instant loading)
  document.addEventListener('DOMContentSwitch', function () {
    if (!document.getElementById('sidebar-toggle-btn')) {
      init();
    }
  });

  // Fermer le scrim si la fenêtre est redimensionnée au-delà du breakpoint mobile
  window.addEventListener('resize', function () {
    if (window.innerWidth >= 1220) {
      removeScrim();
      document.body.classList.remove(COLLAPSED_CLASS);
      localStorage.setItem(STORAGE_KEY, 'false');
    }
  });
})();
