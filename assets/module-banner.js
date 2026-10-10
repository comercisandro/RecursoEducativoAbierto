(() => {
  const hero = document.querySelector('.module-page > .module-hero');
  const spacer = document.querySelector('.module-hero-spacer');
  const header = document.querySelector('.site-header');
  if (!hero || !spacer) return;

  let scheduled = false;
  const update = () => {
    const headerHeight = header ? header.getBoundingClientRect().height : 0;
    const bannerHeight = hero.getBoundingClientRect().height;
    document.documentElement.style.setProperty('--module-banner-top', `${headerHeight}px`);
    document.documentElement.style.setProperty('--module-banner-space', `${bannerHeight + 19}px`);
    scheduled = false;
  };
  const schedule = () => {
    if (scheduled) return;
    scheduled = true;
    window.requestAnimationFrame(update);
  };

  update();
  window.addEventListener('resize', schedule, { passive: true });
  window.addEventListener('scroll', schedule, { passive: true });
  if (window.ResizeObserver) {
    const observer = new ResizeObserver(schedule);
    observer.observe(hero);
    if (header) observer.observe(header);
  }
})();
