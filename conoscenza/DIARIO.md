# Diario del progetto

A cura della chat **COSTRUTTRICE**, aggiornato dopo ogni decisione o avanzamento.
Le altre chat lo leggono per restare allineate.

---

## Stato attuale

Il sito è **completo e già online**: https://tholmes-ui.github.io/sito-atelier/

Funziona tutto (carosello, sezione contatti, footer). Mancano solo i **contenuti
veri**: al momento sono testi e foto segnaposto.

## Cos'è già stato fatto

1. Installato **Git** e avviato il repository `main`.
2. Creato il sito in HTML/CSS/JS puri:
   - Hero con carosello di 5 foto (scorrimento destra→sinistra, autoplay, frecce, swipe).
   - Sezione contatti con modulo pronto per **Web3Forms**.
   - Footer con info e social.
3. Creato l'account GitHub (`Tholmes-ui`) e il repository `sito-atelier`.
4. Primo commit caricato e **GitHub Pages attivato**: sito online e verificato (HTTP 200).
5. Creato il "cervello condiviso": `AGENTS.md` + questa cartella `conoscenza/`.

## Decisioni prese

- **Tecnologia**: HTML/CSS/JS puri (niente Node, niente framework) — scelta per
  semplicità e hosting gratuito.
- **Email**: servizio esterno **Web3Forms** (gratis, 250 invii/mese) invece di un
  backend.
- **Hosting**: **GitHub Pages**.
- **Identità Git**: `King7Master <73787711+Tholmes-ui@users.noreply.github.com>`
  (email privata di GitHub per non pubblicare la Gmail).

## Cosa ho imparato (appunti utili)

- ✅ **AGGIORNAMENTO 12/10/2026 — ORA LE FOTO SI VEDONO**: il modello
  **space-bunny-free** (quello attuale) **accetta immagini in ingresso** e le
  mostra davvero. Verificato leggendo `images/WhatsApp Image 2026-10-12 at 17.02.40.jpeg`
  (768x1376): si legge tutto il testo dell'insegna. Prima valeva solo per gli
  altri modelli gratuiti (longcat, mimo, step-5, ling, exo, nemotron, muse-spark),
  che invece non le accettavano.
  💡 **Regola pratica**: la chat e la memoria sono le stesse, cambia solo il
  "cervello". Se si torna su **Big Pickle** le immagini tornano invisibili →
  **per lavorare sulle foto restare su Space Bunny**.
- ✅ **Cosa so fare sulle immagini** (verificato):
  - vederle e leggerne il testo;
  - ritagliare, ridimensionare, comprimere, cambiare formato
    (JPEG/PNG) con PowerShell + `System.Drawing`;
  - creare disegni e loghi in **SVG** (scrivendo il codice, non con un'AI);
  - fare screenshot del sito.
  **Cosa NON so fare**: generare foto realistiche con l'AI (nessun modello
  di generazione immagini disponibile).
- ✅ **Trucco usato al posto della vista**: uno script PowerShell con l'**OCR**
  di Windows legge il **testo** dentro le immagini, e un altro script con
  `System.Drawing` ne campiona i **colori** e la luminosità.
- 🎨 **Il giudizio estetico è dell'utente**: lui prepara le proposte
  (`logo-prova.html`), l'utente le guarda e sceglie. Nessun modello serve.

## Prossimi passi (da fare)

