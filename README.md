# Famylia

Companion app **privacy-first** per la gestione familiare: task, lista spesa, scadenze, spese condivise e altro.

- **Repository:** [github.com/mccoy88f/Famylia](https://github.com/mccoy88f/Famylia)
- **Piano di sviluppo:** [docs/PIANO_SVILUPPO.md](docs/PIANO_SVILUPPO.md)
- **Specifica:** [family_hub_spec_v3.md](family_hub_spec_v3.md)

## Stack

| Componente | Tecnologia |
|------------|------------|
| Frontend | Flutter Web (PWA) |
| Backend | Serverpod 2.5 (Dart) |
| Database | PostgreSQL 16 |
| Cache | Redis 7 |
| Storage | MinIO (Fase 2+) |
| Deploy | Docker Compose |

## Struttura progetto

```
Famylia/
├── app/          # Flutter PWA
├── client/       # Client Serverpod (generato)
├── server/       # Backend Serverpod
├── docker/       # Stack completo (Postgres, Redis, MinIO)
├── docs/         # Documentazione
└── scripts/      # Setup e sviluppo
```

## Requisiti

- [Dart SDK](https://dart.dev/get-dart) ≥ 3.3
- [Flutter](https://flutter.dev) ≥ 3.22 (canale stable, web abilitato)
- PostgreSQL — **Docker** oppure installazione locale (`scripts/install-local-deps.sh`)
- Serverpod CLI: `dart pub global activate serverpod_cli 2.5.1`

## Avvio rapido (Fase 0)

### 1. Dipendenze (prima volta, senza sudo)

```bash
chmod +x scripts/*.sh
./scripts/install-local-deps.sh   # Dart, Flutter, PostgreSQL in ~/.local
./scripts/start-postgres.sh       # DB su localhost:8090
```

### 2. Setup progetto

```bash
./scripts/setup-phase0.sh         # generate, migration (salta Docker se assente)
```

### 3. Test completi

```bash
./scripts/run-tests.sh            # analyze + flutter test + smoke API
```

Lo script:

- copia `server/config/passwords.example.yaml` → `passwords.yaml`
- esegue `serverpod generate` e crea le migration
- avvia Postgres/Redis in `server/docker-compose.yaml`
- applica le migration

### 4. Avvio manuale

```bash
# Database: Docker OPPURE Postgres locale
./scripts/start-postgres.sh
# oppure: cd server && docker compose up -d

# Passwords
cp config/passwords.example.yaml config/passwords.yaml

# Genera codice e migration
dart pub global activate serverpod_cli 2.5.1
dart pub get
serverpod generate
serverpod create-migration   # solo la prima volta

# Applica migration e avvia server
dart run bin/main.dart --apply-migrations

# App (altro terminale)
cd ../app
flutter pub get
flutter run -d chrome
```

Server: `http://localhost:8080/`  
Insights: `http://localhost:8081/`

### Stack Docker completo (opzionale)

```bash
cd docker
cp .env.example .env
docker compose up -d
```

## Stato sviluppo

| Fase | Stato |
|------|--------|
| Fase 0 | Auth + famiglia |
| Fase 1 | Todo + lista spesa + dashboard (in corso) |

Vedi [docs/FASE1.md](docs/FASE1.md).

## Stato Fase 0

| Componente | Stato |
|------------|--------|
| Modelli `Family`, `FamilyMember`, `FamilyRole` | ✅ YAML pronti |
| Endpoint `FamilyEndpoint` | ✅ Implementato |
| Auth Serverpod (`serverpod_auth`) | ✅ Configurato nel server |
| UI login / register / onboarding | ✅ Shell Flutter (stub API fino a `generate`) |
| PWA manifest | ✅ |
| Docker Compose | ✅ |

L'app è collegata al client Serverpod generato (`famylia_client`) con auth email e API famiglia.

**Registrazione in sviluppo:** il codice di verifica viene stampato nei log del server (configura SMTP in produzione).

Vedi [docs/FASE0.md](docs/FASE0.md) per il dettaglio.

## Licenza

Da definire.
