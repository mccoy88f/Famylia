#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/app"
flutter run -d chrome --dart-define=SERVER_URL=http://localhost:8080/
