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
  [string]$SuffissoOut = "",
  [ValidateSet("sfumatura", "foto")]
  [string]$TipoSfondo = "sfumatura",
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

# --- il colore del fondo: media dei pixel del bordo esterno ------------------
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
  if ($n -eq 0) { return @(128, 128, 128) }
  return @([int]($sr / $n), [int]($sg / $n), [int]($sb / $n))
}

# --- salvataggio JPEG di qualita' alta --------------------------------------
$cod = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$par = New-Object System.Drawing.Imaging.EncoderParameters 1
$par.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), 92L

$file = Get-ChildItem $Cartella -Filter "$Prefisso*$Suffisso" | Sort-Object Name
foreach ($f in $file) {
  "LEGGO: {0}" -f $f.FullName
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

  if ($TipoSfondo -eq "sfumatura") {
    # ---- sfondo A: sfumatura pulita costruita con i colori della foto -----
    # niente "fantasmi" di capi sfocati: solo il colore e la luce della foto
    $bc = ColoreBordo $src 0.09
    $chiaro = [System.Drawing.Color]::FromArgb(255, [Math]::Min(255, [int]($bc[0] * 1.16) + 8), [Math]::Min(255, [int]($bc[1] * 1.16) + 8), [Math]::Min(255, [int]($bc[2] * 1.16) + 8))
    $scuro  = [System.Drawing.Color]::FromArgb(255, [int]($bc[0] * 0.72), [int]($bc[1] * 0.72), [int]($bc[2] * 0.72))
    $g = [System.Drawing.Graphics]::FromImage($tela)
    $rect = New-Object System.Drawing.Rectangle 0, 0, $Larghezza, $Altezza
    $sfum = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, $chiaro, $scuro, 90
    $g.FillRectangle($sfum, $rect)
    # alone luminoso dall'alto, come un fondo studio (copre tutta la larghezza,
    # altrimenti resta una banda piu' scura ai lati)
    $rAlone = [System.Drawing.Rectangle]::new(0, [int](-$Altezza * 0.30), $Larghezza, [int]($Altezza * 1.05))
    $sfum2 = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        $rAlone,
        [System.Drawing.Color]::FromArgb(58, 255, 255, 255),
        [System.Drawing.Color]::FromArgb(0, 255, 255, 255),
        [System.Drawing.Drawing2D.LinearGradientMode]::Vertical)
    $g.FillRectangle($sfum2, $rAlone)
    $g.Dispose(); $sfum.Dispose(); $sfum2.Dispose()
  } else {
    # ---- sfondo B: la stessa foto, sfocata, come fondo --------------------
    # Due regole perche' non risulti "distorto":
    #  1. non si stira MAI: si ritaglia il pezzo centrale con le proporzioni
    #     giuste (rettangolo sorgente esplicito), quindi la foto resta identica;
    #  2. si sfoca PRIMA di ingrandiare: si riduce a una manciata di pixel
    #     (che fa la media dei colori) e solo dopo si riporta a 1600x900.
    #     Cosi' sparisce ogni sagoma di cappotto: niente strisce, niente aloni.
    $s1 = [Math]::Max($Larghezza / $sw, $Altezza / $sh)
    $sxw = [Math]::Min($sw, $Larghezza / $s1)
    $sxh = [Math]::Min($sh, $Altezza  / $s1)
    $sxx = ($sw - $sxw) / 2
    $sxy = ($sh - $sxh) / 2

    $piccolo = New-Object System.Drawing.Bitmap 96, 54      # 96x54 = esattamente 16:9
    $piccolo.SetResolution(96, 96)
    $g = [System.Drawing.Graphics]::FromImage($piccolo)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.DrawImage($src,
      [System.Drawing.Rectangle]::new(0, 0, 96, 54),
      [System.Drawing.Rectangle]::new([int]$sxx, [int]$sxy, [int]$sxw, [int]$sxh),
      [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()

    $sf = New-Object System.Drawing.Bitmap $Larghezza, $Altezza
    $sf.SetResolution(96, 96)
    $g = [System.Drawing.Graphics]::FromImage($sf)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.DrawImage($piccolo, 0, 0, $Larghezza, $Altezza)
    $g.Dispose(); $piccolo.Dispose()

    # Velo color crema del sito: stemperia le sagome sfocate dei capi, cosi'
    # lo sfondo resta "la foto sfocata" ma non si vedono cappotti giganti.
    $g = [System.Drawing.Graphics]::FromImage($sf)
    $velo = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(120, 251, 247, 242))
    $g.FillRectangle($velo, 0, 0, $Larghezza, $Altezza)
    $g.Dispose(); $velo.Dispose()

    $g = [System.Drawing.Graphics]::FromImage($tela)
    $g.DrawImage($sf, 0, 0)
    $g.Dispose(); $sf.Dispose()
  }

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

  $dest = Join-Path $Out ($f.BaseName + $SuffissoOut + $f.Extension)
  $tela.Save($dest, $cod, $par)

  "{0,-22} sorgente {1,5}x{2,-5} sfondo: {3,-10} soggetto {4}x{5} in ({6},{7})  {8:N0} byte" -f `
    (Split-Path $dest -Leaf), $sw, $sh, $TipoSfondo, $fw, $fh, $fx, $fy, (Get-Item $dest).Length

  $src.Dispose(); $tela.Dispose()
}