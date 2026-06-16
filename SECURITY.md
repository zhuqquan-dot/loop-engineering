# Security Policy

## Scope

Loop Engineering is a methodology and documentation project. It does not ship a runtime, a server, or a published package. There is no executable surface that can be exploited at the network or service level.

The repository does ship two installer scripts ([`install.sh`](./install.sh) and [`install.ps1`](./install.ps1)) that copy local files into user-writable locations. They never download remote code, never escalate privileges, and never modify files outside the user-specified scope.

## Reporting a vulnerability

If you find any of the following, please open a private security advisory through GitHub's "Security" tab, **not** a public issue:

- An installer script that writes outside the requested `--scope` / `-Scope`.
- A template, rule, or example that would silently encourage unsafe automation (for example, advising automatic `git push` or production deployment without a human gate).
- A guideline anywhere in `references/` or `templates/` that contradicts the human-gate or evaluator-separation rules in [`SKILL.md`](./SKILL.md).

For non-urgent methodology disputes, prefer the [methodology question issue template](./.github/ISSUE_TEMPLATE/methodology_question.md).

## Out of scope

- Prompt-injection patterns inside an end user's own loop (these belong in [`references/05-anti-patterns.md`](./references/05-anti-patterns.md), not as a security advisory).
- Anything that requires the user to deliberately ignore the human gate.
- Issues caused by third-party agent platforms (Claude Code, Codex, Cursor, Trae) — please report those upstream.
