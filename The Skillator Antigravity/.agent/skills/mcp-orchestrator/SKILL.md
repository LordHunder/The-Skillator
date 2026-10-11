---
name: mcp-orchestrator
description: >
  Teaches the agent how to discover and use MCP (Model Context Protocol) servers. 
  Crucial for agents interacting with external tools like Playwright, databases, or local filesystems.
---

# MCP Orchestrator

Your environment supports **MCP (Model Context Protocol) servers**. This means you are not limited to text generation; you can interact with the outside world.

## How to use MCP:
1. **Discover Tools:** If the user asks you to interact with a specific tool (e.g., GitHub, a database, Playwright), check if you have an MCP server configured for it.
2. **Execute Tools:** Use your native tool-calling capabilities to invoke MCP resources. 
3. **Handle Errors:** If an MCP tool call fails, DO NOT invent the data. Tell the user the tool failed and explain the error output so they can fix the configuration.

## Playwright & Agent Reach Guidelines
- **Playwright CLI / MCP:** If requested to test a UI or interact with a local web app, use the Playwright MCP or CLI tools to click, type, and verify elements.
- **Agent Reach:** If requested to search external social data (Reddit, Twitter, YouTube), use the Agent Reach tools to fetch live data instead of relying on your training cutoff.
