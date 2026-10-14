(() => {
  const modules = {
    1: {
      title: 'Del texto a Word2Vec',
      kicker: 'MÓDULO 1 · TEXTO Y EMBEDDINGS',
      description: 'Prepara un corpus, observa cómo se aprenden embeddings y explora qué muestran —y qué no muestran— las similitudes entre palabras.',
      objectives: ['Preparar el corpus', 'Aprender embeddings', 'Leer similitudes'],
      video: 'https://drive.google.com/file/d/1P72hdUcRjhEczzgtXxFBD8OZbMtq2i52/preview',
      notebook: 'modulo-1.ipynb',
      pdf: 'modulo-1 - Colab.pdf',
      page: '01-word2vec.html',
      idea: 'Word2Vec aprende representaciones vectoriales a partir de contextos; una similitud refleja patrones del corpus y no una definición o comprensión humana.',
      outcomes: ['Relacionar decisiones de limpieza y tokenización con las representaciones aprendidas.', 'Interpretar una similitud sin exceder lo que permiten concluir los datos.'],
      activity: 'Cambia una decisión de preprocesamiento y predice qué efecto podría tener en las palabras próximas en el espacio vectorial.',
      question: '¿Qué información conserva una representación basada en frecuencias y qué relaciones no expresa directamente?',
      evidence: 'Explica una decisión de preprocesamiento y qué observaste en los embeddings.',
      requirements: 'Para ejecutar, revisa los datos requeridos, las versiones y las advertencias de la página del módulo. También puedes estudiar sin ejecutar código.'
    },
    2: {
      title: 'Construir un agente ReAct',
      kicker: 'MÓDULO 2 · AGENTES Y HERRAMIENTAS',
      description: 'Sigue un agente que decide cuándo llamar herramientas, interpreta observaciones y construye una respuesta dentro de un ciclo controlado.',
      objectives: ['Definir herramientas', 'Interpretar acciones', 'Cerrar el ciclo'],
      video: 'https://drive.google.com/file/d/11obRKjCaQyzhnOF3Zp92GlomkoklG2MX/preview',
      notebook: 'modulo-2.ipynb',
      pdf: 'modulo-2 - Colab.pdf',
      page: '02-agente-react.html',
      idea: 'En ReAct se alternan la generación de una acción y la observación de su resultado; una herramienta ejecuta operaciones con permisos y límites definidos.',
      outcomes: ['Distinguir lo que genera el modelo de lo que ejecuta una herramienta.', 'Analizar trazas, errores y condiciones de terminación del ciclo.'],
      activity: 'Anota una traza con una acción exitosa y otra fallida; identifica qué información recibe el agente después de cada llamada.',
      question: '¿Qué controles deben existir antes de que una acción propuesta por el modelo se ejecute?',
      evidence: 'Comenta una traza ReAct y explica cómo responde el agente ante una herramienta no disponible.',
      requirements: 'La ejecución puede requerir dependencias y un token externo. Revisa las advertencias y nunca publiques credenciales.'
    },
    3: {
      title: 'De ReAct a frameworks y Skills',
      kicker: 'MÓDULO 3 · FRAMEWORKS Y COMPOSICIÓN',
      description: 'Compara herramientas, Skills y capas de orquestación para decidir qué abstracción resuelve mejor una tarea y con qué límites.',
      objectives: ['Declarar tools', 'Orquestar el flujo', 'Componer Skills'],
      video: 'fuentes/modulo-3-explicacion.mp4',
      notebook: 'modulo-3.ipynb',
      pdf: 'modulo-3 - Colab.pdf',
      page: '03-frameworks-skills.html',
      idea: 'Los frameworks y las Skills ofrecen distintas capas de organización; no sustituyen el análisis de permisos, dependencias, errores y supervisión.',
      outcomes: ['Diferenciar herramienta, Skill, protocolo y runtime de orquestación.', 'Justificar una elección técnica considerando límites y seguridad.'],
      activity: 'Dibuja una arquitectura mínima para una tarea y anota qué permisos necesita cada componente y cómo comprobarías su funcionamiento.',
      question: '¿Qué aporta una capa de orquestación y qué complejidad o riesgo añade?',
      evidence: 'Presenta un diagrama de componentes, oral o escrito, con permisos mínimos y pruebas propuestas.',
      requirements: 'El video se sirve como archivo local. Para ejecutar la notebook, revisa versiones y requisitos de API; la lectura no requiere ejecutar código.'
    },
    4: {
      title: 'Actividad integradora',
      kicker: 'MÓDULO 4 · DISEÑO Y REFLEXIÓN',
      description: 'Diseña un agente pequeño y auditable que use una herramienta, documenta sus pruebas, límites y decisiones de seguridad, y elige cómo presentar la evidencia.',
      objectives: ['Definir un problema', 'Probar y documentar', 'Reflexionar sobre límites'],
      video: null,
      notebook: null,
      pdf: null,
      page: 'evaluacion-final.html',
      idea: 'La actividad integra la ruta: una solución válida debe hacer visibles su alcance, flujo, pruebas, reproducibilidad, seguridad y reflexión.',
      outcomes: ['Diseñar una solución con código, pseudocódigo o diagrama.', 'Justificar decisiones y reconocer errores, límites y cambios pendientes.'],
      activity: 'Elige una tarea acotada y prepara el problema, el flujo, los casos de prueba, los permisos mínimos y una reflexión final.',
      question: '¿Qué evidencia permite revisar el funcionamiento de tu propuesta sin depender de una API real?',
      evidence: 'Entrega código, pseudocódigo, diagrama o traza acompañada de una explicación y una revisión entre pares.',
      requirements: 'Puedes trabajar con datos ficticios y una traza simulada. La consigna y la rúbrica completa están integradas en esta lección.'
    }
  };

  const $ = (id) => document.getElementById(id);
  const moduleButtons = [...document.querySelectorAll('.module-button')];
  const tabs = [...document.querySelectorAll('.tab')];
  let current = 1;
  let completed = new Set();

  try {
    completed = new Set(JSON.parse(localStorage.getItem('rea-course-completed') || '[]').map(Number));
  } catch (_) {}

  function progress() {
    const count = completed.size;
    $('progress').value = count;
    $('progress-label').textContent = `${count} de 4 completados`;
    $('progress-percent').textContent = `${Math.round(count / 4 * 100)}%`;
    moduleButtons.forEach((button) => button.classList.toggle('complete', completed.has(Number(button.dataset.module))));
    $('complete').checked = completed.has(current);
  }

  function media(item, number) {
    const host = $('media');
    host.replaceChildren();
    if (!item.video) {
      const fallback = document.createElement('div');
      fallback.className = 'media-fallback';
      fallback.innerHTML = '<h3>Actividad integradora</h3><p>La consigna, la rúbrica y las alternativas de entrega están disponibles en la lectura de esta lección.</p>';
      host.append(fallback);
      return;
    }
    if (number === 3) {
      const video = document.createElement('video');
      video.controls = true;
      video.preload = 'metadata';
      video.setAttribute('aria-label', `Explicación en video: ${item.title}`);
      const source = document.createElement('source');
      source.src = item.video;
      source.type = 'video/mp4';
      video.append(source);
      host.append(video);
    } else {
      const iframe = document.createElement('iframe');
      iframe.src = item.video;
      iframe.title = `Explicación en video: ${item.title}`;
      iframe.loading = 'lazy';
      iframe.allow = 'autoplay; fullscreen';
      iframe.allowFullscreen = true;
      host.append(iframe);
    }
  }

  let readingObserver;
  function fitReadingFrame() {
    const frame = $('reading-frame');
    try {
      const documentHeight = Math.max(frame.contentDocument.body.scrollHeight, frame.contentDocument.documentElement.scrollHeight);
      frame.style.height = `${Math.max(420, documentHeight + 24)}px`;
    } catch (_) {}
  }

  $('reading-frame').addEventListener('load', () => {
    fitReadingFrame();
    window.setTimeout(fitReadingFrame, 250);
    window.setTimeout(fitReadingFrame, 1000);
    try {
      if (readingObserver) readingObserver.disconnect();
      readingObserver = new ResizeObserver(fitReadingFrame);
      readingObserver.observe($('reading-frame').contentDocument.documentElement);
    } catch (_) {}
  });

  function render(number) {
    current = Number(number);
    const item = modules[current];
    const isActivity = current === 4;
    const readingPath = isActivity ? item.page : `modulos_html/${item.page}`;

    moduleButtons.forEach((button) => {
      const active = Number(button.dataset.module) === current;
      button.classList.toggle('active', active);
      if (active) button.setAttribute('aria-current', 'step');
      else button.removeAttribute('aria-current');
    });

    $('position').textContent = `MÓDULO 0${current} DE 04`;
    $('kicker').textContent = item.kicker;
    $('lesson-title').textContent = item.title;
    $('description').textContent = item.description;
    $('objectives').replaceChildren(...item.objectives.map((value) => {
      const span = document.createElement('span');
      span.textContent = value;
      return span;
    }));
    $('key-idea').textContent = item.idea;
    $('outcomes').replaceChildren(...item.outcomes.map((value) => {
      const li = document.createElement('li');
      li.textContent = value;
      return li;
    }));
    $('activity').textContent = item.activity;
    $('question').textContent = item.question;
    $('evidence').textContent = item.evidence;
    $('requirements').textContent = item.requirements;
    $('tab-video').hidden = isActivity;
    $('tab-reading').textContent = isActivity ? 'Ver actividad' : 'Leer módulo';
    $('colab-tab').hidden = isActivity;
    $('page-link').href = isActivity ? 'evaluacion-final.html' : `modulos_html/${item.page}`;
    $('reading-frame').src = `${readingPath}?embedded=1`;
    $('reading-frame').title = `Contenido de ${item.title}`;
    $('notebook-link').hidden = isActivity;
    $('pdf-link').hidden = isActivity;

    if (item.notebook) {
      $('notebook-link').href = `fuentes/${item.notebook}`;
      $('pdf-link').href = `fuentes/${encodeURIComponent(item.pdf).replace(/%2D/g, '-')}`;
      $('colab-tab').href = `https://colab.research.google.com/github/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/${item.notebook}`;
    }

    $('previous').disabled = current === 1;
    $('next').disabled = isActivity;
    $('next').textContent = isActivity ? 'Ruta completa' : 'Siguiente módulo →';
    media(item, current);
    $('media-note').textContent = isActivity ? 'La actividad integradora está disponible en la pestaña "Ver actividad".' : `${item.title}. Si prefieres leer, abre la pestaña "Leer módulo".`;
    progress();
    selectView(isActivity ? 'reading' : 'video');
  }

  function selectView(view) {
    tabs.forEach((tab) => {
      const active = tab.dataset.view === view;
      tab.classList.toggle('selected', active);
      tab.setAttribute('aria-selected', String(active));
    });
    ['video', 'reading'].forEach((name) => {
      $(`panel-${name}`).hidden = name !== view;
    });
  }

  moduleButtons.forEach((button) => button.addEventListener('click', () => render(button.dataset.module)));
  tabs.forEach((tab) => tab.addEventListener('click', () => selectView(tab.dataset.view)));
  $('complete').addEventListener('change', (event) => {
    if (event.target.checked) completed.add(current);
    else completed.delete(current);
    try {
      localStorage.setItem('rea-course-completed', JSON.stringify([...completed]));
    } catch (_) {
      $('storage').textContent = 'No se pudo guardar el avance, pero puedes continuar igualmente.';
    }
    progress();
  });
  $('previous').addEventListener('click', () => { if (current > 1) render(current - 1); });
  $('next').addEventListener('click', () => { if (current < 4) render(current + 1); });

  const changeFont = (delta) => {
    const size = parseFloat(getComputedStyle(document.documentElement).fontSize);
    document.documentElement.style.fontSize = `${Math.max(14, Math.min(21, size + delta))}px`;
  };
  $('font-down').addEventListener('click', () => changeFont(-1));
  $('font-up').addEventListener('click', () => changeFont(1));

  try {
    if (localStorage.getItem('rea-course-contrast') === 'true') {
      document.body.classList.add('high-contrast');
      $('contrast').setAttribute('aria-pressed', 'true');
    }
  } catch (_) {}

  $('contrast').addEventListener('click', () => {
    const enabled = document.body.classList.toggle('high-contrast');
    $('contrast').setAttribute('aria-pressed', String(enabled));
    try { localStorage.setItem('rea-course-contrast', String(enabled)); } catch (_) {}
  });

  const requestedModule = Number(new URLSearchParams(window.location.search).get('module'));
  render([1, 2, 3, 4].includes(requestedModule) ? requestedModule : 1);
})();
