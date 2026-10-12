# Foglio di confronto: versione A (sfondo sfumatura) e versione B
# (sfondo = foto sfocata). Serve all'utente per scegliere.
param(
  [string]$A = "C:\Users\tommy\AppData\Local\Temp\opencode\sfumatura",
  [string]$B = "C:\Users\tommy\AppData\Local\Temp\opencode\sfocata",
  [string]$Out = "C:\Users\tommy\AppData\Local\Temp\opencode\confronto-A-B.png",
  [int]$Col = 720
)
Add-Type -AssemblyName System.Drawing

$file = Get-ChildItem $A -Filter "foto-*.jpg" | Sort-Object Name
$h = [int]($Col * 9 / 16)
$gap = 14; $tit = 28
$W = ($Col * 2) + ($gap * 3)
$H = ($h + $tit + $gap) * $file.Count + $gap + $tit

$foglio = New-Object System.Drawing.Bitmap $W, $H
$g = [System.Drawing.Graphics]::FromImage($foglio)
$g.Clear([System.Drawing.Color]::FromArgb(20, 20, 22))
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

$fontT = New-Object System.Drawing.Font "Segoe UI", 17, ([System.Drawing.FontStyle]::Bold)
$fontS = New-Object System.Drawing.Font "Segoe UI", 12, ([System.Drawing.FontStyle]::Regular)
$cA = [System.Drawing.Brushes]::MediumSeaGreen
$cB = [System.Drawing.Brushes]::SteelBlue

$g.DrawString("VERSIONE A - sfondo sfumatura (foto NON sfocata)", $fontT, $cA, $gap, 6)
$g.DrawString("VERSIONE B - sfondo = foto sfocata (proporzioni corrette)", $fontT, $cB, ($gap * 2 + $Col), 6)

$y = $gap + $tit
foreach ($f in $file) {
  $nome = $f.Name
  $ia = [System.Drawing.Image]::FromFile((Join-Path $A $nome))
  $g.DrawImage($ia, $gap, ($y + $tit), $Col, $h)
  $g.DrawString($nome, $fontS, [System.Drawing.Brushes]::Silver, ($gap + $Col - 60), ($y + 6))
  $ia.Dispose()
  $ib = [System.Drawing.Image]::FromFile((Join-Path $B $nome))
  $g.DrawImage($ib, ($gap * 2 + $Col), ($y + $tit), $Col, $h)
  $ib.Dispose()
  $y += $h + $tit + $gap
}
$g.Dispose()
$foglio.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
$foglio.Dispose(); $fontT.Dispose(); $fontS.Dispose()
"confronto creato: $Out"