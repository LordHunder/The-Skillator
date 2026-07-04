[CmdletBinding()]
param (
    [switch]$UpdateCache,
    [string]$AddRepo,
    [string]$Search,
    [string]$Install,
    [string]$Uninstall,
    [switch]$ListActive,
    [switch]$ListAll,
    [switch]$GlobalCodex
)

# 1. Base Paths & Directories
$CacheDir = Join-Path $env:USERPROFILE ".codex\skills-cache"
$ProjectRoot = Split-Path -Parent $PSScriptRoot

if ($GlobalCodex) {
    $ActiveSkillsDir = Join-Path $env:USERPROFILE ".codex\skills"
} else {
    $ActiveSkillsDir = Join-Path $ProjectRoot ".codex\skills"
}

# 2. Pre-defined Curated Repositories
$DefaultRepos = @(
    @{ Name = "anthropic-cybersecurity"; Url = "https://github.com/mukul975/Anthropic-Cybersecurity-Skills" },
    @{ Name = "antigravity-awesome"; Url = "https://github.com/sickn33/antigravity-awesome-skills" },
    @{ Name = "mattpocock-skills"; Url = "https://github.com/mattpocock/skills" },
    @{ Name = "agency-agents"; Url = "https://github.com/msitarzewski/agency-agents" }
)

# 3. The 20 Distilled Core Macro-Skills (The Gold Standard)
$CoreMacroSkills = @(
    "accessibility-and-performance", "brainstorming", "brand-identity", "caveman",
    "codebase-onboarding-explorer", "core-security-guard", "database-sql-optimizer",
    "deep-security-audit", "design-craft", "devops-cloud-architect",
    "error-handling-patterns", "finance-business-analyst", "legal-compliance-advisor",
    "magic-ui-generator", "motion-choreographer", "premium-frontend-architect",
    "project-memory-archivist", "seo-aeo-optimizer", "ui-redesign", "writing-plans"
)

