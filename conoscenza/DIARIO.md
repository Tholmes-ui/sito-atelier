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

## Prossimi passi (da fare)

1. **Sostituire i 14 segnaposto gialli** con i dati reali della signora:
   nome attività, telefono, email, indirizzo, orari, P.IVA, link social.
2. **Sostituire le 5 foto** `images/foto-1.svg` … `foto-5.svg` con le foto vere dei lavori.
3. **Creare la chiave Web3Forms** (https://web3forms.com) e incollarla in
   `index.html` al posto di `INSERISCI_QUI_LA_TUA_ACCESS_KEY`.
4. (Opzionale) Collegare un **dominio personalizzato** tipo `ateliernome.it`.

### Modifiche tecniche emerse man mano che arrivano i dati

- [ ] Rifare la casella **"Tipo di lavoro"** del modulo. ✔ voci già decise
      (vedi `DATI_ATTIVITA.md`), da applicare al codice.
- [ ] Aggiornare i testi della hero e la descrizione: non "sartoria generica"
      ma laboratorio specializzato in **pelle e pelliccia**.
- [ ] **Indirizzo privato**: nel footer la sezione "Dove trovarmi" deve perdere
      via e civico → resta solo **"Caselle Torinese (TO)"**, con nota
      **"Laboratorio privato — ricevimento su appuntamento"** (✔ confermato).
      Niente mappa.
- [ ] **Orari**: presentarli come *disponibilità*, non come orari di negozio
      (non c'è un negozio aperto al pubblico).
- [ ] **Come funziona (ritiro/consegna)**: aggiungere ai contatti una frase del
      tipo *"Mi porti il capo di persona, su appuntamento, e vieni a riprenderlo
      quando è pronto. Nessun ritiro a domicilio né spedizione."* ✔ dato confermato.

## Domande aperte (in attesa di risposta)

- Nome dell'attività e slogan?
- Contatti reali (telefono, email, indirizzo)?
- Orari di apertura e Partita IVA?
- Link ai profili social?
- Nomi dei file delle foto vere?
