# De Word2Vec a agentes de inteligencia artificial

Proyecto de Recurso Educativo Abierto (REA) en preparación para la cátedra de Inteligencia Artificial. El sitio propone una ruta progresiva desde el preprocesamiento del texto y los embeddings hasta la construcción de agentes con herramientas.

## Ver el sitio

La portada para GitHub Pages está en [`index.md`](index.md). Las tres páginas HTML de lectura se generan en `modulos_html/` desde las notebooks originales de `fuentes/`.

Para regenerarlas después de editar una notebook, ejecuta en Windows:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/render-notebooks.ps1
```

El script solo representa texto, código y salidas guardadas; **no ejecuta las notebooks**. Para publicar, en GitHub entra a **Settings → Pages**, selecciona la rama `master` y la carpeta raíz (`/`). El sitio se genera con Jekyll y el tema Minima.

## Ruta de aprendizaje

1. [Del texto a Word2Vec](modulos_html/01-word2vec.html) — tokens, preprocesamiento, Bag-of-Words y embeddings.
2. [Construir un agente ReAct](modulos_html/02-agente-react.html) — herramientas y ciclo Thought–Action–Observation.
3. [Frameworks y skills](modulos_html/03-frameworks-skills.html) — LangChain/LangGraph y capacidades compuestas.
4. [Guía de reutilización docente](guia-reutilizacion.md).
5. [Licencias, atribuciones y estado del proyecto](licencias-y-atribuciones.md).

## Materiales por incorporar

Las tres notebooks originales `.ipynb` y sus PDF exportados ya están en `fuentes/`. Los documentos institucionales de evaluación y guía docente SRC-06, SRC-09, SRC-21 y SRC-26 todavía faltan; la lista completa está en el inventario de fuentes. Los enlaces de Colab apuntan a los notebooks de este repositorio.

Se recuperaron cinco PDFs adicionales desde URLs públicas. El inventario de todos los originales disponibles, atribuciones, licencias registradas y materiales faltantes está en [`fuentes/README.md`](fuentes/README.md).

## Estado de licenciamiento

El repositorio no declara todavía una licencia abierta. La publicación visible en GitHub no basta para conceder permisos de adaptación o redistribución. La licencia debe acordarse con las personas titulares de derechos y declararse explícitamente antes de presentar el material como REA. Ver [Licencias y atribuciones](licencias-y-atribuciones.md).

## Fuentes de contexto

La secuencia se basa en las notebooks SRC-01 (Word2Vec), SRC-04 (ReAct) y SRC-03 (LangChain), disponibles en `fuentes/`. Los requisitos de evaluación se vinculan provisionalmente con SRC-21, SRC-09 y SRC-26; los originales de esas rúbricas y guía docente todavía deben incorporarse y cotejarse.
