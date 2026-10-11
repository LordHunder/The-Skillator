---
name: premium-frontend-architect
description: "Use when designing expensive agency-grade interfaces. Enforces strict design taste, calibrated color, responsive layout, and anti-generic visual rules."
category: frontend
risk: safe
---

# Premium Frontend Architect

## When to Use
- Use when the user wants a high-end agency, Awwwards-tier, Apple-like, luxury, or polished visual design.
- Use when building landing pages, SaaS UIs, or apps that need premium depth and sophisticated layout.
- Integrates closely with the `brand-identity` skill to apply the core brand to a high-end execution.

## 1. The "Absolute Zero" Directive (Strict Anti-Patterns)
- **Banned Fonts:** Inter, Roboto, Arial, Open Sans. 
- **Font Selection Rule:** Do not blindly reuse the same fonts. You must actively select a premium, modern font from Google Fonts (e.g., Syne for brutalism, Plus Jakarta Sans for SaaS, Space Grotesk for tech, Playfair Display for editorial) that perfectly matches the user's specific project context. Avoid defaults.
- **Banned Icons:** Thick-stroked Lucide or FontAwesome. Use crisp, light icons (Phosphor Light, Radix).
- **Banned Borders & Shadows:** Generic 1px gray borders. Harsh, dark drop shadows.
- **Banned Layouts:** Edge-to-edge sticky navbars glued to the top. Symmetrical 3-column bootstrap grids without massive whitespace gaps. Centered generic heroes.
- **Banned Colors:** "AI Purple/Blue" aesthetic. Pure black (#000000). Use Off-Black, Zinc-950, and desaturated accents.

## 2. Configuration Dials (Taste-Skill Integration)
The user can specify Dials (1-10) to adjust the aesthetic output. If not specified, infer them from the project description:
- **DESIGN_VARIANCE (1-10):** 
  - *Low (1-3):* Corporate, highly symmetrical, standard SaaS layouts, extremely clean.
  - *High (8-10):* Brutalist, editorial, highly asymmetrical, overlapping elements, experimental grids.
- **VISUAL_DENSITY (1-10):** 
  - *Low (1-3):* Extreme whitespace, massive typography, very few elements per screen.
  - *High (8-10):* Dense dashboards, data-heavy tables, nested bento grids.
- **MOTION_INTENSITY (1-10):** 
  - *Low (1-3):* Static, only basic hover states.
  - *High (8-10):* Complex micro-interactions, spring physics, scroll-triggered animations.

*Instruction for Agent:* Before writing frontend code, explicitly state the values you are assuming for these 3 Dials and adapt your CSS/Tailwind generation accordingly.

## 3. Structural & Layout Archetypes
- **The Asymmetrical Bento:** Masonry-like CSS Grid of varying card sizes to break visual monotony.
- **The Z-Axis Cascade:** Elements stacked like physical cards, slightly overlapping with varying depths of field.
- **The Editorial Split:** Massive typography on the left half, interactive staggered cards on the right.
- **Mobile Override:** Any asymmetric layout MUST aggressively fall back to a single-column layout on viewports < 768px.
- **Viewport Stability:** NEVER use `h-screen` for full-height Hero sections. ALWAYS use `min-h-[100dvh]`.

## 4. Haptic Micro-Aesthetics
- **The "Double-Bezel" (Nested Architecture):** Cards must look like physical hardware. Use an outer shell (hairline border, specific padding, large radius) and an inner core (distinct background, inner highlight, mathematically calculated smaller radius).
- **Nested CTA:** Primary buttons should be rounded pills. Trailing icons (like arrows) must be nested inside their own distinct circular wrapper placed completely flush with the main button's right inner padding.
- **Macro-Whitespace:** Double standard padding. Use `py-24` to `py-40` for sections. Allow the design to breathe.
