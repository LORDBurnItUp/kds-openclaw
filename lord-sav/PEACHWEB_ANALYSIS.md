# PeachWeb Animation Analysis

_From CSS/JS source inspection_

---

## Key Techniques Found

### 1. Glassmorphism (Everywhere)
```css
backdrop-filter: blur(10px);
background-color: rgba(83, 40, 255, 0.4);  /* #5328ff66 */
border-radius: 16px;
border: 1px solid rgba(255, 255, 255, 0.2);  /* #ffffff33 */
```

### 2. Viewport-Relative Typography
```css
font-size: 4dvw;      /* Desktop */
font-size: 6dvw;      /* Tablet */
font-size: 13.8dvw;   /* Mobile — massive hero text */
line-height: 1em;
letter-spacing: -1px;  /* Tight tracking for impact */
```

### 3. Scroll-Driven Layout (Parallax)
```css
/* Staggered vertical positioning creates depth on scroll */
.card:nth-child(1) { margin-top: 150px; }
.card:nth-child(2) { margin-top: 300px; }
.card:nth-child(3) { margin-top: 450px; }
```

### 4. Fixed Position Sections
```css
position: fixed;
/* Creates sticky sections that scroll over each other */
```

### 5. WebGL Canvas (3D Scenes)
```css
.pw-scene-style > canvas {
  display: block;
  width: 100%;
  height: 100%;
  user-select: none;
}
```

### 6. Font Stack
```css
@font-face { font-family: neuehaasdisplayroman; }  /* Headings */
@font-face { font-family: neuehaasdisplaylight; }   /* Body */
@font-face { font-family: instrumentserif-regular; } /* Accent */
@font-face { font-family: instrumentserif-italic; }  /* Emphasis */
```

### 7. Color Palette
```css
--primary: #20174e;      /* Deep purple */
--accent: #00f0ff;       /* Cyan */
--card-1: #5328ff66;     /* Purple 40% */
--card-2: #12064466;     /* Dark purple 40% */
--text: #ffffff;
--text-muted: #20174e80; /* Purple 50% */
```

### 8. Button Pattern
```css
border: 1px solid #ffffff;
height: 50px;
border-radius: 16px;
padding: 0 16px;
background: transparent;  /* Outline style */
/* Filled variant */
background-color: #ffffff;
color: #20174e;
```

### 9. Hover Effects
```css
/* Text: subtle opacity shift */
color: #ffffff;
:hover { color: #ffffffb3; }

/* Borders: lighten */
border: 1px solid #20174e;
:hover { border: 1px solid #20174eb3; }

/* Cards: image border highlight */
:hover { border: 2px solid #00e2ff; }
```

### 10. Scroll Spacers
```css
/* Empty divs for scroll-driven pacing */
height: 30vh;
height: 50vh;
height: 100vh;
height: 160vh;
height: 200vh;
```

---

## What We Already Have (Better)
- ✅ StarField (animated 3D stars)
- ✅ AsteroidField (flying asteroids)
- ✅ Glitch teleport transitions
- ✅ Parallax3D (multi-layer depth)
- ✅ BreathingText + LightningText
- ✅ CyberGrid (perspective grid)
- ✅ Scanline overlay
- ✅ Glassmorphism cards
- ✅ GSAP scroll triggers

## What We Can Add From PeachWeb
- [ ] Viewport-relative font sizing (dvw units)
- [ ] Staggered card margins for scroll depth
- [ ] Fixed sticky sections
- [ ] Tight letter-spacing on hero text
- [ ] Semi-transparent colored card backgrounds
- [ ] Subtle opacity hover on all text

---

_Added: 2026-03-28_
