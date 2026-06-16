# OpenAI Codex Adapter

## Concept mapping

| Core methodology concept | Codex implementation |
|---|---|
| skills/ directory | `.codex/skills/{name}/SKILL.md` |
| rules.md | `AGENTS.md` (project root) |
| state/ directory | Any location under project root, recommend `state/` |
| Quick command | Custom Slash Command |
| Scheduling Lv1 | Human says `/skill-name` in conversation |
| Scheduling Lv2 | Automations tab (daily/weekly + cron) |
| Scheduling Lv3 | Codex Jobs (if released) or GitHub Actions |
| Generator/Evaluator separation | Subagents (`.codex/agents/` TOML definition) |
| Worktree | Built-in background worktree, isolated per automation run |
| Connector | MCP + Plugins |
| Triage inbox | Automation results automatically go into Triage inbox |

## Key differences

- Automations tab is the core scheduling capability — can directly set daily/weekly/cron
- Each automation result goes into Triage inbox, which is equivalent to a built-in inbox mechanism
- No `/goal` equivalent command → evaluator is simulated via independent subagent tasks
- Project can only be linked to one GitHub repository

## Evaluator independence

- Recommend using subagent to define evaluator as an independent agent
- Recommend using a different model for evaluator for best judgment quality; minimum requirement is independent agent/task
- Subagents are defined in `.codex/agents/` TOML files, each can optionally specify a different model

## Quick start

### One-line install (recommended)

```bash
# macOS / Linux / WSL
./install.sh codex --scope global --with-rules
./install.sh codex --scope project --project-dir ~/work/my-app --with-state --with-rules
```

```powershell
# Windows PowerShell
.\install.ps1 -Target codex -Scope global -WithRules
.\install.ps1 -Target codex -Scope project -ProjectDir 'C:\work\my-app' -WithState -WithRules
```

Add `--dry-run` / `-DryRun` to preview, `--force` / `-Force` to overwrite.

### Manual install

```bash
# Run from the repository root (the directory that contains SKILL.md).

# 1. Install skill (rename to drop the version suffix in the destination)
cp -r . .codex/skills/loop-engineering/

# 2. Create state directory in your target project
mkdir -p state/archive/
cp templates/state/log.md state/
cp templates/state/inbox.md state/
cp templates/state/weekly-summary.md state/
cp templates/rules-template.md AGENTS.md

# 3. Set up automation
# Open Automations tab → create new automation → select project + prompt + frequency
```

## Limitations and notes

- Cloud scheduling requires Codex Jobs (may be in roadmap) or external GitHub Actions
- MCP connector availability depends on Codex marketplace and support list
