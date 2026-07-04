# 🧠 The Skillator — Claude Code Edition (Anthropic)

This edition of The Skillator is optimized for **Anthropic's Claude Code**. It uses Claude Code's native `.claude/` configuration folder, `CLAUDE.md` for project instructions, `settings.json` for security hooks, and skills in their original Claude-native format.

---

## What Is This?

The Skillator is your AI agent's personal **"App Store"** for cybersecurity skills. Instead of manually downloading, organizing, and adapting skills, a single PowerShell command does everything for you.

This specific edition is tailored for Claude Code's architecture:
- Skills live in `.claude/skills/` — in their **original, unmodified format** (no text adaptation needed, since the skill source is already Claude-native).
- Project rules live in `CLAUDE.md` — a concise, under-150-line file optimized for Claude's context window.
- Security hooks in `settings.json` automatically block dangerous commands and scan for hardcoded secrets.

---

## Folder Structure

```
The Skillator Claude Code/
├── .claude/                   # Claude Code native configuration
│   ├── settings.json          # Security hooks & permissions
│   ├── skills/                # 20 pre-installed skill modules
│   │   ├── core-security-guard/
│   │   ├── brainstorming/
│   │   ├── design-craft/
│   │   └── ... (17 more)
│   ├── commands/              # Custom slash commands (empty, ready for use)
│   └── .env.example           # Template for API keys (copy to .env)
├── inputs/                    # Your input files go here
├── outputs/                   # Generated results appear here
├── tools/
│   └── manage-skills.ps1      # The Skill Manager script
├── CLAUDE.md                  # Project rules for Claude Code (<150 lines)
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

This clones a repository of 500+ cybersecurity skills into your user profile folder (`~\.claude\skills-cache\`). You only need to do this once; use the same command later to update.

### 2. Search for a Skill

Looking for something specific? Search by keyword:

```powershell
.\tools\manage-skills.ps1 -Search "ransomware"
```

### 3. Install a Skill

Found what you need? Install it with one command:

```powershell
.\tools\manage-skills.ps1 -Install "analyzing-ransomware-encryption-mechanisms"
```

**What happens behind the scenes:**
1. The script copies the skill folder from the local cache into `.claude/skills/`.
2. **No text adaptation is performed.** The skills are already written in Claude-native language (using "Claude", "Anthropic", etc.), so they work perfectly out of the box.
3. The skill is immediately available. Claude automatically detects it based on the `description` field in its `SKILL.md` frontmatter.

### 4. List Active Skills

```powershell
.\tools\manage-skills.ps1 -ListActive
```

### 5. Uninstall a Skill

```powershell
.\tools\manage-skills.ps1 -Uninstall "analyzing-ransomware-encryption-mechanisms"
```

### 6. Install to Global Claude Folder

To make a skill available across **all** your projects, use the `-GlobalClaude` flag:

```powershell
.\tools\manage-skills.ps1 -Install "core-security-guard" -GlobalClaude
```

This installs to `~\.claude\skills\` instead of the project's `.claude\skills\`.

---

## The `CLAUDE.md` File

This is Claude Code's native instruction file. It is automatically loaded at the start of every session. It is intentionally kept **under 150 lines** because research shows Claude performs best with concise, specific instructions.

It defines:
- **Identity**: The agent is augmented — it scans and uses skills automatically.
- **Communication style**: Plain language, analogies, friendly tone.
- **Safety rules**: Ask permission before critical operations, show cost estimates.
- **Build commands**: Exact commands for the skill manager.
- **Project structure**: A map of the folder hierarchy.
- **Code style**: Forward slashes, YAML frontmatter, concise skills.
- **Boundaries**: Files and actions that are off-limits.
- **Done criteria**: When a task is considered complete.

---

## Security Hooks (`settings.json`)

This is a **Claude Code exclusive feature** — no other AI tool has this. Hooks are automatic scripts that run at specific moments in Claude's workflow:

### PreToolUse Hook (Before a Command Runs)
Blocks dangerous commands before they execute:
- `rm -rf /` — Prevents accidental filesystem deletion.
- `git push --force` — Prevents destructive force-pushes.
- `format C:` — Prevents disk formatting.

If the hook detects a dangerous command, it **blocks execution entirely** (exit code 2).

### PostToolUse Hook (After a File is Modified)
Scans every file Claude writes or edits for hardcoded secrets:
- Looks for patterns like `api_key = "..."`, `password = "..."`, `secret = "..."`.
- If found, raises a warning so you can fix it immediately.

> **Note:** Hook configuration is snapshot at session start. If you modify `settings.json`, restart your Claude Code session to apply changes.

---

## Why No Text Adaptation?

Unlike the Antigravity and Codex editions (which must adapt skill language), this edition installs skills **as-is** from the source repository. Here's why:

The skill source ([Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills)) was originally written **for Claude**. The skills already use Claude-native terminology ("Claude", "Anthropic", etc.). Adapting them would be counterproductive — it would replace correct terms with incorrect ones.

This means:
- ✅ Skills install faster (no text processing).
- ✅ Skills are more accurate (no risk of accidental text corruption).
- ✅ The script is simpler and more reliable.

---

## Creating Your Own Skills

See [`skill_creator.md`](./skill_creator.md) for a complete guide. Claude Code-specific tips:

1. The `name` field in frontmatter **must match the directory name exactly**.
2. Keep `description` under 200 characters — Claude uses it for auto-matching.
3. Use the `when_to_use` frontmatter field for additional trigger phrases.
4. Pair skills with hooks in `settings.json` for automatic enforcement.
5. For heavy tasks, instruct the skill to spawn a **subagent** to keep the main context clean.

---

## Claude Code Exclusive Features

Features available in this edition that other editions don't have:

| Feature | Description |
|:---|:---|
| **Security Hooks** | Automatic command blocking and secret scanning via `settings.json`. |
| **Subagents** | Spawn isolated workers for heavy tasks (`.claude/agents/`). |
| **Auto-invocation** | Claude matches skills by description — no manual triggering needed. |
| **Custom Slash Commands** | Add `.md` files to `.claude/commands/` to create `/my-command` shortcuts. |
| **CLAUDE.local.md** | Create a personal override file that isn't committed to Git. |

---

## API Keys & Security

- Copy `.claude/.env.example` to `.claude/.env` and add your keys.
- The `.gitignore` file ensures `.env` is **never** published to GitHub.
- The PostToolUse hook actively scans for hardcoded secrets in every file you edit.
- The PreToolUse hook blocks dangerous terminal commands before they execute.
