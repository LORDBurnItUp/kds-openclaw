# The Complete Design Prompt Template

_5 Core Dimensions for requesting designs from AI agents_

---

## 1. PATTERN & LAYOUT (The Skeleton)

### Product-Specific Patterns

| Product Type | Pattern | Focus | Layout |
|-------------|---------|-------|--------|
| SaaS (General) | Hero + Features + Social Proof + CTA | Value proposition first | Full-width hero, 3-column features |
| Micro SaaS | Minimal + Live Demo | Show don't tell | Centered hero, embedded demo |
| E-commerce (Luxury) | Feature-Rich + Immersive Gallery | Large imagery, storytelling | Full-screen slider, grid gallery |
| Fintech/Crypto | Conversion-Optimized + Trust | Data visualization, security | Split hero, live stats dashboard |
| Analytics Dashboard | Bento Grid + Actionable Insights | Data density with clarity | Modular cards, filters |
| Portfolio/Agency | Storytelling + Case Studies | Visual impact | Full-screen sections, horizontal scroll |

**KDS Pattern:** Community Hub + Marketplace + 4D Experience
**Layout:** Spatial floating modules, teleport navigation, live video grid

---

## 2. STYLE & AESTHETIC (The Skin)

### Style Library

| Style | Keywords | Technical | Best For |
|-------|----------|-----------|----------|
| Glassmorphism | Frosted glass, blurred background | backdrop-filter: blur(10px) | Modern apps, overlays |
| Aurora UI | Vibrant gradients, Northern Lights | Multi-stop gradients, hue rotation | Landing pages, creative |
| Soft UI | Soft shadows, tactile | box-shadow inset+outset | Mobile, wellness |
| Linear/Vercel | Dark mode, subtle borders | #0A0A0A bg, #1A1A1A cards | Developer tools |
| Bento Grid | Modular, organized | CSS Grid, varying sizes | Dashboards |
| Liquid Glass | Fluid shapes, organic | SVG blobs, backdrop-filter | Creative agencies |
| Brutalism | Raw, bold, geometric | High contrast | Creative agencies |
| Y2K Revival | Metallic, chrome, retro-futuristic | Metal gradients | Bold brands |
| Claymorphism | 3D inflated, soft | Rounded + shadows | Playful apps |
| Gradient Mesh | Complex multi-color | Organic gradients | Hero sections |
| Minimalist Luxury | White space, serif, gold | Maximum simplicity | High-end |
| Cyberpunk | Neon, glitch, tech-noir | High energy colors | Gaming, tech |
| Organic | Nature shapes, earth tones | Flowing forms | Wellness |

**KDS Style:** Cyberpunk + Glassmorphism + Liquid Glass
**Implementation:** Void black, lime neon, glassmorphic cards, glitch effects, floating 3D elements

---

## 3. COLOR & THEME (The Palette)

### Color Psychology Palettes

#### Trust & Professionalism
```css
--primary: #0F172A;  /* Navy */
--cta: #0369A1;      /* Blue */
--background: #F8FAFC;
--text: #1E293B;
--accent: #3B82F6;
```

#### Vibrant & Modern
```css
--primary: #6366F1;  /* Indigo */
--cta: #10B981;      /* Emerald */
--background: #FFFFFF;
--text: #1E293B;
--accent: #F59E0B;
```

#### Luxury & Premium
```css
--primary: #1C1917;  /* Stone Dark */
--cta: #CA8A04;      /* Gold */
--background: #FAFAF9;
--text: #292524;
--accent: #78716C;
```

#### Dark Mode Excellence
```css
--background: #0A0A0A;
--surface: #1A1A1A;
--border: #333333;
--text: #FFFFFF;
--text-secondary: #A3A3A3;
--accent: #3B82F6;
```

**KDS Colors:** Cyberpunk Dark Mode
```css
--background: #02040a;    /* Void */
--primary: #BFF549;       /* Lime */
--accent-blue: #60a5fa;
--accent-yellow: #FACC15;
--card: rgba(255,255,255,0.03);
```

