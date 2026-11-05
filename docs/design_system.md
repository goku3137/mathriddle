## 2. Design System & UI Standards

### Color Palette & Hex Specifications

The visual identity follows an ultra-clean, high-contrast monochrome dark mode with warm amber/orange highlights and an off-white dialog system.

```
 [ #121418 ]  Background Dark       (Global Scaffold)
 [ #1A1D24 ]  Surface Dark          (Cards, Keypad Keys, Bars)
 [ #222630 ]  Surface Elevated      (Active Key Feedback, Modals)
 [ #2A2E39 ]  Border Subtle         (1px Structural Outlines)
 [ #282828 ]  Border Charcoal       (Dividers & Inactive Grids)
 [ #E5A93C ]  Accent Amber          (Target '?' Box, Active Level)
 [ #F37A1F ]  Accent Orange         (PRO Crown Badge, High-CTA)
 [ #FFFFFF ]  Text Pure White       (Headers, Primary Digits)
 [ #8C93A8 ]  Text Muted            (Secondary Labels, Padlocks)
 [ #F5F6F8 ]  Modal High-Contrast   (Help Dialog Light Surface)
 [ #121418 ]  Modal Text Dark       (Dark Text on Light Dialog)
 [ #E74C3C ]  Error Red             (Input Shake & Failures)
 [ #2ECC71 ]  Success Green         (Checkmarks & Solved Badges)
```

#### Detailed Color Token Table

| Token Identifier | Hex Code | Flutter Constant (`GameTheme`) | UI Usage & Semantic Role |
|:---|:---|:---|:---|
| `backgroundDark` | `#121418` | `Color(0xFF121418)` | Global background for all screens and scaffold views |
| `surfaceDark` | `#1A1D24` | `Color(0xFF1A1D24)` | Card surfaces, virtual keypad tiles, top app bar |
| `surfaceElevated`| `#222630` | `Color(0xFF222630)` | Active pressed tiles, floating card elevation |
| `borderSubtle` | `#2A2E39` | `Color(0xFF2A2E39)` | 1px border on cards, level containers, and keypad |
| `borderCharcoal`| `#282828` | `Color(0xFF282828)` | Divider lines, inactive borders |
| `accentAmber` | `#E5A93C` | `Color(0xFFE5A93C)` | Current level border, target question mark `?` node |
| `accentOrange` | `#F37A1F` | `Color(0xFFF37A1F)` | PRO VIP crown badge, primary interactive actions |
| `textWhite` | `#FFFFFF` | `Color(0xFFFFFFFF)` | Primary titles, keypad numbers, high-contrast labels |
| `textMuted` | `#8C93A8` | `Color(0xFF8C93A8)` | Subtitles, disabled states, locked level indicators |
| `modalSurface` | `#F5F6F8` | `Color(0xFFF5F6F8)` | High-contrast "Need Help?" popup background |
| `modalTextDark` | `#121418` | `Color(0xFF121418)` | High-contrast black typography on modal popups |
| `modalTextMuted`| `#4A5060` | `Color(0xFF4A5060)` | Secondary explanations in high-contrast modals |
| `errorRed` | `#E74C3C` | `Color(0xFFE74C3C)` | Input validation shake outline, delete warning |
| `successGreen` | `#2ECC71` | `Color(0xFF2ECC71)` | Solved level checkmarks, progression confirm |

### Typography Hierarchy & Letter Tracking

The interface utilizes clean, geometric sans-serif typefaces (Roboto on Android, San Francisco on iOS). Wide letter-spacing (tracking) gives the typography a refined, scholarly architectural feel.

