# Project Memory Standards

Use this reference when the correct note type, folder, or level of detail is
unclear.

## Primary Principle

Treat project memory as durable, in-repo documentation for future humans and
future agents. Keep it useful, linkable, and easy to diff.

## What To Save

Save:

- implementation plans
- walkthroughs and runbooks
- decision records
- research summaries
- handoff and checkpoint notes
- architecture notes
- migration notes

Do not save:

- trivial chat paraphrases
- duplicate drafts of the same artifact
- raw secrets or credentials
- throwaway output with no future reuse value

## Default Layout

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

If the project already has a hand-made archive, preserve it unless the user asks
for a restructure.

## Type Selection

### Plan

Use for:

- implementation plans
- rollout plans
- migration plans
- phased refactors

Sections to keep:

- goal
- scope
- assumptions
- steps
- risks
- validation

### Walkthrough

Use for:

- setup guides
- local run instructions
- reproducible procedures
- operational steps

Sections to keep:

- purpose
- preconditions
- steps
- expected result
- pitfalls
- verification

### Decision

Use for:

- architecture choices
- library or vendor selection
- policy changes
- durable tradeoff decisions

Sections to keep:

- context
- options considered
- decision
- consequences

Prefer one decision per file. If the decision changes, create a new note that
supersedes the old one.

### Research

Use for:

- source-backed comparisons
- model or vendor evaluations
- technical scouting
- market or standards reviews

Sections to keep:

- question
- sources
- findings
- recommendation
- open questions

Include exact dates whenever the facts are time-sensitive.

### Session

Use for:

- end-of-session handoffs
- checkpoints before pause
- "what changed and what is next"

Sections to keep:

- context
- completed
- next steps
- blockers
- commands and files
- handoff

## Naming Rules

- Plans, walkthroughs, research notes, and sessions use `YYYY-MM-DD-slug.md`
- Decisions use `ADR-0001-slug.md`, `ADR-0002-slug.md`, and so on
- Use short, specific titles

## Asset Rules

- Store companion files in `assets/<entry-stem>/`
- Use relative links from the note to its assets
- Keep screenshots close to the note they explain

## Writing Rules

- Prefer Markdown for text artifacts
- Use short paragraphs and scannable sections
- Keep each note focused on one job
- Link to code, docs, tickets, and sources rather than duplicating them
- Update existing notes when continuing the same artifact

## Index Rules

- Maintain `INDEX.md` as the archive entry point
- Add each new note under the matching section
- Keep links relative so the archive remains portable
