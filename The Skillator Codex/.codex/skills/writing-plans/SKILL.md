---
name: writing-plans
description: "Use when you have a spec or requirements for a multi-step task, before touching code. Creates comprehensive, step-by-step implementation plans from design specs."
---

# Writing Plans

## When to use this skill

- After brainstorming has produced an approved design spec
- When you have requirements for a multi-step implementation
- Before touching any code on a non-trivial task
- When a user asks to plan or break down a complex task

## Overview

Write comprehensive implementation plans assuming the engineer has zero context for the codebase. Document everything they need to know: which files to touch for each task, code, testing, docs they might need to check, how to test it. Give them the whole plan as bite-sized tasks. DRY. YAGNI. TDD. Frequent commits.

Assume they are a skilled developer, but know almost nothing about the toolset or problem domain. Assume they don't know good test design very well.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

## Workflow

- [ ] **1. Scope check** — Verify spec covers a single coherent subsystem
- [ ] **2. Map file structure** — List files to create/modify with responsibilities
- [ ] **3. Define tasks** — Break into bite-sized steps with exact code and commands
- [ ] **4. Write plan document** — Save to project docs folder
- [ ] **5. Plan review loop** — Dispatch reviewer (see `resources/plan-document-reviewer-prompt.md`); fix issues until approved
- [ ] **6. Execution handoff** — Announce plan is ready, ask user to proceed

## Instructions

### Scope Check

If the spec covers multiple independent subsystems, it should have been broken into sub-project specs during brainstorming. If it wasn't, suggest breaking this into separate plans — one per subsystem. Each plan should produce working, testable software on its own.

### File Structure

Before defining tasks, map out which files will be created or modified and what each one is responsible for.

- Design units with clear boundaries and well-defined interfaces. Each file should have one clear responsibility.
- Prefer smaller, focused files over large ones that do too much.
- Files that change together should live together. Split by responsibility, not by technical layer.
- In existing codebases, follow established patterns.

### Bite-Sized Task Granularity

**Each step is one action (2-5 minutes):**
- "Write the failing test" — step
- "Run it to make sure it fails" — step
- "Implement the minimal code to make the test pass" — step
- "Run the tests and make sure they pass" — step
- "Commit" — step

### Plan Document Header

**Every plan MUST start with this header:**

```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

---
```

### Task Structure

````markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py`
- Test: `tests/exact/path/to/test.py`

- [ ] **Step 1: Write the failing test**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

- [ ] **Step 2: Run test to verify it fails**

Run: `pytest tests/path/test.py::test_name -v`
Expected: FAIL with "function not defined"

- [ ] **Step 3: Write minimal implementation**

```python
def function(input):
    return expected
```

- [ ] **Step 4: Run test to verify it passes**

Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add tests/path/test.py src/path/file.py
git commit -m "feat: add specific feature"
```
````

### Plan Review Loop

After completing each chunk of the plan:

1. Dispatch plan-document-reviewer (see [`resources/plan-document-reviewer-prompt.md`](resources/plan-document-reviewer-prompt.md))
2. If ❌ Issues Found: fix the issues, re-dispatch reviewer, repeat until ✅ Approved
3. If loop exceeds 5 iterations, surface to human for guidance

**Chunk boundaries:** Use `## Chunk N: <name>` headings. Each chunk should be ≤1000 lines and logically self-contained.

### Execution Handoff

After saving the plan:

**"Plan complete and saved to `<path>`. Ready to execute?"**

## Remember

- Exact file paths always
- Complete code in plan (not "add validation")
- Exact commands with expected output
- DRY, YAGNI, TDD, frequent commits
- Use checkbox (`- [ ]`) syntax for tracking

## Resources

- [`resources/plan-document-reviewer-prompt.md`](resources/plan-document-reviewer-prompt.md) — Template for dispatching plan review

