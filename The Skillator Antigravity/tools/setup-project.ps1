<#
.SYNOPSIS
    The Skillator -- Master Workspace & Skills Bootstrapper
.DESCRIPTION
    All-in-one setup tool:
    1. Optimizes the environment with .agentsignore & .vscode/settings.json (Token-Zero defense).
    2. Installs the curated suite of Core Macro-Skills into the project or global Gemini folder.
.PARAMETER TargetDir
    Target directory for the project. Defaults to current working directory.
.PARAMETER GlobalGemini
    If set, installs skills into global user profile (~/.gemini/skills) instead of the local project.
.PARAMETER InstallGlobalAlias
    Registers the 'skillator' unified command globally in PowerShell.
#>
[CmdletBinding()]
param (
    [string]$TargetDir = ".",
    [switch]$GlobalGemini,
    [switch]$InstallGlobalAlias
)

$ToolsDir = $PSScriptRoot
$ProjectRoot = Split-Path -Parent $ToolsDir

# Resolve target directory
$resolvedTarget = if ([string]::IsNullOrWhiteSpace($TargetDir) -or $TargetDir -eq ".") {
    (Get-Location).Path
} else {
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($TargetDir)
}

if (-not (Test-Path $resolvedTarget)) {
    Write-Host "[*] Target directory does not exist. Creating: $resolvedTarget" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $resolvedTarget -Force | Out-Null
}

# Handle Global CLI registration if requested
if ($InstallGlobalAlias) {
    $profilePath = $PROFILE
    $profileDir = Split-Path -Parent $profilePath
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    if (-not (Test-Path $profilePath)) {
        New-Item -ItemType File -Path $profilePath -Force | Out-Null
    }

    $initScript = Join-Path $ToolsDir "init-workspace.ps1"
    $skillsScript = Join-Path $ToolsDir "manage-skills.ps1"
    $setupScript = $PSCommandPath

    $aliasBlock = @"

# >>> The Skillator Global CLI >>>
function skillator {
    param([Parameter(ValueFromRemainingArguments = `$true)]`$argsList)
    if (`$argsList.Count -eq 0) {
        Write-Host "The Skillator CLI -- Usage:" -ForegroundColor Cyan
        Write-Host "  skillator init [path]         # Optimize environment (Zero Token Leak)" -ForegroundColor White
        Write-Host "  skillator setup [path]        # All-in-one setup (Environment + 20 Core Skills)" -ForegroundColor White
        Write-Host "  skillator search <keyword>    # Search skills catalog" -ForegroundColor White
        Write-Host "  skillator install <skill>     # Install a specific skill" -ForegroundColor White
        Write-Host "  skillator list                # List active skills" -ForegroundColor White
        return
    }
    `$subCmd = `$argsList[0].ToLower()
    switch (`$subCmd) {
        "init" {
            `$target = if (`$argsList.Count -gt 1) { `$argsList[1] } else { "." }
            & "$initScript" -TargetDir `$target
        }
        "setup" {
            `$target = if (`$argsList.Count -gt 1) { `$argsList[1] } else { "." }
            & "$setupScript" -TargetDir `$target
        }
        "search" {
            & "$skillsScript" -Search `$argsList[1]
        }
        "install" {
            & "$skillsScript" -Install `$argsList[1]
        }
        "uninstall" {
            & "$skillsScript" -Uninstall `$argsList[1]
        }
        "list" {
            & "$skillsScript" -ListActive
        }
        "all" {
            & "$skillsScript" -ListAll
        }
        "update" {
            & "$skillsScript" -UpdateCache
        }
        default {
            & "$skillsScript" @argsList
        }
    }
}
# <<< The Skillator Global CLI <<<
"@

    $existingProfile = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue
    if ($existingProfile -match "# >>> The Skillator Global CLI >>>") {
        Write-Host "Updating existing 'skillator' global command in $profilePath..." -ForegroundColor Yellow
        $existingProfile = $existingProfile -replace '(?s)# >>> The Skillator Global CLI >>>.*?# <<< The Skillator Global CLI <<<', $aliasBlock.Trim()
        Set-Content -Path $profilePath -Value $existingProfile -Encoding UTF8
    } else {
        Add-Content -Path $profilePath -Value $aliasBlock -Encoding UTF8
    }

    Write-Host "[OK] 'skillator' registered globally in PowerShell ($profilePath)" -ForegroundColor Green
    Write-Host "     Restart terminal or execute '. `$PROFILE' to activate." -ForegroundColor Gray
    Write-Host ""
}

Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "[*] THE SKILLATOR -- MASTER WORKSPACE & SKILLS BOOTSTRAPPER" -ForegroundColor Cyan
Write-Host "    Target: $resolvedTarget" -ForegroundColor White
Write-Host "================================================================================" -ForegroundColor Cyan

# Step 1: Optimize Workspace Environment (Token-Zero defense)
$initScriptPath = Join-Path $ToolsDir "init-workspace.ps1"
if (Test-Path $initScriptPath) {
    Write-Host "`n--- Step 1: Environment & Token Shield ---" -ForegroundColor Yellow
    & $initScriptPath -TargetDir $resolvedTarget
} else {
    Write-Host "[WARN] init-workspace.ps1 not found in $ToolsDir" -ForegroundColor Yellow
}

# Step 2: Install Curated Core Macro-Skills
Write-Host "`n--- Step 2: Installing Curated Core Macro-Skills ---" -ForegroundColor Yellow

$sourceSkillsDir = Join-Path $ProjectRoot ".agent\skills"
$targetSkillsDir = if ($GlobalGemini) {
    Join-Path $env:USERPROFILE ".gemini\skills"
} else {
    Join-Path $resolvedTarget ".agent\skills"
}

if (-not (Test-Path $targetSkillsDir)) {
    New-Item -ItemType Directory -Path $targetSkillsDir -Force | Out-Null
}

if (Test-Path $sourceSkillsDir) {
    $skillsList = Get-ChildItem -Path $sourceSkillsDir -Directory
    $count = 0
    foreach ($skill in $skillsList) {
        $dest = Join-Path $targetSkillsDir $skill.Name
        if (-not (Test-Path $dest)) {
            Copy-Item -Path $skill.FullName -Destination $dest -Recurse -Force
            Write-Host "  [+] Installed skill: $($skill.Name)" -ForegroundColor Green
            $count++
        } else {
            Write-Host "  [=] Already active:  $($skill.Name)" -ForegroundColor DarkGray
        }
    }
    Write-Host "[OK] Successfully deployed $count macro-skills to $targetSkillsDir" -ForegroundColor Green
} else {
    Write-Host "[WARN] Core skills directory not found at $sourceSkillsDir" -ForegroundColor Red
}

Write-Host "`n================================================================================" -ForegroundColor Cyan
Write-Host "[COMPLETE] Workspace is fully configured and ready for high-performance AI work!" -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor Cyan
exit 0
