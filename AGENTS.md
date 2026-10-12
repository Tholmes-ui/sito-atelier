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

- Ha studiato informatica ma **non è un esperto**: ha chiesto esplicitamente aiuto
  per non partire "da zero".
- **Spiega sempre con parole semplici e analogie concrete.** Se usi un termine
  tecnico, spiegalo in una riga, senza dare per scontato nulla.
- Lingua: **italiano**.
- Mostra i risultati in modo visibile (anteprima, verifica reale) invece di
  limitarti a dire che "funziona".

---

## 3. Come lavoriamo: due chat, un solo cervello

Il progetto usa **due sessioni OpenCode** che condividono la memoria tramite i file:

| Ruolo | Cosa fa | Dove scrive |
| --- | --- | --- |
| **COSTRUTTRICE** | Scrive e modifica il codice del sito | `index.html`, `css/`, `js/`, `images/` |
| **INSEGNANTE** | Spiega ciò che supera la comprensione attuale | `conoscenza/GLOSSARIO.md` |

Regole di collaborazione:

1. La chat **INSEGNANTE** scrive ogni concetto nuovo in `conoscenza/GLOSSARIO.md`,
   una voce per termine, con linguaggio semplice e un'analogia.
2. La chat **COSTRUTTRICE**, prima di prendere decisioni importanti, legge
   `conoscenza/DIARIO.md` per non contraddire quanto già deciso.
3. Dopo ogni avanzamento o decisione importante, **aggiorna
   `conoscenza/DIARIO.md`** (stato, decisioni, prossimi passi, domande aperte).
4. Se una delle due chat impara qualcosa di utile all'altra, **lo scrive su file**:
   è l'unico modo per "passarsi la memoria".

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
