---
name: mcp-orchestrator
description: >
  Manages MCP (Model Context Protocol) servers on-demand for OpenAI Codex.
  Prevents severe context bloat by activating specialized MCP servers only during relevant tasks
  and detaching them afterward. Use when working with browser automation, databases, GitHub, or live APIs.
---

# MCP Orchestrator (Codex Edition)

OpenAI Codex environments support **MCP (Model Context Protocol)** servers. Because OpenAI models load active tool schemas directly into the message context (**Eager Loading**), every permanently running MCP consumes thousands of fixed input tokens per request.

> **⚠️ The Token Trap:** Permanently connecting 6-10 MCP servers burns **8,000 to 15,000 input tokens per call**, eating into rate limits and slowing reasoning down.

---

## The On-Demand Architecture (Zero Token Waste)

Codex must adhere to an **On-Demand Activation Protocol**:

### 1. Dormant Registry by Default
Keep your active agent configuration clean. Store pre-configured servers in `tools/mcp-registry.json` where they consume zero tokens until activated.

### 2. Workflow Clusters
Attach servers only when their specific domain is triggered:

| Cluster | Recommended Server | Command / Transport |
|:---|:---|:---|
| **Browser & UI Testing** | Playwright | `npx -y @modelcontextprotocol/server-playwright` |
| **Repository Management** | GitHub | `npx -y @modelcontextprotocol/server-github` |
| **Database Operations** | PostgreSQL / SQLite | `npx -y @modelcontextprotocol/server-postgres` |
| **Component Generation** | 21st.dev / Magic-UI | `npx -y @21st-dev/magic-mcp` |
| **Live Web Intelligence** | Firecrawl / Tavily | `npx -y firecrawl-mcp` |

### 3. Workflow Lifecycle (Activate ➔ Execute ➔ Detach)
1. **Detect Need:** When a task requires real-world interactions (e.g. database schema inspection or browser clicks), check if the server is actively attached.
2. **Propose Quick Attachment:** Propose attaching the specific server:  
   *"To inspect your database schema live, I can attach the PostgreSQL MCP on-demand. Would you like me to connect it?"*
3. **Execute Task:** Run the query or automation with zero hallucinations.
4. **Clean Detachment:** Once the task is completed, remove the configuration block so future prompts return to zero token overhead.

### 4. Credential Hygiene
- All credentials (e.g. `GITHUB_TOKEN`, `SUPABASE_KEY`) must be read from system environment variables. Never prompt the user for secrets in raw chat.
