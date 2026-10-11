---
name: mcp-orchestrator
description: >
  Teaches Claude Code how to discover and use MCP (Model Context Protocol) servers. 
  Crucial for agents interacting with external tools like Playwright, databases, GitHub, or local filesystems.
---

# MCP Orchestrator (Claude Code Edition)

Claude Code features native support for **MCP (Model Context Protocol)**. You can interact directly with registered external tools, databases, browser automation, and API gateways.

## How Claude Code Uses MCP:
1. **Discover Tools:** If the user asks you to interact with a specific tool (e.g., GitHub, a database, Playwright), check if you have an MCP server configured in `claude.json` or your MCP server list.
2. **Execute Tools:** Use your native tool-calling capabilities to invoke MCP resources. 
3. **Handle Errors:** If an MCP tool call fails, DO NOT hallucinate or fake data. Inform the user of the exact error and suggest how to fix the server configuration or API key.

## Playwright & Agent Reach Guidelines
- **Playwright CLI / MCP:** If requested to test a UI or interact with a local web app, use the Playwright MCP or CLI tools to click, type, and verify DOM elements.
- **Agent Reach:** If requested to search external social platforms (Reddit, Twitter, YouTube), use Agent Reach tools to fetch live data instead of relying on training cutoff.
