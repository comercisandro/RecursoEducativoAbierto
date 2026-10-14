# Del lenguaje a los agentes inteligentes

Primera versión pública de revisión de un Recurso Educativo Abierto (REA) para la cátedra de Inteligencia Artificial. El sitio propone una ruta progresiva desde el preprocesamiento del texto y los embeddings hasta la construcción de agentes con herramientas, con prácticas conceptuales y una actividad integradora.

**Autoría:** Ing. Comerci Sandro Mauricio.

## Ver el sitio

La portada para GitHub Pages está en [`index.md`](index.md). Las tres páginas HTML de lectura se generan en `modulos_html/` desde las notebooks originales de `fuentes/`.

La rama experimental [`feature/interfazdDUA`](../../tree/feature/interfazdDUA) incluye [`aula.html`](aula.html), una interfaz de aula tipo curso: permite elegir video, transcripción o lectura; marcar módulos completados; ajustar tamaño de texto y contraste; y seleccionar formatos alternativos de evidencia. El avance se guarda únicamente en el navegador.

Para probarla localmente en Windows, ejecuta `powershell -NoProfile -ExecutionPolicy Bypass -File tools/serve-local.ps1 -Port 8765` y abre `http://localhost:8765/aula.html`. El servidor admite rangos de bytes para los videos y tolera que el navegador cancele una descarga. No se recomienda abrirla con `file://`, porque la carga de las transcripciones utiliza `fetch`.

Para simular además la integración final de GitHub Pages sin instalar Ruby/Jekyll, ejecuta `powershell -NoProfile -ExecutionPolicy Bypass -File tools/build-local.ps1` y luego `powershell -NoProfile -ExecutionPolicy Bypass -File tools/serve-local.ps1 -Port 8769 -Root .\site-local`. Abre `http://localhost:8769/`; la salida de prueba se mantiene fuera del repositorio mediante `.gitignore`.

Para regenerarlas después de editar una notebook, ejecuta en Windows:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/render-notebooks.ps1
```

El script solo representa texto, código y salidas guardadas; **no ejecuta las notebooks**. Para publicar, en GitHub entra a **Settings → Pages**, selecciona la rama `master` y la carpeta raíz (`/`). El sitio se genera con Jekyll y el tema Minima.

## Ruta de aprendizaje

1. [Del texto a Word2Vec](modulos_html/01-word2vec.html) — tokens, preprocesamiento, Bag-of-Words y embeddings.
2. [Construir un agente ReAct](modulos_html/02-agente-react.html) — herramientas y ciclo Thought–Action–Observation.
3. [Frameworks y skills](modulos_html/03-frameworks-skills.html) — LangChain/LangGraph y capacidades compuestas.
4. [Actividad integradora y rúbrica propuesta](evaluacion-final.md).
5. [Guía de reutilización docente](guia-reutilizacion.md).
6. [Licencias, atribuciones y estado del proyecto](licencias-y-atribuciones.md).

## Estado y materiales de referencia

Las tres notebooks originales `.ipynb` y sus PDF exportados ya están en `fuentes/`. Hay copias de trabajo locales asociadas a fuentes curriculares, pero no se incorporan al repositorio mientras se cotejan procedencia, integridad y permisos. Los enlaces de Colab apuntan a los notebooks de este repositorio.

Las explicaciones audiovisuales se administran desde [`assets/videos.json`](assets/videos.json). Los módulos 1 y 2 enlazan a sus grabaciones públicas de Google Drive y el módulo 3 utiliza el MP4 local del repositorio. Las transcripciones `.txt` se conservan en `fuentes/` como material local, pero no se muestran ni se enlazan desde los módulos.

El inventario de originales, atribuciones, licencias registradas y copias curriculares locales está en [`fuentes/README.md`](fuentes/README.md). La carpeta también incluye [`fuentes/actualizacion-fuentes-2026.md`](fuentes/actualizacion-fuentes-2026.md), con fuentes primarias actuales y cambios propuestos para la ruta. Los PDFs curriculares locales todavía no se publican desde Git y requieren cotejo y autorización.

## Estado de licenciamiento

Los componentes propios autorizados se distribuyen bajo **CC BY-NC-SA 4.0**. Los materiales de terceros no quedan relicenciados por esta declaración y deben revisarse individualmente. Ver [Licencias y atribuciones](licencias-y-atribuciones.md) y [`LICENSE.md`](LICENSE.md).

## Fuentes de contexto

La secuencia se basa en las notebooks SRC-01 (Word2Vec), SRC-04 (ReAct) y SRC-03 (LangChain), disponibles en `fuentes/`, y se complementa con referencias técnicas, pedagógicas y de REA SRC-27 a SRC-39. Hay copias locales de rúbricas y guías SRC-06, SRC-09, SRC-16, SRC-17, SRC-21 y SRC-26; su versión, integridad y permisos deben cotejarse antes de usarlas como criterios definitivos o publicarlas.
