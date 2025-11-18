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

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  log_err "Not a git repository."
  exit 1
fi

if ! command -v codex >/dev/null 2>&1; then
  log_err "codex CLI not found."
  exit 1
fi

LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")
if [ -z "$LAST_TAG" ]; then
  RANGE="HEAD"
  log_warn "No tags found. Using entire history."
else
  RANGE="${LAST_TAG}..HEAD"
  log "Using commit range: $RANGE"
fi

COMMITS=$(git log --pretty=format:'%h %s' $RANGE)

if [ -z "$COMMITS" ]; then
  log_warn "No commits found in range $RANGE."
  exit 0
fi

VERSION_HINT="${1:-}"
TODAY=$(date +%Y-%m-%d)

PROMPT=$(cat <<EOF
You are an expert release manager.

Task:
Generate a CHANGELOG section in Markdown for a new release of this repository.
Use the following constraints:
- Use English.
- Group changes under headings: "Added", "Changed", "Fixed", "Security", "Deprecated".
- Derive the groups from the commit messages.
- Use bullet lists under each heading.
- Avoid repeating commit hashes.
- Keep each line concise and informative.
- If a section has no items, omit it.

Version (if provided by user): $VERSION_HINT
Date: $TODAY

Commits in range ($RANGE):
$COMMITS

Output format example:

## vX.Y.Z - YYYY-MM-DD
### Added
- ...

### Changed
- ...

### Fixed
- ...

### Security
- ...

### Deprecated
- ...

Now generate only the CHANGELOG section. Do not add extra commentary.
EOF
)

log "Requesting CHANGELOG from Codex..."

SECTION=$(printf "%s\n" "$PROMPT" | codex 2>/dev/null || true)

if [ -z "${SECTION// /}" ]; then
  log_err "Codex returned empty content."
  exit 1
fi

CHANGELOG_FILE="CHANGELOG.md"

if [ -f "$CHANGELOG_FILE" ]; then
  log_ok "Appending new section to $CHANGELOG_FILE"
  TMPFILE="$(mktemp)"
  {
    echo "$SECTION"
    echo ""
    cat "$CHANGELOG_FILE"
  } > "$TMPFILE"
  mv "$TMPFILE" "$CHANGELOG_FILE"
else
  log_ok "Creating new $CHANGELOG_FILE"
  echo "# Changelog" > "$CHANGELOG_FILE"
  echo "" >> "$CHANGELOG_FILE"
  echo "$SECTION" >> "$CHANGELOG_FILE"
fi

log_ok "CHANGELOG updated."
echo ""
echo "$SECTION"

