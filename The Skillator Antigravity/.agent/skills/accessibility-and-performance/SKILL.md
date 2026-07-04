---
name: accessibility-and-performance
description: "Ensures high-end UIs remain highly accessible and performant, without compromising the design."
category: frontend
risk: safe
---

# Accessibility and Performance Validator

## When to Use
- After designing or implementing complex, high-end UIs using `premium-frontend-architect` or `motion-choreographer`.
- To validate that visual flourishes do not harm UX for users with disabilities or lower-end devices.

## 1. Performance Mandates
- **No Scroll-Hijacking without Fallbacks:** Avoid overriding native scroll unless strictly necessary. If using Locomotive Scroll or Lenis, ensure touch devices fall back to native smooth scrolling.
- **Paint Optimization:** Avoid using `box-shadow`, `backdrop-filter`, or `filter: blur()` on large scrolling regions. Tie these exclusively to isolated, non-moving layers.
- **Image & Asset Loading:** Heavy visual designs require Next-Gen formats (WebP, AVIF) and lazy loading for off-screen elements.

## 2. Accessibility without Aesthetic Compromise
- **Contrast Ratios:** Ensure text on low-opacity glassmorphism backgrounds still meets WCAG AA (4.5:1) by using subtle text-shadows or dynamic background tinting.
- **Focus Rings:** Do NOT use `outline-none` globally. Implement beautiful, custom `:focus-visible` rings that match the brand identity (e.g., an offset 2px ring in the accent color).
- **Reduced Motion:** Always respect `@media (prefers-reduced-motion: reduce)`. Disable perpetual micro-interactions and complex 3D transitions if this flag is active, falling back to simple opacity fades.
- **Semantic HTML:** High-end div soup is banned. Use `<article>`, `<section>`, `<nav>`, and `<button>` to ensure screen readers can navigate the spatial layout properly.
