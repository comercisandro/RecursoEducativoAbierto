---
layout: page
title: Actividad integradora y evaluación
permalink: /evaluacion-final.html
---

<link rel="stylesheet" href="{{ '/assets/rea.css?v=20261010-6' | relative_url }}">
<script src="{{ '/assets/header-scroll.js' | relative_url }}" defer></script>

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
<thead><tr><th scope="col">Criterio</th><th scope="col">Puntos</th><th scope="col">Evidencia esperada</th></tr></thead>
<tbody>
<tr><th scope="row">Comprensión y distinción conceptual</th><td>25</td><td>Diferencia representación, herramienta, observación, Skill, protocolo y orquestación cuando corresponde.</td></tr>
<tr><th scope="row">Flujo, trazas y pruebas</th><td>25</td><td>El diseño muestra pasos verificables, una respuesta final y casos normales y de error.</td></tr>
<tr><th scope="row">Reproducibilidad y límites</th><td>20</td><td>Declara datos, versiones, supuestos, parámetros y qué no puede concluirse.</td></tr>
<tr><th scope="row">Seguridad y privacidad</th><td>20</td><td>Aplica mínimo privilegio, valida entradas y resultados y evita credenciales o datos innecesarios.</td></tr>
<tr><th scope="row">Comunicación y reflexión</th><td>10</td><td>Explica decisiones con claridad, incorpora una revisión y reconoce cambios pendientes.</td></tr>
</tbody>
</table>
</section>

## Revisión entre pares

Primero resuelve individualmente. Después compara tu diseño con otra persona o equipo. La revisión es formativa y puede hacerse con esta lista:

<ul class="checklist">
<li><label><input type="checkbox"> ¿El objetivo y los límites de la tarea se entienden?</label></li>
<li><label><input type="checkbox"> ¿Se distingue lo que genera el modelo de lo que ejecuta una herramienta?</label></li>
<li><label><input type="checkbox"> ¿Hay pruebas para entradas inválidas, fallos y terminación?</label></li>
<li><label><input type="checkbox"> ¿Los permisos y datos son los mínimos necesarios?</label></li>
<li><label><input type="checkbox"> ¿La explicación ofrece una alternativa si no se puede ejecutar el código?</label></li>
</ul>

Registra **qué observación recibiste, qué modificaste y por qué**. Si la actividad se usa en una consigna acreditable, confirma antes las reglas de colaboración, citación y uso de herramientas de IA; esta página no las modifica.

## Alternativa sin ejecución

Puedes entregar un diagrama, una tabla de casos de prueba y una traza escrita con entradas y salidas ficticias. La evaluación debe centrarse en los objetivos y evidencias definidos, no en tener acceso a Colab, una cuenta de proveedor o una clave de API.

<p class="home-footer-note"><strong>Licencia y transparencia:</strong> los componentes propios autorizados de esta propuesta se distribuyen bajo <a href="{{ '/LICENSE.md' | relative_url }}">CC BY-NC-SA 4.0</a>. Los materiales de terceros conservan sus condiciones. Consulta la <a href="{{ '/guia-reutilizacion.html' | relative_url }}">guía docente</a> y el <a href="{{ '/licencias-y-atribuciones.html' | relative_url }}">inventario de atribuciones</a> antes de adaptar la actividad.</p>
