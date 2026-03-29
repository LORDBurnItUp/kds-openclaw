# AntiGravity + Stitch — Website Building Cheat Code

_Google's AI Design Agent + AntiGravity = insane website generation_

---

## 🛠️ Tools

| Tool | What It Is | URL |
|------|-----------|-----|
| **AntiGravity** | Google's AI agent platform | https://antigravity.google/ |
| **Stitch** | Google's AI design agent | https://stitch.withgoogle.com/ |
| **NotebookLM** | Google's knowledge tool | https://notebooklm.google/ |
| **Stitch Skills** | Modular toolkit for Stitch | https://github.com/google-labs-code/stitch-skills |

---

## 🔌 MCP Server Config

```json
{
  "mcpServers": {
    "stitch": {
      "serverUrl": "https://stitch.googleapis.com/mcp",
      "headers": {
        "X-Goog-Api-Key": "YOUR_KEY_HERE"
      }
    }
  }
}
```

**Get API Key:** https://stitch.withgoogle.com/settings

---

## 🧰 Stitch Skill Stack

### 1. 📋 design-md — Design System Extraction
- Analyzes existing Stitch projects
- Extracts colors, typography, spacing, layouts
- Documents full design system automatically
- Creates DESIGN.md for consistency
- **Use when:** You need to maintain UI consistency across screens

### 2. ⚛️ react-components — React Conversion
- Transforms Stitch HTML → React component systems
- Automated validation for functional output
- Maintains design token consistency
- Production-ready React code
- **Use when:** Moving from prototype to real application

### 3. 🔄 stitch-loop — Autonomous Website Generator ⭐
- **The flagship skill**
- Generates complete multi-page websites from ONE prompt
- Organizes project files automatically
- Validates each generated page
- Continues building autonomously
- **Use when:** Turn one idea into a full website

### 4. ✨ enhance-prompt — Prompt Intelligence
- Converts vague ideas → optimized Stitch prompts
- Adds UI/UX keywords and precision
- Injects design system context
- Structures prompts for stronger results
- **Use when:** You want dramatically better outputs

### 5. 🎥 remotion — Walkthrough Videos
- Creates professional showcase videos from apps
- Smooth transitions via Remotion framework
- Zooms and text overlays
- Marketing-ready output
- **Use when:** Turn apps into demo content

### 6. 🎨 shadcn-ui — Component Integration
- Guides shadcn/ui component integration
- Helps discover and install components
- React best practices
- Clean, scalable UI architecture
- **Use when:** Building React apps with modern UI

---

## 🚀 Why This Stack Is Powerful

- ✅ Built-in validation — outputs actually work
- ✅ Real frameworks (React, shadcn, etc.)
- ✅ Design consistency across projects
- ✅ Multi-step workflow automation
- ✅ Professional marketing outputs (videos)
- ✅ Autonomous generation (stitch-loop)

---

## 🧠 Integration with Lord Sav

### How Stitch Fits Into Our Stack

| Lord Sav Feature | Stitch Skill |
|-----------------|-------------|
| Kings Dripping Swag dashboard | stitch-loop (3D sci-fi site) |
| Portfolio page | react-components + shadcn-ui |
| Landing pages | enhance-prompt + stitch-loop |
| Design consistency | design-md |
| Demo videos | remotion |
| Master Connects webview | react-components |

### Workflow
1. **enhance-prompt** — Refine the idea
2. **stitch-loop** — Generate the full site
3. **design-md** — Extract and document design system
4. **react-components** — Convert to production React
5. **shadcn-ui** — Polish with modern components
6. **remotion** — Create showcase video

---

## 📋 TODO

- [ ] Get real Stitch API key (current one is placeholder)
- [ ] Install Stitch MCP server
- [ ] Test stitch-loop for Kings Dripping Swag
- [ ] Use enhance-prompt for landing page
- [ ] Generate showcase video with remotion

---

## 🔧 Installation Commands

```bash
# Install all Stitch skills globally
npx skills add google-labs-code/stitch-skills --skill stitch-design --global
npx skills add google-labs-code/stitch-skills --skill stitch-loop --global
npx skills add google-labs-code/stitch-skills --skill design-md --global
npx skills add google-labs-code/stitch-skills --skill enhance-prompt --global
npx skills add google-labs-code/stitch-skills --skill react:components --global
npx skills add google-labs-code/stitch-skills --skill remotion --global
npx skills add google-labs-code/stitch-skills --skill shadcn-ui --global
```

## 📂 Skill File Structure

```
skills/[category]/
├── SKILL.md          — Mission Control for the agent
├── scripts/          — Executable enforcers (validation & networking)
├── resources/        — Knowledge base (checklists & style guides)
└── examples/         — Gold standard syntactically valid references
```

## 🆕 Great Candidates for New Skills

- **Validation:** Convert Stitch HTML to other UI frameworks and validate syntax
- **Decoupling Data:** Convert static design content into external mock data files
- **Generate Designs:** Generate new design screens in Stitch from given data

---

_Added: 2026-03-28_
_Source: Omar's AntiGravity + Stitch stack_
