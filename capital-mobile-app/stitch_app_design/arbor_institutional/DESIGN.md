# Design System: Institutional Excellence

## 1. Overview & Creative North Star
The Creative North Star for this design system is **"The Digital Private Bank."** 

Wealth management is built on the intersection of legacy and lucidity. This design system rejects the "fintech-standard" of playful illustrations and loud gradients in favor of an editorial, high-end experience that feels like an invitation into a private club. We move beyond the flat, template-driven look of the original site by introducing **Intentional Asymmetry** and **Tonal Depth**. By utilizing wide margins, varying text alignments, and overlapping elements (e.g., a display headline partially overlaying a secondary container), we create a sense of bespoke craftsmanship. The layout is not just a container for data; it is an architectural space designed for clarity and confidence.

## 2. Colors
Our palette is rooted in the organic stability of forest tones and the precision of charcoal.

*   **Primary (`#1f5d01`):** Represents the core of the 'Tree of Growth'. Used for primary actions and key brand moments. 
*   **Primary Container (`#38761d`):** Used for large-scale hero sections or prominent card backgrounds to establish the "Growth" motif.
*   **Tertiary (`#735c00`):** The Golden Accent. Reserved strictly for calls to action (CTAs) like "Invest Today" to draw immediate focus against the deep greens.
*   **Surface Hierarchy:** We utilize `surface-container-lowest` (#ffffff) through `surface-container-highest` (#e2e2e2) to build a sophisticated environment.

### The "No-Line" Rule
To maintain a premium, seamless feel, **designers are prohibited from using 1px solid borders for sectioning.** Boundaries must be defined solely through background color shifts. For example, a `surface-container-low` section should sit flush against a `surface` background to denote a change in content without the visual "noise" of a line.

### Glass & Gradient Rule
To move beyond a static corporate feel, utilize **Glassmorphism** for floating navigation bars or data overlays. Use a semi-transparent `surface` color with a `backdrop-blur` of 12px-20px. 
*   **Signature Textures:** For Hero backgrounds, use a subtle linear gradient from `primary` (#1f5d01) to `primary-container` (#38761d) at a 135-degree angle. This provides a tactile "soul" to the digital space.

## 3. Typography
The system employs a dual-font strategy to balance modern precision with established authority.

*   **Display & Headlines (Manrope):** A geometric sans-serif that feels architectural. Large-scale headlines (`display-lg` at 3.5rem) should use tighter letter-spacing (-2%) to feel impactful and authoritative.
*   **Title & Body (Inter):** The workhorse for legibility. Inter provides the "Institutional" feel required for complex financial data and long-form advisory letters.
*   **The Narrative Scale:** Use high contrast between `display-md` and `body-lg`. A large, bold headline paired with a generous, wide-measure body paragraph conveys the confidence of a "Digital Curator."

## 4. Elevation & Depth
Hierarchy is achieved through **Tonal Layering** rather than traditional structural lines or heavy drop shadows.

*   **The Layering Principle:** Stacking is the primary method of separation. Place a `surface-container-lowest` card on top of a `surface-container-low` section. The subtle difference in hex code creates a soft, natural lift that mimics fine stationery.
*   **Ambient Shadows:** If a "floating" effect is necessary (e.g., for a high-priority modal or dropdown), shadows must be extra-diffused. Use a blur of 30px-50px with a low-opacity (4%-6%) color derived from `on-surface` (#1a1c1c).
*   **The "Ghost Border" Fallback:** If accessibility requirements demand a border, use the `outline-variant` token at 15% opacity. Never use 100% opaque borders.
*   **Backdrop Blurs:** Use `surface_variant` at 70% opacity with a blur for tooltips and floating menus to allow underlying colors to bleed through, softening the interface.

## 5. Components

### Buttons
*   **Primary (Golden CTA):** Background: `tertiary`, Text: `on-tertiary`. Use `ROUND_FOUR` (0.25rem) for a precise, "sharp" corporate edge.
*   **Secondary (Outlined):** No background. Use a `Ghost Border` with `primary` text.
*   **States:** On hover, the primary button should shift to `tertiary_container` with a subtle `ambient shadow`.

### Cards & Lists
*   **The Rule of Zero Dividers:** Forbid the use of divider lines. Separate list items using the **Spacing Scale** (vertical whitespace) or by alternating background tones between `surface-container-low` and `surface-container-lowest`.
*   **Rounding:** Apply `lg` (0.5rem) to containers that hold imagery (Modern Architecture), but keep functional cards at `md` (0.375rem) to maintain a feeling of precision.

### Input Fields
*   **Style:** Minimalist. Use a `surface-container-highest` background with a `Ghost Border` that turns `primary` on focus.
*   **Labels:** Use `label-md` in `secondary` charcoal. Labels should never be floating; they sit firmly above the input to maintain an editorial grid.

### Additional Specialty Components
*   **The Growth Metric Tracker:** A custom card using `primary_container` with `on_primary` text to highlight portfolio performance.
*   **The Advisory Accordion:** Used for "Annual Letters." No borders; use `surface_container_low` for the header and `surface_container_lowest` for the expanded content to show nesting.

## 6. Do's and Don'ts

### Do
*   **Do** use generous whitespace (at least 80px between major sections) to convey a "luxury" feel.
*   **Do** use high-quality imagery of modern architecture and professional portraiture to anchor the "Institutional Excellence" philosophy.
*   **Do** use the 'Tree of Growth' as a subtle watermark or background motif (opacity < 5%) in sections with high data density.

### Don't
*   **Don't** use standard "Select All" or "Submit" labels; use active, professional language like "Verify Residency" or "Initialize Portfolio."
*   **Don't** use 100% black. Use the `on_background` (#1a1c1c) charcoal for all text to ensure the UI feels soft and premium.
*   **Don't** use rounded "pills" for buttons. Stick to `ROUND_FOUR` or `ROUND_EIGHT` to keep the aesthetic professional and rigid.