# Sito Atelier — Sartoria e cucito su misura

Sito **single page** (una sola pagina che scorre verso il basso) diviso in 3 sezioni:

1. **Hero banner** con un carosello di 5 foto che scorre automaticamente da destra a sinistra.
2. **Contatti** con il modulo che invia le richieste di lavoro per email.
3. **Footer** con informazioni, orari e profili social.

È scritto in **HTML, CSS e JavaScript puri**: non serve installare niente per farlo funzionare, né per pubblicarlo.

---

## 1. Come vederlo subito sul tuo computer

Apri il file **`index.html`** con un doppio clic: si aprirà nel browser e vedrai il sito.

> Nota: alcune cose (come l'invio del modulo) funzionano solo una volta che il sito è online, non aprendolo dal disco. Per lo sviluppo va benissimo così.

---

## 2. Cosa personalizzare

Tutti i pezzi da cambiare sono evidenziati in **giallo** nella pagina. Sono racchiusi in questo modo:

```html
<span class="ph">Testo da sostituire</span>
```

Cerca nel file `index.html` la parola `ph` (o `class="ph"`) e sostituisci ogni volta il testo con quello vero. Quando hai finito, **non deve restare nessun evidenziato giallo**.

| Cosa | Dove | Valore finto attuale |
|---|---|---|
| Nome dell'attività | `index.html` (più punti) | `Nome` |
| Telefono | header contatti + footer | `+39 000 000 0000` |
| Email | sezione contatti + footer | `info@esempio.it` |
| Indirizzo | sezione contatti + footer | `Via Esempio 1, 00000 Città (XX)` |
| Orari | footer | `9:00 – 18:00` ecc. |
| Partita IVA | fondo pagina | `00000000000` |
| Link social | footer (`href`) | `instagram.com`, `facebook.com`… |
| Foto dei lavori | cartella `images/` | `foto-1.svg` … `foto-5.svg` |
| Chiave modulo email | `index.html` | `INSERISCI_QUI_LA_TUA_ACCESS_KEY` |

### Sostituire le foto dei lavori
Le 5 immagini sono in `images/`. Per mettere le foto vere hai due strade:

- **Semplice:** salva le tue foto con gli stessi nomi (`foto-1.jpg`, `foto-2.jpg`, …) e cambia in `index.html` l'estensione da `.svg` a `.jpg`.
- Oppure aggiungi le foto con nomi nuovi e aggiorna tutti gli `src="images/..."` nel carosello.

Consiglio: foto orizzontali e abbastanza grandi (almeno 1600×1000 pixel).

### Cambiare i colori
Apri `css/style.css` e modifica le variabili in cima (sezione **1. VARIABILI**). Ad esempio `--terracotta` è il colore principale.

---

## 3. Attivare l'invio delle email (Web3Forms)

Il sito è statico, quindi non può spedire email da solo. Usiamo **Web3Forms**: un servizio gratuito che riceve i dati del modulo e te li inoltra via email.

Passi:

1. Vai su **https://web3forms.com** e clicca *Get Access Key* (o *Create Access Key*).
2. Inserisci l'**email** dove vuoi ricevere le richieste (quella della signora).
3. Ti arriva subito per email una **Access Key** (una stringa tipo `a1b2c3d4-...`).
4. Apri `index.html`, cerca `INSERISCI_QUI_LA_TUA_ACCESS_KEY` e incolla la chiave al posto del testo.
5. Ricarica il sito: il modulo ora invia davvero.

Cosa succede: quando qualcuno compila il modulo, ricevi una email con nome, email, telefono, tipo di lavoro e messaggio. Il servizio gratuito consente **250 invii al mese**, più che sufficienti.

> In `index.html` c'è un campo nascosto chiamato `botcheck`: è un filtro anti-spam. **Non rimuoverlo.**

---

## 4. Mettere il sito online con GitHub Pages

### 4.1 Creare l'account GitHub (gratis)
1. Vai su **https://github.com/signup**
2. Scegli **username**, email e password. Il piano **Free** basta e avanza.
3. Conferma l'email.

### 4.2 Creare il "magazzino" online (repository)
1. Una volta dentro, clicca il **+** in alto a destra → *New repository*.
2. **Repository name**: ad esempio `sito-atelier`.
3. Lascia **Public** (necessario per GitHub Pages gratuito).
4. **Non** spuntare "Add a README".
5. Clicca **Create repository**.

GitHub ti mostrerà una pagina con dei comandi: copia l'indirizzo del repository, che sarà una cosa tipo `https://github.com/TUO-USERNAME/sito-atelier.git`.

### 4.3 Collegare questo progetto al repository
Apri il **Terminale** (o PowerShell) nella cartella del progetto. Se Git era appena installato, potrebbe servire **chiudere e riaprire il terminale**. Poi esegui questi comandi uno alla volta:

```bash
# Presentati a Git (una sola volta nella vita)
git config --global user.name "Il Tuo Nome"
git config --global user.email "tua@email.it"

# Collega questo progetto al tuo repository (sostituisci l'URL col tuo)
git remote add origin https://github.com/TUO-USERNAME/sito-atelier.git

# Carica tutto online
git push -u origin main
```

La prima volta Git ti chiederà di fare l'accesso a GitHub dal browser: autorizza e fine.

### 4.4 Attivare la pubblicazione
1. Nel repository, vai su **Settings** → **Pages** (menù a sinistra).
2. Alla voce *Branch*, scegli **main** e la cartella **/ (root)** → **Save**.
3. Aspetta 1-2 minuti. Il sito sarà online a questo indirizzo:

```
https://TUO-USERNAME.github.io/sito-atelier/
```

Ogni volta che in futuro modificherai il sito e farai `git push`, il sito online si aggiornerà da solo in un minuto circa.

---

## 5. I 3 comandi Git che userai sempre

Dopo aver modificato dei file:

```bash
git add .                          # prepara tutte le modifiche
git commit -m "Descrizione breve"  # scatta la "foto" con un messaggio
git push                           # carica online (backup)
```

Fine. Sono questi e basta, nella vita di tutti i giorni.

---

## 6. Struttura delle cartelle

```
Progetto predefinito/
├── index.html          → la pagina (testo, struttura, segnaposto)
├── css/
│   └── style.css       → colori, font, impaginazione
├── js/
│   └── main.js         → carosello + invio modulo
├── images/
│   ├── favicon.svg     → iconcina del browser
│   └── foto-1..5.svg   → foto segnaposto dei lavori
├── .gitignore          → file che Git deve ignorare
└── README.md           → questo documento
```

---

## 7. Domande frequenti

**Serve Node.js?** No. Ho scelto HTML/CSS/JS puri proprio per evitare installazioni.

**Quanto costa?** Sia GitHub Pages che Web3Forms (fino a 250 email/mese) sono **gratuiti**.

**Posso avere un indirizzo più bello di `…github.io`?** Sì: si compra un dominio (es. `ateliernome.it`) e si collega a GitHub Pages. Si fa in un secondo momento, quando vuoi.
