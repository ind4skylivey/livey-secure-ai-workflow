# livey-codex-toolkit

<pre align="center">
<img width="1024" height="1024" alt="56335" src="https://github.com/user-attachments/assets/ada40492-65b9-47ed-bfe9-28979b160ca6" />

<div align="center">
  <img src="https://img.shields.io/badge/status-active-50fa7b?style=for-the-badge&labelColor=1e1e2e" alt="Status badge">
  <img src="https://img.shields.io/badge/cli-codex-8be9fd?style=for-the-badge&labelColor=1e1e2e" alt="Codex badge">
  <img src="https://img.shields.io/badge/UAEP-v1.0-ff79c6?style=for-the-badge&labelColor=1e1e2e" alt="UAEP badge">
  <img src="https://img.shields.io/badge/platform-linux%20only-fc618d?style=for-the-badge&labelColor=1e1e2e" alt="Linux badge">
</div>

<p align="center">
  <sub>Repository: <a href="https://github.com/ind4skylivey/livey-codex-toolkit">github.com/ind4skylivey/livey-codex-toolkit</a></sub>
</p>

> ⚡️ **Livey Codex Toolkit**: CLI helpers + Codex templates + UAEP protocol for terminal-first developers who automate git/GitHub over SSH and expect structured AI feedback on tap.

## What's New in v1.1

🎯 **UAEP Integration**: Universal Agent Execution Protocol for structured AI responses  
📁 **Organized Prompts**: All agent profiles moved to `codex/prompts/`  
🚀 **New Command**: `cx-uaep` for protocol-driven development

## Requirements
- Linux environment with Bash (tested on bash/zsh/fish shells)
- git configured with SSH keys for GitHub access
- Codex CLI installed and available on PATH as `codex`

## Installation
```bash
# Clone the toolkit
git clone git@github.com:ind4skylivey/livey-codex-toolkit.git
cd livey-codex-toolkit

# Option A: add to PATH temporarily
export PATH="$PWD/bin:$PATH"

# Option B: symlink into an existing bin dir
ln -s "$PWD/bin"/cx-* ~/bin/

# Option C: run the installer (TODO)
# ./install.sh
```

## Commands

<table>
  <tr>
    <th>Command</th>
    <th>Description</th>
    <th>Example</th>
  </tr>
  <tr>
    <td><code>cx-uaep [mode]</code></td>
    <td>Load Universal Agent Execution Protocol for structured AI development. Modes: <code>production</code>, <code>staging</code></td>
    <td><code>cx-uaep production</code><br><code>cx-uaep staging --mode security_analysis</code></td>
  </tr>
  <tr>
    <td><code>cx-review [working]</code></td>
    <td>Streams staged diffs (default) or working-tree diffs (<code>working</code>) into Codex for a senior, security-conscious review.</td>
    <td><code>cx-review</code><br><code>cx-review working</code></td>
  </tr>
  <tr>
    <td><code>cx-commit</code></td>
    <td>Asks Codex to craft a Conventional Commit subject from staged changes, then optionally commits with it.</td>
    <td><code>cx-commit</code></td>
  </tr>
  <tr>
    <td><code>cx-fix [test command]</code></td>
    <td>Runs a test command (defaults to <code>pytest</code>). On failure, ships the log to Codex for root-cause, file pointers, and regression-test ideas.</td>
    <td><code>cx-fix</code><br><code>cx-fix "npm test"</code></td>
  </tr>
  <tr>
    <td><code>cx-security [path]</code></td>
    <td>Collects up to ~200 .php/.js/.ts/.py files, base64s a tarball, and requests a red-team style static audit from Codex.</td>
    <td><code>cx-security</code><br><code>cx-security src</code></td>
  </tr>
</table>

> 💡 Add `bin/` to your `PATH` (or symlink the scripts) so the commands are available in every repository.

## UAEP Protocol

**Universal Agent Execution Protocol** provides structured, consistent AI responses for development tasks.

### Quick Start
```bash
# Load production mode (strict, optimized, production-ready)
cx-uaep production

# Load staging mode (experimental, rapid iteration)
cx-uaep staging

# Enable special modes
cx-uaep production --mode security_analysis
cx-uaep production --mode performance_max
cx-uaep staging --mode ai_local_support
```

