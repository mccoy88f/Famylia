#!/usr/bin/env bash
# Avvia PostgreSQL locale (porta 8090) senza Docker
set -euo pipefail

PG_ROOT="${PG_ROOT:-$HOME/.local/pg-install}"
PG_BIN="$PG_ROOT/usr/lib/postgresql/18/bin"
PGDATA="${PGDATA:-$HOME/.local/pgdata/famylia}"
export LD_LIBRARY_PATH="$PG_ROOT/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH:-}"

if [ ! -x "$PG_BIN/postgres" ]; then
  echo "PostgreSQL non installato. Esegui prima: ./scripts/install-local-deps.sh"
  exit 1
fi

mkdir -p "$HOME/.local/pgdata/run"

if [ ! -f "$PGDATA/PG_VERSION" ]; then
  echo "==> initdb"
  "$PG_BIN/initdb" -D "$PGDATA" -U postgres --auth-host=trust --auth-local=trust
  {
    echo "port = 8090"
    echo "listen_addresses = 'localhost'"
    echo "unix_socket_directories = '$HOME/.local/pgdata/run'"
  } >> "$PGDATA/postgresql.conf"
fi

if ! "$PG_BIN/pg_isready" -h localhost -p 8090 -q 2>/dev/null; then
  echo "==> avvio postgres :8090"
  "$PG_BIN/pg_ctl" -D "$PGDATA" -l "$HOME/.local/pgdata/famylia.log" start
  sleep 2
fi

"$PG_BIN/psql" -h localhost -p 8090 -U postgres -d postgres -tc \
  "SELECT 1 FROM pg_roles WHERE rolname='famylia'" | grep -q 1 || \
  "$PG_BIN/psql" -h localhost -p 8090 -U postgres -d postgres -c \
  "CREATE USER famylia WITH PASSWORD 'changeme_famylia_db' CREATEDB;"

"$PG_BIN/psql" -h localhost -p 8090 -U postgres -d postgres -tc \
  "SELECT 1 FROM pg_database WHERE datname='famylia'" | grep -q 1 || \
  "$PG_BIN/psql" -h localhost -p 8090 -U postgres -d postgres -c \
  "CREATE DATABASE famylia OWNER famylia;"

echo "PostgreSQL pronto su localhost:8090 (utente/db: famylia)"
