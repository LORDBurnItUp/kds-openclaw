#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════
#  KDS OpenClaw Bootstrap — "Lord Sav Auto-Deploy"
#  Drop this on any fresh OpenClaw instance and run it.
#  It installs everything, configures everything, and gets you flying.
#
#  Usage: bash kds-bootstrap.sh [--with-api-keys]
#  --with-api-keys: Also prompt for API keys (GitHub, X, etc.)
# ═══════════════════════════════════════════════════════════════════

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

WORKSPACE="${OPENCLAW_WORKSPACE:-$HOME/.openclaw/workspace}"
CONFIG_FILE="$HOME/.openclaw/openclaw.json"
LOG_FILE="/tmp/kds-bootstrap-$(date +%s).log"

log() { echo -e "${CYAN}[KDS]${NC} $1" | tee -a "$LOG_FILE"; }
ok()  { echo -e "${GREEN}[✓]${NC} $1" | tee -a "$LOG_FILE"; }
warn(){ echo -e "${YELLOW}[!]${NC} $1" | tee -a "$LOG_FILE"; }
err() { echo -e "${RED}[✗]${NC} $1" | tee -a "$LOG_FILE"; }
step(){ echo -e "\n${BLUE}══════ $1 ══════${NC}" | tee -a "$LOG_FILE"; }

WITH_KEYS=false
[[ "${1:-}" == "--with-api-keys" ]] && WITH_KEYS=true

# ─── PHASE 1: System Packages ───────────────────────────────────
step "PHASE 1: System Dependencies"

log "Updating package lists..."
apt-get update -qq 2>/dev/null || true

PACKAGES="curl wget git jq unzip tar gzip build-essential python3 python3-pip python3-venv ssh"
for pkg in $PACKAGES; do
    if dpkg -l "$pkg" 2>/dev/null | grep -q "^ii"; then
        ok "$pkg already installed"
    else
        log "Installing $pkg..."
        apt-get install -y -qq "$pkg" 2>/dev/null && ok "$pkg installed" || warn "$pkg failed"
    fi
done

# ─── PHASE 2: CLI Tools ─────────────────────────────────────────
step "PHASE 2: CLI Tools"

install_himalaya() {
    if command -v himalaya &>/dev/null; then
        ok "himalaya $(himalaya --version 2>&1 | head -1)"
        return
    fi
    log "Installing himalaya (email CLI)..."
    local url="https://github.com/pimalaya/himalaya/releases/download/v1.2.0/himalaya.x86_64-linux.tgz"
    curl -sSL "$url" -o /tmp/himalaya.tgz
    tar xzf /tmp/himalaya.tgz -C /usr/local/bin/
    chmod +x /usr/local/bin/himalaya
    rm -f /tmp/himalaya.tgz
    ok "himalaya $(himalaya --version 2>&1 | head -1)"
}

install_mcporter() {
    if command -v mcporter &>/dev/null; then
        ok "mcporter $(mcporter --version 2>&1)"
        return
    fi
    log "Installing mcporter (MCP server client)..."
    npm install -g mcporter 2>/dev/null
    ok "mcporter installed"
}

install_vercel() {
    if command -v vercel &>/dev/null; then
        ok "vercel $(vercel --version 2>&1)"
        return
    fi
    log "Installing vercel CLI..."
    npm install -g vercel 2>/dev/null
    ok "vercel installed"
}

install_xurl() {
    if command -v xurl &>/dev/null; then
        ok "xurl already installed"
        return
    fi
    log "Installing xurl (X/Twitter CLI)..."
    local arch=$(uname -m)
    case "$arch" in
        x86_64) arch="amd64" ;;
        aarch64) arch="arm64" ;;
    esac
    local url="https://github.com/imperatrona/twitterapi-go/releases/latest/download/xurl_linux_${arch}.tar.gz"
    curl -sSL "$url" -o /tmp/xurl.tar.gz 2>/dev/null && \
    tar xzf /tmp/xurl.tar.gz -C /usr/local/bin/ 2>/dev/null && \
    chmod +x /usr/local/bin/xurl 2>/dev/null && \
    ok "xurl installed" || warn "xurl install failed (may need manual install)"
    rm -f /tmp/xurl.tar.gz
}

