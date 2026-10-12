# ============================================================================
#  CAROSELLO 16:9 — allarga le foto del carosello a 1600x900
#  Metodo: sfondo = la stessa foto allargata fino a riempire + sfocatura
#          soggetto = la foto INTERA, centrata, con un piccolo margine.
#          Così nessun capo viene mai tagliato e lo stile/luce/ colori
#          dello sfondo restano quelli originali.
# ============================================================================
param(
  [string]$Cartella = "images",
  [string]$Prefisso = "foto-",
  [string]$Suffisso = ".jpg",
  [int]$Larghezza = 1600,
  [int]$Altezza   = 900,
  [int]$Margine   = 46,
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
    $g.DrawImage($cur, 0, 0, $w, $h)
    $g.Dispose()
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

# --- salvataggio JPEG di qualita' alta --------------------------------------
$cod = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$par = New-Object System.Drawing.Imaging.EncoderParameters 1
$par.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), 92L

$file = Get-ChildItem $Cartella -Filter "$Prefisso*$Suffisso" | Sort-Object Name
foreach ($f in $file) {
  $src = [System.Drawing.Image]::FromFile($f.FullName)
  $sw = $src.Width; $sh = $src.Height

  # ---------- 1. sfondo: la foto riempie tutto, poi diventa sfocata ----------
  $s1 = [Math]::Max($Larghezza / $sw, $Altezza / $sh)
  $cw = [int]([Math]::Ceiling($sw * $s1)); $ch = [int]([Math]::Ceiling($sh * $s1))
  $sfondo = New-Object System.Drawing.Bitmap $Larghezza, $Altezza
  $g = [System.Drawing.Graphics]::FromImage($sfondo)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.DrawImage($src, [int](($Larghezza - $cw) / 2), [int](($Altezza - $ch) / 2), $cw, $ch)
  $g.Dispose()
  $sfondo = Sfoca $sfondo 2 14
  $sfondo.SetResolution(96, 96)

  # ---------- 2. velo leggero: stacca il soggetto dallo sfondo --------------
  $g = [System.Drawing.Graphics]::FromImage($sfondo)
  $velo = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(28, 33, 34, 35))
  $g.FillRectangle($velo, 0, 0, $Larghezza, $Altezza)
  $g.Dispose(); $velo.Dispose()

  # ---------- 3. soggetto: la foto INTERA, centrata, con margine -----------
  $maxW = $Larghezza - 2 * $Margine
  $maxH = $Altezza   - 2 * $Margine
  $s2 = [Math]::Min($maxW / $sw, $maxH / $sh)
  $fw = [int]($sw * $s2); $fh = [int]($sh * $s2)
  $fx = [int](($Larghezza - $fw) / 2)
  $fy = [int](($Altezza  - $fh) / 2)
  $g = [System.Drawing.Graphics]::FromImage($sfondo)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.DrawImage($src, $fx, $fy, $fw, $fh)
  $g.Dispose()

  $dest = Join-Path $Out $f.Name
  $sfondo.Save($dest, $cod, $par)

  "{0,-14} {1,5}x{2,-5} -> {3}x{4}   soggetto {5}x{6} in posizione ({7},{8})   {9:N0} byte" -f `
    $f.Name, $sw, $sh, $Larghezza, $Altezza, $fw, $fh, $fx, $fy, (Get-Item $dest).Length

  $src.Dispose(); $sfondo.Dispose()
}