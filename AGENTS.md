# Istruzioni per OpenCode — Progetto "Sito Atelier"

Questo file è la **memoria condivisa** del progetto: tutte le sessioni OpenCode
aperte in questa cartella lo leggono automaticamente all'avvio.

---

## 1. Che cos'è questo progetto

Sito web **single page** per un'attività di sartoria / cucito su misura.
Per la descrizione completa vedi `README.md`.

- **Tecnologie**: HTML, CSS e JavaScript puri. Nessun framework, nessun Node.js.
- **Cartella di lavoro**: `C:\Users\tommy\Documents\Progetto predefinito`
- **Repository GitHub**: https://github.com/Tholmes-ui/sito-atelier
- **Sito online**: https://tholmes-ui.github.io/sito-atelier/
  (GitHub Pages, pubblicato dal branch `main`, cartella root)
- **Struttura**:

```
index.html            la pagina (3 sezioni: lavori, contatti, footer)
css/style.css         stili (colori e font nelle variabili in cima al file)
js/main.js            carosello + invio del modulo
images/               foto dei lavori (segnaposto) + favicon
conoscenza/           memoria condivisa (glossario + diario)
```

---

## 2. Chi è la persona con cui lavori

**Profilo (aggiornato dalla persona stessa, 12/10/2026):** studente di informatica
**neodiplomato**. Ha studiato informatica e ha imparato molto, ma il suo percorso
scolastico è stato turbolento (cambio di preside, professori in continuo
turnover): ci sono **argomenti saltati o appena accennati** dai programmi. Quindi:

- NON è un principiante assoluto: non serve spiegare le basi più elementari.
- **Attenzione agli argomenti "saltati"**: se un concetto è tipico dei programmi
  scolastici di informatica (reti, Git, CSS avanzato, funzioni JS, ecc.), non
  dare per scontato che lo conosca: chiedi o spiega in breve.
- **Usa linguaggio tecnico quando è utile**, ma per ogni termine "vuoto" dai una
  spiegazione in una riga con un'analogia concreta.
- Lingua: **italiano**.
- Mostra i risultati in modo visibile (anteprima, verifica reale) invece di
  limitarti a dire che "funziona".

---

## 3. Come lavoriamo: tre chat, un solo cervello

Il progetto usa **sessioni OpenCode** che condividono la memoria tramite i file.
Per consultarle velocemente, ogni chat ha un **nomignolo simpatico accanto al
nome del modello** (aggiornato dall'utente il 12/10/2026; niente riferimenti
alla sartoria). I nomi dei modelli restano la risposta ufficiale a "che
modelli usi?":

| Nomignolo simpatico | Modello | Ruolo | Cosa fa | Dove scrive |
| --- | --- | --- | --- | --- |
| **Sottaceto Digitale** 🥒 | Big Pickle | scrittore/codice | Scrive e modifica il codice del sito | `index.html`, `css/`, `js/`, `images/` |
| **Coniglietto Spaziale** 🐰 | Space Bunny | reparto immagini | Crea loghi, immagini e proposte grafiche | `images/`, `conoscenza/COMMESSA_FOTO.md`, `conoscenza/LOGO_SASTYLE.md` |
| **Prof. Felino** 🐈 | LongCat | insegnante/lezioni | Spiega i concetti, aggiorna il glossario | `conoscenza/GLOSSARIO.md` |

Regole di collaborazione:

1. La chat **INSEGNANTE** (Prof. Felino / LongCat) scrive ogni concetto nuovo in
   `conoscenza/GLOSSARIO.md`, una voce per termine, con linguaggio semplice e
   un'analogia.
2. La chat **COSTRUTTRICE** (Sottaceto Digitale / Big Pickle), prima di prendere
   decisioni importanti, legge `conoscenza/DIARIO.md` per non contraddire quanto
   già deciso.
3. Dopo ogni avanzamento o decisione importante, **aggiorna
   `conoscenza/DIARIO.md`** (stato, decisioni, prossimi passi, domande aperte).
4. Se una delle chat impara qualcosa di utile a un'altra, **lo scrive su file**:
   è l'unico modo per "passarsi la memoria".

### I file di memoria (cartella `conoscenza/`)

| File | Contenuto | Chi lo aggiorna |
| --- | --- | --- |
| `DATI_ATTIVITA.md` | **⭐ Fonte di verità dei contenuti**: nome, contatti, orari, social, foto. Va consultato **prima di qualsiasi modifica al sito**. | COSTRUTTRICE (Big Pickle) |
| `DATI_CLIENTE.md` | Il questionario (vuoto) da inviare alla cliente per raccogliere i dati | COSTRUTTRICE (Big Pickle) |
| `DIARIO.md` | Stato del progetto, decisioni prese, prossimi passi, domande aperte | COSTRUTTRICE (Big Pickle) |
| `GLOSSARIO.md` | Spiegazioni semplici dei termini, con analogie | INSEGNANTE (LongCat) |
| `LOGO_SASTYLE.md` | Descrizione del logo vero dell'insegna | REPARTO IMMAGINI (Space Bunny) |
| `CHIEDERE_SPIEGAZIONI.md` | Come formulare le domande per farsi spiegare bene le cose | — |

**Obbligo:** prima di modificare testi, contatti, orari o social sul sito,
leggi `conoscenza/DATI_ATTIVITA.md` e usa quei valori. Se un dato lì è
*mancante*, chiedilo all'utente invece di inventarlo.

---

## 4. Convenzioni sul codice

- I contenuti ancora da personalizzare sono **segnaposto** marcati con
  `class="ph"` (evidenziati in giallo nella pagina). Vanno sostituiti con i dati veri.
- Scrivi i **commenti in italiano**.
- **Non introdurre framework o dipendenze** senza chiedere prima.
- Mantieni struttura, stile e impaginazione già esistenti.

---

## 5. Pubblicare le modifiche

Dopo ogni modifica, per aggiornare il sito online:

```bash
git add .
git commit -m "breve descrizione della modifica"
git push
```

GitHub Pages si aggiorna da solo in circa un minuto.

---

## 6. In sospeso

Le cose ancora da fare sono elencate in `conoscenza/DIARIO.md`,
alla sezione **"Prossimi passi"**. Controlla lì prima di proporre nuovi lavori.
