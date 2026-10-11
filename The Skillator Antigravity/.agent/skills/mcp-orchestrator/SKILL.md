---
name: mcp-orchestrator
description: >
  Guides the agent on discovering and leveraging MCP (Model Context Protocol) servers.
  Leverages Antigravity's native Lazy-Loading architecture to invoke external tools (Playwright, databases, GitHub)
  with zero context bloat. Use when interacting with external tools, web testing, or live APIs.
---

# MCP Orchestrator (Antigravity Edition)

Antigravity features native support for **MCP (Model Context Protocol)** servers. This connects Gemini directly to external tools, databases, browsers, and API gateways.

## Antigravity Native Architecture: Zero-Bloat Lazy Loading
Unlike traditional agent environments that eagerly inject all tool definitions into every prompt turn, **Antigravity utilizes native Lazy-Loading for MCP tools**:
- **Indexed on Demand:** Tool schemas are not permanently stored in the active system prompt. Gemini indexes tools by signature and only retrieves full schema definitions when actively invoking them.
- **Token Efficiency:** Because of this built-in architecture, Antigravity does **not** require manual on/off toggling of MCP servers to save tokens. You get maximum tool capability without the 10,000+ token penalty per prompt.

## Execution Directives:
1. **Priority to Specialized Tools:** When requested to test a web UI, navigate a site, or inspect an external API, prioritize using configured MCP servers (e.g. Playwright, GitHub, PostgreSQL) over writing fragile ad-hoc terminal scripts.
2. **Zero Hallucination on Errors:** If an MCP server returns an error, timeout, or authentication failure, DO NOT invent results. Present the raw error output to the user and explain which credential (e.g., environment variable) needs verification.
3. **Assisted Setup:** When the user asks for a workflow requiring an unconfigured external integration, provide the exact configuration block for `mcp_config.json` referencing environment variables.

## Gold Standard Integrations:
- **Playwright MCP:** Run real headless/headed browser sessions to test click events, forms, and visual state.
- **GitHub MCP:** Create PRs, review issues, and inspect repository commits via official API calls.
- **Database MCP (PostgreSQL / SQLite / Supabase):** Inspect schema definitions and execute validated SQL queries.
- **Web Intelligence (Firecrawl / Agent Reach):** Fetch live web pages and documentation beyond knowledge cutoff.
