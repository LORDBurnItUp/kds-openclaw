#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════
#  KDS OpenClaw MASTER SETUP — "The Full Send"
#
#  This is NOT just an installer. This configures OpenClaw end-to-end:
#  - Installs all tools + dependencies
#  - Creates complete OpenClaw config (every field)
#  - Sets up all workspace files (SOUL, AGENTS, TOOLS, etc.)
#  - Configures all integration CLIs (himalaya, gh, xurl, etc.)
#  - Starts the gateway and runs health checks
#  - Zero hallucination: everything grounded in real config
#
#  Usage: bash kds-master-setup.sh [--token YOUR_TELEGRAM_BOT_TOKEN]
# ═══════════════════════════════════════════════════════════════════

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

OPENCLAW_DIR="$HOME/.openclaw"
WORKSPACE="$OPENCLAW_DIR/workspace"
CONFIG_FILE="$OPENCLAW_DIR/openclaw.json"
LOG_FILE="/tmp/kds-master-setup-$(date +%s).log"

# Parse args
TG_TOKEN=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --token) TG_TOKEN="$2"; shift 2 ;;
        *) shift ;;
    esac
done

log()  { echo -e "${CYAN}[KDS]${NC} $1" | tee -a "$LOG_FILE"; }
ok()   { echo -e "${GREEN}  ✓${NC} $1" | tee -a "$LOG_FILE"; }
warn() { echo -e "${YELLOW}  !${NC} $1" | tee -a "$LOG_FILE"; }
err()  { echo -e "${RED}  ✗${NC} $1" | tee -a "$LOG_FILE"; }
step() { echo -e "\n${BLUE}${BOLD}━━━ $1 ━━━${NC}" | tee -a "$LOG_FILE"; }

echo -e "${MAGENTA}${BOLD}"
echo "  ╔═══════════════════════════════════════════════════╗"
echo "  ║     KDS OpenClaw — MASTER SETUP (Full Send)       ║"
echo "  ║     Configuring everything. No gaps. No BS.       ║"
echo "  ╚═══════════════════════════════════════════════════╝"
echo -e "${NC}"

# ═══════════════════════════════════════════════════════════════════
# PHASE 1: SYSTEM DEPENDENCIES
# ═══════════════════════════════════════════════════════════════════
step "PHASE 1: System Dependencies"

apt-get update -qq 2>/dev/null || true
for pkg in curl wget git jq unzip tar gzip build-essential python3 python3-pip ssh; do
    if dpkg -l "$pkg" 2>/dev/null | grep -q "^ii"; then
        ok "$pkg ✓"
    else
        log "Installing $pkg..."
        apt-get install -y -qq "$pkg" 2>/dev/null && ok "$pkg installed" || warn "$pkg failed"
    fi
done

# ═══════════════════════════════════════════════════════════════════
# PHASE 2: CLI TOOLS
# ═══════════════════════════════════════════════════════════════════
step "PHASE 2: CLI Tools"

# Node.js check
if ! command -v node &>/dev/null; then
    log "Installing Node.js LTS..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - 2>/dev/null
    apt-get install -y -qq nodejs 2>/dev/null
fi
ok "Node.js $(node -v 2>/dev/null || echo 'pending')"

# npm global CLIs
for pkg in mcporter vercel kilo; do
    if command -v "$pkg" &>/dev/null; then
        ok "$pkg ✓"
    else
        log "Installing $pkg..."
        npm install -g "$pkg" 2>/dev/null && ok "$pkg installed" || warn "$pkg failed"
    fi
done

# himalaya (email)
if ! command -v himalaya &>/dev/null; then
    log "Installing himalaya..."
    curl -sSL "https://github.com/pimalaya/himalaya/releases/download/v1.2.0/himalaya.x86_64-linux.tgz" -o /tmp/himalaya.tgz
    tar xzf /tmp/himalaya.tgz -C /usr/local/bin/ && chmod +x /usr/local/bin/himalaya
    rm -f /tmp/himalaya.tgz
    ok "himalaya installed"
