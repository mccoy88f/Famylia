# 📋 Companion App Familiare — Documento di Riferimento per l'AI di Sviluppo

> **Progetto:** Family Hub — App Web PWA per la gestione familiare
> **Stack:** Flutter Web (PWA) + Serverpod (Dart backend) + PostgreSQL + Redis + Docker
> **Target:** Famiglie, conviventi, coppie, genitori con figli

---

## 📌 Visione Prodotto

Una **companion app familiare** che centralizza la gestione domestica quotidiana: scadenze, spese, task, liste della spesa, pianificazione pasti, comunicazione e coordinamento. L'obiettivo è ridurre il carico cognitivo dei "manager familiari" (tipicamente un genitore) e distribuire responsabilità in modo equo e trasparente tra tutti i membri.

**Differenziatori chiave:**
- Self-hosted / privacy-first (dati familiari rimangono di proprietà)
- PWA installabile su mobile (nessun app store required)
- Real-time sync tra membri
- Offline-first (la lista spesa funziona senza rete)
- Location tracking con consenso esplicito (non parental control)

---

## 🏗️ Architettura Stack

| Livello | Tecnologia | Ruolo |
|---------|-----------|-------|
| **Frontend** | Flutter Web + PWA | UI responsive, installabile su iOS/Android |
| **Backend** | Serverpod (Dart) | API REST/WebSocket, ORM, auth, caching |
| **Database** | PostgreSQL | Dati relazionali, ACID, migrations |
| **Cache** | Redis | Sessioni, cache query, pub/sub real-time |
| **Storage** | MinIO (S3-compatibile) | Foto ricevute, documenti, avatar |
| **Container** | Docker + Docker Compose | Deploy con un solo comando |
| **Reverse Proxy** | Nginx | SSL termination, static files, rate limiting |

---

## 👤 Modello Utente & Famiglia

### Entità Principali

```
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│     USER        │◄─────►│     FAMILY      │◄─────►│   FAMILY_MEMBER  │
├─────────────────┤       ├─────────────────┤       ├─────────────────┤
│ id              │       │ id              │       │ id              │
│ email (unique)  │       │ name            │       │ user_id         │
│ name            │       │ invite_code     │       │ family_id       │
│ avatar_url      │       │ created_at      │       │ role            │
│ password_hash   │       │ settings JSON   │       │ joined_at       │
│ preferences     │       │                 │       │                 │
│ created_at      │       │                 │       │                 │
└─────────────────┘       └─────────────────┘       └─────────────────┘
```

### Ruoli Famiglia

| Ruolo | Permessi |
|-------|----------|
| **Admin** | Gestisce membri, modifica impostazioni, elimina dati, vede tutto |
| **Member** | Crea/modifica task, spese, liste; vede tutto della famiglia |
| **Guest** | Solo lettura (es: nonno che vuole vedere ma non modificare) |

### Multi-Famiglia
- Un utente può appartenere a **più famiglie** (es: separati/divorziati)
- Switch famiglia rapido dall'header
- Notifiche separate per ogni famiglia

---

## 🔐 Autenticazione & Sicurezza

### Metodi di Login
- Email + password (bcrypt)
- Google OAuth 2.0
- Apple Sign-In (per iOS users)
- Magic Link (passwordless, opzionale)

### Sicurezza
- JWT con refresh token rotation
- Rate limiting su login (5 tentativi / 15 min)
- 2FA opzionale per admin
- Row-level security (RLS) a livello database
- Crittografia AES-256 per documenti sensibili in storage
- GDPR: export dati completo, right to be forgotten

---

## 📅 Modulo: Scadenze & Bollette

### Entità

```
DEADLINE
├── id
├── family_id (FK)
├── created_by (FK → user)
├── title: "TARI 2026"
├── description: "Tassa rifiuti prima rata"
├── category: BILL | TAX | LICENSE | MEDICAL | CONTRACT | PERSONAL | OTHER
├── amount: 245.50 (nullable)
├── currency: EUR
├── due_date: 2026-06-15
├── is_recurring: true/false
├── recurrence_rule: "RRULE:FREQ=YEARLY;BYMONTH=6" (iCal format)
├── status: PENDING | PAID | OVERDUE | CANCELLED
├── priority: LOW | MEDIUM | HIGH | CRITICAL
├── assigned_to (FK → user, nullable)
├── notify_before_hours: [24, 72, 168] (array di preavvisi)
├── payment_method: BANK_TRANSFER | CASH | CARD | DIRECT_DEBIT | OTHER
├── receipt_image_url (FK → storage)
├── receipt_notes: "Pagato con bonifico XYZ"
├── tags: ["casa", "tasse"]
├── is_private: false (visibile solo al creatore se true)
├── completed_at (timestamp)
├── completed_by (FK → user)
├── created_at
└── updated_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Creazione scadenza** | Form con campi sopra elencati, autocomplete categorie |
| 2 | **Scadenze ricorrenti** | RRULE parser, generazione istanze future, modifica singola o serie |
| 3 | **Notifiche intelligenti** | Push/email in base a `notify_before_hours` + notifica OVERDUE |
| 4 | **Filtri e viste** | Per categoria, stato, assegnatario, mese; vista calendario e lista |
| 5 | **Allegato ricevuta** | Upload foto/scan, OCR automatico (estrazione importo/data), storage su MinIO |
| 6 | **Storico pagamenti** | Lista anno per anno, export PDF/Excel |
| 7 | **Duplicazione** | "Crea simile" per scadenze simili |
| 8 | **Condivisione selettiva** | Alcune scadenze private (es: terapia personale) |

### Vista Calendario Scadenze
- Heatmap mensile: giorni con scadenze colorati per priorità
- Vista settimanale con dettaglio
- Drag & drop per spostare scadenze

---

## 📸 Modulo: Ricevute & Documenti

### Entità

```
DOCUMENT
├── id
├── family_id (FK)
├── uploaded_by (FK → user)
├── title: "Ricevuta TARI 2026"
├── description
├── file_url (MinIO/S3)
├── file_type: IMAGE | PDF | OTHER
├── file_size_bytes
├── category: RECEIPT | INVOICE | CONTRACT | MEDICAL | WARRANTY | ID | OTHER
├── related_deadline_id (FK, nullable)
├── related_expense_id (FK, nullable)
├── ocr_data: { extracted_amount, extracted_date, extracted_merchant } (JSON)
├── tags: ["tari", "2026", "casa"]
├── is_encrypted: true/false
├── access_level: FAMILY | ADMIN_ONLY | PRIVATE
├── created_at
└── updated_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Upload multiplo** | Drag & drop, camera da mobile, scan da scanner |
| 2 | **OCR automatico** | Estrazione testo, importo, data, merchant (Tesseract / AWS Textract) |
| 3 | **Link automatico** | Suggerisce collegamento a scadenza/spesa esistente basato su OCR |
| 4 | **Organizzazione** | Cartelle virtuali per categoria, tag, data |
| 5 | **Ricerca full-text** | Nel titolo, descrizione, OCR text |
| 6 | **Preview** | Thumbnail per immagini, preview PDF embed |
| 7 | **Download & share** | Singolo file o batch ZIP |
| 8 | **Backup** | Export completo ogni N mesi |

