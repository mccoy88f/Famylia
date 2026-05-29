#!/usr/bin/env bash
# Installa Dart/Flutter user-local + PostgreSQL da pacchetti .deb (senza sudo)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$HOME/.local/dart-sdk/bin:$HOME/.local/flutter/bin:$HOME/.pub-cache/bin:$PATH"

echo "==> Dart SDK"
if ! command -v dart >/dev/null; then
  mkdir -p "$HOME/.local"
  tmp=/tmp/dart-sdk.zip
  curl -fsSL -o "$tmp" \
    https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-linux-x64-release.zip
  unzip -q -o "$tmp" -d "$HOME/.local/"
fi
dart --version

echo "==> Flutter SDK"
if ! command -v flutter >/dev/null; then
  tmp=/tmp/flutter.tar.xz
  curl -fsSL -o "$tmp" \
    https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.29.3-stable.tar.xz
  tar xf "$tmp" -C "$HOME/.local/"
fi
flutter --version | head -1

echo "==> Serverpod CLI"
dart pub global activate serverpod_cli 2.5.1

echo "==> PostgreSQL (estratto da .deb)"
PG_DEB="$HOME/.local/pg-debs"
PG_ROOT="$HOME/.local/pg-install"
mkdir -p "$PG_DEB"
cd "$PG_DEB"
apt-get download postgresql-18 postgresql-client-18 postgresql-common libpq5 2>/dev/null || true
mkdir -p "$PG_ROOT"
for deb in *.deb; do
  [ -f "$deb" ] && dpkg-deb -x "$deb" "$PG_ROOT"
done

echo ""
echo "Aggiungi al tuo ~/.bashrc:"
echo '  export PATH="$HOME/.local/dart-sdk/bin:$HOME/.local/flutter/bin:$HOME/.pub-cache/bin:$PATH"'
echo '  export LD_LIBRARY_PATH="$HOME/.local/pg-install/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"'
echo ""
echo "Poi: ./scripts/start-postgres.sh && ./scripts/run-tests.sh"