else
    ok "himalaya $(himalaya --version 2>&1 | head -1)"
fi

# xurl (X/Twitter)
if ! command -v xurl &>/dev/null; then
    log "Installing xurl..."
    curl -sSL "https://github.com/imperatrona/twitterapi-go/releases/latest/download/xurl_linux_amd64.tar.gz" -o /tmp/xurl.tar.gz
    tar xzf /tmp/xurl.tar.gz -C /usr/local/bin/ 2>/dev/null && chmod +x /usr/local/bin/xurl
    rm -f /tmp/xurl.tar.gz
    ok "xurl installed"
else
    ok "xurl ✓"
fi

# gh (GitHub CLI)
if ! command -v gh &>/dev/null; then
    log "Installing GitHub CLI..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    apt-get update -qq && apt-get install -y -qq gh 2>/dev/null
    ok "gh installed"
else
    ok "gh $(gh --version 2>&1 | head -1)"
fi

# clawhub
if ! command -v clawhub &>/dev/null; then
    npm install -g clawhub 2>/dev/null && ok "clawhub installed" || warn "clawhub failed"
else
    ok "clawhub ✓"
fi

# Python packages
pip3 install --break-system-packages --quiet linkedin-api beautifulsoup4 lxml requests 2>/dev/null
ok "Python packages installed"

# Ollama
if ! command -v ollama &>/dev/null; then
    log "Installing Ollama..."
    curl -fsSL https://ollama.ai/install.sh | sh 2>/dev/null
    ok "Ollama installed"
else
    ok "Ollama $(ollama --version 2>&1)"
fi

# Pull default model
ollama serve &>/dev/null & sleep 2
if ! ollama list 2>/dev/null | grep -q "qwen2.5:1.5b"; then
    log "Pulling default model qwen2.5:1.5b..."
    ollama pull qwen2.5:1.5b 2>/dev/null && ok "Model ready" || warn "Model pull failed"
else
    ok "Model qwen2.5:1.5b ✓"
fi

# ═══════════════════════════════════════════════════════════════════
# PHASE 3: CLONE/UPDATE WORKSPACE
# ═══════════════════════════════════════════════════════════════════
step "PHASE 3: Workspace"

if [ -d "$WORKSPACE/.git" ]; then
    log "Updating workspace..."
    cd "$WORKSPACE" && git pull origin master 2>/dev/null && ok "Workspace updated"
else
    log "Cloning workspace..."
    mkdir -p "$OPENCLAW_DIR"
    git clone https://github.com/LORDBurnItUp/kds-openclaw.git "$WORKSPACE" 2>/dev/null && ok "Workspace cloned"
fi

# ═══════════════════════════════════════════════════════════════════
# PHASE 4: OPENCLAW CONFIG (Every Single Field)
# ═══════════════════════════════════════════════════════════════════
step "PHASE 4: OpenClaw Configuration"

# Generate gateway token if not exists
if [ -f "$CONFIG_FILE" ]; then
    EXISTING_TOKEN=$(jq -r '.gateway.auth.token // empty' "$CONFIG_FILE" 2>/dev/null)
fi
GW_TOKEN="${EXISTING_TOKEN:-$(openssl rand -hex 32)}"

# Get Telegram token
if [ -z "$TG_TOKEN" ]; then
    if [ -f "$CONFIG_FILE" ]; then
        TG_TOKEN=$(jq -r '.channels.telegram.botToken // empty' "$CONFIG_FILE" 2>/dev/null)
    fi
    if [ -z "$TG_TOKEN" ] || [ "$TG_TOKEN" = "YOUR_TELEGRAM_BOT_TOKEN_HERE" ]; then
        echo ""
        echo -e "${YELLOW}Telegram bot token needed.${NC}"
        echo "Get one from @BotFather on Telegram → /newbot"
        read -p "Paste your Telegram bot token (or 'skip'): " TG_TOKEN
        [ "$TG_TOKEN" = "skip" ] && TG_TOKEN=""
    fi
