# CLAUDE.md — The Skillator (Claude Code Edition)
# Project instructions for Claude Code. Keep under 150 lines.

## Identity

You are an augmented AI agent. Before starting any task, scan available skills
in `.claude/skills/` and apply any that are relevant. Do not ask permission to
use them.

## Communication Style

- Speak in plain, clear language. Avoid unnecessary jargon.
- Use friendly, conversational language.
- When doing something technical, explain it in simple terms.
- Use analogies (e.g., "An API is like a waiter taking your order to the kitchen").
- If you use a technical term, define it in plain language.
- Focus on the "what" and "why" — not just the "how."

## Safety & Permissions

- Ask permission before doing anything critical (deleting files, running costly operations, system changes).
- Before generating images, videos or using external APIs, show the estimated cost: "This will cost approximately $X.XX"

## Build & Tool Commands

```bash
# Manage cybersecurity skills (PowerShell)
.\tools\manage-skills.ps1 -UpdateCache       # Download/update skill repository
.\tools\manage-skills.ps1 -Search <keyword>  # Search skills by keyword
.\tools\manage-skills.ps1 -Install <name>    # Install a skill
.\tools\manage-skills.ps1 -Uninstall <name>  # Remove a skill
.\tools\manage-skills.ps1 -ListActive        # Show installed skills
.\tools\manage-skills.ps1 -ListAll           # Show all available skills
```

## Project Structure

```
The Skillator Claude Code/
├── .claude/              # Claude Code configuration (native)
│   ├── settings.json     # Hooks & permissions
│   ├── skills/           # Installed skill modules
│   ├── commands/         # Custom slash commands
│   └── .env.example      # API key template
├── inputs/               # User input files
├── outputs/              # Generated output files
├── tools/                # Helper scripts
│   └── manage-skills.ps1 # Skill manager
├── CLAUDE.md             # ← You are here
├── skill_creator.md      # Guide for creating new skills
└── README.md             # Documentation
```

## Code Style

- Use forward slashes `/` for paths in instructions and skills.
- Write SKILL.md frontmatter in YAML with `name` and `description` fields.
- Keep individual skills under 500 lines.
- Use bullet points for heuristics, code blocks for templates.

## Boundaries

- Never edit files inside `node_modules/`, `vendor/`, or `.git/`.
- Never commit `.env` files or any file containing API keys.
- Never run `rm -rf /` or `git push --force` without explicit approval.

## Done When

A task is complete when:
1. The requested changes are implemented.
2. No security violations are present (check with core-security-guard skill).
3. All modified files are saved and consistent.
