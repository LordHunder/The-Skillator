---
name: ui-redesign
description: "Use when the user wants to upgrade or modernize an EXISTING website or app. Audits the current design, identifies generic and AI-generated patterns, and applies targeted high-end improvements without rewriting functionality. Works with any stack: Tailwind, vanilla CSS, styled-components, etc."
category: frontend
risk: safe
---

# UI Redesign

Upgrades existing interfaces to premium quality. The goal is never to rewrite from scratch — it's to diagnose the specific weaknesses and fix them surgically, working with whatever stack is already in place.

## When to Use
- The user says "make this look better", "modernize this", "this looks too basic/generic/AI-made".
- Upgrading a prototype or MVP to a production-quality design.
- Auditing a codebase before a design system overhaul.
- Do NOT use this for new builds from scratch — use `premium-frontend-architect` instead.

---

## The Three-Step Process

### 1. Scan
Read the codebase. Before touching anything, identify:
- Framework and styling method (Tailwind v3/v4, vanilla CSS, styled-components, CSS modules, etc.)
- Current font choices
- Color palette and whether it has a strategy
- Primary layout patterns (flex/grid, card grids, hero style)
- What states exist (loading, empty, error) and which are missing

### 2. Diagnose
Run through the full audit below. Produce a numbered list of every problem found. Group by category. Prioritize by visual impact (highest first).

### 3. Fix
Apply targeted upgrades working with the existing stack. Do not migrate to a different CSS framework. Do not rewrite components that work. Improve what's there with minimal diff.

---

## Full Design Audit

### Typography
- [ ] **Browser default fonts or Inter used.** Replace with a font that has character: `Geist`, `Outfit`, `Cabinet Grotesk`, `Satoshi`. For editorial projects, pair a serif header with a sans-serif body.
- [ ] **Headlines lack presence.** Increase size for display text, tighten `letter-spacing`, reduce `line-height`. Headlines should feel heavy and intentional.
- [ ] **Body text too wide.** Limit paragraph width to ~65 characters (`max-width: 65ch`). Increase `line-height` to ~1.6–1.75 for readability.
- [ ] **Only Regular (400) and Bold (700) weights used.** Introduce Medium (500) and SemiBold (600) for more subtle hierarchy.
- [ ] **Numbers in proportional font.** Use `font-variant-numeric: tabular-nums` for data, prices, metrics.
- [ ] **Missing `letter-spacing` adjustments.** Negative tracking for large headers. Positive tracking for small caps or labels.
- [ ] **All-caps subheaders everywhere.** Try lowercase italics, sentence case, or small-caps instead.
- [ ] **Orphaned words.** Single words alone on the last line. Fix with `text-wrap: balance` or `text-wrap: pretty`.
- [ ] **Title Case On Every Header.** Switch to sentence case.

### Color and Surfaces
- [ ] **Pure `#000000` background.** Replace with off-black: `#0a0a0a`, `#121212`, or a tinted dark.
- [ ] **Oversaturated accent colors.** Keep saturation < 80%.
- [ ] **More than one accent color.** Pick one. Remove the rest.
- [ ] **Mixing warm and cool grays.** Stick to one gray family. Tint consistently.
- [ ] **Purple/blue "AI gradient" aesthetic.** Replace with neutral bases and a single, considered accent.
- [ ] **Generic `box-shadow` using pure black.** Tint shadows to match the background hue.
- [ ] **Flat design with zero texture.** Add subtle noise, grain, or micro-patterns to backgrounds.
- [ ] **Perfectly even linear gradients.** Use radial gradients, noise overlays, or mesh gradients.
- [ ] **Inconsistent lighting direction.** Audit all shadows to ensure they suggest one consistent light source.
- [ ] **Random dark section in a light-mode page (or vice versa).** Commit to one mode. If contrast is needed, use a slightly darker shade of the same palette, not a sudden jump to `#111`.
- [ ] **Empty flat sections with no visual depth.** Add background imagery (blurred, overlaid, masked), subtle patterns, or ambient gradients. Use `https://picsum.photos/seed/{name}/1920/1080` as a reliable placeholder when real assets aren't available.

### Layout
- [ ] **Everything centered and symmetrical.** Break symmetry with offset margins, mixed aspect ratios, or left-aligned headers over centered content.
- [ ] **Three equal card columns as feature row.** Replace with 2-column zig-zag, asymmetric grid, horizontal scroll, or masonry.
- [ ] **`height: 100vh` for full-screen sections.** Replace with `min-height: 100dvh` (iOS Safari viewport bug).
- [ ] **Complex flexbox percentage math.** Replace with CSS Grid.
- [ ] **No max-width container.** Add ~1200–1440px container with auto margins.
- [ ] **Cards of equal height forced by flexbox.** Allow variable heights or use masonry when content varies.
- [ ] **Uniform border-radius on everything.** Vary: tighter on inner elements, softer on containers.
- [ ] **No overlap or depth.** Use negative margins to create layering.
- [ ] **Symmetrical vertical padding.** Optically, bottom often needs slightly more than top.
- [ ] **Dashboard always has a left sidebar.** Consider top nav, floating command menu, or collapsible panel.
- [ ] **Missing whitespace.** Double the spacing. Dense layouts work for data dashboards, not marketing pages.
- [ ] **Buttons not bottom-aligned in card groups.** Pin CTAs to bottom of each card regardless of content above.
- [ ] **Feature lists starting at different vertical positions.** Use consistent spacing above lists or fixed-height title blocks.
- [ ] **Mathematical alignment that looks optically wrong.** Apply 1–2px optical corrections to centered icons, text in buttons, play buttons in circles.