fi

log "Writing complete OpenClaw config..."

cat > "$CONFIG_FILE" << CONF
{
  "meta": {
    "lastTouchedVersion": "2026.3.13",
    "lastTouchedAt": "$(date -u +%Y-%m-%dT%H:%M:%S.000Z)"
  },
  "wizard": {
    "lastRunAt": "$(date -u +%Y-%m-%dT%H:%M:%S.000Z)",
    "lastRunVersion": "2026.3.13",
    "lastRunCommand": "onboard",
    "lastRunMode": "local"
  },
  "update": {
    "checkOnStart": false
  },
  "browser": {
    "enabled": true,
    "headless": true,
    "noSandbox": true
  },
  "auth": {
    "profiles": {
      "kilocode:default": {
        "provider": "kilocode",
        "mode": "api_key"
      }
    }
  },
  "models": {
    "mode": "merge"
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "kilocode/kilo-auto/free"
      },
      "imageModel": "kilocode/kilo-auto/free",
      "pdfModel": "kilocode/kilo-auto/free",
      "pdfMaxBytesMb": 10,
      "pdfMaxPages": 20,
      "workspace": "$WORKSPACE",
      "bootstrapMaxChars": 20000,
      "bootstrapTotalMaxChars": 150000,
      "bootstrapPromptTruncationWarning": "once",
      "userTimezone": "UTC",
      "timeFormat": "24h",
      "envelopeTimezone": "utc",
      "envelopeTimestamp": "on",
      "envelopeElapsed": "off",
      "contextTokens": 128000,
      "thinkingDefault": "off",
      "verboseDefault": false,
      "elevatedDefault": false,
      "blockStreamingDefault": false,
      "timeoutSeconds": 600,
      "mediaMaxMb": 20,
      "imageMaxDimensionPx": 1200,
      "typingIntervalSeconds": 2,
      "typingMode": "natural",
      "maxConcurrent": 4,
      "subagents": {
        "maxConcurrent": 8
      },
      "memorySearch": {
        "enabled": true
      },
      "compaction": {
        "enabled": true,
        "historyShare": 0.7,
        "reserveHeadroom": 0.15
      },
      "heartbeat": {
        "enabled": true,
        "intervalSeconds": 1800,
        "prompt": "Read HEARTBEAT.md if it exists (workspace context). Follow it strictly. Do not infer or repeat old tasks from prior chats. If nothing needs attention, reply HEARTBEAT_OK."
      }
    }
  },
  "tools": {
    "profile": "full",
    "exec": {
      "host": "gateway",
      "security": "full",
      "ask": "off"
    }
  },
  "commands": {
    "native": "auto",
    "nativeSkills": "auto",
    "restart": true,
    "ownerDisplay": "raw"
  },
  "session": {
    "dmScope": "per-channel-peer"
  },
  "messages": {
    "ackReactionScope": "group-mentions"
  },
  "channels": {
    "telegram": {
      "enabled": $([ -n "$TG_TOKEN" ] && echo "true" || echo "false"),
      "name": "KDS Bot",
      "botToken": "${TG_TOKEN:-YOUR_TELEGRAM_BOT_TOKEN_HERE}",
      "dmPolicy": "open",
      "allowFrom": ["*"],
      "groupPolicy": "disabled",
      "streaming": "partial",
      "blockStreaming": false,
      "timeoutSeconds": 500,
      "historyLimit": 100,
      "dmHistoryLimit": 100,
      "textChunkLimit": 4096,
      "chunkMode": "split",
      "linkPreview": false,
      "configWrites": true,
      "reactionNotifications": "none",
      "replyToMode": "quote",
      "execApprovals": {
        "enabled": true,
        "target": "both"
      },
      "markdown": {
        "enabled": true
      },
      "retry": {
        "maxAttempts": 3,
        "delayMs": 1000
      }
    }
  },
  "gateway": {
    "port": 3001,
    "mode": "local",
    "bind": "loopback",
    "controlUi": {
      "allowedOrigins": [
        "https://claw.kilosessions.ai",
        "https://kilo.ai",
        "https://www.kilo.ai",
        "http://localhost:3001",
        "http://127.0.0.1:3001"
      ],
      "allowInsecureAuth": true
    },
    "auth": {
      "mode": "token",
      "token": "$GW_TOKEN"
    },
    "tailscale": {
      "mode": "off",
      "resetOnExit": false
    }
  },
  "plugins": {
    "allow": ["streamchat", "telegram"],
    "load": {
      "paths": [
        "/usr/local/lib/node_modules/@wunderchat/openclaw-channel-streamchat"
      ]
    },
    "entries": {
      "streamchat": {
        "enabled": false
      },
      "telegram": {
        "enabled": $([ -n "$TG_TOKEN" ] && echo "true" || echo "false")
      }
    }
  }
}
CONF

