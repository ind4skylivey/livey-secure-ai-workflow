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
  log_err "Not inside a git repository."
  exit 1
fi

if ! command -v codex >/dev/null 2>&1; then
  log_err "codex CLI not found in PATH."
  exit 1
fi

TITLE_HINT="${1:-}"

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
DEFAULT_BASE="main"

log "Preparing PR context for branch: ${CURRENT_BRANCH}"

BASE_BRANCH="${DEFAULT_BASE}"
if git show-ref --verify --quiet "refs/heads/dev"; then
  BASE_BRANCH="dev"
fi

log "Using base branch: ${BASE_BRANCH}"

MERGE_BASE=$(git merge-base "$BASE_BRANCH" "$CURRENT_BRANCH" || echo "$BASE_BRANCH")
COMMITS=$(git log --oneline "${MERGE_BASE}..${CURRENT_BRANCH}")
DIFF_SUMMARY=$(git diff --stat "${MERGE_BASE}..${CURRENT_BRANCH}")
DIFF_PATCH=$(git diff "${MERGE_BASE}..${CURRENT_BRANCH}")

if [ -z "$COMMITS" ] && [ -z "$DIFF_PATCH" ]; then
  log_warn "No changes detected between $BASE_BRANCH and $CURRENT_BRANCH."
  exit 0
fi

PROMPT=$(cat <<EOF
You are an expert software engineer and technical writer.

Task:
Generate a high-quality Pull Request title and description using the following constraints:
- Use concise and meaningful titles (max ~80 characters).
- Use English.
- Use a tone: professional, clear, security-conscious.
- Highlight breaking changes.
- List impacted areas.
- Include a short 'Testing' section.
- Include a short 'Risk' section.
- Output in Markdown.

Format:
# Title

## Summary
- ...

## Changes
- ...

## Testing
- ...

## Risks
- ...

## Notes
- ...

Context:
- Base branch: $BASE_BRANCH
- Feature branch: $CURRENT_BRANCH

Commits:
$COMMITS

Diff Summary:
$DIFF_SUMMARY

Patch (trimmed if large):
$DIFF_PATCH
EOF
)

log "Asking Codex to generate PR description..."

PR_MD=$(printf "%s\n" "$PROMPT" | codex 2>/dev/null || true)

if [ -z "${PR_MD// /}" ]; then
  log_err "Codex did not return any content."
  exit 1
fi

echo ""
echo -e "${GREEN}=== Suggested Pull Request Content ===${RESET}"
echo "$PR_MD"
echo -e "${GREEN}======================================${RESET}"
echo ""

if command -v gh >/dev/null 2>&1; then
  read -rp "Create PR using GitHub CLI now? [y/N]: " ans
  case "$ans" in
    y|Y)
      TMPFILE="$(mktemp)"
      echo "$PR_MD" > "$TMPFILE"
      FIRST_LINE=$(echo "$PR_MD" | sed -n '1p' | sed 's/^# //')
      gh pr create \
        --base "$BASE_BRANCH" \
        --head "$CURRENT_BRANCH" \
        --title "$FIRST_LINE" \
        --body-file "$TMPFILE" || log_warn "gh pr create failed."
      rm -f "$TMPFILE"
      ;;
    *)
      log "Skipping automatic PR creation."
      ;;
  esac
else
  log_warn "GitHub CLI (gh) not found. You can paste the above content into your PR manually."
fi

log_ok "cx-pr finished."