---

## 💰 Modulo: Condivisione Spese

### Entità

```
EXPENSE
├── id
├── family_id (FK)
├── created_by (FK → user)
├── title: "Spesa settimanale"
├── description: "Esselunga del 25 maggio"
├── amount: 87.45
├── currency: EUR
├── category: GROCERY | BILLS | TRANSPORT | HEALTH | ENTERTAINMENT | HOME | EDUCATION | OTHER
├── paid_by (FK → user)
├── split_type: EQUAL | PERCENTAGE | EXACT | SHARES
├── split_details: [
│     { user_id: 1, amount: 43.72, percentage: 50 },
│     { user_id: 2, amount: 43.73, percentage: 50 }
│   ] (JSON)
├── receipt_image_url (nullable)
├── expense_date: 2026-05-25
├── is_recurring: false
├── status: ACTIVE | SETTLED | PENDING
├── settlement_id (FK, nullable)
├── tags: ["spesa", "esselunga"]
├── created_at
└── updated_at

SETTLEMENT
├── id
├── family_id (FK)
├── from_user (FK → user)
├── to_user (FK → user)
├── amount: 120.00
├── currency: EUR
├── status: PENDING | PAID | CANCELLED
├── payment_method: CASH | BANK_TRANSFER | PAYPAL | OTHER
├── payment_proof_url (nullable)
├── settled_at (nullable)
├── created_at
└── updated_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Registrazione spesa** | Form rapido con foto ricevuta, OCR auto-compila importo |
| 2 | **Split types** | Equo (50/50), Percentuale, Esatto, Quote (es: "Marco ha preso vino per tutti") |
| 3 | **Calcolo debiti netti** | Algoritmo di minimizzazione transazioni (es: A deve 10 a B, B deve 10 a C → A paga C) |
| 4 | **Vista bilancio** | Quanto ha pagato/speso ogni membro nel mese |
| 5 | **Reminder pagamenti** | "Marco ti deve €45 da 7 giorni" — notifica gentile |
| 6 | **Conferma settlement** | Mark as paid con upload proof (foto bonifico) |
| 7 | **Budget familiare** | Limite mensile per categoria, alert al 80% |
| 8 | **Report** | Grafici a torta/istogramma per categoria e membro, export CSV/PDF |
| 9 | **Multi-valuta** | Supporto EUR/USD/GBP con conversione automatica |
| 10 | **Spese ricorrenti** | Affitto, Netflix, palestra — auto-generazione mensile |

### Algoritmo Semplificazione Debiti
```
Input: lista di debiti parziali tra membri
Output: lista minima di transazioni per saldare tutto

Esempio:
- Anna ha pagato spesa €90 (split 3 persone: €30 ciascuno)
- Marco ha pagato benzina €60 (split 2 persone: €30 ciascuno)
- Luca deve €30 ad Anna e €30 a Marco

Semplificazione: Luca paga €60 ad Anna, Anna paga €30 a Marco
```

---

## ✅ Modulo: Todo & Compiti

### Entità

```
TODO_ITEM
├── id
├── family_id (FK)
├── created_by (FK → user)
├── title: "Passare aspirapolvere"
├── description: "Sala e cucina"
├── category: CLEANING | COOKING | SHOPPING | MAINTENANCE | KIDS | ADMIN | OTHER
├── priority: LOW | MEDIUM | HIGH | CRITICAL
├── status: PENDING | IN_PROGRESS | DONE | CANCELLED
├── assigned_to (FK → user, nullable)
├── due_date (nullable)
├── due_time (nullable)
├── is_recurring: false
├── recurrence_rule (nullable, RRULE)
├── estimated_minutes: 30
├── subtasks: [
│     { id: 1, title: "Sala", done: true },
│     { id: 2, title: "Cucina", done: false }
│   ] (JSON array)
├── checklist_template_id (nullable, FK)
├── points: 10 (gamification)
├── completed_at
├── completed_by (FK → user)
├── created_at
└── updated_at

TODO_TEMPLATE
├── id
├── family_id (FK, nullable — global se null)
├── name: "Pulizia settimanale"
├── category: CLEANING
├── default_subtasks: ["Bagno", "Cucina", "Sala", "Camere"]
├── default_estimated_minutes: 120
├── default_points: 20
└── created_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Creazione rapida** | "Aggiungi" in 2 tap, voice input, smart suggestion |
| 2 | **Assegnazione** | Drag su membro, rotazione automatica, auto-assegnazione per preferenze |
| 3 | **Sub-task** | Checklist annidata con progress bar |
| 4 | **Template** | "Pulizia di primavera" → 10 subtask predefiniti |
| 5 | **Priorità e scadenza** | Colori, badge, sort automatico |
| 6 | **Notifiche** | Assegnazione, scadenza imminente, reminder ricorrenti |
| 7 | **Gamification** | Punti per task completati, streak giornaliera, classifica familiare |
| 8 | **Auto-ricorrenza** | "Ogni martedì", "Ogni primo del mese", custom RRULE |
| 9 | **Delega** | Re-assign con notifica al nuovo assegnatario |
| 10 | **Vista board** | Kanban (Da fare / In corso / Fatto) o lista |
| 11 | **Vista settimanale** | "Cosa devo fare questa settimana?" filtrata per me |
| 12 | **Task condivisi** | Più assegnatari, ognuno marca la propria parte |

### Gamification System
```
POINTS:
- Task completata: +points (base su priorità/durata)
- Streak 7 giorni: +50 bonus
- Task prima della scadenza: +10% bonus
- Aiutare altro membro: +20 bonus

BADGES:
- "Mani in pasta" — 50 task cucina
- "Mr. Clean" — 100 task pulizia
- "Puntuale" — 30 task prima della scadenza
- "Team player" — 20 task per altri

LEADERBOARD:
- Mensile / Annuale / Sempre
- Per categoria (chi pulisce di più?)
- Non competitivo per bambini: "Obiettivi raggiunti" vs "Classifica"
```

---

## 🛒 Modulo: Lista della Spesa

### Entità

