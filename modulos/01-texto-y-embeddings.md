---
title: Del texto a los embeddings
---

<link rel="stylesheet" href="{{ '/assets/rea.css' | relative_url }}">

# 1. Del texto a los embeddings

## Propósito

Explorar cómo se transforma un texto para que un programa pueda procesarlo y cómo distintas representaciones permiten estudiar relaciones entre palabras.

## Recorrido conceptual

1. **Preprocesamiento:** normalización, limpieza y preparación del corpus.
2. **Tokenización:** segmentación del texto en unidades que se puedan analizar.
3. **Representaciones iniciales:** Bag-of-Words como representación basada en ocurrencias.
4. **Embeddings:** representación de palabras como vectores densos.
5. **Word2Vec:** comparación entre CBOW y Skip-gram como estrategias para aprender representaciones a partir del contexto.
6. **Geometría:** exploración de distancias y similitudes entre vectores; visualización en dimensiones reducidas si lo aborda el notebook.

Esta progresión se basa en **SRC-01, `modulo-1.ipynb`**, disponible en `fuentes/`. Los ejemplos, parámetros y resultados concretos se presentan en la página HTML generada desde el notebook.

## Preguntas para orientar el aprendizaje

- ¿Qué decisiones de preprocesamiento cambian el corpus que recibe el modelo?
- ¿Qué información conserva una representación basada en frecuencias y qué relaciones no expresa directamente?
- ¿Qué significa que dos vectores sean cercanos y qué medida de distancia o similitud se está utilizando?
- ¿Por qué un embedding aprendido a partir de contextos puede ser útil para comparar palabras?

## Actividad de trabajo

Con el notebook original, modificar un pequeño corpus y observar cómo cambian la tokenización, las representaciones y las relaciones vectoriales. Documentar las decisiones tomadas y distinguir los resultados observados de las interpretaciones.

**Material interactivo:** la página generada ofrece lectura estática, descarga de la notebook y enlace a Colab. Antes de ejecutar, revisar el requisito del corpus, las versiones y las advertencias del módulo.

## Puente al módulo siguiente

Word2Vec permite estudiar representaciones aprendidas del contexto, pero el recorrido de la cátedra continúa hacia sistemas capaces de producir respuestas y utilizar herramientas externas. El siguiente módulo introduce ese cambio de problema.
