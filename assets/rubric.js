(() => {
  const key = 'rea-integrator-rubric';
  const selects = [...document.querySelectorAll('[data-rubric]')];
  if (!selects.length) return;
  const summary = document.getElementById('rubric-summary');
  const progress = document.getElementById('rubric-progress');
  const reset = document.getElementById('rubric-reset');
  let states = {};
  try { states = JSON.parse(localStorage.getItem(key) || '{}'); } catch (_) { states = {}; }

  function render() {
    const complete = selects.filter((select) => select.value === 'complete').length;
    progress.value = complete;
    summary.textContent = `${complete} de ${selects.length} criterios cumplidos`;
    selects.forEach((select) => {
      const row = select.closest('[data-rubric-row]');
      row.classList.remove('rubric-pending', 'rubric-progress', 'rubric-complete');
      row.classList.add(`rubric-${select.value}`);
    });
    try { localStorage.setItem(key, JSON.stringify(Object.fromEntries(selects.map((select) => [select.dataset.rubric, select.value])))); } catch (_) { /* La autoevaluación sigue funcionando sin almacenamiento. */ }
  }
  selects.forEach((select) => { if (states[select.dataset.rubric]) select.value = states[select.dataset.rubric]; select.addEventListener('change', render); });
  reset.addEventListener('click', () => { selects.forEach((select) => { select.value = 'pending'; }); render(); });
  render();
})();