```
SHOPPING_LIST
├── id
├── family_id (FK)
├── created_by (FK → user)
├── name: "Spesa settimanale"
├── store: "Esselunga" (nullable)
├── is_template: false
├── status: ACTIVE | COMPLETED | ARCHIVED
├── assigned_to (FK → user, nullable — chi fa la spesa)
├── due_date (nullable — "da fare entro venerdì")
├── total_estimated_cost (calcolato)
├── created_at
└── updated_at

SHOPPING_ITEM
├── id
├── shopping_list_id (FK)
├── name: "Latte fresco"
├── quantity: 2
├── unit: LITERS | PIECES | GRAMS | KILOS | OTHER
├── category: DAIRY | MEAT | VEGETABLES | FRUIT | BAKERY | BEVERAGES | FROZEN | HOUSEHOLD | PERSONAL | OTHER
├── is_checked: false
├── checked_by (FK → user, nullable)
├── checked_at (nullable)
├── price_estimate: 1.50 (nullable)
├── notes: "Intero, non scremato"
├── added_by (FK → user)
├── is_urgent: false
├── from_recipe_id (nullable, FK)
├── created_at
└── updated_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Lista in tempo reale** | Sync istantaneo, vedi chi sta aggiungendo/togliendo |
| 2 | **Aggiunta rapida** | Barra rapida, voice "Aggiungi uova", scan barcode |
| 3 | **Categorie con colori** | Icone e colori per reparto supermercato |
| 4 | **Ordinamento smart** | Per reparto (ottimizzazione percorso supermercato) o per aggiunta |
| 5 | **Quantità e unità** | "2 litri", "3 pezzi", "500 grammi" |
| 6 | **Check con swipe** | Swipe right = comprato, swipe left = rimuovi |
| 7 | **Lista multipla** | "Spesa Esselunga", "Farmacia", "Ferramenta" — separate |
| 8 | **Template lista** | "Lista base settimanale" — aggiungi con un click |
| 9 | **Suggerimenti ricorrenti** | "Aggiungi pane ogni 2 giorni", "Latte ogni 3 giorni" |
| 10 | **Da ricetta** | Importa ingredienti da ricetta salvata |
| 11 | **Offline-first** | Cache locale, sync quando torna la connessione |
| 12 | **Condividi lista** | QR code per lista temporanea (es: "prendi tu il vino per la cena?") |
| 13 | **Storico e analytics** | "Quanto spendiamo in latte al mese?" |

---

## 🍽️ Modulo: Meal Planner & Ricettario

### Entità

```
MEAL_PLAN
├── id
├── family_id (FK)
├── created_by (FK → user)
├── week_start_date: 2026-06-01
├── meals: [
│     { day: "monday", lunch_recipe_id: 5, dinner_recipe_id: 12, notes: "" },
│     { day: "tuesday", lunch_recipe_id: null, dinner_recipe_id: 8, notes: "Cena fuori" }
│   ] (JSON)
├── shopping_list_generated_id (FK, nullable)
├── created_at
└── updated_at

RECIPE
├── id
├── family_id (FK, nullable — global se null)
├── created_by (FK → user)
├── name: "Pasta al pomodoro"
├── description
├── prep_time_minutes: 15
├── cook_time_minutes: 20
├── servings: 4
├── difficulty: EASY | MEDIUM | HARD
├── category: BREAKFAST | LUNCH | DINNER | SNACK | DESSERT | OTHER
├── ingredients: [
│     { name: "Pasta", quantity: 400, unit: "grams", category: "pasta" },
│     { name: "Pomodori", quantity: 6, unit: "pieces", category: "vegetables" }
│   ] (JSON)
├── instructions: ["Step 1...", "Step 2..."] (JSON)
├── image_url
├── tags: ["vegetariano", "veloce", "italiano"]
├── is_favorite: false
├── rating: 4.5
├── times_cooked: 12
├── created_at
└── updated_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Pianificazione settimanale** | Griglia 7 giorni × 2-3 pasti, drag & drop ricette |
| 2 | **Ricettario familiare** | Raccolta ricette con foto, categorie, tag |
| 3 | **Importa ingredienti in lista spesa** | Da meal plan o singola ricetta → auto-genera shopping list |
| 4 | **Auto-categorizzazione** | Ingredienti mappati automaticamente su categorie supermercato |
| 5 | **Preferenze e allergie** | Flag ingredienti da evitare per membro specifico |
| 6 | **Suggerimenti AI** | "Hai pasta e pomodori in dispensa — prova questa ricetta!" |
| 7 | **Cooking mode** | Schermo sempre acceso, step-by-step con timer integrato |
| 8 | **Rating e storico** | "L'ultima volta era venuta bene?" — voto e note |
| 9 | **Template pasti** | "Settimana tipo", "Natale", "Vacanza al mare" |
| 10 | **Condivisione ricette** | Condividi con altre famiglie (pubblico o privato) |

---

## 📍 Modulo: Location Tracking (Consenso Esplicito)

> **IMPORTANTE:** Non è parental control. È un servizio di coordinamento familiare dove OGNI membro deve concedere il consenso esplicito al momento della richiesta. Il tracking è bidirezionale e trasparente.

### Entità

