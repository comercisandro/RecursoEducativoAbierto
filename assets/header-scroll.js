(() => {
  const header = document.querySelector('.site-header');
  const banners = document.querySelectorAll('.module-hero');
  if (!header && banners.length === 0) return;

  const compactAt = 64;
  const expandAt = 24;
  let compact = false;
  let scheduled = false;

  const update = () => {
    const scrollY = window.scrollY || document.documentElement.scrollTop;
    if (!compact && scrollY > compactAt) compact = true;
    else if (compact && scrollY < expandAt) compact = false;
    if (header) header.classList.toggle('is-compact', compact);
    banners.forEach((banner) => banner.classList.toggle('is-compact', compact));
    scheduled = false;
  };

  const onScroll = () => {
    if (scheduled) return;
    scheduled = true;
    window.requestAnimationFrame(update);
  };

  update();
  window.addEventListener('scroll', onScroll, { passive: true });
})();
