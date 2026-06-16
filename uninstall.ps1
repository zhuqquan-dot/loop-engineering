# Loop Engineering uninstaller (Windows PowerShell)
#
# Removes the Loop Engineering skill package from Claude Code, Codex, Cursor,
# or Trae, at either user (global) or project scope.
#
# Usage:
#   .\uninstall.ps1 -Target <target> [-Scope <global|project>] [-ProjectDir <path>] [-DryRun]

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('claude-code', 'codex', 'cursor', 'trae')]
    [string]$Target,

    [ValidateSet('global', 'project')]
    [string]$Scope = '',

    [string]$ProjectDir = (Get-Location).Path,

    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$SkillName = 'loop-engineering'

function Write-Log { param([string]$Msg) Write-Host "[uninstall] $Msg" }
function Fail      { param([string]$Msg) Write-Error "[uninstall] $Msg"; exit 1 }

function Remove-Pathx {
    param([string]$Path)
    if (Test-Path $Path) {
        if ($DryRun) {
            Write-Host "[dry-run] remove $Path"
        } else {
            Remove-Item -Recurse -Force $Path
        }
        Write-Log "removed: $Path"
    } else {
        Write-Log "not found, skipped: $Path"
    }
}

if ([string]::IsNullOrEmpty($Scope)) {
    if ($Target -eq 'cursor') { $Scope = 'project' } else { $Scope = 'global' }
}

switch ($Target) {
    'claude-code' {
        if ($Scope -eq 'project') {
            Remove-Pathx (Join-Path $ProjectDir ".claude/skills/$SkillName")
        } else {
            Remove-Pathx (Join-Path $HOME ".claude/skills/$SkillName")
        }
    }
    'codex' {
        if ($Scope -eq 'project') {
            Remove-Pathx (Join-Path $ProjectDir ".codex/skills/$SkillName")
        } else {
            Remove-Pathx (Join-Path $HOME ".codex/skills/$SkillName")
        }
    }
    'cursor' {
        Write-Log "cursor uninstall is manual. The installer only writes .cursorrules — review and remove if needed: $(Join-Path $ProjectDir '.cursorrules')"
    }
    'trae' {
        if ($Scope -eq 'project') {
            Remove-Pathx (Join-Path $ProjectDir ".trae/skills/$SkillName")
        } else {
            Remove-Pathx (Join-Path $HOME ".trae-cn/skills/$SkillName")
        }
    }
}

Write-Log "done."
