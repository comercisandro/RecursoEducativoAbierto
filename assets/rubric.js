(() => {
  const key = 'rea-integrator-rubric';
  function setupGroup({ selector, stateKey, summaryId, progressId, resetId, stateAttribute }) {
    const selects = [...document.querySelectorAll(selector)];
    if (!selects.length) return;
    const summary = document.getElementById(summaryId);
    const progress = document.getElementById(progressId);
    const reset = document.getElementById(resetId);
    let states = {};
    try { states = JSON.parse(localStorage.getItem(`${key}-${stateKey}`) || '{}'); } catch (_) { states = {}; }
    function render() {
      const complete = selects.filter((select) => select.value === 'complete').length;
      progress.value = complete;
      summary.textContent = `${complete} de ${selects.length} criterios cumplidos`;
      selects.forEach((select) => {
        const row = select.closest(`[${stateAttribute}]`);
        row.classList.remove('rubric-pending', 'rubric-progress', 'rubric-complete');
        row.classList.add(`rubric-${select.value}`);
      });
      try { localStorage.setItem(`${key}-${stateKey}`, JSON.stringify(Object.fromEntries(selects.map((select) => [select.dataset[stateKey], select.value])))); } catch (_) { /* La autoevaluación sigue funcionando sin almacenamiento. */ }
    }
    selects.forEach((select) => { if (states[select.dataset[stateKey]]) select.value = states[select.dataset[stateKey]]; select.addEventListener('change', render); });
    reset.addEventListener('click', () => { selects.forEach((select) => { select.value = 'pending'; }); render(); });
    render();
  }
  setupGroup({ selector: '[data-rubric]', stateKey: 'rubric', summaryId: 'rubric-summary', progressId: 'rubric-progress', resetId: 'rubric-reset', stateAttribute: 'data-rubric-row' });
  setupGroup({ selector: '[data-peer-review]', stateKey: 'peerReview', summaryId: 'peer-summary', progressId: 'peer-progress', resetId: 'peer-reset', stateAttribute: 'data-peer-row' });
})();
