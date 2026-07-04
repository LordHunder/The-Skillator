# 🧠 The Skillator — Codex Edition (OpenAI CLI)

This edition of The Skillator is optimized for **OpenAI's Codex CLI** and any modern AI coding tool that supports the industry-standard `AGENTS.md` open configuration format (including Cursor, GitHub Copilot, Aider, and others).

---

## What Is This?

The Skillator is your AI agent's personal **"App Store"** for cybersecurity skills. Instead of manually downloading, organizing, and adapting skills, a single PowerShell command does everything for you.

This specific edition is tailored for Codex CLI's architecture:
- Skills live in `.codex/skills/`.
- Project rules live in `AGENTS.md` — following the vendor-neutral open standard supported by 30+ AI tools.
- Technical sandbox boundaries are defined in `.codex/config.toml`.
- The script automatically adapts skill language from Claude/Anthropic terminology to **Codex/OpenAI** terminology.

---

## Folder Structure

```
The Skillator Codex/
├── .codex/                    # Codex CLI configuration
│   ├── config.toml            # Sandbox and approval policy settings
│   ├── skills/                # 20 pre-installed skill modules
│   │   ├── core-security-guard/
│   │   ├── brainstorming/
│   │   ├── design-craft/
│   │   └── ... (17 more)
│   ├── prompts/               # Custom slash-command prompts (empty, ready for use)
│   └── .env.example           # Template for API keys (copy to .env)
├── inputs/                    # Your input files go here
├── outputs/                   # Generated results appear here
├── tools/
│   └── manage-skills.ps1      # The Skill Manager script
├── AGENTS.md                  # Open standard project instructions (<150 lines)
├── skill_creator.md           # Guide for creating new skills
├── README.md                  # ← You are here
└── .gitignore                 # Protects secrets and temp files
```

---

## How to Use

### 1. Download the Skill Catalog

The first time you use The Skillator, download the full skill catalog from GitHub:

```powershell
.\tools\manage-skills.ps1 -UpdateCache
```

This clones a repository of 500+ cybersecurity skills into your user profile folder (`~\.codex\skills-cache\`). You only need to do this once; use the same command later to update to the latest version.

### 2. Search for a Skill

Looking for something specific? Search by keyword:

```powershell
.\tools\manage-skills.ps1 -Search "network"
```

The script searches both skill names and descriptions, then shows you all matches.

### 3. Install a Skill

Found what you need? Install it with one command:

```powershell
.\tools\manage-skills.ps1 -Install "core-security-guard"
```

**What happens behind the scenes:**
1. The script copies the skill folder from the local cache into `.codex/skills/`.
2. It automatically rewrites Claude/Anthropic-specific terms (e.g., "Claude Code" → "Codex/OpenAI") so the skill reads naturally for your OpenAI agent.
3. The skill is immediately available for your session.

### 4. List Active Skills

See what's currently installed:

```powershell
.\tools\manage-skills.ps1 -ListActive
```

### 5. Uninstall a Skill

Remove a skill you no longer need:

```powershell
.\tools\manage-skills.ps1 -Uninstall "core-security-guard"
```

### 6. Install to Global Codex Folder

To make a skill available across **all** your projects (not just this one), use the `-GlobalCodex` flag:

```powershell
.\tools\manage-skills.ps1 -Install "core-security-guard" -GlobalCodex
```

This installs to `~\.codex\skills\` instead of the project's `.codex\skills\`.

---

## The `AGENTS.md` File (Open Standard)

This file is the industry-standard "README for machines". While human developers read `README.md`, AI coding tools read `AGENTS.md` to understand how to operate in your project.

It is intentionally kept **under 150 lines** to conserve context window tokens and prevent instruction creep. It defines:
- **Identity**: Tells the agent to scan and apply skills automatically.
- **Communication style**: Plain language, analogies, friendly tone.
- **Safety rules**: Ask permission before critical operations, show cost estimates.
- **Commands**: Exact CLI command strings with flags.
- **Project boundaries**: Explicit off-limits areas (`node_modules/`, `vendor/`, `.env`).
- **Code style**: Use forward slashes, formatting heuristics.
- **Testing & Workflow**: How to verify installed skills.
- **"Done When" criteria**: Clear finish line conditions for tasks.

---

## Sandbox Configuration (`config.toml`)

Codex CLI uses a dedicated configuration file at `.codex/config.toml` to enforce security boundaries. We provide a pre-configured file with safe defaults:

```toml
# Sandbox mode: controls what Codex can do in your project.
sandbox_mode = "workspace-write"

# Approval policy: when Codex should ask for your permission.
approval_policy = "on-request"
```

- **`workspace-write`**: Codex can read files and run standard routine commands (like `git` or PowerShell scripts) strictly inside this project folder. It cannot touch files outside this directory.
- **`on-request`**: Codex operates autonomously for routine tasks, but pauses to ask for explicit user approval before performing high-risk actions.

---

## Text Adaptation Logic

When skills are installed, the script automatically replaces these terms:

| Original Term (from source) | Adapted Term (for Codex) |
|:---|:---|
| `Claude Code` | `Codex/OpenAI` |
| `Claude` | `the AI agent` |
| `Anthropic` | `OpenAI` |
| `claude` | `agent` |

This ensures every skill reads naturally for Codex and avoids confusing the model with competitor branding.

---

## Creating Your Own Skills

See [`skill_creator.md`](./skill_creator.md) for a complete guide. Codex-specific tips:

1. The `name` in YAML frontmatter should ideally use **gerund form** (e.g., `testing-code`, `managing-databases`).
2. Keep `description` written in the third person and under 1024 characters.
3. Keep skills focused on specific procedures to complement the always-on `AGENTS.md` rules.
4. Custom slash-command prompts can also be added directly to the `.codex/prompts/` folder.

---

## API Keys & Security

- Copy `.codex/.env.example` to `.codex/.env` and add your keys (`OPENAI_API_KEY`).
- The `.gitignore` file ensures `.env` is **never** published to GitHub.
- The `core-security-guard` skill actively monitors your code for hardcoded secrets and security violations.