### Best Practices
- ✅ 60-30-10 rule (60% dominant, 30% secondary, 10% accent)
- ✅ WCAG AA compliance (4.5:1 for text)
- ✅ Semantic tokens (--color-success, --color-error)
- ❌ No more than 3 primary colors
- ❌ No pure black on pure white
- ❌ No color-only information

---

## 4. TYPOGRAPHY (The Voice)

### Font Pairings

| Style | Headings | Body | Personality |
|-------|----------|------|-------------|
| Modern/Tech | Inter | Roboto | Clean, scalable |
| Elegant/Luxury | Playfair Display | Montserrat | Sophisticated |
| Friendly/Consumer | Poppins | Open Sans | Approachable |
| Brutalist/Bold | Space Grotesk | JetBrains Mono | Raw, technical |
| Editorial | Merriweather | Source Sans Pro | Readable, classic |

**KDS Typography:**
- Display: Space Grotesk
- Body: Archivo
- Mono: JetBrains Mono

---

## 5. ANIMATIONS & INTERACTIONS (The Soul)

### Micro-Interactions

#### Button Effects
- Scale up: transform: scale(1.02)
- Lift: box-shadow + translateY(-2px)
- Ripple: Radial gradient from click
- Glow: Outer glow on hover
- Border beam: Animated gradient border
- Duration: 150-300ms, cubic-bezier(0.4, 0, 0.2, 1)

#### Input Focus
- Ring: 2-4px outline with brand color at 50%
- Label float: Animated label moving up
- Always visible focus indicators

#### Card Hover
- Lift + Shadow: translateY(-4px)
- Tilt: 3D perspective (2-3deg)
- Glow border: Animated gradient reveal
- Image zoom: Scale 1.05x inside container

### Scroll Animations
- Reveal: Fade up + translateY(20px→0), stagger 100ms
- Parallax: Hero at 0.5x speed, foreground at 1.2x
- Progress bar: Fixed top, width based on scroll %

### Page Transitions
- Fade: opacity 200ms
- Slide: translateX(-100%→0) 300ms
- Blur: filter: blur(0→10px→0)
- Backdrop → Content stagger

### Loading States
- Skeleton: Shimmer effect, 1.5s infinite
- Spinner: Rotating gradient circle
- Pulse: Scale + opacity

### Advanced Effects
- Border beams: Conic gradient rotation
- Mesh gradients: Multi-color, slow hue rotation
- Glassmorphism: backdrop-filter: blur(10px) saturate(180%)

### Performance Rules
- ✅ Use transform and opacity only (GPU)
- ✅ will-change for animated elements
- ✅ requestAnimationFrame for JS
- ✅ prefers-reduced-motion support
- ❌ Never animate width/height/position
- ❌ No animations >500ms for interactions
- ❌ No heavy animations on page load

---

## Anti-Patterns to AVOID

### Design
- ❌ No animations that block user action
- ❌ No light grey on white backgrounds
- ❌ No more than 3 colors, 2 fonts, 5 sizes
- ❌ No icons without labels/tooltips
- ❌ No hamburger menus on desktop
- ❌ No tiny tap targets (min 44x44px)

### Performance
- ❌ No unoptimized images
- ❌ No layout shifts (CLS > 0.1)
- ❌ No heavy animations on load

### Accessibility
- ❌ No keyboard traps
- ❌ No missing alt text
- ❌ No color-only information

---

## KDS Design Implementation

Based on this template, here's what we're building:

| Dimension | KDS Choice |
|-----------|-----------|
| Pattern | Community Hub + Marketplace + Spatial UI |
| Style | Cyberpunk + Glassmorphism + Liquid Glass |
| Colors | Void Black + Lime Green + Blue + Yellow |
| Typography | Space Grotesk + Archivo + JetBrains Mono |
| Animations | Glitch text, scroll reveals, 3D particles, floating orbs, blackhole transitions, glassmorphism hover |

---

## Additional Resources

- Vercel MCP: `npx -y @robinson_ai_systems/vercel-mcp`
- UI/UX Skill: https://github.com/nextlevelbuilder/ui-ux-pro-max-skill.git

---

_Added: 2026-03-28_
