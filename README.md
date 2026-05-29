# Famylia

**Famylia** è la companion app per la vita di famiglia: un unico posto dove organizzare compiti, spesa, scadenze, spese condivise, calendario e comunicazione — con i dati sotto il tuo controllo (self-hosted, privacy-first).

Ideale per famiglie, conviventi e coppie che vogliono ridurre il carico di chi “tiene tutto in testa” e condividere responsabilità in modo chiaro.

---

## Cosa puoi fare con Famylia

### Ogni giorno

| Funzione | Descrizione |
|----------|-------------|
| **Home** | Panoramica: task aperti, articoli da comprare, scadenze in arrivo |
| **Todo** | Compiti di casa con priorità, scadenza e assegnazione a un membro |
| **Lista della spesa** | Liste condivise, spunta articoli, categorie colorate; funziona anche offline e si sincronizza quando torni online |
| **Pasti** | Ricettario e piano settimanale; genera gli ingredienti per la lista spesa |

### Organizzazione di casa

| Funzione | Descrizione |
|----------|-------------|
| **Scadenze** | Bollette, tasse, abbonamenti: importi, date, stato (da pagare / pagato / scaduto) |
| **Spese condivise** | Chi ha pagato cosa, split equo tra i membri, bilancio e suggerimenti per saldare i debiti |
| **Calendario** | Eventi familiari (compleanni, scuola, appuntamenti) |
| **Bacheca** | Messaggi, annunci e sondaggi rapidi (“cosa mangiamo stasera?”) con aggiornamenti in tempo reale |
| **Documenti** | Carica ricevute e file utili, collegati a spese o scadenze |

### Sicurezza e privacy

| Funzione | Descrizione |
|----------|-------------|
| **Posizione** | Condivisione solo se la attivi tu (opt-in), check-in “sono arrivato”, auto-disattivazione dopo 24 ore |
| **Emergenza** | Pulsante di allerta per la famiglia, con countdown per evitare falsi invii e modalità test |
| **Privacy / GDPR** | Esporta i tuoi dati, dashboard su chi vede cosa, possibilità di eliminare l’account |
| **Classifica** | Punti e leaderboard per i task completati (gamification leggera) |
| **Report** | Riepilogo attività e spese, export in CSV |

### Famiglia

- **Crea una famiglia** o **entra con codice invito**
- Più membri con ruoli (admin, membro, ospite)
- Un account può appartenere a più famiglie (in sviluppo: switch rapido)

---

## Come iniziare (utente)

1. Apri Famylia nel browser (PWA installabile su telefono e desktop).
2. **Registrati** con email e password.
3. **Crea la tua famiglia** oppure **unisciti** con il codice invito ricevuto da un altro membro.
4. Usa le sezioni dalla Home: Todo, Spesa, Scadenze, Spese, ecc.

> **Registrazione in ambiente di prova:** se non arriva l’email di verifica, il codice viene mostrato nell’app (sviluppo) o nei log del server. In produzione sarà inviata una mail reale.

> **Emergenza:** Famylia **non sostituisce il 112**. In caso di pericolo immediato chiama i servizi di emergenza.

---

## Per chi sviluppa o installa il server

Dettagli tecnici, requisiti, Docker e comandi da terminale sono in fondo al documento e in [`docs/PIANO_SVILUPPO.md`](docs/PIANO_SVILUPPO.md).

---

## Informazioni tecniche

### Stack

| Componente | Tecnologia |
|------------|------------|
| Frontend | Flutter Web (PWA) |
| Backend | Serverpod 2.5 (Dart) |
| Database | PostgreSQL 16 |
| Cache | Redis 7 (opzionale in dev) |
| Storage file | Locale / MinIO (Fase 2+) |
| Deploy | Docker Compose |

### Struttura progetto

```
Famylia/
├── app/          # Flutter PWA
├── client/       # Client Serverpod (generato)
├── server/       # Backend Serverpod
├── docker/       # Stack completo (Postgres, Redis, MinIO)
├── docs/         # Documentazione di sviluppo
└── scripts/      # Setup e test
```

### Requisiti sviluppo

- [Dart SDK](https://dart.dev/get-dart) ≥ 3.3
- [Flutter](https://flutter.dev) ≥ 3.22 (web abilitato)
- PostgreSQL — Docker o locale (`scripts/start-postgres.sh`)
- Serverpod CLI: `dart pub global activate serverpod_cli 2.5.1`

### Avvio rapido sviluppo

```bash
chmod +x scripts/*.sh
./scripts/start-postgres.sh
./scripts/setup-phase0.sh
./scripts/run-tests.sh
```

Server e app in due terminali:

```bash
# Terminale 1 — backend
cd server && dart run bin/main.dart --apply-migrations

# Terminale 2 — app web
cd app && flutter run -d web-server --web-hostname=127.0.0.1 --web-port=8081
```

- Server API: `http://localhost:8080/`
- App web: `http://127.0.0.1:8081`

### Documentazione sviluppo

| Documento | Contenuto |
|-----------|-----------|
| [docs/PIANO_SVILUPPO.md](docs/PIANO_SVILUPPO.md) | Roadmap e fasi |
| [docs/FASE0.md](docs/FASE0.md) | Auth e famiglia |
| [docs/FASE1.md](docs/FASE1.md) | Todo, spesa, dashboard |
| [docs/FASE2.md](docs/FASE2.md) | Scadenze, spese, calendario, bacheca, documenti, pasti |
| [docs/FASE3.md](docs/FASE3.md) | Privacy, location, emergenza, report |
| [family_hub_spec_v3.md](family_hub_spec_v3.md) | Specifica completa |

### Stato implementazione

| Fase | Contenuto principale |
|------|----------------------|
| Fase 0 | Auth, famiglia, onboarding |
| Fase 1 | Todo, lista spesa, dashboard, offline spesa |
| Fase 2 | Scadenze, spese, calendario, bacheca, documenti, meal planner |
| Fase 3 | GDPR, posizione, emergenza, gamification, report |

### Licenza

Da definire.
