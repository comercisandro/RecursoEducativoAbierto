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
            [void]$html.AppendLine("<p>$(Convert-InlineMarkdown $joined)</p>")
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

$modules = @(
    [pscustomobject]@{
        File='2025_word2vec.ipynb'; Output='01-word2vec.html'; Number='01'; Title='Del texto a Word2Vec';
        SourceId='SRC-01'; Pdf='2025_word2vec.ipynb - Colab.pdf';
        Summary='Preprocesamiento, tokenización, representaciones del texto y exploración de embeddings estáticos.';
        Lead='Partimos de las palabras y de las decisiones que convierten un corpus en datos analizables. Después exploramos cómo Word2Vec aprende vectores a partir de contextos y qué relaciones se pueden observar en ese espacio.'
    },
    [pscustomobject]@{
        File='Agente_ReAct.ipynb'; Output='02-agente-react.html'; Number='02'; Title='Construir un agente ReAct';
        SourceId='SRC-04'; Pdf='Agente_ReAct.ipynb - Colab.pdf';
        Summary='Herramientas, formato de acciones, parser y ciclo Thought–Action–Observation implementado en Python.';
        Lead='El notebook construye un agente desde sus componentes: conexión con un modelo, definición de herramientas, instrucciones estructuradas, análisis de la respuesta y bucle de ejecución.'
    },
    [pscustomobject]@{
        File='Agente_LangChain.ipynb'; Output='03-frameworks-skills.html'; Number='03'; Title='De ReAct a frameworks y skills';
        SourceId='SRC-03'; Pdf='Agente_LangChain.ipynb - Colab.pdf';
        Summary='Abstracción de herramientas y agentes con LangChain/LangGraph, y composición de skills.';
        Lead='Después de implementar ReAct manualmente, comparamos ese flujo con las abstracciones de LangChain y exploramos herramientas y skills que reúnen varias operaciones.'
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
    [void]$builder.AppendLine('<link rel="stylesheet" href="../assets/rea.css">')
    [void]$builder.AppendLine('</head>')
    [void]$builder.AppendLine('<body>')
    [void]$builder.AppendLine('<a class="skip-link" href="#contenido">Saltar al contenido</a>')
    [void]$builder.AppendLine('<header class="site-header"><a class="brand" href="../index.html">De Word2Vec a agentes de IA</a><nav aria-label="Navegación principal"><a href="../index.html">Inicio</a><a href="../guia-reutilizacion.html">Guía docente</a><a href="../licencias-y-atribuciones.html">Licencias</a></nav></header>')
    [void]$builder.AppendLine('<main id="contenido" class="page-shell">')
    [void]$builder.AppendLine('<div class="eyebrow">RUTA DE APRENDIZAJE · MÓDULO ' + $module.Number + '</div>')
    [void]$builder.AppendLine("<h1>$([System.Net.WebUtility]::HtmlEncode($module.Title))</h1>")
    [void]$builder.AppendLine("<p class=`"lead`">$([System.Net.WebUtility]::HtmlEncode($module.Lead))</p>")
    [void]$builder.AppendLine("<p class=`"source-note`">Fuente: $($module.SourceId) · <code>$([System.Net.WebUtility]::HtmlEncode($module.File))</code></p>")
    [void]$builder.AppendLine('<div class="action-row">')
    [void]$builder.AppendLine("<a class=`"button primary`" href=`"$colabPath`" target=`"_blank`" rel=`"noopener noreferrer`">Abrir notebook en Google Colab <span aria-hidden=`"true`">↗</span></a>")
    [void]$builder.AppendLine("<a class=`"button secondary`" href=`"$notebookPath`" download>Descargar notebook (.ipynb)</a>")
    [void]$builder.AppendLine("<a class=`"button secondary`" href=`"$pdfPath`" download>Descargar PDF</a>")
    [void]$builder.AppendLine('</div>')
    [void]$builder.AppendLine('<aside class="notice"><strong>Licencia en revisión.</strong> La página y el notebook no muestran una licencia abierta declarada. La publicación pública del archivo no concede por sí sola permisos de adaptación o redistribución. Ver <a href="../licencias-y-atribuciones.html">estado de licencias y atribuciones</a>.</aside>')
    [void]$builder.AppendLine('<aside class="notice info"><strong>Lectura estática.</strong> Esta página muestra el texto, el código y las salidas que ya estaban guardadas en la notebook. No ejecuta celdas. Las salidas HTML dinámicas de terceros se omiten por seguridad; los gráficos interactivos requieren abrir la notebook.</aside>')

    if ($module.File -eq '2025_word2vec.ipynb') {
        [void]$builder.AppendLine('<aside class="notice warning"><strong>Requisito de datos.</strong> El notebook busca <code>simpsons_dataset.csv</code> en una ruta de Google Drive específica. Para ejecutarlo desde Colab, tendrás que proporcionar ese archivo o actualizar la ruta en una copia de trabajo. El dataset no está incluido en este repositorio.</aside>')
        [void]$builder.AppendLine('<aside class="notice warning"><strong>Revisión del código fuente (SRC-01).</strong> La celda de analogías contiene una línea que parece tener un error de sintaxis y la llamada <code>init_sims()</code> puede no ser compatible con versiones actuales de Gensim. La página reproduce el original; valida esas celdas y la versión de dependencias antes de la práctica.</aside>')
    }
    if ($module.File -eq 'Agente_ReAct.ipynb') {
        [void]$builder.AppendLine('<aside class="notice warning"><strong>Revisión del flujo ReAct (SRC-04).</strong> En la notebook, el prompt solicita <code>FINAL:</code>, mientras que el parser busca <code>Final Answer:</code>. Además, el patrón de acción requiere texto después de <code>|</code>, aunque el ejemplo de la herramienta de hora no lleva entrada. La salida guardada de esa prueba tampoco llega a la fecha final. Revisa y corrige estas diferencias antes de usarlo como práctica ejecutable.</aside>')
    }
    if ($module.File -eq 'Agente_LangChain.ipynb') {
        [void]$builder.AppendLine('<aside class="notice warning"><strong>Reproducibilidad (SRC-03).</strong> Las dependencias se instalan sin fijar versiones y el ejemplo utiliza APIs de frameworks que pueden cambiar. Para una práctica reproducible, valida el notebook en un entorno limpio y registra versiones probadas.</aside>')
    }
    if ($module.File -in @('Agente_ReAct.ipynb','Agente_LangChain.ipynb')) {
        [void]$builder.AppendLine('<aside class="notice warning"><strong>Requisito de API.</strong> El notebook solicita un token de Hugging Face mediante una entrada oculta. No publiques ni guardes tokens en el repositorio; configura el secreto en tu entorno antes de ejecutar las celdas que llaman al modelo o a servicios externos.</aside>')
    }

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
    [void]$builder.AppendLine('<nav class="module-nav" aria-label="Navegación entre módulos">')
    [void]$builder.AppendLine('<a href="01-word2vec.html">Modulo 01</a><a href="02-agente-react.html">Modulo 02</a><a href="03-frameworks-skills.html">Modulo 03</a>')
    [void]$builder.AppendLine('</nav>')
    [void]$builder.AppendLine('</main>')
    [void]$builder.AppendLine('<footer class="site-footer"><p>Recurso educativo en preparación · Cátedra de Inteligencia Artificial</p><p>Fuentes originales y estado de permisos: <a href="https://github.com/comercisandro/RecursoEducativoAbierto/blob/master/fuentes/README.md" rel="noopener noreferrer">inventario de fuentes</a>.</p></footer>')
    [void]$builder.AppendLine('</body></html>')

    $destination = Join-Path $outputDir $module.Output
    [System.IO.File]::WriteAllText($destination, $builder.ToString(), $utf8)
    Write-Output "Generado: $destination"
}
