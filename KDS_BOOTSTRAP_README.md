# 🧠 KDS OpenClaw Bootstrap

**One script to rule them all.** Drop it on any fresh OpenClaw instance, run it, and everything installs + configures automatically.

## Quick Start

### Option 1: Copy-paste one-liner
```bash
# Download and run
curl -sSL https://raw.githubusercontent.com/kingsdrippingswag/kds-openclaw/main/kds-bootstrap.sh | bash

# Or with interactive API key setup
curl -sSL https://raw.githubusercontent.com/kingsdrippingswag/kds-openclaw/main/kds-bootstrap.sh | bash -s -- --with-api-keys
```

### Option 2: Manual copy
1. Copy `kds-bootstrap.sh` to your server
2. `bash kds-bootstrap.sh` (or `bash kds-bootstrap.sh --with-api-keys`)

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