# Helper Function: Extract YAML Frontmatter
function Get-SkillMetadata ($SkillPath) {
    $SkillFile = Join-Path $SkillPath "SKILL.md"
    if (-not (Test-Path $SkillFile)) { return $null }
    
    $content = Get-Content $SkillFile -ErrorAction SilentlyContinue
    $frontmatter = @{}
    $inFront = $false
    foreach ($line in $content) {
        if ($line.Trim() -eq "---") {
            if ($inFront) { break }
            $inFront = $true
            continue
        }
        if ($inFront) {
            if ($line -match "^([^:]+):\s*(.*)$") {
                $key = $Matches[1].Trim()
                $val = $Matches[2].Trim()
                $val = $val.Trim("'", "`"")
                $frontmatter[$key] = $val
            }
        }
    }
    return $frontmatter
}

# 4. Update Cache (Multi-Repository)
if ($UpdateCache) {
    if (-not (Test-Path $CacheDir)) {
        New-Item -ItemType Directory -Path $CacheDir -Force | Out-Null
    }
    
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "[*] UPDATING MULTI-REPOSITORY SKILL CATALOG" -ForegroundColor Cyan
    Write-Host "================================================================================" -ForegroundColor Cyan
    
    foreach ($repo in $DefaultRepos) {
        $repoPath = Join-Path $CacheDir $repo.Name
        if (-not (Test-Path $repoPath)) {
            Write-Host "Cloning $($repo.Name)..." -ForegroundColor Yellow
            git clone --depth 1 $repo.Url $repoPath 2>&1 | Out-Null
        } else {
            Write-Host "Pulling latest changes for $($repo.Name)..." -ForegroundColor Yellow
            Push-Location $repoPath
            git pull 2>&1 | Out-Null
            Pop-Location
        }
    }
    Write-Host "[OK] All skill repositories updated successfully in $CacheDir" -ForegroundColor Green
    exit 0
}

# 5. Add Custom Repository
if ($AddRepo) {
    if (-not (Test-Path $CacheDir)) {
        New-Item -ItemType Directory -Path $CacheDir -Force | Out-Null
    }
    $repoName = ($AddRepo -split "/")[-1].Replace(".git", "")
    $destPath = Join-Path $CacheDir $repoName
    Write-Host "Adding custom repository '$repoName' from $AddRepo..." -ForegroundColor Cyan
    git clone --depth 1 $AddRepo $destPath
    Write-Host "[OK] Repository '$repoName' added to local cache!" -ForegroundColor Green
    exit 0
}

# Ensure Cache exists for searches/installs
if (-not (Test-Path $CacheDir)) {
    Write-Host "Cache not found. Initializing catalog with -UpdateCache..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $CacheDir -Force | Out-Null
    foreach ($repo in $DefaultRepos) {
        $repoPath = Join-Path $CacheDir $repo.Name
        git clone --depth 1 $repo.Url $repoPath 2>&1 | Out-Null
    }
}

# Helper: Find all valid skills across all subfolders in Cache
function Get-AllCachedSkills {
    $results = @()
    $skillFiles = Get-ChildItem -Path $CacheDir -Filter "SKILL.md" -Recurse -ErrorAction SilentlyContinue
    foreach ($file in $skillFiles) {
        $dir = $file.Directory
        $meta = Get-SkillMetadata $dir.FullName
        if ($meta -and $meta["name"]) {
            $relPath = $dir.FullName.Substring($CacheDir.Length + 1)
            $repoSource = ($relPath -split "[\\/]")[0]
            
            $results += [PSCustomObject]@{
                Name = $meta["name"]
                Description = $meta["description"]
                Path = $dir.FullName
                Repo = $repoSource
            }
        }
    }
    return $results
}

# 6. Search Skills (With Top Tier Recommendation Ranking)
if ($Search) {
    Write-Host ("Searching across all curated repositories for '" + $Search + "'...") -ForegroundColor Cyan
    $allSkills = Get-AllCachedSkills
    $matches = $allSkills | Where-Object { $_.Name -like "*$Search*" -or $_.Description -like "*$Search*" }
    
    if ($matches.Count -eq 0) {
        Write-Host ("[ERROR] No matching skills found for '" + $Search + "'.") -ForegroundColor Yellow
        exit 0
    }
    
    $recommendedMatches = @()
    $communityMatches = @()
    
    foreach ($res in $matches) {
        if ($CoreMacroSkills -contains $res.Name) {
            $recommendedMatches += $res
        } else {
            $communityMatches += $res
        }
    }
    
    if ($recommendedMatches.Count -gt 0) {
        Write-Host "================================================================================" -ForegroundColor Yellow
        Write-Host ("[RECOMMENDED] TOP SKILLS FOR '" + $Search + "' (Curated Core Macro-Skills):") -ForegroundColor Yellow
        Write-Host "================================================================================" -ForegroundColor Yellow
        foreach ($res in $recommendedMatches) {
            $desc = $res.Description
            Write-Host " [CORE MACRO-SKILL] " -NoNewline -ForegroundColor Yellow
            Write-Host $res.Name -ForegroundColor Green
            Write-Host ("    Desc: " + $desc) -ForegroundColor White
            Write-Host "    Why Best: Distilled from thousands of community skills & agency models to prevent cognitive overload." -ForegroundColor DarkGray
        }
    }
    
    if ($communityMatches.Count -gt 0) {
        $commCount = $communityMatches.Count
        Write-Host ""
        Write-Host "--------------------------------------------------------------------------------" -ForegroundColor DarkGray
        Write-Host ("[CATALOG] OTHER MATCHING SKILLS FROM COMMUNITY REPOS (" + $commCount + " found):") -ForegroundColor Cyan
        Write-Host "--------------------------------------------------------------------------------" -ForegroundColor DarkGray
        $displayCount = [Math]::Min($communityMatches.Count, 15)
        for ($i = 0; $i -lt $displayCount; $i++) {
            $res = $communityMatches[$i]
            $desc = $res.Description
            Write-Host " [COMMUNITY] " -NoNewline -ForegroundColor Cyan
            Write-Host $res.Name -ForegroundColor Green -NoNewline
            Write-Host (" (Repo: " + $res.Repo + ")") -ForegroundColor Gray
            Write-Host ("    Desc: " + $desc) -ForegroundColor White
        }
        if ($communityMatches.Count -gt 15) {
            $rem = $communityMatches.Count - 15
            Write-Host ("    ... and " + $rem + " more community skills. Try narrowing your keyword!") -ForegroundColor Yellow
        }
    }
    
    Write-Host ""
    Write-Host "[TIP] We strongly recommend prioritizing [CORE MACRO-SKILL]s first!" -ForegroundColor Yellow
    Write-Host "      Installing too many overlapping skills causes AI confusion and prompt clash." -ForegroundColor Gray
    exit 0
}

# 7. Install Skill
if ($Install) {
    $allSkills = Get-AllCachedSkills
    $targetSkill = $allSkills | Where-Object { $_.Name -eq $Install -or ($_.Path -split "[\\/]")[-1] -eq $Install } | Select-Object -First 1
    
    if (-not $targetSkill) {
        Write-Host ("[ERROR] Skill '" + $Install + "' not found in multi-repository cache.") -ForegroundColor Red
        Write-Host ("Run '.\tools\manage-skills.ps1 -Search " + $Install + "' or '-UpdateCache' to fetch latest repos.") -ForegroundColor Yellow
        exit 1
    }
    
    $folderName = Split-Path $targetSkill.Path -Leaf
    $destPath = Join-Path $ActiveSkillsDir $folderName
    
    if (-not (Test-Path $ActiveSkillsDir)) {
        New-Item -ItemType Directory -Path $ActiveSkillsDir -Force | Out-Null
    }
    
    Write-Host ("Installing skill '" + $targetSkill.Name + "' from repo '" + $targetSkill.Repo + "'...") -ForegroundColor Cyan
    if (Test-Path $destPath) {
        Remove-Item -Path $destPath -Recurse -Force | Out-Null
    }
    Copy-Item -Path $targetSkill.Path -Destination $destPath -Recurse -Force
    
    # Text adaptation for Codex / OpenAI
    $SkillFile = Join-Path $destPath "SKILL.md"
    if (Test-Path $SkillFile) {
        $text = Get-Content $SkillFile -Raw
        $text = $text -replace "Claude Code", "Codex/OpenAI"
        $text = $text -replace "Claude", "the AI agent"
        $text = $text -replace "Anthropic", "OpenAI"
        $text = $text -replace "claude", "agent"
        Set-Content -Path $SkillFile -Value $text -Force
    }
    
    Write-Host ("[OK] Skill '" + $targetSkill.Name + "' installed and adapted for Codex successfully!") -ForegroundColor Green
    if ($CoreMacroSkills -contains $targetSkill.Name) {
        Write-Host "[NOTE] This is a Curated Core Macro-Skill -- perfectly optimized for high performance!" -ForegroundColor Yellow
    }
    exit 0
}

# 8. Uninstall Skill
if ($Uninstall) {
    $targetPath = Join-Path $ActiveSkillsDir $Uninstall
    if (-not (Test-Path $targetPath)) {
        if (Test-Path $ActiveSkillsDir) {
            foreach ($dir in (Get-ChildItem $ActiveSkillsDir -Directory)) {
                $meta = Get-SkillMetadata $dir.FullName
                if ($meta -and $meta["name"] -eq $Uninstall) {
                    $targetPath = $dir.FullName
                    break
                }
            }
        }
    }
    
    if (Test-Path $targetPath) {
        Write-Host ("Removing skill from " + $targetPath + "...") -ForegroundColor Cyan
        Remove-Item -Path $targetPath -Recurse -Force
        Write-Host "[OK] Skill uninstalled successfully." -ForegroundColor Green
    } else {
        Write-Host ("[WARN] Skill '" + $Uninstall + "' is not currently active.") -ForegroundColor Yellow
    }
    exit 0
}

# 9. List Active Skills
if ($ListActive) {
    Write-Host ("Active skills in target directory (" + $ActiveSkillsDir + "):") -ForegroundColor Cyan
    if (Test-Path $ActiveSkillsDir) {
        $count = 0
        foreach ($dir in (Get-ChildItem $ActiveSkillsDir -Directory)) {
            $meta = Get-SkillMetadata $dir.FullName
            $skillName = if ($meta) { $meta["name"] } else { $dir.Name }
            $badge = if ($CoreMacroSkills -contains $skillName) { "[CORE MACRO-SKILL]" } else { "[CUSTOM]" }
            
            if ($meta) {
                $desc = $meta["description"]
                Write-Host (" " + $badge + " ") -NoNewline -ForegroundColor Yellow
                Write-Host ($skillName + ": ") -NoNewline -ForegroundColor Green
                Write-Host $desc -ForegroundColor White
            } else {
                Write-Host (" " + $badge + " " + $skillName + " (no metadata)") -ForegroundColor Gray
            }
            $count++
        }
        if ($count -eq 0) { Write-Host "No active skills installed." -ForegroundColor Yellow }
    } else {
        Write-Host ("Target skills folder does not exist: " + $ActiveSkillsDir) -ForegroundColor Yellow
    }
    exit 0
}

# 10. List All Cache Skills
if ($ListAll) {
    Write-Host "Scanning all cached repositories..." -ForegroundColor Cyan
    $allSkills = Get-AllCachedSkills
    $totalCount = $allSkills.Count
    $repoCount = $DefaultRepos.Count
    Write-Host ("Found " + $totalCount + " total skills across " + $repoCount + " repositories:") -ForegroundColor Green
    
    foreach ($res in $allSkills) {
        $badge = if ($CoreMacroSkills -contains $res.Name) { "[CORE]" } else { "[" + $res.Repo + "]" }
        $desc = $res.Description
        Write-Host (" " + $badge + " ") -NoNewline -ForegroundColor Yellow
        Write-Host ($res.Name + ": ") -NoNewline -ForegroundColor Green
        Write-Host $desc -ForegroundColor White
    }
    exit 0
}

# Default Help
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "The Skillator -- Universal Multi-Repo Skill Manager (Codex Edition)" -ForegroundColor White
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "Usage:" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -UpdateCache               # Fetch/update all curated skill catalogs" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -AddRepo <github-url>      # Add any custom GitHub skill repo to cache" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -Search <keyword>          # Search skills (highlights [CORE] Top Recommendations)" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -Install <skill-name>      # Install and adapt a specific skill" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -Uninstall <skill-name>    # Remove an installed skill" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -ListActive                # Show currently installed skills" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -ListAll                   # Show all skills across all cached repos" -ForegroundColor Gray
Write-Host "Switches:" -ForegroundColor Gray
Write-Host "  -GlobalCodex                                   # Target global Codex skills folder" -ForegroundColor Gray
