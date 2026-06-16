#!/usr/bin/env bash
# Loop Engineering installer (macOS / Linux / WSL)
#
# Installs the Loop Engineering skill package into Claude Code, Codex, Cursor,
# or Trae, at either user (global) or project scope.
#
# Usage:
#   ./install.sh <target> [options]
#
# Targets:
#   claude-code    Install into Claude Code
#   codex          Install into OpenAI Codex
#   cursor         Install rules into Cursor (project scope only)
#   trae           Install into Trae / Trae Worker
#
# Options:
#   --scope <global|project>   Install scope. Default: global (cursor: project)
#   --project-dir <path>       Target project directory. Default: current dir
#   --with-state               Also copy templates/state/* into <project>/state/
#   --with-rules               Also write rules-template.md into the platform's rules file
#   --dry-run                  Show what would happen, do not change anything
#   --force                    Overwrite an existing installation without prompting
#   -h, --help                 Show this help
#
# Examples:
#   ./install.sh claude-code --scope global --with-rules
#   ./install.sh codex --scope project --project-dir ~/work/my-app --with-state --with-rules
#   ./install.sh cursor --project-dir ~/work/my-app --with-rules
#   ./install.sh trae --scope global

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_NAME="loop-engineering"

target=""
scope=""
project_dir="$(pwd)"
with_state=0
with_rules=0
dry_run=0
force=0

print_help() {
  sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'
}

log()   { printf '[install] %s\n' "$*"; }
warn()  { printf '[install] WARNING: %s\n' "$*" >&2; }
fail()  { printf '[install] ERROR: %s\n' "$*" >&2; exit 1; }

run() {
  if [ "$dry_run" -eq 1 ]; then
    printf '[dry-run] %s\n' "$*"
  else
    eval "$@"
  fi
}

require_repo_root() {
  if [ ! -f "$SCRIPT_DIR/SKILL.md" ] || [ ! -d "$SCRIPT_DIR/templates" ]; then
    fail "install.sh must live next to SKILL.md and templates/. Got: $SCRIPT_DIR"
  fi
}

copy_skill() {
  local dest="$1"
  local parent
  parent="$(dirname "$dest")"

  if [ -e "$dest" ] && [ "$force" -ne 1 ]; then
    fail "destination already exists: $dest (use --force to overwrite)"
  fi

  run "mkdir -p '$parent'"
  if [ -e "$dest" ]; then
    run "rm -rf '$dest'"
  fi
  run "mkdir -p '$dest'"

  # Copy methodology files only — skip installer scripts and VCS / CI metadata
  for item in SKILL.md README.md CHANGELOG.md LICENSE CONTRIBUTING.md \
              docs references templates adapters examples; do
    if [ -e "$SCRIPT_DIR/$item" ]; then
      run "cp -R '$SCRIPT_DIR/$item' '$dest/'"
    fi
  done

  log "skill installed at: $dest"
}

copy_state() {
  local proj="$1"
  if [ "$with_state" -ne 1 ]; then return; fi
  local state_dir="$proj/state"
  run "mkdir -p '$state_dir/archive'"
  for f in log.md inbox.md weekly-summary.md judgment-journal.md; do
    if [ -e "$SCRIPT_DIR/templates/state/$f" ]; then
      if [ -e "$state_dir/$f" ] && [ "$force" -ne 1 ]; then
        warn "state file already exists, skipping: $state_dir/$f (use --force to overwrite)"
      else
        run "cp '$SCRIPT_DIR/templates/state/$f' '$state_dir/$f'"
      fi
    fi
  done
  log "state files placed under: $state_dir"
}

write_rules() {
  local proj="$1"
  local rules_filename="$2"   # CLAUDE.md | AGENTS.md | .cursorrules
  if [ "$with_rules" -ne 1 ]; then return; fi
  local rules_src="$SCRIPT_DIR/templates/rules-template.md"
  local rules_dst="$proj/$rules_filename"
  if [ ! -f "$rules_src" ]; then
    fail "rules-template.md missing at: $rules_src"
  fi
  if [ -e "$rules_dst" ] && [ "$force" -ne 1 ]; then
    warn "rules file already exists, skipping: $rules_dst (use --force to overwrite)"
    return
  fi
  run "cp '$rules_src' '$rules_dst'"
  log "rules file written: $rules_dst"
}

install_claude_code() {
  local dest
  if [ "$scope" = "project" ]; then
    dest="$project_dir/.claude/skills/$SKILL_NAME"
  else
    dest="$HOME/.claude/skills/$SKILL_NAME"
  fi
  copy_skill "$dest"
  if [ "$scope" = "project" ]; then
    copy_state "$project_dir"
    write_rules "$project_dir" "CLAUDE.md"
  fi
}

install_codex() {
  local dest
  if [ "$scope" = "project" ]; then
    dest="$project_dir/.codex/skills/$SKILL_NAME"
  else
    dest="$HOME/.codex/skills/$SKILL_NAME"
  fi
  copy_skill "$dest"
  if [ "$scope" = "project" ]; then
    copy_state "$project_dir"
    write_rules "$project_dir" "AGENTS.md"
  fi
}

install_cursor() {
  if [ "$scope" = "global" ]; then
    fail "cursor target does not support --scope global. Use --scope project --project-dir <path>."
  fi
  # Cursor has no native skill auto-loading; we only place a cursorrules file
  # plus optional state directory.
  copy_state "$project_dir"
  write_rules "$project_dir" ".cursorrules"
  log "cursor: rules + state prepared. Skill folder is not auto-loaded by Cursor — see adapters/cursor.md."
}

install_trae() {
  local dest
  if [ "$scope" = "project" ]; then
    dest="$project_dir/.trae/skills/$SKILL_NAME"
  else
    # Trae global skills live under ~/.trae-cn/skills on most platforms
    dest="$HOME/.trae-cn/skills/$SKILL_NAME"
  fi
  copy_skill "$dest"
  if [ "$scope" = "project" ]; then
    copy_state "$project_dir"
    write_rules "$project_dir" "AGENTS.md"
  fi
}

# --- arg parsing ---
if [ $# -eq 0 ]; then
  print_help
  exit 0
fi

target="$1"; shift || true
case "$target" in
  -h|--help) print_help; exit 0 ;;
  claude-code|codex|cursor|trae) ;;
  *) fail "unknown target: $target (use claude-code|codex|cursor|trae, or --help)" ;;
esac

while [ $# -gt 0 ]; do
  case "$1" in
    --scope)        scope="${2:-}"; shift 2 ;;
    --project-dir)  project_dir="${2:-}"; shift 2 ;;
    --with-state)   with_state=1; shift ;;
    --with-rules)   with_rules=1; shift ;;
    --dry-run)      dry_run=1; shift ;;
    --force)        force=1; shift ;;
    -h|--help)      print_help; exit 0 ;;
    *) fail "unknown option: $1" ;;
  esac
done

# Defaults
if [ -z "$scope" ]; then
  if [ "$target" = "cursor" ]; then scope="project"; else scope="global"; fi
fi
case "$scope" in
  global|project) ;;
  *) fail "invalid --scope: $scope (use global or project)" ;;
esac

if [ "$scope" = "project" ] && [ ! -d "$project_dir" ]; then
  fail "project directory does not exist: $project_dir"
fi

require_repo_root

log "target=$target scope=$scope project=$project_dir with_state=$with_state with_rules=$with_rules dry_run=$dry_run force=$force"

case "$target" in
  claude-code) install_claude_code ;;
  codex)       install_codex ;;
  cursor)      install_cursor ;;
  trae)        install_trae ;;
esac

log "done."
