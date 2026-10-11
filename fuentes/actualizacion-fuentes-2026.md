---
layout: page
title: Actualización de fuentes 2026
permalink: /fuentes/actualizacion-fuentes-2026.html
---

<link rel="stylesheet" href="{{ '/assets/rea.css?v=20261010-6' | relative_url }}">
<script src="{{ '/assets/header-scroll.js' | relative_url }}" defer></script>

# Actualización de fuentes y hallazgos — 10 de octubre de 2026

Este registro conserva hallazgos consultados en fuentes primarias. Las páginas de documentación son dinámicas: comprobar la versión vigente antes de ejecutar prácticas. Los IDs SRC-27 a SRC-36 se asignan en el inventario del proyecto.

## Word2Vec y reproducibilidad — SRC-27

La documentación consultada identifica Gensim 4.3.3 y documenta `vector_size` en el constructor de `Word2Vec`; los vectores aprendidos se consultan mediante `model.wv`. `init_sims()` figura como obsoleto; para consultar un vector normalizado la API documenta `get_vector(key, norm=True)`. Para reducir la variabilidad del entrenamiento, la documentación advierte que también debe usarse un solo worker (`workers=1`) y fijar `PYTHONHASHSEED`; esto mejora repetibilidad, pero no debe presentarse como garantía de resultados idénticos entre cualquier plataforma.

**Aplicación:** conservar la advertencia en el módulo 1 y añadir como objetivo de práctica registrar versión de Gensim, parámetros, semilla, cantidad de workers y corpus. La notebook fuente sigue sin repararse automáticamente: el dataset no está incorporado y el código señalado necesita validación.

