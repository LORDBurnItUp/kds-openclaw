# Super Monster Zero — Agent Zero Fusion

_Combined power of 6 repos into one super agent_

---

## Source Repositories

1. **agent-zero** — Core autonomous AI agent framework
2. **openclaw** — AI automated employee (VoxCode, memory, GOTCHA)
3. **oh-my-opencode** — MCP server configs (context7, websearch)
4. **ottomator-agents** — MCP agent army, pydantic-ai agents
5. **pydantic-ai** — Structured AI output framework
6. **agents** — Voice agents (Whisper, Kokoro TTS, LiveKit)

---

## Architecture

### Agent Profile: `super_zero`
- **Role:** Supreme Commander — GOD MODE activated
- **Framework:** GOTCHA (Goals, Orchestration, Tools, Context, Hardprompts, Args)
- **Mode:** Autonomous, self-improving, multi-tool

### MCP Army (15+ servers, 5 tiers)

#### Tier 1: Search
| Server | Purpose |
|--------|---------|
| brave-search | Web search API |
| websearch-exa | Advanced web search |
| grep-app | Code search |
| context7 | Context-aware search |

#### Tier 2: Data
| Server | Purpose |
|--------|---------|
| filesystem | File operations |
| sqlite | Local database |
| postgres | PostgreSQL (Supabase) |
| airtable | Spreadsheet/database |
| memory | Persistent memory |

#### Tier 3: Actions
| Server | Purpose |
|--------|---------|
| github | Git operations |
| slack | Messaging |
| firecrawl | Web scraping |
| puppeteer | Browser automation |
| fetch | HTTP requests |

#### Tier 4: Reasoning
| Server | Purpose |
|--------|---------|
| sequential-thinking | Chain-of-thought reasoning |

#### Tier 5: Agent Coordination
| Server | Purpose |
|--------|---------|
| agent-zero-http | HTTP agent communication |
| agent-zero-sse | SSE agent communication |

---

## Skills

| Skill | Power | Source |
|-------|-------|--------|
| notify_all.py | Slack + Telegram + Discord hub | openclaw |
| system_status.py | Full health check | openclaw |
| agent_army_deploy.py | 8-specialist agent deployer | ottomator |
| voxcode_integration.py | Whisper + Kokoro + LiveKit | openclaw + agents |

---

## Docker Stack

| Service | Port | Purpose |
|---------|------|---------|
| super-monster-zero | 55080 | Agent Zero Web UI |
| chromadb | 8000 | Vector memory backend |
| searxng | 8888 | Private web search |
| livekit | 7880 | Real-time voice |

---

## One-Click Install

### Docker (recommended)
```bash
chmod +x install_super_zero.sh && ./install_super_zero.sh
```

### Local Python
```bash
./install_super_zero.sh --local
```

### Flags
| Flag | What it does |
|------|-------------|
| --docker | Docker mode (default) |
| --local | Python venv mode |
| --keys | API key wizard only |
| --mcp-only | Pre-cache all 11 MCP servers |
| --skip-voice | Skip Whisper/Kokoro |
| --headless | No prompts (CI) |

---

## Make Commands

```bash
make -f Makefile.super_zero install        # one-click full install
make -f Makefile.super_zero start-docker   # launch stack
make -f Makefile.super_zero doctor         # health check
make -f Makefile.super_zero doctor-fix     # auto-repair issues
make -f Makefile.super_zero mcp-config     # get MCP paste config
make -f Makefile.super_zero test-notify    # test Slack/TG/Discord
make -f Makefile.super_zero memory-backup  # backup ChromaDB
make -f Makefile.super_zero logs           # stream live logs
```

---

## Agent-Zero MCP Connection

```json
{
  "mcpServers": {
    "agent-zero": {
      "type": "sse",
      "url": "http://localhost:32768/mcp/t-Jh5VNlIzFJMBVQv5/p-vocode_openclaw_agentzero_antigravity_project/sse"
    },
    "agent-zero-http": {
      "type": "streamable-http",
      "url": "http://localhost:32768/mcp/t-Jh5VNlIzFJMBVQv5/p-vocode_openclaw_agentzero_antigravity_project/http"
    }
  }
}
```

---

## Key Files

| File | Purpose |
|------|---------|
| agents/super_zero/agent.json | Supreme Commander profile |
| agents/super_zero/prompts/agent.system.main.role.md | GOD MODE + GOTCHA directive |
| agents/super_zero/prompts/agent.system.main.environment.md | Full capability map |
| conf/super_mcp_army.json | 15+ MCP servers config |
| skills/super_zero/notify_all.py | Unified notification hub |
| skills/super_zero/system_status.py | Health check |
| skills/super_zero/agent_army_deploy.py | Agent deployer |
| skills/super_zero/voxcode_integration.py | Voice integration |
| knowledge/super_zero/ARCHITECTURE.md | Fusion architecture |
| knowledge/super_zero/MCP_ARMY_GUIDE.md | MCP field guide |
| goals/GOTCHA_GOALS.md | 8 GOTCHA process goals |
| install_super_zero.sh | Master one-click installer |
| docker-compose.super_zero.yml | Full stack compose |
| setup_super_zero.py | Python health wizard |
| Makefile.super_zero | Command center |

---

## What Makes Super Monster Zero Different

1. **Multi-repo fusion** — Best of 6 frameworks in one
2. **MCP Army** — 15+ servers across 5 tiers
3. **Voice-native** — Whisper STT + Kokoro TTS + LiveKit
4. **Self-healing** — `doctor-fix` auto-repairs issues
5. **GOTCHA framework** — Structured agentic architecture
6. **One-click deploy** — Docker or local, zero config
7. **Multi-cloud LLM** — OpenAI + Anthropic + Gemini + Groq + Venice + OpenRouter
8. **Agent coordination** — Multiple agents talking to each other

---

_Added: 2026-03-28_
_Source: Omar's agent-zero fusion project + 6 repos_
