<#
.SYNOPSIS
    The Skillator -- Zero-Token Workspace Environment Optimizer
.DESCRIPTION
    Configures .agentsignore, .geminiignore, and .vscode/settings.json in a target workspace
    to prevent context bloat, token leakage, and rate-limit exhaustion.
.PARAMETER TargetDir
    The target project directory to configure. Defaults to the current working directory.
#>
[CmdletBinding()]
param (
    [string]$TargetDir = "."
)

$resolvedTarget = if ([string]::IsNullOrWhiteSpace($TargetDir) -or $TargetDir -eq ".") {
    (Get-Location).Path
} else {
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($TargetDir)
}

if (-not (Test-Path $resolvedTarget)) {
    Write-Host "[*] Target directory does not exist. Creating: $resolvedTarget" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $resolvedTarget -Force | Out-Null
}

Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "[*] THE SKILLATOR -- ZERO-TOKEN WORKSPACE OPTIMIZER" -ForegroundColor Cyan
Write-Host "    Target: $resolvedTarget" -ForegroundColor White
Write-Host "================================================================================" -ForegroundColor Cyan

$agentsIgnoreContent = @"
# ==============================================================================
# The Skillator -- Zero-Token Agent Ignore Matrix
# Prevents context pollution, token waste, and rate-limit exhaustion.
# ==============================================================================

# Dependencies & Package Managers
node_modules/
.pnpm-store/
vendor/

# Lockfiles (Massive token sink: 250k - 600k tokens per read!)
package-lock.json
pnpm-lock.yaml
yarn.lock
bun.lockb
composer.lock
Cargo.lock

# Build Artefacts & Minified Bundles
dist/
build/
out/
.next/
.nuxt/
.output/
.turbo/
target/

# Mobile & Native (Expo, React Native, Android, iOS)
.expo/
android/
ios/
*.apk
*.ipa
*.aab

# Media & Binary Assets (LLM reads only when explicitly requested by user)
*.png
*.jpg
*.jpeg
*.gif
*.webp
*.svg
*.ico
*.mp4
*.mov
*.webm
*.mp3
*.wav
*.pdf
*.zip
*.tar.gz
*.exe
*.dll

# Logs, Cache & Local Environment
*.log
.cache/
.parcel-cache/
coverage/
.nyc_output/
.env.local
.env.*.local
*.tmp
*.temp

# VCS Metadata
.git/
.svn/
.hg/
"@

# 1. Write .agentsignore and .geminiignore
$agentsIgnorePath = Join-Path $resolvedTarget ".agentsignore"
$geminiIgnorePath = Join-Path $resolvedTarget ".geminiignore"

Set-Content -Path $agentsIgnorePath -Value $agentsIgnoreContent -Encoding UTF8
Write-Host "[OK] Created: .agentsignore" -ForegroundColor Green

Set-Content -Path $geminiIgnorePath -Value $agentsIgnoreContent -Encoding UTF8
Write-Host "[OK] Created: .geminiignore" -ForegroundColor Green

# 2. Configure VS Code / IDE workspace settings
$vscodeDir = Join-Path $resolvedTarget ".vscode"
if (-not (Test-Path $vscodeDir)) {
    New-Item -ItemType Directory -Path $vscodeDir -Force | Out-Null
}
$settingsPath = Join-Path $vscodeDir "settings.json"

$settingsObj = @{}
if (Test-Path $settingsPath) {
    try {
        $rawJson = Get-Content $settingsPath -Raw
        $parsed = $rawJson | ConvertFrom-Json
        if ($parsed) {
            foreach ($prop in $parsed.PSObject.Properties) {
                if ($prop.Value -is [System.Management.Automation.PSCustomObject]) {
                    $subHash = @{}
                    foreach ($subProp in $prop.Value.PSObject.Properties) {
                        $subHash[$subProp.Name] = $subProp.Value
                    }
                    $settingsObj[$prop.Name] = $subHash
                } else {
                    $settingsObj[$prop.Name] = $prop.Value
                }
            }
        }
    } catch {
        $settingsObj = @{}
    }
}

if (-not $settingsObj["search.exclude"]) {
    $settingsObj["search.exclude"] = @{}
}
$searchExcludes = @(
    "**/node_modules", "**/package-lock.json", "**/pnpm-lock.yaml", "**/yarn.lock",
    "**/.expo", "**/dist", "**/build", "**/.next", "**/coverage", "**/*.min.js"
)
foreach ($item in $searchExcludes) {
    $settingsObj["search.exclude"][$item] = $true
}

if (-not $settingsObj["files.exclude"]) {
    $settingsObj["files.exclude"] = @{}
}
$filesExcludes = @("**/node_modules", "**/.expo", "**/.git", "**/dist", "**/build")
foreach ($item in $filesExcludes) {
    $settingsObj["files.exclude"][$item] = $true
}

$updatedJson = $settingsObj | ConvertTo-Json -Depth 10
Set-Content -Path $settingsPath -Value $updatedJson -Encoding UTF8
Write-Host "[OK] Configured: .vscode/settings.json (Search and File Excludes active)" -ForegroundColor Green

Write-Host ""
Write-Host "[SUCCESS] Workspace protected against token leakage and context bloat!" -ForegroundColor Green
exit 0
