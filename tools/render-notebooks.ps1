param(
    [string]$Repository = 'comercisandro/RecursoEducativoAbierto',
    [string]$Branch = 'master'
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$notebooksDir = Join-Path $root 'fuentes'
$outputDir = Join-Path $root 'modulos_html'
$utf8 = [System.Text.UTF8Encoding]::new($false)

if (-not (Test-Path $notebooksDir)) {
    throw "No se encuentra la carpeta fuentes/: $notebooksDir"
}
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

function Get-CellSource($Cell) {
    if ($null -eq $Cell.source) { return '' }
    if ($Cell.source -is [string]) { return $Cell.source }
    return ($Cell.source -join '')
}

function Convert-InlineMarkdown([string]$Text) {
    $raw = [System.Collections.Generic.List[string]]::new()
    $value = [regex]::Replace($Text, '!\[([^\]]*)\]\(([^)]+)\)', {
        param($m)
        $alt = [System.Net.WebUtility]::HtmlEncode($m.Groups[1].Value)
        $src = $m.Groups[2].Value.Trim()
        if ($src -match '^(https://|http://|data:image/(png|jpeg|gif|webp);base64,)') {
            $safeSrc = [System.Net.WebUtility]::HtmlEncode($src)
            $html = "<figure class=`"notebook-image`"><img loading=`"lazy`" alt=`"$alt`" src=`"$safeSrc`"></figure>"
        } else {
            $html = "<span class=`"image-omitted`">[Imagen omitida: $alt]</span>"
        }
        $raw.Add($html)
        return "@@RAW$($raw.Count - 1)@@"
    })
    $value = [regex]::Replace($value, '\[([^\]]+)\]\((https?://[^)]+|#[^)]+)\)', {
        param($m)
        $label = [System.Net.WebUtility]::HtmlEncode($m.Groups[1].Value)
        $href = [System.Net.WebUtility]::HtmlEncode($m.Groups[2].Value)
        $html = "<a href=`"$href`" rel=`"noopener noreferrer`">$label</a>"
        $raw.Add($html)
        return "@@RAW$($raw.Count - 1)@@"
    })

    $codes = [System.Collections.Generic.List[string]]::new()
    $value = [regex]::Replace($value, '`([^`]+)`', {
        param($m)
        $codes.Add("<code>$([System.Net.WebUtility]::HtmlEncode($m.Groups[1].Value))</code>")
        return "@@CODE$($codes.Count - 1)@@"
    })
    $value = [System.Net.WebUtility]::HtmlEncode($value)
    $value = [regex]::Replace($value, '\*\*(.+?)\*\*', '<strong>$1</strong>')
    $value = [regex]::Replace($value, '(?<!\*)\*([^*]+)\*(?!\*)', '<em>$1</em>')
    $value = [regex]::Replace($value, '\$([^$]+)\$', '<span class="math-inline">$1</span>')
    for ($i = 0; $i -lt $codes.Count; $i++) { $value = $value.Replace("@@CODE$i@@", $codes[$i]) }
    for ($i = 0; $i -lt $raw.Count; $i++) { $value = $value.Replace("@@RAW$i@@", $raw[$i]) }
    return $value
}

function Convert-Markdown([string]$Markdown) {
    $lines = $Markdown -replace "`r`n?", "`n" -split "`n"
    $html = [System.Text.StringBuilder]::new()
    $paragraph = [System.Collections.Generic.List[string]]::new()
    $listType = ''
    $inFence = $false
    $codeLines = [System.Collections.Generic.List[string]]::new()

    $flushParagraph = {
        if ($paragraph.Count -gt 0) {
            $joined = ($paragraph -join "`n") -replace '\s*\n\s*', ' '
            $converted = Convert-InlineMarkdown $joined
            if ($converted -match '^\s*<figure class="notebook-image"[\s\S]*</figure>\s*$') {
                [void]$html.AppendLine($converted)
            } else {
                [void]$html.AppendLine("<p>$converted</p>")
            }
            $paragraph.Clear()
        }
    }
    foreach ($line in $lines) {
        if ($line -match '^\s*```') {
            if ($inFence) {
                $code = [System.Net.WebUtility]::HtmlEncode(($codeLines -join "`n"))
                [void]$html.AppendLine("<pre class=`"markdown-code`"><code>$code</code></pre>")
                $codeLines.Clear()
                $inFence = $false
            } else {
                & $flushParagraph
                Close-MarkdownList $html ([ref]$listType)
                $inFence = $true
            }
            continue
        }
        if ($inFence) { $codeLines.Add($line); continue }
        if (-not $line.Trim()) { & $flushParagraph; Close-MarkdownList $html ([ref]$listType); continue }
        if ($line -match '^\s*[-*_]{3,}\s*$') { & $flushParagraph; Close-MarkdownList $html ([ref]$listType); [void]$html.AppendLine('<hr>'); continue }
        if ($line -match '^(#{1,6})\s*(.*)$') {
            & $flushParagraph; Close-MarkdownList $html ([ref]$listType)
            $level = $Matches[1].Length
            $text = Convert-InlineMarkdown $Matches[2]
            [void]$html.AppendLine("<h$level>$text</h$level>")
            continue
        }
        if ($line -match '^\s*([-*+]\s+|\d+[.)]\s+)') {
            & $flushParagraph
            $type = if ($line -match '^\s*\d+[.)]\s+') { 'ol' } else { 'ul' }
            if ($listType -and $listType -ne $type) { Close-MarkdownList $html ([ref]$listType) }
            if (-not $listType) { $listType = $type; [void]$html.AppendLine("<$listType>") }
            $item = $line -replace '^\s*([-*+]\s+|\d+[.)]\s+)', ''
            [void]$html.AppendLine("<li>$(Convert-InlineMarkdown $item)</li>")
            continue
        }
        if ($line -match '^\s*>\s?(.*)$') {
            & $flushParagraph; Close-MarkdownList $html ([ref]$listType)
            [void]$html.AppendLine("<blockquote><p>$(Convert-InlineMarkdown $Matches[1])</p></blockquote>")
            continue
        }
        $paragraph.Add($line.Trim())
    }
    if ($inFence) {
        $code = [System.Net.WebUtility]::HtmlEncode(($codeLines -join "`n"))
        [void]$html.AppendLine("<pre class=`"markdown-code`"><code>$code</code></pre>")
    }
    & $flushParagraph
    Close-MarkdownList $html ([ref]$listType)
    return $html.ToString()
}

function Close-MarkdownList($Builder, [ref]$ListType) {
    if ($ListType.Value) {
        [void]$Builder.AppendLine("</$($ListType.Value)>")
        $ListType.Value = ''
    }
}

function Get-OutputData($Output, [string]$Mime) {
    if (-not $Output.data) { return $null }
    $property = $Output.data.PSObject.Properties[$Mime]
    if ($property) { return $property.Value }
    return $null
}

function Add-CellOutput($Builder, $Output) {
    if ($Output.output_type -eq 'stream') {
        $text = Get-CellSource $Output
        if (-not $text -and $Output.text) { $text = $Output.text -join '' }
        if ($text) {
            $text = [regex]::Replace($text, ([char]27 + '\[[0-?]*[ -/]*[@-~]'), '')
            $text = $text -replace "`r`n?", "`n"
            $text = [regex]::Replace($text, '[ \t]+(?=\r?$)', '', [System.Text.RegularExpressions.RegexOptions]::Multiline)
            if ($text.Length -gt 12000) { $text = $text.Substring(0, 12000).TrimEnd() + "`n[Salida truncada en la versión web.]" }
            $safe = [System.Net.WebUtility]::HtmlEncode($text)
            [void]$Builder.AppendLine("<pre class=`"output-text`"><code>$safe</code></pre>")
        }
        return
    }
    if ($Output.output_type -eq 'error') {
        $text = (($Output.traceback) -join "`n")
        if (-not $text) { $text = "$($Output.ename): $($Output.evalue)" }
        $text = [regex]::Replace($text, ([char]27 + '\[[0-?]*[ -/]*[@-~]'), '')
        if ($text.Length -gt 12000) { $text = $text.Substring(0, 12000).TrimEnd() + "`n[Salida truncada en la versión web.]" }
        [void]$Builder.AppendLine("<pre class=`"output-error`"><code>$([System.Net.WebUtility]::HtmlEncode($text))</code></pre>")
        return
    }

    $png = Get-OutputData $Output 'image/png'
    if ($png) {
        $pngData = if ($png -is [array]) { $png -join '' } else { [string]$png }
        [void]$Builder.AppendLine("<figure class=`"notebook-image output-image`"><img loading=`"lazy`" alt=`"Salida gráfica del notebook`" src=`"data:image/png;base64,$pngData`"><figcaption>Salida gráfica guardada en la notebook.</figcaption></figure>")
    }

    $plain = Get-OutputData $Output 'text/plain'
    if ($plain -and -not $png) {
        $text = if ($plain -is [array]) { $plain -join '' } else { [string]$plain }
        $text = [regex]::Replace($text, '[ \t]+(?=\r?$)', '', [System.Text.RegularExpressions.RegexOptions]::Multiline)
        if ($text.Length -gt 12000) { $text = $text.Substring(0, 12000).TrimEnd() + "`n[Salida truncada en la versión web.]" }
        [void]$Builder.AppendLine("<pre class=`"output-text`"><code>$([System.Net.WebUtility]::HtmlEncode($text))</code></pre>")
    }

    $htmlOutput = Get-OutputData $Output 'text/html'
    if ($htmlOutput -and -not $plain -and -not $png) {
        [void]$Builder.AppendLine('<p class="output-note">La notebook contiene aquí una salida HTML dinámica que no se ejecuta en esta página. Consulta el código fuente o abre el cuaderno en Colab.</p>')
    }
    $plotly = Get-OutputData $Output 'application/vnd.plotly.v1+json'
    if ($plotly) {
        [void]$Builder.AppendLine('<p class="output-note">Gráfico interactivo de Plotly guardado en la notebook. Para explorarlo, ejecuta la celda desde Colab.</p>')
    }
}

function Add-InteractiveActivity($Builder, $Module) {
    [void]$Builder.AppendLine('<section class="learning-activity" aria-labelledby="activity-title">')
    [void]$Builder.AppendLine('<div class="activity-heading"><span class="section-kicker">PRACTICA FORMATIVA</span><h2 id="activity-title">Comprueba lo que comprendiste</h2><p>Responde sin ejecutar código. Puedes volver a intentarlo; el resultado queda solamente en este navegador y no es una calificación oficial.</p></div>')
    [void]$Builder.AppendLine('<form class="interactive-quiz" novalidate>')

    if ($Module.Number -eq '01') {
        [void]$Builder.AppendLine('<fieldset class="quiz-question" data-answer="b"><legend><span class="question-number">1</span>¿Qué información se pierde principalmente al representar un texto con Bag-of-Words?</legend><label><input type="radio" name="m01-q01" value="a"> La frecuencia de cada palabra.</label><label><input type="radio" name="m01-q01" value="b"> El orden y el contexto de las palabras.</label><label><input type="radio" name="m01-q01" value="c"> El tamaño del vocabulario.</label><p class="quiz-feedback" data-correct="Correcto: Bag-of-Words conserva conteos, pero no representa el orden ni las relaciones de contexto." data-incorrect="Revisa la diferencia entre contar palabras y representar el contexto: Bag-of-Words conserva frecuencias, pero pierde el orden." hidden></p></fieldset>')
        [void]$Builder.AppendLine('<fieldset class="quiz-question" data-answer="c"><legend><span class="question-number">2</span>Si dos palabras tienen alta similitud en Word2Vec, ¿qué conclusión es más prudente?</legend><label><input type="radio" name="m01-q02" value="a"> Que son sinónimos en cualquier idioma y situación.</label><label><input type="radio" name="m01-q02" value="b"> Que el modelo demostró una relación causal entre ellas.</label><label><input type="radio" name="m01-q02" value="c"> Que aparecen en contextos parecidos en el corpus usado.</label><p class="quiz-feedback" data-correct="Correcto: la similitud describe una regularidad del corpus y depende de sus datos y parámetros." data-incorrect="La similitud no prueba sinonimia, causalidad ni comprensión: describe contextos parecidos en el corpus." hidden></p></fieldset>')
        [void]$Builder.AppendLine('<fieldset class="quiz-question" data-answer="a"><legend><span class="question-number">3</span>¿Qué decisión mejora la posibilidad de reproducir un entrenamiento pequeño de Word2Vec?</legend><label><input type="radio" name="m01-q03" value="a"> Registrar corpus, parámetros, semilla y usar un solo worker cuando corresponda.</label><label><input type="radio" name="m01-q03" value="b"> Ocultar la versión de la biblioteca para evitar sesgos.</label><label><input type="radio" name="m01-q03" value="c"> Cambiar el corpus en cada ejecución sin anotarlo.</label><p class="quiz-feedback" data-correct="Correcto: documentar entradas y configuración permite interpretar y repetir la práctica con más control." data-incorrect="La reproducibilidad requiere registrar entradas y configuración; ocultar versiones o cambiar datos sin anotarlo impide comparar resultados." hidden></p></fieldset>')
    }
    if ($Module.Number -eq '02') {
        [void]$Builder.AppendLine('<fieldset class="quiz-question" data-answer="a"><legend><span class="question-number">1</span>En una traza ReAct, ¿qué ocurre después de una acción válida?</legend><label><input type="radio" name="m02-q01" value="a"> Se ejecuta la herramienta y su resultado se incorpora como observación.</label><label><input type="radio" name="m02-q01" value="b"> Se da por terminada la tarea sin revisar el resultado.</label><label><input type="radio" name="m02-q01" value="c"> Se convierte automáticamente en una respuesta humana.</label><p class="quiz-feedback" data-correct="Correcto: la observación devuelve al ciclo el resultado de la herramienta para decidir el siguiente paso." data-incorrect="En ReAct la acción no basta: la herramienta debe ejecutarse y su salida vuelve al ciclo como observación." hidden></p></fieldset>')
        [void]$Builder.AppendLine('<fieldset class="quiz-question" data-answer="c"><legend><span class="question-number">2</span>Si el prompt pide <code>FINAL:</code> pero el parser solo reconoce <code>Final Answer:</code>, ¿qué riesgo aparece?</legend><label><input type="radio" name="m02-q02" value="a"> El agente siempre será más preciso.</label><label><input type="radio" name="m02-q02" value="b"> La herramienta recibirá permisos adicionales.</label><label><input type="radio" name="m02-q02" value="c"> El parser puede no reconocer la respuesta final y continuar o fallar.</label><p class="quiz-feedback" data-correct="Correcto: un contrato de formato inconsistente puede impedir la terminación o producir un error de parseo." data-incorrect="Compara exactamente el formato producido con el que espera el parser: una diferencia puede impedir reconocer la respuesta final." hidden></p></fieldset>')
        [void]$Builder.AppendLine('<fieldset class="quiz-question" data-answer="b"><legend><span class="question-number">3</span>¿Cuál es una buena prueba negativa para una herramienta de un agente?</legend><label><input type="radio" name="m02-q03" value="a"> Probar solo una entrada ideal y registrar que terminó.</label><label><input type="radio" name="m02-q03" value="b"> Enviar una herramienta desconocida o un argumento inválido y verificar un cierre seguro.</label><label><input type="radio" name="m02-q03" value="c"> Aumentar indefinidamente el límite de iteraciones.</label><p class="quiz-feedback" data-correct="Correcto: las pruebas negativas muestran cómo responde el sistema ante entradas no previstas y ayudan a evitar ciclos inseguros." data-incorrect="Una prueba negativa debe explorar errores previsibles, como herramientas desconocidas o argumentos inválidos, y comprobar una respuesta segura." hidden></p></fieldset>')
    }
    if ($Module.Number -eq '03') {
        [void]$Builder.AppendLine('<fieldset class="quiz-question" data-answer="b"><legend><span class="question-number">1</span>¿Qué opción describe mejor una Skill en esta ruta?</legend><label><input type="radio" name="m03-q01" value="a"> Un permiso secreto que habilita cualquier acción.</label><label><input type="radio" name="m03-q01" value="b"> Un paquete de instrucciones y recursos reutilizables para una capacidad.</label><label><input type="radio" name="m03-q01" value="c"> Un reemplazo obligatorio de todas las herramientas.</label><p class="quiz-feedback" data-correct="Correcto: una Skill organiza instrucciones y recursos; su forma y alcance dependen de la plataforma que la implemente." data-incorrect="Una Skill no es un secreto ni un permiso universal: en este recurso se entiende como un paquete de instrucciones y recursos reutilizables." hidden></p></fieldset>')
        [void]$Builder.AppendLine('<fieldset class="quiz-question" data-answer="a"><legend><span class="question-number">2</span>¿Qué principio debería guiar los permisos de una herramienta?</legend><label><input type="radio" name="m03-q02" value="a"> Mínimo privilegio: habilitar solo lo necesario y validar entradas y resultados.</label><label><input type="radio" name="m03-q02" value="b"> Dar acceso total para que el agente no se bloquee.</label><label><input type="radio" name="m03-q02" value="c"> Evitar documentar los datos que entran y salen.</label><p class="quiz-feedback" data-correct="Correcto: el mínimo privilegio reduce el impacto de errores y debe acompañarse de validación y confirmación para efectos externos." data-incorrect="El acceso total aumenta el riesgo. Define permisos mínimos, valida entradas y resultados y pide confirmación cuando corresponda." hidden></p></fieldset>')
        [void]$Builder.AppendLine('<fieldset class="quiz-question" data-answer="c"><legend><span class="question-number">3</span>¿Qué conviene hacer antes de adaptar un ejemplo de un framework de agentes?</legend><label><input type="radio" name="m03-q03" value="a"> Suponer que todas las APIs mantienen el mismo comportamiento.</label><label><input type="radio" name="m03-q03" value="b"> Conectar credenciales reales para comprobar rápidamente.</label><label><input type="radio" name="m03-q03" value="c"> Validar versiones, dependencias, permisos y casos de error en un entorno controlado.</label><p class="quiz-feedback" data-correct="Correcto: los frameworks cambian; una adaptación responsable registra versiones y prueba límites sin exponer credenciales reales." data-incorrect="Antes de adaptar, revisa versiones y dependencias, usa un entorno controlado y prueba errores sin exponer credenciales." hidden></p></fieldset>')
    }
    [void]$Builder.AppendLine('<div class="quiz-actions"><button class="button primary" type="submit">Corregir respuestas</button><output class="quiz-score" aria-live="polite">Práctica pendiente · 0 de 3</output></div>')
    [void]$Builder.AppendLine('</form>')
    [void]$Builder.AppendLine('<aside class="activity-transfer"><strong>Para conversar o entregar.</strong> Explica una respuesta a otra persona, señala un supuesto o posible fallo y escribe qué evidencia necesitarías para cambiar de opinión. Si no puedes ejecutar la notebook, responde usando el código y las salidas visibles en esta página.</aside>')
    [void]$Builder.AppendLine('</section>')
}

function Add-TransparencyNotices($Builder, $Module) {
    [void]$Builder.AppendLine('<section class="module-notices" aria-labelledby="notices-title"><div class="module-notices-heading"><span class="section-kicker">TRANSPARENCIA Y SEGURIDAD</span><h2 id="notices-title">Antes de ejecutar</h2><p>Estas condiciones acompañan la lectura y deben comprobarse en cada entorno de práctica.</p></div><div class="notice-grid">')
    [void]$Builder.AppendLine('<aside class="notice info"><strong>Licencia declarada para los componentes propios.</strong> Esta versión se distribuye bajo <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.es" target="_blank" rel="noopener noreferrer">CC BY-NC-SA 4.0 ↗</a>, con atribución, uso no comercial y compartir igual. Los materiales de terceros mantienen sus propias condiciones; revisa el <a href="../licencias-y-atribuciones.html">estado de licencias y atribuciones</a>.</aside>')
    [void]$Builder.AppendLine('<aside class="notice info"><strong>Lectura estática.</strong> Esta página muestra el texto, el código y las salidas que ya estaban guardadas en la notebook. No ejecuta celdas. Las salidas HTML dinámicas de terceros se omiten por seguridad; los gráficos interactivos requieren abrir la notebook.</aside>')

    if ($Module.File -eq '2025_word2vec.ipynb') {
        [void]$Builder.AppendLine('<aside class="notice warning"><strong>Requisito de datos.</strong> El notebook busca <code>simpsons_dataset.csv</code> en una ruta de Google Drive específica. Para ejecutarlo desde Colab, tendrás que proporcionar ese archivo o actualizar la ruta en una copia de trabajo. El dataset no está incluido en este repositorio.</aside>')
        [void]$Builder.AppendLine('<aside class="notice warning"><strong>Revisión del código fuente (SRC-01, SRC-27).</strong> La celda de analogías contiene una línea que parece tener un error de sintaxis. La documentación de Gensim 4.3.3 marca <code>init_sims()</code> como obsoleto; para vectores normalizados documenta <code>model.wv.get_vector(palabra, norm=True)</code>. Registra versión, parámetros y corpus, y prueba las celdas en un entorno limpio antes de usarlas.</aside>')
        [void]$Builder.AppendLine('<aside class="notice info"><strong>Reproducibilidad del entrenamiento (SRC-27).</strong> La API permite registrar una semilla, pero su documentación advierte que la planificación concurrente puede introducir variación: usa <code>workers=1</code> y fija <code>PYTHONHASHSEED</code> para una ejecución más reproducible. La normalización y las analogías describen asociaciones del corpus; no prueban causalidad ni comprensión humana. <a href="https://radimrehurek.com/gensim/models/word2vec.html" target="_blank" rel="noopener noreferrer">Consultar documentación de Gensim ↗</a></aside>')
    }
    if ($Module.File -eq 'Agente_ReAct.ipynb') {
        [void]$Builder.AppendLine('<aside class="notice warning"><strong>Revisión del flujo ReAct (SRC-04).</strong> En la notebook, el prompt solicita <code>FINAL:</code>, mientras que el parser busca <code>Final Answer:</code>. Además, el patrón de acción requiere texto después de <code>|</code>, aunque el ejemplo de la herramienta de hora no lleva entrada. La salida guardada de esa prueba tampoco llega a la fecha final. Revisa y corrige estas diferencias antes de usarlo como práctica ejecutable.</aside>')
        [void]$Builder.AppendLine('<aside class="notice info"><strong>Fundamento y evaluación (SRC-28).</strong> ReAct propone intercalar razonamiento y acciones; el patrón del artículo no garantiza que cada agente o parser funcione correctamente. Evalúa por separado el formato de salida, selección de herramienta, observación, respuesta final y límite de iteraciones. <a href="https://arxiv.org/abs/2210.03629" target="_blank" rel="noopener noreferrer">Leer el artículo original ↗</a></aside>')
    }
    if ($Module.File -eq 'Agente_LangChain.ipynb') {
        [void]$Builder.AppendLine('<aside class="notice warning"><strong>Reproducibilidad (SRC-03).</strong> Las dependencias se instalan sin fijar versiones y el ejemplo utiliza APIs de frameworks que pueden cambiar. Para una práctica reproducible, valida el notebook en un entorno limpio y registra versiones probadas.</aside>')
        [void]$Builder.AppendLine('<aside class="notice info"><strong>Mapa actual de abstracciones (SRC-29 a SRC-33).</strong> LangChain documenta <code>create_agent</code> para bucles modelo-herramientas configurables; LangGraph se centra en orquestar flujos con estado, persistencia y supervisión humana. Skills son paquetes de instrucciones y recursos cuya forma depende de la plataforma; MCP es un protocolo para conectar aplicaciones y herramientas, no un framework de agentes. Consulta la <a href="../fuentes/actualizacion-fuentes-2026.html">actualización de fuentes</a> antes de adaptar ejemplos a APIs actuales.</aside>')
        [void]$Builder.AppendLine('<aside class="notice warning"><strong>Diseño seguro de herramientas (SRC-33).</strong> Define permisos mínimos, valida argumentos y resultados, limita iteraciones y pide confirmación antes de efectos externos. No conectes credenciales reales ni servidores locales que no hayas auditado; consulta las prácticas de <a href="https://modelcontextprotocol.io/docs/2026-07-28/tutorials/security/security_best_practices" target="_blank" rel="noopener noreferrer">seguridad de MCP ↗</a>.</aside>')
    }
    if ($Module.File -in @('Agente_ReAct.ipynb','Agente_LangChain.ipynb')) {
        [void]$Builder.AppendLine('<aside class="notice warning"><strong>Requisito de API.</strong> El notebook solicita un token de Hugging Face mediante una entrada oculta. No publiques ni guardes tokens en el repositorio; configura el secreto en tu entorno antes de ejecutar las celdas que llaman al modelo o a servicios externos.</aside>')
    }
    [void]$Builder.AppendLine('</div></section>')
}

$modules = @(
    [pscustomobject]@{
        File='2025_word2vec.ipynb'; Output='01-word2vec.html'; Number='01'; Title='Del texto a Word2Vec';
        Focus=@('Preparar el corpus','Aprender embeddings','Leer similitudes');
        SourceId='SRC-01'; Pdf='2025_word2vec.ipynb - Colab.pdf';
        Summary='Preprocesamiento, tokenización, representaciones del texto y exploración de embeddings estáticos.';
        Lead='Convertimos un corpus en datos analizables y observamos cómo Word2Vec aprende vectores a partir de los contextos. La meta no es “entender” el texto, sino aprender a leer qué representan los resultados y cuáles son sus límites.';
        Purpose='Relacionar las decisiones de limpieza y tokenización con las representaciones vectoriales que aprende un modelo de embeddings.';
        Evidence='Un registro de decisiones sobre el corpus, los parámetros de entrenamiento y la interpretación prudente de una similitud.';
        Requirements='Lectura web para seguir el concepto; para ejecutar, notebook, corpus simpsons_dataset.csv y un entorno compatible con Gensim.'
    },
    [pscustomobject]@{
        File='Agente_ReAct.ipynb'; Output='02-agente-react.html'; Number='02'; Title='Construir un agente ReAct';
        Focus=@('Definir herramientas','Interpretar acciones','Cerrar el ciclo');
        SourceId='SRC-04'; Pdf='Agente_ReAct.ipynb - Colab.pdf';
        Summary='Herramientas, formato de acciones, parser y ciclo Thought–Action–Observation implementado en Python.';
        Lead='Construimos un agente haciendo visibles sus piezas: herramienta, instrucciones, parser, observación y respuesta final. El foco está en analizar el flujo y sus fallos, no en atribuir razonamiento humano al modelo.';
        Purpose='Distinguir la generación de texto de la ejecución de acciones y analizar cómo un bucle ReAct coordina ambas.';
        Evidence='Una traza anotada del ciclo y un conjunto de pruebas para respuestas válidas, errores, herramientas desconocidas y límite de iteraciones.';
        Requirements='Lectura web para analizar el flujo; para ejecutar, notebook, dependencias compatibles y token de Hugging Face configurado fuera del repositorio.'
    },
    [pscustomobject]@{
        File='Agente_LangChain.ipynb'; Output='03-frameworks-skills.html'; Number='03'; Title='De ReAct a frameworks y skills';
        Focus=@('Declarar tools','Orquestar el flujo','Componer skills');
        SourceId='SRC-03'; Pdf='Agente_LangChain.ipynb - Colab.pdf';
        Summary='Abstracción de herramientas y agentes con LangChain/LangGraph, y composición de skills.';
        Lead='Comparamos el bucle ReAct explícito con las abstracciones de LangChain y LangGraph, y distinguimos una herramienta, una Skill y un protocolo como MCP. Elegimos la capa adecuada sin ocultar sus riesgos.';
        Purpose='Comparar distintas capas de abstracción y justificar cuándo conviene una herramienta puntual, una Skill o un runtime de orquestación.';
        Evidence='Un diagrama de componentes con permisos mínimos, criterios de elección y casos de prueba para una herramienta o flujo.';
        Requirements='Lectura web para comparar conceptos; para ejecutar, notebook, versiones verificadas y token configurado de forma segura. MCP no es requisito.'
    }
)

foreach ($module in $modules) {
    $sourcePath = Join-Path $notebooksDir $module.File
    if (-not (Test-Path $sourcePath)) { throw "Falta el notebook requerido: $sourcePath" }
    $notebook = Get-Content -Raw -Encoding utf8 $sourcePath | ConvertFrom-Json
    $builder = [System.Text.StringBuilder]::new()
    $notebookPath = "../fuentes/$($module.File)"
    $pdfPath = "../fuentes/$([uri]::EscapeDataString($module.Pdf))"
    $colabPath = "https://colab.research.google.com/github/$Repository/blob/$Branch/fuentes/$($module.File)"

    [void]$builder.AppendLine('<!doctype html>')
    [void]$builder.AppendLine('<html lang="es">')
    [void]$builder.AppendLine('<head>')
    [void]$builder.AppendLine('<meta charset="utf-8">')
    [void]$builder.AppendLine('<meta name="viewport" content="width=device-width, initial-scale=1">')
    [void]$builder.AppendLine("<meta name=`"description`" content=`"$([System.Net.WebUtility]::HtmlEncode($module.Summary))`">")
    [void]$builder.AppendLine("<title>$([System.Net.WebUtility]::HtmlEncode($module.Title)) · Recurso educativo</title>")
    [void]$builder.AppendLine('<link rel="stylesheet" href="../assets/rea.css?v=20261010-7">')
    [void]$builder.AppendLine('<script src="../assets/learning.js?v=20261010-1" defer></script>')
    [void]$builder.AppendLine('</head>')
    [void]$builder.AppendLine('<body>')
    [void]$builder.AppendLine('<a class="skip-link" href="#contenido">Saltar al contenido</a>')
    [void]$builder.AppendLine('<header class="site-header"><div class="header-inner"><a class="brand" href="../index.html">De Word2Vec a agentes de IA</a><nav aria-label="Navegación principal"><a href="../index.html">Inicio</a><a href="../guia-reutilizacion.html">Guía de reutilización</a><a href="../evaluacion-final.html">Actividad integradora</a><a href="../licencias-y-atribuciones.html">Licencias</a></nav></div></header>')
    [void]$builder.AppendLine("<main id=`"contenido`" class=`"page-shell module-page module-$($module.Number)`">")
    [void]$builder.AppendLine('<section class="module-hero">')
    [void]$builder.AppendLine('<div class="eyebrow"><span>RUTA DE APRENDIZAJE</span><span class="eyebrow-divider"></span><span>MÓDULO ' + $module.Number + ' DE 03</span></div>')
    [void]$builder.AppendLine("<h1>$([System.Net.WebUtility]::HtmlEncode($module.Title))</h1>")
    [void]$builder.AppendLine("<p class=`"lead`">$([System.Net.WebUtility]::HtmlEncode($module.Lead))</p>")
    [void]$builder.AppendLine("<div class=`"focus-grid`" aria-label=`"Focos de aprendizaje`"><div class=`"focus-card`"><span class=`"focus-number`">01</span><span>$([System.Net.WebUtility]::HtmlEncode($module.Focus[0]))</span></div><div class=`"focus-card`"><span class=`"focus-number`">02</span><span>$([System.Net.WebUtility]::HtmlEncode($module.Focus[1]))</span></div><div class=`"focus-card`"><span class=`"focus-number`">03</span><span>$([System.Net.WebUtility]::HtmlEncode($module.Focus[2]))</span></div></div>")
    [void]$builder.AppendLine('<div class="action-row">')
    [void]$builder.AppendLine("<a class=`"button primary`" href=`"$colabPath`" target=`"_blank`" rel=`"noopener noreferrer`">Abrir notebook en Google Colab <span aria-hidden=`"true`">↗</span></a>")
    [void]$builder.AppendLine("<a class=`"button secondary`" href=`"$notebookPath`" download>Descargar notebook (.ipynb)</a>")
    [void]$builder.AppendLine("<a class=`"button secondary`" href=`"$pdfPath`" download>Descargar PDF</a>")
    [void]$builder.AppendLine('</div>')
    [void]$builder.AppendLine("<p class=`"source-note`">Fuente: $($module.SourceId) · <code>$([System.Net.WebUtility]::HtmlEncode($module.File))</code></p>")
    [void]$builder.AppendLine('</section>')
    [void]$builder.AppendLine('<nav class="learning-path" aria-label="Progreso de la ruta formativa">')
    [void]$builder.AppendLine('<div class="path-caption"><span>ITINERARIO</span><span>De la representación a la acción</span></div>')
    $pathSteps = @(
        [pscustomobject]@{ Number='01'; Label='Texto y embeddings'; Href='01-word2vec.html?v=cf595a3' },
        [pscustomobject]@{ Number='02'; Label='Agentes ReAct'; Href='02-agente-react.html?v=cf595a3' },
        [pscustomobject]@{ Number='03'; Label='Frameworks y skills'; Href='03-frameworks-skills.html?v=cf595a3' }
    )
    foreach ($step in $pathSteps) {
        $stepClass = if ($step.Number -eq $module.Number) { 'path-step active' } elseif ([int]$step.Number -lt [int]$module.Number) { 'path-step complete' } else { 'path-step' }
        $aria = if ($step.Number -eq $module.Number) { ' aria-current="step"' } else { '' }
        [void]$builder.AppendLine("<a class=`"$stepClass`" href=`"$($step.Href)`"$aria><span class=`"path-number`">$($step.Number)</span><span class=`"path-label`">$([System.Net.WebUtility]::HtmlEncode($step.Label))</span></a>")
    }
    [void]$builder.AppendLine('</nav>')
    [void]$builder.AppendLine('<section class="module-overview" aria-labelledby="overview-title">')
    [void]$builder.AppendLine('<div class="module-overview-heading"><span class="section-kicker">ANTES DE EMPEZAR</span><h2 id="overview-title">Qué vas a hacer en este módulo</h2><p>La página permite estudiar el recorrido sin ejecutar código. Usa la notebook solo después de revisar los requisitos y las advertencias.</p></div>')
    [void]$builder.AppendLine('<div class="module-overview-grid">')
    [void]$builder.AppendLine("<article class=`"overview-card overview-purpose`"><span class=`"overview-label`">PROPÓSITO</span><p>$([System.Net.WebUtility]::HtmlEncode($module.Purpose))</p></article>")
    [void]$builder.AppendLine("<article class=`"overview-card overview-evidence`"><span class=`"overview-label`">EVIDENCIA SUGERIDA</span><p>$([System.Net.WebUtility]::HtmlEncode($module.Evidence))</p></article>")
    [void]$builder.AppendLine("<article class=`"overview-card overview-requirements`"><span class=`"overview-label`">REQUISITOS</span><p>$([System.Net.WebUtility]::HtmlEncode($module.Requirements))</p></article>")
    [void]$builder.AppendLine('</div></section>')
    [void]$builder.AppendLine("<div class=`"lesson-label`"><span class=`"lesson-dot`"></span><span>$($module.Number) / CONTENIDO DE LA LECCIÓN</span><span class=`"lesson-source`">Transcripción estática de la notebook</span></div>")
    [void]$builder.AppendLine('<section class="notebook-content" aria-label="Contenido original de la notebook">')
    $cellNumber = 0
    foreach ($cell in $notebook.cells) {
        $cellNumber++
        $source = Get-CellSource $cell
        if ($cell.cell_type -eq 'markdown') {
            [void]$builder.AppendLine('<article class="markdown-cell">')
            [void]$builder.AppendLine((Convert-Markdown $source))
            [void]$builder.AppendLine('</article>')
            continue
        }
        if ($cell.cell_type -eq 'code') {
            $exec = if ($cell.execution_count) { " · ejecución guardada #$($cell.execution_count)" } else { '' }
            $renderedCode = [regex]::Replace($source, '[ \t]+(?=\r?$)', '', [System.Text.RegularExpressions.RegexOptions]::Multiline)
            [void]$builder.AppendLine("<details class=`"code-cell`"><summary>Código Python$exec</summary><pre><code>$([System.Net.WebUtility]::HtmlEncode($renderedCode))</code></pre></details>")
            foreach ($output in $cell.outputs) { Add-CellOutput $builder $output }
            continue
        }
        if ($cell.cell_type -eq 'raw' -and $source.Trim()) {
            [void]$builder.AppendLine("<pre class=`"output-text`"><code>$([System.Net.WebUtility]::HtmlEncode($source))</code></pre>")
        }
    }
    [void]$builder.AppendLine('</section>')
    [void]$builder.AppendLine('<nav class="module-nav" aria-label="Explorar módulos de la ruta">')
    $moduleLinks = @(
        [pscustomobject]@{ Number='01'; Label='Texto y embeddings'; Href='01-word2vec.html?v=cf595a3' },
        [pscustomobject]@{ Number='02'; Label='Agentes ReAct'; Href='02-agente-react.html?v=cf595a3' },
        [pscustomobject]@{ Number='03'; Label='Frameworks y skills'; Href='03-frameworks-skills.html?v=cf595a3' }
    )
    foreach ($link in $moduleLinks) {
        $current = if ($link.Number -eq $module.Number) { ' aria-current="page"' } else { '' }
        [void]$builder.AppendLine("<a href=`"$($link.Href)`"$current><span>MÓDULO $($link.Number)</span><strong>$([System.Net.WebUtility]::HtmlEncode($link.Label))</strong></a>")
    }
    [void]$builder.AppendLine('</nav>')
    Add-InteractiveActivity $builder $module
    Add-TransparencyNotices $builder $module
    [void]$builder.AppendLine('</main>')
    [void]$builder.AppendLine('<footer class="site-footer"><p>Recurso educativo en preparación · Cátedra de Inteligencia Artificial</p><p>Fuentes originales y estado de permisos: <a href="https://github.com/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/README.md" rel="noopener noreferrer">inventario de fuentes</a>.</p></footer>')
    [void]$builder.AppendLine('</body></html>')

    $destination = Join-Path $outputDir $module.Output
    [System.IO.File]::WriteAllText($destination, $builder.ToString(), $utf8)
    Write-Output "Generado: $destination"
}
