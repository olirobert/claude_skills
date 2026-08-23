[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Skills = @(),

    [string]$Target = $(if ($env:CLAUDE_SKILLS_DIR) { $env:CLAUDE_SKILLS_DIR } else { Join-Path $HOME ".claude\skills" }),

    [switch]$Link,
    [switch]$Help
)

if ($Help) {
    Write-Host @"
Usage: .\install.ps1 [-Target <dir>] [-Link] [skill-name ...]

Installs skills from this repo into your Claude skills directory.
With no skill names, installs every skill found in this repo.

  -Target <dir>   Install target directory (default: `$HOME\.claude\skills,
                  or `$env:CLAUDE_SKILLS_DIR if set)
  -Link           Symlink skills instead of copying (requires Developer Mode,
                  or an elevated shell, on Windows)

Examples:
  .\install.ps1                             # install every skill
  .\install.ps1 hello-skill                 # install just one skill
  .\install.ps1 -Link                       # symlink all skills
  .\install.ps1 -Target .\.claude\skills    # install into a project
"@
    exit 0
}

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

New-Item -ItemType Directory -Force -Path $Target | Out-Null

function Test-SkillDir($path) {
    Test-Path (Join-Path $path "SKILL.md")
}

if ($Skills.Count -eq 0) {
    $Skills = Get-ChildItem -Path $RepoRoot -Directory |
        Where-Object { Test-SkillDir $_.FullName } |
        ForEach-Object { $_.Name }
}

if ($Skills.Count -eq 0) {
    Write-Error "No skills found in $RepoRoot"
    exit 1
}

foreach ($name in $Skills) {
    $src = Join-Path $RepoRoot $name
    if (-not (Test-SkillDir $src)) {
        Write-Warning "Skipping '$name': no SKILL.md found at $src"
        continue
    }
    $dest = Join-Path $Target $name
    if (Test-Path $dest) {
        Remove-Item -Recurse -Force $dest
    }
    if ($Link) {
        New-Item -ItemType SymbolicLink -Path $dest -Target $src | Out-Null
        Write-Host "Linked    $name -> $dest"
    } else {
        Copy-Item -Recurse -Path $src -Destination $dest
        Write-Host "Installed $name -> $dest"
    }
}
