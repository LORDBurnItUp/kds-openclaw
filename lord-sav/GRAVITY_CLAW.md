# Gravity Claw — Personal AI Agent

_OpenClaw-inspired, built from scratch, security-first_

---

## What It Is
A lean, secure, fully-understood personal AI agent. Not a fork — built from scratch.

## Source of Inspiration
- **OpenClaw** (github.com/steipete/openclaw)
- Strengths: multi-LLM, persistent memory, voice, 700+ skills, proactive heartbeats
- Weaknesses: exposed web server (42K+ public instances), malicious community skills (341 found), $500-5K/mo API costs

---

## Architecture Principles

| Principle | Detail |
|-----------|--------|
| TypeScript | ES modules, modular folder structure |
| Telegram-only | No web server, no exposed ports, no HTTP endpoints |
| Security by default | User ID whitelist, .env secrets only, no hardcoded keys |
| Agentic loop | LLM calls tools → gets results → calls more tools (max iterations) |
| MCP for integrations | Standardized, auditable, separate process |
| Local-first | Data never leaves unless explicitly connected |

---

## Core Tech Stack

| Package | Purpose |
|---------|---------|
| grammy | Telegram bot framework |
| @anthropic-ai/sdk | Claude (primary LLM) |
| better-sqlite3 + FTS5 | Persistent memory |
| openai SDK | Whisper transcription |
| ElevenLabs API | Text-to-speech |
| tsx | Dev runner, TypeScript strict |

---

## Security Requirements (Non-Negotiable)

1. **User ID whitelist** — Only respond to owner's Telegram ID. Silently ignore others.
2. **No web server** — Telegram long-polling only. Never expose a port.
3. **Secrets in .env only** — Never in code, memory files, or logs.
4. **Tool safety** — Dangerous shell commands require confirmation. Max iteration limit.
5. **No third-party skill files** — MCP only (standardized, auditable, separate process).

---

## Build Levels

| Level | What | Status |
|-------|------|--------|
| 1 — Foundation | Telegram bot + LLM + basic agent loop | ⏳ |
| 2 — Memory | Persistent memory (SQLite + FTS5 + memory tools) | ⏳ |
| 3 — Voice | Voice messages (Whisper in, ElevenLabs out) | ⏳ |
| 4 — Tools | Tools + MCP bridge (shell, files, external services) | ⏳ |
| 5 — Heartbeat | Proactive morning briefing, scheduled check-ins | ⏳ |

---

## Three-Tier Memory System

### Tier 1: SQLite Conversation Memory
- **Type:** Local, instant, always available
- **DB:** gravity-claw.db
- **Tables:**
  - `core_memory` — Durable facts (name, preferences, timezone, goals)
  - `messages` — Full conversation history (last 20 loaded as context)
  - `summaries` — Rolling summaries when messages exceed 30
- **Auto fact extraction:** Background LLM pass after every exchange
- **Auto compaction:** When messages > 30, older ones summarized and pruned

### Tier 2: Pinecone Semantic Memory
- **Type:** Cloud, meaning-based search, long-term recall
- **Namespaces:**
  - `conversations` — Every exchange embedded and searchable
  - `knowledge` — Ingested content (YouTube, web, text), 150-char overlap
- **Model:** multilingual-e5-large (auto-embedded by Pinecone)
- **Threshold:** 0.3 minimum similarity
- **Pattern:** Fire-and-forget, never blocks user
- **Top K:** 3 most relevant matches

### Tier 3: Supabase Data Store
- **Type:** Cloud, structured data, analytics
- **Tables:**
  - `data_store` — Arbitrary key-value storage
  - `youtube_videos` — Synced video metadata
  - `youtube_comments` — Top comments per video
  - `youtube_comment_insights` — AI-analyzed sentiment
  - `activity_log` — Every bot action logged
  - `cost_log` — LLM API cost tracking

### Agent Memory Tools
| Tool | Tier | What It Does |
|------|------|-------------|
| `remember_fact` | Tier 1 | Store fact to core memory |
| `recall_memory` | Tier 1+2 | Search semantic + display core facts |
| `add_to_memory` | Tier 2 | Ingest transcripts/URLs/text |
| `save_data` | Tier 3 | Save structured data |
| `query_data` | Tier 3 | Query data store |

### Design Principles
- **Graceful degradation** — Each tier independent. No single failure takes everything down.
- **Non-blocking writes** — All post-response ops are fire-and-forget.
- **Auto compaction** — Messages > 30 → summarized → pruned.
- **Redundancy** — Tier 1 (exact) + Tier 2 (semantic) overlap intentionally.

---

## Railway Deployment

### Quick Reference
```bash
railway down                    # Pause live bot
npm run dev                     # Local dev (hot-reload)
npx tsc --noEmit                # Type-check
railway variables set KEY="val" # Set env var
railway up --detach             # Deploy
railway logs --lines 40         # Verify
railway open                    # Dashboard
```

### Dev Cycle
1. Pause Railway (`railway down`)
2. Test locally (`npm run dev`)
3. Type-check (`npx tsc --noEmit`)
4. Deploy (`railway up --detach`)
5. Verify (`railway logs`)

### Important
- SQLite resets on every deploy (ephemeral filesystem)
- Pinecone memory persists across deploys
- Files deployed: src/, tsconfig.json, soul.md, mcp.json, package*.json
- Files NOT deployed: .env, node_modules/, gravity-claw.db

---

## Relationship to Lord Sav

Gravity Claw is Omar's **TypeScript/Telegram** agent project.
Lord Sav is Omar's **OpenClaw** AI assistant (me).

We share the same vision:
- Multi-tier memory
- Agentic tool loops
- Voice capabilities
- Proactive automation
- Security-first design

Different implementations, same soul. 🧠🦞

---

_Added: 2026-03-28_
