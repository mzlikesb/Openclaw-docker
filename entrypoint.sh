#!/bin/bash
set -e

# 볼륨이 비어있으면 기본 설정 복사
if [ ! -f /root/.openclaw/openclaw.json ]; then
  echo "[init] Empty volume detected, copying default config..."
  cp -a /root/.openclaw-defaults/. /root/.openclaw/
fi

# Start gateway in background
openclaw gateway run --allow-unconfigured &
GATEWAY_PID=$!

# Wait for gateway to be ready
sleep 5

# Auto-approve pairing requests loop
while kill -0 $GATEWAY_PID 2>/dev/null; do
  CODES=$(openclaw pairing list --channel telegram 2>/dev/null | grep -oE '[A-Z0-9]{6,}' || true)
  if [ -n "$CODES" ]; then
    for CODE in $CODES; do
      echo "[auto-pair] Approving telegram pairing code: $CODE"
      openclaw pairing approve --channel telegram "$CODE" --notify 2>/dev/null || true
    done
  fi
  sleep 3
done

wait $GATEWAY_PID