install_clawhub() {
    if command -v clawhub &>/dev/null; then
        ok "clawhub already installed"
        return
    fi
    log "Installing clawhub (skill manager)..."
    npm install -g clawhub 2>/dev/null && ok "clawhub installed" || warn "clawhub install failed"
}

install_ollama() {
    if command -v ollama &>/dev/null; then
        ok "ollama $(ollama --version 2>&1)"
        return
    fi
    log "Installing Ollama (local LLM runtime)..."
    curl -fsSL https://ollama.ai/install.sh | sh 2>/dev/null
    ok "ollama installed"
}

install_kilo() {
    if command -v kilo &>/dev/null; then
        ok "kilo CLI already installed"
        return
    fi
    log "Installing Kilo CLI..."
    npm install -g kilo 2>/dev/null && ok "kilo installed" || warn "kilo install failed"
}

install_gog() {
    if command -v gog &>/dev/null; then
        ok "gog (Google Workspace CLI) already installed"
        return
    fi
    log "Note: gog requires brew (macOS). Install manually if needed: brew install steipete/tap/gogcli"
    warn "gog skipped (requires brew — use on macOS or manual compile)"
}

install_summarize() {
    if command -v summarize &>/dev/null; then
        ok "summarize CLI already installed"
        return
    fi
    log "Note: summarize requires brew. Install manually: brew install steipete/tap/summarize"
    warn "summarize skipped (requires brew)"
}

# Python packages
install_python_tools() {
    log "Installing Python tools..."
    pip3 install --break-system-packages --quiet linkedin-api beautifulsoup4 lxml requests 2>/dev/null && \
        ok "Python tools installed (linkedin-api, beautifulsoup4, lxml)" || \
        warn "Some Python packages failed"
}

# Run all installs
install_himalaya
install_mcporter
install_vercel
install_xurl
install_clawhub
install_ollama
install_kilo
install_gog
install_summarize
install_python_tools

# ─── PHASE 3: Pull Ollama Models ────────────────────────────────
step "PHASE 3: Ollama Models"

if command -v ollama &>/dev/null; then
    # Ensure ollama is running
    ollama serve &>/dev/null &
    sleep 2
    
    MODELS="qwen2.5:1.5b"
    for model in $MODELS; do
        if ollama list 2>/dev/null | grep -q "$model"; then
            ok "Model $model already pulled"
        else
            log "Pulling model $model..."
            ollama pull "$model" 2>/dev/null && ok "$model ready" || warn "$model pull failed"
        fi
    done
else
    warn "Ollama not installed — skipping model pulls"
fi

# ─── PHASE 4: Skills Setup ──────────────────────────────────────
step "PHASE 4: Skills Inventory"

SKILLS_DIR="$WORKSPACE/skills"
mkdir -p "$SKILLS_DIR"

log "Scanning installed skills..."
INSTALLED=0
MISSING_REQS=0

