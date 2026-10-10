---
layout: home
title: De Word2Vec a agentes de inteligencia artificial
---

<link rel="stylesheet" href="{{ '/assets/rea.css' | relative_url }}">
<script src="{{ '/assets/header-scroll.js' | relative_url }}" defer></script>

<main class="page-shell home-page">
  <section class="module-hero home-hero" aria-labelledby="home-title">
    <div class="eyebrow"><span>RECURSO EDUCATIVO · INTELIGENCIA ARTIFICIAL</span><span class="eyebrow-divider"></span><span>3 MÓDULOS</span></div>
    <h1 id="home-title">Del texto a los agentes de IA</h1>
    <p class="lead">Una ruta teórico-práctica para explorar cómo se procesa el lenguaje, cómo se representa con vectores y cómo un agente puede usar herramientas para resolver tareas.</p>
    <div class="action-row">
      <a class="button primary" href="modulos_html/01-word2vec.html">Comenzar la ruta <span aria-hidden="true">→</span></a>
      <a class="button secondary" href="guia-reutilizacion.html">Ver guía docente</a>
    </div>
    <p class="source-note">Material de la Cátedra de Inteligencia Artificial · lectura web y cuadernos Jupyter</p>
  </section>

  <aside class="notice home-status"><strong>Proyecto en preparación.</strong> Las notebooks ya se pueden leer en HTML. La autorización de licencias y el cotejo institucional siguen pendientes. La ruta técnica incorpora una actualización documentada de Gensim, agentes, Skills, MCP y prácticas de seguridad.</aside>

  <section class="home-route" aria-labelledby="route-title">
    <div class="section-heading">
      <div><div class="eyebrow home-eyebrow">ITINERARIO FORMATIVO</div><h2 id="route-title">Avanza paso a paso</h2></div>
      <p>Lee la explicación en la web o abre el cuaderno para experimentar.</p>
    </div>
    <div class="home-module-grid">
      <article class="home-module-card module-card-01">
        <div class="home-card-top"><span class="home-module-number">01</span><span class="home-card-kicker">REPRESENTACIÓN</span></div>
        <h3>Del texto a Word2Vec</h3>
        <p>Preprocesamiento, tokens, Bag-of-Words, embeddings y distancias entre palabras.</p>
        <div class="home-card-actions"><a href="modulos_html/01-word2vec.html">Leer módulo <span aria-hidden="true">→</span></a><a href="https://colab.research.google.com/github/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/2025_word2vec.ipynb" target="_blank" rel="noopener noreferrer">Abrir Colab ↗</a></div>
      </article>
      <article class="home-module-card module-card-02">
        <div class="home-card-top"><span class="home-module-number">02</span><span class="home-card-kicker">RAZONAR Y ACTUAR</span></div>
        <h3>Construir un agente ReAct</h3>
        <p>Herramientas, parser de acciones y ciclo Thought–Action–Observation en Python.</p>
        <div class="home-card-actions"><a href="modulos_html/02-agente-react.html">Leer módulo <span aria-hidden="true">→</span></a><a href="https://colab.research.google.com/github/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/Agente_ReAct.ipynb" target="_blank" rel="noopener noreferrer">Abrir Colab ↗</a></div>
      </article>
      <article class="home-module-card module-card-03">
        <div class="home-card-top"><span class="home-module-number">03</span><span class="home-card-kicker">ABSTRACCIÓN</span></div>
        <h3>Frameworks y skills</h3>
        <p>LangChain, LangGraph, herramientas reutilizables y capacidades compuestas.</p>
        <div class="home-card-actions"><a href="modulos_html/03-frameworks-skills.html">Leer módulo <span aria-hidden="true">→</span></a><a href="https://colab.research.google.com/github/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/Agente_LangChain.ipynb" target="_blank" rel="noopener noreferrer">Abrir Colab ↗</a></div>
      </article>
    </div>
  </section>

  <section class="home-details" aria-label="Información del recurso">
    <article class="home-info-card">
      <span class="home-card-kicker">FICHA DEL RECURSO</span>
      <h2>Una secuencia para comprender y construir</h2>
      <dl class="home-facts">
        <div><dt>Área</dt><dd>Inteligencia Artificial y Procesamiento del Lenguaje Natural</dd></div>
        <div><dt>Destinatarios</dt><dd>Estudiantes de nivel superior; perfil y conocimientos previos por confirmar con la cátedra.</dd></div>
        <div><dt>Formatos</dt><dd>Páginas HTML estáticas, notebooks Jupyter y PDF de lectura.</dd></div>
        <div><dt>Autoría y licencia</dt><dd>Pendientes de confirmación y autorización del equipo titular.</dd></div>
      </dl>
    </article>
    <article class="home-info-card home-info-tint">
      <span class="home-card-kicker">PARA DOCENTES</span>
      <h2>Reutilizar, adaptar, evaluar</h2>
      <p>Consulta los objetivos propuestos, requisitos técnicos, ideas de adaptación y evaluación formativa.</p>
      <a class="text-link" href="guia-reutilizacion.html">Abrir guía de reutilización docente →</a>
      <hr>
      <p class="small-note">La licencia abierta está pendiente de autorización y declaración explícita. Los documentos originales de evaluación SRC-06, SRC-09, SRC-21 y SRC-26 deben cotejarse antes de cerrar la propuesta.</p>
      <a class="text-link" href="licencias-y-atribuciones.html">Revisar licencias y atribuciones →</a>
    </article>
  </section>

  <footer class="home-footer-note">Las páginas muestran el contenido guardado en las notebooks y no ejecutan código. Los cuadernos originales se pueden descargar desde cada módulo. <a href="fuentes/actualizacion-fuentes-2026.html">Consulta las fuentes actuales y los cambios incorporados.</a></footer>
</main>
