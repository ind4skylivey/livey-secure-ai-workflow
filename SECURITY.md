# Security Model

## Threat Boundaries
- Data sent to LLMs is limited to `git diff` and minimal context; full files are not uploaded.
- Secrets are masked where patterns are detected before sending.
- Local-only mode prevents any external egress.

## Permission Scopes
- GitHub Actions tokens limited to `contents:read` and `pull-requests:write`.
- No package installation beyond `jq`.
- Optional `id-token:write` reserved for future OIDC attestation.

## API Keys
- Store LLM provider keys only as GitHub Secrets (e.g., `LLM_API_KEY`); never commit or log them.
- Workflows skip automatically if no key is present unless `LLM_PROVIDER=local`.
- Prefer least-privilege keys and rotate regularly.

## How Not to Leak Code
- Always prefer diff-scoped reviews.
- Avoid pasting stack traces containing secrets into prompts.
- When running locally, keep `LLM_PROVIDER=local` for air-gapped workflows.

## Safe Prompting Principles
- Explicit system instructions to mask tokens and avoid speculation.
- Severity scoring enforces clarity and minimizes verbose dumps.
- Guardrails disallow fabricated code and secret echoing.

## Incident Response
- If a secret is detected in output: rotate immediately, purge history, rerun scan.
- If unintended data egress is suspected: disable workflows, audit runner logs, rotate tokens.

## Contact
ind4skylivey (maintainer). Use encrypted channels for sensitive reports.
