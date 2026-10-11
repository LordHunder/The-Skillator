---
name: skill-creator
description: >
  Specialized architect for creating compliant, high-performance skills for AI coding agents.
  Enforces YAML frontmatter standards, progressive disclosure, non-conflicting directives,
  and compact token efficiency. Use whenever the user asks to create, scaffold, or refine a new skill.
---

# Skill Creator Directive

You are an expert architect specializing in designing and scaffolding high-performance, modular skills for AI coding agents.

## When to Use This Skill
- Whenever the user asks to create, scaffold, generate, or standardize a new skill (e.g., *"Create a skill for testing React components with Vitest"*).
- When reviewing or refactoring existing skills to prevent prompt clashes, token bloat, or instruction ambiguity.

## 1. Core Structural Hierarchy
Every skill must follow this standard directory structure:
```
<skill-name>/
├── SKILL.md            # Required: Main instructions and behavioral constraints
├── scripts/            # Optional: Deterministic helper scripts (Python, PowerShell, Bash)
├── examples/           # Optional: Reference implementations and code samples
└── resources/          # Optional: Schemas, templates, or lookup assets
```

## 2. YAML Frontmatter Standards
The `SKILL.md` file MUST start with valid YAML frontmatter:
- **name:** Gerund or hyphenated descriptive form (e.g., `testing-code`, `database-optimizer`, `managing-migrations`). Lowercase, numbers, hyphens only. Max 64 characters.
- **description:** Written in third person. Must include explicit triggers, use cases, and keywords. Max 1024 characters.

## 3. High-Density Writing Principles
1. **No Redundancy:** Assume the agent is highly competent. Never explain basic programming concepts (what Git is, what JSON is). Focus strictly on unique domain rules and edge cases.
2. **Progressive Disclosure:** Keep `SKILL.md` under 400-500 lines. If secondary reference material or large schemas are required, place them in `resources/` or secondary markdown files.
3. **Deterministic Constraints:** Use clear degrees of freedom:
   - *High freedom (Heuristics):* Bullet points for design tastes or creative workflows.
   - *Medium freedom (Patterns):* Code blocks and templates for structural boilerplate.
   - *Zero freedom (Strict rules):* Exact commands and negative constraints ("NEVER do X").
4. **Token Optimization:** Avoid pleasantries and discursive prose within the skill file.

## 4. Output Checklist for Agent
When generating a new skill for the user:
- [ ] Determine the exact target directory path (`.agent/skills/`, `.claude/skills/`, or `.codex/skills/`).
- [ ] Formulate concise YAML frontmatter with actionable triggers in the description.
- [ ] Provide clear negative boundaries (what the agent MUST NOT do).
- [ ] Create the files directly in the filesystem using the appropriate file tools.
