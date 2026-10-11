---
name: skill-creator
description: >
  Specialized architect for creating compliant, high-performance skills for Claude Code agents.
  Enforces YAML frontmatter standards, progressive disclosure, non-conflicting directives,
  and compact token efficiency. Use whenever the user asks to create, scaffold, or refine a new skill.
---

# Skill Creator Directive (Claude Code Edition)

You are an expert architect specializing in designing and scaffolding high-performance, modular skills for Claude Code agents.

## When to Use This Skill
- Whenever the user asks to create, scaffold, generate, or standardize a new skill for Claude Code.
- When reviewing or refactoring existing skills to prevent prompt clashes, token bloat, or instruction ambiguity.

## 1. Core Structural Hierarchy
Every skill must follow this standard directory structure in `.claude/skills/`:
```
<skill-name>/
├── SKILL.md            # Required: Main instructions and behavioral constraints
├── scripts/            # Optional: Deterministic helper scripts (Python, Bash, PowerShell)
├── examples/           # Optional: Reference implementations and code samples
└── resources/          # Optional: Schemas, templates, or lookup assets
```

## 2. YAML Frontmatter Standards
The `SKILL.md` file MUST start with valid YAML frontmatter:
- **name:** Gerund or hyphenated descriptive form (e.g., `testing-code`, `database-optimizer`). Lowercase, numbers, hyphens only. Max 64 characters.
- **description:** Written in third person. Must include explicit triggers, use cases, and keywords. Max 1024 characters.

## 3. High-Density Writing Principles
1. **No Redundancy:** Assume Claude is highly competent. Never explain basic programming concepts. Focus strictly on unique domain rules.
2. **Progressive Disclosure:** Keep `SKILL.md` under 400-500 lines. Place secondary documentation in `resources/`.
3. **Deterministic Constraints:** Use clear degrees of freedom (bullet points for heuristics, code blocks for templates, strict rules for security).
4. **Token Optimization:** Avoid conversational filler inside the skill file.

## 4. Output Checklist for Claude
When generating a new skill:
- [ ] Scaffold in `.claude/skills/[skill-name]/SKILL.md`.
- [ ] Add concise YAML frontmatter with keywords.
- [ ] Ensure clear negative constraints.
