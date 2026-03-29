# Ultimate Orchestrator Configuration

_Comprehensive .env template for multi-agent orchestration_

---

## LLM Configuration
```env
LLM_PROVIDER=openai          # openai, anthropic, openrouter, groq, google
MODEL_CHOICE=gpt-4o
OPENAI_API_KEY=your-key
BASE_URL=https://api.openai.com/v1
LLM_TEMPERATURE=0.7
LLM_MAX_TOKENS=4096
LLM_TIMEOUT=60
```

## Database Configuration
```env
DB_PROVIDER=supabase         # supabase, postgres, mongodb, pinecone, chromadb
SUPABASE_URL=your-url
SUPABASE_KEY=your-key
```

## Voice Configuration
```env
# Speech-to-Text
STT_PROVIDER=deepgram        # deepgram, openai_whisper, assemblyai, azure_speech
DEEPGRAM_API_KEY=your-key

# Text-to-Speech
TTS_PROVIDER=openai          # openai, elevenlabs, cartesia, azure_speech

# LiveKit
LIVEKIT_URL=wss://your-instance.livekit.cloud
LIVEKIT_API_KEY=your-key
LIVEKIT_API_SECRET=your-secret
```

## MCP Servers
```env
MCP_ENABLED=false
GITHUB_TOKEN=your-token
SLACK_BOT_TOKEN=your-token
AIRTABLE_API_KEY=your-key
BRAVE_API_KEY=your-key
FIRECRAWL_API_KEY=your-key
LOCAL_FILE_DIR=/path/to/files
```

## Monitoring
```env
MONITORING_ENABLED=true
LANGFUSE_ENABLED=false
LANGFUSE_PUBLIC_KEY=your-key
LANGFUSE_SECRET_KEY=your-key
```

## Environment
```env
ENVIRONMENT=development      # development, staging, production
```

---

## Lord Sav's Values (Already Configured)

| Setting | Lord Sav Value | Source |
|---------|---------------|--------|
| LLM_PROVIDER | anthropic | CONFIG.md |
| MODEL_CHOICE | claude-sonnet-4-6 | CONFIG.md |
| DB_PROVIDER | supabase | CONFIG.md |
| STT_PROVIDER | deepgram | CONFIG.md |
| TTS_PROVIDER | openai + elevenlabs | CONFIG.md |
| MCP_ENABLED | true | CONFIG.md |
| FIRECRAWL_API_KEY | ✅ configured | CONFIG.md |
| ENVIRONMENT | production | CONFIG.md |

---

_Added: 2026-03-28_
