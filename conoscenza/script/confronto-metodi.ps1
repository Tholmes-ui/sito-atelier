# Confronto: il metodo BOCCIATO (immagine ingrandita + blur, che si distorce)
# contro il metodo NUOVO (sfumatura costruita con i colori della foto).
# Serve solo a far vedere la differenza: non scrive niente in images/.
param(
  [string]$Foto = @("foto-1.jpg", "foto-5.jpg"),
  [string]$Cartella = "images",
  [string]$Out = "C:\Users\tommy\AppData\Local\Temp\opencode\confronto-metodi.png",
  [int]$L = 720, [int]$H = 405
)
Add-Type -AssemblyName System.Drawing

function Sfoca($bmp, $Passi, $Fattore) {
  $cur = $bmp
  for ($i = 0; $i -lt $Passi; $i++) {
    $w = [Math]::Max(1, [int]($cur.Width  / $Fattore))
    $h = [Math]::Max(1, [int]($cur.Height / $Fattore))
    $pic = New-Object System.Drawing.Bitmap $w, $h
    $g  = [System.Drawing.Graphics]::FromImage($pic)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($cur, 0, 0, $w, $h); $g.Dispose()
    $big = New-Object System.Drawing.Bitmap $cur.Width, $cur.Height
    $g2 = [System.Drawing.Graphics]::FromImage($big)
    $g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g2.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g2.DrawImage($pic, 0, 0, $cur.Width, $cur.Height)
    $g2.Dispose(); $pic.Dispose()
    if ($cur -ne $bmp) { $cur.Dispose() }
    $cur = $big
  }
  return $cur
}

function ColoreBordo($img, $Pct) {
  $t = [Math]::Max(2, [int]([Math]::Min($img.Width, $img.Height) * $Pct))
  $passo = [Math]::Max(1, [int]($img.Height / 80))
  $sr = 0; $sg = 0; $sb = 0; $n = 0
  for ($y = 0; $y -lt $img.Height; $y += $passo) {
    for ($x = 0; $x -lt $img.Width; $x += $passo) {
      if (($x -lt $t) -or ($x -ge ($img.Width - $t)) -or ($y -lt $t) -or ($y -ge ($img.Height - $t))) {
        $c = $img.GetPixel($x, $y); $sr += $c.R; $sg += $c.G; $sb += $c.B; $n++
      }
    }
  }
  if ($n -eq 0) { return @(128,128,128) }
  return @([int]($sr/$n), [int]($sg/$n), [int]($sb/$n))
}

$cod = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }

$gap = 12; $tit = 30
$font  = New-Object System.Drawing.Font "Segoe UI", 14, ([System.Drawing.FontStyle]::Bold)
$fontS = New-Object System.Drawing.Font "Segoe UI", 12, ([System.Drawing.FontStyle]::Regular)
$rosso = [System.Drawing.Brushes]::Tomato
$verde = [System.Drawing.Brushes]::MediumSeaGreen

$alto = 0
foreach ($n in $Foto) { $alto += ($tit + $H + $tit + $H + $gap) }
$alto += $gap
$foglio = New-Object System.Drawing.Bitmap $L, $alto
$g = [System.Drawing.Graphics]::FromImage($foglio)
$g.Clear([System.Drawing.Color]::FromArgb(22, 22, 24))

