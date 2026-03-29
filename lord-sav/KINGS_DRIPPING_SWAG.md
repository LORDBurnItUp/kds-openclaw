# Kings Dripping Swag — AI Platform Vision

_3D Sci-Fi Community Dashboard + AI Video Platform_

---

## 🌌 The Vision

A **3D, interactive, sci-fi community dashboard** powered by LiveKit Agents. Not just a website — a futuristic environment with floating UI elements, real-time AI agents, and immersive spatial design.

**Welcome sequence:**
```
> SYSTEM BOOT INITIATED...
> ESTABLISHING SECURE CONNECTION...
> UPLINK SECURED. 
> SYNCING NEURAL PATHWAYS... [ERR_GLITCH_DETECTED]
> REROUTING TO 2050 AESTHETIC PROTOCOLS...
> W E L C O M E  T O  T H E  F U T U R E .
```

---

## 🎯 Core Features

### 1. Interactive 3D Dashboard
- Dynamic, moving spatial interface
- Next.js 14 + custom CSS/WebGL elements
- Floating UI components that move around
- Immersive sci-fi aesthetic

### 2. Live AI Navigational Agents
- Real-time voice-to-voice AI avatars
- Video-enabled agent guides
- Help users navigate the platform
- Facilitate onboarding

### 3. Community Core (like X/Twitter)
- User authentication
- Groups
- Forums (deep-learning logs)
- Direct messaging
- Live agents that help you get around

### 4. Portfolio / Hire Page
- Showcase completed AI jobs
- "Hire automation for your business" portal
- Dynamic project displays

### 5. Persistent Memory
- AI remembers users across sessions
- SQLite-backed memory manager
- Conversation history persists

---

## 🏗️ Tech Stack

### Frontend (Visual Experience)
| Tech | Purpose |
|------|---------|
| Next.js 14 (App Router) | Framework |
| Tailwind CSS | Styling + 3D/glitch animations |
| LiveKit React Components | Real-time video |
| WebGL/CSS | 3D spatial elements |

### Backend (The Brains)
| Tech | Purpose |
|------|---------|
| Python (FastAPI) | API server |
| LiveKit Agents Framework | Real-time AI agents |
| LlamaIndex | RAG engine |
| Qdrant | Vector database |
| OpenAI / Anthropic / Gemini | LLM providers |
| Deepgram | Speech-to-text |
| ElevenLabs | Text-to-speech |
| SQLite | Persistent memory |

---

## 📁 Repository Structure

```
kings-dripping-swag-ai/
├── frontend/              # Next.js 14, LiveKit UI, Tailwind, 3D assets
├── backend/
│   ├── agent.py           # Core LiveKit agent logic
│   ├── api_server.py      # FastAPI routes
│   ├── rag_engine.py      # Vector DB + semantic search
│   ├── memory_manager.py  # Conversation history
│   ├── tools.py           # LLM function calling
│   ├── config.py          # Configuration management
│   └── video_handler.py   # Video streaming + avatars
├── k8s/                   # Kubernetes manifests
├── docker-compose.yml     # Full stack orchestration
├── README.md              # Overview + quick start
├── SETUP_GUIDE.md         # 620-line setup guide
├── .env.example           # All environment variables
└── .gitignore             # Ignore patterns
```

---

## 🚀 Deployment Plan

### Hostinger VPS (Recommended)
- Standard shared Node.js hosting won't work for full stack
- Need VPS for: Python backend, Docker, Qdrant, LiveKit
- Use Hostinger VPS (46.202.197.97) with Docker Compose

### Quick Start
```bash
git clone https://github.com/your-org/kings-dripping-swag-ai.git
cd kings-dripping-swag-ai
cp .env.example .env
docker-compose up -d --build
```

### Services
| Service | Port |
|---------|------|
| Next.js Frontend | 3000 |
| FastAPI Backend | 8000 |
| LiveKit | 7880 |
| Qdrant | 6333 |

---

## 🎨 Design Direction

- **3D sci-fi** — floating elements, spatial depth
- **Glitch intro** — "teleports you to the future" animation
- **Moving elements** — dashboard feels alive
- **Dark theme** — neon accents, futuristic feel
- **Smooth transitions** — everything flows like liquid

---

## 🔗 Related Projects

- **Lord Sav** — Telegram bot (Agent Smith 2.0 clone + more)
- **VoxCode** — Voice-to-code assistant
- **OpenClaw** — AI automated employee
- **Super Monster Zero** — Agent-zero fusion

---

_Added: 2026-03-28_
_Vision by: Omar (LORDBurnItDown)_
