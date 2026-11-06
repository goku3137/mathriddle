# SMATH – Design System & UI Specifications

> **Target Framework:** Flutter 3.27+ / Dart 3.6+  
> **Visual Identity:** Minimalist Scholarly Dark Mode  
> **Primary Colors:** Deep Carbon (`#121418`), Slate Surface (`#1A1D24`), Warm Amber (`#E5A93C`), Vivid Orange (`#F37A1F`)  

---

## 1. Color Palette & Token Definitions

SMATH employs a high-contrast dark palette engineered to minimize eye strain during extended problem solving while providing warm amber focal points.

```
 [ #121418 ]  Background Dark       (Scaffold background across all screens)
 [ #1A1D24 ]  Surface Dark          (Cards, keypad tiles, list containers)
 [ #222630 ]  Surface Elevated      (Active states, pressed tiles, modal backdrops)
 [ #2A2E39 ]  Border Subtle         (1px structural borders and dividers)
 [ #282828 ]  Border Charcoal       (Inactive borders and locked state frames)
 [ #E5A93C ]  Accent Amber          (Target '?' boxes, score pills, active level outlines)
 [ #F37A1F ]  Accent Orange         (PRO badge, call-to-action highlights)
 [ #FFFFFF ]  Text Pure White       (Primary headlines, keypad digits, active values)
 [ #8C93A8 ]  Text Muted            (Subtitles, explanations, secondary labels)
 [ #5A6275 ]  Text Dim              (Inactive hints, padlock indicators)
 [ #F5F6F8 ]  Modal Light Surface   (High-contrast help dialog surface)
 [ #121418 ]  Modal Text Dark       (Dark typography on light dialogs)
 [ #E74C3C ]  Error Red             (Input shake, wrong answer flash, heart loss)
 [ #2ECC71 ]  Success Green         (Solved checkmarks, success dialog badges)
```

### Flutter Token Mapping (`GameTheme`)

| Token Identifier | Hex Value | Flutter `Color` Value | Semantic Usage |
|:---|:---|:---|:---|
| `backgroundDark` | `#121418` | `Color(0xFF121418)` | Global scaffold background |
| `surfaceDark` | `#1A1D24` | `Color(0xFF1A1D24)` | Card backgrounds, keypad key default fill |
| `surfaceElevated` | `#222630` | `Color(0xFF222630)` | Pressed states, elevated bottom sheets |
| `borderSubtle` | `#2A2E39` | `Color(0xFF2A2E39)` | Outlines for keys, cards, and input containers |
| `borderCharcoal` | `#282828` | `Color(0xFF282828)` | Inactive grid lines, subtle dividers |
| `accentAmber` | `#E5A93C` | `Color(0xFFE5A93C)` | Active level borders, score highlights, target node |
| `accentOrange` | `#F37A1F` | `Color(0xFFF37A1F)` | PRO VIP badge, primary promotion accents |
| `textWhite` | `#FFFFFF` | `Color(0xFFFFFFFF)` | Primary digits, screen titles, active labels |
| `textLight` | `#D8DCE6` | `Color(0xFFD8DCE6)` | Secondary labels, descriptions |
| `textMuted` | `#8C93A8` | `Color(0xFF8C93A8)` | Subtitles, formulas, inactive status labels |
| `textDim` | `#5A6275` | `Color(0xFF5A6275)` | Padlocks, locked level numbers |
| `errorRed` | `#E74C3C` | `Color(0xFFE74C3C)` | Validation shake, incorrect answer indicator |
| `successGreen` | `#2ECC71` | `Color(0xFF2ECC71)` | Solved checkmarks, mastery badges |
| `modalSurface` | `#F5F6F8` | `Color(0xFFF5F6F8)` | High-contrast "Need Help?" modal container |
| `modalTextDark` | `#121418` | `Color(0xFF121418)` | High-contrast modal typography |

---

## 2. Typography Hierarchy & Spacing

SMATH utilizes modern geometric typography with deliberate tracking (letter spacing) to convey an architectural, scholarly feel.

