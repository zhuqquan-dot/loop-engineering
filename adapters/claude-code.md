# Claude Code Adapter

## Concept mapping

| Core methodology concept | Claude Code implementation |
|---|---|
| skills/ directory | `.claude/skills/{name}/SKILL.md` |
| rules.md | `CLAUDE.md` or `AGENTS.md` (project root) |
| state/ directory | Any location under project root, recommend `state/` |
| Quick command | Custom Slash Command (triggered by `/`) |
| Scheduling Lv1 | Human says `/loop` or `/goal` in terminal |
| Scheduling Lv2 | `/loop {interval} {command}` or cron |
| Scheduling Lv3 | GitHub Actions schedule + `claude` CLI |
| Generator/Evaluator separation | Subagent (`.claude/agents/`) + optionally different models |
| Worktree | `--worktree` or `git worktree` |
| Connector | MCP server |
| "Run until condition met" | `/goal {condition}` — each round judged by a fresh model |

## Key differences

- `/goal` is Claude Code's unique maker-checker product primitive — usable as a lighter evaluator
- `/loop` is session-scoped, defaults to 7-day expiration
- Cloud Routines support running even when machine is off

## Evaluator independence

- Recommend using subagent (`.claude/agents/`) to define the evaluator as an independent agent
- Recommend using a different model for evaluator for best judgment quality; minimum requirement is independent agent/task
- `/goal` is a maker-checker product primitive — each round uses a fresh model to judge stop conditions, inherently independent judgment

## Quick start

### One-line install (recommended)

```bash
# macOS / Linux / WSL — install globally and write CLAUDE.md rules
./install.sh claude-code --scope global --with-rules

# Or per-project
./install.sh claude-code --scope project --project-dir ~/work/my-app --with-state --with-rules
```

```powershell
# Windows PowerShell
.\install.ps1 -Target claude-code -Scope global -WithRules
.\install.ps1 -Target claude-code -Scope project -ProjectDir 'C:\work\my-app' -WithState -WithRules
```

Add `--dry-run` / `-DryRun` to preview the actions, or `--force` / `-Force` to overwrite an existing install.

### Manual install

```bash
# Run from the repository root (the directory that contains SKILL.md).

# 1. Install skill (rename to drop the version suffix in the destination)
cp -r . ~/.claude/skills/loop-engineering/

# 2. Create state directory in your target project
mkdir -p state/archive/
cp templates/state/log.md state/
cp templates/state/inbox.md state/
cp templates/state/weekly-summary.md state/
cp templates/rules-template.md CLAUDE.md

# 3. First command
# In Claude Code conversation: "Use the loop-engineering skill to design a loop for me"
```

## Limitations and notes

- `/loop` and `/goal` syntax and parameters may change with versions — refer to `claude --help`
- Cloud scheduling requires additional GitHub Actions or Cloud Routines configuration
- Worktree functionality requires git ≥ 2.5
