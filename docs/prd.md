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

The core gameplay centers on 500 mathematical riddles (hybrid handcrafted and deterministic procedural), 12 smart progressive challenge categories, and a 36-lesson interactive Math Academy featuring a Candy Crush-inspired adventure progression map. The entire experience is powered by an inbuilt dark virtual numeric keypad (bypassing native OS keyboards), vector canvas geometry via `CustomPainter`, reactive state management via Riverpod, and offline-first HMAC data persistence.

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
* **Hybrid Scalable Engine:** 80 premium handcrafted milestone levels balanced across all 10 progression packs, combined with 420 deterministic procedural levels spanning 14 mathematical categories.
* **Curated Difficulty & Zero Geometry in Levels 1–150:** Levels 1–150 focus exclusively on foundational arithmetic, operator shifts, sequence deduction, and numerical balances; geometry puzzles are introduced progressively only from Level 151 onward.
* **Grand Singularity Finale (Level 500):** Multi-stage composite master riddle serving as the ultimate campaign milestone.
* **Pack Organization:** Levels are organized into 10 collapsible packs of 50 levels (Levels 1–50, 51–100, ..., 451–500).
* **Memory Management:** Scalable level repository leverages an LRU cache (capacity 50) and lazy-loading to keep memory consumption minimal on low-end devices.
* **Sequential Progression:** Level 1 is unlocked initially. Level $N$ unlocks strictly upon successfully solving Level $N-1$. Zero duplicate questions across all 500 levels.

### 3.2 Smart Progressive Challenges (12 Categories)
* **12 Dedicated Categories:**
  1. *Addition* – Fast mental summation
  2. *Subtraction* – Difference calculation
  3. *Multiplication* – Mental times tables
  4. *Division* – Exact quotient calculation
  5. *Squares & Powers* – Squares, cubes, and power exponents
  6. *Percentages & Rates* – Mental fractions, rates, and discounts
  7. *Sequences & Patterns* – Next number in arithmetic, geometric & Fibonacci series
  8. *Missing Number Puzzles* – Algebraic placeholder deduction
  9. *BODMAS Precedence* – Order of operations precedence traps
  10. *Lateral Operators* – Custom functional transformations with universal geometric symbols (`⊕`, `★`, `▲`, `⊗`, `⊙`, `⊘`, `◆`, `✦`, `∇`, `◎`, `◈`, `❖`, `△`, `◇`, `⬡`)
  11. *Speed Math Tricks* – Shortcut arithmetic, handshake formulas, and clock angles
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

### 3.3 Interactive Math Academy (36 Lessons Across 6 Stages)
* **Candy Crush-Inspired Adventure Progression Map:**
  - Replaces boxed card lists with a continuous, vertically scrolling progression path.
  - Alternating nodes connected by smooth quadratic Bézier curves with dual-layer rendering (slate road underlay, glowing amber unlocked segment, dashed/slate locked trail).
  - Node States:
    - *Completed:* Emerald green token with white checkmark and lesson number.
    - *Active / Next to Play:* Enlarged token with vibrant amber gradient, pulsing halo animation, and play icon.
    - *Locked:* Muted dark slate token with padlock icon.
  - Milestone stage portals marking entry into each of the 6 distinct curriculum stages.
  - Auto-scroll on launch smoothly focuses the learner on their current active lesson.
* **Curriculum Structure Across 6 Stages:**
  * **Stage 1: Absolute Beginner (Lessons 1–6)** – Number sense, place values, four operations, parity, fractions & decimals.
  * **Stage 2: Basic Mathematics (Lessons 7–12)** – Order of operations (BODMAS), factors, primes, divisibility, ratios, squares & roots.
  * **Stage 3: Intermediate Mathematics (Lessons 13–18)** – Integers, algebraic expressions, linear equations, arithmetic & geometric sequences, commercial interest, time-speed-distance.
  * **Stage 4: Advanced Mathematical Thinking (Lessons 19–24)** – Coordinate geometry, simultaneous equations, quadratics, exponents & logarithms, permutations & combinations, probability.
  * **Stage 5: Mathematical Logic & Cryptarithms (Lessons 25–30)** – Modular arithmetic, number bases (binary/hex), set theory & Venn diagrams, lateral operators, cryptarithmetic alphametics, mathematical induction.
  * **Stage 6: Master Competition & Olympiad Math (Lessons 31–36)** – Pigeonhole principle, Euclidean algorithm & modular inverses, Diophantine equations, geometric proofs, recurrence relations, extreme mathematical synthesis.
* **8-Step Readability-First Pedagogical Flow Inside Lessons:**
  1. *What You Will Learn:* 1–2 sentence non-intimidating overview.
  2. *Why This Matters:* Everyday relatable application (shopping, gaming, time, finance).
  3. *Core Rule / Formula:* High-contrast focal callout box.
  4. *Step-by-Step Method:* Numbered recipe with bite-sized steps.
  5. *Worked Example 1 (Simple):* Guided walkthrough with small numbers.
  6. *Worked Example 2 (Real-World / Riddle Level):* Practical problem connected to actual campaign riddle levels.
  7. *Common Pitfall to Avoid:* Red-accented warning addressing intuitive mistakes.
  8. *Practice Test & Mastery Quiz:* 4-option interactive quiz testing the concept with instant feedback and +50 PTS reward.

### 3.4 Hearts & Energy Economy
* **Capacity:** 5 maximum hearts (`❤️ 5`).
* **Consumption:** Incorrect submissions in Riddle gameplay consume 1 heart. Correct answers consume 0 hearts.
* **Refill Mechanism:** Automatically regenerates 1 heart every **20 minutes** (1200 seconds).
* **Offline Delta Calculation:** Heart recovery accurately accounts for background time elapsed between app launches.
* **Out of Hearts State:** Submissions pause at 0 hearts. Players can wait for the timer, watch a rewarded ad (full 5 hearts refill), or upgrade to Premium for **Unlimited Hearts ($\infty$)**.

### 3.5 Scoring Engine & Point Economy
* **Riddle Campaign:** +5 PTS base for early levels, escalating by +10 PTS for every 10 levels completed (e.g., +15 PTS for Levels 11–20, +25 PTS for Levels 21–30).
* **Learn Academy:** +50 PTS for each mastered lesson practice quiz (strictly single-claim per lesson).
* **Challenges:** +3 PTS for each correctly solved challenge question.
* **ScoreBadge Rules Modal:** Responsive, two-tiered card dialog with scrollable viewport that displays full scoring breakdown without horizontal or vertical RenderFlex overflow on any mobile screen width.
* **Anti-Cheat & Idempotency:** Points are awarded exactly once per solved item. Replays or duplicates do not inflate score. Total points are clamped against maximum theoretical ceilings.

### 3.6 Audio & Haptics Engine
* **Sound Effects:** Calibrated sound effects for tap, correct answer, error shake, heart loss, and level clear.
* **Granular Volume:** Interactive volume slider (0% to 100%) and instant sound toggle in Settings.
* **Haptics:** Light vibration on keypad taps, double pulse on success, and triple vibration on invalid submissions.

---

## 4. Monetization & In-App Purchases

* **Free Tier:** Complete access to all 500 riddles, 12 challenges, and 36 academy lessons. Non-intrusive interstitial ads appear strictly after every 9th completed riddle level ($N = 9, 18, 27, \dots$) with a strict 120-second cooldown. Zero mid-round challenge interruptions. Rewarded ads are 100% opt-in for hints and heart refills.
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
