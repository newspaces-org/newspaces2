// Filters /archive/ by #element hash — no plugins needed on GitHub Pages.
(function () {
  var chips = document.querySelectorAll('[data-filter]');
  var rows = document.querySelectorAll('.ns-arow');
  function apply() {
    var f = decodeURIComponent(location.hash.slice(1));
    chips.forEach(function (c) {
      var on = c.getAttribute('data-filter') === f;
      c.classList.toggle('tag-accent', on);
      c.classList.toggle('tag-outline', !on);
    });
    rows.forEach(function (r) {
      r.hidden = !!f && (' ' + r.getAttribute('data-tags')).indexOf(' ' + f + ' ') === -1;
    });
  }
  chips.forEach(function (c) {
    if (!c.getAttribute('data-filter')) c.addEventListener('click', function (e) {
      e.preventDefault(); history.replaceState(null, '', location.pathname); apply();
    });
  });
  window.addEventListener('hashchange', apply);
  apply();
})();
