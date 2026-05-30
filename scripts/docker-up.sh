#!/usr/bin/env bash
# Avvia stack Famylia su Docker (Postgres, Redis, MinIO, Serverpod)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/docker"

if [ ! -f .env ]; then
  cp .env.example .env
  echo "Creato docker/.env da .env.example"
fi

if [ ! -f "$ROOT/server/config/passwords.yaml" ]; then
  cp "$ROOT/server/config/passwords.docker.yaml" "$ROOT/server/config/passwords.yaml"
  echo "Creato server/config/passwords.yaml (sviluppo locale)"
fi

echo "==> Build e avvio container..."
docker compose up -d --build

echo ""
echo "Servizi:"
echo "  API Serverpod:  http://localhost:8080"
echo "  Insights:       http://localhost:8081"
echo "  Web (relays):   http://localhost:8082"
echo "  PostgreSQL:     localhost:5432"
echo "  Redis:          localhost:6379"
echo "  MinIO API:      http://localhost:9000"
echo "  MinIO Console:  http://localhost:9001"
echo ""
echo "Log server: docker compose -f $ROOT/docker/docker-compose.yml logs -f server"
