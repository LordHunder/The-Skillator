# 🧠 The Skillator

**An open-source toolkit that gives your AI coding agent superpowers.**

The Skillator is a plug-and-play skill management system for AI coding agents. It lets you browse, install, and manage hundreds of cybersecurity skills from a curated public repository — with a single command.

---

## What Problem Does This Solve?

Modern AI coding agents (like Google's Gemini via Antigravity, Anthropic's Claude Code, and OpenAI's Codex) become dramatically more capable when you give them structured instructions called **"Skills"**. A Skill is like a specialized training module: it teaches your agent how to perform a specific task (e.g., "audit this code for SQL injection", "set up a firewall with Suricata", or "analyze a memory dump with Volatility").

**The problem?** Finding, downloading, organizing, and adapting these skills for your specific AI tool is tedious and error-prone. The Skillator automates the entire process:

1. **Browse** a catalog of 500+ cybersecurity skills.
2. **Install** any skill with a single command.
3. **Auto-adapt** the skill's language to your specific AI tool (so a skill written for Claude works perfectly on Gemini or Codex).

---

## Choose Your Edition

This repository contains **three editions** of The Skillator, each optimized for a different AI coding agent. **Pick the one that matches your tool:**

| Edition | AI Tool | Config Folder | Instruction File | Key Feature |
|:---|:---|:---|:---|:---|
| [**Antigravity**](./The%20Skillator%20Antigravity/) | Google Gemini (Antigravity IDE) | `.agent/` | `Global Antigravity.md` | Gemini-native rules + folder structure prompt |
| [**Claude Code**](./The%20Skillator%20Claude%20Code/) | Anthropic Claude Code | `.claude/` | `CLAUDE.md` | Security hooks + no adaptation needed (native skills) |
| [**Codex**](./The%20Skillator%20Codex/) | OpenAI Codex CLI | `.codex/` | `AGENTS.md` | Open standard format + sandbox configuration |

> **Not sure which one to pick?** If you use Google's Antigravity IDE, pick **Antigravity**. If you use Claude Code in the terminal, pick **Claude Code**. If you use OpenAI's Codex CLI, pick **Codex**.

---

## How It Works (The Big Picture)

Each edition follows the same core workflow, but uses the native architecture of its respective AI tool:

```
┌─────────────────────────────────────────────────────────┐
│                    YOUR AI AGENT                         │
│                                                          │
│  1. Reads instruction file (CLAUDE.md / AGENTS.md / etc) │
│  2. Scans installed skills in the config folder           │
│  3. Auto-applies relevant skills to your task             │
└──────────────────────┬──────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│              manage-skills.ps1 (The Skill Manager)       │
│                                                          │
│  • Downloads 500+ skills from GitHub                      │
│  • Installs skills to the correct config folder           │
│  • Adapts language for your specific AI tool              │
│  • Lists, searches, and uninstalls skills                 │
└─────────────────────────────────────────────────────────┘
```

### The `manage-skills.ps1` Script

This PowerShell script is the heart of The Skillator. Think of it as an **"App Store for AI skills"**:

| Command | What it does |
|:---|:---|
| `.\tools\manage-skills.ps1 -UpdateCache` | Downloads (or updates) the full skill catalog from GitHub to your local machine. |
| `.\tools\manage-skills.ps1 -Search "security"` | Searches the catalog by keyword and shows matching skills. |
| `.\tools\manage-skills.ps1 -Install "core-security-guard"` | Installs the skill into the correct config folder and adapts its language. |
| `.\tools\manage-skills.ps1 -Uninstall "core-security-guard"` | Removes an installed skill. |
| `.\tools\manage-skills.ps1 -ListActive` | Shows all currently installed skills. |
| `.\tools\manage-skills.ps1 -ListAll` | Shows all available skills in the local cache. |

---

## Quick Start

### Prerequisites
- **Windows** with PowerShell 5.1+
- **Git** installed and accessible from the terminal
- One of the supported AI coding agents (Antigravity, Claude Code, or Codex CLI)

### Step-by-step

1. **Clone this repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/The-Skillator.git
   ```

2. **Navigate to your edition's folder:**
   ```bash
   cd "The-Skillator/The Skillator Claude Code"   # or Antigravity, or Codex
   ```

3. **Download the skill catalog:**
   ```powershell
   .\tools\manage-skills.ps1 -UpdateCache
   ```

4. **Search and install a skill:**
   ```powershell
   .\tools\manage-skills.ps1 -Search "malware"
   .\tools\manage-skills.ps1 -Install "analyzing-malware-behavior-with-cuckoo-sandbox"
   ```

5. **Start your AI agent in this folder.** It will automatically detect and use the installed skills.

---

## Folder Structure (All Editions)

Every edition follows the same logical structure, adapted to the native conventions of each AI tool:

```
The Skillator [Edition]/
├── [config folder]       # .agent/ or .claude/ or .codex/
│   ├── skills/           # Installed skill modules
│   ├── [commands/prompts] # Custom workflows
│   └── .env.example      # API key template
├── inputs/               # Your input files (empty by default)
├── outputs/              # Generated results (empty by default)
├── tools/
│   └── manage-skills.ps1 # The Skill Manager script
├── [instruction file]    # CLAUDE.md or AGENTS.md or Global Antigravity.md
├── skill_creator.md      # Guide for creating your own skills
├── README.md             # Edition-specific documentation
└── .gitignore            # Protects secrets and temp files
```

---

## What Are "Skills"?

A **Skill** is a structured set of instructions that teaches your AI agent how to perform a specific task. Each skill lives in its own folder and contains a `SKILL.md` file with:

- **YAML Frontmatter** — metadata (name, description) used by the agent to decide when to trigger the skill.
- **Markdown Body** — the actual instructions, rules, and workflows.

### Example: `core-security-guard`

```markdown
---
name: core-security-guard
description: >
  Real-time lightweight safety monitor. Automatically monitors code changes
  to ensure basic security practices are always followed.
---

# Core Security Guard

## Core Rules
1. Never hardcode API keys or passwords in source code.
2. Always sanitize user input.
3. Use parameterized queries to prevent SQL injection.
...
```

When your AI agent encounters a security-related task, it automatically loads this skill and follows its rules — without you having to remember or type them.

---

## Pre-installed Skills (20)

Each edition ships with these 20 skills, ready to use:

| Skill | Purpose |
|:---|:---|
| `accessibility-and-performance` | Web accessibility and performance optimization |
| `brainstorming` | Structured creative ideation |
| `brand-identity` | Brand voice and visual identity guidelines |
| `caveman` | Simplified communication for complex topics |
| `codebase-onboarding-explorer` | Navigate and understand new codebases |
| `core-security-guard` | Real-time code security monitoring |
| `database-sql-optimizer` | SQL query optimization and database design |
| `deep-security-audit` | In-depth security vulnerability analysis |
| `design-craft` | UI/UX design principles and patterns |
| `devops-cloud-architect` | Cloud architecture and DevOps workflows |
| `error-handling-patterns` | Robust error handling strategies |
| `finance-business-analyst` | Financial modeling and business analysis |
| `legal-compliance-advisor` | Legal and regulatory compliance guidance |
| `magic-ui-generator` | Rapid UI component generation |
| `motion-choreographer` | Animation and motion design |
| `premium-frontend-architect` | Advanced frontend architecture patterns |
| `project-memory-archivist` | Project context and decision logging |
| `seo-aeo-optimizer` | Search and answer engine optimization |
| `ui-redesign` | UI modernization and redesign workflows |
| `writing-plans` | Structured technical writing and planning |

---

## Creating Your Own Skills

Each edition includes a `skill_creator.md` file with detailed instructions for building custom skills. The general process is:

1. Create a folder in your config's `skills/` directory.
2. Add a `SKILL.md` file with YAML frontmatter and instructions.
3. Restart your agent session to load the new skill.

See the edition-specific `skill_creator.md` for format details and examples.

---

## Architecture Comparison

For those interested in the technical differences between the three editions:

| Feature | Antigravity (Gemini) | Claude Code | Codex |
|:---|:---|:---|:---|
| Instruction file | `Global Antigravity.md` | `CLAUDE.md` | `AGENTS.md` |
| Config folder | `.agent/` | `.claude/` | `.codex/` |
| Security system | — | Hooks (`settings.json`) | Sandbox (`config.toml`) |
| Skill adaptation | Claude → Gemini | None (native) | Claude → OpenAI |
| Custom workflows | `.agent/workflows/` | `.claude/commands/` | `.codex/prompts/` |
| Standard format | Proprietary | Proprietary | Open (30+ tools) |
| Global config | `~/.gemini/` | `~/.claude/` | `~/.codex/` |

---

## Contributing

Contributions are welcome! If you create a useful skill, consider submitting it to the upstream [Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) repository.

---

## License

This project is provided as-is for educational and professional use. The cybersecurity skills are sourced from [Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) — refer to their repository for licensing details.
