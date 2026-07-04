---
name: error-handling-patterns
description: "Master error handling patterns across languages including exceptions, Result types, error propagation, and graceful degradation to build resilient applications. Use when implementing error handling, designing APIs, or improving application reliability."
---

# Error Handling Patterns

Build resilient applications with robust error handling strategies that gracefully handle failures and provide excellent debugging experiences.

## When to Use This Skill

- Implementing error handling in new features
- Designing error-resilient APIs
- Debugging production issues
- Improving application reliability
- Creating better error messages for users and developers
- Implementing retry and circuit breaker patterns
- Handling async/concurrent errors
- Building fault-tolerant distributed systems

## Core Concepts

### Error Handling Philosophies

| Approach | Best For | Trade-offs |
|----------|----------|------------|
| **Exceptions** (try-catch) | Unexpected errors, exceptional conditions | Disrupts control flow, implicit |
| **Result Types** | Expected errors, validation failures | Explicit, functional, verbose |
| **Error Codes** | C-style, low-level systems | Requires discipline, easy to ignore |
| **Option/Maybe Types** | Nullable values | No error details |

### Error Categories

**Recoverable:** Network timeouts, missing files, invalid user input, API rate limits
**Unrecoverable:** Out of memory, stack overflow, programming bugs (null pointer, etc.)

## Reference Documentation

Depending on the task you are performing, consult the specific resource file below.

### For Language-Specific Patterns

If you need error handling patterns for Python, TypeScript/JavaScript, Rust, or Go:
👉 **[`resources/language-patterns.md`](resources/language-patterns.md)**

### For Universal/Architectural Patterns

If you need circuit breakers, error aggregation, or graceful degradation:
👉 **[`resources/universal-patterns.md`](resources/universal-patterns.md)**

### For Best Practices & Pitfalls

If you need a checklist of best practices or common anti-patterns to avoid:
👉 **[`resources/best-practices.md`](resources/best-practices.md)**

## Workflow

- [ ] **1. Identify error category** — Is the error recoverable or unrecoverable?
- [ ] **2. Choose the right approach** — Exceptions, Result types, or error codes based on the language and context
- [ ] **3. Read the language-specific patterns** — Consult `resources/language-patterns.md`
- [ ] **4. Apply universal patterns if needed** — Circuit breaker, retry, graceful degradation from `resources/universal-patterns.md`
- [ ] **5. Validate against best practices** — Check `resources/best-practices.md` for pitfalls
- [ ] **6. Test error paths** — Verify error handling works correctly under failure conditions

## Key Principles

- **Fail Fast** — Validate input early, fail quickly
- **Preserve Context** — Include stack traces, metadata, timestamps
- **Meaningful Messages** — Explain what happened and how to fix it
- **Handle at Right Level** — Catch where you can meaningfully handle
- **Clean Up Resources** — Use try-finally, context managers, defer
- **Don't Swallow Errors** — Log or re-throw, never silently ignore

