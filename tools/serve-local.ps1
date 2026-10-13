param(
    [int]$Port = 8765,
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$rootPath = [IO.Path]::GetFullPath($Root).TrimEnd('\') + '\'
$listener = [Net.HttpListener]::new()
$listener.Prefixes.Add("http://127.0.0.1:$Port/")
$listener.Start()

$mime = @{
    '.html' = 'text/html; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.json' = 'application/json; charset=utf-8'
    '.txt'  = 'text/plain; charset=utf-8'
    '.pdf'  = 'application/pdf'
    '.ipynb' = 'application/json; charset=utf-8'
    '.mp4'  = 'video/mp4'
}

function Write-NotFound($Context) {
    $body = [Text.Encoding]::UTF8.GetBytes('Not found')
    $Context.Response.StatusCode = 404
    $Context.Response.ContentType = 'text/plain; charset=utf-8'
    $Context.Response.ContentLength64 = $body.Length
    $Context.Response.OutputStream.Write($body, 0, $body.Length)
}

Write-Output "Servidor REA activo en http://127.0.0.1:$Port/"
Write-Output 'Presiona Ctrl+C para detenerlo.'

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        try {
            $relative = [Uri]::UnescapeDataString($context.Request.Url.AbsolutePath.TrimStart('/'))
            if ([string]::IsNullOrWhiteSpace($relative)) { $relative = 'aula.html' }
            $candidate = [IO.Path]::GetFullPath((Join-Path $Root $relative))
            if (-not $candidate.StartsWith($rootPath, [StringComparison]::OrdinalIgnoreCase) -or -not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
                Write-NotFound $context
                continue
            }

            $file = [IO.FileInfo]::new($candidate)
            $extension = $file.Extension.ToLowerInvariant()
            $context.Response.ContentType = if ($mime.ContainsKey($extension)) { $mime[$extension] } else { 'application/octet-stream' }
            $context.Response.Headers.Add('Accept-Ranges', 'bytes')
            $start = 0L
            $end = $file.Length - 1L
            $range = $context.Request.Headers['Range']
            if ($range -and $range -match '^bytes=(\d*)-(\d*)$') {
                if ($Matches[1]) {
                    $start = [Int64]$Matches[1]
                    if ($Matches[2]) { $end = [Int64]$Matches[2] }
                } elseif ($Matches[2]) {
                    $start = [Math]::Max(0, $file.Length - [Int64]$Matches[2])
                }
                if ($start -gt $end -or $start -ge $file.Length) {
                    $context.Response.StatusCode = 416
                    $context.Response.Headers.Add('Content-Range', "bytes */$($file.Length)")
                    continue
                }
                $end = [Math]::Min($end, $file.Length - 1L)
                $context.Response.StatusCode = 206
                $context.Response.Headers.Add('Content-Range', "bytes $start-$end/$($file.Length)")
            }
            $length = $end - $start + 1L
            $context.Response.ContentLength64 = $length
            if ($context.Request.HttpMethod -eq 'HEAD') { continue }
            $stream = [IO.File]::OpenRead($file.FullName)
            try {
                $stream.Seek($start, [IO.SeekOrigin]::Begin) | Out-Null
                $buffer = New-Object byte[] 65536
                $remaining = $length
                while ($remaining -gt 0) {
                    $read = $stream.Read($buffer, 0, [Math]::Min($buffer.Length, $remaining))
                    if ($read -le 0) { break }
                    $context.Response.OutputStream.Write($buffer, 0, $read)
                    $remaining -= $read
                }
            } catch [IO.IOException] {
                Write-Verbose 'El cliente cerró la conexión antes de terminar la respuesta.'
            } catch [Net.HttpListenerException] {
                Write-Verbose 'El cliente cerró la conexión antes de terminar la respuesta.'
            } finally { $stream.Dispose() }
        } catch [Net.HttpListenerException] {
            Write-Verbose 'Solicitud cancelada por el cliente.'
        } catch [IO.IOException] {
            Write-Verbose 'Solicitud cancelada por el cliente.'
        } finally {
            $context.Response.Close()
        }
    }
} finally {
    $listener.Stop()
    $listener.Close()
}
