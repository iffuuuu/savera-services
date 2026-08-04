# Update sitemap.xml with all pages
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path '.').Path

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('<?xml version="1.0" encoding="UTF-8"?>')
[void]$sb.AppendLine('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">')
[void]$sb.AppendLine('')
[void]$sb.AppendLine('<url>')
[void]$sb.AppendLine('  <loc>https://saveraservices.com/</loc>')
[void]$sb.AppendLine('</url>')
[void]$sb.AppendLine('<url>')
[void]$sb.AppendLine('  <loc>https://saveraservices.com/index.html</loc>')
[void]$sb.AppendLine('</url>')

$main = @('AC-Repair-Pune','Fridge-Repair-Pune','Washing-Machine-Pune','TV-Repair-Pune','Microwave-Repair-Pune','Water-Pureifire-Repair','Cooler-Repair-Pune','genrator','employes/logain')
foreach ($m in $main) {
  [void]$sb.AppendLine('<url>')
  [void]$sb.AppendLine('  <loc>https://saveraservices.com/' + $m + '</loc>')
  [void]$sb.AppendLine('</url>')
}

$files = Get-ChildItem (Join-Path $root 'Area Pages') -Recurse -Filter *.html
$count = 0
foreach ($f in $files) {
  if ($f.Name -eq 'generate_pages.ps1') { continue }
  $areaPagesRoot = Join-Path $root 'Area Pages'
  $relPath = $f.FullName.Substring($areaPagesRoot.Length + 1)
  $folder = Split-Path $relPath -Parent
  $name = [System.IO.Path]::GetFileNameWithoutExtension($relPath)
  $urlFolder = $folder.Replace(' ','-')
  $loc = 'https://saveraservices.com/Area-Pages/' + $urlFolder + '/' + $name
  [void]$sb.AppendLine('<url>')
  [void]$sb.AppendLine('  <loc>' + $loc + '</loc>')
  [void]$sb.AppendLine('</url>')
  $count++
}

[void]$sb.AppendLine('')
[void]$sb.AppendLine('</urlset>')
[System.IO.File]::WriteAllText((Join-Path $root 'sitemap.xml'), $sb.ToString(), [System.Text.UTF8Encoding]::new($false))
Write-Host "Sitemap updated with $count area pages. Total URLs: $($count + 11)"

