# Design System

> Project: `SDD SKILL`
> Platform: `Frontend UI in user projects; SDD SKILL itself has no visual UI`
> Framework: `Use the target project's existing UI framework and language`

## 1. Brand & Colors
- Source of truth: the Figma design provided for the target project and accessed through Figma MCP.
- Do not invent or impose global colors. Read color tokens from the relevant Figma file.
- If a needed color or semantic token is missing, ask the user or report the gap instead of guessing.

## 2. Typography
- Read font families, type scale, weights, and line heights from the target project's Figma design through Figma MCP.
- Do not impose a repository-wide typography scale across unrelated target projects.
- If typography is unspecified, flag it as a design question rather than silently selecting a font.

## 3. Spacing & Layout
- Read spacing, grid, radius, and container rules from the target project's Figma design through Figma MCP.
- Follow the target project's existing responsive and layout conventions where the design is silent.
- Do not introduce global layout tokens that conflict with the target project.

## 4. Core Components
- Inspect the relevant Figma frames and components through Figma MCP before implementing frontend UI.
- Reuse components and variants already present in the target project.
- Match component behavior and variants shown in Figma; report missing or ambiguous states instead of inventing them.

## 5. States & Accessibility
- Inspect interaction states and accessibility annotations available through Figma MCP.
- Preserve keyboard navigation, visible focus, semantic controls, and readable contrast in the implementation.
- If Figma does not specify a required state or accessibility detail, flag it for confirmation; do not treat its absence as approval to omit accessibility.

## 6. Icons & Assets
- Use icons, illustrations, and assets specified by the target project's Figma design or existing codebase.
- Do not substitute or add assets when the intended asset is unclear; ask or flag the gap.

## 7. References
- Figma file and UI references are supplied per target project and accessed through Figma MCP.
- No single Figma file, component library, or frontend framework is imposed by SDD SKILL.
