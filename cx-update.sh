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

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ ! -d "$REPO_ROOT/.git" ]; then
  log_err "This does not look like a git repository: $REPO_ROOT"
  exit 1
fi

cd "$REPO_ROOT"

log "Updating LiveY Codex Toolkit from origin..."

git fetch --all --prune
git status --short

if ! git diff --quiet; then
  log_warn "You have local changes. Update might conflict."
  read -rp "Continue with git pull? [y/N]: " ans
  case "$ans" in
    y|Y) ;;
    *) log_warn "Aborting update."; exit 0 ;;
  esac
fi

git pull --rebase || { log_err "git pull --rebase failed."; exit 1; }

log_ok "Repository updated."

if [ -f "./install.sh" ]; then
  log "Re-running install.sh to refresh PATH and symlinks..."
  ./install.sh || log_warn "install.sh failed, but repository is updated."
else
  log_warn "install.sh not found. Skipping re-install."
fi

log_ok "cx-update finished."

