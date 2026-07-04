---
name: core-security-guard
description: >
  Real-time lightweight safety monitor. Automatically monitors code changes and file additions
  to ensure basic security practices (no hardcoded keys, proper input validation, secure defaults)
  are always followed during daily development.
---

This skill acts as your automatic real-time security guardian. Whenever you write code, propose architectural decisions, or edit configuration files, apply these rules:

## Core Rules for Secure Code Writing

### 1. Hardcoded Secrets (Segreti nel Codice)
- Never hardcode API keys, passwords, private tokens, or encryption keys in your source code or configuration files.
- Always use environment variables (e.g. read from `.env` or system variables) or config managers.
- *Analogy: Writing a password in code is like leaving a house key under the doormat with a sign pointing to it.*

### 2. Input Sanitization (Sanitizzazione Input)
- Always assume any input coming from a user, an external system, or an API is untrusted (potentially malicious).
- Ensure inputs are sanitized or validated against expected formats (e.g., regex, type constraints).
- Use parameterized queries (prepared statements) to prevent **SQL Injection** (injection of malicious SQL queries).
- Escape HTML/Javascript characters to prevent **XSS (Cross-Site Scripting)**.
- *Analogy: Sanitization is like washing vegetables before eating them to wash away dirt and bacteria.*

### 3. Error Handling (Gestione Errori)
- Never print internal stack traces, database schemas, or details to the user interface.
- Gracefully log errors internally and present clean, generic messages to the end user.

### 4. Encryption & Secure Protocols (Crittografia e Protocolli Sicuri)
- Do not use legacy, broken protocols (like HTTP, FTP, or Telnet) for sensitive communication. Always default to secure alternatives (HTTPS, SFTP, SSH).
- Use modern cryptographic standards (e.g. AES-256, SHA-256, bcrypt for hashing passwords). Never write custom encryption algorithms.

---

## Action and Warnings

If you notice a violation of these basic security principles in your modifications or in the workspace:
1. Highlight the problem to the user immediately.
2. Explain **why** it is unsafe.
3. Provide the corrected, secure code.
