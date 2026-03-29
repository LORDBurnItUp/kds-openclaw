# Agent Smith 2.0 — Complete Reference

_Source: Screenshots from Omar + GitHub (yashkumarthakur2004/agent-smith-2.0)_
_Private repo — reference for building Lord Sav_

---

## 🏗️ Architecture

### Main Files
| File | Purpose |
|------|---------|
| `jarvis.py` | Main Telegram bot — all handlers |
| `masterconnect.py` | Flask web dashboard for WhatsApp linking |
| `whatsapp_bot.py` | WhatsApp bot integration |
| `requirements.txt` | Python dependencies |

### Bot Framework
- **Library:** `pyTelegramBotAPI` (telebot)
- **Database:** MongoDB Atlas (pymongo)
- **Web:** Flask + gunicorn
- **Image Processing:** Pillow (PIL)
- **PDF Generation:** reportlab
- **File Handling:** PyPDF2, python-docx, python-pptx

---

## 📋 Features & Commands

### Core Commands
| Command | Description |
|---------|-------------|
| `/start` | Welcome message + feature menu (inline buttons) |
| `/help` | Help menu with all commands |
| `/masterconnects` | Link bot to WhatsApp via URL |
| `/admin` | Admin panel (add/remove credits) |

### Image Tools
| Command | Description |
|---------|-------------|
| `/imagine` | Generate images (DALL-E 3, Flux 1.1 Pro, Recraft V3) |
| `/removebg` | Remove background from uploaded image |
| `/upscale` | Upscale uploaded image |
| `/facerestore` | Restore/enhance faces in photos |

### Video Generation
| Command | Description |
|---------|-------------|
| `/video` | Video generation menu |
| Supports | Kling, Luma, Hunyuan, Hailuo, Pika, Pixverse, OpenAI Sora, Wan Video, Stable Diffusion Video, CogVideoX |

### Audio & Voice
| Command | Description |
|---------|-------------|
| `/voice` | Realtime voice chat (Gemini, GPT-4o, Claude 3.5 Sonnet) |
| `/tts` | Text-to-speech (OpenAI voices) |
| `/music` | Music generation (Lyria, MusicFX) |

### TTS Voices Available
`nova`, `alloy`, `echo`, `fable`, `onyx`, `shimmer`, `coral`, `sage`, `ash`, `ballad`, `verse`

### File Conversions
| Command | Description |
|---------|-------------|
| `/imagetopdf` | Convert images to PDF |
| `/pdftoword` | PDF → Word document |
| `/wordtopdf` | Word → PDF |
| `/pdftoppt` | PDF → PowerPoint |
| `/ppttopdf` | PowerPoint → PDF |
| `/pdftoimages` | PDF → Images |
| `/imagestopdf` | Images → PDF |

### Other
| Command | Description |
|---------|-------------|
| `/summarize` | Summarize group chat messages |
| Language selection | Multi-language support (inline keyboard) |

---

## 🗄️ Database Schema (MongoDB)

### Users Collection
```json
{
  "userID": "telegram_user_id",
  "sessions": {},
  "credits": 15
}
```

### Credits System
- **Daily credits:** 15 per user per day
- **Admin can add/remove** credits per user
- Credits tracked in MongoDB

---

## 🔌 Master Connects (WhatsApp Bridge)

### Architecture
1. Flask web app (`masterconnect.py`) runs on webview
2. User navigates to web dashboard
3. Enters WhatsApp bot URL to link
4. MongoDB stores session data
5. Cross-platform session sync

### WhatsApp Bot (`whatsapp_bot.py`)
- Admin commands: add/remove credits
- Multiple AI conversations
- Image generation
- Voice messages
- File handling

---

## 📦 Dependencies (requirements.txt)

```
telebot
flask
pillow
requests
pymongo
gunicorn
python-dotenv
openai
reportlab
PyPDF2
python-docx
python-pptx
```

---

## 🎨 UI/UX Pattern

### Inline Keyboard Layout (from /start)
```
[🎨 Image Generation]  [✏️ Edit Image]
[🎬 Video]              [🎵 Music]
[🎙️ Voice Chat]         [🔊 TTS]
[📄 Files]              [📋 Summarize]
[🔗 Master Connects]    [❓ Help]
```

### Callback Pattern
- Each button sends a callback query
- Bot edits message to show sub-menu or starts processing
- Photo/document handlers wait for user uploads
- Progress messages sent during processing

---

## 🔑 API Services Used

| Service | Endpoint/Purpose |
|---------|-----------------|
| OpenAI | DALL-E 3, GPT-4o, TTS, Whisper |
| Flux | Flux 1.1 Pro image generation |
| Recraft | Recraft V3 image generation |
| ElevenLabs | Premium TTS |
| Google Gemini | Voice chat |
| Anthropic Claude | Voice chat |
| Kling | Video generation |
| Luma | Video generation |
| Hailuo | Video generation |
| Pika | Video generation |
| Pixverse | Video generation |
| Wan | Video generation |
| CogVideoX | Video generation |
| Lyria | Music generation |
| MusicFX | Music generation |

---

## 📊 What Lord Sav Needs to Match/Exceed

Everything above, PLUS:
- ✅ Web scraping MCP server
- ✅ Auto lead generator
- ✅ Knowledge base integration
- ✅ Persistent memory system
- ✅ Proactive automation (heartbeats)
- ✅ Multi-platform (Telegram + WhatsApp + more)

---

## 🔐 Deployment Details (from source code)

### Bot Token
- From BotFather — Omar needs his OWN

### API Keys Found in Code (Yash Kumar's — NOT Omar's)
- OpenAI: `sk-proj-...` (in jarvis.py)
- Gemini: `AIzaSyB...` (in jarvis.py)
- MongoDB: `mongodb+srv://yashkumarthakur808:...@cluster0.bnpdp.mongodb.net/`
- ⚠️ Omar must get his own keys

### Hosting
- Platform: PythonAnywhere
- Flask dashboard hosted alongside bot
- Bot link: `https://t.me/jarvisfastreplit_bot`

### Additional Dependencies
- `google-generativeai` (for Gemini voice chat)

---

_This is the blueprint. Now build it._