Fuente: [Gensim 4.3.3 — Word2Vec](https://radimrehurek.com/gensim/models/word2vec.html), API oficial consultada el 10-10-2026.

## ReAct y construcción de agentes — SRC-28, SRC-29 y SRC-30

El artículo de Yao et al. describe ReAct como generación intercalada de trazas de razonamiento y acciones, para actualizar planes y obtener información del entorno (SRC-28). Es la base conceptual; no garantiza por sí sola que una implementación concreta sea correcta.

La documentación actual de LangChain describe el agente como un modelo que llama herramientas en un bucle, bajo un arnés de instrucciones, herramientas y middleware; documenta `create_agent` como punto de entrada configurable (SRC-29). LangGraph se presenta como runtime de orquestación de bajo nivel para flujos con estado y larga duración, con persistencia, ejecución durable y supervisión humana (SRC-30). Por eso conviene enseñar la diferencia entre una abstracción de agente y la orquestación explícita, en vez de presentar ambos nombres como sinónimos.

**Aplicación:** la práctica ReAct mantiene el análisis del parser y el formato terminal de la notebook SRC-04. Antes de conectarla a servicios reales, pedir pruebas del parser (acción válida, entrada vacía, herramienta desconocida, respuesta final y límite de iteraciones). En el módulo 3, comparar tres decisiones: bucle directo para una demo, `create_agent` para un loop común y LangGraph cuando se requieran control explícito de estado, persistencia o intervención humana.

Fuente académica: Yao, S., Zhao, J., Yu, D., Du, N., Shafran, I., Narasimhan, K., y Cao, Y. (2023). *ReAct: Synergizing Reasoning and Acting in Language Models*. ICLR 2023. [arXiv:2210.03629](https://arxiv.org/abs/2210.03629). Documentación: [LangChain Agents](https://docs.langchain.com/oss/python/langchain/agents) y [LangGraph overview](https://docs.langchain.com/oss/python/langgraph/overview), consultadas el 10-10-2026.

## Skills e interoperabilidad MCP — SRC-31, SRC-32 y SRC-33

La documentación de Anthropic define Agent Skills como recursos filesystem-based que reúnen metadatos, instrucciones y materiales opcionales, cargados progresivamente cuando hacen falta (SRC-31). Su implementación descrita corresponde a productos de Anthropic; no debe confundirse con una especificación universal ni asumirse interoperabilidad automática.

MCP se define como un estándar abierto para conectar aplicaciones de IA con sistemas externos mediante fuentes de datos, herramientas y workflows (SRC-32). MCP resuelve una capa de interoperabilidad; no determina cómo razona el modelo ni reemplaza la lógica/orquestación del agente. La guía de seguridad de MCP enumera riesgos como consentimiento insuficiente, SSRF, uso de credenciales, servidores locales no confiables y permisos excesivos (SRC-33).

**Aplicación:** añadir una comparación conceptual al módulo 3: *tool* = operación invocable; *Skill* = paquete de instrucciones/recursos de una implementación; *MCP* = protocolo de intercambio entre host, cliente y servidor; *framework/runtime* = abstracción u orquestación del flujo. Actividad propuesta: modelar un servidor de consulta de solo lectura, especificar entradas/salidas, mínimo privilegio, confirmación humana para acciones con efectos y pruebas de entradas maliciosas; no instalar un servidor MCP como requisito del itinerario.

Fuentes: [Anthropic Agent Skills](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview), [MCP Introduction](https://modelcontextprotocol.io/docs/getting-started/intro) y [MCP Security Best Practices](https://modelcontextprotocol.io/docs/2026-07-28/tutorials/security/security_best_practices), consultadas el 10-10-2026.

## REA, licencias e IA en educación — SRC-34, SRC-35 y SRC-36

La Recomendación UNESCO sobre REA sirve como marco internacional para políticas y prácticas de recursos abiertos (SRC-34). La guía UNESCO sobre IA generativa mantiene un enfoque centrado en las personas y la página institucional indica actualización el 16-01-2026 (SRC-35). Son marcos de orientación y no sustituyen normas locales ni los acuerdos de derechos de autor de este recurso.

El selector de Creative Commons permite comparar atribución, usos comerciales, adaptaciones y compartir igual; indica que la persona que aplica una licencia debe tener derechos o autoridad para hacerlo y que la licencia aplicada no es revocable (SRC-36). El proyecto conserva su estado de licencia pendiente: la nueva fuente informa opciones, pero no autoriza escoger una por el equipo titular.

**Aplicación:** agregar a la guía una revisión de privacidad, pertinencia pedagógica, transparencia sobre el uso de IA y supervisión docente. En la página de licencias, enlazar al selector como ayuda informativa, manteniendo pendiente la decisión formal.

Fuentes: [Recomendación UNESCO sobre REA](https://www.unesco.org/en/legal-affairs/recommendation-open-educational-resources-oer), [Guidance for generative AI in education and research](https://www.unesco.org/en/articles/guidance-generative-ai-education-and-research) y [Creative Commons License Chooser](https://creativecommons.org/chooser/), consultadas el 10-10-2026.

## Diseño de REA, guía docente y accesibilidad — SRC-37, SRC-38 y SRC-39

La guía rápida de REBIUN propone un ciclo para buscar, crear, adoptar o adaptar, usar y compartir REA, e incluye la importancia de los metadatos y de seleccionar una licencia apropiada (SRC-37). El material de planificación del INTEF sugiere partir de contexto, objetivos y necesidades del grupo, articular tareas con evaluación y considerar desde el diseño recursos, accesibilidad y distribución (SRC-38). CAST organiza prácticas de accesibilidad en estructura, enlaces, descripción de imágenes, tipografía/color y evaluación (SRC-39); advierte que una lista o comprobación automatizada no reemplaza una auditoría completa ni la evaluación con personas usuarias.

**Aplicación:** se añadió a la guía una secuencia orientativa con evidencias, modalidades con y sin ejecución de notebooks, una lista de preparación docente y una revisión básica de accesibilidad. Son adaptaciones de criterios generales a este borrador; no se copió una plantilla ni se afirma que el recurso haya superado una auditoría.

Fuentes consultadas el 10-10-2026: [REBIUN — Guía rápida para profesores](https://www.rebiun.org/kit-rea/guia-rapida-para-profesores), [INTEF — Pasos para crear un REA](https://formacion.intef.es/aulaenabierto/mod/book/tool/print/index.php?id=4158) y [CAST AEM Center — Protocol for Creating Accessible OER](https://aem.cast.org/binaries/content/assets/common/publications/aem/protocol-creating-accessible-oer-a11y.pdf).

## Cotejo de fuentes curriculares en copia local

En la carpeta de trabajo también existen PDFs con nombres correspondientes a SRC-06, SRC-09, SRC-16, SRC-17, SRC-21 y SRC-26. Se leyeron las copias disponibles, que no forman parte de este registro de fuentes web ni se incorporaron automáticamente a Git:

- **SRC-06 — Rúbrica RD I:** evalúa cumplimiento de plazos, actividades acreditables y citas APA, cumplimiento de pautas REA y exposición final; distingue niveles Notable (8–10), Suficiente (6–7,9) y En desarrollo (4–5,9). Se debe aplicar respetando la consigna y la evaluación institucional.
- **SRC-09 — Evaluación de REA:** propone escala de 1 a 5 y dimensiones de objetivos, calidad/vigencia del contenido, motivación y feedback, accesibilidad, reusabilidad, portabilidad, licenciamiento, diseño y usabilidad.
- **SRC-16 — Hoja de Ruta 3 Repositorio:** orienta sobre repositorios y evaluación de recursos; para la actividad cooperativa acreditable del punto 3 indica expresamente que no corresponde el uso de herramientas de IA. Esa condición se conserva para esa actividad concreta.
- **SRC-21 — Rúbrica REA:** valora originalidad/creatividad, condición REA, guía de reutilización, presentación de la plantilla para evaluar a un compañero y reflexión personal vinculada con autores.
- **SRC-26 — Guía de reutilización REA:** la copia disponible presenta identificación/metadatos (incluye destinatarios y licencia), intencionalidad pedagógica, requisitos técnicos/acceso y DUA, adaptación/remix y evaluación formativa. El PDF local muestra las secciones 1 y 8–11; falta cotejarlo con el original completo. Por ello, la guía de este proyecto sigue en borrador.

Estas observaciones se usan para convertir criterios visibles en tareas de revisión y evidencias concretas; no sustituyen las rúbricas institucionales ni asignan notas. Verificar versiones, integridad, autoría y autorización antes de citarlas como versión definitiva o publicarlas.
