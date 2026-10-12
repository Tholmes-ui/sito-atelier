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
6. **12/10/2026 — PROVA COLORI in corso**: palette cambiata con i colori del
   biglietto da visita (bianco, nero, grigio, fucsia). Vecchia palette salvata
   in un commento in cima a `css/style.css` per tornare indietro facilmente.
   Da valutare insieme all'utente; se approvata resta, altrimenti revert.
   - Header con **sfondo grigio scuro** (scala del nero) e testi chiari.
   - La **y** di "SàStyle" è **fucsia** sia nell'header sia nel footer.
7. **Effetto "si accende" sui contatti** (`js/main.js` → `initContactGlow` +
   CSS). Cliccando un link che porta a `#contatti` scatta un breve lampo fucsia:
   - link **"Contatti"** → si illumina la zona **recapiti** (telefono·email·WhatsApp);
   - link **"Richiedi (un) preventivo"** → si illumina il **modulo** da compilare.
   Il CSS distingue i due effetti: `@keyframes contattiLampo` (recapiti) e
   `@keyframes contattiLampoForm` (modulo, tramite pseudo-elemento `::after` che
   non disturba l'ombra del modulo). Rispetta "riduci animazioni". Verificato dal
   browser con test vero (nessun errore in console).
8. **12/10/2026 — OTTIMIZZAZIONE del codice** (solo pulizia, aspetto identico):
   - aggiunta `--accent-rgb` per non ripetere a mano il fucsia `rgba(230,0,126,…)`
     in 13 punti; `--gold` ora rimanda a `--terracotta`;
   - rimossi **codice morto** (`@keyframes heroZoom`, `.hero-slide.is-active img`)
     e variabili mai usate (`--sand-2`, `--shadow-soft`);
   - uniti due blocchi `.contact-facts` e portato `position: relative` dentro
     `.contact-form`;
   - JS: tolto il doppione `restart()` (=`start()`) e passato il modulo a
     `initContactGlow(form)` evitando una seconda ricerca nel DOM.
   Verificato nel browser: colori giusti, nessun errore, carosello e lampi OK.

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
   ⏳ **RINVIATA (12/10/2026)**: l'utente **ha accesso alla Gmail dell'atelier**
   (`laboratorio.sastyle@gmail.com`), quindi la crea lui — ma **oggi non si fa**.
   → vedi voce dedicata più sotto (con i passi).
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
- [x] **WhatsApp**: ✅ **confermato dalla cliente (12/10/2026)** — è lo stesso
      numero del telefono (`+39 331 357 5006`, link `wa.me/393313575006`).
      Il sito già lo usa, nessuna modifica necessaria.
- [ ] **Link pagina Facebook**: ancora mancante — **lo cerca l'utente di persona**
      (aprire la pagina e copiare l'indirizzo dalla barra del browser).
      Temporaneamente porta alla home di Facebook.
- [x] **Icone social rifatte** (12/10/2026): WhatsApp e TikTok **non erano
      riconoscibili** (WhatsApp = fumetto vuoto; TikTok = nota musicale
      generica). Rifatte in **line-art** con i tracciati ufficiali **Tabler**,
      stesso stile a tratto 24×24 di Instagram/Facebook (stroke 1.7):
      WhatsApp ora ha la **cornetta dentro il fumetto**, TikTok la **nota "d"**
      del marchio. Corretta anche la **stessa icona WhatsApp nella sezione
      contatti** (era identica a quella sbagliata). Instagram e Facebook
      invariati. Verificato nel browser misurando i `getBBox` (tracciati non
      vuoti) e con una pagina di anteprima prima/dopo.
- [x] **Titoli del footer in fucsia** (12/10/2026): "Dove trovarmi", "Come
      lavoriamo" e "Link utili" passano da **bianco** a **fucsia** in
      `css/style.css` (`.footer-col h3` → `color: var(--terracotta)`, #E6007E).
      Verificato nel browser: colore calcolato `rgb(230, 0, 126)` su tutti e tre.
- [x] **Orari**: la cliente non vuole orari specifici (su appuntamento). Ha
      indicato la disponibilità generale **nei giorni lavorativi lun–ven**.
      Il sabato (su richiesta) esiste ma **per ora non si pubblica** (richiesta
      della cliente, 12/10/2026). Footer: "Disponibilità: dal lunedì al
      venerdì". Aggiornati `DATI_ATTIVITA.md` e sito.
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
- [x] **DUE VERSIONI DEL CAROSELLO** (12 ottobre 2026, Coniglietto Spaziale,
      su richiesta dell'utente): entrambe **1600 x 900**, capo intero e
      centrato, nessuna distorsione.
      - **Versione A** `images/foto-1.jpg` ... `foto-5.jpg` — sfondo **sfumatura**
        costruita con i colori della foto (media del bordo) + alone in alto.
        Piu' sobria, "da studio".
      - **Versione B** `images/foto-1-sfocata.jpg` ... `foto-5-sfocata.jpg` —
        sfondo = **la foto stessa sfocata**. Perche' non risulti distorta:
        (1) non si stira mai, si ritaglia il pezzo centrale con il rettangolo
        sorgente esplicito; (2) si sfoca **prima** di ingrandiare (riduzione a
        96x54, che fa la media dei colori) e solo dopo si riporta a 1600x900,
        cosi' spariscono le sagome dei cappotti; (3) velo color crema del sito
        per stemperare il contrasto.
      ✅ **Installata nel sito la versione B** (12/10, su richiesta dell'utente):
      `foto-1.jpg`...`foto-5.jpg` = sfondo sfocato; la versione A e' conservata
      come `foto-N-sfumatura.jpg`. Per tornare ad A basta copiare i file
      `-sfumatura` sopra `foto-N.jpg`.
      ✅ **CSS sistemato** in `css/style.css`:
      - `.hero-slide img { object-fit: cover }` (desktop): il 16:9 riempie la
        hero senza bande nere, tagliando solo il fondo generato;
      - `@media (max-width: 1000px) { object-fit: contain }`: sotto i 1000 px il
        ritaglio laterale crescerebbe troppo (13% per lato a 1000 px, 17% a
        900 px) e toccherebbe i capi di foto-4, che occupa dal 16% al 84% della
        larghezza. Meglio bande che abiti tagliati.
      Verificato dal vivo nel browser: 5/5 immagini caricate a 1600x900, desktop
      = cover senza letterbox, sotto 1000 px = contain.
      Comandi: `16x9.ps1 -TipoSfondo sfumatura|foto -Cartella <orig> -Out <dest>`.
      Attenzione: per rifare le foto servono gli **originali verticali**,
      recuperabili con `git show 9f8e1e7:images/foto-1.jpg > file`, perche' le
      16:9 hanno sovrascritto gli originali nella cartella di lavoro.

- [x] **FOTO CAROSELLO 16:9** (12 ottobre 2026, **Coniglietto Spaziale** /
      Space Bunny, su commessa di `COMMESSA_FOTO.md`): tutte e 5 le foto in
      `images/` sono ora **1600 x 900 px (16:9)**, sovrascritte con lo stesso
      nome e nello stesso ordine (foto 1 = foto 1, ecc.).
      - Sfondo: **sfumatura pulita costruita con i colori della foto stessa**
        (media dei pixel del bordo) + alone luminoso in alto + ombra portata
        morbida sotto la foto. Stesso stile, stessa luce, stessi colori.
      - Il **soggetto e' intero e centrato**, con margine di 34 px: nessun
        capo, nessuna maniglia e nessun bordo e' stato tagliato.
      - Nessuna scritta, logo, filigrana o bordo aggiunto.
      - Scartati due metodi peggiori: allungare le fasce laterali della foto
        (riproduceva pellicce e muri del negozio "strisciati") e sfondo sfocato
        (lasciava fantasmi sfocati dei capi). Rischio: 6 prove, 2 metodi persi.
      Da fare ora (Big Pickle): in `css/style.css` riga 236 c'e' ancora
      `object-fit: contain` sulle foto del carosello. Con `contain` la foto
      16:9 appare intera, ma il riquadro della hero e' piu' alto, quindi
      restano fasce scure sopra e sotto. Passando a **`cover`** si elimina la
      letterbox: `cover` taglia i bordi della foto, che qui e' solo sfondo
      generato (i capi restano interi).
      Script usati: `conoscenza\script\16x9.ps1` (converte le foto) e
      `conoscenza\script\provino.ps1` (compila il provino con tutte e 5 le
      foto da controllare). Originali recuperabili con `git checkout -- images/`.

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
- [ ] **Chiave Web3Forms — RINVIATA** (12/10/2026): è **l'ultimo pezzo che
      manca** perché il modulo invii davvero le email (per ora il modulo resta
      "muto"). L'utente **ha accesso alla Gmail dell'atelier**
      (`laboratorio.sastyle@gmail.com`) e la creerà lui; **oggi non si è fatto**.
      Come si fa, per non dimenticarselo:
      1. web3forms.com → **Create your Form — Free**;
      2. email: `laboratorio.sastyle@gmail.com`;
      3. confermare col **link che arriva nella Gmail** (controllare anche
         **Spam** e **Promozioni**);
      4. copiare la **Access Key** (formato `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`);
      5. incollarla in `index.html` **riga 171** al posto di
         `INSERISCI_QUI_LA_TUA_ACCESS_KEY`;
      6. provare un invio di prova e pubblicare.
      ℹ️ La chiave **non è segreta**: è solo l'alias della email, si può mettere
      in chiaro nel sito senza rischi. Piano gratis = 250 invii/mese.
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
- [x] **NUOVO TENTATIVO in corso** (12/10/2026): Space Bunny sta rifacendo le
      foto con **outpainting vero** (estensione disegnata, non sfocata).
      Feedback del primo tentativo aggiunto alla commessa. Quando consegna:
      1. sostituire `images/foto-1…5.jpg` con le nuove 16:9;
      2. rimettere `object-fit: cover` nel CSS;
      3. anteprima e push.
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