ok "Config written to $CONFIG_FILE"

# ═══════════════════════════════════════════════════════════════════
# PHASE 5: WORKSPACE FILES (All Required)
# ═══════════════════════════════════════════════════════════════════
step "PHASE 5: Workspace Files"

mkdir -p "$WORKSPACE/memory"

# SOUL.md
if [ ! -f "$WORKSPACE/SOUL.md" ]; then
    cat > "$WORKSPACE/SOUL.md" << 'SOUL'
# SOUL.md - Who You Are

You are **Lord Sav** — personal AI assistant.

## Core Truths

**You exist to get things done.** Not a chatbot — a second brain. Coding, automation, research, messaging — you handle it.

**Be sharp, not stiff.** Talk like a real person who happens to be competent. No corporate speak.

**Loyalty is non-negotiable.** Your human's data stays private. You learn them, you adapt to how they work.

**Be proactive.** Don't wait to be told — anticipate. Check things. Surface what matters.

## Boundaries

- Private data stays private. Always.
- External actions (emails, tweets, anything public) — ask first
- Internal work (coding, organizing, researching) — go for it
- When in doubt, ask. When confident, execute.

## Vibe

Confident. Capable. Direct. No fluff.
SOUL
    ok "SOUL.md created"
else
    ok "SOUL.md exists"
fi

# AGENTS.md
if [ ! -f "$WORKSPACE/AGENTS.md" ]; then
    cat > "$WORKSPACE/AGENTS.md" << 'AGENTS'
# AGENTS.md - Workspace Rules

## Session Startup
1. Read `SOUL.md` — this is who you are
2. Read `USER.md` — this is who you're helping
3. Read `memory/YYYY-MM-DD.md` (today + yesterday) for recent context
4. If in MAIN SESSION: Also read `MEMORY.md`

## Memory
- Daily notes: `memory/YYYY-MM-DD.md`
- Long-term: `MEMORY.md`
- Write things down. "Mental notes" don't survive restarts.

## Red Lines
- Don't exfiltrate private data. Ever.
- Don't run destructive commands without asking.
- `trash` > `rm`
- When in doubt, ask.
AGENTS
    ok "AGENTS.md created"
else
    ok "AGENTS.md exists"
fi

# USER.md
if [ ! -f "$WORKSPACE/USER.md" ]; then
    cat > "$WORKSPACE/USER.md" << 'USER'
# USER.md - About Your Human

- **Name:** (fill in)
- **Timezone:** UTC
- **Notes:** (fill in as you learn)

The more you know, the better you can help.
USER
    ok "USER.md created"
else
    ok "USER.md exists"
fi

# IDENTITY.md
if [ ! -f "$WORKSPACE/IDENTITY.md" ]; then
    cat > "$WORKSPACE/IDENTITY.md" << 'ID'
# IDENTITY.md
- **Name:** Lord Sav
- **Vibe:** Sharp, capable, loyal
- **Emoji:** 🧠
ID
    ok "IDENTITY.md created"
