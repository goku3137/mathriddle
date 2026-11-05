# Math Riddles & Mind Logic â€” Exhaustive Product & Technical Specification

> **Document Type:** Product Requirements Document (PRD) & Technical Specification Document (TSD)  
> **Version:** 2.19.0 (Production Release)  
> **Target Framework:** Flutter 3.27+ / 3.47+ (Dart 3.6+)  
> **Target Platforms:** Android (API 26â€“36) & iOS (iOS 14.0+)  
> **Visual Aesthetic:** Minimalist Deep Dark Mode (#121418 / #1A1D24) with Warm Amber Accents (#E5A93C / #F37A1F)  
> **Inspiration:** *Math | Riddles and Puzzle Game* by Black Games

---

## Executive Summary

**Math Riddles & Mind Logic** is an ultra-minimalist, distraction-free mobile logic puzzle game engineered for pure intellectual engagement. Stripping away cartoon characters, coin economies, and invasive full-screen popups, the game delivers handcrafted mathematical and lateral-logic riddles across geometric figures, numeric matrices, and algebraic sequences.

The application is architected around offline-first persistence, reactive state management using **Riverpod 3**, vector-based rendering via **CustomPainter**, and an **inbuilt virtual numeric keypad** that completely bypasses operating-system soft keyboards for tactile, one-handed mobile control.

---

## Table of Contents
1. [Core Concept & Product Vision](#1-core-concept--product-vision)
   - [Product Pillars & Core Values](#product-pillars--core-values)
   - [Lateral Logic Mathematical Philosophy](#lateral-logic-mathematical-philosophy)
   - [Target Audience & Player Personas](#target-audience--player-personas)
2. [Design System & UI Standards](#2-design-system--ui-standards)
   - [Color Palette & Hex Specifications](#color-palette--hex-specifications)
   - [Typography Hierarchy & Letter Tracking](#typography-hierarchy--letter-tracking)
   - [UI Component Specifications & ASCII Wireframes](#ui-component-specifications--ascii-wireframes)
   - [Animation Choreography & Haptics](#animation-choreography--haptics)
3. [Screen-by-Screen Architecture & User Flows](#3-screen-by-screen-architecture--user-flows)
   - [Global Screen Navigation State Diagram](#global-screen-navigation-state-diagram)
   - [Screen 1: Home Screen](#screen-1-home-screen)
   - [Screen 2: Settings Screen](#screen-2-settings-screen)
   - [Screen 3: Riddle Level Select (20-Container Grid)](#screen-3-riddle-level-select-20-container-grid)
   - [Screen 4: Question & Riddle Gameplay Screen (5-Min Timer & Keypad)](#screen-4-question--riddle-gameplay-screen)
   - [Screen 5: "Need Help?" Modal (High-Contrast Popup)](#screen-5-need-help-modal)
   - [Screen 6: Shop / Premium Subscription Screen](#screen-6-shop--premium-subscription-screen)
   - [Screen 7: Learn Screen (Mental Math Concepts)](#screen-7-learn-screen)
   - [Screen 8: Challenge Screen (Endless Speedrun Mode)](#screen-8-challenge-screen)
4. [Puzzle Engine & Level Data Model](#4-puzzle-engine--level-data-model)
   - [Data Schema (Dart Model)](#data-schema-dart-model)
   - [Vector Canvas Rendering Archetypes](#vector-canvas-rendering-archetypes)
   - [Complete 20-Level Mathematical Master Catalog](#complete-20-level-mathematical-master-catalog)
5. [Ad Strategy & Monetization Architecture](#5-ad-strategy--monetization-architecture)
   - [Ad Units, Frequency Caps & Lifecycle Triggers](#ad-units-frequency-caps--lifecycle-triggers)
   - [Rewarded Video Implementation Rules](#rewarded-video-implementation-rules)
   - [Interstitial Cadence & Suppression](#interstitial-cadence--suppression)
   - [GDPR / CCPA Privacy & Consent Protocols](#gdpr--ccpa-privacy--consent-protocols)
6. [In-App Purchases & Pricing Model](#6-in-app-purchases--pricing-model)
   - [Product Tiers & Multi-Currency Pricing](#product-tiers--multi-currency-pricing)
   - [Comprehensive Feature Matrix](#comprehensive-feature-matrix)
   - [Billing State Machine & Purchase Restoration](#billing-state-machine--purchase-restoration)
7. [Technical Architecture & State Management](#7-technical-architecture--state-management)
   - [Riverpod 3 Notifier State Lifecycle](#riverpod-3-notifier-state-lifecycle)
   - [Offline Persistence & SharedPreferences Schema](#offline-persistence--sharedpreferences-schema)
   - [Error Handling & Edge Cases](#error-handling--edge-cases)
8. [Setup, Build & Test Verification](#8-setup-build--test-verification)

---

## 1. Core Concept & Product Vision

### Product Pillars & Core Values

1. **Zero Distraction, Pure Intellect:**
   Eliminates all superfluous game mechanics: no spinning wheels, daily login streaks, cartoon mascots, or energy timers. The interface remains quiet, dark, and scholarly.
2. **Tactile Virtual Control (No OS Keyboard):**
   The operating system virtual keyboard is entirely suppressed. The gameplay canvas is paired with an inbuilt, custom-tuned dark numeric keypad with zero input latency and dedicated actions (`0-9`, `ENTER`, `âœ•` Clear, and `ðŸ’¡` Hint).
3. **Rigorous Lateral Logic:**
   Challenges test lateral arithmetic and spatial deduction rather than rote computational speed. Puzzles incorporate geometric patterns, matrix determinants, functional transforms, and progressive number sequences.
4. **100% Offline-Capable Core:**
   Every level, hint, explanation, and persistent state can be experienced entirely without an active internet connection.

```
       â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
       â”‚             CORE PRODUCT PILLARS                       â”‚
       â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
       â”‚ Pure Intellect  â”‚  Virtual Keypad  â”‚  Offline-First    â”‚
       â”‚ No cartoon UI   â”‚  No native soft  â”‚  100% playable    â”‚
       â”‚ No coin casino  â”‚  keyboard popups â”‚  without network  â”‚
       â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”´â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”´â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

### Lateral Logic Mathematical Philosophy

The aesthetic and intellectual spirit of the game is anchored to the quote rendered on the Home Screen:
> *â€œLogic is the anatomy of thought. Challenge your limits.â€*

Rather than testing conventional academic arithmetic, puzzles are grouped into three cognitive domains:
* **Functional Transforms:** Puzzles where the basic operator symbols ($+$, $\times$, $-$) indicate a custom hidden binary operation (e.g., $a \oplus b = a \cdot b + a$).
* **Spatial & Geometric Reasoning:** Geometric networks where peripheral nodes transmit values toward central target nodes via geometric relations (Pythagorean triples, radial sum rules, inscribed ratios).
* **Matrix Symmetries:** 2x2 and 3x3 grids where rows, columns, and diagonals maintain arithmetic parity or exponential progression.

### Target Audience & Player Personas

| Persona | Demographics | Motivation | Pain Point in Competing Apps |
|:---|:---|:---|:---|
| **The STEM Professional / Student** | Ages 18â€“35; Engineers, Developers, Competitive Exam Candidates | Enjoys rigorous mental challenges, problem-solving, and logic tests. | Hates childish graphics, forced tutorials, and excessive ads. |
| **The Commuter Thinker** | Ages 22â€“50; Daily transit commuters, busy professionals | Wants 3â€“5 minutes of focused mental workout between stations. | Frustrated by complex menu systems, heavy load times, and required internet. |
| **The Minimalist Puzzle Purist** | Ages 16â€“60; Sudoku, Chess, and Crossword players | Appreciates clean typographic design, dark themes, and quiet focus. | Annoyed by flashing microtransaction banners and coin-based hint economies. |

---

