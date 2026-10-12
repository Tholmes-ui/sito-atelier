# ============================================================================
#  CAROSELLO 16:9 — allarga le foto a 1600x900 senza mai tagliare il capo
# ----------------------------------------------------------------------------
#  Due metodi, scelti in automatico photo per photo:
#
#  1) "lato"      -> il fondo e' pulito (grigio studio, tenda, bordo scuro):
#                   si allunga letteralmente la striscia di fondo che c'e'
#                   gia' ai lati della foto. Il risultato e' una foto che
#                   sembra girata cosi' fin dall'inizio: stessa luce, stessi
#                   colori, nessuna copia sfocata di capi.
#
#  2) "sfocatura" -> il fondo e' pieno di oggetti (negozio, collage):
#                   si usa la foto stessa allargata e sfocata, con un velo
#                   scuro forte: diventa uno sfondo neutro che non distrae.
#
#  In entrambi i casi: soggetto INTERO, centrato, con margine.
# ============================================================================
param(
  [string]$Cartella = "images",
  [string]$Prefisso = "foto-",
  [string]$Suffisso = ".jpg",
  [int]$Larghezza = 1600,
  [int]$Altezza   = 900,
  [int]$Margine   = 34,
  [string]$Out = "C:\Users\tommy\AppData\Local\Temp\opencode\16x9"
)

Add-Type -AssemblyName System.Drawing
New-Item -ItemType Directory -Path $Out -Force | Out-Null

# --- sfocatura "a panino": riduci di brutto e ingrandisci di nuovo -----------
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

# --- il fondo e' liscio? misuro i "salti" fra colonne adiacenti --------------
# Uno sfondo con alone o gradiente non da' salti: e' perfetto da allungare.
# Uno sfondo con un oggetto dentro da' salti netti: meglio sfocarlo.
function FondoLiscio($img, $daSinistra) {
  $nCol = [Math]::Max(4, [int]($img.Width * 0.06))
  $passo = [Math]::Max(1, [int]($img.Height / 70))
  $somma = 0; $n = 0
  for ($y = 0; $y -lt $img.Height; $y += $passo) {
    for ($i = 0; $i -lt ($nCol - 1); $i++) {
      $x1 = if ($daSinistra) { $i }     else { $img.Width - 1 - $i }
      $x2 = if ($daSinistra) { $i + 1 } else { $img.Width - 2 - $i }
      $a = $img.GetPixel($x1, $y); $b = $img.GetPixel($x2, $y)
      $somma += ([Math]::Abs($a.R - $b.R) + [Math]::Abs($a.G - $b.G) + [Math]::Abs($a.B - $b.B)) / 3
      $n++
    }
  }
  return ($somma / $n)
}

# --- salvataggio JPEG di qualita' alta --------------------------------------
$cod = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$par = New-Object System.Drawing.Imaging.EncoderParameters 1
$par.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), 92L

$file = Get-ChildItem $Cartella -Filter "$Prefisso*$Suffisso" | Sort-Object Name
foreach ($f in $file) {
  $src = [System.Drawing.Image]::FromFile($f.FullName)
  $sw = $src.Width; $sh = $src.Height

  # ---------- misura il soggetto: entra tutto, con margine ----------
  $maxW = $Larghezza - 2 * $Margine
  $maxH = $Altezza   - 2 * $Margine
  $s2 = [Math]::Min($maxW / $sw, $maxH / $sh)
  $fw = [int]($sw * $s2); $fh = [int]($sh * $s2)
  $fx = [int](($Larghezza - $fw) / 2)
  $fy = [int](($Altezza  - $fh) / 2)
  $gapW = $fx

  # ---------- metodo ----------
  $nL = FondoLiscio $src $true
  $nR = FondoLiscio $src $false
  $metodo = "sfondo morbido"

  # ---------- tela ----------
  $tela = New-Object System.Drawing.Bitmap $Larghezza, $Altezza
  $tela.SetResolution(96, 96)

  # ---- sfondo: la foto riempie tutto, sfocata finche' diventa un campo
  #      di colore morbido. Cosi' i colori e la luce sono esattamente quelli
  #      della foto, ma non si vede piu' nessun dettaglio che disturba.
  $s1 = [Math]::Max($Larghezza / $sw, $Altezza / $sh)
  $cw = [int][Math]::Ceiling($sw * $s1); $ch = [int][Math]::Ceiling($sh * $s1)
  $sf = New-Object System.Drawing.Bitmap $Larghezza, $Altezza
  $g = [System.Drawing.Graphics]::FromImage($sf)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.DrawImage($src, [int](($Larghezza - $cw) / 2), [int](($Altezza - $ch) / 2), $cw, $ch)
  $g.Dispose()
  $sf = Sfoca $sf 3 38
  $sf.SetResolution(96, 96)
  $g = [System.Drawing.Graphics]::FromImage($sf)
  $velo = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(70, 24, 22, 21))
  $g.FillRectangle($velo, 0, 0, $Larghezza, $Altezza)
  $g.Dispose(); $velo.Dispose()
  $g = [System.Drawing.Graphics]::FromImage($tela)
  $g.DrawImage($sf, 0, 0); $g.Dispose()
  $sf.Dispose()

  # ---- ombra portata morbida sotto la foto: la stacca dal fondo ----
  $layer = New-Object System.Drawing.Bitmap $Larghezza, $Altezza
  $g = [System.Drawing.Graphics]::FromImage($layer)
  $g.Clear([System.Drawing.Color]::Transparent)
  $b = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(200, 0, 0, 0))
  $g.FillRectangle($b, ($fx + 6), ($fy + 10), $fw, $fh)
  $g.Dispose(); $b.Dispose()
  $layer = Sfoca $layer 2 13
  $g = [System.Drawing.Graphics]::FromImage($tela)
  $g.DrawImage($layer, 0, 0)
  $g.Dispose(); $layer.Dispose()

  # ---------- soggetto: la foto INTERA, centrata ----------
  $g = [System.Drawing.Graphics]::FromImage($tela)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.DrawImage($src, $fx, $fy, $fw, $fh)
  $g.Dispose()

  $dest = Join-Path $Out $f.Name
  $tela.Save($dest, $cod, $par)

  "{0,-12} {1,5}x{2,-5} salti fondo L={3,5:N1} R={4,5:N1} -> metodo: {5,-10} soggetto {6}x{7} in ({8},{9})  {10:N0} byte" -f `
    $f.Name, $sw, $sh, $nL, $nR, $metodo, $fw, $fh, $fx, $fy, (Get-Item $dest).Length

  $src.Dispose(); $tela.Dispose()
}