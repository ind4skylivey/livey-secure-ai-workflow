#!/usr/bin/env bash

### ================================================================
###  LiveY Codex Toolkit — Universal Installer (v1.2)
### ================================================================
###   • Detects bash / zsh / fish
###   • Adds bin/ to PATH (safe, idempotent)
###   • Creates symlinks in ~/bin (optional)
###   • Checks git + SSH + Codex
### ================================================================

set -euo pipefail

CYAN="\033[1;36m"
MAGENTA="\033[1;35m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$REPO_ROOT/bin"
TARGET_BIN="$HOME/bin"

echo -e "${CYAN}⟁ LiveY Codex Toolkit — Universal Installer${RESET}"
echo -e "${MAGENTA}----------------------------------------------${RESET}"
echo ""

log_ok()    { echo -e " ${GREEN}✔${RESET} $1"; }
log_fail()  { echo -e " ${RED}✖${RESET} $1"; }
log_info()  { echo -e " ${CYAN}➜${RESET} $1"; }
log_warn()  { echo -e " ${YELLOW}⚠${RESET} $1"; }
log_done()  { echo -e "\n${GREEN}✨ Installation complete!${RESET}\n"; }

log_info "Checking dependencies..."

command -v git >/dev/null 2>&1  || { log_fail "git is not installed."; exit 1; }
log_ok "git found"

if ! command -v ssh >/dev/null 2>&1; then
  log_fail "ssh is not installed. Install it before using the toolkit."
  exit 1
else
  log_ok "ssh found"
fi

if ! command -v codex >/dev/null 2>&1; then
  log_warn "Codex CLI not found. cx-* commands may not work until you install it."
else
  log_ok "Codex CLI found"
fi

if [ ! -f "$HOME/.ssh/id_rsa.pub" ] && [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
  log_warn "No SSH key found (GitHub over SSH may fail)."
else
  log_ok "SSH key found"
fi

echo ""
echo -e "${CYAN}Choose install mode:${RESET}"
echo -e "  ${GREEN}[1]${RESET} Add toolkit bin/ to PATH (recommended)"
echo -e "  ${GREEN}[2]${RESET} Symlink cx-* into ~/bin"
echo -e "  ${GREEN}[3]${RESET} Both"
echo -e "  ${GREEN}[4]${RESET} Cancel"
echo ""
read -rp "Enter choice [1-4]: " choice
echo ""

install_path=0
install_symlink=0

case "$choice" in
  1) install_path=1 ;;
  2) install_symlink=1 ;;
  3) install_path=1; install_symlink=1 ;;
  4) log_info "Installation canceled."; exit 0 ;;
  *) log_warn "Invalid input, defaulting to option 1"; install_path=1 ;;
esac

SHELL_NAME=$(basename "$SHELL")
PROFILE=""

case "$SHELL_NAME" in
  bash) PROFILE="$HOME/.bashrc" ;;
  zsh)  PROFILE="$HOME/.zshrc" ;;
  fish) PROFILE="$HOME/.config/fish/config.fish" ;;
  *)    PROFILE="$HOME/.profile"; log_warn "Unknown shell '$SHELL_NAME', using $PROFILE";;
esac

if [ "$install_path" -eq 1 ]; then
  log_info "Adding $BIN_DIR to PATH in $PROFILE"
  if ! grep -q "$BIN_DIR" "$PROFILE" 2>/dev/null; then
    if [ "$SHELL_NAME" = "fish" ]; then
      echo "set -U fish_user_paths $BIN_DIR \$fish_user_paths" >> "$PROFILE"
    else
      echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$PROFILE"
    fi
    log_ok "PATH entry added to $PROFILE"
  else
    log_warn "PATH entry already present, skipping."
  fi
fi

if [ "$install_symlink" -eq 1 ]; then
  log_info "Creating symlinks in $TARGET_BIN"
  mkdir -p "$TARGET_BIN"
  for file in "$BIN_DIR"/cx-*; do
    [ -x "$file" ] || continue
    name=$(basename "$file")
    ln -sf "$file" "$TARGET_BIN/$name"
    log_ok "Linked $name → $TARGET_BIN"
  done
fi

log_info "Reloading shell configuration (might not affect current session)..."
case "$SHELL_NAME" in
  fish) source "$PROFILE" 2>/dev/null || true ;;
  *)    # best effort
        # shellcheck disable=SC1090
        source "$PROFILE" 2>/dev/null || true ;;
esac

if command -v cx-review >/dev/null 2>&1; then
  log_ok "cx-review detected in PATH"
else
  log_warn "cx-review not detected yet. You may need to open a new terminal."
fi

log_done
echo -e "${MAGENTA}Try:${RESET} cx-review"
echo -e "${MAGENTA}Or:${RESET} cx-uaep production"
exit 0