| Element | Size | Weight | Tracking (Letter Spacing) | Color Token |
|:---|:---|:---|:---|:---|
| **App Title** (`MATH RIDDLES`) | `32sp` | Bold (700) | `4.0px` | `textWhite` |
| **Section Header** (`SETTINGS`, `LEVEL SELECT`) | `18sp` | SemiBold (600) | `2.5px` | `textWhite` |
| **Hero Quote** | `13sp` | Light (300) | `0.5px` (Italic) | `textMuted` |
| **Menu Action Buttons** (`RIDDLE`, etc.) | `16sp` | SemiBold (600) | `2.0px` | `textWhite` |
| **Keypad Digits** (`0`â€“`9`, `ENTER`) | `22sp` | Medium (500) | `1.0px` | `textWhite` |
| **Level Indicator & Timer** (`04:59`) | `16sp` | Bold (700) | `1.5px` | `textWhite` / `accentAmber` |
| **Level Grid Tiles** (`1`â€“`20`) | `18sp` | SemiBold (600) | `0.0px` | `textWhite` / `textMuted` |
| **Modal Headline** (`Need Help?`) | `22sp` | Bold (700) | `1.0px` | `modalTextDark` |

### UI Component Specifications & ASCII Wireframes

#### Virtual Keypad Component Specifications
* **Keypad Grid:** 4-row layout anchored to bottom screen edge.
* **Row 1:** `1`, `2`, `3`
* **Row 2:** `4`, `5`, `6`
* **Row 3:** `7`, `8`, `9`
* **Row 4:** `âœ•` (Clear/Delete), `0`, `ENTER` (Submit)
* **Touch Target Height:** Uniform `54dp` per key with `8dp` inter-key spacing.
* **Key Borders:** `1px` stroke, `Color(0xFF2A2E39)`, border radius `10dp`.
* **Haptic Profile:** Light impact on key press, medium on delete, heavy triple on error shake, heavy double on success.

```
       â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
       â”‚    1     â”‚    2     â”‚    3     â”‚
       â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
       â”‚    4     â”‚    5     â”‚    6     â”‚
       â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
       â”‚    7     â”‚    8     â”‚    9     â”‚
       â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
       â”‚  âœ• DEL   â”‚    0     â”‚  ENTER â†µ â”‚
       â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”´â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”´â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

#### High-Contrast "Need Help?" Modal Specifications
* **Scrim Overlay:** Dark matte backdrop with 80% opacity (`#CC000000`).
* **Modal Dialog Box:** High-contrast off-white container (`#F5F6F8`), corner radius `20dp`, padding `24dp`.
* **Action Buttons:** Contained dark pill rows (`#121418` fill with `#FFFFFF` text) ensuring maximum visual affordance.

```
 â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
 â•‘                [ðŸ’¡ Need Help?]                â•‘
 â•‘                                               â•‘
 â•‘   Choose an option to reveal clues or unlock  â•‘
 â•‘   the mathematical solution.                  â•‘
 â•‘                                               â•‘
 â•‘  â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”  â•‘
 â•‘  â”‚ â–¶ Watch Ad for Hint                    â”‚  â•‘
 â•‘  â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜  â•‘
 â•‘  â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”  â•‘
 â•‘  â”‚ ðŸ‘‘ Watch Ad for Solution OR Be Premium  â”‚  â•‘
 â•‘  â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜  â•‘
 â•‘                                               â•‘
 â•‘                [ No thanks ]                  â•‘
 â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
```

### Animation Choreography & Haptics

1. **Target Node Idle Pulse:**
   * **Target:** The missing value indicator (`?`) on the geometric canvas.
   * **Animation:** Scale animation from `1.0` to `1.08` and opacity from `0.85` to `1.0`.
   * **Duration:** `1400ms` with `Curves.easeInOut`, reversing indefinitely.
2. **Input Error Shake:**
   * **Trigger:** Incorrect value submitted via `ENTER`.
   * **Animation:** Horizontal translation offset `[-12, 12, -8, 8, -4, 4, 0]`.
   * **Duration:** `450ms` with `Curves.easeOut`.
   * **Visual:** Input container outline transitions from `#2A2E39` to `#E74C3C` (Error Red).
3. **Level Clear Success Dialog:**
   * **Trigger:** Exact match with `correctAnswer`.
   * **Animation:** Fade-in and scale-up from `0.9` to `1.0` with `Curves.elasticOut`.
   * **Haptics:** Success vibration notification.

---

