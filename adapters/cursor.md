# Cursor Adapter

## Concept mapping

| Core methodology concept | Cursor implementation |
|---|---|
| skills/ directory | `.cursorrules` at project root, or manually create `.cursor/skills/` and reference manually |
| rules.md | `.cursorrules` (project root, auto-loaded) |
| state/ directory | Any location under project root, recommend `state/` |
| Quick command | Custom Command (Settings → Commands) |
| Scheduling Lv1 | Human trigger (in conversation) |
| Scheduling Lv2 | Background Agents, scheduled trigger |
| Scheduling Lv3 | Cloud Agents or GitHub Actions |
| Generator/Evaluator separation | Two independent conversations / subagents |
| Worktree | Manual `git worktree` |
| Connector | MCP (manual configuration required) |

## Key differences

- **No native Skill auto-loading mechanism** — user must explicitly say "use Loop Engineering" or write core rules into `.cursorrules`
- Background Agents and Cloud Agents capabilities are still evolving — refer to the latest Cursor changelog
- Model selection depends on Cursor's supported model list + the user's own API key

## Recommended approaches

Since Cursor does not have automatic skill loading, two alternatives:

**Option A: Rule-based fallback**

Copy the contents of [`templates/rules-template.md`](../templates/rules-template.md) into `.cursorrules`.
When the user mentions "automation," Cursor reads the rules from the rules file.

**Option B: Explicit conversation reference**

At the start of a conversation say: "First, help me design this using Loop Engineering methodology."

## Quick start

### One-line install (recommended)

```bash
# macOS / Linux / WSL
./install.sh cursor --project-dir ~/work/my-app --with-rules --with-state
```

```powershell
# Windows PowerShell
.\install.ps1 -Target cursor -ProjectDir 'C:\work\my-app' -WithRules -WithState
```

Cursor only supports project scope (it has no global skill directory); the installer writes `.cursorrules` and optionally seeds `state/`.

### Manual install

```bash
# Run from the repository root (the directory that contains SKILL.md).

# Option A: Write rules into .cursorrules in your target project
cp templates/rules-template.md /path/to/your/project/.cursorrules
cd /path/to/your/project
mkdir -p state/archive/
cp /path/to/loop-engineering/templates/state/log.md state/
cp /path/to/loop-engineering/templates/state/inbox.md state/
```

## Limitations and notes

- Cursor's capabilities iterate frequently — check the official latest changelog before each use
- Background Agents and Cloud Agents usage limits depend on your Cursor subscription plan
- If independent evaluator capability is missing, open two separate conversation windows in Cursor to simulate
