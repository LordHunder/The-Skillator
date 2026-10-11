# The Skillator

**An open-source toolkit that gives your AI coding agent superpowers — while slashing token costs.**

The Skillator is a plug-and-play, multi-repository skill management system and workspace optimizer for AI coding agents. It lets you browse, install, and manage specialized skills from elite public GitHub repositories with smart ranking, shields your projects against massive token leaks, and equips your agent with enterprise-grade coding disciplines.

---

## What Problem Does This Solve?

Modern AI coding agents (like Google's Gemini in Antigravity, Anthropic's Claude Code, and OpenAI's Codex) become dramatically more capable when you give them structured instructions called **"Skills"**. A Skill is a specialized behavioral module: it teaches your agent how to audit code for vulnerabilities, design high-end UIs, or orchestrate external tools.

However, developers face two major obstacles:
1. **Cognitive Overload & Choice Paralysis:** Downloading dozens of redundant, competing community skills causes instruction clashes, prompt pollution, and average-quality outputs.
2. **Devastating Token & Budget Waste:**
   - **Input Leaks:** Blind workspace scans index giant files like `package-lock.json`, minified bundles, or `node_modules`, silently burning **250,000+ tokens** in a single prompt!
   - **Output Fluff:** AI models waste expensive generation tokens echoing back conversational pleasantries (*"Certainly! Here is your code..."*) instead of delivering pure code.

**The Skillator solves both problems out of the box.**

---

## The Triple Token-Shield Philosophy (Zero-Token Leak by Design)

The Skillator is engineered to minimize token consumption and maximize speed from day one across three distinct defense layers:

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                 THE TRIPLE TOKEN-SHIELD                                 │
├──────────────────────────┬─────────────────────────────┬────────────────────────────────┤
│ 1. INPUT SHIELD          │ 2. OUTPUT SHIELD            │ 3. TOOL / MCP SHIELD           │
│ tools/init-workspace.ps1 │ skills/silent-coder         │ skills/mcp-orchestrator        │
├──────────────────────────┼─────────────────────────────┼────────────────────────────────┤
│ • Generates native ignore│ • Replaces deprecated       │ • ANTIGRAVITY (Gemini):        │
│   files (.agentsignore,  │   'caveman' mode.           │   Native Lazy-Loading indexes  │
│   .geminiignore,         │ • Bimodal execution: deep   │   MCP signatures, loading      │
│   .claudeignore,         │   hidden reasoning inside   │   schemas ONLY on execution    │
│   .codexignore).         │   <thought>/<thinking> tags │   (zero setup, zero bloat).    │
│ • Merges .vscode/settings│   with zero conversational  │ • CLAUDE CODE & CODEX:         │
│   to exclude lockfiles,  │   fluff outside.            │   Dynamic On-Demand Protocol.  │
│   node_modules, & builds.│ • Code & diffs delivered    │   Servers sleep in registry    │
│ ➔ SAVES 250k - 600k      │   directly.                 │   and attach only per task.    │
│   TOKENS / INCIDENT      │ ➔ SAVES 30% - 50% OUTPUT    │ ➔ SAVES 8k - 15k TOKENS/PROMPT │
└──────────────────────────┴─────────────────────────────┴────────────────────────────────┘
```

---

## The Advice & Curation Architecture

Why does each edition ship with a curated suite of **Core Macro-Skills** instead of hundreds of raw prompts?

### 1. Extensive Research & Macro-Skill Synthesis
We conducted an exhaustive synthesis across thousands of skills from leading open-source repositories:
- [mattpocock/skills](https://github.com/mattpocock/skills) — TypeScript, React, and modern frontend development excellence.
- [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) — Curated agentic behaviors and developer utilities.
- [mukul975/Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) — In-depth cybersecurity auditing and vulnerability analysis.
- [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) — Autonomous agency roles (architects, security leads, analysts).
- [taste-skill](https://github.com/leonxlnx/taste-skill) — Modern aesthetic calibration dials and anti-overfitting layout principles.

Instead of copying fragmented snippets, we synthesized entire roles into high-density **"Macro-Skills"** (such as `premium-frontend-architect`, `devops-cloud-architect`, `mcp-orchestrator`, and `core-security-guard`).

### 2. Preventing "Cognitive Overload" in AI Agents
Providing an AI agent with dozens of overlapping skills degrades model performance:
- **Instruction Clash:** Conflicting guidelines cause model confusion and broken logic.
- **Token Bloat & Latency:** Loading redundant prompts saturates the context window, slowing responses and skyrocketing costs.
- **Generic Fallback:** Overwhelmed models revert to generic, average answers rather than sharp domain expertise.

---

## Choose Your Edition

This repository contains **three tailored editions**, each mapped directly to the native architecture of its respective AI agent:

| Edition | AI Agent / IDE | Native Folder | Native Ignore File | Key Feature |
|:---|:---|:---|:---|:---|
| [**Antigravity**](./The%20Skillator%20Antigravity/) | Google Gemini (Antigravity IDE) | `.agent/` | `.agentsignore`, `.geminiignore` | Gemini-native adaptation + IDE configuration |
| [**Claude Code**](./The%20Skillator%20Claude%20Code/) | Anthropic Claude Code CLI | `.claude/` | `.claudeignore`, `.agentsignore` | Native `<thinking>` tags + MCP orchestration |
| [**Codex**](./The%20Skillator%20Codex/) | OpenAI Codex / CLI | `.codex/` | `.codexignore`, `.agentsignore` | GPT-4o / Astra prompt injection shields |

---

## The 3-Command Modular Tool Suite

The Skillator separates concerns into three dedicated, standalone tools inside the `tools/` directory of each edition:

```
tools/
├── manage-skills.ps1   # [Tool 1] Pure Skill App Store (Search, Cache, Install, Security-Scan)
├── init-workspace.ps1  # [Tool 2] Zero-Token Environment Shield (Configures ignore files & VS Code)
└── setup-project.ps1   # [Tool 3] Master Bootstrapper (All-In-One: Shields workspace + deploys skills)
```

### 1. `manage-skills.ps1` — The Skill Manager & App Store
Transforms your terminal into a **Universal Multi-Repository Skill Catalog**:
- **Smart Ranking:** Highlights curated `[CORE MACRO-SKILL]` recommendations above raw community files.
- **Skill-Spector Integration:** Automatically scans third-party skills for prompt injections and malicious code before installation.
- **Auto-Adaptation:** Automatically adapts terminology so Claude skills work natively on Gemini and Codex.

```powershell
.\tools\manage-skills.ps1 -UpdateCache               # Fetch/update all GitHub skill catalogs
.\tools\manage-skills.ps1 -Search "security"         # Search skills with Core Macro-Skills at the top
.\tools\manage-skills.ps1 -Install "core-security-guard" # Install & scan a specific skill
.\tools\manage-skills.ps1 -ListActive                # Show active skills in project
```

### 2. `init-workspace.ps1` — The Zero-Token Environment Optimizer
Prepares any existing or new project directory to eliminate background token waste:
- Creates `.agentsignore`, `.geminiignore` (or `.claudeignore` / `.codexignore`).
- Intelligently merges `.vscode/settings.json` to prevent IDE search indexing on `package-lock.json`, minified bundles, `node_modules`, and mobile build folders (`.expo`, `android`, `ios`).

```powershell
# Optimize current folder:
.\tools\init-workspace.ps1

# Or optimize a specific project:
.\tools\init-workspace.ps1 -TargetDir "C:\path\to\my-app"
```

### 3. `setup-project.ps1` — Master All-In-One Bootstrapper (Beginner Friendly)
The fastest way to initialize any new or existing project:
1. Shields the project directory with `init-workspace.ps1`.
2. Deploys the curated foundation skills directly into the project's configuration folder.
3. Optionally registers the global CLI command!

```powershell
# Set up environment and install all foundation skills in one step:
.\tools\setup-project.ps1 -TargetDir "C:\path\to\my-app"

# Register the global 'skillator' CLI command in your PowerShell:
.\tools\setup-project.ps1 -InstallGlobalAlias
```

> **💡 Global CLI Superpower:** Once registered via `-InstallGlobalAlias`, you can open any terminal in any directory and type:
> - `skillator init` $\rightarrow$ Instantly shield the current directory at token zero.
> - `skillator setup` $\rightarrow$ Shield directory + install all foundation skills.
> - `skillator search <keyword>` $\rightarrow$ Search skills with smart ranking.

---

## Quick Start (Beginners & Experts)

### Method 1: Express Agent Setup (Zero Commands Required)
If you prefer not to touch the terminal, let your AI agent handle the entire setup. Open your AI agent inside your chosen workspace folder and paste this prompt:

```text
Please set up "https://github.com/LordHunder/The-Skillator" in this workspace for me:
1. Run ".\tools\init-workspace.ps1" to protect this workspace from token leakage.
2. Copy the pre-installed Core Macro-Skills into my active skills folder.
3. Confirm once completed and explain how my skills are ready to use!
```

### Method 2: Manual Setup via PowerShell

1. **Clone this repository:**
   ```bash
   git clone https://github.com/LordHunder/The-Skillator.git
   ```

2. **Navigate to your edition:**
   ```powershell
   cd "The-Skillator\The Skillator Antigravity"   # or Claude Code, or Codex
   ```

3. **Bootstrap any target project:**
   ```powershell
   .\tools\setup-project.ps1 -TargetDir "C:\path\to\your-project"
   ```

---

## Curated Core Macro-Skills (The Foundation Suite)

Each edition ships with these battle-tested, high-density Macro-Skills pre-installed:

| Skill | Description & Recent Enhancements |
|:---|:---|
| `silent-coder` | **New:** Replaces `caveman`. Bimodal directive: outputs pure diffs/code with hidden `<thought>` reasoning on implementation tasks; provides articulate analysis on advisory tasks. Cuts output tokens by 30-50%. |
| `mcp-orchestrator` | **New:** Directs your agent to discover and orchestrate external Model Context Protocol tools (Playwright browser automation, Agent Reach web intelligence, databases). |
| `premium-frontend-architect` | **Enhanced:** Agency-grade UI architecture. Incorporates **Taste Dials** (`DESIGN_VARIANCE`, `VISUAL_DENSITY`, `MOTION_INTENSITY`) and anti-overfitting Google Fonts guidelines to eliminate generic designs. |
| `core-security-guard` | **Enhanced:** Real-time safety guardian. Protects against secret leaks, injection flaws, and includes specialized **LLM Prompt Injection / Jailbreak sanitization**. |
| `accessibility-and-performance` | WCAG compliance, Core Web Vitals, and runtime performance benchmarks. |
| `brainstorming` | Structured ideation and architectural alignment before code execution. |
| `brand-identity` | Single source of truth for design tokens, typography, and visual voice. |
| `codebase-onboarding-explorer` | Rapid architectural mapping and entry-point analysis for unfamiliar codebases. |
| `database-sql-optimizer` | Query optimization, indexing strategies, and relational schema modeling. |
| `deep-security-audit` | Comprehensive full-stack threat modeling and vulnerability scanning. |
| `design-craft` | Layout mathematics, spatial hierarchy, and visual design laws. |
| `devops-cloud-architect` | Enterprise cloud infrastructure, CI/CD pipelines, and containerization. |
| `error-handling-patterns` | Resilient error propagation, typed Results, and graceful fault recovery. |
| `finance-business-analyst` | Unit economics, SaaS metrics, and commercial technical modeling. |
| `legal-compliance-advisor` | GDPR, HIPAA, and open-source software license auditing. |
| `magic-ui-generator` | High-speed component generation via 21st.dev primitives. |
| `motion-choreographer` | Physics-based spring animations, layout transitions, and micro-interactions. |
| `project-memory-archivist` | Cross-session memory persistence and progress logging for long-running workflows. |
| `seo-aeo-optimizer` | Modern search engine and Answer Engine Optimization (AI search visibility). |
| `skill-creator` | **Essential Meta-Skill:** Teaches your agent how to generate, scaffold, and refine new custom skills following strict YAML frontmatter, progressive disclosure, and non-conflicting directives. |
| `ui-redesign` | Surgical visual modernization for legacy interfaces. |
| `writing-plans` | Comprehensive step-by-step implementation blueprints and verification steps. |

---

## Folder Structure

```
The Skillator/
├── The Skillator Antigravity/     # Google Gemini / Antigravity IDE edition
│   ├── .agent/skills/            # 22 Core Macro-Skills
│   └── tools/                    # manage-skills, init-workspace, setup-project
├── The Skillator Claude Code/     # Anthropic Claude Code edition
│   ├── .claude/skills/           # 22 Core Macro-Skills
│   └── tools/                    # manage-skills, init-workspace, setup-project
├── The Skillator Codex/           # OpenAI Codex / CLI edition
│   ├── .codex/skills/            # 22 Core Macro-Skills
│   └── tools/                    # manage-skills, init-workspace, setup-project
└── README.md                      # Global documentation
```

---

## Author & Contact

**Pietro Canettieri**  
- **Email:** [pietro.canettieri.2008@gmail.com](mailto:pietro.canettieri.2008@gmail.com)  
- **GitHub:** [https://github.com/LordHunder/The-Skillator](https://github.com/LordHunder/The-Skillator)

---

## License

This project is open-source under the MIT License. Special thanks to the creators and maintainers of [mattpocock/skills](https://github.com/mattpocock/skills), [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills), [Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills), [agency-agents](https://github.com/msitarzewski/agency-agents), and [taste-skill](https://github.com/leonxlnx/taste-skill).
