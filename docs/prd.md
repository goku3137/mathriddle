# SMATH – Product Requirements Document (PRD)

> **Document Type:** Production Product Requirements Document (PRD)  
> **Product Name:** SMATH – Math Riddles & Mind Logic  
> **Package ID:** `com.valcire.mathriddle`  
> **Target SDK:** Flutter 3.27+ / Dart 3.6+  
> **Target Platforms:** Android (API 26–36) & iOS (iOS 14.0+)  
> **Visual Identity:** Minimalist Deep Dark Mode (`#121418` / `#1A1D24`) with Warm Amber Accents (`#E5A93C` / `#F37A1F`)  

---

## 1. Executive Summary & Product Vision

**SMATH (Math Riddles & Mind Logic)** is a distraction-free, minimalist mathematical brain-training mobile application engineered for pure intellectual engagement. Rejecting intrusive paywalls, cartoon mascots, gambling mechanics, and ad fatigue, SMATH delivers a focused learning and puzzle-solving experience.

The core gameplay centers on 500 handcrafted and procedurally generated mathematical riddles, 12 smart progressive challenge categories, and a 14-lesson interactive Math Academy. The entire experience is powered by an inbuilt dark virtual numeric keypad (bypassing native OS keyboards), vector canvas geometry via `CustomPainter`, reactive state management via Riverpod, and offline-first HMAC data persistence.

---

## 2. Core Product Pillars

1. **Pure Intellect & Minimalist Design:** Clean typographic interfaces, muted dark surfaces, and distraction-free puzzle presentation without cartoon mascots or coin casinos.
2. **Dedicated Virtual Keypad:** Zero input latency with tactile numeric keys (`0–9`, `DEL`, `ENTER`) directly in-app, suppressing OS soft keyboard jumps and layout disruption.
3. **Continuous Smart Progression:** Challenges start with accessible single-digit calculations and dynamically adapt to 2-digit and 3-digit problems based on cumulative correct answers (20 for Tier 1, 40 for Tier 2) and accuracy thresholds.
4. **Interactive Conceptual Learning:** The Math Academy pairs theory with visual interactive sandboxes (modular clocks, balance scales, binary bit flips, fraction bars) and mastery quizzes.
5. **Offline-First & Security Hardened:** 100% playable without network connectivity. Local game state is sealed with cryptographic HMAC-SHA256 checksums to safeguard progress.

---

## 3. Product Architecture & Features

### 3.1 Riddle Campaign (500 Mathematical Levels)
* **Handcrafted Foundational Levels (1–20):** 20 authored lateral logic puzzles testing arithmetic operator shifts, Pythagorean geometry, concentric doubling, matrix determinants, and prime sequences.
* **Procedural Scalable Levels (21–500):** Generated across 14 mathematical categories (BODMAS, Algebra, Number Series, Modular Arithmetic, Triangular Geometry, Matrix Grids, Percentages, Exponents, and Prime Logic) with deterministic seeding.
* **Grand Singularity Finale (Level 500):** Multi-stage composite master riddle serving as the ultimate campaign milestone.
* **Pack Organization:** Levels are organized into 10 collapsible packs of 50 levels (Levels 1–50, 51–100, ..., 451–500).
* **Memory Management:** Scalable level repository leverages an LRU cache (capacity 50) and lazy-loading to keep memory consumption minimal on low-end devices.
* **Sequential Progression:** Level 1 is unlocked initially. Level $N$ unlocks strictly upon successfully solving Level $N-1$.

### 3.2 Smart Progressive Challenges (12 Categories)
* **12 Dedicated Categories:**
  1. *Addition* – Fast mental summation
  2. *Subtraction* – Difference calculation
  3. *Multiplication* – Mental times tables
  4. *Division* – Exact quotient calculation
  5. *Powers & Roots* – Squares, cubes, and square roots
  6. *Percentages* – Mental fractions and discounts
  7. *Number Sequences* – Next number in series
  8. *Missing Number* – Algebraic placeholder deduction
  9. *Order of Operations* – BODMAS / PEMDAS precedence
  10. *Lateral Operators* – Custom functional transformations
  11. *Math Tricks* – Shortcut arithmetic techniques
  12. *Mixed Challenge* – Grand synthesis combining all mechanics
* **3-Tier Dynamic Progression:**
  * **Tier 0 (Beginner):** 1-digit numbers, accessible for all players.
  * **Tier 1 (Intermediate):** 2-digit numbers, unlocked at **20 cumulative solved answers** with $\ge 60\%$ accuracy.
  * **Tier 2 (Advanced):** 3-digit numbers and composite expressions, unlocked at **40 cumulative solved answers** with $\ge 65\%$ accuracy.
