# Fase 3 — Privacy, sicurezza e polish

**Stato:** implementata (MVP)  
**Migration:** `migrations/20260529053603526`

## Moduli backend

| Modulo | Endpoint | Note |
|--------|----------|------|
| GDPR | `gdpr` | Export JSON, delete account, privacy dashboard |
| Posizione | `location` | Opt-in, auto-off 24h, check-in, posizioni famiglia, safe zones |
| Emergenza | `emergency` | Panic/test, countdown lato UI, contatti, stream real-time |
| Gamification | `gamification` | Punti su complete todo, leaderboard |
| Report | `report` | Riepilogo famiglia + export CSV |

## App Flutter

- Sezione **Sicurezza e privacy** in Home
- Schermate: `/privacy`, `/location`, `/emergency`, `/reports`, `/leaderboard`
- Copy legale **«Famylia non sostituisce il 112»** in schermata emergenza

## Fuori scope MVP (documentato)

- Google OAuth / magic link / 2FA admin (richiede credenziali esterne)
- Google Calendar import
- Escalation SMS/chiamate automatiche
- Test e2e browser (Playwright)
- Tracking GPS nativo in background

## Comandi

```bash
cd server && dart run bin/main.dart --apply-migrations
cd app && flutter run -d chrome
./scripts/run-tests.sh
```
