#!/usr/bin/env bash
# Esegue tutti i test locali (unit + smoke API)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$HOME/.local/dart-sdk/bin:$HOME/.local/flutter/bin:$HOME/.pub-cache/bin:$PATH"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-$HOME/.local/pg-install/usr/lib/x86_64-linux-gnu}"

cd "$ROOT"

echo "==> PostgreSQL"
if command -v docker >/dev/null 2>&1; then
  (cd server && docker compose up -d)
else
  ./scripts/start-postgres.sh
fi

echo "==> Migration"
if ! curl -sf http://localhost:8080/ >/dev/null 2>&1; then
  (cd server && dart run bin/main.dart --role maintenance --apply-migrations)
fi

echo "==> Server (se non già in esecuzione)"
if ! curl -sf http://localhost:8080/ >/dev/null 2>&1; then
  echo "Avvia il server in un altro terminale:"
  echo "  cd server && dart run bin/main.dart --apply-migrations"
  echo "Oppure attendo 3s e provo smoke test comunque..."
  sleep 1
fi

echo "==> dart analyze (server)"
(cd server && dart analyze)

echo "==> flutter test (app)"
(cd app && flutter test)

echo "==> smoke test API"
(cd scripts && dart pub get && dart run smoke_test.dart)

echo ""
echo "✅ Tutti i test completati"
