---
layout: page
title: Actividad integradora y evaluación
permalink: /evaluacion-final.html
---

<link rel="stylesheet" href="{{ '/assets/rea.css?v=20261010-6' | relative_url }}">
<script src="{{ '/assets/rubric.js?v=20261013-1' | relative_url }}" defer></script>

# Actividad integradora

> **Propuesta formativa pendiente de validación docente.** Los puntos de esta página ayudan a orientar la devolución; no constituyen una calificación institucional ni reemplazan la consigna vigente de la cátedra.

## Diseñar un agente pequeño y auditable

Elige una tarea acotada y diseña una solución que use una herramienta. Puedes entregar **código, pseudocódigo o un diagrama** acompañado de una explicación. No es necesario usar una API real: una traza simulada y datos ficticios permiten demostrar los mismos aprendizajes.

Tu entrega debe incluir:

1. **Problema y alcance:** qué tarea resuelve, para quién y qué queda fuera.
2. **Flujo:** entradas, modelo o reglas, herramienta, observación, decisión y respuesta final.
3. **Casos de prueba:** un caso normal, un error de entrada, una herramienta no disponible y una condición de terminación.
4. **Reproducibilidad:** datos de ejemplo, versiones o supuestos, parámetros relevantes y límites conocidos.
5. **Seguridad:** permisos mínimos, datos que se envían o reciben, validaciones y momento en que se solicita confirmación humana.
6. **Reflexión:** qué podría salir mal y qué cambiarías después de revisar la propuesta con otra persona.

<section class="integrator-card" aria-labelledby="rubric-title">
<h2 id="rubric-title">Rúbrica propuesta · 100 puntos</h2>
<p>Usa los niveles como guía de devolución. La cátedra debe confirmar criterios, puntajes y umbrales antes de utilizarlos para acreditar.</p>
<table>
<thead><tr><th scope="col">Criterio</th><th scope="col">Puntos</th><th scope="col">Evidencia esperada</th><th scope="col">Autoevaluación</th></tr></thead>
<tbody>
<tr data-rubric-row="concepts"><th scope="row">Comprensión y distinción conceptual</th><td>25</td><td>Diferencia representación, herramienta, observación, Skill, protocolo y orquestación cuando corresponde.</td><td><label class="rubric-status"><span class="status-light" aria-hidden="true"></span><span class="sr-only">Estado de comprensión conceptual</span><select data-rubric="concepts" aria-label="Estado de comprensión y distinción conceptual"><option value="pending">Pendiente</option><option value="progress">En proceso</option><option value="complete">Cumplido</option></select></label></td></tr>
<tr data-rubric-row="flow"><th scope="row">Flujo, trazas y pruebas</th><td>25</td><td>El diseño muestra pasos verificables, una respuesta final y casos normales y de error.</td><td><label class="rubric-status"><span class="status-light" aria-hidden="true"></span><span class="sr-only">Estado de flujo, trazas y pruebas</span><select data-rubric="flow" aria-label="Estado de flujo, trazas y pruebas"><option value="pending">Pendiente</option><option value="progress">En proceso</option><option value="complete">Cumplido</option></select></label></td></tr>
<tr data-rubric-row="reproducibility"><th scope="row">Reproducibilidad y límites</th><td>20</td><td>Declara datos, versiones, supuestos, parámetros y qué no puede concluirse.</td><td><label class="rubric-status"><span class="status-light" aria-hidden="true"></span><span class="sr-only">Estado de reproducibilidad y límites</span><select data-rubric="reproducibility" aria-label="Estado de reproducibilidad y límites"><option value="pending">Pendiente</option><option value="progress">En proceso</option><option value="complete">Cumplido</option></select></label></td></tr>
<tr data-rubric-row="security"><th scope="row">Seguridad y privacidad</th><td>20</td><td>Aplica mínimo privilegio, valida entradas y resultados y evita credenciales o datos innecesarios.</td><td><label class="rubric-status"><span class="status-light" aria-hidden="true"></span><span class="sr-only">Estado de seguridad y privacidad</span><select data-rubric="security" aria-label="Estado de seguridad y privacidad"><option value="pending">Pendiente</option><option value="progress">En proceso</option><option value="complete">Cumplido</option></select></label></td></tr>
<tr data-rubric-row="communication"><th scope="row">Comunicación y reflexión</th><td>10</td><td>Explica decisiones con claridad, incorpora una revisión y reconoce cambios pendientes.</td><td><label class="rubric-status"><span class="status-light" aria-hidden="true"></span><span class="sr-only">Estado de comunicación y reflexión</span><select data-rubric="communication" aria-label="Estado de comunicación y reflexión"><option value="pending">Pendiente</option><option value="progress">En proceso</option><option value="complete">Cumplido</option></select></label></td></tr>
</tbody>
</table>
<div class="rubric-selfcheck" aria-live="polite"><div><strong id="rubric-summary">0 de 5 criterios cumplidos</strong><p>Marca cada criterio según el estado actual de tu trabajo. Este registro es formativo y se guarda solo en este navegador.</p></div><div class="rubric-progress-wrap"><progress id="rubric-progress" max="5" value="0" aria-label="Progreso de la autoevaluación">0 de 5</progress><button id="rubric-reset" class="rubric-reset" type="button">Reiniciar autoevaluación</button></div></div>
</section>

