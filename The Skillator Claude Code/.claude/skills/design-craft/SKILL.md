---
name: design-craft
description: "Use when you need deep design judgment on color, typography, layout, motion, and copy. Applies rigorous design laws to prevent AI-generic output. Works at any fidelity — from first draft to final polish. Complements premium-frontend-architect by providing the 'why' behind each design decision."
category: frontend
risk: safe
---

# Design Craft

A set of precise, non-negotiable design laws derived from professional frontend design practice. Use these rules to make every interface feel deliberate, calibrated, and human — not AI-generated.

## When to Use
- When producing or reviewing UI at any stage (wireframe to production).
- When a design feels "generic" or "AI-ish" and needs a principled audit.
- When choosing color strategy, typography scale, layout architecture, or motion behavior.
- Use alongside `premium-frontend-architect` for building; use standalone for auditing existing work.

---

## 1. Color

**Step 1 — Choose a Color Strategy before choosing colors.**

Pick exactly one of these four commitment levels. Do not default to "Restrained" out of caution:

| Strategy | Color Role | Use For |
|---|---|---|
| **Restrained** | Tinted neutrals + one accent ≤10% | SaaS product default, minimal brand |
| **Committed** | One saturated color carries 30–60% of surface | Identity-driven pages, bold brand |
| **Full Palette** | 3–4 named roles, each used deliberately | Data viz, brand campaigns |
| **Drenched** | The surface IS the color | Campaign heroes, statement pages |

**Step 2 — Use OKLCH for all color values.**
- Reduce chroma as lightness approaches 0 or 100 — high chroma at extremes looks garish.
- Never use `#000` or `#fff`. Tint every neutral toward the brand hue (chroma 0.005–0.01 is enough).

**Absolute color bans:**
- No "AI Purple/Blue" gradient aesthetic.
- No oversaturated accents (keep saturation < 80%).
- No mixing warm and cool grays in the same project.
- No tinted box shadows using pure black at low opacity — tint shadows to match the background hue.

---

## 2. Theme (Light vs. Dark)

Dark vs. light is never a default. Not dark "because tools look cool dark." Not light "to be safe."

**The Scene Test:** Before choosing, write one sentence describing who uses this, where, under what ambient light, in what mood. If the sentence doesn't force the answer, make it more specific.

- ❌ "Observability dashboard" — doesn't force the answer.
- ✅ "SRE glancing at incident severity on a 27-inch monitor at 2am in a dim room" — forces dark mode.

---

## 3. Typography

**Hierarchy rules:**
- Scale ratio between heading steps must be ≥ 1.25. Flat scales are invisible hierarchy.
- Cap body line length at 65–75ch.
- Negative tracking (`letter-spacing: -0.02em`) for large display text. Positive tracking for small labels/caps.
- Use `text-wrap: balance` or `text-wrap: pretty` to prevent orphaned single words on the last line.
- Introduce at least Medium (500) and SemiBold (600) weights — "only Regular + Bold" produces flat hierarchy.
- Enable `font-variant-numeric: tabular-nums` for any data, prices, or metrics.

**Font choices:**
- Banned: Inter, Roboto, Arial, Open Sans, browser defaults.
- Allowed (premium sans): Geist, Outfit, Cabinet Grotesk, Satoshi, Clash Display.
- Serif fonts: editorial/creative contexts only. **Never** on dashboards or technical UIs.
- For technical UIs, pair `Geist` + `Geist Mono` or `Satoshi` + `JetBrains Mono`.

---

## 4. Layout

**Spacing:**
- Vary spacing for rhythm — same padding everywhere is monotony.
- Double standard padding for marketing pages. Use `py-24` to `py-40` for sections. Let the design breathe.
- Optically adjust top/bottom padding — bottom often needs to be slightly larger than top.

