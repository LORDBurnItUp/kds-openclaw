# Kings Dripping Swag (2130) — The Future Is Now

_Build Plan: The Sickest Website Ever Created_

---

## 🌌 The Lore

> Once there was a tale about ARTIFICIAL INTELLIGENCE TECHNOLOGY that took over the world. So SLIDERS teleported back one hundred years to see when AI initiated war against mankind...

**Domain:** kingsdrippingswag.io
**Era:** 2130 (100 years in the future)
**Aesthetic:** Ultra-advanced, 3D sci-fi, from another dimension

---

## 🔬 Research: PeachWeb.io Analysis

### What PeachWeb Is
A no-code builder for **WebGL 3D websites**. 4x winner of "No-Code Site of the Month," beating Wix, Webflow, and WordPress.

### Their Tech Stack
| Technology | What It Does |
|-----------|-------------|
| **WebGL** | 3D rendering in browser |
| **Three.js** | JavaScript 3D library |
| **Scroll-triggered scenes** | 3D scenes animate on scroll |
| **Keyframe animations** | Smooth property transitions |
| **Drag-and-drop editor** | No-code 3D placement |
| **Interactive elements** | Click/hover 3D responses |

### What We Can Learn From Them
- Scroll-driven 3D scenes (immersive storytelling)
- WebGL performance optimization
- Smooth keyframe animations
- 3D product landing pages
- Interactive portfolio layouts

---

## 🏗️ Our Tech Stack

### Frontend (The 3D Experience)
| Technology | Purpose | Why |
|-----------|---------|-----|
| **Next.js 14** (App Router) | Framework | SSR, routing, performance |
| **React Three Fiber** | 3D rendering | React wrapper for Three.js — declarative 3D |
| **@react-three/drei** | 3D helpers | Pre-built 3D components (cameras, controls, effects) |
| **Three.js** | WebGL engine | Core 3D rendering |
| **Spline** | 3D design | Design 3D scenes visually, export to web |
| **GSAP** (GreenSock) | Animation | Industry-standard animation library |
| **ScrollTrigger** (GSAP) | Scroll animations | Trigger 3D scenes on scroll |
| **Framer Motion** | UI animations | React animation library |
| **Tailwind CSS** | Styling | Utility-first CSS |
| **GLSL Shaders** | Custom effects | Blackhole, teleport, glitch effects |

### Backend (The Brains)
| Technology | Purpose |
|-----------|---------|
| **FastAPI** | REST API + WebSocket |
| **LiveKit** | Real-time video chat (10 cameras) |
| **Supabase** | Auth, database, real-time |
| **Qdrant** | Vector search, recommendations |
| **Redis** | Session management, caching |

### Payments & Commerce
| Technology | Purpose |
|-----------|---------|
| **Stripe** | Card payments |
| **PayPal** | Alternative payments |
| **Affiliate system** | Custom tracking |

### Hosting
| Platform | Purpose |
|----------|---------|
| **Hostinger VPS** | Main hosting (46.202.197.97) |
| **Vercel** | Frontend CDN (optional) |
| **Cloudflare** | DNS + CDN + security |

---

## 🎨 Design System: "2130 Aesthetic"

### Color Palette
```css
--primary: #BFF549        /* Lime green — energy, future */
--accent-blue: #60a5fa    /* Blue — trust, tech */
--accent-yellow: #FACC15  /* Yellow — attention, gold */
--bg-void: #02040a        /* Ultra dark — space */
--bg-card: rgba(255,255,255,0.03)
--glow-lime: rgba(191,245,73,0.3)
--glow-blue: rgba(96,165,250,0.3)
```

### Typography
```css
--font-display: 'Space Grotesk'    /* Headings — futuristic */
--font-body: 'Archivo'             /* Body — clean, modern */
--font-mono: 'JetBrains Mono'      /* Code — terminal feel */
```

### 3D Effects
- **Floating orbs** with blur (ambient glow)
- **Grid backgrounds** (sci-fi depth)
- **Blackhole transitions** between pages
- **Glitch effects** on load
- **Particle systems** (stars, data streams)
- **Parallax depth** (layers move at different speeds)
- **Holographic UI elements** (glassmorphism + glow)

### Animation Effects (The "Cool But Not Too Crazy" Ones)
| Effect | When | Intensity |
|--------|------|-----------|
| Blackhole teleport | Page transitions | Medium |
| Glitch text | Loading/intro | Light |
| Floating UI elements | Always | Subtle |
| Scroll-triggered 3D | Section reveals | Medium |
| Particle background | Always | Light |
| Hover glow | Interactive elements | Light |
| Smooth slide-in | Content appears | Subtle |
| Confetti | Achievements/copies | Burst |
| Scanline overlay | Loading states | Very light |

---

## 📐 Page Architecture