| Role | Size | Weight | Tracking | Color Token |
|:---|:---:|:---:|:---:|:---|
| **App Title** (`MATH RIDDLES`) | `34sp` | Bold (800) | `2.0px` | `textWhite` |
| **Hero Quote** | `11sp` | Regular (400) | `0.4px` (Italic) | `textDim` |
| **Section Headers** (`SETTINGS`, `LEARN`) | `18sp` | SemiBold (600) | `2.0px` | `textWhite` |
| **Menu Action Buttons** (`RIDDLE`, `CHALLENGE`) | `16sp` | SemiBold (600) | `2.0px` | `textWhite` |
| **Keypad Digits** (`0–9`) | `24sp` | SemiBold (600) | `0.0px` | `textWhite` |
| **Timer Display** (`04:59`) | `16sp` | Bold (700) | `1.5px` | `textWhite` |
| **Level Grid Tiles** | `16sp` | SemiBold (600) | `0.0px` | `textWhite` / `textDim` |
| **Modal Headlines** (`Need Help?`) | `22sp` | Bold (700) | `0.5px` | `modalTextDark` |

---

## 3. UI Component Specifications

### 3.1 Inbuilt Virtual Numeric Keypad
* **Layout:** 4-row grid anchored to the screen bottom:
  * Row 1: `1`, `2`, `3`
  * Row 2: `4`, `5`, `6`
  * Row 3: `7`, `8`, `9`
  * Row 4: `DEL` (`✕`), `0`, `ENTER` (`↵`)
* **Key Dimensions:** Uniform `54dp` height per key, `8dp` inter-key spacing, `10dp` border radius.
* **Border & Fill:** Background `#1A1D24` with 1px border `#2A2E39`. Pressed fill `#222630`.
* **Zero Input Latency:** Suppresses OS soft keyboard completely. Includes a 50ms software debounce to avoid accidental double taps.

### 3.2 High-Contrast "Need Help?" Modal
* **Container:** `#F5F6F8` light surface with `20dp` rounded corners.
* **Scrim:** 80% dark backdrop (`#CC000000`).
* **Action Buttons:** Contained dark pill rows (`#121418` fill with `#FFFFFF` text) ensuring instant visibility and high contrast.

### 3.3 Top Header Cluster (Home Screen)
* Single horizontal row at top right:
  1. `HeartsIndicator` (`❤️ 5` or `❤️ 4 (18:22)` or `❤️ ∞`)
  2. `ScoreBadge` (`★ 125 PTS`)
  3. `HomeProPill` (`PRO` badge)
  4. `SettingsGear` (42x42dp touch target)
* Maintains a clean, aligned, un-cluttered header layout with zero horizontal overflow across all device viewports.

### 3.4 Progressive Challenge Cards
* **Surfaces:** Neutral dark background (`#1A1D24`) with subtle borders (`#2A2E39`).
* **Achievement Badges:** Unified amber-gold color palette across all categories (no jarring rainbow backgrounds). Badge progression updates dynamically based on cumulative correct answers.

---

## 4. Animation & Haptic Choreography

1. **Target Node Idle Pulse:**
   * Missing value indicator (`?`) gently pulses with a scale from `1.0` to `1.08` over `1400ms` with `Curves.easeInOut`, reversing continuously.
2. **Input Validation Error Shake:**
   * Incorrect answer triggers a horizontal shake offset `[-12, 12, -8, 8, -4, 4, 0]` over `450ms` with `Curves.easeOut`.
   * Input border transitions from `#2A2E39` to `#E74C3C` (Error Red).
   * Accompanied by a triple haptic vibration pulse.
3. **Level Cleared Celebration:**
   * Scale and fade animation (`Curves.elasticOut`) celebrating level completion.
   * Accompanied by a double haptic pulse and success audio chime.
4. **Smooth Timer Countdown:**
   * Elapsed-time driven updates avoiding high-frequency rebuilds while maintaining second-level accuracy.
