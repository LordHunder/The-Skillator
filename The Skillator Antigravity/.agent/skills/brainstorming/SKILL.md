---
name: brainstorming
description: "Use this skill BEFORE any creative work — creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements, and design through collaborative dialogue before implementation begins."
---

# Brainstorming Ideas Into Designs

Help turn ideas into fully formed designs and specs through natural collaborative dialogue.

Start by understanding the current project context, then ask questions one at a time to refine the idea. Once you understand what you're building, present the design and get user approval.

> **HARD GATE:** Do NOT write any code, scaffold any project, or take any implementation action until you have presented a design and the user has approved it. This applies to EVERY project regardless of perceived simplicity.

## When to use this skill

- User wants to build a new feature or component
- User describes a change in behavior or functionality
- User has an idea but hasn't defined requirements yet
- User asks "how should I build X?"
- Before any creative/generative coding work

## Anti-Pattern: "This Is Too Simple To Need A Design"

Every project goes through this process. A todo list, a single-function utility, a config change — all of them. "Simple" projects are where unexamined assumptions cause the most wasted work. The design can be short (a few sentences for truly simple projects), but you MUST present it and get approval.

## Workflow

You MUST complete these items in order:

- [ ] **1. Explore project context** — check files, docs, recent commits
- [ ] **2. Ask clarifying questions** — one at a time, understand purpose/constraints/success criteria
- [ ] **3. Propose 2-3 approaches** — with trade-offs and your recommendation
- [ ] **4. Present design** — in sections scaled to their complexity, get user approval after each section
- [ ] **5. Write design doc** — save to project's docs folder and commit
- [ ] **6. Spec review loop** — dispatch spec reviewer (see `resources/spec-document-reviewer-prompt.md`); fix issues and re-dispatch until approved (max 5 iterations, then surface to human)
- [ ] **7. User reviews written spec** — ask user to review the spec file before proceeding
- [ ] **8. Transition to planning** — invoke writing-plans skill to create implementation plan

## Instructions

### Understanding the Idea

- Check out the current project state first (files, docs, recent commits)
- Before asking detailed questions, assess scope: if the request describes multiple independent subsystems, flag this immediately
- If the project is too large for a single spec, help the user decompose into sub-projects: what are the independent pieces, how do they relate, what order should they be built?
- For appropriately-scoped projects, ask questions **one at a time** to refine the idea
- Prefer **multiple choice** questions when possible
- Focus on understanding: purpose, constraints, success criteria

### Exploring Approaches

- Propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why

### Presenting the Design

- Once you believe you understand what you're building, present the design
- Scale each section to its complexity: a few sentences if straightforward, up to 200-300 words if nuanced
- Ask after each section whether it looks right so far
- Cover: architecture, components, data flow, error handling, testing
- Be ready to go back and clarify if something doesn't make sense

### Design for Isolation and Clarity

- Break the system into smaller units that each have one clear purpose, communicate through well-defined interfaces, and can be understood and tested independently
- Smaller, well-bounded units are also easier to work with — you reason better about code you can hold in context at once

### Working in Existing Codebases

- Explore the current structure before proposing changes. Follow existing patterns.
- Where existing code has problems that affect the work (e.g., a file that's grown too large, unclear boundaries), include targeted improvements as part of the design
- Don't propose unrelated refactoring. Stay focused on what serves the current goal.

### After the Design

**Documentation:**
- Write the validated design (spec) to the project's docs folder
- Commit the design document to git

**Spec Review Loop:**
After writing the spec document:
1. Dispatch spec-document-reviewer (see [`resources/spec-document-reviewer-prompt.md`](resources/spec-document-reviewer-prompt.md))
2. If Issues Found: fix, re-dispatch, repeat until Approved
3. If loop exceeds 5 iterations, surface to human for guidance

**User Review Gate:**
After the spec review loop passes, ask the user to review the written spec before proceeding:
> "Spec written and committed to `<path>`. Please review it and let me know if you want to make any changes before we start writing out the implementation plan."

Wait for the user's response. Only proceed once the user approves.

**Implementation:**
- Invoke the writing-plans skill to create a detailed implementation plan
- Do NOT invoke any other skill. writing-plans is the next step.

## Key Principles

- **One question at a time** — Don't overwhelm with multiple questions
- **Multiple choice preferred** — Easier to answer than open-ended when possible
- **YAGNI ruthlessly** — Remove unnecessary features from all designs
- **Explore alternatives** — Always propose 2-3 approaches before settling
- **Incremental validation** — Present design, get approval before moving on
- **Be flexible** — Go back and clarify when something doesn't make sense

## Resources

- [`resources/spec-document-reviewer-prompt.md`](resources/spec-document-reviewer-prompt.md) — Template for dispatching spec review
