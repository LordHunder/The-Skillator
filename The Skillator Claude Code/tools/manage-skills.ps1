[CmdletBinding()]
param (
    [switch]$UpdateCache,
    [string]$Search,
    [string]$Install,
    [string]$Uninstall,
    [switch]$ListActive,
    [switch]$ListAll,
    [switch]$GlobalClaude
)

$CacheDir = Join-Path $env:USERPROFILE ".claude\skills-cache"

# Determine target active skills directory
if ($GlobalClaude) {
    $ActiveSkillsDir = Join-Path $env:USERPROFILE ".claude\skills"
} else {
    # Default to current workspace directory's Claude skills
    $ActiveSkillsDir = Join-Path (Get-Location) ".claude\skills"
}

# Function to extract name and description from SKILL.md YAML frontmatter
function Get-SkillMetadata ($SkillPath) {
    $SkillFile = Join-Path $SkillPath "SKILL.md"
    if (-not (Test-Path $SkillFile)) { return $null }
    
    $content = Get-Content $SkillFile
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
                # Remove quotes if present
                $val = $val.Trim("'", "`"")
                $frontmatter[$key] = $val
            }
        }
    }
    return $frontmatter
}

# 1. Update/Initialize Cache
if ($UpdateCache) {
    if (-not (Test-Path $CacheDir)) {
        Write-Host "Cloning Anthropic-Cybersecurity-Skills to cache..." -ForegroundColor Cyan
        git clone --depth 1 https://github.com/mukul975/Anthropic-Cybersecurity-Skills $CacheDir
    } else {
        Write-Host "Updating cache..." -ForegroundColor Cyan
        Push-Location $CacheDir
        git pull
        Pop-Location
    }
    Write-Host "Cache updated successfully." -ForegroundColor Green
    exit
}

# Ensure Cache exists for remaining operations
if (-not (Test-Path $CacheDir)) {
    Write-Host "Cache not found. Running UpdateCache automatically..." -ForegroundColor Yellow
    if (-not (Test-Path $CacheDir)) {
        Write-Host "Cloning Anthropic-Cybersecurity-Skills to cache..." -ForegroundColor Cyan
        git clone --depth 1 https://github.com/mukul975/Anthropic-Cybersecurity-Skills $CacheDir
    }
}

$SkillsCachePath = Join-Path $CacheDir "skills"

# 2. Search Skills
if ($Search) {
    Write-Host "Searching for skills matching '$Search'..." -ForegroundColor Cyan
    $results = @()
    if (Test-Path $SkillsCachePath) {
        $dirs = Get-ChildItem $SkillsCachePath -Directory
        foreach ($dir in $dirs) {
            $meta = Get-SkillMetadata $dir.FullName
            if ($meta) {
                $name = $meta["name"]
                $desc = $meta["description"]
                if ($name -like "*$Search*" -or $desc -like "*$Search*") {
                    $results += [PSCustomObject]@{
                        Name = $name
                        Description = $desc
                        Path = $dir.FullName
                    }
                }
            }
        }
    }
    
    if ($results.Count -eq 0) {
        Write-Host "No matching skills found." -ForegroundColor Yellow
    } else {
        foreach ($res in $results) {
            Write-Host "----------------------------------------" -ForegroundColor DarkGray
            Write-Host "Name: " -NoNewline; Write-Host $res.Name -ForegroundColor Green
            Write-Host "Desc: $($res.Description)" -ForegroundColor White
        }
        Write-Host "----------------------------------------" -ForegroundColor DarkGray
        Write-Host "Found $($results.Count) matching skills." -ForegroundColor Cyan
    }
    exit
}

