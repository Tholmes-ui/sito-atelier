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
- [x] Logo: **solo la parola**, niente forbice (decisione dell'utente).
- [ ] **Link pagina Facebook**: manca l'indirizzo esatto (nel codice c'è un
      commento che lo segnala). Temporaneamente porta alla home di Facebook.
- [ ] **WhatsApp**: si è usato lo stesso numero del telefono
      (`+39 331 357 5006`) — **da confermare** con la cliente.
- [ ] **Orari**: non disponibili. Per ora il footer dice "su appuntamento".
- [ ] **P.IVA**: arriva più avanti (segnaposto rimasto in fondo pagina).

## Domande aperte (in attesa di risposta)

- Nome dell'attività e slogan?
- Contatti reali (telefono, email, indirizzo)?
- Orari di apertura e Partita IVA?
- Link ai profili social?
- Nomi dei file delle foto vere?