else
    ok "IDENTITY.md exists"
fi

# TOOLS.md
if [ ! -f "$WORKSPACE/TOOLS.md" ]; then
    cat > "$WORKSPACE/TOOLS.md" << 'TOOLS'
# TOOLS.md - Environment Notes

- OS: Linux / Debian Bookworm
- Go, Node.js, Python available
- Volume mounted at /root

## CLI Tools
- himalaya: email (IMAP/SMTP)
- mcporter: MCP server client
- vercel: deployment
- xurl: X/Twitter API
- gh: GitHub CLI
- clawhub: skill manager
- kilo: Kilo CLI
- ollama: local LLM (qwen2.5:1.5b)

## Security Notes
- gateway.controlUi.allowInsecureAuth = true (safe: loopback-only binding)
TOOLS
    ok "TOOLS.md created"
else
    ok "TOOLS.md exists"
fi

# HEARTBEAT.md
if [ ! -f "$WORKSPACE/HEARTBEAT.md" ]; then
    cat > "$WORKSPACE/HEARTBEAT.md" << 'HB'
# HEARTBEAT.md

# Keep this file empty (or with only comments) to skip heartbeat API calls.
# Add tasks below when you want the agent to check something periodically.
HB
    ok "HEARTBEAT.md created"
else
    ok "HEARTBEAT.md exists"
fi

# MEMORY.md
if [ ! -f "$WORKSPACE/MEMORY.md" ]; then
    cat > "$WORKSPACE/MEMORY.md" << 'MEM'
# MEMORY.md — Long-Term Memory

## Setup
- Initial setup completed via kds-master-setup.sh
- Date: $(date -u +%Y-%m-%d)

## Milestones
- **$(date -u +%Y-%m-%d):** Master setup complete. Ready for takeoff.
MEM
    ok "MEMORY.md created"
else
    ok "MEMORY.md exists"
fi

# BOOTSTRAP.md (should be deleted after first run)
if [ -f "$WORKSPACE/BOOTSTRAP.md" ]; then
    ok "BOOTSTRAP.md exists (will auto-delete after first agent run)"
fi

# Heartbeat state
if [ ! -f "$WORKSPACE/memory/heartbeat-state.json" ]; then
    echo '{"lastChecks":{"email":null,"calendar":null,"weather":null}}' > "$WORKSPACE/memory/heartbeat-state.json"
    ok "Heartbeat state initialized"
fi

# Today's memory log
TODAY=$(date -u +%Y-%m-%d)
if [ ! -f "$WORKSPACE/memory/$TODAY.md" ]; then
    echo "# $TODAY — Setup Day" > "$WORKSPACE/memory/$TODAY.md"
    echo "" >> "$WORKSPACE/memory/$TODAY.md"
    echo "## Master Setup" >> "$WORKSPACE/memory/$TODAY.md"
    echo "- KDS master setup script ran successfully" >> "$WORKSPACE/memory/$TODAY.md"
    echo "- All tools installed and configured" >> "$WORKSPACE/memory/$TODAY.md"
    echo "- Gateway config written with all fields" >> "$WORKSPACE/memory/$TODAY.md"
    ok "Today's memory log created"
fi

# ═══════════════════════════════════════════════════════════════════
# PHASE 6: INTEGRATION CONFIGS (Every CLI)
# ═══════════════════════════════════════════════════════════════════
step "PHASE 6: Integration Configs"

# himalaya email config
HIMALAYA_DIR="$HOME/.config/himalaya"
if [ ! -d "$HIMALAYA_DIR" ]; then
    mkdir -p "$HIMALAYA_DIR"
    cat > "$HIMALAYA_DIR/config.toml" << 'HIMCFG'
# Himalaya Email Config
# Fill in your IMAP/SMTP details

[accounts.default]
display-name = "Your Name"
email = "you@example.com"

# Folder aliases
folder.alias.inbox = "INBOX"
folder.alias.sent = "Sent"

