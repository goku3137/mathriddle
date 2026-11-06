# SMATH Learning Curriculum Architecture & Complete Syllabus

This document outlines the expanded 36-lesson progressive mathematics curriculum powering **SMATH Academy**. The curriculum takes learners from foundational number literacy (Stage 1: Absolute Beginner) to advanced Olympiad and modern mathematical research techniques (Stage 6: Extreme Mathematics).

---

## 1. Curriculum Design Principles

1. **Seamless Progression**: The curriculum is partitioned into 6 distinct stages containing 6 lessons each (36 lessons total).
2. **Pedagogical Empathy**: Every concept is explained without intimidation, starting with intuitive real-world metaphors (sharing candy, shopping discounts, clock cycles, balance scales).
3. **Linear Sequential Unlock System**:
   - Lesson 1 is immediately unlocked for all learners.
   - Lesson $k$ unlocks strictly upon completing Lesson $k-1$ and passing its interactive practice quiz.
   - Completed lessons remain permanently unlocked for review and revision.
   - Tapping a locked lesson informs the learner which prerequisite lesson must be completed.
4. **Strict Single-Reward Policy**:
   - Passing a lesson quiz awards **+50 Points** exactly once.
   - Duplicate rewards on review, retry, or restart are strictly prevented.
5. **Keypad & Answer Compatibility**:
   - Every practice quiz features 4 multiple-choice options with large touch targets ($\ge 48\text{px}$).
   - The correct answer is always a non-negative integer string for future keypad compatibility.
   - Every question includes hint text, step-by-step guidance, and targeted feedback for why specific wrong answers are incorrect.

---

## 2. Complete 36-Lesson Syllabus Across 6 Stages

### Stage 1 – Absolute Beginner
*Focus: Foundational number sense, place values, the four basic arithmetic operations, parity, and intuitive fractions.*

| # | Lesson ID | Title | Difficulty | Prerequisite | Core Concept / Practice Target | Linked Riddle Levels |
|---|---|---|---|---|---|---|
| 1 | `stage1_lesson1_place_values` | 1. Understanding Numbers & Place Values | Beginner | None (Unlocked) | Place values (100s, 10s, 1s); value of digit 5 in 752 is 50 | 1, 2, 3 |
| 2 | `stage1_lesson2_addition_subtraction` | 2. Addition, Subtraction & Comparing Numbers | Beginner | Lesson 1 | Combining & removing; 15 coins - 7 spent = 8 left | 4, 5, 6 |
| 3 | `stage1_lesson3_multiplication_tables` | 3. Multiplication & Times Tables | Beginner | Lesson 2 | Repeated addition & commutative rule; 7 boxes × 6 = 42 | 7, 8, 9 |
| 4 | `stage1_lesson4_division_remainders` | 4. Division, Equal Sharing & Remainders | Beginner | Lesson 3 | Equal grouping; 27 pencils ÷ 4 = 6 remainder 3 | 10, 11, 12 |
| 5 | `stage1_lesson5_odd_even_negatives` | 5. Even, Odd & Negative Numbers | Beginner | Lesson 4 | Parity rules (last digit 0, 2, 4, 6, 8) & values below 0; 48 is even | 13, 14, 15 |
| 6 | `stage1_lesson6_fractions_decimals_percents` | 6. Basic Fractions, Decimals & Percentages | Beginner | Lesson 5 | 1/4 = 0.25 = 25%; 25% of 80 is 20 | 16, 17, 18 |

---

### Stage 2 – Basic Mathematics
*Focus: Arithmetic precedence, number theory, fractions, proportions, and geometric powers.*

| # | Lesson ID | Title | Difficulty | Prerequisite | Core Concept / Practice Target | Linked Riddle Levels |
|---|---|---|---|---|---|---|
| 7 | `topic_pemdas` | 7. Order of Operations (BODMAS / PEMDAS) | Basic | Lesson 6 | Operator hierarchy: Brackets → Orders → ÷/× → +/-; 8 + 8÷4 + 8×2 - 4 = 22 | 1, 5, 12, 25, 50 |
| 8 | `stage2_lesson8_factors_primes` | 8. Factors, Multiples & Prime Numbers | Basic | Lesson 7 | Prime testing & divisibility rules; smallest prime > 20 is 23 | 19, 21, 27, 33 |
| 9 | `stage2_lesson9_fractions_operations` | 9. Working with Fractions & Decimals | Basic | Lesson 8 | Common denominators & fraction scaling; (1/2 + 1/4) of 40 = 30 | 22, 28, 45, 62 |
| 10 | `stage2_lesson10_ratios_proportions` | 10. Ratios, Proportions & Percent Change | Basic | Lesson 9 | Sum of parts & fair scaling; 60 split 2:3 gives Ben 36 coins | 30, 48, 70, 95 |
| 11 | `stage2_lesson11_averages_word_problems` | 11. Averages & Everyday Word Problems | Basic | Lesson 10 | Total Sum Rule: Total = Average × N; missing 4th number is 25 | 35, 52, 85, 110 |
| 12 | `stage2_lesson12_squares_roots_cubes` | 12. Squares, Square Roots & Cubes | Basic | Lesson 11 | Square areas, volume cubes, square roots; 3² + 4² = 25 | 14, 26, 60, 105 |

