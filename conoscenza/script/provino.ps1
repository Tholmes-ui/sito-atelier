# Crea un "provino": un unico file PNG con tutte le foto 16:9 impilate,
# cosi' l'utente può vederle tutte con un colpo d'occhio.
param(
  [string]$Cartella = "C:\Users\tommy\AppData\Local\Temp\opencode\16x9",
  [string]$Out = "C:\Users\tommy\AppData\Local\Temp\opencode\provino-16x9.png",
  [int]$Larghezza = 760
)
Add-Type -AssemblyName System.Drawing

$file = Get-ChildItem $Cartella -Filter "foto-*.jpg" | Sort-Object Name
if (-not $file) { "nessuna foto trovata in $Cartella"; exit }

$h = [int]($Larghezza * 9 / 16)
$gap = 14
$etichetta = 26
$n = $file.Count
$alto = ($h + $etichetta + $gap) * $n + $gap

$foglio = New-Object System.Drawing.Bitmap $Larghezza, $alto
$g = [System.Drawing.Graphics]::FromImage($foglio)
$g.Clear([System.Drawing.Color]::FromArgb(24, 24, 26))
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

$font = New-Object System.Drawing.Font "Segoe UI", 13, ([System.Drawing.FontStyle]::Bold)
$bco = [System.Drawing.Brushes]::White

$y = $gap
foreach ($f in $file) {
  $img = [System.Drawing.Image]::FromFile($f.FullName)
  $g.DrawString($f.Name, $font, $bco, 8, ($y - 2))
  $g.DrawImage($img, 0, ($y + $etichetta), $Larghezza, $h)
  $img.Dispose()
  $y += $h + $etichetta + $gap
}
$g.Dispose()

$foglio.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
$foglio.Dispose(); $font.Dispose()
"provino creato: $Out ({0:N0} byte)" -f (Get-Item $Out).Length