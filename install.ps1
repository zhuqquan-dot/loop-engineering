# Loop Engineering installer (Windows PowerShell)
#
# Installs the Loop Engineering skill package into Claude Code, Codex, Cursor,
# or Trae, at either user (global) or project scope.
#
# Usage:
#   .\install.ps1 -Target <target> [-Scope <global|project>] [-ProjectDir <path>]
#                 [-WithState] [-WithRules] [-DryRun] [-Force]
#
# Targets:
#   claude-code    Install into Claude Code
#   codex          Install into OpenAI Codex
#   cursor         Install rules into Cursor (project scope only)
#   trae           Install into Trae / Trae Worker
#
# Examples:
#   .\install.ps1 -Target claude-code -Scope global -WithRules
#   .\install.ps1 -Target codex -Scope project -ProjectDir 'C:\work\my-app' -WithState -WithRules
#   .\install.ps1 -Target cursor -ProjectDir 'C:\work\my-app' -WithRules
#   .\install.ps1 -Target trae -Scope global

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('claude-code', 'codex', 'cursor', 'trae')]
    [string]$Target,

    [ValidateSet('global', 'project')]
    [string]$Scope = '',

    [string]$ProjectDir = (Get-Location).Path,

    [switch]$WithState,
    [switch]$WithRules,
    [switch]$DryRun,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillName = 'loop-engineering'

function Write-Log  { param([string]$Msg) Write-Host "[install] $Msg" }
function Write-Warn { param([string]$Msg) Write-Warning "[install] $Msg" }
function Fail       { param([string]$Msg) Write-Error "[install] $Msg"; exit 1 }

function Invoke-Step {
    param([scriptblock]$Action, [string]$Description)
    if ($DryRun) {
        Write-Host "[dry-run] $Description"
    } else {
        & $Action
    }
}

function Require-RepoRoot {
    if (-not (Test-Path (Join-Path $ScriptDir 'SKILL.md')) -or
        -not (Test-Path (Join-Path $ScriptDir 'templates'))) {
        Fail "install.ps1 must live next to SKILL.md and templates/. Got: $ScriptDir"
    }
}

function Copy-Skill {
    param([string]$Dest)

    $parent = Split-Path -Parent $Dest

    if ((Test-Path $Dest) -and (-not $Force)) {
        Fail "destination already exists: $Dest (use -Force to overwrite)"
    }

    Invoke-Step -Description "create directory: $parent" -Action {
        if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    }
    if (Test-Path $Dest) {
        Invoke-Step -Description "remove existing: $Dest" -Action {
            Remove-Item -Recurse -Force $Dest
        }
    }
    Invoke-Step -Description "create directory: $Dest" -Action {
        New-Item -ItemType Directory -Path $Dest -Force | Out-Null
    }

    $items = @('SKILL.md','README.md','CHANGELOG.md','LICENSE','CONTRIBUTING.md',
              'docs','references','templates','adapters','examples')
    foreach ($item in $items) {
        $src = Join-Path $ScriptDir $item
        if (Test-Path $src) {
            Invoke-Step -Description "copy $item -> $Dest" -Action {
                Copy-Item -Recurse -Force -Path $src -Destination $Dest
            }
        }
    }
    Write-Log "skill installed at: $Dest"
}

function Copy-State {
    param([string]$Proj)
    if (-not $WithState) { return }
    $stateDir = Join-Path $Proj 'state'
    $archive  = Join-Path $stateDir 'archive'
    Invoke-Step -Description "create state dir: $stateDir" -Action {
        if (-not (Test-Path $archive)) { New-Item -ItemType Directory -Path $archive -Force | Out-Null }
    }
    foreach ($f in 'log.md','inbox.md','weekly-summary.md','judgment-journal.md') {
        $src = Join-Path $ScriptDir "templates/state/$f"
        $dst = Join-Path $stateDir $f
        if (-not (Test-Path $src)) { continue }
        if ((Test-Path $dst) -and (-not $Force)) {
            Write-Warn "state file already exists, skipping: $dst (use -Force to overwrite)"
            continue
        }
        Invoke-Step -Description "copy state file -> $dst" -Action {
            Copy-Item -Force -Path $src -Destination $dst
        }
    }
    Write-Log "state files placed under: $stateDir"
}

function Write-Rules {
    param([string]$Proj, [string]$RulesFilename)
    if (-not $WithRules) { return }
    $src = Join-Path $ScriptDir 'templates/rules-template.md'
    $dst = Join-Path $Proj $RulesFilename
    if (-not (Test-Path $src)) { Fail "rules-template.md missing at: $src" }
    if ((Test-Path $dst) -and (-not $Force)) {
        Write-Warn "rules file already exists, skipping: $dst (use -Force to overwrite)"
        return
    }
    Invoke-Step -Description "write rules file -> $dst" -Action {
        Copy-Item -Force -Path $src -Destination $dst
    }
    Write-Log "rules file written: $dst"
}

function Install-ClaudeCode {
    if ($Scope -eq 'project') {
        $dest = Join-Path $ProjectDir ".claude/skills/$SkillName"
    } else {
        $dest = Join-Path $HOME ".claude/skills/$SkillName"
    }
    Copy-Skill -Dest $dest
    if ($Scope -eq 'project') {
        Copy-State -Proj $ProjectDir
        Write-Rules -Proj $ProjectDir -RulesFilename 'CLAUDE.md'
    }
}

function Install-Codex {
    if ($Scope -eq 'project') {
        $dest = Join-Path $ProjectDir ".codex/skills/$SkillName"
    } else {
        $dest = Join-Path $HOME ".codex/skills/$SkillName"
    }
    Copy-Skill -Dest $dest
    if ($Scope -eq 'project') {
        Copy-State -Proj $ProjectDir
        Write-Rules -Proj $ProjectDir -RulesFilename 'AGENTS.md'
    }
}

function Install-Cursor {
    if ($Scope -eq 'global') {
        Fail "cursor target does not support -Scope global. Use -Scope project -ProjectDir <path>."
    }
    Copy-State -Proj $ProjectDir
    Write-Rules -Proj $ProjectDir -RulesFilename '.cursorrules'
    Write-Log "cursor: rules + state prepared. Skill folder is not auto-loaded by Cursor — see adapters/cursor.md."
}

function Install-Trae {
    if ($Scope -eq 'project') {
        $dest = Join-Path $ProjectDir ".trae/skills/$SkillName"
    } else {
        $dest = Join-Path $HOME ".trae-cn/skills/$SkillName"
    }
    Copy-Skill -Dest $dest
    if ($Scope -eq 'project') {
        Copy-State -Proj $ProjectDir
        Write-Rules -Proj $ProjectDir -RulesFilename 'AGENTS.md'
    }
}

# Defaults
if ([string]::IsNullOrEmpty($Scope)) {
    if ($Target -eq 'cursor') { $Scope = 'project' } else { $Scope = 'global' }
}
if ($Scope -eq 'project' -and -not (Test-Path $ProjectDir)) {
    Fail "project directory does not exist: $ProjectDir"
}

Require-RepoRoot

Write-Log "target=$Target scope=$Scope project=$ProjectDir withState=$WithState withRules=$WithRules dryRun=$DryRun force=$Force"

switch ($Target) {
    'claude-code' { Install-ClaudeCode }
    'codex'       { Install-Codex }
    'cursor'      { Install-Cursor }
    'trae'        { Install-Trae }
}

Write-Log "done."
