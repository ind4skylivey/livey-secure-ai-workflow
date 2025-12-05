# Livey Secure AI Workflow
**Tagline:** Security-first, LLM-agnostic GitHub Actions that keep your code, secrets, and supply chain under continuous AI-assisted scrutiny.

```
 _     _ _                ____                          ___      ___ _       __          __        _  __        __
| |   (_) |__  _   _ ___ / ___|  ___  ___ _   _ _ __   / _ \    / _ | |     / / ___  ___| |/ /___  / / ___  ___/ /
| |   | | '_ \| | | / __| |  _  / _ \/ __| | | | '_ \ | | | |  | | | | | /| / / / _ \/ _ |   / __ \/ / / _ \/ _  / 
| |___| | |_) | |_| \__ | |_| |  __| (__| |_| | |_) || |_| |  | |_| | |/ |/ / |  __/  __|   |  __/ / |  __/ (_| | 
|_____|_|_.__/ \__,_|___/\____| \___|\___|\__,_| .__/  \___/    \___/|__/|__/   \___|\___|_|\_\___/_/ \___|\__,_| 
                                              |_|                                                                
```

## What is this?
Livey Secure AI Workflow is a production-ready suite of GitHub Actions, Bash helpers, and UAEP prompts that deliver secure code review, redteam-style static analysis, and secrets/dependency scanning without locking you to a single LLM vendor.

## Quickstart
```bash
git clone https://github.com/ind4skylivey/livey-secure-ai-workflow.git
cd livey-secure-ai-workflow
./install.sh
```
Add to your repo:
```bash
cp -r .github bin codex templates assets README.md SECURITY.md CHANGELOG.md .
```
Configure secrets/vars:
- `LLM_API_KEY` (not needed if `LLM_PROVIDER=local`)
- `LLM_PROVIDER` (openai|anthropic|mistral|deepseek|qwen|local)
- `LLM_MODEL` (e.g., gpt-4o-mini, claude-3.5-sonnet, mistral-large)
- `LLM_ENDPOINT` (for non-default or local endpoints)
- `FAIL_ON_HIGH` (`true|false`)

## Workflow Examples
- Secure code review on PRs: `.github/workflows/secure-code-review.yml`
- Scheduled static redteam audit: `.github/workflows/security-audit.yml`
- Secrets & dependency scan on PRs: `.github/workflows/secrets-scan.yml`

## Local Mode (no cloud)
```bash
LLM_PROVIDER=local LLM_ENDPOINT=http://localhost:11434/api/generate \
bin/cx-secure-pr.sh --prompt codex/prompts/secure_code_review.md --template templates/pr-code-review.md
```

## Supported LLM Providers
- OpenAI, Anthropic, Mistral, DeepSeek, Qwen
- Any OpenAI-compatible local HTTP endpoint

## Why this vs claude-code-workflows?
- Vendor neutral (no provider lock-in)
- Diff-only uploads to minimize data exposure
- UAEP prompt pack with redteam lens
- Optional “fail on high severity” gate
- Pure Bash + jq + curl; zero extra deps

## Advanced Usage
- Override output dir: `OUTPUT_DIR=out bin/cx-security-audit.sh ...`
- Point to custom prompts/templates for language-specific policies.
- Scope to a subdir: `WORKDIR=services/api bin/cx-secrets-scan.sh ...`
- Enforce blocking: `FAIL_ON_HIGH=true`

## SEO / Metadata
- **Meta description:** LLM-agnostic security GitHub Actions for code review, static audit, and secret scanning with minimal data leakage.
- **Keywords:** security workflow, GitHub Actions security, LLM code review, secrets scan, DevSecOps automation, red team CI, supply chain security.
- **Short marketing blurb:** Ship faster with AI that respects your boundaries—Livey Secure AI Workflow brings vendor-neutral security checks to every PR.

## GitHub Topics (recommend)
`security`, `github-actions`, `devsecops`, `code-review`, `llm`, `secrets-scanning`, `supply-chain-security`, `red-team`, `bash`, `uaep`

## Contributing
Follow the SECURITY model; do not submit secrets. Use `[TYPE] Message` commit format.

## License
MIT (or your org’s chosen license).
