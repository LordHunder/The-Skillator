# The Skillator — Antigravity Edition (Google Gemini)

This edition of The Skillator is specifically designed and optimized for **Google Gemini** running inside the **Antigravity IDE**. It leverages Gemini's native `.agent/` configuration architecture and automated text adaptation to unlock enterprise-grade coding superpowers.

---

## What Is This?

The Skillator is your AI agent's personal **Universal Multi-Repository App Store** for specialized skills. Instead of manually searching, cloning, and formatting markdown files from fragmented GitHub repositories, a single PowerShell command manages the entire lifecycle.

This specific edition is tailored for Gemini's architecture:
- Skills live in `.agent/skills/`.
- The script automatically adapts skill language from Claude/Anthropic terminology to **Antigravity/Gemini** terminology.

---

## The Curation Philosophy & "The Goldilocks Principle"

Why does this edition ship with exactly **20 pre-installed skills** instead of 100 or 500?

### 1. Extensive Research & Macro-Skill Synthesis
I conducted, with the help of AI, an exhaustive research, curation, and synthesis process across thousands of skills from leading open-source repositories:
- [mattpocock/skills](https://github.com/mattpocock/skills) — TypeScript, React, and modern frontend development excellence.
- [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) — Curated agentic behaviors and developer utilities.
- [mukul975/Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) — In-depth cybersecurity auditing and vulnerability analysis.
- [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) — Complete autonomous AI agency roles (architects, analysts, DevOps leads).

Instead of simply copying raw files, I analyzed the complex agent personas in `agency-agents` and **converted entire autonomous roles into high-density "Macro-Skills"** (such as `premium-frontend-architect`, `devops-cloud-architect`, and `core-security-guard`).

### 2. Preventing "Cognitive Overload" in Gemini
A common misconception in AI development is that *more skills equal better performance*. In reality, providing an AI agent with 50 or 100 overlapping skills causes **Cognitive Overload**:
- **Instruction Clash:** When multiple skills contain similar or competing rules, Gemini becomes confused about which guideline to prioritize.
- **Token Bloat & Latency:** Loading dozens of redundant prompts consumes thousands of unnecessary context tokens, slowing down response times and degrading reasoning quality.
- **Generic Output:** Overwhelmed models revert to generic, average coding patterns rather than applying sharp, specialized expertise.

### 3. The Distilled Foundation (The Essential 20)
The 20 skills pre-installed in `.agent/skills/` represent the **Distilled Core Foundation**. It is the precise, optimal number of skills required for Gemini to perform every major software engineering, security, UI/UX design, and business analysis task at peak performance — without confusion, overlap, or context dilution.

---

## Folder Structure

```
The Skillator Antigravity/
├── .agent/                    # Gemini agent configuration
│   ├── skills/                # 20 pre-installed Core Macro-Skills
│   │   ├── core-security-guard/
│   │   ├── brainstorming/
│   │   ├── design-craft/
│   │   └── ... (17 more)
│   ├── workflows/             # Custom workflows (empty, ready for use)
│   └── .env.example           # Template for API keys (copy to .env)
├── inputs/                    # Your input files go here
├── outputs/                   # Generated results appear here
├── tools/
│   └── manage-skills.ps1      # Universal Multi-Repo Skill Manager script
├── skill_creator.md           # Guide for creating new skills
├── README.md                  # ← You are here
└── .gitignore                 # Protects secrets and temp files
```

---

## How to Use the Multi-Repo App Store

We provide two easy ways to use the store: **Method 1** lets Google Gemini handle the terminal commands for you via a prompt, while **Method 2** shows the manual terminal commands.

### Method 1: Let Gemini Do Everything (Recommended for Beginners)

If you don't want to run terminal commands manually, you can let **Google Gemini** do all the work for you inside the Antigravity IDE! Simply create a folder named whatever you want, open Antigravity IDE inside it, and give Gemini one of these two prompts depending on your preference:

#### Option 1: Express Global Setup (Fastest - Copy the 20 Pre-installed Skills)
If you want instant access to the 20 pre-installed Core Macro-Skills across all your projects without downloading anything, give Gemini this prompt:

```text
Please set up "https://github.com/LordHunder/The-Skillator" in this workspace for me.
Copy the 20 pre-installed Core Macro-Skills from this edition's skill folder (`.agent/skills/`) directly into my global user skills directory (for example, `C:\Users\Pietro\.gemini\skills`).
Please confirm when they are copied and explain what you did in simple terms so I know my 20 foundation skills are ready to use everywhere!
```

#### Option 2: Interactive Step-by-Step Setup (Explore & Custom Install)
If you prefer to explore the full multi-repository catalog and install specific skills step by step, give Gemini this prompt:

```text
Please set up "https://github.com/LordHunder/The-Skillator" in this workspace for me.
1. Run `.\tools\manage-skills.ps1 -UpdateCache` in PowerShell to download the multi-repository skill catalog.
2. Show me a list of available skills or suggest relevant ones based on my project goals.
3. Once I confirm, install the recommended Core Macro-Skills using `.\tools\manage-skills.ps1 -Install "<skill-name>"`.
Please explain each step in simple terms as you do it!
```

> **💡 Beginner Pro Tip: How to Activate Your Skills in Any Chat**  
> Whenever you start a new coding task or project, it is best to remind Gemini by saying: **"Please check what skills I have installed"** (or in Italian: *"Vai a controllare le skill che ho"*). This guarantees that Gemini scans your skill folder and activates all its specialized coding superpowers immediately!

### Method 2: Manual Terminal Commands

#### 1. Download & Update the Skill Catalog

The first time you use The Skillator, download the full multi-repository skill catalog from GitHub:

```powershell
.\tools\manage-skills.ps1 -UpdateCache
```

This clones multiple elite repositories (`anthropic-cybersecurity`, `antigravity-awesome`, `mattpocock-skills`, `agency-agents`) into your user profile folder (`~\.gemini\skills-cache\`).

#### 2. Add Custom GitHub Repositories
Want to add another skill repository to your catalog? One command adds it:
```powershell
.\tools\manage-skills.ps1 -AddRepo "https://github.com/username/awesome-repo.git"
```

#### 3. Search for a Skill (With Smart Ranking)

Looking for something specific? Search by keyword:

```powershell
.\tools\manage-skills.ps1 -Search "design"
```

##### Smart Recommendation Ranking
When searching, the script automatically separates and ranks results to prevent choice paralysis:
1. **[CORE MACRO-SKILL] (Top Recommendations):** Pietro's pre-installed foundation skills appear at the very top, highlighted as the recommended choice because they prevent AI instruction clash.
2. **[COMMUNITY] (Catalog Matches):** Additional matching skills from external repositories appear below for specialized exploration.

#### 4. Install a Skill

Found what you need? Install it with one command:

```powershell
.\tools\manage-skills.ps1 -Install "magic-ui-generator"
```

**What happens behind the scenes:**
1. The script copies the skill folder from the local cache into `.agent/skills/`.
2. It automatically rewrites Claude/Anthropic-specific terms (e.g., "Claude Code" → "Antigravity/Gemini") so the skill reads natively for Gemini.
3. The skill is immediately active — no IDE restart required.

#### 5. List Active & All Skills

See what's currently installed in your workspace:
```powershell
.\tools\manage-skills.ps1 -ListActive
```
See every available skill across all cached GitHub repositories:
```powershell
.\tools\manage-skills.ps1 -ListAll
```

#### 6. Uninstall a Skill

Remove a skill you no longer need:
```powershell
.\tools\manage-skills.ps1 -Uninstall "magic-ui-generator"
```

#### 7. Install to Global Gemini Folder

To make a skill available across **all** your Gemini projects (not just this workspace), use the `-GlobalGemini` flag:
```powershell
.\tools\manage-skills.ps1 -Install "core-security-guard" -GlobalGemini
```
This installs to `~\.gemini\skills\` instead of the local `.agent\skills\`.

---

## Text Adaptation Logic

When skills are installed from any GitHub source, the script automatically replaces these terms:

| Original Term (from source) | Adapted Term (for Gemini) |
|:---|:---|
| `Claude Code` | `Antigravity/Gemini` |
| `Claude` | `the AI agent` |
| `Anthropic` | `Antigravity` |
| `claude` | `agent` |

This guarantees that every downloaded skill functions as if it were written exclusively for Google Gemini.

---

## Creating Your Own Skills

See [`skill_creator.md`](./skill_creator.md) for a complete guide on building custom skills. The key requirements:

1. Create a folder in `.agent/skills/` with your skill's name.
2. Add a `SKILL.md` file with YAML frontmatter (`name`, `description`).
3. Write clear, concise instructions in the markdown body.
4. Keep it under 500 lines.

---

## Author & Contact

**Pietro Canettieri**  
Email: [pietro.canettieri.2008@gmail.com](mailto:pietro.canettieri.2008@gmail.com)  
GitHub Repository: [https://github.com/LordHunder/The-Skillator](https://github.com/LordHunder/The-Skillator)

---

## License

This project is provided as-is for educational and professional use. Special thanks to the creators and maintainers of [mattpocock/skills](https://github.com/mattpocock/skills), [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills), [Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills), and [agency-agents](https://github.com/msitarzewski/agency-agents) for their pioneering contributions to open-source agentic ecosystems.