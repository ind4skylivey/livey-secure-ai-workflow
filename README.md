<p align="center">
  <img width="1024" height="1024" alt="Livey Codex Toolkit Banner" src="https://github.com/user-attachments/assets/287507a2-5e38-44e4-9c35-d0c643923e87" />
</p>

<h1 align="center">LiveY · Codex Toolkit</h1>
<p align="center"><strong>Universal AI-powered toolkit for terminal-first developers, hackers, and automation power users</strong></p>

<p align="center">
  <!-- Status & Core Protocol -->
  <img src="https://img.shields.io/badge/status-LIVE-43d675?style=for-the-badge&labelColor=282a36&logo=statuspage&logoColor=white" />
  <img src="https://img.shields.io/github/v/release/ind4skylivey/livey-codex-toolkit?color=f1fa8c&style=for-the-badge&label=version&logo=semantic-release&logoColor=black" />
  <img src="https://img.shields.io/badge/UAEP%20protocol-v1.0-ff79c6?style=for-the-badge&labelColor=282a36&logo=octopusdeploy&logoColor=white" />
  
  <!-- AI/LLM Universal -->
  <img src="https://img.shields.io/badge/LLM-agnostic-6366f1?style=for-the-badge&logo=openai&logoColor=white" />
  <img src="https://img.shields.io/badge/models-GPT%20%7C%20Claude%20%7C%20Ollama-bd93f9?style=for-the-badge&logo=huggingface&logoColor=white" />
  
  <!-- Platform & Tech -->
  <img src="https://img.shields.io/badge/bash-5.0+-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" />
  <img src="https://img.shields.io/badge/platform-Linux-fc618d?style=for-the-badge&labelColor=282a36&logo=linux&logoColor=white" />
  
  <!-- License & Activity -->
  <img src="https://img.shields.io/badge/license-MIT-8BE9FD?style=for-the-badge&labelColor=282a36&logo=open-source-initiative&logoColor=white" />
  <img src="https://img.shields.io/github/last-commit/ind4skylivey/livey-codex-toolkit?style=for-the-badge&logo=git&logoColor=white&label=Last%20commit" />
</p>

<p align="center">
  <!-- Features -->
  <img src="https://img.shields.io/badge/local%20AI-supported-50fa7b?style=for-the-badge&logo=pytorch&logoColor=black" />
  <img src="https://img.shields.io/badge/privacy-first-ff79c6?style=for-the-badge&logo=protonvpn&logoColor=white" />
  <img src="https://img.shields.io/badge/terminal-first-bd93f9?style=for-the-badge&logo=gnome-terminal&logoColor=white" />
  <img src="https://img.shields.io/badge/PRs-welcome-f1fa8c?style=for-the-badge&logo=github" />
  <img src="https://img.shields.io/github/stars/ind4skylivey/livey-codex-toolkit?style=for-the-badge&logo=github&color=50fa7b" />
</p>

<p align="center">
  <b>Universal AI toolkit for terminal power users • LLM-agnostic • UAEP-powered • Privacy-first • SSH + automation</b>
</p>

---

# 🔧 Overview

**LiveY-Codex-Toolkit** is an AI-augmented, terminal-native development toolkit that unifies:

- Code review  
- Commit message generation  
- Patch suggestion + fix flow  
- Red-team static analysis  
- UAEP protocol execution  
- Structured agents for Laravel, security, Rust, Python and more  
- Git + SSH automation  
- Local AI support (Ollama, llama.cpp, local endpoints)

It is fully **LLM-agnostic**, supports **any model**, and remains **privacy-first** by design.

Built for developers who live in the terminal and run their workflows like a command center.

---

# ⚡ Why This Toolkit Exists

Because modern development deserves tools that:

- write commit messages for you  
- analyze your code instantly  
- provide structured refactor plans  
- observe your entire repository safely  
- execute AI instructions consistently  
- work offline with local models  
- integrate into your git+SSH workflow  
- respect privacy and security boundaries  

This toolkit tries to make AI feel like a real teammate — reliable, structured, predictable.
---

# 🧩 Features

### 🧠 AI-Augmented Commands

| Command | Description |
|--------|-------------|
| **cx-uaep** | Loads Universal Agent Execution Protocol (production, staging, special modes). |
| **cx-review** | Senior-level code review + security reasoning + structure evaluation. |
| **cx-commit** | Generates Conventional Commit messages automatically. |
| **cx-fix** | Debugs failing tests using AI-guided reasoning. |
| **cx-security** | Performs red-team static analysis on multi-language codebases. |

---
## 🌐 LLM Compatibility

LiveY Codex Toolkit is fully LLM-agnostic.  
Every command (`cx-review`, `cx-pr`, `cx-fix`, `cx-security`, UAEP modes, templates) works with:

### ✔ Cloud Models
- **Claude 3.5 / 3 / 2** (Anthropic)
- **GPT-4o / GPT-4.1 / GPT-3.5** (OpenAI)
- **Mistral Large / Medium / Small**
- **DeepSeek-Coder / DeepSeek-V3**
- **Qwen 2.5 Series**
- **Gemini** (via OpenAI-compatible gateways)