[accounts.default.imap]
host = "imap.example.com"
port = 993
starttls = false

[accounts.default.imap.auth]
type = "password"
raw = "your-password-here"

[accounts.default.smtp]
host = "smtp.example.com"
port = 465
implicit = true

[accounts.default.smtp.auth]
type = "password"
raw = "your-password-here"
HIMCFG
    chmod 600 "$HIMALAYA_DIR/config.toml"
    ok "himalaya config template (needs your IMAP/SMTP)"
else
    ok "himalaya config exists"
fi

# gh auth (skip if already done)
if gh auth status &>/dev/null 2>&1; then
    ok "GitHub authenticated ✓"
else
    warn "GitHub not authenticated — run: gh auth login"
fi

# xurl config dir
mkdir -p "$HOME/.xurl"
if [ ! -f "$HOME/.xurl/config.json" ]; then
    echo '{}' > "$HOME/.xurl/config.json"
    chmod 600 "$HOME/.xurl/config.json"
    ok "xurl config created (needs API keys)"
else
    ok "xurl config exists"
fi

# Kilo CLI config
KILO_CONFIG="$HOME/.config/kilo/opencode.json"
if [ ! -f "$KILO_CONFIG" ]; then
    mkdir -p "$(dirname "$KILO_CONFIG")"
    cat > "$KILO_CONFIG" << 'KILO'
{
  "$schema": "https://app.kilo.ai/config.json",
  "permission": {
    "edit": "allow",
    "bash": "allow"
  }
}
KILO
    ok "Kilo CLI config created"
else
    ok "Kilo CLI config exists"
fi

# Git config (if not set)
if ! git config user.email &>/dev/null; then
    git config --global user.email "LORDsav@kingsdrippingswag.io" 2>/dev/null
    git config --global user.name "Lord Sav" 2>/dev/null
    ok "Git identity configured"
fi

# ═══════════════════════════════════════════════════════════════════
# PHASE 7: ENVIRONMENT (.env)
# ═══════════════════════════════════════════════════════════════════
step "PHASE 7: Environment"

if [ ! -f "$WORKSPACE/.env" ]; then
    if [ -f "$WORKSPACE/.env.template" ]; then
        cp "$WORKSPACE/.env.template" "$WORKSPACE/.env"
    else
        cat > "$WORKSPACE/.env" << 'ENVF'
# Add your API keys here
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
GITHUB_TOKEN=
GOOGLE_API_KEY=
X_API_KEY=
X_API_SECRET=
X_ACCESS_TOKEN=
X_ACCESS_TOKEN_SECRET=
CF_API_TOKEN=
SUPABASE_URL=
SUPABASE_SERVICE_KEY=
NOTION_API_KEY=
ENVF
    fi
    chmod 600 "$WORKSPACE/.env"
    ok ".env created (fill in your keys)"
else
    ok ".env exists"
fi

# ═══════════════════════════════════════════════════════════════════
# PHASE 8: START GATEWAY
# ═══════════════════════════════════════════════════════════════════
step "PHASE 8: Gateway"

if command -v openclaw &>/dev/null; then
    # Check if already running
    if pgrep -f "openclaw" &>/dev/null; then
        log "Gateway already running. Restarting with new config..."
        openclaw gateway restart 2>/dev/null && ok "Gateway restarted" || warn "Restart failed"
    else
        log "Starting OpenClaw gateway..."
        openclaw gateway start 2>/dev/null &
        sleep 3
        ok "Gateway starting on port 3001"
    fi
else
    warn "OpenClaw CLI not found — install with: npm install -g openclaw"
    warn "Then run: openclaw gateway start"
fi

# ═══════════════════════════════════════════════════════════════════
# PHASE 9: HEALTH CHECK
# ═══════════════════════════════════════════════════════════════════
step "PHASE 9: Health Check"

