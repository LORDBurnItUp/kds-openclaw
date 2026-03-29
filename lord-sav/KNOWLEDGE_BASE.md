# Omar's Knowledge Base

_Curated long-term facts, preferences, and context._

---

## User Preferences

- Building open-source alternatives to commercial tools
- Voice-first development workflow (like Whispr Flow but free)
- Wants AI to be self-improving and aware of its limitations

## Key Facts

- **OpenClaw** = The brain/framework — an AI automated employee, personal assistant, code builder/deployer
- **VoxCode** = Open-source voice-to-code assistant (component of OpenClaw)
- **GOTCHA Framework** = 6-layer architecture: Goals, Orchestration, Tools, Context, Hardprompts, Args
- The project combines GOTCHA framework knowledge with Claude Code's intelligence
- Python 3.14 is installed at `C:\Users\user\AppData\Local\Python\pythoncore-3.14-64`
- Whisper base.en model is downloaded and ready

## Learned Behaviors

- Always check `tools/manifest.md` before creating new scripts
- Follow GOTCHA framework: Goals, Orchestration, Tools, Context, Hardprompts, Args
- Compare OpenClaw capabilities vs Claude Code capabilities continuously
- Identify and document flaws/weaknesses for improvement
- Use the correct Python path for packages (`pythoncore-3.14-64`)

## Current Projects

- **OpenClaw VIP Secured Version** — Main project
  - VoxCode voice assistant (built, needs installation)
  - Memory system (built, functional)
  - GOTCHA framework structure (scaffolded)

## Technical Context

- **Framework:** GOTCHA (6-layer agentic architecture)
- **VoxCode dependencies:** openai-whisper, sounddevice, pynput, pydantic, typer, httpx
- **AI providers supported:** Ollama (local), OpenAI, Anthropic
- **IDE integrations:** VS Code, JetBrains, Neovim, System-wide

## OpenClaw Gaps & Flaws (vs Claude Code)

### Current Gaps Identified:
1. Empty GOTCHA layers: `args/`, `context/`, `hardprompts/` directories are empty
2. No tools manifest: `tools/manifest.md` doesn't exist yet
3. No CLI entry point: VoxCode has `pyproject.toml` but no `cli.py` module
4. No semantic search embeddings: `embed_memory.py` exists but embeddings not generated
5. Limited self-awareness: No mechanism to learn from mistakes
6. No real-time context: Can't access live IDE state without VS Code extension
7. No agentic loop: Tools are scripts, not integrated agent workflows

### What Claude Code Does Better:
- Automatic tool selection based on context
- Multi-step reasoning and planning (TodoWrite)
- Real-time file system awareness
- Code editing with precise line targeting
- Web search and fetch capabilities
- Background task management

### Enhancement Priorities:
1. Create `tools/manifest.md`
2. Build VoxCode CLI entry point
3. Populate GOTCHA layers with real content
4. Add agentic orchestration layer
5. Integrate memory with decision-making

---

_Added: 2026-03-28_
