---
layout: home
title: De Word2Vec a agentes de inteligencia artificial
---

Una ruta teórico-práctica para comprender cómo pasamos de procesar y representar palabras como vectores a construir sistemas que usan herramientas para resolver tareas.

> **Estado:** versión HTML inicial en preparación. Las tres notebooks originales ya se pueden leer en la web; faltan por incorporar y cotejar los documentos institucionales de evaluación y completar la autorización de licencias.

## ¿Qué vas a recorrer?

La secuencia comienza con el texto: cómo se limpia y tokeniza, cómo se representa y qué relaciones se pueden estudiar en un espacio vectorial. Después plantea el salto desde esas representaciones y los modelos de lenguaje hacia los agentes: sistemas que pueden invocar herramientas, observar sus resultados y continuar una tarea.

1. **[Módulo 1 · Del texto a Word2Vec](modulos_html/01-word2vec.html)** — preprocesamiento, tokens, Bag-of-Words, embeddings, Word2Vec y distancias. [Abrir notebook en Colab](https://colab.research.google.com/github/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/2025_word2vec.ipynb).
2. **[Módulo 2 · Construir un agente ReAct](modulos_html/02-agente-react.html)** — herramientas, parser de acciones y ciclo Thought–Action–Observation. [Abrir notebook en Colab](https://colab.research.google.com/github/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/Agente_ReAct.ipynb).
3. **[Módulo 3 · Frameworks y skills](modulos_html/03-frameworks-skills.html)** — herramientas y agentes con LangChain/LangGraph y skills compuestas. [Abrir notebook en Colab](https://colab.research.google.com/github/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/Agente_LangChain.ipynb).

Las páginas se generaron desde las notebooks originales: el texto, el código y las salidas guardadas se pueden consultar desde la web sin ejecutar Colab. Los cuadernos originales están disponibles para descargar o abrir en Colab si se desea experimentar.

## Ficha del recurso

| Campo | Información de trabajo |
|---|---|
| Título | De Word2Vec a agentes de inteligencia artificial |
| Área | Inteligencia Artificial y Procesamiento del Lenguaje Natural |
| Destinatarios | Estudiantes de nivel superior; perfil y conocimientos previos por confirmar con la cátedra |
| Formato | Páginas HTML estáticas y notebooks Jupyter (`.ipynb`) |
| Autoría y afiliación | Pendiente de confirmar con el equipo de cátedra |
| Licencia | Pendiente de autorización y declaración explícita; ver [licencias](licencias-y-atribuciones.html) |

## Guía para docentes

La [guía de reutilización docente](guia-reutilizacion.html) reúne el propósito, los objetivos de trabajo, los requisitos técnicos y propuestas iniciales de adaptación y evaluación. Se completará y cotejará con la plantilla original **SRC-26** cuando esté disponible.

## Fuentes y evaluación

La ruta se apoya en las notebooks fuente **SRC-01** (Word2Vec), **SRC-04** (agente ReAct) y **SRC-03** (LangChain), ya incluidas en `fuentes/`. La evaluación debe cotejarse con **SRC-06**, **SRC-09**, **SRC-21** y **SRC-26**, cuyos originales aún no están disponibles. Consulta el [inventario de fuentes en GitHub](https://github.com/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/README.md).

## Uso transparente de IA

Este proyecto y el renderizado de las notebooks se realizaron con asistencia de IA generativa. El equipo autor debe revisar, corregir y aprobar las explicaciones, actividades, código, citas y declaraciones antes de publicar la versión final. La declaración definitiva deberá describir los usos reales realizados durante la producción.
