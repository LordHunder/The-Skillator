---
name: mcp-orchestrator
description: >
  Teaches OpenAI Codex how to discover and use MCP (Model Context Protocol) servers. 
  Crucial for agents interacting with external tools like Playwright, databases, GitHub, or local filesystems.
---

# MCP Orchestrator (Codex Edition)

Your environment supports **MCP (Model Context Protocol)** tools and servers. This connects OpenAI models directly to external execution environments and data feeds.

## How Codex Uses MCP:
1. **Discover Tools:** If the user asks you to interact with a specific tool (e.g., GitHub, a database, Playwright), inspect the available MCP tool signatures before defaulting to plain bash scripts.
2. **Execute Tools:** Use native tool calls with strict JSON arguments.
3. **Handle Errors:** If an MCP tool call fails, DO NOT invent results. Present the raw error output to the user and suggest parameter corrections.

## Playwright & Agent Reach Guidelines
- **Playwright CLI / MCP:** For end-to-end testing, UI verification, or web interaction, call the Playwright tools to click, type, and verify page elements.
- **Agent Reach:** For live social or web data (Reddit, Twitter, GitHub searches), use Agent Reach tools to fetch real-time information beyond model cutoff.
