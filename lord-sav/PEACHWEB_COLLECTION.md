# PeachWeb Template Collection

_All templates analyzed from Omar's PeachWeb account_

---

## Template 1: Main PeachWeb Site
**URL:** peachweb.io
**Fonts:** neuehaasdisplayroman, neuehaasdisplaylight, instrumentserif-regular, instrumentserif-italic
**Colors:** #20174e (deep purple), #00f0ff (cyan), #5328ff66 (purple cards), #12064466 (dark cards)
**Techniques:**
- Glassmorphism everywhere (backdrop-filter: blur(10px))
- Viewport fonts (4dvw, 6dvw, 13.8dvw mobile)
- Staggered card margins (150px, 300px, 450px)
- Fixed sections for scroll pacing
- WebGL canvas for 3D scenes
- Tight letter-spacing (-1px, -2.5px)
- Scroll spacers (30vh, 50vh, 100vh, 160vh, 200vh)

---

## Template 2: DM Sans Scroll
**URL:** quick-c59mcdisy.peachworlds.com
**Fonts:** dmsans-medium, dmsans-light
**Colors:** #000000 (black), #ffffff (white)
**Techniques:**
- Fixed text while scrolling (position: fixed)
- 200dvh and 100dvh sections for pacing
- Viewport fonts (3dvw, 3.5dvw)
- Letter-spacing -2.5px, -0.25dvw
- Layered images (z-index: 2)
- Bottom-left and bottom-right fixed UI elements

---

## Template 3: Italic Serif Minimal
**URL:** cute-a5aysg13ic.peachworlds.com
**Fonts:** cotford-display-light-italic, kantumruypro-light, kantumruypro-regular
**Colors:** #000000fc (black), #ffffff (white) — pure B&W
**Techniques:**
- Full-screen fixed background (100vw × 100vh, z-index: -1)
- Fixed UI corners (bottom-left, bottom-right, top)
- Viewport fonts (4.8dvw, 4.5dvw)
- Max-width constraints (800px, 400px)
- Very tight letter-spacing (-1.5px)
- Line-height matches font-size (5dvw for 4.8dvw)
- Italic serif headings (luxury editorial feel)

---

## Template 4: Neon Green Tech
**URL:** worthy-1g3n3jez.peachworlds.com
**Fonts:** Syne, Syne-Bold, Syne-SemiBold, Inter, Inter Tight, Manrope, Times New Roman
**Colors:** #000d0f (dark teal), #0e1517 (surface), #66ff63 (neon green), #66ff8a (light green), #0099ff (blue)
**Techniques:**
- Fixed pixel sizes (12px to 100px, no viewport units)
- Minimal fixed elements (only 1)
- Normal scroll layout
- Zero CSS animations (all JS/WebGL)
- Multi-grey text hierarchy (#c9c9c9, #7d7d7d)

**Closest to KDS aesthetic** — dark teal + neon green

---

## Template 5: Grey Scale Elegance
**URL:** great-xjpdu2nxy.peachworlds.com
**Fonts:** juana-lightit (italic serif), helveticaneueltstd-ltex, rooberttrial-light/medium/regular
**Colors:** #000000 (black), #ffffff (white), greys: #a9a9a9, #b0b0b0, #bfbfbf, #d5d5d5
**Techniques:**
- Pure black background
- Multi-grey text hierarchy (5 levels of grey)
- Italic serif accent font
- Clean geometric sans-serif body
- Minimal color — maximum contrast

---

## Common Patterns Across ALL Templates

### Layout
- Fixed/sticky elements for parallax
- 100dvh-600dvh section heights for scroll pacing
- Full-width sections with constrained content (max-width)
- Bottom-left and bottom-right fixed UI anchors

### Typography
- Viewport-relative sizes (dvw) OR fixed pixel sizes
- Tight letter-spacing (-1px to -2.5px)
- Line-height matching or close to font-size
- 2-3 font families max
- Large hero text (80-120px or 4-13dvw)

### Colors
- Always dark backgrounds (#000 to #0d1420)
- White text with grey hierarchy (2-5 levels of grey)
- Single accent color (cyan, green, purple, gold)
- Glassmorphism cards with semi-transparent backgrounds

### Animations
- CSS transitions minimal (most in JS)
- WebGL/Three.js for 3D scenes
- Scroll-triggered via Intersection Observer or GSAP
- Hover: subtle opacity shifts, border color changes

### Responsive
- Desktop: >992px
- Tablet: <=992px
- Mobile: <=480px
- Different font sizes per breakpoint
- Mobile: larger font percentages (13dvw vs 4dvw)

---

## Font CDN Sources
PeachWeb hosts all fonts on: https://files.peachworlds.com/website/

---

## KDS Application

### What We Have (Already Better)
- ✅ StarField (animated 3D stars)
- ✅ AsteroidField (flying asteroids)
- ✅ WormholeEntry (5-phase scroll animation)
- ✅ Glitch teleport transitions
- ✅ Parallax3D (multi-layer depth)
- ✅ BreathingText + LightningText
- ✅ CyberGrid (perspective grid)
- ✅ Scanline overlay
- ✅ Glassmorphism cards
- ✅ GSAP scroll triggers

### What to Add From Templates
- [ ] 5 levels of grey text hierarchy
- [ ] Multiple font families (Syne for display, DM Sans for body)
- [ ] Fixed background layer
- [ ] Bottom-corner UI elements
- [ ] Tighter letter-spacing throughout
- [ ] Viewport-relative sizing on all text
- [ ] Scroll spacer sections (200vh, 400vh, 600vh)

---

_Added: 2026-03-28_
_Total templates analyzed: 5_
