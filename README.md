# SMATH – Math Riddles & Mind Logic

> **Production-Grade Flutter Math Brain-Training Application**  
> **Package ID:** `com.valcire.mathriddle`  
> **Target SDK:** Flutter 3.27+ / Dart 3.6+  
> **Target Platforms:** Android (API 26+) & iOS (iOS 14.0+)  
> **Architecture:** Feature-Based Modular Architecture with Riverpod 3 State Management

---

## Overview

**SMATH (Math Riddles & Mind Logic)** is an ultra-minimalist, distraction-free brain-training game engineered for pure intellectual engagement. Stripping away cartoon characters, coin economies, and intrusive popups, SMATH delivers handcrafted mathematical and lateral-logic riddles across geometric figures, numeric matrices, algebraic sequences, and real-time timed challenges.

The application operates on an **offline-first** privacy standard with zero telemetry, reactive state management using **Riverpod**, vector-based rendering via **CustomPainter**, and an **inbuilt virtual numeric keypad** that bypasses operating-system keyboards for fluid, one-handed mobile control.

---

## Key Features

1. **500 Mathematical Riddles (Hybrid Campaign):**
   - 80 handcrafted milestone levels distributed across all 10 progression packs.
   - 420 deterministic procedural levels spanning 14 mathematical categories with LRU memory caching and zero duplicate questions.
   - Strict progressive difficulty with 0 geometry in Levels 1–150 and Grand Singularity finale at Level 500.

2. **Smart Progressive Challenges (12 Categories):**
   - 12 arithmetic and lateral categories (Addition, Subtraction, Multiplication, Division, Powers, Percentages, Sequences, Missing Numbers, BODMAS, Lateral Operators, Math Tricks, Mixed Challenge).
   - Dynamic 3-tier difficulty progression (1-digit → 2-digit → 3-digit) unlocking after cumulative correct answers.
   - Non-terminating continuous sessions with compact inline feedback overlays.
   - Dynamic Achievement Badges: Newbie → Beginner → Skilled → Expert → Master → Grandmaster.
   - Clean UTF-8 math typography and universal geometric symbols for custom operators.

3. **Interactive Math Academy (Candy Crush-Inspired Adventure):**
   - 36 comprehensive curriculum lessons across 6 progressive stages (Absolute Beginner → Basic Math → Intermediate Math → Advanced Thinking → Mathematical Logic & Cryptarithms → Master Competition Math).
   - Vertically scrolling adventure progression map with smooth winding Bézier paths, milestone stage portals, and pulsing active nodes.
   - 8-step readability-first pedagogical breakdown inside lessons with real-world examples and common mistake alerts.
   - Graded 4-option practice quizzes awarding +50 points upon mastery with step-by-step feedback and retry mechanism.

4. **Robust Economy & Audio System:**
   - 5-heart energy system refilling every 20 minutes (with optional Unlimited Hearts via Shop).
   - Granular scoring system: +5 PTS (1–10), +15 PTS (+10 per 10 levels), +50 PTS (Learn Mode), +3 PTS (Challenge).
   - Responsive scoring rules modal with two-tier non-overflowing cards.
   - Audio feedback suite powered by `audioplayers` with granular volume control and instant mute toggle in Settings.
   - Google Play Store in-app rating flow for `com.valcire.mathriddle`.

---

## Feature-Based Codebase Architecture

```
lib/
├── core/
│   ├── domain/               # Pure business logic (energy_rules.dart, scoring_rules.dart)
│   ├── services/             # Peripheral services (sound, billing, security, store)
│   ├── theme/                # Centralized design tokens (colors, typography, spacing)
│   └── widgets/              # Reusable shared UI components (keypad, hearts, score badge)
│
├── features/
│   ├── riddles/              # 500 Levels & Riddle Gameplay
│   │   ├── controllers/      # GameController & Riddle state
│   │   ├── data/             # Handcrafted levels & procedural generators
│   │   ├── models/           # LevelModel
│   │   ├── repositories/     # ILevelRepository & ScalableLevelRepository
│   │   ├── screens/          # RiddleScreen, LevelsScreen
│   │   └── widgets/          # Canvas painter, out-of-hearts modal, cleared modal
│   │
│   ├── challenges/           # 12 Arithmetic & Logic Challenge Categories
│   │   ├── data/             # Category definitions & item banks
│   │   ├── models/           # Challenge models & Badge progression
│   │   ├── services/         # Procedural challenge generators
│   │   ├── screens/          # ChallengeScreen, ChallengePlayScreen
│   │   └── widgets/          # Timer bar, question card, feedback overlay
│   │
│   ├── learning/             # Interactive Math Academy & Curriculum
│   │   ├── data/             # Modular curriculum chapters
│   │   ├── models/           # LessonModel
│   │   ├── screens/          # LearnScreen, LessonDetailScreen
│   │   └── widgets/          # Stepper, practice card, interactive sandboxes
│   │
│   ├── settings/             # User Settings & Monetization
│   │   ├── screens/          # SettingsScreen, ShopScreen
│   │   └── widgets/          # Confirmation dialogs, legal modals
│   │
│   └── home/                 # Main Dashboard & Navigation
│       ├── screens/          # HomeScreen
│       └── widgets/          # Rate dialog, menu action buttons
```

---

## Detailed Documentation

For comprehensive specifications, design guidelines, and architectural deep-dives, see the documentation in `docs/`:

- [Product Requirements Document (PRD)](docs/prd.md)
- [Design System & UI Standards](docs/design_system.md)
- [Screen Architecture & Puzzle Engine](docs/architecture.md)
- [Monetization & In-App Purchases](docs/monetization.md)
- [Learning Academy Curriculum & Syllabus](docs/SMATH_LEARNING_CURRICULUM.md)
- [Learning Section Adventure UI Report](docs/SMATH_LEARNING_UI_REPORT.md)
- [500 Riddle Campaign Audit Report](docs/SMATH_RIDDLE_CONTENT_AUDIT.md)
- [Code Quality & Architecture Audit](docs/SMATH_CODE_QUALITY_REPORT.md)
- [Comprehensive Application Audit Report](docs/SMATH_FULL_AUDIT_REPORT.md)

---

## Development & Testing

### Static Analysis
```bash
flutter analyze --no-pub
```

### Running Test Suites
```bash
flutter test
```