---

### Stage 3 – Intermediate Mathematics
*Focus: Variables, algebraic simplification, balance scales, progressions, index laws, and rates.*

| # | Lesson ID | Title | Difficulty | Prerequisite | Core Concept / Practice Target | Linked Riddle Levels |
|---|---|---|---|---|---|---|
| 13 | `stage3_lesson13_algebra_fundamentals` | 13. Algebra Fundamentals & Simplifying Expressions | Intermediate | Lesson 12 | Variables, expanding brackets, like terms; 3(2x-1) - 2x with x=4 is 13 | 40, 75, 120, 160 |
| 14 | `topic_equations` | 14. Solving Linear Equations (Balance Method) | Intermediate | Lesson 13 | Isolating x on balanced scales; 3x - 7 = 17 ⟹ x = 8 | 2, 16, 32, 64, 128 |
| 15 | `stage3_lesson15_inequalities` | 15. Simple Inequalities & Number Constraints | Intermediate | Lesson 14 | Boundary limits & sign reversal; largest integer for 4x + 5 < 29 is 5 | 55, 80, 135, 175 |
| 16 | `topic_sequences` | 16. Number Sequences: AP & GP | Intermediate | Lesson 15 | Common step d vs ratio r; 6th term of 2, 6, 18, 54... is 486 | 6, 18, 38, 72, 144 |
| 17 | `stage3_lesson17_exponents_powers` | 17. Exponents, Powers & Scientific Notation | Intermediate | Lesson 16 | Index laws (aᵐ × aⁿ = aᵐ⁺ⁿ, a⁰ = 1); (2³ × 2²) ÷ 2⁴ = 2 | 65, 90, 140, 180 |
| 18 | `topic_money` | 18. Rates, Speed, Distance & Work Problems | Intermediate | Lesson 17 | Distance = Speed × Time; 75 km/h for 4 hours = 300 km | 20, 42, 84, 168 |

---

### Stage 4 – Advanced Mathematics
*Focus: Simultaneous elimination, quadratic roots, coordinate geometry, Euclidean triangles, and combinatorics.*

| # | Lesson ID | Title | Difficulty | Prerequisite | Core Concept / Practice Target | Linked Riddle Levels |
|---|---|---|---|---|---|---|
| 19 | `topic_logic` | 19. Simultaneous Equations & Elimination | Advanced | Lesson 18 | Elimination method; 2x+y=11 & x+y=7 ⟹ x = 4 | 8, 24, 76, 155 |
| 20 | `stage4_lesson20_quadratic_factoring` | 20. Quadratic Equations & Factoring | Advanced | Lesson 19 | Difference of squares & Zero Product Rule; positive root of x² - 9 = 0 is 3 | 151, 165, 210, 280 |
| 21 | `stage4_lesson21_coordinate_geometry` | 21. Coordinate Geometry & Linear Slopes | Advanced | Lesson 20 | Rise over Run: m = (y2 - y1) / (x2 - x1); slope through (1, 3) and (3, 11) is 4 | 158, 185, 240, 310 |
| 22 | `topic_triangles` | 22. Angles, Triangles & Pythagorean Theorem | Advanced | Lesson 21 | Right triangle relationship a² + b² = c²; legs 9 & 12 ⟹ hypotenuse 15 | 152, 170, 225, 320 |
| 23 | `topic_circles` | 23. Circles, Overlaps, Area & Volume | Advanced | Lesson 22 | Area = πr², circumference = 2πr; circle with r = 7 has area 154 | 160, 205, 275, 350 |
| 24 | `stage4_lesson24_probability_combinatorics` | 24. Probability, Permutations & Combinations | Advanced | Lesson 23 | Factorials & independent event counting; 4! arrangements = 24 | 172, 230, 315, 390 |

---

### Stage 5 – Expert Mathematics
*Focus: Complex numbers, logarithmic transformations, unit circle trigonometry, matrix determinants, vectors, and differential limits.*

