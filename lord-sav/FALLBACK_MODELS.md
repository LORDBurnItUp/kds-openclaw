# Fallback LLM Configuration

_Open source models for when paid APIs hit limits — Lord Sav never goes offline_

---

## Free Tier / Open Source Models

### Via OpenRouter (Free Tier Available)
| Model | Provider | Use Case | Cost |
|-------|----------|----------|------|
| `meta-llama/llama-3.1-8b-instruct:free` | Meta | General chat | FREE |
| `google/gemma-2-9b-it:free` | Google | Fast responses | FREE |
| `mistralai/mistral-7b-instruct:free` | Mistral | Code generation | FREE |
| `huggingface/zephyr-7b-beta:free` | HuggingFace | Conversational | FREE |

### Via Groq (Fast Inference)
| Model | Speed | Use Case |
|-------|-------|----------|
| `llama3-8b-8192` | Ultra-fast | Quick responses |
| `mixtral-8x7b-32768` | Fast | Complex reasoning |
| `gemma-7b-it` | Fast | General purpose |

### Via Venice AI
| Model | Use Case |
|-------|----------|
| `llama-3.3-70b` | Balanced, most tasks |
| `venice-uncensored` | No content filtering |

### Local (Ollama - Zero Cost)
| Model | Size | Use Case |
|-------|------|----------|
| `llama3.1:8b` | 4.7GB | General chat |
| `mistral:7b` | 4.1GB | Code generation |
| `codellama:7b` | 3.8GB | Code specialist |
| `gemma2:9b` | 5.4GB | Fast responses |
| `phi3:3.8b` | 2.2GB | Ultra-lightweight |

---

## Fallback Chain

```
1. Anthropic Claude (primary) → fails
2. OpenAI GPT-4o → fails
3. Groq Llama 3.1 (fast) → fails
4. OpenRouter Free Llama (free) → fails
5. Venice AI (uncensored) → fails
6. Ollama Local (zero cost) → NEVER FAILS
```

## Setup Priority

1. **Already configured:** Anthropic, OpenAI, Groq, OpenRouter, Venice
2. **Need to configure:** Ollama local models
3. **Fallback ready:** Free OpenRouter models (no setup needed, just use)

---

## Implementation

In the bot, add fallback logic:
```python
def get_llm_response(prompt):
    providers = [
        ("anthropic", "claude-sonnet-4-6"),
        ("openai", "gpt-4o"),
        ("groq", "llama3-8b-8192"),
        ("openrouter", "meta-llama/llama-3.1-8b-instruct:free"),
        ("venice", "llama-3.3-70b"),
        ("ollama", "llama3.1:8b"),  # Local, always available
    ]
    for provider, model in providers:
        try:
            return call_provider(provider, model, prompt)
        except Exception:
            continue
    return "All providers down. Emergency mode."
```

---

_Added: 2026-03-28_
