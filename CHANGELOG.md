# CHANGELOG

All notable changes to this project will be documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## v2.2 — 2026-06-16

### Added
- Open-source-facing repository narrative with a rewritten `README.md`
- New `docs/` layer for human-readable public documentation
- Clearer positioning for cross-agent GitHub publication
- Explicit design goals: agent-agnostic, model-agnostic, platform-agnostic, human-gated
- `LICENSE` (MIT)
- `.gitignore` for cross-platform contribution hygiene
- `.gitattributes` to force LF line endings on shell scripts and text files
- `.editorconfig` for consistent editor behavior
- `CONTRIBUTING.md` for adapter and methodology contribution flow
- `SECURITY.md` describing the (small) security surface and reporting channel
- `CODE_OF_CONDUCT.md` (Contributor Covenant 2.1)
- GitHub issue templates under `.github/ISSUE_TEMPLATE/`
- GitHub Actions workflows for Markdown link checking and installer smoke tests
- `docs/README.md` clarifying the boundary between `docs/` and `references/`
- `install.sh` / `install.ps1` and `uninstall.sh` / `uninstall.ps1` — one-line installers and uninstallers for Claude Code, Codex, Cursor, and Trae, with global / project scope, optional state seeding, optional rules-file writing, dry-run, and force flags
- Mermaid lifecycle and runtime topology diagrams in `README.md` and `docs/philosophy.md`
- Project status section and table of contents in `README.md`
- A complete runnable example under `examples/daily-brief/` (discovery + generator + evaluator skills, plus a seeded `state/log.md`)
- `license: MIT` in the main `SKILL.md` frontmatter so skill loaders that surface license metadata pick it up

### Changed
- `SKILL.md` rewritten for a stronger cross-agent core description
- Core package reframed from a private skill bundle into a publishable open-source methodology repository
- Reading order and repository structure clarified for both humans and agents
- Public explanation strengthened around what the method solves and what it does not claim
- Adapter installation commands updated to use repository-root-relative paths instead of the legacy `loop-engineering-v2/` directory name
- Cross-file references in `README.md`, `SKILL.md`, `docs/`, and `adapters/` converted into clickable Markdown links
- Template skills (`generator-example`, `evaluator-example`, `loop-audit`, `discovery-SKILL`) given proper `author` and `version` fields, and the `name` placeholder pattern made explicit instead of using a literal `{name}` slug

### Fixed
- Resolved directory-name drift that would have caused all adapter installation commands to fail after publication
- Removed remaining Chinese passages from the changelog so the public history is fully English

---

## v2.1 — 2026-06-16

### Changed
- The evaluator's core requirement was downgraded from "must use a different model" to "must be an independent sub-agent or independent task"
- Anti-pattern #2 was rephrased from "same model" to "the same agent reviewing its own output"
- Generator and evaluator templates dropped the hard model declaration in favor of "independent sub-agent / independent task"
- All four adapters dropped hard model recommendation pairs in favor of "evaluator independence"
- `rules.md` core rule #1 was updated: the heart of Maker-Checker separation is "different agents", not "different models"

---

## v2.0 — 2026-06-16

### Added
- 30-day trial skeleton (`skeleton-30day.md`)
- Three-level grading system (L-READ / L-DRAFT / L-ACT)
- Hot / warm / cold rolling state model (`08-hot-warm-cold.md`)
- Auto-downgrade mechanism (four consecutive weeks without self-audit triggers an automatic downgrade)
- Evaluator calibration block (`CALIBRATION`) plus auto-reset
- Multi-user governance reference (`06-multi-user.md`)
- Optional cost-control reference (`07-cost-guide.md`)
- Cross-agent adapters (`adapters/` — Claude Code, Codex, Cursor, Trae)
- `author: zhuquan` metadata
- `CHANGELOG.md`

### Changed
- The five hard gates were collapsed into 3 hard gates plus 2 soft prompts
- Removed all platform/source bindings such as references to the "Orange Book" or "Trae"
- `SKILL.md` was rewritten as a generic agent version with no implementation-level instructions
- `budget` was downgraded from a mandatory main-flow file to an optional reference
- `weekly-summary.md` was added as a warm-layer summary file
- `rules.md` added state-file read rules and auto-downgrade rules
- All file paths were turned into placeholders (for example `.trae/` → `{agent-specific}`), with the adapters responsible for mapping

### Removed
- Platform-specific paths in `SKILL.md` (such as `.trae/skills/`)
- `budget.md` was removed from `state/` (moved into `references/07-cost-guide.md`)
- Orange Book references and other source-specific citations
- Trae-exclusive capability mapping documents

---

## v1.0 — 2026-06-16
- Initial release (Trae Worker exclusive)
