---
layout: page
title: Guía de reutilización REA
permalink: /guia-reutilizacion.html
---

<link rel="stylesheet" href="{{ '/assets/rea.css?v=20261010-6' | relative_url }}">

# Guía de reutilización REA

> **Propósito de esta guía:** establecer las orientaciones necesarias para que otros docentes puedan comprender, adaptar, remezclar y aplicar este Recurso Educativo Abierto (REA) con criterios pedagógicos, técnicos y de seguridad jurídica.

## 1. Identificación y metadatos del recurso

| Campo | Descripción / detalle |
|---|---|
| **Título del REA** | *Del lenguaje a los agentes inteligentes* |
| **Autoría y afiliación** | Ing. Comerci Sandro Mauricio. Material de la Cátedra de Inteligencia Artificial. |
| **Área disciplinar** | Inteligencia Artificial y Procesamiento del Lenguaje Natural (NLP). |
| **Destinatarios** | Estudiantes de nivel superior de carreras o espacios curriculares vinculados con Inteligencia Artificial, informática o áreas afines. Los conocimientos previos y el contexto institucional deben ser definidos por la cátedra que lo implemente. |
| **Licencia abierta** | **CC BY-NC-SA 4.0** para los componentes propios autorizados: atribución, uso no comercial y distribución de adaptaciones bajo la misma licencia. Los materiales de terceros conservan sus propias condiciones. |
| **Repositorio** | [RecursoEducativoAbierto en GitHub](https://github.com/comercisandro/RecursoEducativoAbierto). Publicación prevista mediante GitHub Pages. |
| **Versión** | Primera versión pública de revisión, octubre de 2026. |

## 8. Intencionalidad pedagógica y curricular

### Propósito de aprendizaje

El REA propone una ruta teórico-práctica para comprender cómo se procesa y representa el lenguaje, y cómo esos fundamentos se conectan con el diseño de agentes de inteligencia artificial que utilizan herramientas. La secuencia avanza desde el texto y los embeddings hasta los agentes ReAct, los frameworks y las Skills.

### Objetivos del REA

**Objetivo principal:** comprender la relación entre las representaciones del lenguaje, el uso de herramientas y la construcción de agentes de IA auditables.

**Objetivos específicos:** al finalizar la ruta, se espera que el estudiantado pueda:

1. Describir decisiones básicas de preprocesamiento y tokenización de texto.
2. Diferenciar representaciones basadas en frecuencias y embeddings aprendidos a partir de contextos.
3. Interpretar de forma básica similitudes y distancias entre vectores de palabras.
4. Explicar el ciclo ReAct e identificar la función de una herramienta y su observación.
5. Comparar una implementación manual de agente con una basada en un framework.
6. Distinguir una herramienta, una Skill, un protocolo MCP y un runtime de orquestación.
7. Diseñar una solución pequeña que use herramientas, incluya pruebas y contemple límites.
8. Registrar versiones, parámetros, datos de entrada, permisos y supuestos para favorecer la reproducibilidad.

### Sugerencia de implementación

Se recomienda utilizar el recurso como una secuencia de **inicio, desarrollo y cierre integrador**:

| Momento | Implementación sugerida | Evidencia orientativa |
|---|---|---|
| Inicio | Recuperar ideas previas sobre representación de texto y agentes. Presentar la pregunta: ¿qué gana y qué pierde un sistema al convertir texto en vectores y acciones? | Predicción inicial o mapa conceptual. |
| Desarrollo · Módulo 1 | Explorar tokens, Bag-of-Words y embeddings. Comparar la lectura web con la notebook si el entorno está disponible. | Explicación de una transformación y registro del corpus/parámetros. |
| Desarrollo · Módulo 2 | Analizar el ciclo ReAct, el parser, la acción, la observación y la terminación. Probar casos válidos y fallidos. | Traza anotada y casos de prueba. |
| Desarrollo · Módulo 3 | Comparar herramientas, Skills, MCP y orquestación. Diseñar una solución con permisos mínimos. | Diagrama de componentes y plan de pruebas. |
| Cierre integrador | Diseñar y documentar un agente pequeño, con código, pseudocódigo o diagrama. | Producto integrador, revisión entre pares y reflexión sobre límites. |

La duración, modalidad, obligatoriedad de las actividades y criterios de acreditación deben ser definidos por la cátedra según su programa vigente.

## 9. Especificaciones técnicas y requisitos de acceso

### Formatos y tecnologías

- Páginas web estáticas en HTML/Jekyll para lectura sin instalación.
- Notebooks Jupyter (`.ipynb`) y versiones exportadas en PDF.
- Videos en formato MP4 y videos enlazados desde Google Drive.
- Transcripciones de trabajo en formato TXT.
- Código de apoyo en JavaScript y scripts PowerShell para generar o servir el sitio local.
- Google Colab como alternativa opcional para ejecutar notebooks.

Para leer el recurso alcanza con un navegador web. Para ejecutar las prácticas pueden requerirse Python/Jupyter o Colab, dependencias específicas, el archivo `simpsons_dataset.csv`, conexión a internet y, en algunos ejemplos, una cuenta o token de un proveedor externo. No se deben publicar credenciales.

### Instalación y acceso

El recurso no requiere una instalación web específica para su uso básico. Puede:

1. consultarse publicado en GitHub Pages;
2. abrirse localmente mediante el servidor incluido en `tools/serve-local.ps1`;
3. generarse como sitio local completo ejecutando `tools/build-local.ps1` y luego servirse desde la carpeta `site-local/`.

Para modificar una notebook y actualizar sus páginas HTML puede ejecutarse `tools/render-notebooks.ps1`. El script representa texto, código y salidas guardadas; no ejecuta las notebooks.

### Accesibilidad y Diseño Universal para el Aprendizaje (DUA)

El recurso incorpora actualmente las siguientes alternativas y apoyos:

- lectura web sin necesidad de ejecutar código;
- notebooks, PDF y materiales audiovisuales;
- alternativa de trabajo sin cuenta, API ni ejecución mediante diagramas, pseudocódigo, trazas y datos ficticios;
- opciones de explicación escrita, oral, demostración, esquema o diagrama;
- navegación semántica, enlace para saltar al contenido, foco visible y etiquetas ARIA en la interfaz de aula;
- ajuste del tamaño del texto, modo de alto contraste, diseño adaptable a dispositivos móviles y preferencia de movimiento reducido;
- avance a ritmo propio y almacenamiento del progreso únicamente en el navegador.

El recurso se encuentra **en proceso de validación de accesibilidad**. Las transcripciones están conservadas en `fuentes/`, pero deben publicarse o enlazarse de forma visible junto a cada video para constituir una alternativa completa. También debe verificarse la presencia y calidad de subtítulos, el contraste, la navegación con teclado, la compatibilidad con lectores de pantalla y el funcionamiento en dispositivos móviles. La disponibilidad de un control no sustituye las pruebas con personas usuarias y tecnologías de asistencia.

## 10. Orientaciones para la adaptación y el remix (reutilización)

Los docentes pueden adaptar los componentes propios respetando la licencia **CC BY-NC-SA 4.0**, manteniendo la atribución, el uso no comercial y la misma licencia en las adaptaciones. Antes de redistribuir una versión, debe revisarse la licencia de cada material de terceros, imagen, dataset, biblioteca, texto o fragmento de código.

Se sugieren las siguientes adaptaciones:

- reemplazar el corpus de ejemplo por textos de otra disciplina y documentar los criterios de selección;
- comparar cómo distintas decisiones de limpieza y normalización modifican los tokens y embeddings;
- sustituir o ampliar las herramientas del agente, describiendo entradas, salidas, errores y permisos;
- adaptar los ejemplos a otro framework o protocolo sin ocultar el flujo ReAct ni los controles de seguridad;
- cambiar la tarea integradora por un problema propio de la carrera o asignatura;
- ofrecer la misma actividad en modalidad ejecutable, de baja conectividad o completamente analítica;
- incorporar las transcripciones y subtítulos al aula virtual o LMS institucional;
- registrar la versión, los cambios, las fuentes, las atribuciones y las pruebas realizadas en cada adaptación.

La adaptación debe conservar la progresión conceptual, los objetivos de aprendizaje y una vía equivalente para quienes no puedan ejecutar código o acceder a servicios externos.

## 11. Criterios sugeridos de evaluación formativa

Las siguientes pautas son orientativas. No constituyen una calificación institucional ni reemplazan la consigna, la rúbrica o las reglas de la cátedra.

### Actividades y preguntas guía

- Explicar una decisión de preprocesamiento y su posible efecto sobre los embeddings.
- Interpretar una similitud entre vectores sin extraer conclusiones que los datos no permiten.
- Trazar una iteración ReAct distinguiendo acción, herramienta, observación y respuesta final.
- Diseñar una herramienta pequeña y proponer casos normales y de error.
- Comparar la solución manual con una solución basada en framework.
- Clasificar un componente como herramienta, Skill, conexión MCP u orquestación.
- Auditar permisos, datos, errores, confirmación humana y pruebas negativas.

Cada módulo incluye una práctica conceptual de tres preguntas con retroalimentación inmediata. El resultado orientativo es de 3 puntos por módulo y 9 para la ruta completa; no se almacena en un servidor ni debe interpretarse como una nota.

### Producto integrador y rúbrica propuesta

La actividad integradora propone diseñar un agente pequeño y auditable. Puede entregarse código, pseudocódigo o diagrama acompañado de una explicación. No es obligatorio utilizar una API real: pueden emplearse trazas simuladas y datos ficticios.

La rúbrica formativa propone 100 puntos:

| Criterio | Puntos | Evidencia esperada |
|---|---:|---|
| Comprensión y distinción conceptual | 25 | Diferencia representación, herramienta, observación, Skill, protocolo y orquestación cuando corresponde. |
| Flujo, trazas y pruebas | 25 | Muestra pasos verificables, respuesta final y casos normales y de error. |
| Reproducibilidad y límites | 20 | Declara datos, versiones, supuestos, parámetros y limitaciones. |
| Seguridad y privacidad | 20 | Aplica mínimo privilegio, valida entradas y resultados y evita credenciales o datos innecesarios. |
| Comunicación y reflexión | 10 | Explica decisiones, incorpora una revisión y reconoce cambios pendientes. |

Como revisión entre pares puede utilizarse el ciclo **resolver → comparar → revisar**, comprobando si el objetivo y los límites son claros, si se distingue el modelo de la herramienta, si existen pruebas de error y terminación, si los permisos son mínimos y si hay una alternativa sin ejecución.

La cátedra debe validar los criterios, puntajes, umbrales y condiciones de acreditación antes de aplicar esta propuesta.

## Inventario de fuentes y licencias

El inventario de fuentes, atribuciones, estado de permisos y materiales de terceros está disponible en [`fuentes/README.md`](fuentes/README.html). Para conocer las condiciones de uso de los componentes propios, consultar [Licencias y atribuciones](licencias-y-atribuciones.html) y [LICENSE.md](LICENSE.md).
