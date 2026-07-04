# 🧠 The Skillator — Antigravity Edition (Google Gemini)

This edition of The Skillator is optimized for **Google Gemini** running inside the **Antigravity IDE**. It uses Gemini's native `.agent/` configuration folder and a `Global Antigravity.md` file for project-wide rules.

---

## What Is This?

The Skillator is your AI agent's personal **"App Store"** for cybersecurity skills. Instead of manually downloading, organizing, and adapting skills, a single PowerShell command does everything for you.

This specific edition is tailored for Gemini's architecture:
- Skills live in `.agent/skills/`.
- Project rules live in `Global Antigravity.md`.
- The script automatically adapts skill language from Claude/Anthropic terminology to **Antigravity/Gemini** terminology.

---

## Folder Structure

```
The Skillator Antigravity/
├── .agent/                    # Gemini agent configuration
│   ├── skills/                # 20 pre-installed skill modules
│   │   ├── core-security-guard/
│   │   ├── brainstorming/
│   │   ├── design-craft/
│   │   └── ... (17 more)
│   ├── workflows/             # Custom workflows (empty, ready for use)
│   └── .env.example           # Template for API keys (copy to .env)
├── inputs/                    # Your input files go here
├── outputs/                   # Generated results appear here
├── tools/
│   └── manage-skills.ps1      # The Skill Manager script
├── Global Antigravity.md      # Project rules for Gemini
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

This clones a repository of 500+ cybersecurity skills into your user profile folder (`~\.gemini\skills-cache\`). You only need to do this once; use the same command later to update to the latest version.

### 2. Search for a Skill

Looking for something specific? Search by keyword:

```powershell
.\tools\manage-skills.ps1 -Search "malware"
```

The script searches both skill names and descriptions, then shows you all matches.

### 3. Install a Skill

Found what you need? Install it with one command:

```powershell
.\tools\manage-skills.ps1 -Install "core-security-guard"
```

**What happens behind the scenes:**
1. The script copies the skill folder from the local cache into `.agent/skills/`.
2. It automatically rewrites Claude/Anthropic-specific terms (e.g., "Claude Code" → "Antigravity/Gemini") so the skill works perfectly with your Gemini agent.
3. The skill is immediately available — no restart needed.

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

### 6. Install to Global Gemini Folder

To make a skill available across **all** your projects (not just this one), use the `-GlobalGemini` flag:

```powershell
.\tools\manage-skills.ps1 -Install "core-security-guard" -GlobalGemini
```

This installs to `~\.gemini\skills\` instead of the project's `.agent\skills\`.

---

## The `Global Antigravity.md` File

This file contains the project-wide rules that Gemini follows during every interaction. It defines:

- **Identity**: Tells Gemini it's an augmented agent that should use skills automatically.
- **Communication style**: Plain language, analogies, friendly tone.
- **Safety rules**: Always ask permission before critical operations.
- **Cost transparency**: Show estimated costs before using paid APIs.
- **Technical explanations**: Focus on "what" and "why", not just "how".
- **Folder structure prompt**: Instructions for setting up the project workspace.

You can customize these rules to match your preferences.

---

## Text Adaptation Logic

When skills are installed, the script automatically replaces these terms:

| Original Term (from source) | Adapted Term (for Gemini) |
|:---|:---|
| `Claude Code` | `Antigravity/Gemini` |
| `Claude` | `the AI agent` |
| `Anthropic` | `Antigravity` |
| `claude` | `agent` |

This ensures every skill reads naturally for your Gemini agent.

---

## Creating Your Own Skills

See [`skill_creator.md`](./skill_creator.md) for a complete guide on building custom skills. The key requirements:

1. Create a folder in `.agent/skills/` with your skill's name.
2. Add a `SKILL.md` file with YAML frontmatter (`name`, `description`).
3. Write clear, concise instructions in the markdown body.
4. Keep it under 500 lines.

---

## API Keys & Security

- Copy `.agent/.env.example` to `.agent/.env` and add your keys.
- The `.gitignore` file ensures `.env` is **never** published to GitHub.
- The `core-security-guard` skill actively monitors your code for hardcoded secrets.

---

## Author & Contact

**Pietro Canettieri**
- Email: [pietro.canettieri.2008@gmail.com](mailto:pietro.canettieri.2008@gmail.com)
- GitHub: [LordHunder](https://github.com/LordHunder)