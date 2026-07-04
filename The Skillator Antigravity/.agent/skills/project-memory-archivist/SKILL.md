---
name: project-memory-archivist
description: Persist durable project memory into a structured repository folder using Markdown and relative asset paths. Use when Codex or Gemini is creating or updating implementation plans, walkthroughs, decision records, research notes, architecture notes, handoff logs, migration notes, or any artifact that should be reusable after the current chat. Prefer this skill when a project already has a Plans.e.Walkthrough folder, when screenshots or images must be stored beside notes, or when documentation should become a long-lived memory for humans and agents.
---

# Project Memory Archivist

Use this skill to turn one-off chat output into durable project memory that remains useful weeks later.

## Core Rules

- Archive only durable knowledge. Save plans, walkthroughs, decisions, research, handoffs, and other reusable artifacts. Do not dump trivial chatter, duplicate drafts, or low-value intermediate output.
- Keep project memory inside the project. Prefer a repository-local folder over a global notes dump.
- Default to Markdown for text artifacts. Use other formats only when the source materially requires them.
- Store screenshots, PDFs, images, CSVs, and similar companions inside an `assets/` subfolder linked from the note with relative paths.
- Use exact dates for time-sensitive material such as model comparisons, regulations, prices, and research summaries.
- Update an existing note when it is clearly the same artifact. Create a new note only when the work represents a new plan, new decision, new walkthrough, or new session handoff.
- Never store secrets, tokens, passwords, or private credentials in project memory.

## Workflow

### 1. Decide Whether To Archive

Archive the output if at least one of these is true:

- The user asks for an implementation plan, walkthrough, or project memory.
- The artifact will likely be reused by a future human or agent.
- The artifact explains why something was done, not just what happened.
- The work includes research findings, assumptions, tradeoffs, or next-step guidance.
- The task includes images or files that would lose context if left unattached.

If none of those are true, skip archival.

### 2. Choose the Archive Root

- Prefer an existing `Plans.e.Walkthrough/` folder in the current project root.
- If it does not exist, create it in the current project root.
- Do not silently reorganize a hand-made archive unless the user asks for restructuring.

Use the helper script when possible:

```bash
python scripts/project_memory.py init --root <project-root>
```

This creates:

```text
Plans.e.Walkthrough/
  INDEX.md
  plans/
  walkthroughs/
  decisions/
  research/
  sessions/
  assets/
```

### 3. Classify the Artifact

Choose exactly one primary type:

- `plan`: implementation plan, rollout plan, migration plan, roadmap slice
- `walkthrough`: step-by-step guide, setup guide, reproduction guide, operating procedure
- `decision`: ADR-like note capturing context, options, decision, and consequences
- `research`: source-backed findings, comparisons, vendor analysis, model research, technical scouting
- `session`: handoff note, checkpoint log, "what I changed and what remains"

If the artifact mixes multiple types, split it into separate notes instead of writing one overloaded document.

### 4. Create or Update the Entry

Use the helper script when possible:

```bash
python scripts/project_memory.py new --kind plan --title "Billing migration"
python scripts/project_memory.py new --kind walkthrough --title "Local setup"
python scripts/project_memory.py new --kind decision --title "Use Prisma with SQLite for local dev"
python scripts/project_memory.py new --kind research --title "Model routing options for tutoring"
python scripts/project_memory.py new --kind session --title "Backend checkpoint after OCR refactor"
```

The script:

- creates the note in the correct subfolder
- uses stable naming conventions
- creates a matching asset folder
- updates `INDEX.md`

If you cannot run the script, follow the same structure manually.

### 5. Store Related Assets

- Put companion assets in `Plans.e.Walkthrough/assets/<entry-stem>/`
- Link them with relative paths
- Keep the note and the asset folder stem aligned

Example:

```markdown
![Dashboard state](../assets/2026-05-04-billing-migration/dashboard-before.png)
```

### 6. Finalize the Memory

Before finishing:

- ensure the title is specific
- remove stale placeholders
- add file links, commands, or source links that a future reader will need
- update `INDEX.md` if you created or renamed files manually
- prefer concise notes over essay-length summaries

## Writing Standards by Type

### Plans

- Capture goal, scope, assumptions, ordered steps, risks, and validation.
- Keep the plan actionable.
- Record dependencies and open questions explicitly.

### Walkthroughs

- Capture prerequisites, exact steps, expected result, pitfalls, and verification.
- Optimize for repeatability by someone who did not attend the current session.

### Decisions

- Keep one decision per file.
- Record context, considered options, chosen direction, and consequences.
- If a decision changes, create a new note that supersedes the old one rather than editing history away.

### Research

- Capture question, dated sources, findings, recommendation, and open questions.
- When facts may change, include the access date and any relevant absolute dates in the body.

### Sessions

- Capture current context, what was completed, what remains, blockers, and next steps.
- Make the next action obvious.

## Resources

- Run `scripts/project_memory.py` to initialize the archive or create new entries.
- Read `references/project-memory-standards.md` when deciding where a document belongs or how detailed it should be.
