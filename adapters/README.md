# Adapter Usage Guide

This directory contains the **implementation mappings** of Loop Engineering's core methodology onto different AI agents.

## How to use

1. Read the core [`SKILL.md`](../SKILL.md) first (the universal methodology)
2. Find the adapter file for your current agent
3. Either run the one-line installer (recommended) or follow the manual mapping in the adapter

### One-line install

The repository root ships with [`install.sh`](../install.sh) (macOS / Linux / WSL) and [`install.ps1`](../install.ps1) (Windows PowerShell):

```bash
./install.sh claude-code --scope global --with-rules
./install.sh codex       --scope project --project-dir ~/work/my-app --with-state --with-rules
./install.sh cursor      --project-dir ~/work/my-app --with-rules
./install.sh trae        --scope global
```

```powershell
.\install.ps1 -Target claude-code -Scope global -WithRules
.\install.ps1 -Target codex -Scope project -ProjectDir 'C:\work\my-app' -WithState -WithRules
.\install.ps1 -Target cursor -ProjectDir 'C:\work\my-app' -WithRules
.\install.ps1 -Target trae -Scope global
```

Add `--dry-run` / `-DryRun` to preview, `--force` / `-Force` to overwrite. To uninstall, use [`uninstall.sh`](../uninstall.sh) / [`uninstall.ps1`](../uninstall.ps1) with the same target and scope.

## What adapters do NOT repeat

- Methodology definitions (5 actions, 3-level grading, etc.) → only in [`SKILL.md`](../SKILL.md)
- Anti-pattern catalog → only in [`references/05-anti-patterns.md`](../references/05-anti-patterns.md)
- Guardrail generic descriptions → only in [`references/03-guardrail.md`](../references/03-guardrail.md)

## What adapters do

- Tell you: what each component in [`SKILL.md`](../SKILL.md) maps to in your agent
- Specific commands, filenames, paths, model names
- Agent-specific tips and limitations

## If your agent is not listed

Reference the design pattern in this section:

1. Treat the core methodology (5 actions, 3 levels, 5 core rules) as the invariant logic layer
2. Find how your agent loads rules/skills → that is the rules.md mapping
3. Find how your agent creates custom commands → that is the quick command mapping
4. Find your agent's scheduling/timing capability → that is the automations mapping