### ✔ Local Models
- **Ollama** (Llama3, Qwen, Mistral, DeepSeek, Phi-3…)
- **LM Studio**
- **llama.cpp servers**
- **Any OpenAI-compatible local API** (`/v1/chat/completions`)

### ✔ Custom Engines
- **Droid CLI**
- **OpenRouter**
- **litellm bridges**
- **Self-hosted inference endpoints**

### Why it works
The toolkit uses:
- `codex` as a universal abstraction layer  
- UAEP for structured, predictable responses  
- openai-compatible HTTP schema  
- explicit model profiles via TOML  

This makes the toolkit **portable, engine-independent, and future-proof**.

---

## 🎭 Agent Profiles


Load with UAEP:

```bash
cx-uaep production --profile claude
cx-uaep production --profile qwen
cx-uaep staging    --profile local

⟁🔄 Engine Switching — Runtime Model Selector

Switch engines dynamically:

cx-engine claude claude-3.5-sonnet
cx-engine ollama llama3
cx-engine qwen qwen2.5
cx-engine droid neon-16k

Activate the new engine:
codex --profile current cx-review

⟁🤖 Droid CLI Support — Alternate LLM Engine

Droid CLI can serve as a complete backend engine:

[mode.droid]
provider = "openai-compatible"
api_url  = "http://localhost:8000/v1"
model    = "neon-16k"

Use it:
codex --profile droid cx-review

---

# 🟣 **3) BADGES 

### Claude  
https://img.shields.io/badge/Claude-Ready-9775fa?style=for-the-badge&logo=anthropic&logoColor=white

### Ollama  
https://img.shields.io/badge/Ollama-Local_LLM-7aa2f7?style=for-the-badge&logo=ollama&logoColor=white

### Droid CLI  
https://img.shields.io/badge/Droid_CLI-Engine-ff79c6?style=for-the-badge&logo=android&logoColor=white

---

# 🟣 **4) VISUAL DIAGRAM 

<img src="assets/76584.png" width="1024" />


🟣 5) cx-engine-ui — TUI Selector 

Create: bin/cx-engine-ui

#!/usr/bin/env bash

CY="\033[1;36m"; MG="\033[1;35m"; GR="\033[1;32m"; RS="\033[0m"

echo -e "${CY}⟁ LiveY Codex Toolkit — Engine Selector UI${RS}"
echo -e "${MG}-------------------------------------------${RS}"
echo ""
echo -e "Select an engine:"
echo ""
echo -e "  [1] Claude (claude-3.5-sonnet)"
echo -e "  [2] Ollama (llama3)"
echo -e "  [3] Qwen (qwen2.5)"
echo -e "  [4] Droid CLI (neon-16k)"
echo -e "  [5] Cancel"
echo ""
read -rp "Choice: " c

case "$c" in
  1) engine="claude"; model="claude-3.5-sonnet" ;;
  2) engine="ollama"; model="llama3" ;;
  3) engine="qwen"; model="qwen2.5" ;;
  4) engine="droid"; model="neon-16k" ;;
  5) echo "Cancelled."; exit 0 ;;
  *) echo "Invalid option."; exit 1 ;;
esac

echo ""
echo -e "${CY}Setting engine → ${GR}${engine} (${model})${RS}"
cx-engine "$engine" "$model"

echo ""
echo -e "${GR}✔ Engine updated. Use:${RS} codex --profile current cx-review"

Make it executable:
chmod +x bin/cx-engine-ui



## 🌐 LLM Compatibility

LiveY Codex Toolkit is fully LLM-agnostic.  
Every command (`cx-review`, `cx-pr`, `cx-fix`, `cx-security`, UAEP modes, templates) works with:

### ✔ Cloud Models
- **Claude 3.5 / 3 / 2** (Anthropic)
- **GPT-4o / GPT-4.1 / GPT-3.5** (OpenAI)
- **Mistral Large / Medium / Small**
- **DeepSeek-Coder / DeepSeek-V3**
- **Qwen 2.5 Series**
- **Gemini** (via OpenAI-compatible gateways)

### ✔ Local Models
- **Ollama** (Llama3, Qwen, Mistral, DeepSeek, Phi-3…)
- **LM Studio**
- **llama.cpp servers**
- **Any OpenAI-compatible local API** (`/v1/chat/completions`)

### ✔ Custom Engines
- **Droid CLI**
- **OpenRouter**
- **litellm bridges**
- **Self-hosted inference endpoints**

### Why it works
The toolkit uses:
- `codex` as a universal abstraction layer  
- UAEP for structured, predictable responses  
- openai-compatible HTTP schema  
- explicit model profiles via TOML  

This makes the toolkit **portable, engine-independent, and future-proof**.

---

## 🎭 Agent Profiles

Specialized LLM-optimized agents:

codex/prompts/agent.claude.md – Claude optimized
codex/prompts/agent.qwen.md – Qwen optimized
codex/prompts/agent.local.md – Local LLM optimized

Use with UAEP:

```bash
cx-uaep production --profile claude
cx-uaep production --profile qwen
cx-uaep staging    --profile local

