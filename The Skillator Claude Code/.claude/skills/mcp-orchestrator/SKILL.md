---
name: mcp-orchestrator
description: >
  Manages MCP (Model Context Protocol) servers on-demand for Claude Code.
  Prevents severe context bloat by activating specialized MCP servers only during relevant tasks
  and detaching them afterward. Use when working with browser automation, databases, GitHub, or live APIs.
---

# MCP Orchestrator (Claude Code Edition)

Claude Code supports **MCP (Model Context Protocol)** servers. However, Claude Code uses **Eager Loading**: every server active in `~/.claude.json` injects its full JSON schema into Claude's system prompt on **every single message**.

> **⚠️ The Token Trap:** Having 6-10 MCP servers permanently enabled burns **8,000 to 15,000 input tokens per prompt**, dramatically increasing API costs and causing tool confusion.

---

## The On-Demand Architecture (Zero Token Waste)

Instead of keeping all servers permanently running, Claude Code must follow an **On-Demand Activation Protocol**:

### 1. Dormant by Default
Keep your global `~/.claude.json` lean. Keep servers dormant in `tools/mcp-registry.json` until a specific workflow cluster is initiated.

### 2. Workflow Clusters
Activate tools only when their specific domain is triggered:

| Cluster | Recommended Server | Activation Command |
|:---|:---|:---|
| **Browser & UI Testing** | Playwright | `claude mcp add playwright npx -y @modelcontextprotocol/server-playwright` |
| **Repository Management** | GitHub | `claude mcp add github npx -y @modelcontextprotocol/server-github` |
| **Database Operations** | PostgreSQL / SQLite | `claude mcp add postgres npx -y @modelcontextprotocol/server-postgres` |
| **Component Generation** | 21st.dev / Magic-UI | `claude mcp add magic-ui npx -y @21st-dev/magic-mcp` |
| **Live Web Intelligence** | Firecrawl / Tavily | `claude mcp add firecrawl npx -y firecrawl-mcp` |

### 3. Workflow Lifecycle (Activate ➔ Execute ➔ Detach)
1. **Detect Need:** When the user initiates a task requiring external tool interaction (e.g., *"Test the checkout flow with a browser"*), check if the server is present.
2. **Propose Quick Attachment:** If absent, propose attaching it:  
   *"To test this UI flow live, I can activate the Playwright MCP on-demand. Would you like me to attach it?"*
3. **Execute Task:** Run the test, take screenshots, or perform mutations.
4. **Clean Detachment:** Once the task is finished, recommend detaching the server to reclaim context tokens:  
   `claude mcp remove <server-name>`

### 4. Credential Hygiene
- **Never ask the user to type secrets into the chat window.**
- All servers configured from `tools/mcp-registry.json` must reference system environment variables (e.g. `$env:GITHUB_TOKEN`, `$env:FIRECRAWL_API_KEY`).
