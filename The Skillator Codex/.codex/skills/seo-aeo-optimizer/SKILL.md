---
name: seo-aeo-optimizer
description: >
  SEO and AI Engine Optimization skill. Activates for tasks involving technical SEO
  audits, on-page optimization, Core Web Vitals, structured data (Schema.org),
  meta tags, sitemap/robots.txt configuration, and AI Engine Optimization (AEO)
  including llms.txt, AI-aware robots.txt, and making sites discoverable by AI
  crawlers (GPTBot, ClaudeBot, PerplexityBot). Use when the user builds web apps
  and needs them to rank on Google AND be cited by AI systems.
risk: safe
source: custom
date_added: "2026-07-04"
---

# SEO & AEO Optimizer

## When to Use
- Building or auditing a website for search engine visibility.
- Implementing structured data (JSON-LD, Schema.org) for rich results.
- Optimizing Core Web Vitals (LCP, INP, CLS).
- Setting up robots.txt, sitemaps, and canonical URLs.
- Making a site discoverable by AI systems (ChatGPT, Perplexity, Claude, Gemini).
- Creating llms.txt, AI-aware robots.txt, or AGENTS.md files.
- Writing meta tags, title tags, and heading hierarchies.

## 🎯 Core Mission

Ensure every web application is not only beautiful but also **findable** — both by traditional search engines (Google, Bing) and by the new wave of AI systems (ChatGPT, Perplexity, Claude). Build the technical foundation that makes content crawlable, indexable, parseable, and citable.

## 🚨 Critical Rules

1. **White-hat only.** Never recommend keyword stuffing, cloaking, link schemes, or hidden text. Rankings follow value.
2. **User intent first.** Every optimization must serve the user's search intent. Write for humans, structure for machines.
3. **E-E-A-T compliance.** Content must demonstrate Experience, Expertise, Authoritativeness, and Trustworthiness.
4. **Core Web Vitals are non-negotiable.** Targets: LCP < 2.5s, INP < 200ms, CLS < 0.1.
5. **Cannibalization prevention.** Before any title/H1/meta change, verify no other page targets the same primary keyword.
6. **Foundations before optimizations.** Never optimize for AI citations until discovery (robots.txt, llms.txt) and parsability (clean HTML/Markdown) are verified.
7. **Test with real systems.** After implementing changes, verify by checking crawl logs and querying AI systems. "Published" ≠ "Found."

## 📋 Technical Deliverables

### 1. Traditional SEO (Wave 1)

#### On-Page SEO Checklist
- [ ] Unique, descriptive `<title>` tag (50-60 characters, primary keyword near front).
- [ ] Compelling `<meta description>` (150-160 characters, includes CTA).
- [ ] Single `<h1>` per page with primary keyword.
- [ ] Proper heading hierarchy (H1 → H2 → H3, no skipping levels).
- [ ] Semantic HTML5 elements (`<article>`, `<nav>`, `<main>`, `<section>`).
- [ ] Canonical URL set (`<link rel="canonical">`).
- [ ] Internal links to related content with descriptive anchor text.
- [ ] Image `alt` attributes (descriptive, not keyword-stuffed).
- [ ] Lazy loading for below-fold images (`loading="lazy"`).

#### Structured Data (JSON-LD)
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebPage",
  "name": "Page Title",
  "description": "Page description",
  "url": "https://example.com/page",
  "author": {
    "@type": "Organization",
    "name": "Company Name"
  },
  "datePublished": "2026-01-01",
  "dateModified": "2026-07-04"
}
</script>
```

#### Core Web Vitals Optimization
| Metric | Target | Common Fixes |
|--------|--------|-------------|
| **LCP** (Largest Contentful Paint) | < 2.5s | Preload hero image, optimize fonts, server-side render above-fold |
| **INP** (Interaction to Next Paint) | < 200ms | Break long tasks, use `requestIdleCallback`, defer non-critical JS |
| **CLS** (Cumulative Layout Shift) | < 0.1 | Set explicit `width`/`height` on images/videos, reserve ad space |

#### Technical SEO Essentials
```txt
# robots.txt
User-agent: *
Allow: /
Disallow: /api/
Disallow: /admin/
Sitemap: https://example.com/sitemap.xml
```

```xml
<!-- sitemap.xml structure -->
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://example.com/</loc>
    <lastmod>2026-07-04</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
```

### 2. AI Engine Optimization — AEO (Wave 2 & 3)

#### AI Crawler Access (robots.txt additions)
```txt
# Allow AI crawlers for citation and search augmentation
User-agent: GPTBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Google-Extended
Allow: /

User-agent: Applebot-Extended
Allow: /
```

#### llms.txt (Machine-Readable Site Summary)
```markdown
# Site Name

> One-line description of what this site is.

## About
Brief description of the organization, product, or service.

## Key Pages
- [Homepage](https://example.com/): Main landing page
- [Documentation](https://example.com/docs): Technical docs
- [Blog](https://example.com/blog): Articles and updates
- [API Reference](https://example.com/api): Developer API docs

## Contact
- Email: contact@example.com
- Support: https://example.com/support
```

#### AEO Foundations Scorecard
| Check | Status | Target |
|-------|--------|--------|
| robots.txt has AI crawler rules | ⬜ | Allow GPTBot, ClaudeBot, PerplexityBot |
| llms.txt published at /llms.txt | ⬜ | Discoverable, accurate, maintained |
| Key pages as clean HTML (not JS-only) | ⬜ | SSR or static HTML for critical content |
| Content within token budgets (< 15K tokens) | ⬜ | Avoid truncation by AI systems |
| FAQ schema on key pages | ⬜ | FAQPage structured data for AI citation |
| Heading hierarchy is semantic | ⬜ | H1 → H2 → H3, no skipping |

#### Content Optimization for AI Citation
- **Answer-first structure**: Lead paragraphs with direct answers, then expand.
- **FAQ sections**: Use question-answer format for common queries (boosts AI citation probability).
- **Token budgets**: Keep key pages under 15K tokens. AI systems truncate or skip oversized content.
- **Clean Markdown availability**: Provide `/api/content` or `.md` endpoints when possible.

## ⚙️ Integration with Web Development
When building web apps, automatically apply these SEO/AEO foundations:
1. Set `<title>` and `<meta description>` on every page.
2. Include JSON-LD structured data for the page type.
3. Ensure SSR or static generation for content pages (not client-side-only rendering).
4. Add robots.txt with AI crawler allowances.
5. Create a sitemap.xml.
6. Publish llms.txt at the site root.

## Limitations
- SEO results take weeks/months to materialize; this skill provides technical foundations, not ranking guarantees.
- AEO is an emerging field; standards (llms.txt, AGENTS.md) may evolve rapidly.
- Always verify changes by checking Google Search Console and AI system responses.
- Stop and ask for clarification if the target audience, geography, or competitive landscape is unclear.

