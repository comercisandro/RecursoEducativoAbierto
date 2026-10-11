---
layout: page
title: Guía de reutilización docente
permalink: /guia-reutilizacion.html
---

<link rel="stylesheet" href="{{ '/assets/rea.css?v=20261010-6' | relative_url }}">

# Guía de reutilización docente

> **Primera versión pública de revisión.** Hay copias locales de **SRC-06, SRC-09, SRC-21 y SRC-26**, ya cotejadas para esta revisión, pero todavía no están versionadas. El PDF disponible de SRC-26 muestra las secciones 1 y 8–11; falta contrastar la guía con el original completo. Las propuestas de abajo no reemplazan las rúbricas ni equivalen a una evaluación institucional.

## 1. Identificación del recurso

- **Título:** Del lenguaje a los agentes inteligentes.
- **Autoría y afiliación:** Ing. Comerci Sandro Mauricio, Dra. Laura Diaz Davila
- **Área:** Inteligencia Artificial y Procesamiento del Lenguaje Natural.
- **Versión:** primera versión pública de revisión, 2026-10-10.
- **Repositorio:** [RecursoEducativoAbierto en GitHub](https://github.com/comercisandro/RecursoEducativoAbierto); publicación web en GitHub Pages.

## 2. Destinatarios y contexto

Propuesta dirigida a estudiantes de nivel superior vinculados con Inteligencia Artificial o áreas afines. El nivel, carrera, espacio curricular y perfil de ingreso deben precisarse con la cátedra.

Antes de implementarla, completar con el equipo docente: asignatura/carrera, conocimientos previos, modalidad, cantidad de encuentros, tamaño del grupo, dispositivos disponibles y conectividad. La planificación se presenta como adaptable y no presupone una duración institucional.

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

### Secuencia orientativa

| Momento | Propuesta de trabajo | Evidencia observable |
|---|---|---|
| Apertura | Recuperar ideas previas sobre cómo representar texto y qué puede hacer un agente. Presentar una pregunta guía: ¿qué información gana y qué pierde un sistema al convertir texto en vectores y acciones? | Predicción inicial o mapa de conceptos. |
| Módulo 1 | Explorar tokens, Bag-of-Words y embeddings; contrastar una lectura conceptual con la notebook si el entorno está disponible. | Explicación de una transformación y registro de corpus/parámetros. |
| Módulo 2 | Seguir un ciclo ReAct e inspeccionar parser, acción, observación y terminación. Probar ejemplos válidos y fallidos. | Traza anotada y casos de prueba. |
| Módulo 3 | Comparar herramientas, Skills, MCP y orquestación; diseñar una solución acotada que aplique mínimo privilegio. | Diagrama de componentes y plan de pruebas. |
| Cierre | Integrar la ruta en una explicación, prototipo en papel o demostración revisada por pares. | Producto integrador y reflexión sobre límites y reproducibilidad. |

La secuencia retoma como orientación el diseño desde contexto, objetivos, tareas y evaluación de SRC-38 y el ciclo de adopción/adaptación de SRC-37. No es una plantilla institucional ni sustituye la planificación de la asignatura.

## 6. Requisitos técnicos y formatos

- Navegador web para leer las páginas estáticas; no requieren ejecutar código ni instalar software (SRC-09, portabilidad).
- Notebook Jupyter `.ipynb` para las prácticas; Google Colab es opcional y requiere acceso a internet. Las páginas HTML y PDF permiten una alternativa de lectura/análisis sin ejecutar celdas.
- La práctica Word2Vec necesita el CSV `simpsons_dataset.csv`, no incluido; cada ejemplo con modelo externo puede exigir una cuenta/token y depender de cambios de proveedor o API (SRC-01, SRC-03, SRC-04).
- Antes de la actividad, documentar versiones probadas y dependencias. No se publicarán claves, tokens ni credenciales.

### Alternativas de implementación

- **Con ejecución:** preparar Python/Jupyter o Colab y probar previamente dependencias, datos y servicios. Para actividades con modelos/API, explicitar costos, límites, manejo de datos y alternativas sin cuenta.
- **Solo lectura o baja conectividad:** trabajar con las páginas HTML, capturas/código ya visibles y trazas impresas o descargadas; entregar análisis y casos de prueba sin ejecutar celdas.
- **Trabajo colaborativo:** distribuir roles (lectura del flujo, pruebas, documentación y revisión de riesgos) y permitir una entrega individual equivalente si las condiciones de acceso lo requieren.

## 7. Accesibilidad y alternativas de participación

Mantener jerarquía de encabezados, instrucciones textuales, enlaces descriptivos y explicaciones que no dependan únicamente del color o de una imagen. Acompañar gráficos con una descripción textual. Ofrecer una alternativa de lectura/análisis para quien no pueda ejecutar el notebook. La copia local de **SRC-09** incluye accesibilidad sensorial/motora, acceso en distintos dispositivos y problemas técnicos; revisar el sitio con esos criterios y documentar las limitaciones observadas. **SRC-26** pide declarar elementos de Diseño Universal para el Aprendizaje (DUA), como transcripciones, contraste y compatibilidad con lectores de pantalla: no marcar una característica como satisfecha sin comprobarla.

Como comprobación práctica inspirada en SRC-39, revisar: orden de encabezados; navegación por teclado; propósito comprensible de cada enlace; texto alternativo útil para imágenes informativas y descripción extensa cuando el gráfico sea complejo; contraste y legibilidad en móvil; y disponibilidad de alternativa textual para medios. Una revisión automatizada puede ayudar, pero no demuestra por sí sola conformidad ni sustituye pruebas con tecnologías de asistencia y personas usuarias.

## 8. Orientaciones para adaptar y remezclar

- Reemplazar el corpus de ejemplo por textos pertinentes a otra disciplina y explicar los criterios de selección.
- Comparar cómo las decisiones de normalización afectan los tokens y las representaciones.
- Sustituir o ampliar herramientas del agente, especificando entradas, salidas y errores posibles.
- Cambiar el problema integrador conservando la progresión conceptual.
- Registrar los cambios realizados y atribuir las fuentes y materiales reutilizados según sus licencias.

Los componentes propios autorizados pueden adaptarse y redistribuirse bajo **CC BY-NC-SA 4.0**, respetando atribución, uso no comercial y compartir igual. Esta licencia no se extiende automáticamente a materiales de terceros; revisar el inventario y las condiciones de cada componente antes de reutilizarlo.

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

### Lista breve para preparar una implementación

- [ ] Validar destinatarios, objetivos y contenidos con el programa vigente.
- [ ] Elegir módulos y tiempos; indicar qué actividades son obligatorias o ampliatorias.
- [ ] Comprobar equipos, conectividad, dependencias, datasets y servicios externos antes de clase.
- [ ] Preparar una vía equivalente sin ejecución y opciones para diferentes dispositivos.
- [ ] Alinear cada actividad con una evidencia y dar criterios/retroalimentación comprensibles.
- [ ] Revisar accesibilidad, datos personales, credenciales, atribuciones y permisos antes de compartir materiales.
- [ ] Registrar versión, adaptaciones realizadas y problemas observados durante el pilotaje.

Esta lista sintetiza criterios de planificación de SRC-38, adopción/adaptación y metadatos de SRC-37, y revisión de accesibilidad de SRC-39; es una ayuda de trabajo, no una certificación de calidad.

### Evidencias de revisión sugeridas

| Criterio de las fuentes curriculares | Evidencia que puede reunir el equipo |
|---|---|
| Objetivos, calidad y vigencia (SRC-09) | Correspondencia objetivo–actividad–evidencia; enlaces técnicos comprobados y fecha de revisión. |
| Accesibilidad, dispositivos y portabilidad (SRC-09, SRC-26) | Revisión por teclado y móvil; alternativa sin ejecución; texto alternativo/transcripción cuando corresponda; limitaciones pendientes. |
| Reutilización y licencia (SRC-09, SRC-21, SRC-26) | Guía de adaptación, atribuciones y permiso/licencia explícitos aprobados por titulares. |
| Evaluación entre pares y reflexión (SRC-21) | Plantilla completa aplicada a otro REA con ejemplos y reflexión conectada a autores/fuentes. |
| Actividades, referencias y presentación (SRC-06) | Registro de actividades entregadas, citas APA verificadas y material para la exposición final. |

### Autocomprobaciones y producto integrador

Cada módulo incluye tres preguntas conceptuales con retroalimentación inmediata. El resultado se muestra como **práctica sobre 3 por módulo y sobre 9 en la ruta completa**; puede repetirse y no se almacena ni se envía a un servidor. El puntaje no es una nota: sirve para decidir qué concepto revisar y qué evidencia conviene discutir.

La [actividad integradora](evaluacion-final.html) propone diseñar un agente pequeño y auditable en código, pseudocódigo o diagrama. Incluye una rúbrica formativa de **100 puntos**: comprensión conceptual (25), flujo y pruebas (25), reproducibilidad y límites (20), seguridad y privacidad (20), y comunicación y reflexión (10). La cátedra debe validar los criterios, los puntajes y cualquier condición de acreditación antes de aplicarlos.

La interacción entre pares sigue el ciclo **resolver → comparar → revisar**. Cada estudiante debe poder entregar una alternativa equivalente sin ejecución, cuenta o clave de API. La actividad no modifica las reglas de SRC-16: confirmar siempre la consigna vigente antes de usar herramientas de IA en una tarea acreditable.

## 10. Licencias, atribución y materiales de terceros

La licencia de los componentes propios autorizados está declarada en [LICENSE.md](LICENSE.md). Antes de adaptar o redistribuir la versión, identificar autoría, procedencia y licencia de cada texto, imagen, dataset, fragmento de código y biblioteca incorporados. Ver [Licencias y atribuciones](licencias-y-atribuciones.html).

## 11. Referencias, versión y transparencia

La secuencia técnica se apoya en SRC-01, SRC-04 y SRC-03, actualizadas con documentación oficial de Gensim (SRC-27), el artículo de ReAct (SRC-28), LangChain (SRC-29), LangGraph (SRC-30), Agent Skills (SRC-31) y MCP (SRC-32 y SRC-33). Para el marco REA y la IA en educación se incorporan la Recomendación UNESCO sobre REA (SRC-34), su orientación sobre IA generativa (SRC-35) y la herramienta de selección de Creative Commons (SRC-36). El registro de consulta y los hallazgos están en [`fuentes/actualizacion-fuentes-2026.html`](fuentes/actualizacion-fuentes-2026.html); consultar las fuentes primarias antes de implementar cambios porque la documentación técnica es dinámica. El uso de IA durante la elaboración se documentará con precisión en la versión publicada.

## Inventario de fuentes

Consulta el [inventario de fuentes SRC](fuentes/README.html) para identificar la procedencia, licencia y estado de cada material utilizado en esta guía. Los códigos `SRC-01`, `SRC-03`, etc. funcionan como referencias breves para localizar allí la fuente completa.
