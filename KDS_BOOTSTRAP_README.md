# 🧠 KDS OpenClaw Bootstrap

**One script to rule them all.** Drop it on any fresh OpenClaw instance, run it, and everything installs + configures automatically.

## ⚡ Recommended: Master Setup (Full Send)

**This is the one.** Installs everything, configures every field, starts the gateway, runs health checks. Zero manual steps (except API keys).

```bash
# Linux — full end-to-end setup
curl -sSL https://raw.githubusercontent.com/LORDBurnItUp/kds-openclaw/main/kds-master-setup.sh | bash

# With Telegram bot token
curl -sSL https://raw.githubusercontent.com/LORDBurnItUp/kds-openclaw/main/kds-master-setup.sh | bash -s -- --token YOUR_BOT_TOKEN
```

### What `kds-master-setup.sh` does:
- Installs all system deps (git, node, python, build tools)
- Installs all CLI tools (mcporter, vercel, himalaya, xurl, gh, kilo, ollama)
- Clones this repo as the workspace
- **Writes complete OpenClaw config** — every single field: model, channels, streaming, exec, heartbeat, memory search, compaction, plugins, gateway auth, browser, etc.
- **Creates all workspace files** — SOUL.md, AGENTS.md, USER.md, TOOLS.md, IDENTITY.md, HEARTBEAT.md, MEMORY.md, memory logs
- **Configures all integrations** — himalaya email config, GitHub auth prompt, xurl config dir, Kilo CLI config, git identity
- **Creates .env** from template
- **Starts the gateway** on port 3001
- **Runs health check** — verifies every tool, every file, every integration
- Pulls Ollama model (qwen2.5:1.5b) for local AI fallback

## Quick Start

### 🪟 Windows 10/11 (Beginner-Friendly)

**One command — open Terminal or PowerShell and paste:**
```powershell
irm https://raw.githubusercontent.com/LORDBurnItUp/kds-openclaw/main/kds-bootstrap-windows.ps1 | iex
```

**Or download and double-click:** `kds-install.bat`

This installs everything automatically: Git, Node.js, Python, OpenClaw, all skills, and Ollama for local AI. No cloud needed.

### 🐧 Linux / macOS
```bash
curl -sSL https://raw.githubusercontent.com/LORDBurnItUp/kds-openclaw/main/kds-bootstrap.sh | bash

# With interactive API key setup
curl -sSL https://raw.githubusercontent.com/LORDBurnItUp/kds-openclaw/main/kds-bootstrap.sh | bash -s -- --with-api-keys
```

## What It Installs

### CLI Tools
| Tool | Purpose | Skill |
|------|---------|-------|
| himalaya | Email (IMAP/SMTP) | himalaya |
| mcporter | MCP server client | mcporter |
| vercel | Deploy & manage apps | vercel |
| xurl | X/Twitter API | xurl |
| clawhub | Skill manager | clawhub |
| ollama | Local LLM runtime | — |
| kilo | Kilo CLI | — |
| linkedin-api | Python LinkedIn API | linkedin-cli |

### Ollama Models
- `qwen2.5:1.5b` — Fast, lightweight, runs on anything

### Configurations
- OpenClaw optimized config (plugin allowlist, browser, exec)
- Environment template (.env.template)
- Workspace directory structure
- Heartbeat state

## What You Still Need To Do

After running the bootstrap, set up your API keys:

```bash
# GitHub
gh auth login

# X/Twitter (get keys at developer.x.com)
xurl auth

# Or edit .env.template → .env with all keys
```

### Keys needed per skill:
| Skill | Keys Required |
|-------|--------------|
| github | `gh auth login` |
| xurl | X API Key/Secret + Access Token/Secret |
| cloudflare-dns | CF_API_TOKEN, CF_ZONE_ID |
| supabase | SUPABASE_URL, SUPABASE_SERVICE_KEY |
| notion | NOTION_API_KEY |
| linkedin-cli | LINKEDIN_LI_AT, LINKEDIN_JSESSIONID |
| facebook | FB_ACCESS_TOKEN, FB_PAGE_ID |
| gog | OAuth (brew only) |
| vercel | `vercel login` |
| himalaya | IMAP/SMTP config in ~/.config/himalaya/ |

## Config Template

`kds-config-template.json` — Drop this at `~/.openclaw/openclaw.json` on a fresh instance with your tokens filled in.

## Files
```
kds-bootstrap.sh          # Main bootstrap script
kds-config-template.json  # OpenClaw config template
.env.template             # Environment variables template
KDS_BOOTSTRAP_README.md   # This file
```

## Philosophy
- **Open-source first.** Ollama over cloud APIs.
- **No vendor lock-in.** If it can't run offline, it doesn't ship.
- **One command.** Run it, done.
