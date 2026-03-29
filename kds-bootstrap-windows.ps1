# ═══════════════════════════════════════════════════════════════════
#  KDS OpenClaw Bootstrap — Windows 11 Edition
#  One script. Fresh machine. No cloud. No headaches.
#
#  HOW TO RUN:
#  1. Right-click Start → Terminal (or PowerShell)
#  2. Paste this command:
#     irm https://raw.githubusercontent.com/LORDBurnItUp/kds-openclaw/main/kds-bootstrap-windows.ps1 | iex
#
#  Or download and run:
#     powershell -ExecutionPolicy Bypass -File kds-bootstrap-windows.ps1
# ═══════════════════════════════════════════════════════════════════

$ErrorActionPreference = "Continue"
$ProgressPreference = "SilentlyContinue"

$GREEN = "`e[32m"
$YELLOW = "`e[33m"
$RED = "`e[31m"
$CYAN = "`e[36m"
$BLUE = "`e[34m"
$NC = "`e[0m"

$WORKSPACE = "$HOME\.openclaw\workspace"
$CONFIG_DIR = "$HOME\.openclaw"
$LOG_FILE = "$env:TEMP\kds-bootstrap-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

function Log($msg) { Write-Host "${CYAN}[KDS]${NC} $msg"; Add-Content $LOG_FILE "[KDS] $msg" }
function Ok($msg) { Write-Host "${GREEN}[OK]${NC} $msg"; Add-Content $LOG_FILE "[OK] $msg" }
function Warn($msg) { Write-Host "${YELLOW}[!]${NC} $msg"; Add-Content $LOG_FILE "[!] $msg" }
function Err($msg) { Write-Host "${RED}[X]${NC} $msg"; Add-Content $LOG_FILE "[X] $msg" }
function Step($msg) { Write-Host "`n${BLUE}═══ $msg ═══${NC}"; Add-Content $LOG_FILE "=== $msg ===" }

# Check admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Warn "Not running as Administrator. Some installs may fail."
    Warn "Right-click PowerShell → 'Run as Administrator' for best results."
}

# ─── PHASE 1: Prerequisites (Node.js, Git) ──────────────────────
Step "PHASE 1: Prerequisites"

function Install-WithWinget($package, $name) {
    if (Get-Command $name -ErrorAction SilentlyContinue) {
        Ok "$name already installed"
        return $true
    }
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Log "Installing $name via winget..."
        winget install $package --accept-package-agreements --accept-source-agreements -e 2>$null
        if ($LASTEXITCODE -eq 0) { Ok "$name installed"; return $true }
    }
    Warn "$name install failed — install manually from the link below"
    return $false
}

# Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Log "Git not found. Installing..."
    winget install Git.Git --accept-package-agreements --accept-source-agreements -e 2>$null
    if ($LASTEXITCODE -eq 0) {
        Ok "Git installed"
        # Refresh PATH
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    } else {
        Err "Git install failed. Download from: https://git-scm.com/download/win"
    }
} else {
    Ok "Git $(git --version)"
}

# Node.js
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Log "Node.js not found. Installing..."
    winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements -e 2>$null
    if ($LASTEXITCODE -eq 0) {
        Ok "Node.js installed"
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    } else {
        Err "Node.js install failed. Download from: https://nodejs.org"
    }
} else {
    Ok "Node.js $(node --version)"
}

# Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Log "Python not found. Installing..."
    winget install Python.Python.3.12 --accept-package-agreements --accept-source-agreements -e 2>$null
    if ($LASTEXITCODE -eq 0) {
        Ok "Python installed"
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    } else {
        Err "Python install failed. Download from: https://python.org"
    }
} else {
    Ok "Python $(python --version)"
}

# ─── PHASE 2: Install OpenClaw ──────────────────────────────────
Step "PHASE 2: OpenClaw"

if (Get-Command openclaw -ErrorAction SilentlyContinue) {
    Ok "OpenClaw already installed"
} else {
    Log "Installing OpenClaw globally..."
    npm install -g openclaw 2>$null
    if (Get-Command openclaw -ErrorAction SilentlyContinue) {
        Ok "OpenClaw installed"
    } else {
        Err "OpenClaw install failed. Try: npm install -g openclaw"
    }
}

# ─── PHASE 3: Kilo CLI ──────────────────────────────────────────
Step "PHASE 3: Kilo CLI"

if (Get-Command kilo -ErrorAction SilentlyContinue) {
    Ok "Kilo CLI already installed"
} else {
    Log "Installing Kilo CLI..."
    npm install -g kilo 2>$null
    if (Get-Command kilo -ErrorAction SilentlyContinue) {
        Ok "Kilo CLI installed"
    } else {
        Warn "Kilo install failed — non-critical, can install later"
    }
}

