# 🧠 The Skillator

**An open-source toolkit that gives your AI coding agent superpowers.**

The Skillator is a plug-and-play, multi-repository skill management system for AI coding agents. It lets you browse, install, and manage hundreds of specialized skills from elite public GitHub repositories — with a single command and smart recommendation ranking.

---

## What Problem Does This Solve?

Modern AI coding agents (like Google's Gemini via Antigravity, Anthropic's Claude Code, and OpenAI's Codex) become dramatically more capable when you give them structured instructions called **"Skills"**. A Skill is like a specialized training module: it teaches your agent how to perform a specific task (e.g., "audit this code for SQL injection", "design an agency-grade UI", or "analyze cloud DevOps workflows").

**The problem?** Finding, downloading, organizing, and adapting these skills across fragmented GitHub repositories is tedious, error-prone, and overwhelming. When users search for skills, they are often bombarded with hundreds of redundant files that confuse AI models. 

The Skillator automates and refines the entire process:

1. **Browse & Search** across multiple curated open-source catalogs with smart ranking.
2. **Prevent AI Confusion** by prioritizing distilled, high-density Macro-Skills over redundant community prompts.
3. **Install** any skill with a single command.
4. **Auto-adapt** the skill's language to your specific AI tool (so a skill written for Claude works perfectly on Gemini or Codex).

---

## 🏆 The Curation Philosophy & "The Goldilocks Principle"

Why does each edition ship with exactly **20 pre-installed skills** instead of 100 or 500?

### 1. Extensive Research & Macro-Skill Synthesis
The author, **Pietro Canettieri**, conducted an exhaustive research, curation, and synthesis process across thousands of skills from leading open-source repositories:
- [mattpocock/skills](https://github.com/mattpocock/skills) — TypeScript, React, and modern frontend development excellence.
- [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) — Curated agentic behaviors and developer utilities.
- [mukul975/Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) — In-depth cybersecurity auditing and vulnerability analysis.
- [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) — Complete autonomous AI agency roles (architects, analysts, DevOps leads).

Instead of simply copying raw files, Pietro analyzed the complex agent personas in `agency-agents` and **converted entire autonomous roles into high-density "Macro-Skills"** (such as `premium-frontend-architect`, `devops-cloud-architect`, and `core-security-guard`).

### 2. Preventing "Cognitive Overload" in AI Agents
A common misconception in AI development is that *more skills equal better performance*. In reality, providing an AI agent with 50 or 100 overlapping skills causes **Cognitive Overload**:
- **Instruction Clash:** When multiple skills contain similar or competing rules, the AI becomes confused about which guideline to prioritize.
- **Token Bloat & Latency:** Loading dozens of redundant prompts consumes thousands of unnecessary context tokens, slowing down response times and degrading reasoning quality.
- **Generic Output:** Overwhelmed models revert to generic, average coding patterns rather than applying sharp, specialized expertise.

### 3. The Distilled Foundation (The Essential 20)
The 20 skills pre-installed in your `.agent/skills/` (or `.claude/skills/`, `.codex/skills/`) represent the **Distilled Core Foundation**. It is the precise, optimal number of skills required for an agent to perform every major software engineering, security, UI/UX design, and business analysis task at peak performance — without confusion, overlap, or context dilution.

---

## Choose Your Edition

This repository contains **three editions** of The Skillator, each optimized for a different AI coding agent. **Pick the one that matches your tool:**

| Edition | AI Tool | Config Folder | Instruction File | Key Feature |
|:---|:---|:---|:---|:---|
| [**Antigravity**](./The%20Skillator%20Antigravity/) | Google Gemini (Antigravity IDE) | `.agent/` | `Global Antigravity.md` | Gemini-native adaptation + folder structure prompt |
| [**Claude Code**](./The%20Skillator%20Claude%20Code/) | Anthropic Claude Code | `.claude/` | `CLAUDE.md` | Security hooks + native skill execution |
| [**Codex**](./The%20Skillator%20Codex/) | OpenAI Codex CLI | `.codex/` | `AGENTS.md` | Open standard format + sandbox configuration |

> **Not sure which one to pick?** If you use Google's Antigravity IDE, pick **Antigravity**. If you use Claude Code in the terminal, pick **Claude Code**. If you use OpenAI's Codex CLI, pick **Codex**.

---

## How It Works (The Big Picture)

Each edition follows the same core workflow, but uses the native architecture of its respective AI tool:

```
┌─────────────────────────────────────────────────────────┐
│                    YOUR AI AGENT                         │
│                                                          │
│  1. Reads instruction file (CLAUDE.md / AGENTS.md / etc) │
│  2. Scans installed skills in the config folder           │
│  3. Auto-applies relevant skills to your task             │
└──────────────────────┬──────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│              manage-skills.ps1 (The Skill Manager)       │
│                                                          │
│  • Fetches catalogs from multiple GitHub repositories     │
│  • Smart-ranks search results (Core Macro-Skills first)   │
│  • Installs skills to the correct config folder           │
│  • Auto-adapts language for your specific AI tool         │
└─────────────────────────────────────────────────────────┘
```

### The `manage-skills.ps1` Script (Multi-Repo App Store & Smart Ranking)

This PowerShell script transforms your terminal into a **Universal Multi-Repository App Store** for AI skills. It connects to multiple curated catalogs (`mukul975/Anthropic-Cybersecurity-Skills`, `sickn33/antigravity-awesome-skills`, `mattpocock/skills`, `msitarzewski/agency-agents`) and allows you to add any custom GitHub repository!

#### 💡 Smart Recommendation & Ranking
When you search for a skill (e.g., `.\tools\manage-skills.ps1 -Search "design"`), you might get dozens or hundreds of matches across community repositories. To prevent choice paralysis and cognitive overload, **The Skillator automatically ranks search results**:
1. **[CORE MACRO-SKILL] (Top Recommendations):** Pietro's curated foundation skills appear at the very top, highlighted as the recommended choice because they are optimized against instruction clash.
2. **[COMMUNITY] (Catalog Matches):** Additional matching skills from external repositories appear below for specialized exploration.

| Command | What it does |
|:---|:---|
| `.\tools\manage-skills.ps1 -UpdateCache` | Fetches and updates all curated skill catalogs from GitHub to your local machine. |
| `.\tools\manage-skills.ps1 -AddRepo <url>` | Clones any custom GitHub skill repository into your local catalog cache. |
| `.\tools\manage-skills.ps1 -Search "security"` | Searches all catalogs by keyword and ranks Core Macro-Skills at the top. |
| `.\tools\manage-skills.ps1 -Install "core-security-guard"` | Installs the skill into your active folder and adapts its language for your AI tool. |
| `.\tools\manage-skills.ps1 -Uninstall "core-security-guard"` | Removes an active skill from your workspace. |
| `.\tools\manage-skills.ps1 -ListActive` | Shows all currently installed skills in your active workspace. |
| `.\tools\manage-skills.ps1 -ListAll` | Shows all available skills across all cached GitHub repositories. |

---

## Quick Start

### Prerequisites
- **Windows** with PowerShell 5.1+
- **Git** installed and accessible from the terminal
- One of the supported AI coding agents (Antigravity, Claude Code, or Codex CLI)

### Step-by-step

1. **Clone this repository:**
   ```bash
   git clone https://github.com/LordHunder/The-Skillator.git
   ```

2. **Navigate to your edition's folder:**
   ```bash
   cd "The-Skillator/The Skillator Claude Code"   # or Antigravity, or Codex
   ```

3. **Download the multi-repository skill catalog:**
   ```powershell
   .\tools\manage-skills.ps1 -UpdateCache
   ```

4. **Search and install a skill (notice how Core Macro-Skills are recommended first):**
   ```powershell
   .\tools\manage-skills.ps1 -Search "design"
   .\tools\manage-skills.ps1 -Install "magic-ui-generator"
   ```

5. **Start your AI agent in this folder.** It will automatically detect and use the installed skills without cognitive overload!

---

## Pre-installed Core Macro-Skills (The Gold Standard 20)

Each edition ships with these 20 curated skills pre-installed, representing the perfect foundation for enterprise development:

| Skill | Purpose & Origin |
|:---|:---|
| `accessibility-and-performance` | Web accessibility and performance optimization rules. |
| `brainstorming` | Structured creative ideation before coding begins. |
| `brand-identity` | Single source of truth for design tokens, typography, and voice. |
| `caveman` | Ultra-concise communication protocol to save tokens and time. |
| `codebase-onboarding-explorer` | Rapid structural analysis and mapping of unfamiliar codebases. |
| `core-security-guard` | Real-time safety monitor against credential leaks and vulnerabilities. |
| `database-sql-optimizer` | Advanced query optimization, indexing, and schema design. |
| `deep-security-audit` | Comprehensive vulnerability analysis across full-stack architectures. |
| `design-craft` | Rigorous UI/UX design laws that prevent generic AI visual patterns. |
| `devops-cloud-architect` | Enterprise cloud architecture, CI/CD, and infrastructure workflows (Synthesized from `agency-agents`). |
| `error-handling-patterns` | Resilient error propagation, Result types, and graceful degradation. |
| `finance-business-analyst` | Strategic business modeling, SaaS metrics, and financial analysis (Synthesized from `agency-agents`). |
| `legal-compliance-advisor` | GDPR, HIPAA, and software licensing compliance guidance. |
| `magic-ui-generator` | Rapid generation and integration of production-ready UI components via 21st.dev. |
| `motion-choreographer` | Fluid spring physics, layout transitions, and micro-interactions. |
| `premium-frontend-architect` | Agency-grade frontend architecture, calibrated color, and layout rules (Synthesized from `agency-agents`). |
| `project-memory-archivist` | Persistent project memory logging across sessions and agent handoffs. |
| `seo-aeo-optimizer` | Modern Search Engine and Answer Engine Optimization strategies. |
| `ui-redesign` | Targeted visual modernization for legacy websites and applications. |
| `writing-plans` | Comprehensive step-by-step technical implementation planning. |

---

## Folder Structure (All Editions)

Every edition follows the same clean structure, adapted to the native conventions of each AI tool:

```
The Skillator [Edition]/
├── [config folder]       # .agent/ or .claude/ or .codex/
│   ├── skills/           # Installed Core Macro-Skills
│   ├── [commands/prompts] # Custom workflows
│   └── .env.example      # API key template
├── inputs/               # Your input files (reference documentation, images, specs)
├── outputs/              # Generated results (builds, mockups, exported reports)
├── tools/
│   └── manage-skills.ps1 # Universal Multi-Repo Skill Manager script
├── [instruction file]    # CLAUDE.md or AGENTS.md or Global Antigravity.md
├── skill_creator.md      # Guide for creating custom skills
└── README.md             # Edition-specific documentation
```

---

## Contributing

Contributions are welcome! If you create a high-performance skill, feel free to open a Pull Request or contribute to any of our upstream source repositories.

---

## Author & Contact

**Pietro Canettieri**  
📧 Email: [pietro.canettieri.2008@gmail.com](mailto:pietro.canettieri.2008@gmail.com)  
🐙 GitHub Repository: [https://github.com/LordHunder/The-Skillator](https://github.com/LordHunder/The-Skillator)

---

## License

This project is provided as-is for educational and professional use. Special thanks to the creators and maintainers of [mattpocock/skills](https://github.com/mattpocock/skills), [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills), [Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills), and [agency-agents](https://github.com/msitarzewski/agency-agents) for their pioneering contributions to open-source agentic ecosystems.
