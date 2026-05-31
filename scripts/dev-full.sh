#!/usr/bin/env bash
# Stack completo: Docker (backend) + Flutter web (UI)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

"$ROOT/scripts/docker-up.sh"

echo ""
echo "==> Avvio app Flutter (terminale separato consigliato per hot reload)"
echo "    URL app: http://127.0.0.1:8083"
echo ""

exec "$ROOT/scripts/dev-app.sh"