| # | Lesson ID | Title | Difficulty | Prerequisite | Core Concept / Practice Target | Linked Riddle Levels |
|---|---|---|---|---|---|---|
| 25 | `stage5_lesson25_complex_numbers` | 25. Complex Numbers & the Argand Plane | Expert | Lesson 24 | Imaginary unit i² = -1, modulus \|z\| = √(a² + b²); \|6 + 8i\| = 10 | 250, 305, 365, 420 |
| 26 | `stage5_lesson26_logarithms_exponentials` | 26. Logarithms & Exponential Growth | Expert | Lesson 25 | Inverse powers & log properties; log₂(64) + log₃(27) = 6 + 3 = 9 | 265, 320, 380, 435 |
| 27 | `stage5_lesson27_advanced_trigonometry` | 27. Advanced Trigonometry & the Unit Circle | Expert | Lesson 26 | Fundamental identity sin²θ + cos²θ = 1; if sin θ = 3/5, 25 × cos²θ = 16 | 285, 340, 395, 450 |
| 28 | `topic_matrices` | 28. Matrices, Determinants & Transformations | Expert | Lesson 27 | 2×2 determinant det = ad - bc; det([[5, 2], [3, 4]]) = 20 - 6 = 14 | 7, 21, 63, 189, 400 |
| 29 | `stage5_lesson29_vectors_dot_product` | 29. Vectors & Dot Product | Expert | Lesson 28 | Scalar product u · v = ux·vx + uy·vy; (3, 5) · (4, 2) = 12 + 10 = 22 | 300, 360, 410, 460 |
| 30 | `stage5_lesson30_limits_calculus_intro` | 30. Limits & Introduction to Calculus | Expert | Lesson 29 | Instantaneous slope & Power Rule d/dx[axⁿ] = a·n·xⁿ⁻¹; derivative of 4x² at x = 3 is 24 | 325, 375, 425, 470 |

---

### Stage 6 – Extreme Mathematics
*Focus: Optimization, anti-derivatives, dynamic differential equations, modular arithmetic, matrix spectra, and Olympiad synthesis.*

| # | Lesson ID | Title | Difficulty | Prerequisite | Core Concept / Practice Target | Linked Riddle Levels |
|---|---|---|---|---|---|---|
| 31 | `stage6_lesson31_derivatives_optimization` | 31. Derivatives, Tangents & Optimization | Mastery | Lesson 30 | Critical points where f'(x) = 0; peak of f(x) = -2x² + 24x - 5 is at x = 6 | 350, 400, 440, 480 |
| 32 | `stage6_lesson32_integrals_accumulated_area` | 32. Integration & Accumulated Area | Mastery | Lesson 31 | Fundamental Theorem of Calculus: ∫_a^b f(x)dx = F(b) - F(a); ∫₀⁴ 3x² dx = [x³]₀⁴ = 64 | 380, 420, 460, 490 |
| 33 | `stage6_lesson33_differential_equations` | 33. Differential Equations & Dynamic Models | Mastery | Lesson 32 | Exponential rate models y(t) = y₀ × 2^(t/T); 50 bacteria doubling for 3h = 400 | 410, 450, 475, 495 |
| 34 | `stage6_lesson34_modular_arithmetic` | 34. Modular Arithmetic & Cryptography | Mastery | Lesson 33 | Clock arithmetic & factor reduction; (15 × 8) mod 7 = (1 × 1) mod 7 = 1 | 430, 465, 485, 498 |
| 35 | `stage6_lesson35_linear_algebra_eigenvalues` | 35. Linear Algebra, Eigenvalues & Spectra | Mastery | Lesson 34 | Invariant axes & Trace theorem (∑ λᵢ = Trace); diagonal 4 and 7 gives sum 11 | 455, 478, 492, 499 |
| 36 | `topic_final_boss` | 36. Olympiad Reasoning & Level 500 Mastery | Grandmaster | Lesson 35 | Chinese Remainder Theorem & multi-constraint deduction; N ≡ 3 (mod 5) & N ≡ 2 (mod 7) ⟹ 23 | 480, 490, 495, 499, 500 |

---

## 3. Mathematical Verification Summary

All 36 lessons are verified for:
1. **Uniqueness**: 36 unique IDs and titles.
2. **Keypad Compatibility**: Every question has a non-negative integer string answer (`int.tryParse(ans) != null && ans >= 0`).
3. **Option Distribution**: Every lesson has 4 unique multiple-choice options with the correct answer included.
4. **Pedagogical Structure**: Every lesson provides `whatItIs`, `whyItWorks`, `howToSolveIt`, `whenToUseIt`, step-by-step reasoning, formula, takeaway, common traps, and shortcuts.
5. **Riddle Connection**: Valid linked riddle levels between 1 and 500.

