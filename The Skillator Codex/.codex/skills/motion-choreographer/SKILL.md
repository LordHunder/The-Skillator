---
name: motion-choreographer
description: "Use to implement fluid dynamics, spring physics, perpetual micro-interactions, and complex layout transitions."
category: frontend
risk: safe
---

# Motion Choreographer

## When to Use
- When adding interactions, hover states, scroll reveals, or complex animations to an interface.
- Must be used to elevate static UIs into "alive", premium experiences.

## 1. Fluid Dynamics & Physics
- **No Linear Easing:** All motion must simulate real-world mass and spring physics. Use custom cubic-beziers (e.g., `cubic-bezier(0.32,0.72,0,1)`) or Framer Motion springs (`type: "spring", stiffness: 100, damping: 20`).
- **Hardware Acceleration:** Never animate `top`, `left`, `width`, or `height`. Animate exclusively via `transform` and `opacity`.

## 2. Micro-Interactions
- **Magnetic Button Hover:** On hover, scale the entire button down slightly (`scale-[0.98]`) to simulate physical pressing.
- **Perpetual Micro-Interactions:** Embed continuous, infinite micro-animations (Pulse, Typewriter, Float, Shimmer) in standard components.
- **Staggered Reveals:** Do not mount lists instantly. Use staggered waterfall reveals (`staggerChildren` or CSS `animation-delay`).

## 3. Scroll & State Interpolation
- **Entry Animations:** Elements must execute a gentle, heavy fade-up (`translate-y-16 blur-md opacity-0` resolving to `translate-y-0 blur-0 opacity-100` over 800ms+) as they enter the viewport.
- **Loading & Empty States:** Implement full interaction cycles, including skeletal loaders matching layout sizes and beautiful empty states.

## 4. Performance Guardrails
- **Blur Constraints:** Apply `backdrop-blur` only to fixed/sticky elements. Never apply to scrolling containers (causes continuous GPU repaints).
- **Z-Index Restraint:** Reserve z-indexes strictly for systemic layers (sticky nav, modals, overlays).