**Structure bans:**
- No centered hero with generic H1 as default. Use Split Screen (50/50), Left-Aligned Content / Right-Aligned Asset, or Asymmetric Whitespace.
- No three equal card columns as a feature row. Replace with 2-column zig-zag, asymmetric grid, or masonry.
- No `height: 100vh` for full-height sections. Always use `min-height: 100dvh`.
- No complex flexbox percentage math (`calc(33% - 1rem)`). Use CSS Grid.
- No uniform `border-radius` on everything — tighter on inner elements, softer on outer containers.
- No negative margins creating horizontal scroll on mobile — always collapse to single column below 768px.

**Cards:**
- Cards are the lazy answer. Use them only when elevation communicates hierarchy.
- Nested cards are always wrong.
- Remove the border, or use only background color, or use only spacing — never all three at once.
- Buttons in card groups must be bottom-aligned across all cards regardless of content length above.

---

## 5. Motion

**Permitted:**
- Ease out with exponential curves: `ease-out-quart`, `ease-out-quint`, `ease-out-expo`.
- Spring physics for interactive elements: `type: "spring", stiffness: 100, damping: 20`.
- `transform` and `opacity` only.

**Banned:**
- Do not animate CSS layout properties (`top`, `left`, `width`, `height`).
- No bounce, no elastic easing.
- No `window.addEventListener('scroll')` — use IntersectionObserver or Framer Motion's `useScroll`.
- No perpetual animations on scrolling containers (causes continuous GPU repaints).

---

## 6. Copy

- Every word earns its place. No restated headings, no intros that repeat the title.
- No em dashes (`—` or `--`). Use commas, colons, semicolons, periods, or parentheses.
- No AI copywriting clichés: "Elevate", "Seamless", "Unleash", "Next-Gen", "Game-changer", "Delve", "Tapestry", "In the world of..."
- No exclamation marks in success messages. Be confident, not loud.
- No "Oops!" error messages. Be direct: "Connection failed. Please try again."
- Use active voice. "We couldn't save your changes" — not "Mistakes were made."
- No Lorem Ipsum. Write real draft copy.
- No generic names (John Doe, Jane Smith). No round fake numbers (99.99%, $100.00). Use organic data.
- Sentence case on headers, not Title Case On Every Word.

---

## 7. Absolute Visual Bans

Match-and-refuse. If you're about to write any of these, rewrite the element with different structure:

- **Side-stripe borders:** `border-left` or `border-right` > 1px as colored accent. Never intentional. Rewrite with full borders, background tints, leading numbers/icons, or nothing.
- **Gradient text:** `background-clip: text` + gradient background. Use a single solid color. Emphasis via weight or size.
- **Glassmorphism as default:** Blurs and glass cards used decoratively. Rare and purposeful only.
- **The hero-metric template:** Big number, small label, supporting stats, gradient accent. SaaS cliché.
- **Identical card grids:** Same-sized cards with icon + heading + text, repeated endlessly.
- **Modal as first thought:** Modals are usually laziness. Exhaust inline/progressive alternatives first.
- **Neon outer glows:** Use inner borders or subtle tinted shadows instead.
- **Stock "diverse team" photos:** Use real photos, candid shots, or a consistent illustration style.
- **Custom mouse cursors:** Outdated and ruin performance/accessibility.
- **Emoji in UI:** Replace with high-quality icons (Phosphor Light, Radix) or clean SVG primitives.
- **Lucide or Feather icons as default:** Use Phosphor, Heroicons, or a custom set. Standardize stroke width globally.

---

## 8. The AI Slop Test

Ask yourself: *Could someone look at this interface and say "AI made that" without doubt?*

If yes, it has failed. Run this checklist:

- [ ] Color strategy was explicitly chosen, not defaulted to "Restrained."
- [ ] Theme (dark/light) was chosen from a physical scene, not a category reflex.
- [ ] Typography has ≥3 distinct weight steps and a non-banned font.
- [ ] Layout breaks symmetry at least once.
- [ ] No three equal card columns appear anywhere.
- [ ] No gradient text or glassmorphism as decoration.
- [ ] No "AI Purple/Blue" palette.
- [ ] No generic copy clichés.
- [ ] Category-reflex check: "healthcare → white + teal", "crypto → neon on black" — if the palette is guessable from the domain name, rework it.

