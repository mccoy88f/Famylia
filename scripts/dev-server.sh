#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$HOME/.local/dart-sdk/bin:$HOME/.pub-cache/bin:$PATH"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-$HOME/.local/pg-install/usr/lib/x86_64-linux-gnu}"

if command -v docker >/dev/null 2>&1; then
  cd "$ROOT/server" && docker compose up -d
else
  "$ROOT/scripts/start-postgres.sh"
fi

cd "$ROOT/server"
dart run bin/main.dart --apply-migrations
