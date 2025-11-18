#!/usr/bin/env bash
set -euo pipefail

CYAN="\033[1;36m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

log()      { echo -e "${CYAN}➜${RESET} $*"; }
log_ok()   { echo -e "${GREEN}✔${RESET} $*"; }
log_warn() { echo -e "${YELLOW}⚠${RESET} $*"; }
log_err()  { echo -e "${RED}✖${RESET} $*"; }

PROFILE_FILE="$HOME/.codex/config.toml"

MODEL_NAME="${1:-llama3}"
PORT="${2:-11434}"

log "Configuring local AI profile for model: $MODEL_NAME on port: $PORT"

if ! command -v codex >/dev/null 2>&1; then
  log_err "codex CLI not found."
  exit 1
fi

if ! nc -z localhost "$PORT" >/dev/null 2>&1; then
  log_warn "No service detected on localhost:$PORT. Make sure your local AI server (e.g. Ollama) is running."
else
  log_ok "Local service detected on port $PORT"
fi

if [ ! -f "$PROFILE_FILE" ]; then
  log_warn "No config at $PROFILE_FILE, creating a new one."
  mkdir -p "$(dirname "$PROFILE_FILE")"
  touch "$PROFILE_FILE"
fi

{
  echo ""
  echo "# Auto-generated local AI profile"
  echo "[mode.local_fast]"
  echo "provider = \"openai-compatible\""
  echo "api_url  = \"http://localhost:${PORT}/v1\""
  echo "model    = \"${MODEL_NAME}\""
  echo "temperature = 0.2"
} >> "$PROFILE_FILE"

log_ok "Appended [mode.local_fast] to $PROFILE_FILE"

echo ""
log_ok "Usage example:"
echo "  codex --profile local_fast cx-review"

