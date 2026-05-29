# Fase 2 — Core finanziario e organizzativo

**Stato:** implementata (MVP)  
**Migration:** `migrations/20260528214000986`

## Moduli backend

| Modulo | Endpoint | Note |
|--------|----------|------|
| Scadenze | `deadline` | CRUD, `upcoming`, `complete`, stato OVERDUE automatico |
| Spese | `expense` | Split equal, `getBalance`, semplificazione debiti, `settlement` |
| Calendario | `calendar` | CRUD eventi, `listEvents(from, to)` |
| Bacheca | `board` | Post, sondaggi, voto, `watchBoard` real-time |
| Documenti | `document` | Upload bytes, storage locale `server/storage/`, OCR placeholder |
| Meal planner | `meal` | Ricette, piano settimanale, `shoppingItemsFromPlan` |

## App Flutter

- Dashboard Home: scadenze + chip moduli Fase 2
- Schermate: `/deadlines`, `/expenses`, `/expenses/balance`, `/calendar`, `/board`, `/documents`, `/meals`
- `file_picker` per upload documenti (web/desktop)

## Da completare (resto Fase 2)

- [ ] RRULE scadenze/eventi ricorrenti (parser completo)
- [ ] Notifiche `notify_before_hours` (job scheduler)
- [ ] MinIO in produzione (sostituire storage locale)
- [ ] OCR Tesseract reale
- [ ] Split percent/exact/shares in UI
- [ ] Viste calendario settimana/mese
- [ ] Test real-time bacheca (2 client)

## Comandi

```bash
export PATH="$HOME/.local/dart-sdk/bin:$HOME/.local/flutter/bin:$HOME/.pub-cache/bin:$PATH"
cd server && serverpod generate && serverpod create-migration  # se modifichi modelli
cd server && dart run bin/main.dart --apply-migrations
cd app && flutter pub get && flutter run -d chrome
./scripts/run-tests.sh
```
