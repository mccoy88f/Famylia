# Fase 1 — MVP quotidiano (in corso)

## Obiettivo

Todo, lista spesa e dashboard per uso familiare quotidiano.

## Completato

### Backend (Serverpod)

- Modelli: `TodoItem`, `ShoppingList`, `ShoppingItem` + enum
- Endpoint: `TodoEndpoint`, `ShoppingEndpoint`
- Utility condivisa: `family_access.dart`
- Migration: `migrations/20260528210057383`

### App Flutter

- Repository: `TodoRepository`, `ShoppingRepository`
- Cache offline lista spesa: `ShoppingOfflineStore` (Hive)
- Schermate: Home (dashboard), Todo, Liste spesa, Dettaglio lista
- Navigation shell a 3 tab

## API principali

| Endpoint | Metodi |
|----------|--------|
| `todo` | `createTodo`, `listTodos`, `myDay`, `completeTodo`, `deleteTodo` |
| `shopping` | `createList`, `listLists`, `getList`, `addItem`, `checkItem`, `deleteItem`, `completeList` |

## Completato (continuazione)

- [x] Real-time lista spesa (`watchList` + MessageCentral, WebSocket)
- [x] Sync automatico al reconnect (`ConnectivitySync`)
- [x] Assegnazione task (long-press → picker membri)
- [x] Categorie colorate lista spesa
- [x] `assignTodo` endpoint

## Da fare (resto Fase 1)

- [ ] Test integrazione shopping multi-utente (2 browser)
- [ ] Service worker PWA completo (build produzione)
- [x] Nomi membri (`FamilyMemberInfo.displayName` da UserInfo auth)

## Avvio dev

```bash
./scripts/start-postgres.sh
cd server && dart run bin/main.dart --apply-migrations
cd app && flutter run -d chrome
```
