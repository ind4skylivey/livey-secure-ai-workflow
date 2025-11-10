# livey-codex-toolkit

<pre align="center">
 _      _ _           _   __   __
| |    (_) |         | |  \ \ / /
| |     _| |__   ___ | |_  \ V / 
| |    | | '_ \ / _ \| __|  > <  
| |____| | |_) | (_) | |_  / . \ 
|______|_|_.__/ \___/ \__|/_/ \_\

        LiveY · CodeX-Toolkit · v1
</pre>

<div align="center">
  <img src="https://img.shields.io/badge/status-active-50fa7b?style=for-the-badge&labelColor=1e1e2e" alt="Status badge">
  <img src="https://img.shields.io/badge/cli-codex-8be9fd?style=for-the-badge&labelColor=1e1e2e" alt="Codex badge">
  <img src="https://img.shields.io/badge/platform-linux%20only-fc618d?style=for-the-badge&labelColor=1e1e2e" alt="Linux badge">
</div>

<p align="center">
  <sub>Repository: <a href="https://github.com/ind4skylivey/livey-codex-toolkit">github.com/ind4skylivey/livey-codex-toolkit</a></sub>
</p>

> ⚡️ **Livey Codex Toolkit**: CLI helpers + Codex templates for people who live in the terminal, automate git/GitHub over SSH, and expect AI feedback on tap.

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
ln -s "$PWD/bin/cx-review" ~/bin/cx-review
ln -s "$PWD/bin/cx-commit" ~/bin/cx-commit
ln -s "$PWD/bin/cx-fix" ~/bin/cx-fix
ln -s "$PWD/bin/cx-security" ~/bin/cx-security
```

## Commands

<table>
  <tr>
    <th>Command</th>
    <th>Description</th>
    <th>Example</th>
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

## Templates
- `templates/agent.laravel.md` – profile for Codex when operating inside Laravel applications.
- `templates/agent.security.md` – profile for Codex when acting as a security auditor.

Drop these into your Codex profiles or reference them when composing prompts for long-running sessions.

## Safety & Profiles
These scripts never modify project files directly; they call Codex with the data you provide. Always review Codex recommendations before applying them. Pair the toolkit with a tuned `~/.codex/config.toml` containing profiles such as:
- `dev` – high-verbosity development assistant with workspace-write sandbox.
- `analyze` – read-only code reviewer (ideal for `cx-review` and `cx-security`).
- `git-ssh` – trusted profile for push/merge workflows.
- `auto` – only for disposable environments where Codex can operate with elevated permissions.

Prefer conservative profiles on shared or production machines, and reserve the more permissive ones for trusted local environments.
