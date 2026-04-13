# Design System Document: Financial Editorial & Tonal Depth

## 1. Overview & Creative North Star: "The Digital Private Bank"
This design system moves beyond the cold, utilitarian nature of traditional fintech. Our Creative North Star is **"The Digital Private Bank."** The objective is to evoke the feeling of a high-end, bespoke physical office—think heavy bond paper, frosted glass partitions, and whispered confidence.

To achieve this, we break the "template" look by rejecting rigid, boxed-in grids. We favor **intentional asymmetry** and **tonal layering**. We do not use lines to separate ideas; we use space and light. The layout should feel like a premium editorial spread—authoritative, airy, and curated.

---

## 2. Colors & Surface Architecture
We move beyond flat hex codes to a system of "Surface Tiers." This creates a sense of physical architecture within the mobile screen.

### Color Tokens
*   **Primary (The Authority):** `#001e40` (Primary) transitioning into `#003366` (Primary Container).
*   **Secondary (The Prestige):** `#735c00` (Secondary) and `#fed65b` (Secondary Container) for subtle gold accents.
*   **Neutral (The Canvas):** `#f9f9f9` (Surface) up to `#ffffff` (Surface Container Lowest).

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1px solid borders to section content. Traditional dividers feel "cheap" and cluttered. 
*   **The Law:** Boundaries must be defined solely through background color shifts. For example, a `surface-container-low` section sitting on a `surface` background provides all the separation the eye needs.

### Surface Hierarchy & Nesting
Treat the UI as stacked sheets of fine materials.
1.  **Base:** `surface` (#f9f9f9)
2.  **Sectioning:** `surface-container-low` (#f3f3f3)
3.  **Actionable Cards:** `surface-container-lowest` (#ffffff)
This nesting creates natural depth. An "Information Card" should never have a stroke; it should simply be a "whiter" white than the background it sits on.

### Signature Textures
For Hero sections (e.g., total balance displays), use a **Subtle Axial Gradient** transitioning from `primary` (#001e40) to `primary-container` (#003366). This adds "soul" and a sense of luxury that flat blue cannot replicate.

---

## 3. Typography: Editorial Authority
We utilize a dual-font pairing to balance modern tech with corporate heritage.

*   **Display & Headlines (Manrope):** This is our "Editorial" voice. Use `display-lg` to `headline-sm` for large balances and section titles. The wider apertures of Manrope convey openness and modernity.
*   **Body & UI (Inter):** Inter is our "Functional" voice. Use `body-lg` down to `label-sm` for all data, descriptions, and input labels. It is highly legible and provides the "trustworthy" corporate feel required for financial data.

**The Power Scale:** Always use high-contrast sizing. A `display-md` balance should sit near a `label-md` caption to create a clear, sophisticated hierarchy that guides the eye instantly to the most important data.

---

## 4. Elevation & Depth
Hierarchy is achieved through **Tonal Layering**, not structural scaffolding.

*   **The Layering Principle:** Stacking tiers is the default. To highlight a specific investment card, place a `surface-container-lowest` card on a `surface-container` background. 
*   **Ambient Shadows:** If a card must "float" (e.g., a modal or a primary action button), use an extra-diffused shadow.
    *   *Spec:* `Y: 8px, Blur: 24px, Opacity: 4%, Color: #001e40` (a tinted blue shadow, never pure black).
*   **The "Ghost Border" Fallback:** If a border is required for high-accessibility contexts, use `outline-variant` (#c3c6d1) at **15% opacity**. This creates a suggestion of a boundary without breaking the editorial flow.
*   **Glassmorphism:** For top navigation bars or floating action buttons, use `surface` at 80% opacity with a **20px backdrop-blur**. This allows the content to bleed through, making the app feel like a single, integrated experience.

---

## 5. Components

### Cards & Lists
*   **The Rule:** Forbid divider lines.
*   **Implementation:** Use `xl` (1.5rem) or `lg` (1rem) roundedness. Separate list items using 12px of vertical white space or a subtle shift from `surface` to `surface-container-low`.
*   **Status Badges:** Use `error_container` (Red), `secondary_container` (Gold/Yellow), and a custom Tertiary Green. These should be "Soft Pills"—high roundedness, low-saturation backgrounds, and high-saturation text for readability.

### Buttons
*   **Primary:** A gradient of `primary` to `primary-container`. `full` roundedness. No shadow unless hovering/active.
*   **Secondary:** `surface-container-highest` background with `on_surface` text. This feels like a "pressed paper" button.
*   **Tertiary:** Ghost style. No background, no border. Only `primary` colored text with `label-md` weight.

### Input Fields
*   **Styling:** Never use a four-sided box. Use a `surface-container-low` background with a `md` (0.75rem) corner radius.
*   **Interaction:** On focus, the background shifts to `surface-container-lowest` (white) and a 1px `primary` bottom-border (only) appears.

### Additional App-Specific Components
*   **The Portfolio Dial:** A semi-circular visualization using `primary` and `secondary` tokens to show asset allocation.
*   **Trust Indicators:** Small, `surface-variant` containers with `label-sm` text (e.g., "SIPC Insured") to provide constant, subtle reassurance.

---

## 6. Do’s and Don’ts

### Do:
*   **Do** use white space aggressively. If it feels like "too much," it’s probably just right for a premium experience.
*   **Do** use `secondary_fixed` (Gold) sparingly as a "jewelry" accent—for stars, premium icons, or specific "Growth" indicators.
*   **Do** ensure all touch targets are at least 44x44px, despite the "minimalist" look.

### Don’t:
*   **Don't** use pure black (#000000) for text. Use `on_surface` (#1a1c1c) to maintain a soft, premium feel.
*   **Don't** use standard Material or iOS drop shadows. They look "off-the-shelf" and diminish the custom brand feel.
*   **Don't** crowd the edges. Maintain a minimum 24px (1.5rem) horizontal padding for all screen content to ensure an editorial, "un-cramped" layout.