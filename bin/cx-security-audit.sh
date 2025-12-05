#!/usr/bin/env bash
set -euo pipefail

# Static redteam audit (scheduled / push)

PROMPT_FILE=""
TEMPLATE_FILE=""
WORKDIR="${WORKDIR:-$(pwd)}"
OUTPUT_DIR="${OUTPUT_DIR:-artifacts}"
LLM_PROVIDER="${LLM_PROVIDER:-openai}"
LLM_MODEL="${LLM_MODEL:-gpt-4o-mini}"
LLM_API_KEY="${LLM_API_KEY:-}"
LLM_ENDPOINT="${LLM_ENDPOINT:-}"
FAIL_ON_HIGH="${FAIL_ON_HIGH:-false}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --prompt) PROMPT_FILE="$2"; shift 2;;
    --template) TEMPLATE_FILE="$2"; shift 2;;
    *) echo "Unknown arg $1" >&2; exit 1;;
  esac
done

[[ -f "$PROMPT_FILE" ]] || { echo "Prompt not found: $PROMPT_FILE" >&2; exit 1; }
[[ -f "$TEMPLATE_FILE" ]] || { echo "Template not found: $TEMPLATE_FILE" >&2; exit 1; }

mkdir -p "$OUTPUT_DIR"
JSON_OUT="$OUTPUT_DIR/security-audit.json"
COMMENT_OUT="$OUTPUT_DIR/security-audit-comment.md"

if [[ -z "$LLM_API_KEY" && "$LLM_PROVIDER" != "local" ]]; then
  echo "LLM_API_KEY required for provider $LLM_PROVIDER" >&2; exit 1
fi

detect_base() {
  if git -C "$WORKDIR" rev-parse --verify origin/main >/dev/null 2>&1; then
    echo "origin/main"
  elif git -C "$WORKDIR" rev-parse --verify origin/master >/dev/null 2>&1; then
    echo "origin/master"
  else
    echo "HEAD~1"
  fi
}

BASE_REF=$(detect_base)
DIFF_RAW=$(git -C "$WORKDIR" diff --no-color "${BASE_REF}"...HEAD --unified=5 || true)

mask_payload() {
  python3 - <<'PY'
import sys,re
data=sys.stdin.read()
patterns=[
    r'AKIA[0-9A-Z]{16}',
    r'ASIA[0-9A-Z]{16}',
    r'(?i)(api[_-]?key|secret|token|password)\s*[:=]\s*[\'"]?([A-Za-z0-9/\.\-_=+]{10,})',
    r'-----BEGIN [A-Z ]*PRIVATE KEY-----.*?-----END [A-Z ]*PRIVATE KEY-----'
]
for pat in patterns:
    data=re.sub(pat, lambda m: m.group(0)[:6]+"***MASKED***", data, flags=re.DOTALL)
print(data)
PY
}

DIFF=$(printf "%s" "$DIFF_RAW" | mask_payload)
SNAPSHOT=$(git -C "$WORKDIR" ls-tree -r --name-only HEAD | head -n 200 | while read -r f; do git -C "$WORKDIR" show "HEAD:${f}"; done | head -n 2000 | mask_payload)

trim_diff() { echo "$DIFF" | head -n 4000; }
TRIMMED_DIFF=$(trim_diff)

payload=$(jq -n \
  --arg model "$LLM_MODEL" \
  --arg prompt "$(cat "$PROMPT_FILE")" \
  --arg diff "$TRIMMED_DIFF" \
  --arg snap "$SNAPSHOT" \
  '{model:$model,temperature:0,max_tokens:2000,
    messages:[
      {role:"system",content:$prompt},
      {role:"user",content:("Perform static redteam audit.\nDiff:\n```\n"+$diff+"\n```\nSample files:\n```\n"+$snap+"\n```")}
    ]}')

call_llm() {
  case "$LLM_PROVIDER" in
    openai)
      curl -sS -H "Authorization: Bearer $LLM_API_KEY" \
           -H "Content-Type: application/json" \
           -d "$payload" https://api.openai.com/v1/chat/completions | jq -r '.choices[0].message.content'
      ;;
    anthropic)
      curl -sS -H "x-api-key: $LLM_API_KEY" \
           -H "Content-Type: application/json" \
           -d "$payload" https://api.anthropic.com/v1/messages | jq -r '.content[0].text'
      ;;
    mistral|deepseek|qwen)
      curl -sS -H "Authorization: Bearer $LLM_API_KEY" \
           -H "Content-Type: application/json" \
           -d "$payload" "${LLM_ENDPOINT:-https://api.mistral.ai/v1/chat/completions}" | jq -r '.choices[0].message.content'
      ;;
    local)
      if [[ "${LLM_ENDPOINT:-http://localhost:11434/api/generate}" == *"/generate"* ]]; then
        gen_payload=$(jq -n \
          --arg model "$LLM_MODEL" \
          --arg prompt "$(cat "$PROMPT_FILE")" \
          --arg diff "$TRIMMED_DIFF" \
          --arg snap "$SNAPSHOT" \
          '{model:$model,prompt:($prompt+"\n\nDiff:\n```\n"+$diff+"\n```\nSample files:\n```\n"+$snap+"\n```"),stream:false}')
        curl -sS -H "Content-Type: application/json" \
             -d "$gen_payload" "${LLM_ENDPOINT:-http://localhost:11434/api/generate}" | jq -r '.response // .message // .choices[0].message.content'
      else
        curl -sS -H "Content-Type: application/json" \
             -d "$payload" "${LLM_ENDPOINT:-http://localhost:11434/api/chat}" | jq -r '.message.content // .choices[0].message.content'
      fi
      ;;
    *)
      echo "Unsupported provider $LLM_PROVIDER" >&2; exit 1;;
  esac
}

RAW_RESPONSE=$(call_llm)

echo "$RAW_RESPONSE" | python3 - "$JSON_OUT" <<'PY'
import json, re, sys
from pathlib import Path
text = sys.stdin.read()
text = re.sub(r'```(json)?|```','',text).strip()
try:
    data = json.loads(text)
except Exception:
    data = {"summary": text[:400], "findings": [], "max_severity": "unknown"}
Path(sys.argv[1]).write_text(json.dumps(data, indent=2))
PY

MAX_SEV=$(jq -r '.max_severity // "unknown"' "$JSON_OUT")

python3 - "$TEMPLATE_FILE" "$JSON_OUT" "$COMMENT_OUT" <<'PY'
import json, sys
from pathlib import Path
tmpl = Path(sys.argv[1]).read_text()
data = json.loads(Path(sys.argv[2]).read_text())
body = tmpl.format(
    summary=data.get("summary",""),
    findings=json.dumps(data.get("findings",[]), indent=2),
    max_severity=data.get("max_severity","unknown")
)
Path(sys.argv[3]).write_text(body)
PY

if [[ "$FAIL_ON_HIGH" == "true" && ( "$MAX_SEV" == "high" || "$MAX_SEV" == "critical" ) ]]; then
  echo "High severity findings detected; failing." >&2
  exit 1
fi

echo "Security audit complete (max severity: $MAX_SEV)"