### Navigation: "Teleport Terminal"
Instead of traditional nav, users type commands or click 3D portals:
```
> teleport home
> teleport marketplace
> teleport terminal
> teleport community
```
Each "teleport" triggers a blackhole transition animation.

### Pages
| Page | 3D Element | Description |
|------|-----------|-------------|
| **Home/Landing** | Floating 3D logo + particle field | "Welcome to 2130" |
| **Feed** | 3D card stack | Social posts with depth |
| **Video Hub** | 10 floating camera windows | Live webcam grid |
| **Marketplace** | 3D product showcase | Services with hover effects |
| **Command Center** | Holographic dashboard | API integrations, analytics |
| **Terminal CLI** | Full-screen terminal | Real terminal connection |
| **Groups/Forums** | 3D conversation bubbles | Threaded discussions |
| **DMs** | Floating message panels | Private messaging |
| **Portfolio** | 3D project gallery | Interactive case studies |
| **Affiliate** | 3D referral tree | Network visualization |

---

## 🔮 The Blackhole Transition

The signature effect. When a user clicks a button:

1. Screen darkens at click point
2. A swirling blackhole expands from click
3. Particles get sucked in
4. New page emerges from the center
5. Content materializes with glitch effect

### Implementation
```jsx
// React Three Fiber + GSAP
function BlackholeTransition({ isActive, onComplete }) {
  // Shader-based blackhole effect
  // Particle system that responds to mouse
  // GSAP timeline for expansion/collapse
  // onComplete triggers route change
}
```

---

## 🚀 Build Phases

### Phase 1: Foundation (Week 1)
- Next.js 14 project setup
- Tailwind + design tokens
- Basic 3D scene with React Three Fiber
- Landing page with floating elements
- Supabase auth setup

### Phase 2: Core Pages (Week 2)
- Home/Landing with 3D hero
- Social feed with 3D cards
- Navigation/teleport system
- Blackhole transition effect
- User profiles

### Phase 3: Community (Week 3)
- Groups/forums
- DM system
- Video hub (LiveKit integration)
- 10-camera webcam system
- Real-time messaging (WebSocket)

### Phase 4: Commerce (Week 4)
- Marketplace with 3D showcase
- Stripe/PayPal integration
- Affiliate system
- Service listings
- Portfolio pages

### Phase 5: Power Features (Week 5)
- Command Center dashboard
- Built-in Terminal CLI
- API integration panel
- Analytics visualization
- Admin panel

### Phase 6: Polish (Week 6)
- Performance optimization
- Mobile responsiveness
- Animation refinement
- SEO optimization
- Launch prep

---

## 🧠 What We Need (Knowledge Gaps)

### Already Have ✅
- Next.js, React, Tailwind — ✅
- Supabase, Qdrant, Stripe — ✅
- LiveKit — ✅
- Design tokens + templates — ✅
- Hosting — ✅

### Need to Research/Learn 🔍
1. **React Three Fiber advanced patterns** — Complex 3D scenes, performance
2. **Custom GLSL shaders** — Blackhole, teleport, glitch effects
3. **Spline integration** — Design 3D models, export to R3F
4. **GSAP ScrollTrigger** — Scroll-driven 3D animations
5. **WebGL optimization** — LOD, instancing, frustum culling
6. **WebSocket terminal** — xterm.js + node-pty for CLI
7. **LiveKit multi-camera** — 10 simultaneous video streams

### Recommended Resources
- **Three.js Journey** (threejs-journey.com) — Best 3D web course
- **React Three Fiber docs** (docs.pmnd.rs) — Official R3F docs
- **Spline tutorials** (spline.design/examples) — 3D design examples
- **GSAP ScrollTrigger** (greensock.com/scrolltrigger) — Scroll animations
- **Shader School** (github.com/stackgl/shader-school) — GLSL fundamentals

---

## ✅ Can We Pull This Off?

**YES.** Here's why:

1. **Tech exists** — All the pieces (R3F, GSAP, Spline, LiveKit) are production-ready
2. **We have the infrastructure** — Hosting, databases, payments, auth all configured
3. **We have the design system** — Scroll-Stop template shows we can build dark sci-fi UI
4. **We have reference** — PeachWeb proves 3D WebGL sites work at scale
5. **We have 6 AI providers** — Can generate 3D assets, code, content

**The only gap:** Advanced WebGL shader expertise. But with AI assistance + the resources above, we can learn and build simultaneously.

---

## 🎯 The End Result

A website that:
- Looks like it's from **2130**
- Makes visitors say "what the f***"
- Makes X and Facebook look like ancient history
- Has 3D/4D visuals that feel alive
- Has working blackhole transitions between pages
- Has live video chat with 10 cameras
- Has a real terminal CLI
- Has a marketplace where people make money
- Is **1 of 1** — nothing else like it exists

---

_Added: 2026-03-28_
_Vision: Omar (LORDBurnItDown) + Alan (GknowsThis)_
_Domain: kingsdrippingswag.io_
_Era: 2130_
