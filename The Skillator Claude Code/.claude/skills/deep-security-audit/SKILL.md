---
name: deep-security-audit
description: >
  Deep-effort on-demand security auditing system. Trigger this skill when the user requests a
  "security check", "cybersecurity audit", "deep audit", "scan project", or "security audit".
  Orchestrates scanning, importing matching skills from cache, executing reviews, generating
  a comprehensive report, and cleaning up.
---

This master skill allows you to conduct a deep, high-effort security audit by leveraging the 754-skill database cached in the workspace.

## Audit Workflow

When triggered, you must execute the audit systematically:

### Step 1: Scan Workspace Technologies
List files and identify the technologies used in the project. For example:
- Python (`.py`, `requirements.txt`)
- Javascript/Node (`.js`, `package.json`)
- Configuration/IAC (`Dockerfile`, `.yaml`, `.tf`)
- Secrets/Configuration (`.env`, `config/`)

### Step 2: Search Relevant Skills in Cache
Run the skill manager to find skills targeting the identified technologies. 
For each technology or risk area, run:
```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\Pietro\.gemini\tools\manage-skills.ps1 -Search "<technology_keyword>"
```
Examples of keywords: `secrets`, `python`, `javascript`, `docker`, `injection`, `owasp`.

### Step 3: Select and Install Relevant Skills
From the search results, select the most relevant skills. Install them dynamically:
```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\Pietro\.gemini\tools\manage-skills.ps1 -Install "<skill-name>"
```
*Note: The script will automatically adapt the skill to be fully compatible with your execution environment.*

### Step 4: Perform the Review
Read each newly installed skill (by viewing its `SKILL.md` under `.agent/skills/<skill-name>/SKILL.md`). Execute its specified workflow checklist against your workspace code.

### Step 5: Compile the Security Report
Write a detailed report summarizing all findings. The report should include:
1. **Summary Table:** A list of all checks run and their status (Passed / Failed / Info).
2. **Detailed Findings:** For any failed checks, explain the risk, show the offending line of code, and propose a secure fix (including code snippets).
3. **Remediation Steps:** Clear instructions for how the developer should patch the issues.

Save the report to:
`artifacts/security_audit_report.md` (or write it directly to the chat if requested).

### Step 6: Workspace Cleanup
Uninstall the temporary skills you imported to restore the workspace to a lightweight state:
```powershell
powershell -ExecutionPolicy Bypass -File .\tools\manage-skills.ps1 -Uninstall "<skill-name>"
```
Verify they are removed by listing active skills:
```powershell
powershell -ExecutionPolicy Bypass -File .\tools\manage-skills.ps1 -ListActive
```

