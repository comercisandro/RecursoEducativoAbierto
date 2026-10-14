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
  function setupChecks() {
    const checks = [...document.querySelectorAll('[data-peer-review]')];
    if (!checks.length) return;
    const summary = document.getElementById('peer-summary');
    const progress = document.getElementById('peer-progress');
    const reset = document.getElementById('peer-reset');
    let states = {};
    try { states = JSON.parse(localStorage.getItem(`${key}-peerReview`) || '{}'); } catch (_) { states = {}; }
    function renderChecks() {
      const complete = checks.filter((check) => check.checked).length;
      progress.value = complete;
      summary.textContent = `${complete} de ${checks.length} criterios revisados`;
      try { localStorage.setItem(`${key}-peerReview`, JSON.stringify(Object.fromEntries(checks.map((check) => [check.dataset.peerReview, check.checked])))); } catch (_) { /* La revisión sigue funcionando sin almacenamiento. */ }
    }
    checks.forEach((check) => { check.checked = states[check.dataset.peerReview] === true; check.addEventListener('change', renderChecks); });
    reset.addEventListener('click', () => { checks.forEach((check) => { check.checked = false; }); renderChecks(); });
    renderChecks();
  }
  setupGroup({ selector: '[data-rubric]', stateKey: 'rubric', summaryId: 'rubric-summary', progressId: 'rubric-progress', resetId: 'rubric-reset', stateAttribute: 'data-rubric-row' });
  setupChecks();
})();
