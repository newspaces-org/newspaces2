document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".carousel").forEach(function (carousel) {
    var track = carousel.querySelector(".carousel-track");
    var slides = Array.prototype.slice.call(carousel.querySelectorAll(".carousel-slide"));
    var dotsWrap = carousel.querySelector(".carousel-dots");
    var prevBtn = carousel.querySelector(".carousel-prev");
    var nextBtn = carousel.querySelector(".carousel-next");

    if (!track || slides.length < 2) {
      if (prevBtn) prevBtn.remove();
      if (nextBtn) nextBtn.remove();
      if (dotsWrap) dotsWrap.remove();
      return;
    }

    slides.forEach(function (_, i) {
      var dot = document.createElement("button");
      dot.setAttribute("aria-label", "Go to image " + (i + 1));
      if (i === 0) dot.classList.add("active");
      dot.addEventListener("click", function () {
        goTo(i);
      });
      dotsWrap.appendChild(dot);
    });
    var dots = Array.prototype.slice.call(dotsWrap.children);

    function currentIndex() {
      var w = track.clientWidth || 1;
      return Math.round(track.scrollLeft / w);
    }
    function goTo(i) {
      i = Math.max(0, Math.min(slides.length - 1, i));
      track.scrollTo({ left: i * track.clientWidth, behavior: "smooth" });
    }
    function updateDots() {
      var idx = currentIndex();
      dots.forEach(function (d, i) {
        d.classList.toggle("active", i === idx);
      });
    }

    prevBtn.addEventListener("click", function () {
      goTo(currentIndex() - 1);
    });
    nextBtn.addEventListener("click", function () {
      goTo(currentIndex() + 1);
    });
    track.addEventListener("scroll", function () {
      window.requestAnimationFrame(updateDots);
    });
  });
});