# 3. Install Skill
if ($Install) {
    $targetSkillPath = Join-Path $SkillsCachePath $Install
    if (-not (Test-Path $targetSkillPath)) {
        # Try matching by name inside metadata
        $found = $null
        if (Test-Path $SkillsCachePath) {
            foreach ($dir in (Get-ChildItem $SkillsCachePath -Directory)) {
                $meta = Get-SkillMetadata $dir.FullName
                if ($meta -and $meta["name"] -eq $Install) {
                    $found = $dir.FullName
                    break
                }
            }
        }
        if ($found) {
            $targetSkillPath = $found
        } else {
            Write-Host "Skill '$Install' not found in cache." -ForegroundColor Red
            exit 1
        }
    }
    
    $folderName = Split-Path $targetSkillPath -Leaf
    $destPath = Join-Path $ActiveSkillsDir $folderName
    
    if (-not (Test-Path $ActiveSkillsDir)) {
        New-Item -ItemType Directory -Path $ActiveSkillsDir -Force | Out-Null
    }
    
    Write-Host "Installing skill to $destPath..." -ForegroundColor Cyan
    if (Test-Path $destPath) {
        Remove-Item -Path $destPath -Recurse -Force | Out-Null
    }
    Copy-Item -Path $targetSkillPath -Destination $destPath -Recurse -Force
    
    # Claude Code edition: skills are already in native Claude format.
    # No text replacement needed.
    
    Write-Host "Skill '$Install' installed successfully!" -ForegroundColor Green
    exit 0
}

# 4. Uninstall Skill
if ($Uninstall) {
    # Check if uninstall target matches folder name or skill name
    $targetPath = Join-Path $ActiveSkillsDir $Uninstall
    if (-not (Test-Path $targetPath)) {
        # Check by skill name in metadata
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
        Write-Host "Uninstalling skill at $targetPath..." -ForegroundColor Cyan
        Remove-Item -Path $targetPath -Recurse -Force
        Write-Host "Skill uninstalled successfully." -ForegroundColor Green
    } else {
        Write-Host "Skill '$Uninstall' is not currently active." -ForegroundColor Yellow
    }
    exit 0
}

# 5. List Active Skills
if ($ListActive) {
    Write-Host "Active skills in target directory ($ActiveSkillsDir):" -ForegroundColor Cyan
    if (Test-Path $ActiveSkillsDir) {
        $count = 0
        foreach ($dir in (Get-ChildItem $ActiveSkillsDir -Directory)) {
            $meta = Get-SkillMetadata $dir.FullName
            if ($meta) {
                Write-Host " - $($meta['name']): $($meta['description'])" -ForegroundColor Green
                $count++
            } else {
                Write-Host " - $($dir.Name) (no metadata)" -ForegroundColor Yellow
            }
        }
        if ($count -eq 0) { Write-Host "No active skills." -ForegroundColor Yellow }
    } else {
        Write-Host "Target skills folder does not exist: $ActiveSkillsDir" -ForegroundColor Yellow
    }
    exit 0
}

# 6. List All Cache Skills
if ($ListAll) {
    Write-Host "All available skills in cache:" -ForegroundColor Cyan
    if (Test-Path $SkillsCachePath) {
        foreach ($dir in (Get-ChildItem $SkillsCachePath -Directory)) {
            $meta = Get-SkillMetadata $dir.FullName
            if ($meta) {
                Write-Host " - $($meta['name']): $($meta['description'])"
            }
        }
    } else {
        Write-Host "Cache is empty." -ForegroundColor Yellow
    }
    exit 0
}

# Default output if no args provided
Write-Host "Cybersecurity Skill Manager (Claude Code Edition)" -ForegroundColor White
Write-Host "Usage:" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -UpdateCache               # Clone or pull latest skills repo" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -Search <keyword>          # Search skills by keyword" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -Install <skill-name>      # Install a skill (no adaptation needed)" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -Uninstall <skill-name>    # Remove a skill" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -ListActive                # Show currently installed skills" -ForegroundColor Gray
Write-Host "  .\manage-skills.ps1 -ListAll                   # Show all skills available in cache" -ForegroundColor Gray
Write-Host "Switches:" -ForegroundColor Gray
Write-Host "  -GlobalClaude                                  # Target global Claude skills folder" -ForegroundColor Gray