```
LOCATION_SHARING
├── id
├── user_id (FK)
├── family_id (FK)
├── is_enabled: false
├── share_with: [user_id_1, user_id_2] (JSON — chi può vedere la mia posizione)
├── accuracy_level: PRECISE | APPROXIMATE | CITY_ONLY
├── auto_disable_after_hours: 24 (auto-off per privacy)
├── battery_saving_mode: true (aggiornamento ogni 5 min vs real-time)
├── created_at
└── updated_at

LOCATION_HISTORY
├── id
├── user_id (FK)
├── family_id (FK)
├── latitude: 45.4642
├── longitude: 9.1900
├── accuracy_meters: 15
├── address: "Piazza Duomo, Milano"
├── battery_level: 78
├── timestamp: 2026-05-28T14:30:00Z
├── is_manual_check_in: false (true se l'utente ha cliccato "Sono qui")
└── created_at

SAFE_ZONE
├── id
├── family_id (FK)
├── created_by (FK → user)
├── name: "Casa"
├── latitude: 45.4642
├── longitude: 9.1900
├── radius_meters: 100
├── type: HOME | SCHOOL | WORK | OTHER
├── notify_on_enter: true
├── notify_on_exit: true
├── notify_members: [user_id_1, user_id_2] (JSON)
├── created_at
└── updated_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Richiesta consenso** | "Vuoi condividere la tua posizione con la famiglia?" — opt-in, non opt-out |
| 2 | **Controllo granularità** | PRECISE (GPS), APPROXIMATE (cell tower), CITY_ONLY (città) |
| 3 | **Condivisione selettiva** | "Condivido solo con Marco e Anna, non con i bambini" |
| 4 | **Auto-disable** | Dopo N ore il tracking si spegne automaticamente |
| 5 | **Check-in manuale** | "Sono arrivato!" — condividi posizione una tantum |
| 6 | **Safe zones** | Notifica quando membro entra/esce da zona (casa, scuola, lavoro) |
| 7 | **Vista mappa familiare** | Mappa con icone membri, click per dettaglio |
| 8 | **Storico posizioni** | Ultima posizione nota, non tracciamento continuo (risparmio batteria) |
| 9 | **Battery level** | Mostra livello batteria membro ("Marco ha 15% — potrebbe non rispondere") |
| 10 | **Privacy dashboard** | Ogni utente vede CHI ha accesso alla SUA posizione, revoca in qualsiasi momento |
| 11 | **Modalità "In viaggio"** | Attiva tracking temporaneo per tragitto specifico (es: "Torno a casa") |

### Flusso Consenso
```
1. Membro A vuole sapere dove è Membro B
2. App invia richiesta a Membro B: "Anna vuole vedere la tua posizione. Accetti?"
3. Membro B sceglie: SÌ / NO / SOLO PER OGGI / SOLO APPROSSIMATIVA
4. Se SÌ → tracking attivo per 24h (default), poi auto-off
5. Membro B può revocare in qualsiasi momento da Privacy Dashboard
6. Membro A vede posizione solo se autorizzato
```

---


## 🚨 Modulo: Pulsante di Emergenza

> **IMPORTANTE:** Funzione di sicurezza per situazioni critiche. Non è un servizio di emergenza professionale (112/911) ma un sistema di allerta rapida all'interno della famiglia. Da usare in combinazione con i servizi di emergenza ufficiali.

### Entità

```
EMERGENCY_ALERT
├── id
├── family_id (FK)
├── triggered_by (FK → user)
├── alert_type: MEDICAL | ACCIDENT | SECURITY | FIRE | OTHER | CUSTOM
├── custom_message: "Sono caduto in casa, non riesco ad alzarmi" (nullable)
├── location_lat: 45.4642 (nullable — se GPS disponibile)
├── location_lng: 9.1900 (nullable)
├── location_accuracy_meters: 15 (nullable)
├── location_address: "Via Roma 123, Milano" (nullable)
├── battery_level: 34 (nullable — per valutare disponibilità)
├── trigger_method: PANIC_BUTTON | VOICE_COMMAND | SHAKE | WIDGET | AUTO_FALL (nullable)
├── status: ACTIVE | ACKNOWLEDGED | RESOLVED | FALSE_ALARM
├── acknowledged_by (FK → user, nullable)
├── acknowledged_at (nullable)
├── resolved_by (FK → user, nullable)
├── resolved_at (nullable)
├── escalation_level: 1 | 2 | 3 (auto-escalation se non acknowledged)
├── notified_members: [user_id_1, user_id_2] (JSON — chi ha ricevuto l'alert)
├── response_actions: [
│     { user_id: 2, action: "VIEWED", timestamp: "2026-05-28T14:30:00Z" },
│     { user_id: 3, action: "CALLING", timestamp: "2026-05-28T14:31:00Z" },
│     { user_id: 1, action: "ON_MY_WAY", timestamp: "2026-05-28T14:32:00Z" }
│   ] (JSON)
├── created_at
└── updated_at

EMERGENCY_CONTACT
├── id
├── family_id (FK)
├── created_by (FK → user)
├── name: "Dott. Rossi"
├── role: DOCTOR | NEIGHBOR | RELATIVE | FRIEND | OTHER
├── phone: "+39 333 1234567"
├── email: "rossi@example.com" (nullable)
├── priority: 1 | 2 | 3 (ordine di chiamata)
├── is_available_24h: false
├── notes: "Ha le chiavi di casa"
├── created_at
└── updated_at

EMERGENCY_SETTINGS
├── id
├── family_id (FK)
├── panic_button_enabled: true
├── voice_command_enabled: false
├── shake_to_alert_enabled: false
├── shake_sensitivity: MEDIUM (LOW | MEDIUM | HIGH)
├── auto_fall_detection: false (future — richiede sensori native)
├── widget_enabled: true
├── escalation_minutes: [5, 15, 30] (minuti prima di escalation)
├── escalation_actions: [
│     { level: 1, action: "PUSH_ALL_MEMBERS" },
│     { level: 2, action: "SMS_ALL_MEMBERS" },
│     { level: 3, action: "CALL_EMERGENCY_CONTACTS" }
│   ] (JSON)
├── require_confirmation: true (evita falsi positivi)
├── confirmation_seconds: 3 (countdown prima di invio)
├── silent_mode_available: true (alert silenzioso per situazioni di pericolo)
├── created_at
└── updated_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Panic Button** | Pulsante rosso prominente in app, widget, e lock screen (Android). Countdown 3-5s per annullamento |
| 2 | **Trigger multipli** | Panic button, voice command ("Emergenza famiglia"), shake device, widget rapido |
| 3 | **Alert istantaneo** | Push + SMS + in-app a TUTTI i membri della famiglia simultaneamente |
| 4 | **Dati contestuali** | Posizione GPS, battery level, timestamp, messaggio personalizzato |
| 5 | **Risposte predefinite** | "Visto", "Chiamo ora", "Arrivo", "Chiamo 112", "Falso allarme" |
| 6 | **Auto-escalation** | Se nessuno risponde in 5 min → SMS a tutti; 15 min → chiama contatti emergenza; 30 min → notifica vicini |
| 7 | **Contatti emergenza** | Rubrica interna: dottore, vicino con chiavi, parente vicino — con priorità |
| 8 | **Silent mode** | Alert silenzioso (vibrazione + notifica discreta) per situazioni di pericolo dove suoni forti non sono sicuri |
| 9 | **Storico alert** | Registro di tutti gli alert con outcome, per review e miglioramento |
| 10 | **Test mode** | Simulazione alert per familiarizzare la famiglia con il flusso |
| 11 | **False alarm handling** | "Falso allarme" con un tap, notifica a tutti che è tutto ok |
| 12 | **Wearable support** | Pulsante su smartwatch (future — richiede native wrapper) |

### Flusso Panic Button

```
1. Utente preme pulsante rosso (o shake/voice)
2. Countdown 3-5 secondi con vibrazione crescente + "Annulla?"
3. Se NON annullato → alert inviato
4. Server invia push a TUTTI i membri (massima priorità, bypass quiet hours)
5. Notifica mostra: chi ha triggerato, dove, quando, battery
6. Membri rispondono con azione predefinita
7. Se nessuno acknowledged in 5 min → escalation level 2 (SMS)
8. Se nessuno in 15 min → escalation level 3 (chiama contatti emergenza)
9. Chi ha triggerato può marcare "Tutto ok / Falso allarme"
```

### UI/UX — Panic Button

```
┌─────────────────────────────┐
│  🔴 EMERGENZA               │
│                             │
│  [     PULSANTE ROSSO      ]│
│  [   Premi e tieni 3 sec   ]│
│                             │
│  ┌─────────┐ ┌─────────┐   │
│  │  🏥    │ │  🔥    │   │
│  │ Medico │ │ Incendio│   │
│  └─────────┘ └─────────┘   │
│  ┌─────────┐ ┌─────────┐   │
│  │  🚗    │ │  ⚠️    │   │
│  │ Incidente│ │ Altro  │   │
│  └─────────┘ └─────────┘   │
│                             │
│  Ultimo test: 2 giorni fa   │
└─────────────────────────────┘
```

### Notifica Emergenza (Push/SMS)

```
🚨 EMERGENZA — Marco ha attivato l'allarme

📍 Via Roma 123, Milano
🔋 Batteria: 34%
⏰ 14:30 — 2 minuti fa

Rispondi:
[📞 Chiamo ora] [🚗 Arrivo] [✅ Visto] [📱 Falso allarme]
```

### Integrazione con Location Tracking

- Se location sharing è attivo per il membro che triggera → posizione inclusa automaticamente
- Se non attivo → richiesta one-time location al momento dell'alert (bypass consenso per emergenza, con notifica post-facto)
- Safe zones: se alert triggerato da casa → notifica include "A casa" vs "Fuori casa"

### Privacy & Consenso

- **Opt-in esplicito** per ogni membro: "Attivare pulsante emergenza?"
- **Override quiet hours**: le notifiche emergenza bypassano le ore silenziose
- **Dati minimi**: solo posizione, battery, timestamp — nessun altro dato
- **Retention limitata**: storico alert cancellato dopo 90 giorni (configurabile)
- **No tracking continuo**: l'alert richiede location al momento, non tracciamento passivo



## 📅 Modulo: Calendario Familiare

### Entità

```
CALENDAR_EVENT
├── id
├── family_id (FK)
├── created_by (FK → user)
├── title: "Compleanno nonna"
├── description
├── category: BIRTHDAY | MEDICAL | SCHOOL | WORK | SPORT | SOCIAL | TRAVEL | APPOINTMENT | OTHER
├── start_date: 2026-06-15
├── start_time: 14:00 (nullable)
├── end_date: 2026-06-15
├── end_time: 18:00 (nullable)
├── is_all_day: false
├── location: "Casa nonna, Via Roma 123"
├── assigned_to (FK → user, nullable)
├── related_todo_id (nullable)
├── related_deadline_id (nullable)
├── recurrence_rule (nullable, RRULE)
├── is_private: false
├── color: "#FF5733" (override colore categoria)
├── reminder_minutes_before: [15, 60, 1440]
├── attendees: [user_id_1, user_id_2] (JSON array)
├── created_at
└── updated_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Viste multiple** | Giorno, settimana, mese, agenda (lista) |
| 2 | **Colori per membro** | Ogni membro ha colore, eventi multi-membro mostrano entrambi |
| 3 | **Conflitti** | Alert se due eventi nello stesso slot per stesso membro |
| 4 | **Trasporti e pickup** | "Chi porta i bambini a scuola?" con assegnazione e reminder |
| 5 | **Integrazione esterna** | Import Google Calendar / Outlook (read-only o bidirezionale) |
| 6 | **Eventi ricorrenti** | Compleanni, sport settimanali, lezioni |
| 7 | **Link a task** | "Visita medica" → auto-crea todo "Preparare documenti" |
| 8 | **Vista famiglia** | Tutti gli eventi sovrapposti, filtra per membro |

---

## 💬 Modulo: Comunicazione & Bacheca

### Entità

```
BOARD_POST
├── id
├── family_id (FK)
├── created_by (FK → user)
├── title: "Ricordate!"
├── content: "Domani arriva la nonna per pranzo"
├── type: NOTE | POLL | ANNOUNCEMENT | REMINDER
├── is_pinned: false
├── expires_at (nullable)
├── reactions: { "👍": [user_id_1], "❤️": [user_id_2] } (JSON)
├── comments: [ { user_id, content, created_at } ] (JSON)
├── created_at
└── updated_at

POLL_OPTION (se type=POLL)
├── id
├── board_post_id (FK)
├── text: "Pizza"
├── votes: [user_id_1, user_id_2] (JSON array)
└── created_at
```

### Funzionalità

| # | Funzione | Dettaglio |
|---|----------|-----------|
| 1 | **Bacheca familiare** | Post-it digitali, annunci, reminder |
| 2 | **Sondaggi rapidi** | "Cosa mangiamo stasera?" — voto maggioranza, scadenza temporale |
| 3 | **Commenti** | Thread sotto ogni post |
| 4 | **Reazioni** | Emoji rapide (👍 ❤️ 😂 😮 😢 😡) |
| 5 | **Pin importanti** | Post sticky in cima alla bacheca |
| 6 | **Scadenza post** | Auto-elimina dopo N giorni (opzionale) |
| 7 | **Notifica nuovo post** | Push a tutti i membri |

---

## 🔔 Sistema Notifiche

### Canali

| Canale | Uso | Configurabile |
|--------|-----|---------------|
| **Push in-app** | Tutto | Sì, per categoria |
| **Email** | Riassunti, scadenze importanti | Sì, frequenza |
| **SMS** | Solo emergenze (scadenza critica) | Sì, opt-in |
| **In-app** | Badge, event feed | Sempre attivo |

### Trigger Notifiche

| Evento | Destinatari | Timing |
|--------|-------------|--------|
| Task assegnata | Assegnatario | Immediato |
| Scadenza imminente | Assegnatario + Admin | `notify_before_hours` |
| Scadenza OVERDUE | Assegnatario + Admin | Giorno stesso, poi ogni 3 giorni |
| Spesa registrata | Tutti | Immediato |
| Debito da saldare | Creditore + Debitore | Dopo 3 giorni, poi settimanale |
| Nuovo post bacheca | Tutti | Immediato |
| Sondaggio creato | Tutti | Immediato |
| Riassunto settimanale | Tutti | Domenica mattina (configurabile) |
| Location check-in | Membri autorizzati | Immediato |
| Safe zone enter/exit | Membri notificati | Immediato |
| Meal plan generato | Tutti | Immediato |
| **Emergenza triggerata** | **Tutti i membri** | **Immediato, bypass quiet hours** |
| Escalazione emergenza | Contatti emergenza | Dopo 5/15/30 min |

### Preferenze Utente

```
NOTIFICATION_PREFS
├── user_id
├── push_enabled: true
├── email_enabled: true
├── email_frequency: IMMEDIATE | DAILY_DIGEST | WEEKLY_DIGEST
├── quiet_hours_start: 22:00
├── quiet_hours_end: 08:00
├── categories_muted: ["shopping", "entertainment"]
├── channels: { deadline: [push, email], expense: [push], board: [push] }
└── location_notifications: true/false
```

---

## 📊 Dashboard & Analytics

### Dashboard Admin (Vista "Comandante")

```
┌─────────────────────────────────────────────────────────────┐
│  FAMILY HUB — Dashboard                                     │
├─────────────────────────────────────────────────────────────┤
│  ⚠️  URGENTE                                                │
│  • TARI scade tra 3 giorni (€245) — non pagata             │
│  • 2 task scadute: "Chiamare idraulico", "Pagare palestra"  │
│                                                             │
│  📋 Questa settimana                                        │
│  • 12 task totali | 5 assegnate a te | 3 senza assegnatario│
│  • 2 scadenze | 1 spesa da registrare                       │
│                                                             │
│  💰 Bilancio Maggio                                         │
│  • Speso: €1,240 / Budget: €1,500 (83%)                     │
│  • Marco deve €45 a Anna                                    │
│                                                             │
│  📅 Prossimi eventi                                         │
│  • Domani: Visita pediatrica (15:00)                        │
│  • Venerdì: Cena dai suoceri (20:00)                        │
│                                                             │
│  🛒 Lista spesa                                             │
│  • 8 articoli da comprare (3 urgenti)                       │
│  • Assegnata a: Marco (per venerdì)                         │
│                                                             │
│  🍽️ Meal Plan                                               │
│  • Oggi: Pasta al pomodoro (pranzo), Pollo al curry (cena)  │
│                                                             │
│  📍 Membri                                                  │
│  • Anna: 📍 Casa (5 min fa)                                 │
│  • Marco: 📍 Ufficio (30 min fa)                            │
│  • Luca: 📍 Scuola (Safe Zone — entrato 2h fa)              │
│                                                             │
│  🚨 Emergenza                                               │
│  • [PULSANTE ROSSO] — Premi e tieni 3 secondi              │
│  • Ultimo test: 2 giorni fa                                 │
└─────────────────────────────────────────────────────────────┘
```

### Report Disponibili

| Report | Dati | Formato |
|--------|------|---------|
| Spese mensili | Per categoria, membro, trend | Grafico + tabella |
| Task completate | Per membro, categoria, periodo | Grafico + tabella |
| Scadenze anno | Calendario fiscale personale | PDF |
| Bilancio familiare | Entrate/uscite, debiti netti | Tabella |
| Storico documenti | Per categoria, data | Lista |
| Meal plan analytics | Ricette più usate, costo medio | Grafico |
| Location history | Entrate/uscite safe zones | Mappa + timeline |

---

## 📱 PWA vs Native — Decisione Architetturale

### Perché PWA (scelta consigliata)

| Vantaggio | Dettaglio |
|-----------|-----------|
| **Nessun app store** | Zero review Apple/Google, deploy istantaneo |
| **Costo sviluppo** | Un solo codebase (Flutter Web) vs 3 (iOS, Android, Web) |
| **Self-hosted** | Dati in casa, nessun vendor lock-in |
| **Installabile** | "Aggiungi a schermo Home" — icona come app nativa |
| **Offline-first** | Service Worker + cache per lista spesa e task |
| **Real-time sync** | WebSocket funziona perfettamente in PWA |
| **Aggiornamenti** | Silent update, niente "aggiorna app" |

### Limitazioni PWA (e mitigazioni)

| Limitazione | Impatto | Mitigazione |
|-------------|---------|-------------|
| **Push iOS** | Richiede installazione su Home Screen + Safari | UX che guida installazione; fallback email per non-installati |
| **Push delivery iOS** | ~70-85% vs 90-95% Android | Email fallback; in-app badge; ri-sottoscrizione automatica |
| **Background sync** | Limitato su iOS | Foreground sync all'apertura; push per trigger |
| **Geolocation background** | Non disponibile in background su iOS | Check-in manuale + foreground location; safe zones con enter/exit |
| **Face ID / Touch ID** | Non disponibile | Biometria web (WebAuthn) per login; PIN alternativo |

### Quando valutare Native (futuro)

- **Fase 2 post-MVP**: se il tracking location in background diventa critico
- **Notifiche critiche**: se le push devono arrivare al 99% (fintech, health emergency)
- **App Store presence**: se serve visibilità su store per acquisizione utenti
- **Hardware access**: NFC, Bluetooth BLE, HealthKit (non necessari per Family Hub)

### Strategia Ibrida Suggerita

```
FASE 1 (MVP): PWA completa
├── Flutter Web
├── PWA installabile
├── Push + Email fallback
├── Location foreground + check-in manuale
└── Tutte le funzioni core

FASE 2 (Scale): Valuta wrapper native
├── Flutter WebView wrapper (Capacitor / Flutter itself)
├── Stesso codice, container nativo
├── Push native (APNs + FCM) — delivery 95%+
├── Background location (se richiesto)
└── App Store / Play Store presence
```

---

## 🎨 UX & UI Principi

### Design System
- **Colori:** Palette calda e familiare (arancio, verde acqua, blu pastello)
- **Tipografia:** Leggibile, font size minimo 16px su mobile
- **Icone:** Line style, coerenti, con label testuali per accessibilità
- **Dark mode:** Supporto completo

### Interazioni Chiave

| Pattern | Implementazione |
|---------|----------------|
| **Aggiunta rapida** | Floating button (+) → menu contestuale |
| **Swipe** | Lista spesa: swipe dx = check, sx = delete |
| **Pull to refresh** | Tutte le liste |
| **Voice input** | Microfono su ogni campo testo rapido |
| **Widget mobile** | Lista spesa e task odierni sulla home |
| **Offline indicator** | Banner sottile quando offline |
| **Skeleton loading** | Placeholder animati durante fetch |

### Accessibilità
- WCAG 2.1 AA compliance
- Screen reader support
- Font size regolabile
- Alto contrasto opzione
- Supporto riduzione movimento

---

## 🔧 API Endpoints (Serverpod — High Level)

```
AUTH
├── POST /auth/register
├── POST /auth/login
├── POST /auth/logout
├── POST /auth/refresh
├── POST /auth/forgot-password
├── POST /auth/reset-password
└── GET  /auth/me

FAMILY
├── POST /family/create
├── POST /family/join (body: invite_code)
├── GET  /family/:id
├── GET  /family/:id/members
├── PUT  /family/:id/members/:user_id/role
├── DELETE /family/:id/members/:user_id
└── POST /family/:id/leave

DEADLINE
├── GET    /deadlines?status=&category=&from=&to=
├── POST   /deadlines
├── GET    /deadlines/:id
├── PUT    /deadlines/:id
├── DELETE /deadlines/:id
├── POST   /deadlines/:id/complete
└── GET    /deadlines/upcoming (prossime 7/30/90 giorni)

DOCUMENT
├── GET    /documents?category=&tag=&q=
├── POST   /documents (multipart upload)
├── GET    /documents/:id
├── GET    /documents/:id/download
├── PUT    /documents/:id
├── DELETE /documents/:id
└── POST   /documents/:id/ocr (trigger manual)

EXPENSE
├── GET    /expenses?from=&to=&category=
├── POST   /expenses
├── GET    /expenses/:id
├── PUT    /expenses/:id
├── DELETE /expenses/:id
├── POST   /expenses/:id/settle
├── GET    /expenses/balance (bilancio corrente)
├── GET    /expenses/settlements (transazioni da fare)
└── GET    /expenses/report?period=month

TODO
├── GET    /todos?status=&assigned_to=&category=
├── POST   /todos
├── GET    /todos/:id
├── PUT    /todos/:id
├── DELETE /todos/:id
├── POST   /todos/:id/complete
├── POST   /todos/:id/reassign
└── GET    /todos/my-day (task di oggi per utente loggato)

SHOPPING
├── GET    /shopping-lists
├── POST   /shopping-lists
├── GET    /shopping-lists/:id
├── PUT    /shopping-lists/:id
├── DELETE /shopping-lists/:id
├── POST   /shopping-lists/:id/items
├── PUT    /shopping-lists/:id/items/:item_id
├── DELETE /shopping-lists/:id/items/:item_id
├── POST   /shopping-lists/:id/items/:item_id/check
└── POST   /shopping-lists/:id/complete

MEAL_PLANNER
├── GET    /meal-plans?week=
├── POST   /meal-plans
├── PUT    /meal-plans/:id
├── GET    /meal-plans/:id/shopping-list (genera lista spesa)
├── GET    /recipes
├── POST   /recipes
├── GET    /recipes/:id
├── PUT    /recipes/:id
├── DELETE /recipes/:id
└── POST   /recipes/:id/favorite

CALENDAR
├── GET    /events?from=&to=&member=
├── POST   /events
├── GET    /events/:id
├── PUT    /events/:id
├── DELETE /events/:id
└── GET    /events/conflicts (eventi sovrapposti)

BOARD
├── GET    /board-posts
├── POST   /board-posts
├── GET    /board-posts/:id
├── PUT    /board-posts/:id
├── DELETE /board-posts/:id
├── POST   /board-posts/:id/react
├── POST   /board-posts/:id/comment
└── POST   /board-posts/:id/poll/vote

EMERGENCY
├── POST   /emergency/trigger (body: type, message, trigger_method)
├── POST   /emergency/:id/acknowledge
├── POST   /emergency/:id/resolve
├── POST   /emergency/:id/false-alarm
├── GET    /emergency/active (alert attivi non resolved)
├── GET    /emergency/history
├── GET    /emergency/settings
├── PUT    /emergency/settings
├── GET    /emergency/contacts
├── POST   /emergency/contacts
├── PUT    /emergency/contacts/:id
├── DELETE /emergency/contacts/:id
└── POST   /emergency/test (simulazione alert)

LOCATION
├── GET    /location/status (mio stato condivisione)
├── PUT    /location/status (abilita/disabilita)
├── GET    /location/family (posizioni membri autorizzati)
├── POST   /location/check-in (check-in manuale)
├── GET    /location/history?user=&from=&to=
├── GET    /safe-zones
├── POST   /safe-zones
├── PUT    /safe-zones/:id
└── DELETE /safe-zones/:id

NOTIFICATIONS
├── GET    /notifications/settings
├── PUT    /notifications/settings
├── GET    /notifications/history
├── POST   /notifications/subscribe (push subscription)
└── POST   /notifications/unsubscribe
```

---

## 🗄️ Schema Database (PostgreSQL)

```sql
-- Users (Serverpod gestisce auth, estendiamo con profilo)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    avatar_url TEXT,
    preferences JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Families
CREATE TABLE families (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    invite_code VARCHAR(20) UNIQUE NOT NULL,
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT NOW()
);

-- Family Members (junction)
CREATE TABLE family_members (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    role VARCHAR(20) DEFAULT 'member' CHECK (role IN ('admin', 'member', 'guest')),
    joined_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, family_id)
);

