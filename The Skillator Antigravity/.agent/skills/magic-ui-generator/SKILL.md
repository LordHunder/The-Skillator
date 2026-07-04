---
name: magic-ui-generator
description: "Utilizes Magic by 21st.dev to generate, compare, and integrate multiple production-ready UI component variations."
category: frontend
risk: safe
---

# Magic UI Generator

## Context
This skill leverages Magic by 21st.dev to build modern, responsive UI components. Instead of generating a single standard solution, it focuses on providing multiple design variations to choose from, drawing inspiration from a curated library of real-world components.

## When to Use
Trigger this skill whenever:
- A new UI component is requested (e.g., pricing tables, hero sections).
- Brainstorming different design directions for a specific feature.
- Professional logos or icons are needed (via SVGL integration).

## Execution Workflow
1. **Analyze Requirements**: Review the component description. Ensure target output aligns with the project's stack.
2. **Generate Variations**: Explore 21st.dev/magic to generate several distinct styles. Use descriptive prompts pushing for modern aesthetics.
3. **Present Options**: Briefly describe the generated variations side-by-side.
4. **Integrate Selection**: Once chosen, integrate the fully functional, production-ready TypeScript code. Ensure dependencies (`lucide-react`, `framer-motion`) are installed.

## Strict Rules
- **Choice First**: Always offer multiple premium design variations before writing the final code to the project.
- **Clean Code**: Ensure all generated code is clean TypeScript, accessible, and responsive.
