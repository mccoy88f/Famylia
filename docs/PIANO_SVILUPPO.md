# Piano di sviluppo — Famylia

> **Versione:** 1.0  
> **Data:** 28 maggio 2026  
> **Repository:** [github.com/mccoy88f/Famylia](https://github.com/mccoy88f/Famylia)  
> **Specifica di riferimento:** [`family_hub_spec_v3.md`](../family_hub_spec_v3.md)

---

## Indice

1. [Obiettivo e visione](#1-obiettivo-e-visione)
2. [Stack e architettura](#2-stack-e-architettura)
3. [Struttura repository](#3-struttura-repository)
4. [Fasi di sviluppo](#4-fasi-di-sviluppo)
5. [Moduli e priorità](#5-moduli-e-priorità)
6. [Roadmap temporale](#6-roadmap-temporale)
7. [Backlog iniziale](#7-backlog-iniziale)
8. [Decisioni architetturali](#8-decisioni-architetturali)
9. [Rischi e mitigazioni](#9-rischi-e-mitigazioni)
10. [Definition of Done](#10-definition-of-done)
11. [Prossimi passi](#11-prossimi-passi)

---

## 1. Obiettivo e visione

**Famylia** è una companion app familiare **privacy-first** e **self-hosted** che centralizza la gestione domestica quotidiana: scadenze, spese, task, liste della spesa, pianificazione pasti, calendario, comunicazione e (in fasi successive) coordinamento posizione ed emergenze.

### Differenziatori

| Principio | Implicazione |
|-----------|--------------|
| Self-hosted | Deploy con Docker Compose; i dati restano di proprietà della famiglia |
| PWA | Flutter Web installabile su mobile senza app store obbligatorio |
| Real-time sync | WebSocket tra membri (lista spesa, bacheca) |
| Offline-first | Lista spesa e task utilizzabili senza rete |
| Consenso esplicito | Location ed emergenza solo con opt-in trasparente |

### Pubblico target

Famiglie, conviventi, coppie, genitori con figli — con focus sulla riduzione del carico cognitivo del “manager familiare” e sulla distribuzione equa delle responsabilità.

### Allineamento naming

- **Prodotto e brand:** Famylia (UI, manifest PWA, README, repository)
- La specifica v3 usa ancora “Family Hub” in alcuni punti — aggiornare progressivamente codice e documentazione al nome definitivo

---

## 2. Stack e architettura

### Stack tecnologico

| Livello | Tecnologia | Ruolo |
|---------|------------|-------|
| Frontend | Flutter Web + PWA | UI responsive, installabile |
| Backend | Serverpod (Dart) | API, ORM, auth, WebSocket |
| Database | PostgreSQL 16 | Dati relazionali, migrations, RLS |
| Cache | Redis 7 | Sessioni, cache, pub/sub |
| Storage | MinIO (S3) | Ricevute, documenti, avatar |
| Container | Docker Compose | Deploy con un comando |
| Edge | Nginx | SSL, static files, rate limiting |

### Diagramma architetturale

```
┌─────────────────────────────────────────────────────────────┐
│                        CLIENT                                │
│  Flutter Web PWA  +  Hive (cache offline)  +  sync queue    │
└──────────────────────────┬──────────────────────────────────┘
                           │ HTTPS / WSS
┌──────────────────────────▼──────────────────────────────────┐
│  Nginx (SSL, static, rate limit)                              │
└──────────────────────────┬──────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────┐
│  Serverpod                                                   │
│  ├── REST / RPC endpoints                                    │
│  ├── WebSocket (real-time)                                   │
│  ├── Auth (JWT + refresh)                                    │
│  └── Background jobs (notifiche, OCR)                        │
└──────┬──────────────┬──────────────┬──────────────────────────┘
       │              │              │
   PostgreSQL       Redis          MinIO
```

### Modello dati core (Fase 0)

```
User ◄──► FamilyMember ◄──► Family
```

**Ruoli famiglia:** `admin` | `member` | `guest`  
**Multi-famiglia:** un utente può appartenere a più famiglie con switch rapido in header.

---

## 3. Struttura repository

Struttura monorepo target:

```
famylia/
├── app/                    # Flutter (web, eventuale mobile futuro)
│   ├── lib/
│   └── web/                # manifest.json, service worker, icone PWA
├── server/                 # Serverpod
│   ├── lib/
│   └── migrations/
├── docker/
│   ├── docker-compose.yml
│   ├── nginx/
│   └── .env.example
├── docs/
│   ├── PIANO_SVILUPPO.md   # questo documento
│   └── adr/                # Architecture Decision Records
├── scripts/
│   ├── migrate.sh
│   ├── seed.sh
│   └── backup.sh
├── family_hub_spec_v3.md
└── README.md
```

---

## 4. Fasi di sviluppo

### Fase 0 — Fondamenta (settimane 1–2)

**Obiettivo:** ambiente ripetibile e vertical slice auth + famiglia.

| # | Deliverable | Criterio di completamento |
|---|-------------|---------------------------|
| 0.1 | Monorepo + CI | Build server + web su ogni PR |
| 0.2 | Docker Compose | `docker compose up` avvia Postgres, Redis, MinIO, Serverpod |
| 0.3 | Schema base | Tabelle `users`, `families`, `family_members` + migrations |
| 0.4 | Auth MVP | Register, login, logout, refresh, `/auth/me` |
| 0.5 | Sicurezza auth | bcrypt, rate limit login (5/15 min), JWT rotation |
| 0.6 | Famiglia | Crea famiglia, join con `invite_code`, ruoli |
| 0.7 | Flutter shell | Routing, tema (palette calda), dark mode base |
| 0.8 | Onboarding UI | Flusso registro → crea/join famiglia → home |

**Fuori scope Fase 0:** OAuth, 2FA, OCR, location, emergenza, gamification, tutti i moduli business.

---

### Fase 1 — MVP quotidiano (settimane 3–6)

**Obiettivo:** una famiglia può usare Famylia ogni giorno per task e spesa.

| Modulo | In scope MVP | Fuori scope MVP |
|--------|--------------|-----------------|
| **Todo** | CRUD, assegnazione, stati, vista “oggi per me” | Kanban, voice, template, gamification |
| **Lista spesa** | CRUD liste/item, check, sync real-time, offline-first | Barcode, QR, analytics, suggerimenti AI |
| **Dashboard** | Riepilogo: task scaduti, lista attiva, contatori | Report avanzati, grafici |
| **Notifiche** | In-app, preferenze base, push web (dove supportato) | SMS, digest email complessi |
| **PWA** | manifest, icone, install prompt, service worker base | Widget home screen |

**Criteri di uscita MVP:**

- [ ] Due utenti nella stessa famiglia vedono aggiornamenti lista spesa in &lt; 2 secondi
- [ ] Lista spesa funziona offline (aggiungi/check) con sync al ritorno online
- [ ] Deploy su VPS con HTTPS documentato nel README
- [ ] Test integrazione: crea famiglia → join → modifica lista condivisa

**Stima:** 4 settimane (1 dev full-time) · 6–8 settimane (part-time o team piccolo)

---

### Fase 2 — Core finanziario e organizzativo (settimane 7–10)

**Obiettivo:** gestione completa di casa, soldi e tempo.

| Modulo | Priorità | Note implementative |
|--------|----------|---------------------|
| Scadenze & bollette | Alta | RRULE base, notifiche `notify_before_hours`, vista lista/calendario |
| Spese condivise | Alta | Split equal/percent/exact/shares, bilancio, semplificazione debiti |
| Documenti & ricevute | Media | Upload MinIO, categorie, link a scadenza/spesa |
| Calendario familiare | Media | CRUD eventi, viste settimana/mese, colori per membro |
| Bacheca | Media | Note, sondaggi, reazioni; real-time come shopping |
| Meal planner | Bassa | Ricettario + piano settimanale; genera lista spesa |

**OCR ricevute:** MVP con Tesseract (job async lato server). Valutare AWS Textract solo se qualità insufficiente.

---

### Fase 3 — Privacy, sicurezza e polish (settimane 11–14)

| Area | Contenuto |
|------|-----------|
| Auth estesa | Google OAuth, magic link (opzionale), 2FA per admin |
| GDPR | Export dati completo, right to be forgotten |
| Location | Opt-in, granularità, auto-off 24h, check-in, safe zones, privacy dashboard |
| Emergenza | Panic button, countdown, escalation, contatti, test mode |
| Gamification | Punti, badge, leaderboard / modalità “obiettivi” per bambini |
| Report & analytics | Spese, task, scadenze; export CSV/PDF |
| Qualità | Test e2e onboarding + shopping; test integrazione spesa→split→settlement |
| Integrazioni | Google Calendar (import read-only o bidirezionale) |

**Copy legale emergenza:** Famylia non sostituisce 112/911 — messaggio visibile in onboarding e schermata emergenza.

---

### Fase 4 — Scale (post-lancio)

- Wrapper nativo (Capacitor / Flutter iOS+Android) per push APNs/FCM e background location
- Suggerimenti AI (meal plan, lista spesa, task)
- Multi-lingua
- White-label per altri use case
- Smart speaker, wearable (futuro)

---

## 5. Moduli e priorità

Ordine consigliato di implementazione (dopo Fase 0):

| Ordine | Modulo | Fase | Dipendenze |
|--------|--------|------|------------|
| 1 | Todo & compiti | 1 | Auth, famiglia |
| 2 | Lista della spesa | 1 | Auth, famiglia, WebSocket |
| 3 | Dashboard | 1 | Todo, shopping |
| 4 | Scadenze & bollette | 2 | Notifiche job |
| 5 | Spese condivise | 2 | Auth, famiglia |
| 6 | Documenti | 2 | MinIO, opz. scadenze/spese |
| 7 | Calendario | 2 | — |
| 8 | Bacheca | 2 | WebSocket |
| 9 | Meal planner | 2 | Ricette, shopping |
| 10 | Sistema notifiche (completo) | 2–3 | Tutti i moduli |
| 11 | Location tracking | 3 | Consenso, privacy UI |
| 12 | Pulsante emergenza | 3 | Notifiche, opz. location |
| 13 | Report & analytics | 3 | Dati Fase 2 |

---

## 6. Roadmap temporale

### Vista sintetica (16 settimane)

```
Settimana   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
            ├──┤  ├──────────────┤  ├──────────────┤  ├──────────────┤
Fase 0      ████
Fase 1          ████████████████████
Fase 2                              ████████████████████
Fase 3                                                  ████████████████
Fase 4                                                                  →
```

### Milestone

| Milestone | Settimana target | Risultato misurabile |
|-----------|------------------|----------------------|
| **M0: Infra** | 2 | `docker compose up` + login funzionante |
| **M1: MVP** | 6 | Famiglia usa todo + shopping in produzione |
| **M2: Core** | 10 | Scadenze, spese, calendario, bacheca attivi |
| **M3: Beta** | 14 | Location, emergenza, GDPR — beta con famiglie reali |
| **M4: Launch** | 16+ | Documentazione, backup, supporto self-hosted |

### Confronto con roadmap spec v3

La spec propone MVP in 4 settimane (solo auth, famiglia, todo, shopping, deploy). Questo piano è allineato ma esplicita:

- **2 settimane** dedicate a fondamenta stabili (Fase 0)
- **Scope MVP ristretto** per rispettare tempi realistici
- **Moduli pesanti** (location, emergenza, gamification) solo in Fase 3

---

## 7. Backlog iniziale

Issue suggerite per il tracker (GitHub Issues / equivalente).

### Fase 0

- [ ] **FAM-001** Inizializzare monorepo (server + app + docker)
- [ ] **FAM-002** Docker Compose: Postgres, Redis, MinIO, Serverpod
- [ ] **FAM-003** Modelli Serverpod: User, Family, FamilyMember
- [ ] **FAM-004** Migrations + seed dati di test
- [ ] **FAM-005** Endpoint auth: register, login, logout, refresh, me
- [ ] **FAM-006** Rate limiting e bcrypt su login
- [ ] **FAM-007** Endpoint famiglia: create, join, members, role, leave
- [ ] **FAM-008** Row-level security per `family_id`
- [ ] **FAM-009** Flutter: tema, routing, schermate auth
- [ ] **FAM-010** Flutter: onboarding crea/join famiglia
- [ ] **FAM-011** CI: lint + build su PR
- [ ] **FAM-012** README: requisiti, avvio locale, variabili env

### Fase 1 (MVP)

- [ ] **FAM-020** API Todo: CRUD, assign, complete, my-day
- [ ] **FAM-021** UI Todo: lista, creazione rapida, filtri stato
- [ ] **FAM-022** API Shopping: liste, item, check, complete
- [ ] **FAM-023** WebSocket shopping list (sync real-time)
- [ ] **FAM-024** Offline: Hive cache + sync queue + conflict resolution
- [ ] **FAM-025** UI Shopping: swipe check/delete, categorie colori
- [ ] **FAM-026** Dashboard home: widget task + shopping
- [ ] **FAM-027** PWA: manifest Famylia, icone, service worker
- [ ] **FAM-028** Notifiche in-app + preferenze base
- [ ] **FAM-029** Push web subscription (con fallback documentato per iOS)
- [ ] **FAM-030** Deploy VPS + HTTPS + guida in README
- [ ] **FAM-031** Test integrazione: famiglia + shopping real-time

### Fase 2 (Core)

- [ ] **FAM-040** Modulo scadenze (CRUD, ricorrenze, notifiche)
- [ ] **FAM-041** Modulo spese (split, bilancio, settlements)
- [ ] **FAM-042** Algoritmo semplificazione debiti
- [ ] **FAM-043** Upload documenti + MinIO
- [ ] **FAM-044** OCR Tesseract (job async)
- [ ] **FAM-045** Calendario eventi
- [ ] **FAM-046** Bacheca + sondaggi + real-time
- [ ] **FAM-047** Meal planner + ricettario + export shopping

### Fase 3 (Polish)

- [ ] **FAM-050** Google OAuth
- [ ] **FAM-051** Export GDPR + cancellazione account
- [ ] **FAM-052** Location sharing + safe zones + privacy dashboard
- [ ] **FAM-053** Emergency alert + escalation + test mode
- [ ] **FAM-054** Gamification (punti, badge)
- [ ] **FAM-055** Report PDF/CSV
- [ ] **FAM-056** Test e2e suite principale
- [ ] **FAM-057** Script backup Postgres + MinIO

---

## 8. Decisioni architetturali

Registro decisioni da confermare all’avvio (ADR in `docs/adr/`).

| ID | Decisione | Scelta raccomandata | Alternative scartate |
|----|-----------|---------------------|----------------------|
| ADR-01 | Nome prodotto | **Famylia** ovunque | Family Hub (solo spec legacy) |
| ADR-02 | Auth v1 | Email + password | OAuth in v1 (rimandato) |
| ADR-03 | Deploy default | Docker Compose self-hosted | SaaS managed |
| ADR-04 | Offline storage | Hive + coda sync | Solo online |
| ADR-05 | Conflict resolution (shopping) | Last-write-wins con timestamp | CRDT (complessità eccessiva per MVP) |
| ADR-06 | Real-time transport | Serverpod WebSocket | Polling |
| ADR-07 | File storage path | `famylia/{family_id}/{uuid}` | Flat bucket |
| ADR-08 | OCR | Tesseract self-hosted | Textract (costo, vendor) |
| ADR-09 | iOS push | PWA + guida install + email fallback | Native subito |
| ADR-10 | Location background | Non in MVP; check-in + foreground | Tracking continuo PWA |

---

## 9. Rischi e mitigazioni

| Rischio | Probabilità | Impatto | Mitigazione |
|---------|-------------|---------|-------------|
| Scope creep (13 moduli in spec) | Alta | Alto | MVP rigido: solo todo + shopping + auth |
| PWA iOS limitata (push, background) | Alta | Medio | Onboarding install; email per scadenze critiche |
| Self-hosted = supporto utente | Media | Medio | Script e doc “un comando”; `.env.example` curato |
| OCR impreciso | Media | Basso | Campi editabili; OCR opzionale |
| Sicurezza dati familiari | Bassa | Critico | RLS, JWT rotation, AES documenti sensibili |
| Emergenza interpretata come 112 | Bassa | Alto | Copy legale + test mode |
| Tempi sottostimati | Alta | Medio | Buffer 2 settimane su MVP; Fase 4 opzionale |

---

## 10. Definition of Done

Per ogni modulo/feature:

1. **Backend:** modelli Serverpod, migration, endpoint con auth `family_id` + ruolo
2. **Frontend:** schermate responsive (mobile-first), gestione errori, loading skeleton
3. **Sicurezza:** nessun dato cross-family; guest read-only dove previsto
4. **Test:** almeno 1 test integrazione sul flusso principale del modulo
5. **Docs:** endpoint documentati (o via codegen Serverpod); note in README se deploy-specific
6. **Accessibilità:** target WCAG 2.1 AA su UI nuove (contrasto, label, touch target ≥ 44px)

---

## 11. Prossimi passi

Ordine operativo consigliato **dopo approvazione di questo piano**:

1. **Review piano** — confermare scope MVP e timeline con stakeholder
2. **Aggiornare README** su GitHub con visione Famylia e link a questo documento
3. **Creare milestone** su issue tracker: Fase 0, MVP, Core, Polish
4. **Wireframe** — dashboard, lista spesa, onboarding (Figma o `docs/wireframes/`)
5. **Avviare Fase 0** — scaffold Serverpod + Flutter + Docker Compose

---

## Riferimenti

- [Specifica completa v3](../family_hub_spec_v3.md) — entità, API, schema SQL, Docker, PWA
- [Repository GitHub](https://github.com/mccoy88f/Famylia)

---

*Documento generato per handoff allo sviluppo — Famylia v1.0*
