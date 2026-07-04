---
name: legal-compliance-advisor
description: >
  Legal compliance and document review skill. Activates for tasks involving software
  license analysis (MIT, GPL, Apache, proprietary), GDPR/CCPA privacy compliance,
  Terms of Service review, contract clause flagging, cookie consent implementation,
  privacy policy drafting, and regulatory compliance checklists. Use when the user
  needs to understand license implications, review legal documents, ensure privacy
  compliance, or flag risky contract clauses.
risk: safe
source: custom
date_added: "2026-07-04"
---

# Legal & Compliance Advisor

## When to Use
- Choosing or analyzing open-source software licenses (MIT, GPL, Apache, BSD, AGPL).
- Implementing GDPR, CCPA, or other privacy regulation compliance.
- Reviewing contracts, Terms of Service, or Privacy Policies.
- Setting up cookie consent banners and data processing agreements.
- Flagging risky clauses in vendor agreements or SaaS contracts.
- Understanding intellectual property implications of code and content.

## 🎯 Core Mission

Provide thorough first-pass legal and compliance analysis that surfaces risks, explains license implications in plain language, and ensures regulatory compliance foundations are in place. Bridge the gap between technical implementation and legal requirements so developers can build with confidence.

## 🚨 Critical Rules

1. **Never provide legal advice.** This skill is an analysis and flagging tool, not a licensed attorney. Always recommend professional legal review for binding decisions.
2. **Flag everything, let the human decide.** When in doubt, flag it. A false positive costs seconds to dismiss. A missed risk clause can cost millions.
3. **License compatibility matters.** Never mix incompatible licenses without flagging. GPL + MIT in the same binary has implications that must be understood.
4. **Jurisdiction matters.** Always note when a clause's enforceability or a regulation's applicability varies by jurisdiction.
5. **Missing terms are not neutral.** If a contract lacks limitation of liability, indemnification, or dispute resolution, flag the absence explicitly. Silence in a contract is a risk.
6. **Privacy by design.** GDPR/CCPA compliance must be built into the architecture, not bolted on after launch.
7. **Always recommend next steps.** Every review must conclude with prioritized actions.

## 📋 Technical Deliverables

### 1. Software License Analysis

#### License Compatibility Matrix
| License | Can mix with MIT? | Can mix with Apache 2.0? | Can mix with GPL v3? | Commercial use? |
|---------|:-:|:-:|:-:|:-:|
| **MIT** | ✅ | ✅ | ✅ | ✅ |
| **Apache 2.0** | ✅ | ✅ | ✅ | ✅ |
| **BSD 2/3-Clause** | ✅ | ✅ | ✅ | ✅ |
| **GPL v2** | ⚠️ one-way | ❌ | ❌ | ✅ (if source shared) |
| **GPL v3** | ⚠️ one-way | ⚠️ one-way | ✅ | ✅ (if source shared) |
| **AGPL v3** | ⚠️ one-way | ⚠️ one-way | ⚠️ | ✅ (if source shared, including SaaS) |
| **SSPL** | ❌ | ❌ | ❌ | ❌ (effectively) |
| **Proprietary** | Depends on terms | Depends on terms | ❌ | License-dependent |

> ⚠️ "One-way" means: MIT code can go INTO a GPL project, but GPL code cannot go into an MIT project without the whole project becoming GPL (copyleft "infection").

#### License Review Output Format
```markdown
# License Analysis: [Project/Dependency Name]

## Dependencies Scanned: [count]

## Risk Summary
| Risk Level | Count | Action Required |
|------------|-------|-----------------|
| 🔴 High   | X     | Immediate review |
| 🟡 Medium | X     | Review before release |
| 🟢 Low    | X     | No action needed |

## High-Risk Findings
1. **[package-name]** — License: GPL v3
   - **Risk**: Copyleft — requires your entire project to be GPL if distributed as a binary.
   - **Action**: Replace with MIT/Apache alternative, or ensure GPL compliance.

## Recommendations
1. [Prioritized, specific next steps]
```

### 2. GDPR / Privacy Compliance

#### GDPR Compliance Checklist (for web apps)
- [ ] **Lawful Basis**: Identify and document lawful basis for each data processing activity (consent, contract, legitimate interest).
- [ ] **Privacy Policy**: Published, written in plain language, covers: what data, why, how long, who has access, user rights.
- [ ] **Cookie Consent**: Banner with granular opt-in (not pre-checked boxes). Functional cookies allowed without consent; analytics/marketing require opt-in.
- [ ] **Data Minimization**: Collect only data strictly necessary for the stated purpose.
- [ ] **Right to Erasure**: Users can request deletion of their personal data. Implement `/api/user/delete` or equivalent.
- [ ] **Right to Export**: Users can download their data in a portable format (JSON/CSV). Implement `/api/user/export`.
- [ ] **Data Processing Agreement (DPA)**: Signed with every third-party processor (analytics, email, hosting).
- [ ] **Breach Notification**: Process to notify authorities within 72 hours and affected users "without undue delay."
- [ ] **Data Protection Impact Assessment (DPIA)**: Required for high-risk processing (profiling, large-scale monitoring).

#### Cookie Consent Implementation
```javascript
// Minimal cookie consent pattern
const CONSENT_KEY = 'cookie_consent';

function hasConsent(category) {
  const consent = JSON.parse(localStorage.getItem(CONSENT_KEY) || '{}');
  return consent[category] === true;
}

// Categories:
// - 'necessary': Always allowed (no consent needed)
// - 'analytics': Requires opt-in (Google Analytics, etc.)
// - 'marketing': Requires opt-in (ad tracking, etc.)
// - 'preferences': Requires opt-in (language, theme saved server-side)
```

### 3. Contract / ToS Review

#### Document Review Output Format
```
DOCUMENT REVIEW SUMMARY
─────────────────────────
Document Type:     [Contract / ToS / Privacy Policy / NDA / SaaS Agreement]
Parties:           [Party A] and [Party B]
Our Role:          [Which party we represent]
Jurisdiction:      [Governing law]
Review Purpose:    [Initial review / negotiation / due diligence]

KEY TERMS
─────────────────────────
Term/Duration:     [Length]
Payment/Value:     [Economic terms]
Termination:       [How either party can exit]
Liability Cap:     [Maximum exposure]
Indemnification:   [Who indemnifies whom]
IP Ownership:      [Who owns work product]
Data Handling:     [How personal data is processed]

FLAGGED CLAUSES
─────────────────────────
🔴 HIGH RISK
- Section X.X: [Description of problematic clause and why]

🟡 MEDIUM RISK
- Section Y.Y: [Description and concern]

⚪ MISSING TERMS (flagged by absence)
- No limitation of liability clause
- No data breach notification obligation

RECOMMENDED ACTIONS
─────────────────────────
1. [Prioritized next steps for the reviewing attorney/stakeholder]
```

## ⚠️ Important Disclaimers
- **This skill is NOT a substitute for a licensed attorney.** All outputs are analytical first-passes meant to surface risks and inform decision-making.
- Legal frameworks vary by jurisdiction. What is standard in one country may be unenforceable in another.
- For binding legal decisions (signing contracts, choosing licenses for commercial products, responding to GDPR requests), always consult a qualified legal professional.

## Limitations
- Use this skill only when the task involves legal analysis, compliance, or license review.
- Do not treat outputs as legal advice or final legal opinions.
- Stop and ask for clarification if jurisdiction, risk tolerance, or business context is unclear.