### Interactivity and States
- [ ] **No hover states on buttons.** Add background shift, slight scale, or translate.
- [ ] **No active/pressed feedback.** Add `scale(0.98)` or `translateY(1px)` on `:active`.
- [ ] **Instant transitions (zero duration).** Add `transition: all 200–300ms` to all interactive elements.
- [ ] **Missing focus ring.** Ensure visible focus indicators for keyboard navigation. Not optional.
- [ ] **No loading states.** Replace generic spinners with skeleton loaders matching the layout shape.
- [ ] **No empty states.** An empty dashboard showing nothing is a missed opportunity. Design a composed "getting started" view.
- [ ] **No error states.** Add clear, inline error messages for forms. No `window.alert()`.
- [ ] **Dead links (`href="#`).** Link to real destinations or visually disable.
- [ ] **No active nav indicator.** Style the current page link differently.
- [ ] **Scroll jumping.** Add `scroll-behavior: smooth`.
- [ ] **Animations using `top`, `left`, `width`, `height`.** Switch to `transform` + `opacity` for GPU-accelerated animation.

### Content
- [ ] **Generic names (John Doe, Jane Smith).** Use diverse, realistic-sounding names.
- [ ] **Round fake numbers (99.99%, $100).** Use organic data: 47.2%, $99.00, +1 (312) 847-1928.
- [ ] **Placeholder company names (Acme, Nexus, SmartFlow).** Invent contextual, believable brand names.
- [ ] **AI copywriting clichés.** Ban: "Elevate", "Seamless", "Unleash", "Next-Gen", "Game-changer", "Delve", "In the world of..."
- [ ] **Exclamation marks in success messages.** Remove them. Be confident, not loud.
- [ ] **"Oops!" error messages.** Be direct: "Connection failed. Please try again."
- [ ] **Passive voice.** Use active voice throughout.
- [ ] **All blog dates identical.** Randomize to appear real.
- [ ] **Same avatar for multiple users.** Use unique assets per person.
- [ ] **Lorem Ipsum.** Never. Write real draft copy.

### Component Patterns
- [ ] **Generic card (border + shadow + white bg).** Remove the border, or use only background color, or only spacing. Never all three.
- [ ] **Always one filled + one ghost button.** Add text links or tertiary styles to reduce visual noise.
- [ ] **Pill-shaped "New"/"Beta" badges.** Try square badges, flags, or plain text labels.
- [ ] **Accordion FAQ.** Use side-by-side list, searchable help, or inline progressive disclosure.
- [ ] **3-card carousel testimonials with dots.** Replace with masonry wall, embedded social posts, or single rotating quote.
- [ ] **Pricing table with 3 identical towers.** Highlight the recommended tier with color and emphasis, not just extra height.
- [ ] **Modals for simple actions.** Use inline editing, slide-over panels, or expandable sections.
- [ ] **Avatar circles exclusively.** Try squircles or rounded squares.
- [ ] **Light/dark toggle as sun/moon switch.** Use a dropdown, system preference detection, or integrate into settings.
- [ ] **Footer link farm with 4 columns.** Simplify. Focus on main nav paths and legally required links.

### Iconography
- [ ] **Lucide or Feather icons exclusively.** Use Phosphor, Heroicons, or a custom set. Standardize stroke width.
- [ ] **Cliché icon metaphors (rocket = launch, shield = security).** Replace with less obvious alternatives: bolt, fingerprint, spark, vault.
- [ ] **Inconsistent stroke widths across icons.** Standardize to one stroke weight across the whole project.
- [ ] **Missing favicon.** Always include a branded favicon.

### Code Quality
- [ ] **Div soup.** Use semantic HTML: `<nav>`, `<main>`, `<article>`, `<section>`, `<aside>`, `<header>`, `<footer>`.
- [ ] **Inline styles.** Move to CSS classes, CSS variables, or framework utilities.
- [ ] **Hardcoded hex values scattered throughout.** Consolidate to CSS custom properties or design tokens.
- [ ] **Non-descriptive class names (`box`, `container2`, `wrapper-new`).** Rename to semantic, intent-based names.
- [ ] **Missing `alt` text on images.** All `<img>` elements need descriptive alt text (or `alt=""` for decorative ones).
- [ ] **`!important` overrides throughout the CSS.** Indicates specificity problems. Resolve the cascade properly.

---

## Output Format

After the audit, provide:

1. **Priority Fix List** — top 5–10 issues by visual impact, with specific file/line references where possible.
2. **Targeted Patches** — minimal code diffs that fix each issue working within the existing stack.
3. **What NOT to change** — anything that's working correctly and shouldn't be touched.
