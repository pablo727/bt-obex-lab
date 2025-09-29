#!/usr/bin/env bash
set -euo pipefail

MAC="${1:-}"
COUNT="${2:-1}"
DELAY="${3:-3}"  # seconds between pushes
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OUTDIR="$BASE_DIR/out"

if [ -z "$MAC" ]; then
  echo "Usage: $0 <phone-mac> [count] [delay_seconds]"
  exit 1
fi

mkdir -p "$OUTDIR"

for i in $(seq 1 "$COUNT"); do
  FILE="$OUTDIR/lab_spam_${i}.txt"
  cat > "$FILE" <<EOF
Lab harmless file #$i
Created $(date --iso-8601=seconds)
Target: $MAC
Notes: Accept the file on your phone. This is non-destructive.
EOF
  echo "Pushing $FILE to $MAC (attempt $i/$COUNT)..."
  if command -v obexftp >/dev/null 2>&1; then
    if obexftp -b "$MAC" -p "$FILE"; then
      echo "OK: obexftp push succeeded."
    else
      echo "WARN: obexftp push failed; trying bluetooth-sendto..."
      bluetooth-sendto --device="$MAC" "$FILE" || echo "ERROR: push failed."
    fi
  else
    bluetooth-sendto --device="$MAC" "$FILE" && echo "OK: bluetooth-sendto succeeded." || echo "ERROR: bluetooth-sendto failed."
  fi
  sleep "$DELAY"
done

echo "Done - check your phone's Downloads/Bluetooth of Files app."