* **Continuous Non-Terminating Runs:** Mistake submissions do not abruptly terminate gameplay. A compact 1.5-second inline feedback overlay displays the correct answer and a one-line explanation before auto-advancing (or allowing instant tap-to-continue).
* **Dynamic Achievement Badges:**
  - *Newbie* (0–9 solved)
  - *Beginner* (10–24 solved)
  - *Skilled* (25–49 solved)
  - *Expert* (50–99 solved)
  - *Master* (100–199 solved)
  - *Grandmaster* (200+ solved)
  All badges follow a unified amber-gold achievement styling to maintain visual consistency.

### 3.3 Interactive Math Academy (14 Lessons)
* **Curriculum Structure:**
  * **Chapter 1: Foundational Arithmetic** (Order of Operations, Mental Multiplication, Mental Division, Fast Percentages, Square & Cube Roots)
  * **Chapter 2: Pattern Recognition & Algebra** (Arithmetic Sequences, Geometric Sequences, Algebraic Isolation, Modular Arithmetic)
  * **Chapter 3: Advanced Geometry & Lateral Logic** (Pythagorean Theorem, Matrix Determinants, Lateral Operator Shifts, Base Number Systems)
* **Interactive Sandboxes:**
  - *Balance Scale:* Drag-free algebraic balance demonstrating equation equivalence.
  - *Clock Modular Wheel:* Interactive dial visualizing wrap-around modulo arithmetic.
  - *Binary Bit-Flipper:* Interactive toggle bits demonstrating base-2 positional notation.
  - *Fraction & Percentage Visualizer:* Dynamic area-fill bar.
* **Mastery Practice Tests:** Graded multiple-choice question testing the core lesson concept. Solving awards **+50 PTS** (claimed once per lesson).

### 3.4 Hearts & Energy Economy
* **Capacity:** 5 maximum hearts (`❤️ 5`).
* **Consumption:** Incorrect submissions in Riddle gameplay consume 1 heart. Correct answers consume 0 hearts.
* **Refill Mechanism:** Automatically regenerates 1 heart every **20 minutes** (1200 seconds).
* **Offline Delta Calculation:** Heart recovery accurately accounts for background time elapsed between app launches.
* **Out of Hearts State:** Submissions pause at 0 hearts. Players can wait for the timer, watch a rewarded ad (full 5 hearts refill), or upgrade to Premium for **Unlimited Hearts ($\infty$)**.

### 3.5 Scoring Engine & Point Economy
* **Riddle Campaign:** +5 PTS base for early levels, escalating by +10 PTS for every 10 levels completed (e.g., +15 PTS for Levels 11–20, +25 PTS for Levels 21–30).
* **Learn Academy:** +50 PTS for each mastered lesson practice quiz.
* **Challenges:** +3 PTS for each correctly solved challenge question.
* **Anti-Cheat & Idempotency:** Points are awarded exactly once per solved item. Replays or duplicates do not inflate score. Total points are clamped against maximum theoretical ceilings.

### 3.6 Audio & Haptics Engine
* **Sound Effects:** Calibrated sound effects for tap, correct answer, error shake, heart loss, and level clear.
* **Granular Volume:** Interactive volume slider (0% to 100%) and instant sound toggle in Settings.
* **Haptics:** Light vibration on keypad taps, double pulse on success, and triple vibration on invalid submissions.

---

## 4. Monetization & In-App Purchases

* **Free Tier:** Complete access to all 500 riddles, 12 challenges, and 14 academy lessons. Non-intrusive interstitial ads appear strictly after every 3rd completed level with a 60-second cooldown. Rewarded ads are 100% opt-in for hints and heart refills.
* **In-App Purchases (Google Play / Apple StoreKit):**
  1. *Remove Ads* (₹49 / $0.99) – Permanent removal of interstitials.
  2. *Monthly Premium* (₹99/mo / $1.99/mo) – Unlimited Hearts, zero ads, instant hints, and solutions.
  3. *Lifetime VIP* (₹199 / $4.99) – Permanent Unlimited Hearts, instant solutions, offline unlocks, and PRO badge.
* **Privacy & Consent:** Full compliance with Google UMP for GDPR/CCPA consent.

---

## 5. Security & Technical Architecture

* **Framework:** Flutter 3.27+ with Dart 3.6+.
* **State Management:** Riverpod 3 with immutable state notifiers and dependency injection.
* **Offline Persistence:** `SharedPreferences` backed by HMAC-SHA256 signature verification to prevent file tampering and score manipulation.
* **Testing & Quality:** Zero static analysis warnings (`flutter analyze --no-pub`), comprehensive unit and widget test suite covering mathematical validity, scoring invariants, energy mechanics, and UI responsiveness.