-- Deadlines
CREATE TABLE deadlines (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    created_by INT REFERENCES users(id),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    category VARCHAR(50) DEFAULT 'other',
    amount DECIMAL(10,2),
    currency VARCHAR(3) DEFAULT 'EUR',
    due_date DATE NOT NULL,
    is_recurring BOOLEAN DEFAULT FALSE,
    recurrence_rule TEXT,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'overdue', 'cancelled')),
    priority VARCHAR(20) DEFAULT 'medium',
    assigned_to INT REFERENCES users(id),
    notify_before_hours INT[] DEFAULT '{24, 72}',
    payment_method VARCHAR(50),
    receipt_image_url TEXT,
    receipt_notes TEXT,
    tags VARCHAR(50)[],
    is_private BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMP,
    completed_by INT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Documents
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    uploaded_by INT REFERENCES users(id),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    file_url TEXT NOT NULL,
    file_type VARCHAR(20) DEFAULT 'other',
    file_size_bytes BIGINT,
    category VARCHAR(50) DEFAULT 'other',
    related_deadline_id INT REFERENCES deadlines(id),
    ocr_data JSONB,
    tags VARCHAR(50)[],
    is_encrypted BOOLEAN DEFAULT FALSE,
    access_level VARCHAR(20) DEFAULT 'family',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Expenses