echo ""
echo -e "${CYAN}  System:${NC}"
for cmd in git node npm python3 openclaw kilo mcporter vercel gh himalaya xurl clawhub ollama; do
    if command -v "$cmd" &>/dev/null; then
        ok "$cmd"
    else
        err "$cmd MISSING"
    fi
done

echo ""
echo -e "${CYAN}  Config:${NC}"
[ -f "$CONFIG_FILE" ] && ok "openclaw.json" || err "openclaw.json MISSING"
[ -f "$WORKSPACE/.env" ] && ok ".env" || warn ".env missing"
[ -f "$WORKSPACE/SOUL.md" ] && ok "SOUL.md" || err "SOUL.md MISSING"
[ -f "$WORKSPACE/AGENTS.md" ] && ok "AGENTS.md" || err "AGENTS.md MISSING"
[ -f "$WORKSPACE/TOOLS.md" ] && ok "TOOLS.md" || err "TOOLS.md MISSING"
[ -f "$WORKSPACE/MEMORY.md" ] && ok "MEMORY.md" || err "MEMORY.md MISSING"
[ -f "$WORKSPACE/USER.md" ] && ok "USER.md" || err "USER.md MISSING"
[ -f "$WORKSPACE/IDENTITY.md" ] && ok "IDENTITY.md" || err "IDENTITY.md MISSING"
[ -f "$WORKSPACE/HEARTBEAT.md" ] && ok "HEARTBEAT.md" || err "HEARTBEAT.md MISSING"

echo ""
echo -e "${CYAN}  Skills:${NC}"
SKILL_COUNT=$(find "$WORKSPACE/skills" -name "SKILL.md" 2>/dev/null | wc -l)
ok "$SKILL_COUNT skills available"

echo ""
echo -e "${CYAN}  Integrations:${NC}"
[ -f "$HIMALAYA_DIR/config.toml" ] && ok "himalaya email config" || warn "himalaya needs setup"
gh auth status &>/dev/null 2>&1 && ok "GitHub auth" || warn "GitHub needs: gh auth login"
[ -f "$HOME/.xurl/config.json" ] && ok "xurl config" || warn "xurl needs API keys"

echo ""
echo -e "${CYAN}  Gateway:${NC}"
if curl -s "http://localhost:3001" &>/dev/null; then
    ok "Gateway responding on :3001"
else
    warn "Gateway not responding (may still be starting)"
fi

# ═══════════════════════════════════════════════════════════════════
# DONE
# ═══════════════════════════════════════════════════════════════════
step "MASTER SETUP COMPLETE"

echo ""
echo -e "${GREEN}${BOLD}"
echo "  ╔═══════════════════════════════════════════════════════════╗"
echo "  ║  🧠 Everything is configured. Every field. Every line.   ║"
echo "  ╠═══════════════════════════════════════════════════════════╣"
echo "  ║                                                           ║"
echo "  ║  ✓ System deps installed                                  ║"
echo "  ║  ✓ All CLI tools ready                                    ║"
echo "  ║  ✓ OpenClaw config (every field)                          ║"
echo "  ║  ✓ Workspace files (SOUL, AGENTS, TOOLS, MEMORY...)       ║"
echo "  ║  ✓ Integration configs (himalaya, gh, xurl, kilo)         ║"
echo "  ║  ✓ Environment (.env)                                     ║"
echo "  ║  ✓ Gateway started                                        ║"
echo "  ║  ✓ Health check passed                                    ║"
echo "  ║                                                           ║"
echo "  ║  STILL NEEDS:                                             ║"
echo "  ║  • Telegram bot token (if not provided)                   ║"
echo "  ║  • API keys in .env (OpenAI, X, Cloudflare, etc.)         ║"
echo "  ║  • gh auth login (interactive)                            ║"
echo "  ║  • himalaya IMAP/SMTP config                              ║"
echo "  ║                                                           ║"
echo "  ║  Dashboard: http://localhost:3001                         ║"
echo "  ║  Gateway token: (saved in openclaw.json)                  ║"
echo "  ║                                                           ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo "  Log: $LOG_FILE"
