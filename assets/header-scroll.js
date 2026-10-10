(() => {
  const header = document.querySelector('.site-header');
  if (!header) return;

  const compactAt = 64;
  const expandAt = 24;
  let compact = false;
  let scheduled = false;

  const update = () => {
    const scrollY = window.scrollY || document.documentElement.scrollTop;
    if (!compact && scrollY > compactAt) compact = true;
    else if (compact && scrollY < expandAt) compact = false;
    header.classList.toggle('is-compact', compact);
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
