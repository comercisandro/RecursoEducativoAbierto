---
layout: page
title: Guía de reutilización docente
permalink: /guia-reutilizacion.html
---

<link rel="stylesheet" href="{{ '/assets/rea.css' | relative_url }}">
<script src="{{ '/assets/header-scroll.js' | relative_url }}" defer></script>

# Guía de reutilización docente

> Borrador de trabajo. Hay copias locales de **SRC-06, SRC-09, SRC-21 y SRC-26**, ya cotejadas para esta revisión, pero todavía no están versionadas. El PDF disponible de SRC-26 muestra las secciones 1 y 8–11; falta contrastar la guía con el original completo. Las propuestas de abajo no reemplazan las rúbricas ni equivalen a una evaluación institucional.

## 1. Identificación del recurso

- **Título:** De Word2Vec a agentes de inteligencia artificial.
- **Autoría y afiliación:** pendientes de confirmar con el equipo de cátedra.
- **Área:** Inteligencia Artificial y Procesamiento del Lenguaje Natural.
- **Versión:** borrador inicial.
- **Repositorio:** este repositorio de GitHub; URL pública permanente pendiente de confirmar.

## 2. Destinatarios y contexto

Propuesta dirigida a estudiantes de nivel superior vinculados con Inteligencia Artificial o áreas afines. El nivel, carrera, espacio curricular y perfil de ingreso deben precisarse con la cátedra.

## 3. Propósito pedagógico

Construir una comprensión progresiva del procesamiento y la representación del lenguaje, y conectar esos fundamentos con el diseño de agentes que utilizan herramientas.

## 4. Objetivos de aprendizaje propuestos

Al finalizar la ruta, se espera que el estudiantado pueda:

1. Describir decisiones básicas de preprocesamiento y tokenización de texto.
2. Explicar la diferencia entre una representación basada en frecuencias y embeddings aprendidos a partir de contextos.
3. Interpretar de manera básica distancias o similitudes entre vectores de palabras.
4. Describir el ciclo ReAct e identificar la función de una herramienta y de su observación.
5. Comparar una implementación manual de agente con una implementación basada en framework.
6. Diseñar una actividad o extensión pequeña que use herramientas y contemple pruebas.
7. Distinguir una herramienta, un paquete de instrucciones (Skill), un protocolo de interoperabilidad (MCP) y un runtime de orquestación; argumentar qué problema resuelve cada capa.
8. Registrar versiones, parámetros y datos de entrada para poder revisar la reproducibilidad de una práctica de NLP o agentes.

Estos objetivos son una propuesta y deben validarse con el programa de la asignatura y los notebooks originales.

## 5. Organización y sugerencia de implementación

La secuencia se organiza en tres módulos: **texto y embeddings** (SRC-01), **ReAct manual** (SRC-04) y **frameworks y skills** (SRC-03). Se sugiere avanzar en ese orden y reservar una instancia integradora para diseñar y probar una herramienta. La duración y modalidad se definirán según la planificación de la cátedra.

> La copia local de las instrucciones **SRC-16** indica que para la actividad cooperativa acreditable del punto 3 no corresponde usar herramientas de IA. Confirmar la consigna vigente en el aula virtual; las actividades de IA de esta guía son propuestas independientes y no modifican esa instrucción.

## 6. Requisitos técnicos y formatos

- Navegador web para leer las páginas estáticas; no requieren ejecutar código ni instalar software (SRC-09, portabilidad).
- Notebook Jupyter `.ipynb` para las prácticas; Google Colab es opcional y requiere acceso a internet. Las páginas HTML y PDF permiten una alternativa de lectura/análisis sin ejecutar celdas.
- La práctica Word2Vec necesita el CSV `simpsons_dataset.csv`, no incluido; cada ejemplo con modelo externo puede exigir una cuenta/token y depender de cambios de proveedor o API (SRC-01, SRC-03, SRC-04).
- Antes de la actividad, documentar versiones probadas y dependencias. No se publicarán claves, tokens ni credenciales.

## 7. Accesibilidad y alternativas de participación

Mantener jerarquía de encabezados, instrucciones textuales, enlaces descriptivos y explicaciones que no dependan únicamente del color o de una imagen. Acompañar gráficos con una descripción textual. Ofrecer una alternativa de lectura/análisis para quien no pueda ejecutar el notebook. La copia local de **SRC-09** incluye accesibilidad sensorial/motora, acceso en distintos dispositivos y problemas técnicos; revisar el sitio con esos criterios y documentar las limitaciones observadas. **SRC-26** pide declarar elementos de Diseño Universal para el Aprendizaje (DUA), como transcripciones, contraste y compatibilidad con lectores de pantalla: no marcar una característica como satisfecha sin comprobarla.

