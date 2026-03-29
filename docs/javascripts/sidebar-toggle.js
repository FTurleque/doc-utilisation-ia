/* ============================================================
   Sidebar Toggle — collapse/expand on desktop
   State is persisted in localStorage
   ============================================================ */

(function () {
  var STORAGE_KEY = 'sidebar-collapsed';
  var COLLAPSED_CLASS = 'sidebar-collapsed';

  function applyState(collapsed) {
    if (collapsed) {
      document.body.classList.add(COLLAPSED_CLASS);
    } else {
      document.body.classList.remove(COLLAPSED_CLASS);
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
})();
