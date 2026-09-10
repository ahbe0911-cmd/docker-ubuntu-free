#!/bin/sh
set -eu

: "${PROXY_USER:?PROXY_USER is required}"
: "${PROXY_PASSWORD:?PROXY_PASSWORD is required}"

PROXY_PORT="${PROXY_PORT:-1080}"

case "$PROXY_PORT" in
  ''|*[!0-9]*)
    echo "ERROR: PROXY_PORT must be numeric" >&2
    exit 1
    ;;
esac

if [ "$PROXY_PORT" -lt 1 ] || [ "$PROXY_PORT" -gt 65535 ]; then
  echo "ERROR: PROXY_PORT must be between 1 and 65535" >&2
  exit 1
fi

if [ ${#PROXY_USER} -lt 3 ]; then
  echo "ERROR: PROXY_USER must be at least 3 characters" >&2
  exit 1
fi

if [ ${#PROXY_PASSWORD} -lt 12 ]; then
  echo "ERROR: PROXY_PASSWORD must be at least 12 characters" >&2
  exit 1
fi

echo "Starting authenticated SOCKS5 proxy on 0.0.0.0:${PROXY_PORT}"
exec microsocks -i 0.0.0.0 -p "$PROXY_PORT" -u "$PROXY_USER" -P "$PROXY_PASSWORD"
