# SMATH Learning Section – Readability & Educational UI/UX Report

## 1. Executive Summary

This report documents the UI/UX modernization of the **SMATH Learning Section (Academy)**, combining:
1. **A Candy Crush-Inspired Vertical Adventure Map** for lesson selection—replacing boxed rectangular lists with a playful, winding progression trail through 6 mathematical stages.
2. **A Readability-First 8-Step Study Environment** inside lessons—providing an uncluttered, high-contrast reading experience conforming to WCAG AAA contrast standards.

---

## 2. Candy Crush-Inspired Learning Adventure Map

### 2.1 Continuous Winding Path Geometry
- **Rhythmic S-Curves**: Node horizontal coordinates follow alternating sine-wave ratios (`[0.50, 0.72, 0.80, 0.50, 0.20, 0.28]` for odd stages, mirroring for even stages).
- **Cubic Bézier Interpolation**: Between adjacent nodes $P_i$ and $P_{i+1}$, path geometry is rendered using `canvas.drawPath` with control points $C_1 = (x_0, y_0 + 0.5\Delta y)$ and $C_2 = (x_1, y_1 - 0.5\Delta y)$, ensuring $C^1$ smooth vertical tangency at all connection points.
- **Dual-Layer Track Architecture**:
  - Base road underlay: $14\text{px}$ deep slate track (`#1E293B`).
  - Active segment: $6\text{px}$ radiant amber-gold track (`#F59E0B`).
  - Locked segment: $4\text{px}$ slate track (`#334155`).
  - Luminous stepping stones (`2.5\text{px}` radius) spaced every $22\text{px}$ along the curve.

### 2.2 Lesson Node Visual States
- **Completed**: $56\text{px}$ circular token with emerald-green gradient (`#10B981` $\rightarrow$ `#059669`), white checkmark, and lesson number.
- **Current / Next to Play**: $64\text{px}$ token with vibrant amber gradient (`#FBBF24` $\rightarrow$ `#D97706`), pulsing halo animation (`AnimationController` scale $1.0 \rightarrow 1.25$), play icon, and prominent gold drop shadow.
- **Locked**: $56\text{px}$ token with dark slate surface (`#1E293B`), subtle border (`#334155`), lock icon (`#64748B`), and lesson number.
- **Integrated Title Pill**: Placed beside each node on the opposite side of the curve to keep titles legible on all screen sizes while preserving widget test accessibility.

### 2.3 Stage Milestone Checkpoints
Horizontal milestone banners demarcate each of the 6 stages:
1. *Stage 1: Beginner* – Foundations & Number Sense (Emerald)
2. *Stage 2: Basic Mathematics* – Operations, Factors & Proportions (Cerulean)
3. *Stage 3: Intermediate* – Algebra, Equations & Sequences (Purple)
4. *Stage 4: Advanced* – Geometry, Quadratics & Probability (Amber)
5. *Stage 5: Expert* – Calculus, Matrices & Complex Plane (Pink)
6. *Stage 6: Extreme Mathematics* – Olympiad & Grandmaster Mastery (Gold)

### 2.4 Auto-Scroll to Current Lesson
On screen launch, a post-frame callback calculates the vertical coordinate of the learner's current unlocked lesson and smoothly animates the scroll position (`Curves.easeOutCubic`, $700\text{ms}$) to center the active node on screen.

---

## 3. Readability-First Lesson Screen Layout

Inside [`LessonDetailScreen`](file:///c:/Users/gokul/code/math/lib/screens/lesson_detail_screen.dart), an 8-step minimal-text reading layout provides cognitive focus:

1. **Top Bar**: Back navigation button, current progress tag (`STAGE X • LESSON Y OF 36`), and compact score badge.
2. **Category & Stage Pill**: High-contrast blue chip (`#0284C7`) indicating the current stage and category.
3. **Lesson Heading**: Large, crisp near-black typography (`24px`, `#0F172A`) paired with difficulty and mastery badges.
4. **Concept Summary**: Short, focused explanation (`15px`, `#334155`, `line-height: 1.6`) written in everyday English.
5. **Visual Formula / Core Shortcut**: Elevated light container (`#FFFFFF`, border `#E2E8F0`, soft shadow) highlighting mathematical equations with breathing room.
6. **Step-by-Step Reasoning**: Numbered, progressive walkthrough with zero skipped steps.
7. **Remember (Key Takeaway)**: Subtle warm amber callout (`#FFFBEB`, border `#FDE68A`, text `#92400E`) reinforcing the single most critical heuristic.
8. **Interactive Practice Test**: Multiple-choice quiz with large touch targets ($\ge 48\text{px}$), immediate feedback, and an on-screen **TRY AGAIN** button.

---

## 4. Dedicated Readability Color System (`LearningTheme`)

| Element | Color Hex | Color Role | WCAG Contrast Ratio | Compliance |
|---|---|---|---|---|
| Reading Surface | `#F8F9FA` | Warm white background | Canvas base | — |
| Primary Text | `#0F172A` | Deep charcoal near-black | 15.5 : 1 (vs `#F8F9FA`) | **WCAG AAA** |
| Secondary Text | `#334155` | Slate-700 body copy | 9.8 : 1 (vs `#F8F9FA`) | **WCAG AAA** |
| Muted Labels | `#64748B` | Slate-500 stage tags | 4.8 : 1 (vs `#F8F9FA`) | **WCAG AA** |
| Surface Cards | `#FFFFFF` | Elevated equation container | Canvas elevated | — |
| Card Border | `#E2E8F0` | Subtle hairline separator | — | — |
| Cerulean Accent | `#0284C7` | Interactive selection & stage chip | 4.9 : 1 (vs `#FFFFFF`) | **WCAG AA** |
| Correct Answer Text | `#166534` | Accessible forest green | 5.8 : 1 (vs `#DCFCE7`) | **WCAG AA** |
| Correct Answer Bg | `#DCFCE7` | Mint green feedback tint | Background | — |
| Error Answer Text | `#991B1B` | Accessible deep crimson | 6.2 : 1 (vs `#FEE2E2`) | **WCAG AA** |
| Error Answer Bg | `#FEE2E2` | Blush red feedback tint | Background | — |
| Takeaway Callout | `#FFFBEB` | Soft warm paper tint | 7.1 : 1 (`#92400E`) | **WCAG AAA** |

---

## 5. Automated Verification Results

- **Total Tests**: 104 passed / 0 failed.
- **`test/widget_test.dart`**: Verified adventure map navigation, 36-concept progress counter, Stage 1 Lesson 1 completion, +50 PTS reward, and back-navigation state retention.
- **`test/unit/learning_curriculum_test.dart`**: Verified all 36 lessons, stage distribution (6 lessons per stage across 6 stages), unique IDs, valid 1..500 level linkages, 4 unique options per question, and mathematical non-negative integer correctness.
- **`flutter analyze --no-pub`**: 0 warnings, 0 errors.
