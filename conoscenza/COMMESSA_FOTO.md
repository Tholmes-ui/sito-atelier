# COMMESSA per la STILISTA (Space Bunny) — foto del carosello

Scritto da: Big Pickle (chat coding), 12/10/2026. Aggiornato il 12/10/2026
con il feedback del primo tentativo (leggi la sezione "⚠️ Feedback").
Destinataria: **Space Bunny** (chat immagini).
Ordine: il cliente (l'utente) ha deciso **formato panoramico 16:9**.

---

## ⚠️ Feedback del primo tentativo (IMPORTANTE)

Un tentativo automatico (sfondo allargato per ripetizione/stretching + versione
con **sfocatura**) è stato provato ed è **stato rifiutato dall'utente**:
"brutte da vedere". NIENTE di simile stavolta:

- ❌ **niente** sfondi sfocati, né "strisce allungate" ripetute o specchiate;
- ❌ **niente** bordi visibili della foto dentro l'immagine (la foto originale
  non deve "galleggiare" su uno sfondo diverso);
- ✅ il risultato deve sembrare **una foto vera scattata già larga**: stessa
  luce, stessi colori, stessa atmosfera su tutta l'immagine;
- ✅ se un lato va esteso, **disegnalo davvero** (outpainting reale: pavimento,
  parete, tenda, sfondo coerente con la scena) — non copiare una striscia.

## Il problema

Le foto attuali sono **verticali** (si vedono intere ma il carosello resta
vuoto ai lati, barre scure). Il sito le mostra in un riquadro **orizzontale**.
Soluzione decisa: **allargare lo sfondo ai lati fino alla proporzione 16:9**,
mantenendo il soggetto intero e centrato.

## Cosa fare, passo passo

1. Apri le immagini già pulite nella cartella `images\`:
   - `foto-1.jpg`, `foto-2.jpg`, `foto-3.jpg`, `foto-4.jpg`, `foto-5.jpg`
   - (le originali con le scritte in basso sono i file "WhatsApp Image ...",
     in caso servano come riferimento per sfondi/tessuti)
2. Per **ognuna** delle 5 foto, produci una versione **16:9** (es. 1600×900 px):
   - **estendi lo sfondo ai lati** in modo naturale (stesso stile, luce e
     colori della foto originale);
   - il **soggetto (il capo / l'oggetto / la scena) deve restare COMPLETO e CENTRATO**;
   - lascia un piccolo margine attorno al soggetto (mai attaccato al bordo);
   - **niente** scritte, loghi, filigrane o bordi aggiunti;
   - se estendendo lo sfondo il soggetto non ci sta (troppo grande), rimpicciolisci
     leggermente il soggetto o rifai il riquadro — **mai tagliare mani/capi**.
3. Salva il risultato **con lo STESSO nome e nella stessa cartella**,
   sovrascrivendo i file (stessa qualità alta, formato JPG):
   - `images\foto-1.jpg` → prima foto del carosello
   - `images\foto-2.jpg` → seconda
   - `images\foto-3.jpg` → terza
   - `images\foto-4.jpg` → quarta
   - `images\foto-5.jpg` → quinta
4. Mantieni l'ordine: la foto 1 resta la foto 1, ecc.

## Quello che NON serve fare

- Niente modifiche a `index.html` o `css\`: i file sono già collegati col nome
  `foto-1.jpg` … `foto-5.jpg`, basta sovrascrivere.
- Niente nuovi nomi di file (a meno che non sia proprio necessario: in quel
  caso scrivi i nuovi nomi nel diario e avvisa).

## Dopo aver finito

Avvisa l'utente (e/o scrivilo in `conoscenza\DIARIO.md`): Big Pickle (chat
coding) poi imposta il carosello su "cover" (riempimento completo) e verifica
anteprima.