### Response Structure
Every UAEP response follows this 5-section format:
1. **PLAN** - Architecture and reasoning
2. **FILE-TREE** - Directory structure
3. **GENERATION RULES** - Coding standards
4. **IMPLEMENTATION** - Complete, working code
5. **TASK QUEUE** - Future improvements

### Execution Modes

#### Production Mode
- Strict quality standards
- Complete error handling
- Tests required
- Full documentation
- Security audited

**Use when:**
- Building production features
- Refactoring critical code
- Security-sensitive changes

#### Staging Mode
- Rapid prototyping
- Experimental code
- TODOs allowed
- Minimal docs
- Iterate fast

**Use when:**
- Testing new ideas
- Quick POCs
- Learning

### Special Modes
- **ai_local_support**: Prefer local models (Ollama, llama.cpp)
- **security_analysis**: Deep security scrutiny
- **performance_max**: Optimization with benchmarks

### Integration Examples

```bash
# Security-focused code review
cx-uaep production --mode security_analysis
cx-review

# Fast prototype with staging
cx-uaep staging
# Then ask Codex to build something quick

# Optimized refactoring
cx-uaep production --mode performance_max
# Then ask for performance improvements
```

📖 **Full UAEP Documentation**: `codex/prompts/uaep/uaep_readme.md`

## Agent Profiles

Specialized Codex behavior templates:

- `codex/prompts/agent.laravel.md` – Laravel development profile
- `codex/prompts/agent.security.md` – Security auditor profile
- `codex/prompts/agent.rust.md` – Rust development profile (TODO)

Load profiles with UAEP:
```bash
cx-uaep production --profile laravel
```

Or directly:
```bash
codex --load codex/prompts/agent.laravel.md
```

## Project Structure
```
livey-codex-toolkit/
├── bin/                    # Executable commands
│   ├── cx-uaep            # UAEP protocol loader
│   ├── cx-review          # Code review
│   ├── cx-commit          # Commit message generator
│   ├── cx-fix             # Test debugger
│   └── cx-security        # Security auditor
│
├── codex/                  # Codex integration
│   ├── prompts/           # Agent profiles and protocols
│   │   ├── uaep/          # Universal Agent Execution Protocol
│   │   │   ├── uaep_core.md
│   │   │   ├── uaep_production.md
│   │   │   ├── uaep_staging.md
│   │   │   ├── uaep_readme.md
│   │   │   └── loader.md
│   │   ├── agent.laravel.md
│   │   └── agent.security.md
│   │
│   └── config/            # Configuration files
│       ├── execution_modes.toml (TODO)
│       └── special_modes.toml (TODO)
│
└── README.md
```

## Safety & Profiles

These scripts never modify project files directly; they call Codex with the data you provide. Always review Codex recommendations before applying them.

Pair the toolkit with a tuned `~/.codex/config.toml` containing profiles such as:
- `dev` – high-verbosity development assistant
- `analyze` – read-only code reviewer (ideal for `cx-review` and `cx-security`)
- `git-ssh` – trusted profile for push/merge workflows

Prefer conservative profiles on shared or production machines.

## Roadmap

### v1.2 (Next Sprint)
- [ ] `install.sh` automated installer
- [ ] `cx-pr` command for pull request management
- [ ] `cx-changelog` for automated changelog generation
- [ ] Comprehensive test suite

### v2.0 (Future)
- [ ] Rust rewrite for cross-platform support
- [ ] Local AI integration (Ollama) as Codex fallback
- [ ] Plugin system for custom commands
- [ ] Interactive TUI mode

### v3.0+ (Long-term)
- [ ] Multi-repository operations
- [ ] CI/CD integration templates
- [ ] VS Code/Neovim plugin wrappers
- [ ] Community template marketplace

## Contributing

Contributions welcome! Please:
1. Follow existing code style (check `bin/cx-*` for patterns)
2. Test on Linux (Arch, Ubuntu, Fedora)
3. Update documentation
4. Add examples for new features

## License

MIT (TODO: Add LICENSE file)

## Links

- **Repository**: https://github.com/ind4skylivey/livey-codex-toolkit
- **UAEP Documentation**: `codex/prompts/uaep/uaep_readme.md`
- **Issues**: https://github.com/ind4skylivey/livey-codex-toolkit/issues
