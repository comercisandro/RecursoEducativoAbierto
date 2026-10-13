---
layout: page
title: Inventario de fuentes
permalink: /fuentes/README.html
---

# Fuentes originales recuperadas

Esta carpeta contiene las notebooks de la cátedra y copias de documentos descargables de las fuentes de referencia del proyecto. Se mantienen los identificadores SRC para relacionar cada material con la matriz bibliográfica de trabajo. Cada obra conserva su autoría y licencia propia; la inclusión aquí no relicencia esos documentos bajo la licencia del proyecto.

## Archivos disponibles localmente

| ID | Archivo local | Fuente original | Licencia indicada por el repositorio |
|---|---|---|---|
| SRC-01 | `modulo-1.ipynb` y `modulo-1 - Colab.pdf` | Original local aportado al proyecto | Componente propio autorizado: CC BY-NC-SA 4.0; revisar terceros |
| SRC-03 | `modulo-3.ipynb` y `modulo-3 - Colab.pdf` | Original local aportado al proyecto | Componente propio autorizado: CC BY-NC-SA 4.0; revisar terceros |
| SRC-04 | `modulo-2.ipynb` y `modulo-2 - Colab.pdf` | Original local aportado al proyecto | Componente propio autorizado: CC BY-NC-SA 4.0; revisar terceros |
| Video-01 | `modulo-1-explicacion.mp4` | Grabación audiovisual enlazada desde Google Drive; registro en [`assets/videos.json`](../assets/videos.json) | Verificar autoría, permiso de redistribución y subtítulos antes de publicar una copia |
| Video-02 | `modulo-2-explicacion.mp4` | Grabación audiovisual enlazada desde Google Drive; registro en [`assets/videos.json`](../assets/videos.json) | Verificar autoría, permiso de redistribución y subtítulos antes de publicar una copia |
| Video-03 | `modulo-3-explicacion.mp4` | Grabación audiovisual local incorporada al repositorio; registro en [`assets/videos.json`](../assets/videos.json) | Verificar autoría, permiso de redistribución y subtítulos |
| SRC-07 | `SRC-07-villarreal-curso-repositorios-aspectos-tecnologicos.pdf` | [SEDICI: Curso de Repositorios Digitales - Aspectos tecnológicos](https://sedici.unlp.edu.ar/handle/10915/57192) | CC BY-SA 4.0 |
| SRC-08 | `SRC-08-diaz-davila-aprendizaje-matematica-ingenieria.pdf` | [SEDICI: La pandemia. Acciones para facilitar el aprendizaje en Matemática durante el ingreso a carreras de Ingeniería](https://sedici.unlp.edu.ar/handle/10915/103682) | CC BY-NC-SA 4.0 |
| SRC-12 | `SRC-12-educar-ia-y-educacion-encuesta-2025.pdf` | [Educ.ar: IA y educación. Usos y representaciones de la comunidad educativa](https://www.educ.ar/recursos/159144/ia-y-educacion-informe-encuesta) | CC BY-NC-SA (según ficha de Educ.ar) |
| SRC-13 | `SRC-13-bongiovani-repositorios-acceso-abierto.pdf` | [SEDICI: Introducción a los repositorios de acceso abierto en Argentina](https://sedici.unlp.edu.ar/handle/10915/26792) | CC BY-NC-ND 2.5 Argentina |
| SRC-18 | `SRC-18-educar-recursos-educativos-abiertos.pdf` | [Educ.ar: Recursos educativos abiertos. Conceptos, herramientas y procesos](https://www.educ.ar/recursos/157196/recursos-educativos-abiertos-conceptos-herramientas-procesos) | CC BY-NC-SA (según ficha de Educ.ar) |

## Referencias técnicas y pedagógicas actuales

Consultadas el **10 de octubre de 2026**. Son referencias web oficiales o publicaciones académicas; se enlazan al original porque su contenido y versiones pueden cambiar. El resumen de hallazgos y su aplicación al recurso está en [`actualizacion-fuentes-2026.html`](actualizacion-fuentes-2026.html).

| ID | Tema | Fuente primaria | Uso en el proyecto |
|---|---|---|---|
| SRC-27 | API vigente de Word2Vec | [Gensim 4.3.3 — Word2Vec](https://radimrehurek.com/gensim/models/word2vec.html) | API `vector_size`, `model.wv` y `init_sims()` obsoleto; reproducibilidad con `workers=1`. |
| SRC-28 | Fundamento de ReAct | [Yao et al. (2023), arXiv:2210.03629](https://arxiv.org/abs/2210.03629) | Fuente académica primaria para razonamiento y acciones intercalados. |
| SRC-29 | Agentes LangChain | [Documentación oficial — Agents](https://docs.langchain.com/oss/python/langchain/agents) | Define el agente como modelo en bucle con herramientas e instrucciones/middleware; `create_agent` es la API documentada. |
| SRC-30 | Orquestación LangGraph | [Documentación oficial — Overview](https://docs.langchain.com/oss/python/langgraph/overview) | Distingue la orquestación de bajo nivel: estado, persistencia, ejecución durable y supervisión humana. |
| SRC-31 | Skills | [Anthropic — Agent Skills overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) | Ejemplo específico de Skills filesystem-based con instrucciones y recursos cargados progresivamente; no implica que todas las plataformas compartan formato/compatibilidad. |
| SRC-32 | Interoperabilidad de herramientas | [Model Context Protocol — Introduction](https://modelcontextprotocol.io/docs/getting-started/intro) | Presenta MCP como estándar abierto para conectar aplicaciones con datos, herramientas y workflows. |
| SRC-33 | Seguridad de MCP | [MCP — Security Best Practices](https://modelcontextprotocol.io/docs/2026-07-28/tutorials/security/security_best_practices) | Riesgos y controles sobre consentimiento, autorización, SSRF, servidores locales y mínimo privilegio. |
| SRC-34 | Marco internacional REA | [UNESCO — Recommendation on Open Educational Resources](https://www.unesco.org/en/legal-affairs/recommendation-open-educational-resources-oer) | Referencia de política pública para creación, acceso, adaptación y cooperación en REA. |
| SRC-35 | IA generativa en educación | [UNESCO — Guidance for generative AI in education and research](https://www.unesco.org/en/articles/guidance-generative-ai-education-and-research) | Orientación centrada en las personas; página consultada indica actualización del 16 de enero de 2026. |
| SRC-36 | Selección de licencias | [Creative Commons — License Chooser](https://creativecommons.org/chooser/) | Ayuda a comparar atribución, uso comercial, adaptaciones y compartir igual; la elección requiere titularidad/autorización. |
| SRC-37 | Guía REA para profesorado | [REBIUN — Guía rápida para profesores](https://www.rebiun.org/kit-rea/guia-rapida-para-profesores) | Ciclo de búsqueda, creación, adopción/adaptación, uso y difusión con metadatos y licencia. |
| SRC-38 | Diseño de secuencia didáctica REA | [INTEF — Pasos para crear un REA](https://formacion.intef.es/aulaenabierto/mod/book/tool/print/index.php?id=4158) | Planificación desde contexto, objetivos, actividades, evaluación, accesibilidad y distribución. |
| SRC-39 | Accesibilidad en REA | [CAST AEM Center — Protocol for Creating Accessible OER](https://aem.cast.org/binaries/content/assets/common/publications/aem/protocol-creating-accessible-oer-a11y.pdf) | Prácticas de estructura, enlaces, texto alternativo, diseño visual y revisión; no equivale a auditoría de conformidad. |

Los metadatos de licencias se registran tal como aparecen en las fichas/repositorios consultados; verificar la ficha original antes de redistribuir o modificar cada documento. Una consulta web no concede permiso para copiar o relicenciar su contenido.

## Fuentes curriculares locales pendientes de publicar/cotejar

### Evaluación y guía docente

- **SRC-06 — Copia de Rúbrica Final RDI-2026**: copia local `Copia de Rúbrica Final RDI-2026 - punto 4.pdf`.
- **SRC-09 — `Evaluacion_REA_Plantilla`**: copia local `Evaluacion_REA_Plantilla - punto 4.pdf`.
- **SRC-16 — `RDI_Hoja de Ruta 3 Repositorio`**: copia local `RDI_Hoja de Ruta 3 Repositorio.pdf`.
- **SRC-17 — `RDI_Hoja de Ruta TF`**: copia local `RDI_Hoja de Ruta TF punto 4.pdf`.
- **SRC-21 — Rúbrica REA-2026**: copia local `Rúbrica REA-2026 - punto 4.pdf`.
- **SRC-26 — `guia_reutilizacion_docente.docx`**: copia PDF local `guia_reutilizacion_docente.docx punto 4.pdf`; el original editable no está disponible.

Estas copias aparecieron en la carpeta de trabajo local y todavía no están incorporadas al repositorio publicado. Antes de distribuirlas, verificar versión, procedencia, integridad y permisos con la cátedra. No se reconstruyeron como si fueran originales.

## Otras fuentes del índice

Estas fuentes se mantienen como enlaces a sus sitios originales en lugar de descargar copias locales: SRC-02, SRC-05, SRC-10, SRC-11, SRC-14, SRC-15, SRC-19, SRC-20, SRC-22, SRC-23, SRC-24 y SRC-25. La memoria incluye enlaces para ellas.

- **SRC-16** y **SRC-17** figuran como archivos curriculares; hay copias PDF locales (ver arriba), pendientes de cotejo y autorización para distribución.