$y = $gap
foreach ($n in $Foto) {
  $path = Join-Path $Cartella $n
  if (-not (Test-Path $path)) { continue }
  $src = [System.Drawing.Image]::FromFile((Resolve-Path $path).Path)
  $sw = $src.Width; $sh = $src.Height
  $maxW = $L - 68; $maxH = $H - 68
  $s2 = [Math]::Min($maxW / $sw, $maxH / $sh)
  $fw = [int]($sw * $s2); $fh = [int]($sh * $s2)
  $fx = [int](($L - $fw) / 2); $fy = 34

  foreach ($modo in @("vecchio", "nuovo")) {
    $tela = New-Object System.Drawing.Bitmap $L, $H
    if ($modo -eq "vecchio") {
      $s1 = [Math]::Max($L / $sw, $H / $sh)
      $cw = [int][Math]::Ceiling($sw * $s1); $ch = [int][Math]::Ceiling($sh * $s1)
      $sf = New-Object System.Drawing.Bitmap $L, $H
      $g2 = [System.Drawing.Graphics]::FromImage($sf)
      $g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
      $g2.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
      $g2.DrawImage($src, [int](($L - $cw)/2), [int](($H - $ch)/2), $cw, $ch)
      $g2.Dispose()
      $sf = Sfoca $sf 2 16
      $g2 = [System.Drawing.Graphics]::FromImage($sf)
      $v = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(150, 26, 24, 24))
      $g2.FillRectangle($v, 0, 0, $L, $H); $g2.Dispose(); $v.Dispose()
      $g2 = [System.Drawing.Graphics]::FromImage($tela); $g2.DrawImage($sf, 0, 0); $g2.Dispose(); $sf.Dispose()
    } else {
      $bc = ColoreBordo $src 0.09
      $chiaro = [System.Drawing.Color]::FromArgb(255, [Math]::Min(255,[int]($bc[0]*1.16)+8), [Math]::Min(255,[int]($bc[1]*1.16)+8), [Math]::Min(255,[int]($bc[2]*1.16)+8))
      $scuro  = [System.Drawing.Color]::FromArgb(255, [int]($bc[0]*0.72), [int]($bc[1]*0.72), [int]($bc[2]*0.72))
      $g2 = [System.Drawing.Graphics]::FromImage($tela)
      $rect = [System.Drawing.Rectangle]::new(0, 0, $L, $H)
      $sfum = [System.Drawing.Drawing2D.LinearGradientBrush]::new($rect, $chiaro, $scuro, 90)
      $g2.FillRectangle($sfum, $rect)
      $rA = [System.Drawing.Rectangle]::new(0, [int](-$H*0.30), $L, [int]($H*1.05))
      $sf2 = [System.Drawing.Drawing2D.LinearGradientBrush]::new($rA, [System.Drawing.Color]::FromArgb(58,255,255,255), [System.Drawing.Color]::FromArgb(0,255,255,255), [System.Drawing.Drawing2D.LinearGradientMode]::Vertical)
      $g2.FillRectangle($sf2, $rA); $g2.Dispose(); $sfum.Dispose(); $sf2.Dispose()
      $layer = New-Object System.Drawing.Bitmap $L, $H
      $g3 = [System.Drawing.Graphics]::FromImage($layer)
      $g3.Clear([System.Drawing.Color]::Transparent)
      $b = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(200,0,0,0))
      $g3.FillRectangle($b, ($fx+6), ($fy+10), $fw, $fh); $g3.Dispose(); $b.Dispose()
      $layer = Sfoca $layer 2 13
      $g3 = [System.Drawing.Graphics]::FromImage($tela); $g3.DrawImage($layer,0,0); $g3.Dispose(); $layer.Dispose()
      $g4 = [System.Drawing.Graphics]::FromImage($tela)
      $g4.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
      $g4.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
      $g4.DrawImage($src, $fx, $fy, $fw, $fh); $g4.Dispose()
    }
    $g.DrawImage($tela, 0, $y + $tit)
    $g.DrawString(
      $(if ($modo -eq "vecchio") { "PRIMA (boccciato) - immagine ingrandita + blur: si distorce" } else { "ADESSO - sfumatura costruita con i colori della foto: pulita" }),
      $font, $(if ($modo -eq "vecchio") { $rosso } else { $verde }), 6, ($y + 4))
    $g.DrawString($n, $fontS, [System.Drawing.Brushes]::Silver, ($L - 110), ($y + 8))
    $tela.Dispose()
    $y += $tit + $H
  }
  $y += $gap
}
$g.Dispose()
$foglio.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
$foglio.Dispose()
"confronto creato: $Out"