🔄 Engine Switching
Switch LLM engine dynamically:
cx-engine <engine> <model>

Examples:
cx-engine claude claude-3.5-sonnet
cx-engine ollama llama3
cx-engine qwen qwen2.5
cx-engine droid neon-16k

Activate the profile:
codex --profile current cx-review

🤖 Droid CLI Support

LiveY Codex Toolkit can use Droid CLI as an LLM backend via the included mode.droid profile:

# 🚀 What's New in v1.1

### 🎯 **UAEP Integration**
Universal Agent Execution Protocol (production + staging + special modes).

### 📁 **Unified Prompt Architecture**
All agents placed under:

codex/prompts/


### 🧪 **New Execution Command**

cx-uaep [mode]


### 💻 **Better Local AI Support**
Works with Ollama, LM Studio, and custom local endpoints.

---

# 📦 Installation

```bash
git clone git@github.com:ind4skylivey/livey-codex-toolkit.git
cd livey-codex-toolkit
export PATH="$PWD/bin:$PATH"

Optional symlink:

ln -s "$PWD/bin"/cx-* ~/bin/

🔮 UAEP Protocol

UAEP standardizes AI execution using 5 strict response layers:

    PLAN – architecture + reasoning

    FILE-TREE – directory layout

    GENERATION RULES – formatting, standards, safety

    IMPLEMENTATION – full working code

    TASK QUEUE – next actions

UAEP can run in:
Production Mode

    strict, safe, fully documented

    ideal for real projects

Staging Mode

    rapid prototyping

    TODOs allowed

    ideal for experiments

Special Modes

    security_analysis

    performance_max

    ai_local_support

    architecture_review

Load UAEP:

cx-uaep production
cx-uaep staging
cx-uaep production --mode security_analysis

🧠 Agent Profiles
Profile	Description
agent.laravel.md	Laravel-specialized developer agent
agent.security.md	Red-team static analysis agent
agent.rust.md	(WIP) Rust agent
uaep/*	Full UAEP protocol

Load via UAEP:

cx-uaep production --profile laravel

Direct usage:

codex --load codex/prompts/agent.laravel.md

🛠 Commands (Deep Documentation)
cx-review

AI-powered repository inspection.

Examples:

cx-review
cx-review working

cx-commit

Generates a clean Conventional Commit message.

cx-commit

cx-fix

AI-powered debugging of failing tests.

cx-fix
cx-fix "npm test"

cx-security

Red-team static analysis:

cx-security
cx-security src

📁 Project Structure

livey-codex-toolkit/
├── bin/
│   ├── cx-uaep
│   ├── cx-review
│   ├── cx-commit
│   ├── cx-fix
│   └── cx-security
│
├── codex/
│   ├── prompts/
│   │   ├── uaep/
│   │   │   ├── uaep_core.md
│   │   │   ├── uaep_production.md
│   │   │   ├── uaep_staging.md
│   │   │   ├── uaep_readme.md
│   │   │   └── loader.md
│   │   ├── agent.laravel.md
│   │   ├── agent.security.md
│   │   └── agent.rust.md (TODO)
│   │
│   └── config/ (future)
│       └── *.toml
│
└── README.md

🔰 Philosophy & Safety

    The toolkit never modifies files directly.

    All changes are visible through diff previews.

    You remain fully in control of commits, patches, and code writing.

    UAEP ensures predictable, structured responses across any LLM.

Use the profile system for safety:

    dev

    analyze

    git-ssh

    livey_power_user (full-auto mode 😈)

🔄 Workflows
Daily Dev Loop

cx-review
cx-fix
cx-commit
git push

Security Sweep

cx-uaep production --mode security_analysis
cx-security

Fast Prototyping

cx-uaep staging

Offline Mode

export CODEX_ENGINE_URL=http://localhost:11434
cx-review

🜁 LiveY Official Seal

⟁ ᛦ LIVEY · CODEX TOOLKIT ᛦ ⟁

Available soon as:

    SVG (vector)

    PNG (HQ)

    Banner integration

🛣 Roadmap
v1.2

    install.sh

    cx-pr

    cx-changelog

    execution_modes.toml

    test suite

v2.0

    Rust rewrite

    Local AI fallback

    Plugin system

    TUI interface

v3.0+

    multi-repo ops

    CI/CD integrations

    Neovim/VSCode bindings

    template marketplace

🤝 Contributing

PRs welcome.
Test on Linux.
Document changes.
Respect UAEP structure.
📜 License

MIT License.
🔗 Links

    Repository: https://github.com/ind4skylivey/livey-codex-toolkit

    UAEP Docs: codex/prompts/uaep/uaep_readme.md

    Issues: https://github.com/ind4skylivey/livey-codex-toolkit/issues