## Revisión entre pares

Primero resuelve individualmente. Después compara tu diseño con otra persona o equipo. La revisión es formativa y puede hacerse con esta lista:

<ul class="checklist peer-review-list">
<li data-peer-row="scope"><span>¿El objetivo y los límites de la tarea se entienden?</span><label class="peer-check"><input type="checkbox" data-peer-review="scope" aria-label="Marcar objetivo y límites revisados"><span class="sr-only">Marcar como revisado</span></label></li>
<li data-peer-row="distinction"><span>¿Se distingue lo que genera el modelo de lo que ejecuta una herramienta?</span><label class="peer-check"><input type="checkbox" data-peer-review="distinction" aria-label="Marcar distinción entre modelo y herramienta revisada"><span class="sr-only">Marcar como revisado</span></label></li>
<li data-peer-row="tests"><span>¿Hay pruebas para entradas inválidas, fallos y terminación?</span><label class="peer-check"><input type="checkbox" data-peer-review="tests" aria-label="Marcar pruebas y terminación revisadas"><span class="sr-only">Marcar como revisado</span></label></li>
<li data-peer-row="permissions"><span>¿Los permisos y datos son los mínimos necesarios?</span><label class="peer-check"><input type="checkbox" data-peer-review="permissions" aria-label="Marcar permisos y datos revisados"><span class="sr-only">Marcar como revisado</span></label></li>
<li data-peer-row="alternative"><span>¿La explicación ofrece una alternativa si no se puede ejecutar el código?</span><label class="peer-check"><input type="checkbox" data-peer-review="alternative" aria-label="Marcar alternativa sin ejecución revisada"><span class="sr-only">Marcar como revisado</span></label></li>
</ul>
<div class="rubric-selfcheck peer-selfcheck" aria-live="polite"><div><strong id="peer-summary">0 de 5 criterios revisados</strong><p>Marca con una tilde cada aspecto revisado en el trabajo de otra persona o equipo. Este registro es formativo y local.</p></div><div class="rubric-progress-wrap"><progress id="peer-progress" max="5" value="0" aria-label="Progreso de la revisión entre pares">0 de 5</progress><button id="peer-reset" class="rubric-reset" type="button">Reiniciar revisión</button></div></div>

Registra **qué observación recibiste, qué modificaste y por qué**. Si la actividad se usa en una consigna acreditable, confirma antes las reglas de colaboración, citación y uso de herramientas de IA; esta página no las modifica.

## Alternativa sin ejecución

Puedes entregar un diagrama, una tabla de casos de prueba y una traza escrita con entradas y salidas ficticias. La evaluación debe centrarse en los objetivos y evidencias definidos, no en tener acceso a Colab, una cuenta de proveedor o una clave de API.

<p class="home-footer-note"><strong>Licencia y transparencia:</strong> los componentes propios autorizados de esta propuesta se distribuyen bajo <a href="{{ '/LICENSE.md' | relative_url }}">CC BY-NC-SA 4.0</a>. Los materiales de terceros conservan sus condiciones. Consulta la <a href="{{ '/guia-reutilizacion.html' | relative_url }}">guía docente</a> y el <a href="{{ '/licencias-y-atribuciones.html' | relative_url }}">inventario de atribuciones</a> antes de adaptar la actividad.</p>
