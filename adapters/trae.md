# Trae / Trae Worker Adapter

## Concept mapping

| Core methodology concept | Trae / Trae Worker implementation |
|---|---|
| skills/ directory | `.trae/skills/{name}/SKILL.md` (project-level) or `~/.trae-cn/skills/` (global) |
| rules.md | `AGENTS.md` (project root, compatible with CLAUDE.md) |
| state/ directory | Any location under project root, recommend `.trae/state/` |
| Quick command | Custom Slash Command (Settings → Commands) |
| Scheduling Lv1 | Human says `/{name}` in conversation or mobile one-tap trigger |
| Scheduling Lv2 | Mobile + phone system timer (iOS Shortcuts / Android Tasker) |
| Scheduling Lv3 | GitHub Actions schedule + Trae GitHub integration |
| Generator/Evaluator separation | Two independent tasks + different models (manually select model when creating task) |
| Worktree | Code mode: GitHub branch isolation; Work mode: cloud tasks naturally isolated |
| Connector | MCP (Settings → MCP) + GitHub integration |
| Three-terminal sync | Mobile/Desktop/Web same account real-time sync — natural scheduling/review separation |

## Key differences

- **Work mode** is designed for non-developer roles — operations, sales, product work entirely in Work mode, never touching the code interface
- **No native cron** — scheduling relies on three-phase progression (manual → phone timer → GitHub Actions)
- **No `/goal`** — evaluator uses "generator task + evaluator task" two-step relay
- **Three-terminal sync** is a unique advantage — dispatch from phone, execute on desktop, review anywhere
- Skills auto-load on demand — write clear trigger keywords in the description
- Supports global skills (across all projects) and project skills
- Compatible with `AGENTS.md` and `CLAUDE.md` (auto-loaded after enabling the setting switch)

## Evaluator independence

- Recommend using independent tasks (new conversation window) to run evaluator
- Recommend using a different model for evaluator, but independent task separation alone provides the necessary structural separation
- Models can be selected manually when creating each task (both Work and Code modes support this)

## Quick start

### One-line install (recommended)

```bash
# macOS / Linux / WSL
./install.sh trae --scope global
./install.sh trae --scope project --project-dir ~/work/my-app --with-state --with-rules
```

```powershell
# Windows PowerShell
.\install.ps1 -Target trae -Scope global
.\install.ps1 -Target trae -Scope project -ProjectDir 'C:\work\my-app' -WithState -WithRules
```

Add `--dry-run` / `-DryRun` to preview, `--force` / `-Force` to overwrite.

### Manual install

```bash
# Run from the repository root (the directory that contains SKILL.md).

# 1. Install skill (global, across all projects)
# Option A: Copy folder (rename to drop the version suffix in the destination)
cp -r . %userprofile%/.trae-cn/skills/loop-engineering/
# Option B: Upload zip
# In Trae Settings → Skills → Upload Skill → select loop-engineering.zip

# 2. Create project structure and state directory (in a specific project)
mkdir -p .trae/skills/
mkdir -p .trae/state/archive/
cp templates/state/log.md .trae/state/
cp templates/state/inbox.md .trae/state/
cp templates/state/weekly-summary.md .trae/state/
cp templates/rules-template.md AGENTS.md

# 3. Verify installation
# In Trae conversation: "Help me build a loop"
# Confirm the skill was auto-loaded
```

## Limitations and notes

- **Local tasks require machine to be on** — cloud tasks can run even when machine is off
- **Custom models only available on desktop local environment** — using Claude/GPT as evaluator requires desktop version
- **Web version only supports cloud tasks** — loops involving local files must use desktop version
- **Mobile preview limited** — only supports previewing cloud web pages; local web pages require desktop/web version
- **Skill description affects auto-loading** — must have clear keywords for automatic matching