1. **Sostituire le 5 foto** `images/foto-1.svg` … `foto-5.svg` con le foto vere dei lavori.
2. **Creare la chiave Web3Forms** (https://web3forms.com) e incollarla in
   `index.html` al posto di `INSERISCI_QUI_LA_TUA_ACCESS_KEY`.
3. (Opzionale) Collegare un **dominio personalizzato** tipo `sastylelab.it`.

### Modifiche tecniche emerse man mano che arrivano i dati

- [x] **Dati reali applicati al sito** (12 ottobre 2026): nome "SàStyle Lab",
      ragione sociale nel footer, slogan "Pelle · Pellicce · Accessori", servizi,
      telefono, email, "Caselle Torinese (TO)", "solo su appuntamento", social
      Instagram + TikTok, tendina "Tipo di lavoro" rifatta.
- [x] **Favicon nuova** (12/10/2026): **S fucsia (#E6007E) su sfondo nero**,
      font Palatino Linotype corsivo grassetto, resa in `images/favicon.png`
      (il vecchio `favicon.svg` con la S tratteggiata è stato rimosso).
- [x] **Nomignoli simpatici delle chat** (12/10/2026, aggiornati dall'utente —
      niente riferimenti alla sartoria): **Sottaceto Digitale** 🥒 = Big Pickle,
      scrittore/codice; **Coniglietto Spaziale** 🐰 = Space Bunny, reparto
      immagini; **Prof. Felino** 🐈 = LongCat, insegnante/lezioni. I nomi dei
      modelli restano la risposta ufficiale a "che modelli usi?".
- [ ] **Link pagina Facebook**: manca l'indirizzo esatto (nel codice c'è un
      commento che lo segnala). Temporaneamente porta alla home di Facebook.
- [ ] **WhatsApp**: si è usato lo stesso numero del telefono
      (`+39 331 357 5006`) — **da confermare** con la cliente.
- [ ] **Orari**: non disponibili. Per ora il footer dice "su appuntamento".
- [x] **Foto carosello** (12 ottobre 2026): sostituite con le foto inviate
      (ripulite dalle scritte in basso con un ritaglio automatico). ⚠️ **Nota:**
      sono **composizioni generate con Gemini**, NON foto reali dei lavori.
      Da valutare: sostituirle prima o poi con foto vere (fiducia dei clienti).
- [x] **Carosello: foto mostrate INTERE** (12 ottobre 2026): la cliente non
      voleva foto tagliate → `object-fit: contain` (foto intera, centrata sul
      fondo scuro) e via l'animazione di zoom che tagliava i bordi.
- [x] **Descrizione del logo vero** salvata da un'altra chat in
      `conoscenza/LOGO_SASTYLE.md` (font Playfair, oro champagne, manichino…).
      ⚠️ **Aggiornamento:** il file `images/logo-sastyle.svg` **ora esiste**
      (trovato nella cartella e committato). Da decidere se usarlo nell'header
      al posto della scritta semplice "SàStyle Lab".
- [x] **LOGO RICOSTRUITO** (12 ottobre 2026, questa chat): dalla foto
      dell'insegna è stato rifatto il logo intero in **SVG vettoriale**.
      - `images/logo-sastyle.svg` — versione **oro champagne** (per sfondi scuri)
      - `images/logo-sastyle-inchiostro.svg` — versione **nera** (per lo sfondo crema del sito)
      - `images/anteprima-logo-oro-su-scuro.png` e
        `images/anteprima-logo-inchiostro-su-crema.png` — le anteprime
      Le lettere **non sono testo**: sono disegnate (12 tracciati `<path>`,
      36 KB), quindi il file si vede uguale su ogni computer e si può
      ingrandire all'infinito senza perdere qualità. Font usati:
      **Playfair Display** (nome) e **Questrial** (testo piccolo).
      ⏳ **Non ancora usato nel sito**: header e footer mostrano ancora la
      scritta semplice "SàStyle Lab" in carattere.
- [ ] **P.IVA**: arriva più avanti (segnaposto rimasto in fondo pagina).
- [x] **Commessa foto per Space Bunny** (12/10/2026): l'utente ha deciso foto
      **panoramiche 16:9** (soggetto intero e centrato, sfondo esteso ai lati).
      Istruzioni pronte in `conoscenza/COMMESSA_FOTO.md` per Space Bunny.
      ⏳ In attesa: quando le nuove foto sono pronte, **tornare il carosello a
      `object-fit: cover`** (ora è `contain`) e fare anteprima.
- [x] **Foto 16:9 INSTALLATE → RIPRISTINATE** (12/10/2026): provate le foto
      rialargate a 1600×900 (script `conoscenza/script/16x9.ps1`, metodo
      automatico "lato"/"sfocatura") ma **all'utente non sono piaciute**
      ("brutte da vedere"). Tornati allo stato precedente: foto verticali
      originali e carosello a **`object-fit: contain`** (foto intere, niente
      tagli, ma barre scure ai lati su desktop). Lo script resta salvato per
      eventuali tentativi futuri; possibile alternativa: allargamento disegnato
      da Space Bunny (commessa in `conoscenza/COMMESSA_FOTO.md`).
- [ ] **Foto del carosello: attenzione alle proporzioni** (12 ottobre 2026).
      Le 5 foto hanno forme diverse: foto-1, 2, 3 e 5 sono **verticali**,
      **foto-4 è orizzontale** (1084x820). Nel carosello (che le mostra
      intere, `object-fit: contain`) foto-4 sembrerà più piccola e "strana"
      rispetto alle altre. Foto-2 e foto-3 hanno anche **scritte dentro**
      ("prima/dopo/Non ti piace più?", "Qualunque tipo di personalizzazione"):
      vanno bene per i social, meno per un sito.

## Come è stato fatto il logo (per non rifarlo da capo)

1. Dalla foto dell'insegna ho **misurato** la figura e i testi a occhio,
   riportando tutto in **proporzioni** (larghezza spalle, vita, fianchi, gambe).
2. Il generatore sta in `C:\Users\tommy\AppData\Local\Temp\opencode\logo-gen.html`.
   Scarica i font TrueType da Google, e con la libreria **opentype.js**
   **trasforma ogni lettera in un disegno** (così l'SVG non dipende dai font
   installati sul computer di chi visita il sito).
3. `rebuild.ps1` rimette dentro i font e ricostruisce la pagina;
   un piccolo server (`server2.ps1`, porta 8732) fa salvare i risultati.
4. `confronto.ps1` mette fianco a fianco la foto originale e la figura
   ridisegnata: è il modo più veloce per capire cosa correggere.
   ⚠️ Attenzione: i file in `%TEMP%\opencode` **si perdono** se il computer
   viene spento o il sistema pulisce i temporanei. Se serve, rigenerare.

## Domande aperte (in attesa di risposta)

- Nome dell'attività e slogan?
- Contatti reali (telefono, email, indirizzo)?
- Orari di apertura e Partita IVA?
- Link ai profili social?
- Nomi dei file delle foto vere?
