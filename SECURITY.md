# Security Policy

## Supported Versions
- Only the latest `main` branch is supported
- Security patches are backported to the latest release if applicable

## Reporting a Vulnerability
1. **Do NOT post vulnerabilities publicly.**
2. Please email: security@livey-codex-toolkit.dev (replace with your actual address if preferred).
3. Describe:
   - What is affected (command, file, workflow)
   - How to reproduce
   - Your environment (OS/distro, shell, Codex version, model, etc.)
4. If you use GitHub issues, label as `security` and mark private if necessary.
5. Initial response in 48 hours; mitigation/patch within 7 days for serious issues.

## Disclosure Policy
- Coordinated/Responsible Disclosure is encouraged
- Public advisory will be published after fix or as mutually agreed

## Scope
- Bash scripts, prompt templates, install scripts
- Third-party usage patterns (e.g. AI model integration via Codex/Ollama/LLMs)
- Repository infrastructure

## Out of Scope
- Third-party AI model bugs and upstream LLM vulnerabilities
- User configuration errors

## Best Practices
- Always review generated code
- Do not trust AI output blindly
- Use on isolated/dev environments for critical tasks
- Never share private keys or sensitive files in prompts

## Contact
For urgent issues, use GitHub Security tab or contact security@livey-codex-toolkit.dev (configure as desired).