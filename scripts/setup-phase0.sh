#!/usr/bin/env bash
# Setup Fase 0 — richiede Dart SDK, Flutter, Docker
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "==> Famylia — setup Fase 0"

if ! command -v dart >/dev/null 2>&1; then
  echo "ERRORE: Dart SDK non trovato. Installa da https://dart.dev/get-dart"
  exit 1
fi

if ! command -v flutter >/dev/null 2>&1; then
  echo "ERRORE: Flutter non trovato. Installa da https://flutter.dev"
  exit 1
fi

echo "==> Attiva Serverpod CLI"
dart pub global activate serverpod_cli 2.5.1
export PATH="$PATH:$HOME/.pub-cache/bin"

echo "==> Passwords server"
if [ ! -f server/config/passwords.yaml ]; then
  cp server/config/passwords.example.yaml server/config/passwords.yaml
  echo "Creato server/config/passwords.yaml"
fi

echo "==> Dipendenze server"
cd server
dart pub get

echo "==> Genera codice Serverpod"
serverpod generate

echo "==> Migration iniziale (se non esiste)"
if [ ! -d migrations ]; then
  serverpod create-migration
fi

echo "==> Avvia database locale (porta 8090/8091)"
docker compose up -d

echo "==> Applica migration"
dart run bin/main.dart --role maintenance --apply-migrations

cd "$ROOT/client"
dart pub get

cd "$ROOT/app"
flutter pub get

echo ""
echo "Setup completato."
echo "  Server:  cd server && dart run bin/main.dart"
echo "  App web: cd app && flutter run -d chrome"
echo ""
