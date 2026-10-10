---
title: De los modelos de lenguaje a los agentes
---

<link rel="stylesheet" href="{{ '/assets/rea.css' | relative_url }}">
<script src="{{ '/assets/header-scroll.js' | relative_url }}" defer></script>

# 2. De los modelos de lenguaje a los agentes

## Propósito

Comprender el patrón de interacción que permite conectar un modelo de lenguaje con funciones externas y examinar un agente ReAct implementado paso a paso.

## Recorrido conceptual

1. Diferenciar la generación de texto de la ejecución de una acción externa.
2. Definir una herramienta como una función disponible para el agente.
3. Presentar el ciclo **Thought → Action → Observation** y la respuesta final.
4. Analizar el formato de instrucciones, el parser de acciones y el bucle de ejecución.
5. Examinar cómo se conecta el ejemplo con un proveedor de modelos mediante una API.

El contenido se basa en **SRC-04, `Agente_ReAct.ipynb`**, disponible en `fuentes/`. Los detalles de implementación deben cotejarse con el archivo fuente antes de publicar código o instrucciones ejecutables.

## Preguntas para orientar el aprendizaje

- ¿Qué información necesita una herramienta para poder ejecutarse?
- ¿Qué diferencia hay entre una acción solicitada y la observación que devuelve la herramienta?
- ¿Qué puede fallar si la salida del modelo no respeta el formato esperado?
- ¿Qué responsabilidades corresponden al modelo y cuáles al código que controla el bucle?

## Actividad de trabajo

Seguir una iteración del agente identificando pensamiento, acción, entrada de la herramienta, observación y respuesta. Luego, proponer una herramienta sencilla adicional y describir qué entradas, salidas y errores debería contemplar.

**Material interactivo:** la página generada ofrece lectura estática, descarga de la notebook y enlace a Colab. Las credenciales o claves de API no deben incluirse en archivos públicos; el procedimiento de ejecución debe comprobarse a partir del notebook revisado.

## Puente al módulo siguiente

Una implementación manual hace visibles las partes del ciclo. El módulo siguiente estudia cómo los frameworks encapsulan parte de esa coordinación y permiten organizar agentes y herramientas con abstracciones de mayor nivel.
