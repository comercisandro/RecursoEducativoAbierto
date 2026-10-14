param(
    [string]$Output = (Join-Path (Split-Path -Parent $PSScriptRoot) 'site-local')
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$utf8 = [Text.UTF8Encoding]::new($false)
$siteTitle = 'Del lenguaje a los agentes inteligentes'
$siteDescription = 'Ruta did' + [char]0x00E1 + 'ctica abierta desde el procesamiento del lenguaje hasta los agentes de inteligencia artificial.'
$titleSeparator = '&#183;'
$navigationLabel = 'Navegaci' + [char]0x00F3 + 'n principal'
$guideLabel = 'Gu' + [char]0x00ED + 'a de reutilizaci' + [char]0x00F3 + 'n'
$footerTitle = 'Recurso educativo &#183; C' + [char]0x00E1 + 'tedra de Inteligencia Artificial'

function Convert-Inline([string]$Text) {
    $value = [Net.WebUtility]::HtmlEncode($Text)
    $value = [regex]::Replace($value, '\[([^\]]+)\]\(([^)]+)\)', '<a href="$2">$1</a>')
    $value = [regex]::Replace($value, '`([^`]+)`', '<code>$1</code>')
    $value = [regex]::Replace($value, '\*\*(.+?)\*\*', '<strong>$1</strong>')
    $value = [regex]::Replace($value, '(?<!\*)\*([^*]+)\*(?!\*)', '<em>$1</em>')
    return $value
}

function Render-Table([Collections.Generic.List[string]]$Rows) {
    if ($Rows.Count -eq 0) { return '' }
    $table = [Text.StringBuilder]::new()
    [void]$table.AppendLine('<table>')
    $header = @($Rows[0].Trim().Trim('|') -split '\|')
    [void]$table.AppendLine('<thead><tr>')
    foreach ($cell in $header) {
        [void]$table.AppendLine("<th scope=`"col`">$(Convert-Inline $cell.Trim())</th>")
    }
    [void]$table.AppendLine('</tr></thead>')
    if ($Rows.Count -gt 2) {
        [void]$table.AppendLine('<tbody>')
        for ($index = 2; $index -lt $Rows.Count; $index++) {
            [void]$table.AppendLine('<tr>')
            $cells = @($Rows[$index].Trim().Trim('|') -split '\|')
            foreach ($cell in $cells) {
                [void]$table.AppendLine("<td>$(Convert-Inline $cell.Trim())</td>")
            }
            [void]$table.AppendLine('</tr>')
        }
        [void]$table.AppendLine('</tbody>')
    }
    [void]$table.AppendLine('</table>')
    return $table.ToString()
}

function Convert-Markdown([string]$Markdown) {
    $lines = ($Markdown -replace "`r`n?", "`n") -split "`n"
    $html = [Text.StringBuilder]::new()
    $paragraph = [Collections.Generic.List[string]]::new()
    $listType = ''
    $inCode = $false
    $code = [Collections.Generic.List[string]]::new()
    $inTable = $false
    $tableRows = [Collections.Generic.List[string]]::new()

    function Close-List {
        if ($listType) { [void]$html.AppendLine("</$listType>"); $script:listType = '' }
    }
    function Flush-Paragraph {
        if ($paragraph.Count -gt 0) {
            [void]$html.AppendLine("<p>$(Convert-Inline ($paragraph -join ' '))</p>")
            $paragraph.Clear()
        }
    }

    foreach ($line in $lines) {
        if ($line -match '^```') {
            Flush-Paragraph
            if ($inCode) {
                [void]$html.AppendLine("<pre><code>$([Net.WebUtility]::HtmlEncode(($code -join "`n")))</code></pre>")
                $code.Clear()
                $inCode = $false
            } else { $inCode = $true }
            continue
        }
        if ($inCode) { $code.Add($line); continue }
        $isTableSeparator = $line -match '^\s*\|?\s*:?-+:?\s*(\|\s*:?-+:?\s*)+\|?\s*$'
        $isTableRow = (($line -split '\|').Count -ge 3) -and ($line -match '\|')
        if ($inTable) {
            if ($isTableSeparator -or $isTableRow) { $tableRows.Add($line.Trim()); continue }
            [void]$html.AppendLine((Render-Table $tableRows))
            $tableRows.Clear()
            $inTable = $false
        }
        if ($isTableRow) {
            Flush-Paragraph
            if ($listType) { [void]$html.AppendLine("</$listType>"); $listType = '' }
            $tableRows.Add($line.Trim())
            $inTable = $true
            continue
        }
        if ([string]::IsNullOrWhiteSpace($line)) { Flush-Paragraph; if ($listType) { [void]$html.AppendLine("</$listType>"); $listType = '' }; continue }
        if ($line -match '^#{1,6}\s+(.+)$') {
            Flush-Paragraph; if ($listType) { [void]$html.AppendLine("</$listType>"); $listType = '' }
            $level = $line.Substring(0, $line.IndexOf(' ')).Length
            [void]$html.AppendLine("<h$level>$(Convert-Inline $Matches[1])</h$level>"); continue
        }
        if ($line -match '^\s*[-*]\s+(.+)$') {
            Flush-Paragraph; if (-not $listType) { $listType = 'ul'; [void]$html.AppendLine('<ul>') } elseif ($listType -ne 'ul') { [void]$html.AppendLine("</$listType><ul>"); $listType = 'ul' }
            [void]$html.AppendLine("<li>$(Convert-Inline $Matches[1])</li>"); continue
        }
        if ($line -match '^\s*\d+\.\s+(.+)$') {
            Flush-Paragraph; if (-not $listType) { $listType = 'ol'; [void]$html.AppendLine('<ol>') } elseif ($listType -ne 'ol') { [void]$html.AppendLine("</$listType><ol>"); $listType = 'ol' }
            [void]$html.AppendLine("<li>$(Convert-Inline $Matches[1])</li>"); continue
        }
        if ($line -match '^>\s?(.*)$') { Flush-Paragraph; if ($listType) { [void]$html.AppendLine("</$listType>"); $listType = '' }; [void]$html.AppendLine("<blockquote>$(Convert-Inline $Matches[1])</blockquote>"); continue }
        if ($line -match '^\s*<') { Flush-Paragraph; if ($listType) { [void]$html.AppendLine("</$listType>"); $listType = '' }; [void]$html.AppendLine($line); continue }
        $paragraph.Add($line.Trim())
    }
    Flush-Paragraph
    if ($listType) { [void]$html.AppendLine("</$listType>") }
    if ($inCode) { [void]$html.AppendLine("<pre><code>$([Net.WebUtility]::HtmlEncode(($code -join "`n")))</code></pre>") }
    if ($inTable) { [void]$html.AppendLine((Render-Table $tableRows)) }
    return $html.ToString()
}

function Get-FrontMatter([string]$Text) {
    $result = @{ Layout = 'default'; Title = $siteTitle }
    $match = [regex]::Match($Text, '(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n')
    if (-not $match.Success) { return @{ Metadata = $result; Body = $Text } }
    foreach ($line in ($match.Groups[1].Value -split "`n")) {
        if ($line -match '^\s*([^:]+):\s*["'']?(.+?)["'']?\s*$') { $result[$Matches[1].Trim()] = $Matches[2].Trim() }
    }
    return @{ Metadata = $result; Body = $Text.Substring($match.Length) }
}

function Convert-LocalLinks([string]$Html) {
    $value = [regex]::Replace($Html, '\{\{\s*["'']([^"'']+)["'']\s*\|\s*relative_url\s*\}\}', { param($m) $m.Groups[1].Value })
    $value = $value.Replace('{{ site.lang | default: ''es'' }}', 'es')
    $value = $value.Replace('{{ site.description | escape }}', $siteDescription)
    $value = $value.Replace('{{ site.title | escape }}', $siteTitle)
    $value = [regex]::Replace($value, 'href="([^"]+)\.md([#"]?)', 'href="$1.html$2')
    return $value
}

function Write-Page([string]$Source, [string]$Destination) {
    $raw = Get-Content -Raw -Encoding utf8 $Source
    $parts = Get-FrontMatter $raw
    $metadata = $parts.Metadata
    $body = Convert-Markdown $parts.Body
    $title = [Net.WebUtility]::HtmlEncode([string]$metadata.Title)
    $description = [Net.WebUtility]::HtmlEncode($siteDescription)
    $main = if ([string]$metadata.Layout -eq 'page') { "<main id=`"contenido`" class=`"page-shell standard-page`"><article class=`"standard-content`">$body</article></main>" } else { $body }
    $page = @"
<!doctype html>
<html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><meta name="description" content="$description"><title>$title $titleSeparator $siteTitle</title><link rel="stylesheet" href="/assets/rea.css?v=local"><link rel="stylesheet" href="/assets/course.css"><script>if (new URLSearchParams(window.location.search).get('embedded') === '1') document.documentElement.classList.add('embedded-page');</script></head>
<body><a class="skip-link" href="#contenido">Saltar al contenido</a><header class="site-header"><div class="header-inner"><a class="brand" href="/">$siteTitle</a><nav aria-label="$navigationLabel"><a href="/">Inicio</a><a href="/aula.html">Aula</a><a href="/guia-reutilizacion.html">$guideLabel</a><a href="/licencias-y-atribuciones.html">Licencias</a></nav></div></header>$main<footer class="site-footer"><p>$footerTitle</p><p>Fuentes: <a href="/fuentes/README.html">inventario de fuentes</a>.</p></footer></body></html>
"@
    $page = Convert-LocalLinks $page
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Destination) | Out-Null
    [IO.File]::WriteAllText($Destination, $page, $utf8)
}

if (Test-Path -LiteralPath $Output) { Remove-Item -LiteralPath $Output -Recurse -Force }
New-Item -ItemType Directory -Force -Path $Output | Out-Null
foreach ($directory in @('assets', 'modulos_html')) { Copy-Item -LiteralPath (Join-Path $root $directory) -Destination (Join-Path $Output $directory) -Recurse }
Copy-Item -LiteralPath (Join-Path $root 'aula.html') -Destination (Join-Path $Output 'aula.html')
foreach ($page in @('index.md', 'guia-reutilizacion.md', 'evaluacion-final.md', 'licencias-y-atribuciones.md')) { Write-Page (Join-Path $root $page) (Join-Path $Output ($page -replace '\.md$', '.html')) }
$sourceDirectory = Join-Path $root 'fuentes'
$targetDirectory = Join-Path $Output 'fuentes'
if (Test-Path -LiteralPath $targetDirectory) { Remove-Item -LiteralPath $targetDirectory -Recurse -Force }
New-Item -ItemType Directory -Force -Path $targetDirectory | Out-Null
foreach ($sourceFile in Get-ChildItem -LiteralPath $sourceDirectory -File) {
    $targetFile = Join-Path $targetDirectory $sourceFile.Name
    New-Item -ItemType HardLink -Path $targetFile -Target $sourceFile.FullName | Out-Null
}
foreach ($page in @('README.md', 'actualizacion-fuentes-2026.md')) { Write-Page (Join-Path $sourceDirectory $page) (Join-Path $targetDirectory ($page -replace '\.md$', '.html')) }
Write-Output "Sitio local generado en: $Output"
