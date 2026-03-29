# Agent Framework Collection

_Received from Omar — 2026-03-29 03:45 UTC_

---

## 1. OmniMemory — The Living Brain

**Type:** Memory system for autonomous agents
**Language:** Python 3.10+
**Repo:** omnirexflora-labs/omnimemory

### Key Features
- **Dual-Agent Synthesis** — Episodic + Summarizer agents process memories
- **Self-Evolving** — Update/Delete/Skip operations when memories conflict
- **Composite Scoring** — Relevance × [1 + Recency + Importance]
- **Structured Memory Notes** — Behavior, Learnings, Guidance
- **Docker ready** — Dockerfile + docker-compose.local.yml

### vs Traditional RAG
| Feature | Traditional RAG | OmniMemory |
|---------|----------------|------------|
| Input | Naive chunking | Dual-Agent Synthesis |
| Conflicts | None (coexist) | Self-Evolving resolution |
| Retrieval | Cosine similarity | Composite scoring |
| Context | Static chunks | Structured memory notes |

### Use for Lord Sav
- Replace basic memory with self-evolving cognitive substrate
- Automatic conflict resolution
- Importance-weighted recall

---

## 2. OmniCoreAgent — Production Agent Framework

**Type:** AI Agent Framework for production
**Language:** Python 3.10+
**Features:**
- Runtime memory backend switching
- Automatic context management
- Tool output guardrails
- Tool response offloading
- Community tools support

### Use for Lord Sav
- Production-ready agent architecture
- Runtime flexibility for memory backends
- Tool safety guardrails

---

## 3. Swarm — Multi-Agent Orchestration

**Type:** OpenAI's experimental multi-agent framework
**Note:** Now replaced by OpenAI Agents SDK
**Language:** Python 3.10+

### Core Concepts
- Agents hand off to other agents
- Lightweight, educational
- Function-calling based handoffs

### Use for Lord Sav
- Multi-agent coordination patterns
- Agent handoff architecture
- Reference for swarm-style deployments

---

## 4. Workflow Orchestrator (Agent Role)

**Role:** Design explicit stage workflows for complex tasks
**Model:** gpt-5.4 (high reasoning)

### Responsibilities
- Map objectives into stages (discovery, implementation, validation, integration)
- Define local vs delegated execution per stage
- Wait points, continuation rules, merge conditions
- Rollback/retry handling

### Key Patterns
- Critical-path identification
- Stage-level parallelization
- Delegation criteria by coupling/urgency/complexity
- Output contracts for cross-stage integration
- Validation checkpoints before advancing

---

## 5. Task Distributor (Agent Role)

**Role:** Decompose broad tasks into parallel-ready sub-tasks
**Model:** gpt-5.4 (high reasoning)

### Responsibilities
- Decomposition by deliverable and dependency
- Ownership clarity (code, docs, validation, integration)
- Minimal coupling between parallel work units
- Sequencing foundational tasks first

### Key Patterns
- One owner per task, one completion condition
- Dependency graph with blocking edges and parallel branches
- Assignee type matches complexity and permissions
- Handoff contracts between adjacent units

---

## 6. Performance Monitor (Agent Role)

**Role:** Early-warning performance signal interpretation
**Model:** gpt-5.3-codex-spark (medium reasoning)

### Responsibilities
- Metric movement analysis by timeframe/subsystem
- Signal vs noise separation
- Root-cause area identification with confidence ranking
- Alert fatigue reduction through triage

### Key Patterns
- Baseline variance comparison
- Correlation with releases/config changes
- Dominant resource signal classification
- Confidence scoring for owner subsystem

---

## 7. Multi-Agent Coordinator (Agent Role)

**Role:** Design multi-agent execution plans
**Model:** gpt-5.4 (high reasoning)

### Responsibilities
- Critical-path vs parallel sidecar mapping
- Role assignment with disjoint write scopes
- Dependency and wait points with integration contracts
- Result reconciliation and conflict resolution

### Key Patterns
- Local-first handling of blockers before delegation
- Role fit between task complexity and agent capability
- At most one owner per write-critical scope
- Contingency branches for uncertain delegate results

---

## 8. Knowledge Synthesizer (Agent Role)

**Role:** Distill multi-agent findings into non-redundant synthesis
**Model:** gpt-5.3-codex-spark (medium reasoning)

### Responsibilities
- Normalize inputs into comparable claims
- Deduplicate while preserving nuance
- Separate confirmed facts from inference
- Decision-oriented synthesis with gaps surfaced

### Key Patterns
- Claim deduplication without losing nuance
- Confidence alignment when sources disagree
- Thematic grouping by decision boundaries
- Traceability to source outputs
- Prioritization by impact and actionability

---

## Integration with Lord Sav

### All 18 Agent Roles Collected

**Meta & Orchestration:**
| Role | Use Case | Model |
|------|----------|-------|
| Workflow Orchestrator | Stage-based task design | gpt-5.4 |
| Task Distributor | Parallel task decomposition | gpt-5.4 |
| Multi-Agent Coordinator | Multi-agent execution plans | gpt-5.4 |
| Agent Organizer | Pick right subagents, divide work | gpt-5.4 |
| Agent Installer | Install agent files into directories | gpt-5.3 |
| Context Manager | Compact project context packet | gpt-5.3 |
| Knowledge Synthesizer | Merge multi-agent findings | gpt-5.3 |

**Operations & Debugging:**
| Role | Use Case | Model |
|------|----------|-------|
| IT Ops Orchestrator | Cross-domain IT workflows | gpt-5.4 |
| Error Coordinator | Group and prioritize errors | gpt-5.4 |
| Performance Monitor | Metrics signal interpretation | gpt-5.3 |

**Content & Product:**
| Role | Use Case | Model |
|------|----------|-------|
| Technical Writer | Release notes, migration docs | gpt-5.3 |
| UX Researcher | UI feedback → product guidance | gpt-5.4 |
| Scrum Master | Process facilitation, sprint planning | gpt-5.3 |
| WordPress Master | WP themes, plugins, content | gpt-5.4 |

**Frameworks:**
| Framework | Type |
|-----------|------|
| OmniMemory | Self-evolving memory system |
| OmniCoreAgent | Production agent framework |
| Swarm | Multi-agent orchestration |
1. **OmniMemory** → Upgrade 3-tier memory system
2. **OmniCoreAgent** → Production agent architecture
3. **Swarm patterns** → Multi-agent coordination
4. **Agent roles** → Specialized sub-agents for complex tasks

### Agent Role → Lord Sav Mapping
| Role | Lord Sav Use |
|------|-------------|
| Workflow Orchestrator | B.L.A.S.T. protocol automation |
| Task Distributor | Parallel feature builds |
| Performance Monitor | Dashboard metrics analysis |
| Multi-Agent Coordinator | Sharp_wilson + main bot coordination |
| Knowledge Synthesizer | Memory consolidation |

---

_Added: 2026-03-29_