# ─── PHASE 4: Skill CLIs ───────────────────────────────────────
Step "PHASE 4: Skill CLIs"

# mcporter
if (-not (Get-Command mcporter -ErrorAction SilentlyContinue)) {
    Log "Installing mcporter..."
    npm install -g mcporter 2>$null
    if ($LASTEXITCODE -eq 0) { Ok "mcporter installed" } else { Warn "mcporter install failed" }
} else { Ok "mcporter installed" }

# vercel
if (-not (Get-Command vercel -ErrorAction SilentlyContinue)) {
    Log "Installing vercel..."
    npm install -g vercel 2>$null
    if ($LASTEXITCODE -eq 0) { Ok "vercel installed" } else { Warn "vercel install failed" }
} else { Ok "vercel installed" }

# gh (GitHub CLI)
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Log "Installing GitHub CLI..."
    winget install GitHub.cli --accept-package-agreements --accept-source-agreements -e 2>$null
    if ($LASTEXITCODE -eq 0) { Ok "GitHub CLI installed" } else { Warn "GitHub CLI install failed" }
} else { Ok "GitHub CLI $(gh --version | Select-Object -First 1)" }

# linkedin-api (Python)
Log "Installing Python tools..."
python -m pip install --quiet linkedin-api beautifulsoup4 lxml requests 2>$null
if ($LASTEXITCODE -eq 0) { Ok "Python tools installed" } else { Warn "Some Python packages failed" }

# himalaya (email)
$himalayaDir = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
if (-not (Get-Command himalaya -ErrorAction SilentlyContinue)) {
    Log "Installing himalaya (email CLI)..."
    $himalayaUrl = "https://github.com/pimalaya/himalaya/releases/latest/download/himalaya.x86_64-windows.zip"
    $himalayaZip = "$env:TEMP\himalaya.zip"
    try {
        Invoke-WebRequest -Uri $himalayaUrl -OutFile $himalayaZip -UseBasicParsing
        Expand-Archive -Path $himalayaZip -DestinationPath "$env:LOCALAPPDATA\himalaya" -Force
        # Add to PATH
        $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
        if ($userPath -notlike "*himalaya*") {
            [Environment]::SetEnvironmentVariable("Path", "$userPath;$env:LOCALAPPDATA\himalaya", "User")
            $env:Path += ";$env:LOCALAPPDATA\himalaya"
        }
        Ok "himalaya installed"
    } catch {
        Warn "himalaya install failed — install manually from GitHub releases"
    }
    Remove-Item $himalayaZip -ErrorAction SilentlyContinue
} else { Ok "himalaya installed" }

# ─── PHASE 5: Ollama (Local AI) ─────────────────────────────────
Step "PHASE 5: Ollama (Local AI)"

if (Get-Command ollama -ErrorAction SilentlyContinue) {
    Ok "Ollama already installed"
} else {
    Log "Downloading Ollama for Windows..."
    $ollamaUrl = "https://ollama.ai/download/OllamaSetup.exe"
    $ollamaExe = "$env:TEMP\OllamaSetup.exe"
    try {
        Invoke-WebRequest -Uri $ollamaUrl -OutFile $ollamaExe -UseBasicParsing
        Log "Ollama installer downloaded. Running..."
        Start-Process -FilePath $ollamaExe -ArgumentList "/S" -Wait
        Ok "Ollama installed (restart terminal if 'ollama' command not found)"
    } catch {
        Warn "Ollama auto-install failed. Download from: https://ollama.ai"
        Warn "Run the installer, then: ollama pull qwen2.5:1.5b"
    }
    Remove-Item $ollamaExe -ErrorAction SilentlyContinue
}

# Pull default model
if (Get-Command ollama -ErrorAction SilentlyContinue) {
    Log "Pulling default model (qwen2.5:1.5b)..."
    ollama pull qwen2.5:1.5b 2>$null
    if ($LASTEXITCODE -eq 0) { Ok "Model ready" } else { Warn "Model pull failed — run 'ollama pull qwen2.5:1.5b' manually" }
}

# ─── PHASE 6: Clone Skills & Config ─────────────────────────────
Step "PHASE 6: Workspace Setup"

if (Test-Path $WORKSPACE) {
    Log "Workspace exists. Pulling latest..."
    Set-Location $WORKSPACE
    git pull origin master 2>$null
    Ok "Workspace updated"
} else {
    Log "Cloning KDS workspace..."
    New-Item -ItemType Directory -Path (Split-Path $WORKSPACE) -Force | Out-Null
    git clone https://github.com/LORDBurnItUp/kds-openclaw.git $WORKSPACE 2>$null
    if ($LASTEXITCODE -eq 0) { Ok "Workspace cloned" } else { Err "Clone failed — check internet connection" }
}