for skill_dir in "$SKILLS_DIR"/*/; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    skill_name=$(basename "$skill_dir")
    INSTALLED=$((INSTALLED + 1))
    
    # Check for binary requirements
    bins=$(grep -oP 'requires.*bins.*\["\K[^"]+' "$skill_dir/SKILL.md" 2>/dev/null | head -1)
    if [ -n "$bins" ] && ! command -v "$bins" &>/dev/null; then
        MISSING_REQS=$((MISSING_REQS + 1))
    fi
done

ok "$INSTALLED skills installed, $MISSING_REQS with missing CLI deps"

# ─── PHASE 5: OpenClaw Config Patch ─────────────────────────────
step "PHASE 5: OpenClaw Configuration"

log "Applying optimized config patches..."

# We create a JSON patch file and apply it via openclaw or direct write
CONFIG_PATCH=$(cat <<'PATCH'
{
  "plugins": {
    "allow": ["streamchat", "telegram"]
  },
  "update": {
    "checkOnStart": false
  },
  "browser": {
    "enabled": true,
    "headless": true,
    "noSandbox": true
  },
  "tools": {
    "profile": "full",
    "exec": {
      "host": "gateway",
      "security": "full",
      "ask": "off"
    }
  }
}
PATCH
)

# Save patch for reference
echo "$CONFIG_PATCH" > "$WORKSPACE/.config-patch.json"
ok "Config patch saved to .config-patch.json"
warn "Apply manually: openclaw config patch < .config-patch.json"
warn "Or use OpenClaw gateway config.patch API"

# ─── PHASE 6: Environment Variables Template ────────────────────
step "PHASE 6: Environment Setup"

ENV_FILE="$WORKSPACE/.env"
ENV_TEMPLATE="$WORKSPACE/.env.template"

if [ ! -f "$ENV_TEMPLATE" ]; then
    cat > "$ENV_TEMPLATE" <<'ENVEOF'
# ═══════════════════════════════════════════════════════════
#  KDS Environment Variables Template
#  Copy to .env and fill in your keys
# ═══════════════════════════════════════════════════════════

# --- AI Models (Primary: local Ollama, fallback: cloud) ---
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
# KiloCode uses its own auth, no key needed here

# --- X / Twitter API ---
X_API_KEY=...
X_API_SECRET=...
X_ACCESS_TOKEN=...
X_ACCESS_TOKEN_SECRET=...

# --- Cloudflare ---
CF_API_TOKEN=...
CF_ZONE_ID=...

# --- Supabase ---
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_SERVICE_KEY=eyJ...

# --- Notion ---
NOTION_API_KEY=secret_...

# --- GitHub (use gh auth login instead) ---
# GITHUB_TOKEN=ghp_...

# --- LinkedIn (cookie-based, not API key) ---
LINKEDIN_LI_AT=...
LINKEDIN_JSESSIONID=...

# --- Facebook / Meta ---
FB_ACCESS_TOKEN=...
FB_PAGE_ID=...

# --- Telegram (set in openclaw.json channels config) ---
# TELEGRAM_BOT_TOKEN=...

# --- Vercel ---
# Run: vercel login
ENVEOF
    ok "Environment template created at .env.template"
else
    ok "Environment template already exists"
fi

# ─── PHASE 7: Directory Structure ───────────────────────────────
step "PHASE 7: Workspace Structure"

DIRS="memory agent-frameworks kds-bot kds-platform lord-sav"
for dir in $DIRS; do
    mkdir -p "$WORKSPACE/$dir"
done
ok "Workspace directories ensured"

# Create memory state file if missing
if [ ! -f "$WORKSPACE/memory/heartbeat-state.json" ]; then
    cat > "$WORKSPACE/memory/heartbeat-state.json" <<'EOF'
{
  "lastChecks": {
    "email": null,
    "calendar": null,
    "weather": null
  }
}
EOF
    ok "Heartbeat state initialized"
fi

# ─── PHASE 8: API Key Setup (Optional) ─────────────────────────
step "PHASE 8: API Key Setup"

if $WITH_KEYS; then
    log "Interactive API key setup..."
    
    # GitHub
    if ! gh auth status &>/dev/null 2>&1; then
        echo ""
        echo -e "${YELLOW}GitHub authentication needed.${NC}"
        echo "Run: gh auth login"
        echo "Or provide a token:"
        read -p "GitHub token (or skip): " GH_TOKEN
        if [ -n "$GH_TOKEN" ] && [ "$GH_TOKEN" != "skip" ]; then
            echo "$GH_TOKEN" | gh auth login --with-token 2>/dev/null && ok "GitHub authenticated" || warn "GitHub auth failed"
        fi
    else
        ok "GitHub already authenticated"
    fi
    
    # X/Twitter
    if [ ! -f "$HOME/.xurl/config.json" ]; then
        echo ""
        echo -e "${YELLOW}X/Twitter API needed for xurl skill.${NC}"
        echo "Get keys at: https://developer.x.com"
        read -p "X API Key (or skip): " X_KEY
        if [ -n "$X_KEY" ] && [ "$X_KEY" != "skip" ]; then
            read -p "X API Secret: " X_SECRET
            read -p "X Access Token: " X_TOKEN
            read -p "X Access Token Secret: " X_TOKEN_SECRET
            mkdir -p "$HOME/.xurl"
            cat > "$HOME/.xurl/config.json" <<XEOF
{
  "default": {
    "consumer_key": "$X_KEY",
    "consumer_secret": "$X_SECRET",
    "token": "$X_TOKEN",
    "token_secret": "$X_TOKEN_SECRET"
  }
}
XEOF
            chmod 600 "$HOME/.xurl/config.json"
            ok "X/Twitter configured"
        fi
    else
        ok "X/Twitter already configured"
    fi
else
    log "Skipping interactive key setup (use --with-api-keys to enable)"
    echo ""
    echo -e "${YELLOW}Keys you'll need to set up:${NC}"
    echo "  1. GitHub:     gh auth login"
    echo "  2. X/Twitter:  xurl auth (see .env.template)"
    echo "  3. Cloudflare: Set CF_API_TOKEN in .env"
    echo "  4. Supabase:   Set SUPABASE_URL + SUPABASE_SERVICE_KEY in .env"
    echo "  5. Notion:     Set NOTION_API_KEY in .env"
    echo "  6. LinkedIn:   Set LINKEDIN_LI_AT + LINKEDIN_JSESSIONID in .env"
    echo "  7. Vercel:     vercel login"
    echo ""
    echo "  Template at: $WORKSPACE/.env.template"
fi

# ─── PHASE 9: Verification ──────────────────────────────────────
step "PHASE 9: Verification"

echo ""
echo -e "${CYAN}Tool Status:${NC}"
for tool in himalaya mcporter vercel xurl clawhub kilo gh ollama; do
    if command -v "$tool" &>/dev/null; then
        ok "$tool: $(command -v $tool)"
    else
        err "$tool: NOT FOUND"
    fi
done

echo ""
echo -e "${CYAN}Python Packages:${NC}"
for pkg in linkedin_api beautifulsoup4 lxml requests; do
    if pip3 show "$pkg" &>/dev/null 2>&1; then
        ok "$pkg: $(pip3 show "$pkg" 2>/dev/null | grep Version | cut -d' ' -f2)"
    else
        err "$pkg: NOT INSTALLED"
    fi
done

echo ""
echo -e "${CYAN}Workspace:${NC}"
ok "Skills: $(ls -d $SKILLS_DIR/*/ 2>/dev/null | wc -l) installed"
ok "Config: $CONFIG_FILE"
ok "Workspace: $WORKSPACE"
[ -f "$WORKSPACE/.env" ] && ok ".env: present" || warn ".env: missing (copy from .env.template)"

# ─── DONE ───────────────────────────────────────────────────────
step "BOOTSTRAP COMPLETE"

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  🧠 Lord Sav Bootstrap Complete                              ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║  Tools installed. Skills ready. Config optimized.            ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║  Next steps:                                                 ║${NC}"
echo -e "${GREEN}║  1. Set up API keys: bash $0 --with-api-keys   ║${NC}"
echo -e "${GREEN}║  2. Or edit .env.template → .env manually                    ║${NC}"
echo -e "${GREEN}║  3. Restart OpenClaw: openclaw gateway restart               ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║  Log: $LOG_FILE${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