## 8. Orientaciones para adaptar y remezclar

- Reemplazar el corpus de ejemplo por textos pertinentes a otra disciplina y explicar los criterios de selección.
- Comparar cómo las decisiones de normalización afectan los tokens y las representaciones.
- Sustituir o ampliar herramientas del agente, especificando entradas, salidas y errores posibles.
- Cambiar el problema integrador conservando la progresión conceptual.
- Registrar los cambios realizados y atribuir las fuentes y materiales reutilizados según sus licencias.

La posibilidad legal de adaptar o redistribuir los materiales de este repositorio depende de la licencia que acuerden sus titulares; por ahora no se declara una licencia abierta.

## 9. Actividades y evaluación formativa

- Explicar una transformación del texto y justificar sus decisiones.
- Comparar dos vectores o representaciones y explicar qué permite concluir la medida usada.
- Trazar una iteración ReAct distinguiendo acción y observación.
- Diseñar una herramienta pequeña y proponer casos de prueba, incluidos errores.
- Comparar la solución manual y la solución con framework.
- Clasificar un ejemplo como herramienta, Skill, conexión MCP u orquestación; justificar los límites de cada componente.
- Auditar una herramienta del agente: permisos mínimos, datos que envía/recibe, errores, confirmación humana y pruebas negativas.
- Repetir una práctica Word2Vec registrando versión de Gensim, corpus, semilla y número de workers; explicar la variación observada (SRC-27).

Son propuestas iniciales. Para el pilotaje, registrar evidencias usando como referencia las dimensiones visibles de **SRC-09**: claridad de objetivos, calidad/vigencia, feedback, accesibilidad, reutilización, portabilidad, licenciamiento, diseño y usabilidad. **SRC-21** incluye la presentación de una plantilla completa para evaluar el REA de un compañero y reflexión personal; esta guía propone que esa evaluación cite ejemplos concretos del recurso y relacione conceptos con las fuentes. **SRC-06** agrega plazos, actividades acreditables/citación APA, condición REA y exposición final. Las rúbricas locales son referencias de cotejo, no autorizan inventar puntajes o reemplazar las decisiones de la cátedra.

### Evidencias de revisión sugeridas

| Criterio de las fuentes curriculares | Evidencia que puede reunir el equipo |
|---|---|
| Objetivos, calidad y vigencia (SRC-09) | Correspondencia objetivo–actividad–evidencia; enlaces técnicos comprobados y fecha de revisión. |
| Accesibilidad, dispositivos y portabilidad (SRC-09, SRC-26) | Revisión por teclado y móvil; alternativa sin ejecución; texto alternativo/transcripción cuando corresponda; limitaciones pendientes. |
| Reutilización y licencia (SRC-09, SRC-21, SRC-26) | Guía de adaptación, atribuciones y permiso/licencia explícitos aprobados por titulares. |
| Evaluación entre pares y reflexión (SRC-21) | Plantilla completa aplicada a otro REA con ejemplos y reflexión conectada a autores/fuentes. |
| Actividades, referencias y presentación (SRC-06) | Registro de actividades entregadas, citas APA verificadas y material para la exposición final. |

## 10. Licencias, atribución y materiales de terceros

La licencia del recurso está pendiente de acuerdo con las personas titulares. Antes de publicar la versión final, identificar autoría, procedencia y licencia de cada texto, imagen, dataset, fragmento de código y biblioteca incorporados. Ver [Licencias y atribuciones](licencias-y-atribuciones.html).

## 11. Referencias, versión y transparencia

La secuencia técnica se apoya en SRC-01, SRC-04 y SRC-03, actualizadas con documentación oficial de Gensim (SRC-27), el artículo de ReAct (SRC-28), LangChain (SRC-29), LangGraph (SRC-30), Agent Skills (SRC-31) y MCP (SRC-32 y SRC-33). Para el marco REA y la IA en educación se incorporan la Recomendación UNESCO sobre REA (SRC-34), su orientación sobre IA generativa (SRC-35) y la herramienta de selección de Creative Commons (SRC-36). El registro de consulta y los hallazgos están en [`fuentes/actualizacion-fuentes-2026.html`](fuentes/actualizacion-fuentes-2026.html); consultar las fuentes primarias antes de implementar cambios porque la documentación técnica es dinámica. El uso de IA durante la elaboración se documentará con precisión en la versión publicada.
