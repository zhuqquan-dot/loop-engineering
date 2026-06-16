#!/usr/bin/env bash
# Loop Engineering uninstaller (macOS / Linux / WSL)
#
# Removes the Loop Engineering skill package from Claude Code, Codex, Cursor,
# or Trae, at either user (global) or project scope.
#
# Usage:
#   ./uninstall.sh <target> [--scope global|project] [--project-dir PATH] [--dry-run]

set -euo pipefail

SKILL_NAME="loop-engineering"

target=""
scope=""
project_dir="$(pwd)"
dry_run=0

log()  { printf '[uninstall] %s\n' "$*"; }
fail() { printf '[uninstall] ERROR: %s\n' "$*" >&2; exit 1; }
run()  {
  if [ "$dry_run" -eq 1 ]; then printf '[dry-run] %s\n' "$*"; else eval "$@"; fi
}

print_help() { sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'; }

remove_path() {
  local p="$1"
  if [ -e "$p" ]; then
    run "rm -rf '$p'"
    log "removed: $p"
  else
    log "not found, skipped: $p"
  fi
}

if [ $# -eq 0 ]; then print_help; exit 0; fi
target="$1"; shift || true
case "$target" in
  -h|--help) print_help; exit 0 ;;
  claude-code|codex|cursor|trae) ;;
  *) fail "unknown target: $target" ;;
esac

while [ $# -gt 0 ]; do
  case "$1" in
    --scope)       scope="${2:-}"; shift 2 ;;
    --project-dir) project_dir="${2:-}"; shift 2 ;;
    --dry-run)     dry_run=1; shift ;;
    -h|--help)     print_help; exit 0 ;;
    *) fail "unknown option: $1" ;;
  esac
done

if [ -z "$scope" ]; then
  if [ "$target" = "cursor" ]; then scope="project"; else scope="global"; fi
fi

case "$target" in
  claude-code)
    if [ "$scope" = "project" ]; then
      remove_path "$project_dir/.claude/skills/$SKILL_NAME"
    else
      remove_path "$HOME/.claude/skills/$SKILL_NAME"
    fi
    ;;
  codex)
    if [ "$scope" = "project" ]; then
      remove_path "$project_dir/.codex/skills/$SKILL_NAME"
    else
      remove_path "$HOME/.codex/skills/$SKILL_NAME"
    fi
    ;;
  cursor)
    log "cursor uninstall is manual. The installer only writes .cursorrules — review and remove if needed: $project_dir/.cursorrules"
    ;;
  trae)
    if [ "$scope" = "project" ]; then
      remove_path "$project_dir/.trae/skills/$SKILL_NAME"
    else
      remove_path "$HOME/.trae-cn/skills/$SKILL_NAME"
    fi
    ;;
esac

log "done."
