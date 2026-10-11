---
title: Agentes con frameworks y skills
---

<link rel="stylesheet" href="{{ '/assets/rea.css' | relative_url }}">

# 3. Agentes con frameworks y skills

## Propósito

Relacionar el agente construido de forma explícita con las abstracciones que ofrecen frameworks, y analizar cómo agrupar capacidades en herramientas o skills compuestas.

## Recorrido conceptual

1. Identificar qué tareas repetitivas puede abstraer un framework.
2. Revisar la definición de herramientas mediante decoradores como `@tool`.
3. Explorar la creación y ejecución de agentes con las herramientas que presente el notebook.
4. Distinguir una herramienta puntual de una skill que combina varios pasos o capacidades.
5. Comparar la implementación manual con la solución basada en framework: qué se simplifica y qué decisiones siguen a cargo del desarrollador.

El contenido se basa en **SRC-03, `Agente_LangChain.ipynb`**, disponible en `fuentes/`, que aborda LangChain, LangGraph, runtime de agentes y skills compuestas. Las versiones de bibliotecas y APIs se verificarán contra el notebook antes de publicar instrucciones de instalación.

## Preguntas para orientar el aprendizaje

- ¿Qué partes del ciclo ReAct siguen presentes aunque el framework las oculte?
- ¿Qué gana y qué pierde el usuario al delegar el control del flujo a una abstracción?
- ¿Cuándo conviene una herramienta sencilla y cuándo una capacidad compuesta?
- ¿Cómo se puede probar que un agente eligió y utilizó correctamente una herramienta?

## Actividad de trabajo

Elegir una tarea del módulo anterior y describir dos soluciones: una con el bucle manual y otra con la abstracción del notebook. Comparar legibilidad, control del flujo, facilidad de extensión y manejo de errores.

**Material interactivo:** la página generada ofrece lectura estática, descarga de la notebook y enlace a Colab. Las versiones de bibliotecas y los requisitos de servicios deben verificarse antes de ejecutar.

## Cierre de la ruta

Como actividad integradora, diseñar una tarea que requiera al menos una herramienta, especificar el flujo esperado y proponer casos de prueba. La consigna y sus criterios de evaluación se ajustarán a la plantilla original **SRC-09** y la rúbrica **SRC-21** una vez disponibles para cotejo.
