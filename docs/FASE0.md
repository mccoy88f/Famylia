# Fase 0 — Stato implementazione

## Obiettivi Fase 0

- [x] Struttura monorepo (`app/`, `server/`, `client/`, `docker/`, `scripts/`)
- [x] Docker Compose (Postgres, Redis, MinIO nello stack `docker/`)
- [x] Serverpod: modelli famiglia, endpoint, auth module
- [x] Flutter: tema, routing, login, register, onboarding, home placeholder
- [x] PWA `manifest.json`
- [x] Script setup e README
- [x] `serverpod generate` eseguito
- [x] Migration creata (`migrations/20260528204013540`)
- [x] App collegata al client reale (auth + family API)
- [x] Migration applicata
- [x] Server avviato (PostgreSQL locale porta 8090, senza Docker)
- [x] Smoke test API (`scripts/smoke_test.dart`)
- [ ] CI verde

## Modelli database

| Modello | Tabella | Descrizione |
|---------|---------|-------------|
| `Family` | `family` | Gruppo familiare con `inviteCode` |
| `FamilyMember` | `family_member` | Utente ↔ famiglia + ruolo |
| `FamilyRole` | enum | `admin`, `member`, `guest` |
| `FamilyWithRole` | — | DTO risposta `listMyFamilies` |

Tabelle auth: gestite dal modulo `serverpod_auth` dopo migration.

## Endpoint `FamilyEndpoint`

| Metodo | Descrizione |
|--------|-------------|
| `createFamily(name)` | Crea famiglia + admin |
| `joinFamily(inviteCode)` | Join tramite codice |
| `listMyFamilies()` | Elenco famiglie utente |
| `getFamily(familyId)` | Dettaglio (solo membri) |
| `listMembers(familyId)` | Membri |
| `leaveFamily(familyId)` | Abbandona famiglia |

## UI Flutter (flussi)

```
Login / Register → Onboarding (crea | join) → Home
```

Auth e family API usano **`famylia_client`** e `serverpod_auth` (email/password).

## Prossimo passo (fine Fase 0)

1. Avviare Docker + `./scripts/dev-server.sh`
2. `./scripts/dev-app.sh`
3. Registrarsi: il codice verifica appare nei **log del server** (dev)
4. Issue **FAM-011**: CI senza `continue-on-error`

## Riferimenti

- [PIANO_SVILUPPO.md](PIANO_SVILUPPO.md) — roadmap completa
- [Serverpod Auth 2.5](https://docs.serverpod.dev/2.5.0/concepts/authentication/setup)
