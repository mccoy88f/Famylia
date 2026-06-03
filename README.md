# Famylia

**Famylia** is a self-hosted family companion app: one place to organise tasks, shopping, deadlines, shared expenses, calendar, and communication — with your data under your control (privacy-first).

Ideal for families, housemates, and couples who want to reduce the mental load of "the person who keeps everything in their head" and share responsibilities clearly.

---

## Features

### Daily use

| Feature | Description |
|---------|-------------|
| **Home** | Overview: open tasks, items to buy, upcoming deadlines |
| **Todo** | Household tasks with priority, due date, and member assignment |
| **Shopping list** | Shared lists, item check-off, colour-coded categories; works offline and syncs when back online |
| **Meals** | Recipe book and weekly planner; generates ingredients for the shopping list |
| **Health** | Medical appointments, family diets, and sports activities (planning and status) |

### Home organisation

| Feature | Description |
|---------|-------------|
| **Deadlines** | Bills, taxes, subscriptions: amounts, dates, status (to pay / paid / overdue) |
| **Shared expenses** | Who paid what, equal split among members, balance and suggestions to settle debts |
| **Calendar** | Family events (birthdays, school, appointments) |
| **Board** | Messages, announcements, and quick polls ("what are we having for dinner?") with real-time updates |
| **Documents** | Upload receipts and useful files, linked to expenses or deadlines |

### Safety and privacy

| Feature | Description |
|---------|-------------|
| **Location** | Sharing only if you enable it (opt-in), "I've arrived" check-in, auto-disable after 24 hours |
| **Emergency** | Family alert button with countdown to avoid false triggers and test mode |
| **Privacy / GDPR** | Export your data, dashboard on who sees what, option to delete your account |
| **Leaderboard** | Points and leaderboard for completed tasks (light gamification) |
| **Reports** | Activity and expense summaries, CSV export |

### Family

- **Create a family** or **join with an invite code**
- Multiple members with roles (admin, member, guest)
- One account can belong to multiple families (quick switch: in development)

---

## AI assistant — MarIA

Famylia includes **MarIA**, a configurable AI assistant powered by OpenRouter or Google Gemini.

- Analyses shared content (text, files) and pre-fills new activities
- Per-family monthly quota (token limit and/or cost limit in USD)
- Quota exceeded: users see a clear dialog with the reset date
- All AI config managed from the **Admin Dashboard**

---

## Admin Dashboard

The admin dashboard (accessible at `/admin` in the Flutter app) lets operators:

- **AI Config**: choose provider (OpenRouter / Gemini), pick a model with vision-support and free/paid indicators, set the system prompt
- **Family Quota**: load and update per-family token or cost limits
- **Usage Stats**: see token usage and cost grouped by family for the last N days
- Login protected via `ADMIN_EMAIL` / `ADMIN_PASSWORD` environment variables

---

## Getting started (user)

1. Open Famylia in the browser (installable as a PWA on phone and desktop).
2. **Sign up** with email and password.
3. **Create your family** or **join** with an invite code received from another member.
4. Use the sections from the Home: Todo, Shopping, Deadlines, Expenses, etc.

> **Registration in test environment:** if the verification email does not arrive, the code is shown in the app (development) or in server logs. In production a real email is sent.

> **Emergency:** Famylia **does not replace emergency services**. In case of immediate danger call 112 (EU) or your local emergency number.

---

## Technical information

### Stack

| Component | Technology |
|-----------|------------|
| Frontend | Flutter Web (PWA) |
| Backend | Serverpod 2.5 (Dart) |
| Database | PostgreSQL 16 |
| Cache | Redis 7 (optional in dev) |
| File storage | Local / MinIO (Phase 2+) |
| Deploy | Docker Compose |

### Project structure

```
Famylia/
├── app/          # Flutter PWA
├── client/       # Serverpod client (generated)
├── server/       # Serverpod backend
├── docker/       # Full stack (Postgres, Redis, MinIO)
├── docs/         # Development documentation
└── scripts/      # Setup and test scripts
```

### Development requirements

- [Dart SDK](https://dart.dev/get-dart) ≥ 3.3
- [Flutter](https://flutter.dev) ≥ 3.22 (web enabled)
- PostgreSQL — Docker or local (`scripts/start-postgres.sh`)
- Serverpod CLI: `dart pub global activate serverpod_cli 2.5.1`

### Quick start (development)

**Full stack on Docker** (backend + web interface):

```bash
chmod +x scripts/*.sh
./scripts/docker-up.sh
```

| What | URL |
|------|-----|
| **App (browser)** | **http://localhost:8083** |
| Serverpod API | http://localhost:8080 |

The first app build in Docker may take a few minutes.

Logs: `cd docker && docker compose logs -f server` or `logs -f app`

**DB only on Docker + local server** (ports 8090/8091):

```bash
./scripts/start-postgres.sh   # or: cd server && docker compose up -d
cd server && dart run bin/main.dart --apply-migrations
cd app && flutter run -d web-server --web-hostname=127.0.0.1 --web-port=8081
```

- Server API: `http://localhost:8080/`
- App web: `http://127.0.0.1:8081`

### Environment variables

| Variable | Description | Default |
|----------|-------------|---------|
| `ADMIN_EMAIL` | Admin dashboard login email | `admin@famylia.app` |
| `ADMIN_PASSWORD` | Admin dashboard login password | *(empty — login disabled)* |
| `OPENROUTER_API_KEY` | API key for OpenRouter models | — |
| `GEMINI_API_KEY` | API key for Google Gemini models | — |

### Development documentation

| Document | Content |
|----------|---------|
| [docs/PIANO_SVILUPPO.md](docs/PIANO_SVILUPPO.md) | Roadmap and phases |
| [docs/FASE0.md](docs/FASE0.md) | Auth and family |
| [docs/FASE1.md](docs/FASE1.md) | Todo, shopping, dashboard |
| [docs/FASE2.md](docs/FASE2.md) | Deadlines, expenses, calendar, board, documents, meals |
| [docs/FASE3.md](docs/FASE3.md) | Privacy, location, emergency, reports |
| [family_hub_spec_v3.md](family_hub_spec_v3.md) | Full specification |

### Implementation status

| Phase | Main content |
|-------|-------------|
| Phase 0 | Auth, family, onboarding |
| Phase 1 | Todo, shopping list, dashboard, offline shopping |
| Phase 2 | Deadlines, expenses, calendar, board, documents, meal planner |
| Phase 3 | GDPR, location, emergency, gamification, reports |
| AI / Admin | MarIA assistant, per-family quotas, admin dashboard |

### License

To be defined.
