#!/usr/bin/env bash
set -euo pipefail

# Minimal installer for Livey Secure AI Workflow

chmod +x bin/cx-secure-pr.sh
chmod +x bin/cx-security-audit.sh
chmod +x bin/cx-secrets-scan.sh

echo "Livey Secure AI Workflow installed."
echo "Ensure jq, curl, and python3 are available."
echo "Set LLM_API_KEY or use LLM_PROVIDER=local with LLM_ENDPOINT."