CREATE TABLE expenses (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    created_by INT REFERENCES users(id),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'EUR',
    category VARCHAR(50) DEFAULT 'other',
    paid_by INT REFERENCES users(id),
    split_type VARCHAR(20) DEFAULT 'equal',
    split_details JSONB NOT NULL,
    receipt_image_url TEXT,
    expense_date DATE DEFAULT CURRENT_DATE,
    is_recurring BOOLEAN DEFAULT FALSE,
    status VARCHAR(20) DEFAULT 'active',
    settlement_id INT,
    tags VARCHAR(50)[],
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Settlements
CREATE TABLE settlements (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    from_user INT REFERENCES users(id),
    to_user INT REFERENCES users(id),
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'EUR',
    status VARCHAR(20) DEFAULT 'pending',
    payment_method VARCHAR(50),
    payment_proof_url TEXT,
    settled_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Todo Items
CREATE TABLE todo_items (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    created_by INT REFERENCES users(id),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    category VARCHAR(50) DEFAULT 'other',
    priority VARCHAR(20) DEFAULT 'medium',
    status VARCHAR(20) DEFAULT 'pending',
    assigned_to INT REFERENCES users(id),
    due_date TIMESTAMP,
    is_recurring BOOLEAN DEFAULT FALSE,
    recurrence_rule TEXT,
    estimated_minutes INT,
    subtasks JSONB DEFAULT '[]',
    checklist_template_id INT,
    points INT DEFAULT 10,
    completed_at TIMESTAMP,
    completed_by INT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Shopping Lists
CREATE TABLE shopping_lists (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    created_by INT REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    store VARCHAR(100),
    is_template BOOLEAN DEFAULT FALSE,
    status VARCHAR(20) DEFAULT 'active',
    assigned_to INT REFERENCES users(id),
    due_date TIMESTAMP,
    total_estimated_cost DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Shopping Items
CREATE TABLE shopping_items (
    id SERIAL PRIMARY KEY,
    shopping_list_id INT REFERENCES shopping_lists(id) ON DELETE CASCADE,
    name VARCHAR(200) NOT NULL,
    quantity DECIMAL(10,2) DEFAULT 1,
    unit VARCHAR(20) DEFAULT 'pieces',
    category VARCHAR(50) DEFAULT 'other',
    is_checked BOOLEAN DEFAULT FALSE,
    checked_by INT REFERENCES users(id),
    checked_at TIMESTAMP,
    price_estimate DECIMAL(10,2),
    notes TEXT,
    added_by INT REFERENCES users(id),
    is_urgent BOOLEAN DEFAULT FALSE,
    from_recipe_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Meal Plans
CREATE TABLE meal_plans (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    created_by INT REFERENCES users(id),
    week_start_date DATE NOT NULL,
    meals JSONB DEFAULT '[]',
    shopping_list_generated_id INT REFERENCES shopping_lists(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Recipes
CREATE TABLE recipes (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    created_by INT REFERENCES users(id),
    name VARCHAR(200) NOT NULL,
    description TEXT,
    prep_time_minutes INT,
    cook_time_minutes INT,
    servings INT,
    difficulty VARCHAR(20) DEFAULT 'easy',
    category VARCHAR(50) DEFAULT 'other',
    ingredients JSONB DEFAULT '[]',
    instructions JSONB DEFAULT '[]',
    image_url TEXT,
    tags VARCHAR(50)[],
    is_favorite BOOLEAN DEFAULT FALSE,
    rating DECIMAL(2,1),
    times_cooked INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Calendar Events
CREATE TABLE calendar_events (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    created_by INT REFERENCES users(id),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    category VARCHAR(50) DEFAULT 'other',
    start_date DATE NOT NULL,
    start_time TIME,
    end_date DATE,
    end_time TIME,
    is_all_day BOOLEAN DEFAULT FALSE,
    location VARCHAR(255),
    assigned_to INT REFERENCES users(id),
    related_todo_id INT,
    related_deadline_id INT,
    recurrence_rule TEXT,
    is_private BOOLEAN DEFAULT FALSE,
    color VARCHAR(7) DEFAULT '#2196F3',
    reminder_minutes_before INT[] DEFAULT '{15, 60}',
    attendees INT[],
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Board Posts
CREATE TABLE board_posts (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    created_by INT REFERENCES users(id),
    title VARCHAR(200),
    content TEXT NOT NULL,
    type VARCHAR(20) DEFAULT 'note' CHECK (type IN ('note', 'poll', 'announcement', 'reminder')),
    is_pinned BOOLEAN DEFAULT FALSE,
    expires_at TIMESTAMP,
    reactions JSONB DEFAULT '{}',
    comments JSONB DEFAULT '[]',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Location Sharing
CREATE TABLE location_sharing (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    is_enabled BOOLEAN DEFAULT FALSE,
    share_with INT[] DEFAULT '{}',
    accuracy_level VARCHAR(20) DEFAULT 'precise',
    auto_disable_after_hours INT DEFAULT 24,
    battery_saving_mode BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, family_id)
);

-- Location History
CREATE TABLE location_history (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    accuracy_meters INT,
    address VARCHAR(255),
    battery_level INT,
    timestamp TIMESTAMP DEFAULT NOW(),
    is_manual_check_in BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Safe Zones
CREATE TABLE safe_zones (
    id SERIAL PRIMARY KEY,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    created_by INT REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    radius_meters INT DEFAULT 100,
    type VARCHAR(20) DEFAULT 'other',
    notify_on_enter BOOLEAN DEFAULT TRUE,
    notify_on_exit BOOLEAN DEFAULT TRUE,
    notify_members INT[] DEFAULT '{}',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Gamification
CREATE TABLE user_points (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    family_id INT REFERENCES families(id) ON DELETE CASCADE,
    points INT DEFAULT 0,
    streak_days INT DEFAULT 0,
    last_activity_date DATE,
    badges VARCHAR(50)[],
    UNIQUE(user_id, family_id)
);

-- Indexes per performance
CREATE INDEX idx_deadlines_family_due ON deadlines(family_id, due_date);
CREATE INDEX idx_deadlines_status ON deadlines(status);
CREATE INDEX idx_expenses_family_date ON expenses(family_id, expense_date);
CREATE INDEX idx_todos_family_status ON todo_items(family_id, status);
CREATE INDEX idx_shopping_items_list ON shopping_items(shopping_list_id);
CREATE INDEX idx_calendar_events_dates ON calendar_events(family_id, start_date, end_date);
CREATE INDEX idx_documents_ocr ON documents USING GIN (ocr_data);
CREATE INDEX idx_location_history_user ON location_history(user_id, timestamp DESC);
CREATE INDEX idx_location_history_family ON location_history(family_id, timestamp DESC);
```

---

## 🐳 Docker Compose (Riepilogo)

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: family_hub
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: family_hub
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U family_hub"]
      interval: 5s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data
    ports:
      - "6379:6379"

  minio:
    image: minio/minio:latest
    environment:
      MINIO_ROOT_USER: ${MINIO_USER}
      MINIO_ROOT_PASSWORD: ${MINIO_PASSWORD}
    volumes:
      - minio_data:/data
    ports:
      - "9000:9000"
      - "9001:9001"
    command: server /data --console-address ":9001"

  serverpod:
    build: ./server
    ports:
      - "8080:8080"
      - "8081:8081"
    environment:
      - DATABASE_URL=postgresql://family_hub:${DB_PASSWORD}@postgres:5432/family_hub
      - REDIS_URL=redis://redis:6379
      - MINIO_ENDPOINT=minio:9000
      - MINIO_ACCESS_KEY=${MINIO_USER}
      - MINIO_SECRET_KEY=${MINIO_PASSWORD}
      - JWT_SECRET=${JWT_SECRET}
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_started
      minio:
        condition: service_started

  flutter-web:
    build: ./flutter_app
    ports:
      - "80:80"
    depends_on:
      - serverpod

volumes:
  postgres_data:
  redis_data:
  minio_data:
```

---

## 📱 PWA Configuration

```json
// web/manifest.json
{
  "name": "Family Hub",
  "short_name": "FamilyHub",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#2196F3",
  "orientation": "portrait",
  "icons": [
    { "src": "icons/icon-192.png", "sizes": "192x192", "type": "image/png" },
    { "src": "icons/icon-512.png", "sizes": "512x512", "type": "image/png" }
  ],
  "categories": ["productivity", "lifestyle"],
  "screenshots": [
    { "src": "screenshots/dashboard.png", "sizes": "1280x720", "type": "image/png", "form_factor": "wide" },
    { "src": "screenshots/mobile.png", "sizes": "750x1334", "type": "image/png", "form_factor": "narrow" }
  ]
}
```

---

## 🚀 Roadmap Sviluppo

### Fase 1 — MVP (Week 1-4)
- [ ] Setup progetto Flutter + Serverpod + Docker
- [ ] Auth (register/login)
- [ ] Creazione/join famiglia
- [ ] Todo base (CRUD, assegnazione)
- [ ] Lista spesa base (CRUD, check)
- [ ] Deploy su VPS/cloud

### Fase 2 — Core Features (Week 5-8)
- [ ] Scadenze con notifiche
- [ ] Upload ricevute + OCR
- [ ] Spese e split
- [ ] Calendario familiare
- [ ] Bacheca
- [ ] PWA installabile
- [ ] Meal planner base

### Fase 3 — Polish (Week 9-12)
- [ ] Gamification
- [ ] Report e analytics
- [ ] Template ricorrenti
- [ ] Integrazione Google Calendar
- [ ] Widget mobile
- [ ] Location tracking (consenso esplicito)
- [ ] Test e2e

### Fase 4 — Scale (Post-launch)
- [ ] App native wrapper (Flutter iOS/Android) — se necessario
- [ ] Smart speaker integration
- [ ] AI suggestions (lista spesa, task, meal plan)
- [ ] Multi-lingua
- [ ] White-label per altri use case

---

## 📝 Note per l'AI di Sviluppo

1. **Serverpod genera automaticamente** client Dart, ORM, migrations e API docs dal codice — usare questo vantaggio
2. **Offline-first** è critico per la lista spesa: implementare cache locale con Hive/SharedPreferences + sync queue
3. **Real-time sync** via WebSocket per lista spesa e bacheca — Serverpod supporta nativamente
4. **OCR ricevute** può essere MVP con Tesseract (gratuito) e scalare a AWS Textract se necessario
5. **Privacy first:** nessun dato familiare lascia il server self-hosted senza consenso esplicito
6. **Location tracking:** implementare SOLO con opt-in esplicito, auto-disable, e privacy dashboard trasparente
7. **PWA Push iOS:** richiede installazione su Home Screen + Safari. Implementare UX che guida l'utente, con fallback email
8. **Test:** scrivere test di integrazione per il flusso "registra spesa → split → settlement" fin da subito

---

*Documento versione 3.0 — 28 Maggio 2026*
*Pronto per handoff allo sviluppo*