# Copy config template
if (-not (Test-Path "$CONFIG_DIR\openclaw.json")) {
    if (Test-Path "$WORKSPACE\kds-config-template.json") {
        Copy-Item "$WORKSPACE\kds-config-template.json" "$CONFIG_DIR\openclaw.json"
        Ok "Config template copied to $CONFIG_DIR\openclaw.json"
        Warn "Edit openclaw.json and fill in your tokens!"
    }
} else {
    Ok "OpenClaw config already exists"
}

# Create .env from template
if (-not (Test-Path "$WORKSPACE\.env")) {
    if (Test-Path "$WORKSPACE\.env.template") {
        Copy-Item "$WORKSPACE\.env.template" "$WORKSPACE\.env"
        Ok ".env created from template"
        Warn "Edit .env and add your API keys!"
    }
} else {
    Ok ".env already exists"
}

# ─── PHASE 7: Environment Variables ─────────────────────────────
Step "PHASE 7: Environment Setup"

# Create env template if missing
if (-not (Test-Path "$WORKSPACE\.env.template")) {
    @"
# KDS Environment Variables
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
GITHUB_TOKEN=ghp_...
GOOGLE_API_KEY=AIzaSy...
X_API_KEY=...
X_API_SECRET=...
X_ACCESS_TOKEN=...
X_ACCESS_TOKEN_SECRET=...
CF_API_TOKEN=...
SUPABASE_URL=...
SUPABASE_SERVICE_KEY=...
NOTION_API_KEY=...
"@ | Set-Content "$WORKSPACE\.env.template"
    Ok "Environment template created"
}

# ─── PHASE 8: Verify Everything ─────────────────────────────────
Step "PHASE 8: Verification"

Write-Host "`n${CYAN}Tool Status:${NC}"
$tools = @("git", "node", "npm", "python", "openclaw", "kilo", "mcporter", "vercel", "gh", "himalaya", "ollama")
foreach ($tool in $tools) {
    if (Get-Command $tool -ErrorAction SilentlyContinue) {
        $version = ""
        try { $version = (& $tool --version 2>$null | Select-Object -First 1) } catch {}
        Ok "$tool : $version"
    } else {
        Err "$tool : NOT FOUND"
    }
}

Write-Host "`n${CYAN}Python Packages:${NC}"
$packages = @("linkedin-api", "beautifulsoup4", "lxml", "requests")
foreach ($pkg in $packages) {
    $installed = python -m pip show $pkg 2>$null
    if ($installed) {
        $ver = ($installed | Select-String "Version").ToString().Split(":")[1].Trim()
        Ok "$pkg : $ver"
    } else {
        Err "$pkg : NOT INSTALLED"
    }
}

Write-Host "`n${CYAN}Files:${NC}"
if (Test-Path "$CONFIG_DIR\openclaw.json") { Ok "Config : $CONFIG_DIR\openclaw.json" } else { Err "Config : MISSING" }
if (Test-Path "$WORKSPACE\.env") { Ok ".env : $WORKSPACE\.env" } else { Warn ".env : needs setup" }
Ok "Workspace : $WORKSPACE"
Ok "Skills : $(Get-ChildItem "$WORKSPACE\skills" -Directory -ErrorAction SilentlyContinue | Measure-Object | Select-Object -ExpandProperty Count) installed"

# ─── DONE ────────────────────────────────────────────────────────
Step "BOOTSTRAP COMPLETE"

Write-Host ""
Write-Host "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
Write-Host "${GREEN}║  KDS OpenClaw Bootstrap Complete (Windows)                   ║${NC}"
Write-Host "${GREEN}║                                                              ║${NC}"
Write-Host "${GREEN}║  Tools installed. Skills ready. Config set up.               ║${NC}"
Write-Host "${GREEN}║                                                              ║${NC}"
Write-Host "${GREEN}║  NEXT STEPS:                                                 ║${NC}"
Write-Host "${GREEN}║  1. Edit .env — add your API keys                            ║${NC}"
Write-Host "${GREEN}║  2. Edit openclaw.json — add your Telegram bot token         ║${NC}"
Write-Host "${GREEN}║  3. Run: openclaw gateway start                              ║${NC}"
Write-Host "${GREEN}║  4. Open: http://localhost:3001                              ║${NC}"
Write-Host "${GREEN}║                                                              ║${NC}"
Write-Host "${GREEN}║  GitHub: github.com/LORDBurnItUp/kds-openclaw               ║${NC}"
Write-Host "${GREEN}║  Log: $LOG_FILE${NC}"
Write-Host "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
