import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

/// Stage 6: Extreme Mathematics
/// Covers advanced calculus, differential equations, modular arithmetic, eigenvalues,
/// and Olympiad problem-solving up to the Level 500 Grandmaster Trial.
final List<Lesson> stage6ExtremeMathematics = [
  // Lesson 31
  const Lesson(
    id: 'stage6_lesson31_derivatives_optimization',
    title: '31. Derivatives, Tangents & Optimization',
    category: 'Optimization',
    stage: 'Stage 6 – Extreme Mathematics',
    stageIndex: 6,
    difficulty: 'Mastery',
    conceptSummary:
        'To find the maximum or minimum of a smooth curve, set its derivative equal to zero: f\'(x) = 0. At turning points, the tangent is completely flat.',
    formula: 'Critical Point: f\'(x) = 0 | Max if f\'\'(x) < 0',
    whatItIs:
        'Optimization is finding the best possible outcome—maximum revenue, minimum material cost, or lowest energy state.',
    whyItWorks:
        'At the exact peak of a hill, you are neither rising nor falling. The instantaneous slope (derivative) must be zero.',
    howToSolveIt:
        'Step 1: Differentiate the function: f(x) = -2x² + 24x - 5.\nStep 2: f\'(x) = -4x + 24.\nStep 3: Set f\'(x) = 0: -4x + 24 = 0.\nStep 4: Solve for x: 4x = 24 ⟹ x = 6.',
    whenToUseIt:
        'Used in machine learning gradient descent, aerodynamic hull drag minimization, and portfolio risk management.',
    stepByStepExplanation:
        'Step 1: Given quadratic curve: f(x) = -2x² + 24x - 5.\nStep 2: Differentiate with respect to x:\n  f\'(x) = d/dx [-2x² + 24x - 5] = -4x + 24.\nStep 3: A local extremum occurs where slope is zero:\n  -4x + 24 = 0.\nStep 4: Rearrange: 4x = 24 ⟹ x = 24 ÷ 4 = 6.\nStep 5: Check second derivative: f\'\'(x) = -4 < 0, confirming a true maximum.\nConclusion: The peak occurs at x = 6.',
    workedExample:
        'Example: Find vertex of y = x² - 8x.\ny\' = 2x - 8 = 0 ⟹ x = 4.',
    takeaway: 'At every peak and valley of a smooth curve, the derivative equals zero.',
    commonMistakes: [
      'Forgetting the negative sign on the derivative: d/dx[-2x²] = -4x.',
      'Assuming f\'(x) = 0 always guarantees a maximum (it could be a minimum; check the second derivative).',
    ],
    shortcutsAndTricks: [
      'For parabola ax² + bx + c, the vertex x-coordinate is always -b / (2a): -24 / (2 × -2) = 6.',
    ],
    alternativeMethods: [
      'Complete the square: -2(x² - 12x) - 5 = -2(x - 6)² + 67. The peak is at x = 6.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [350, 400, 440, 480],
    practiceQuestion: PracticeQuestion(
      question: 'Find the value of x that maximizes the curve: f(x) = -2x² + 24x - 5',
      correctAnswer: '6',
      hint: 'Differentiate and set to zero: f\'(x) = -4x + 24 = 0. Solve for x.',
      explanation: 'f\'(x) = -4x + 24 = 0 ⟹ 4x = 24 ⟹ x = 6.',
      options: ['6', '12', '4', '8'],
      stepByStepGuidance: '-4x + 24 = 0 ⟹ x = 6.',
      wrongOptionExplanations: {
        '12': '12 is 24 ÷ 2, but the divisor is 4.',
        '4': 'Check division: 24 ÷ 4 = 6, not 4.',
        '8': 'Check division: 24 ÷ 4 = 6.',
      },
    ),
    icon: Icons.terrain_rounded,
  ),

  // Lesson 32
  const Lesson(
    id: 'stage6_lesson32_integrals_accumulated_area',
    title: '32. Integration & Accumulated Area',
    category: 'Calculus',
    stage: 'Stage 6 – Extreme Mathematics',
    stageIndex: 6,
    difficulty: 'Mastery',
    conceptSummary:
        'Integration is the reverse of differentiation. The definite integral ∫_a^b f(x)dx computes the exact area trapped under a curve: F(b) - F(a).',
    formula: '∫ axⁿ dx = (a / (n + 1)) xⁿ⁺¹ | Area = F(b) - F(a)',
    whatItIs:
        'Integration sums up infinitely many infinitesimal slices of area to find the exact total accumulation.',
    whyItWorks:
        'Fundamental Theorem of Calculus: Differentiation and integration are exact inverse processes of one another.',
    howToSolveIt:
        'Step 1: Function f(x) = 3x².\nStep 2: Anti-derivative F(x) = (3 / 3) x³ = x³.\nStep 3: Boundaries are from x = 0 to x = 4.\nStep 4: Evaluate F(4) - F(0): 4³ - 0³ = 64 - 0 = 64.',
    whenToUseIt:
        'Used to calculate total fuel consumption from variable flow rate, distance from variable velocity, and probability distribution areas.',
    stepByStepExplanation:
        'Step 1: Problem: Evaluate definite integral ∫₀⁴ 3x² dx.\nStep 2: Find the anti-derivative:\n  ∫ 3x² dx = 3 × (x³/3) = x³.\nStep 3: Apply the Fundamental Theorem of Calculus:\n  [x³]₀⁴ = (4)³ - (0)³.\nStep 4: 4³ = 4 × 4 × 4 = 64.\nStep 5: 64 - 0 = 64.\nConclusion: The exact accumulated area is 64.',
    workedExample:
        'Example: Evaluate ∫₀² 2x dx.\nAnti-derivative is x². [x²]₀² = 2² - 0² = 4.',
    takeaway: 'Integration sums up continuous quantities into exact areas and volumes.',
    commonMistakes: [
      'Forgetting to increase the exponent by 1 (thinking ∫ x² dx is 2x).',
      'Forgetting to divide by the new exponent: ∫ 3x² dx = (3/3)x³ = x³.',
    ],
    shortcutsAndTricks: [
      'Power rule for integration: Add 1 to the power, then divide by the new power.',
    ],
    alternativeMethods: [
      'Riemann sum approximation: sum rectangles of width Δx as width approaches zero.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [380, 420, 460, 490],
    practiceQuestion: PracticeQuestion(
      question: 'Evaluate the definite integral of f(x) = 3x² from x = 0 to x = 4:',
      correctAnswer: '64',
      hint: 'The anti-derivative of 3x² is x³. Evaluate 4³ - 0³.',
      explanation: '∫₀⁴ 3x² dx = [x³]₀⁴ = 4³ - 0 = 64.',
      options: ['64', '48', '32', '16'],
      stepByStepGuidance: '[x³]₀⁴ = 4³ = 64.',
      wrongOptionExplanations: {
        '48': '48 is 3 × 4² = 48 (the height at x=4, not the accumulated area under the curve).',
        '32': 'Check your powers: 4³ = 4 × 4 × 4 = 64, not 32.',
        '16': '16 is 4², not 4³.',
      },
    ),
    icon: Icons.integration_instructions_rounded,
  ),

  // Lesson 33
  const Lesson(
    id: 'stage6_lesson33_differential_equations',
    title: '33. Differential Equations & Dynamic Models',
    category: 'Applied Math',
    stage: 'Stage 6 – Extreme Mathematics',
    stageIndex: 6,
    difficulty: 'Mastery',
    conceptSummary:
        'Differential equations describe rates of growth: dy/dt = ky. When growth rate is proportional to size, the solution is exponential: y(t) = y₀ × 2^(t/T).',
    formula: 'Exponential Growth: y(t) = y₀ × 2^(t/T) | dy/dt = ky',
    whatItIs:
        'Differential equations are the language of nature, describing how physical systems evolve through continuous time.',
    whyItWorks:
        'If a colony doubles every period, after n periods it has multiplied by 2ⁿ.',
    howToSolveIt:
        'Step 1: Initial population y₀ = 50 bacteria.\nStep 2: Doubling time T = 1 hour. Total elapsed time t = 3 hours.\nStep 3: Number of doublings = 3 ÷ 1 = 3.\nStep 4: Growth multiplier = 2³ = 8.\nStep 5: Final count = 50 × 8 = 400 bacteria.',
    whenToUseIt:
        'Used in viral epidemic models (R₀ reproduction rate), radioactive nuclear decay, predator-prey ecosystems, and capacitor charging.',
    stepByStepExplanation:
        'Step 1: Given initial count = 50 bacteria.\nStep 2: Doubling occurs every hour.\nStep 3: After Hour 1: 50 × 2 = 100 bacteria.\nStep 4: After Hour 2: 100 × 2 = 200 bacteria.\nStep 5: After Hour 3: 200 × 2 = 400 bacteria.\nFormula: 50 × 2³ = 50 × 8 = 400.',
    workedExample:
        'Example: A colony of 10 triples every hour. How many after 2 hours?\n10 × 3² = 10 × 9 = 90.',
    takeaway: 'Exponential processes compound: growth in each period multiplies the entire previous accumulation.',
    commonMistakes: [
      'Adding the initial amount instead of multiplying: 50 + (50×3) = 200 (incorrect!).',
      'Confusing doubling with squaring (doubling is ×2, not raising to power 2).',
    ],
    shortcutsAndTricks: [
      'Count powers of 2 for doublings: 2¹=2, 2²=4, 2³=8, 2⁴=16, 2⁵=32.',
    ],
    alternativeMethods: [
      'Continuous solution: y(t) = 50 e^(kt) where k = ln(2). At t = 3: 50 e^(3 ln 2) = 50 × 2³ = 400.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [410, 450, 475, 495],
    practiceQuestion: PracticeQuestion(
      question: 'A bacterial culture starts with 50 bacteria and doubles every hour. How many bacteria are present after 3 hours?',
      correctAnswer: '400',
      hint: 'After 1h: 100. After 2h: 200. After 3h: ? (Or 50 × 2³).',
      explanation: '50 × 2³ = 50 × 8 = 400 bacteria.',
      options: ['400', '300', '250', '350'],
      stepByStepGuidance: '50 × 8 = 400.',
      wrongOptionExplanations: {
        '300': 'Growth compounds exponentially, not linearly (50 × 6 is not the right formula).',
        '250': 'Check your doublings: 50 → 100 → 200 → 400.',
        '350': 'Check your multiplication: 50 × 8 = 400.',
      },
    ),
    icon: Icons.biotech_rounded,
  ),

  // Lesson 34
  const Lesson(
    id: 'stage6_lesson34_modular_arithmetic',
    title: '34. Modular Arithmetic & Cryptography',
    category: 'Number Theory',
    stage: 'Stage 6 – Extreme Mathematics',
    stageIndex: 6,
    difficulty: 'Mastery',
    conceptSummary:
        'Modular arithmetic computes remainders: a ≡ b (mod m). A fundamental rule is that you can reduce numbers modulo m BEFORE multiplying.',
    formula: '(a × b) mod m = [(a mod m) × (b mod m)] mod m',
    whatItIs:
        'Clock arithmetic where numbers wrap around a fixed cycle called the modulus.',
    whyItWorks:
        'Because 15 = 2(7) + 1 and 8 = 1(7) + 1, their product is (14 + 1)(7 + 1) = 7(something) + (1 × 1) = remainder 1.',
    howToSolveIt:
        'Step 1: Method A: Multiply 15 × 8 = 120. Divide 120 by 7: 120 = 17 × 7 + 1. Remainder is 1.\nStep 2: Method B (Pro Modular Shortcut):\n  • 15 mod 7 = 1 (since 15 = 2 × 7 + 1)\n  • 8 mod 7 = 1 (since 8 = 1 × 7 + 1)\n  • (1 × 1) mod 7 = 1.',
    whenToUseIt:
        'Secures all internet communications (RSA encryption, Diffie-Hellman key exchange), computes blockchain hashes, and verifies ISBN book barcodes.',
    stepByStepExplanation:
        'Step 1: Evaluate (15 × 8) mod 7.\nStep 2: Pro shortcut: reduce each factor modulo 7 before multiplying:\n  • 15 ÷ 7 = 2 with remainder 1 ⟹ 15 ≡ 1 (mod 7)\n  • 8 ÷ 7 = 1 with remainder 1 ⟹ 8 ≡ 1 (mod 7).\nStep 3: Multiply the remainders: 1 × 1 = 1.\nStep 4: 1 mod 7 = 1.\nConclusion: The remainder is 1.',
    workedExample:
        'Example: Find 25 mod 4.\n25 = (4 × 6) + 1. Remainder is 1.',
    takeaway: 'You can reduce modulo m at any point before adding or multiplying.',
    commonMistakes: [
      'Confusing the quotient with the remainder: 15 ÷ 7 = 2 (quotient) with remainder 1. The mod is 1, not 2!',
      'Thinking modular arithmetic only applies to small numbers.',
    ],
    shortcutsAndTricks: [
      'Modular reduction allows computing astronomical powers like 3¹⁰⁰ mod 7 in seconds.',
    ],
    alternativeMethods: [
      'Direct long division: 120 ÷ 7 = 17 remainder 1.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [430, 465, 485, 498],
    practiceQuestion: PracticeQuestion(
      question: 'What is the remainder when (15 × 8) is divided by 7 (evaluate: (15 × 8) mod 7)?',
      correctAnswer: '1',
      hint: 'Reduce first: 15 mod 7 = 1, and 8 mod 7 = 1. Multiply the remainders: 1 × 1 = ?',
      explanation: '15 ≡ 1 (mod 7) and 8 ≡ 1 (mod 7). (1 × 1) mod 7 = 1.',
      options: ['1', '3', '5', '2'],
      stepByStepGuidance: '(1 × 1) mod 7 = 1.',
      wrongOptionExplanations: {
        '3': 'Check the remainders: 15 ÷ 7 leaves 1, not 3.',
        '5': 'Check division: 120 ÷ 7 = 17 remainder 1, not 5.',
        '2': '2 is the quotient of 15 ÷ 7, not the remainder of (15 × 8).',
      },
    ),
    icon: Icons.lock_clock_rounded,
  ),

  // Lesson 35
  const Lesson(
    id: 'stage6_lesson35_linear_algebra_eigenvalues',
    title: '35. Linear Algebra, Eigenvalues & Spectra',
    category: 'Linear Algebra',
    stage: 'Stage 6 – Extreme Mathematics',
    stageIndex: 6,
    difficulty: 'Mastery',
    conceptSummary:
        'An eigenvector satisfies A·v = λv. The sum of all eigenvalues of any square matrix ALWAYS equals the trace (sum of the main diagonal entries).',
    formula: 'Sum of Eigenvalues = Trace(A) = a₁₁ + a₂₂',
    whatItIs:
        'Eigenvalues reveal the invariant axes of transformations—directions where vectors do not rotate, but merely stretch.',
    whyItWorks:
        'The characteristic polynomial det(A - λI) = 0 has coefficients determined by the trace and determinant: λ² - Trace(A)λ + det(A) = 0.',
    howToSolveIt:
        'Step 1: Identify the main diagonal entries of the matrix: 4 and 7.\nStep 2: Add diagonal entries: 4 + 7 = 11.\nStep 3: By the Trace-Eigenvalue Theorem, the sum of eigenvalues is exactly 11.',
    whenToUseIt:
        'Used in Google PageRank algorithm, preventing structural bridge resonance collapse, and quantum energy eigenstates.',
    stepByStepExplanation:
        'Step 1: Consider a 2×2 matrix with diagonal entries a₁₁ = 4 and a₂₂ = 7.\nStep 2: Trace formula: Trace(A) = a₁₁ + a₂₂.\nStep 3: Trace(A) = 4 + 7 = 11.\nStep 4: Fundamental Theorem: ∑ λᵢ = Trace(A).\nStep 5: Therefore, the sum of the eigenvalues is 11.',
    workedExample:
        'Example: Find trace of [[3, 1], [0, 5]].\nDiagonal entries are 3 and 5. Trace = 3 + 5 = 8. Sum of eigenvalues = 8.',
    takeaway: 'The sum of eigenvalues is always the trace; the product of eigenvalues is always the determinant.',
    commonMistakes: [
      'Adding off-diagonal entries (trace uses ONLY top-left to bottom-right diagonal).',
      'Confusing sum of eigenvalues (trace) with product of eigenvalues (determinant).',
    ],
    shortcutsAndTricks: [
      'Instantly verify eigenvalues: if someone calculates λ₁ = 2 and λ₂ = 9, 2 + 9 = 11 matches the trace!',
    ],
    alternativeMethods: [
      'Solve full characteristic equation: det(A - λI) = (4 - λ)(7 - λ) = 0 ⟹ λ = 4, 7. Sum = 4 + 7 = 11.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [455, 478, 492, 499],
    practiceQuestion: PracticeQuestion(
      question: 'For a 2x2 matrix with diagonal entries 4 and 7, what is the sum of its eigenvalues (the trace)?',
      correctAnswer: '11',
      hint: 'The sum of eigenvalues equals the sum of diagonal entries (the trace): 4 + 7 = ?',
      explanation: 'Sum of eigenvalues = Trace(A) = 4 + 7 = 11.',
      options: ['11', '28', '14', '8'],
      stepByStepGuidance: 'Trace = 4 + 7 = 11.',
      wrongOptionExplanations: {
        '28': '28 is 4 × 7 (the product of diagonal entries), not their sum.',
        '14': 'Check your addition: 4 + 7 = 11, not 14.',
        '8': 'Check diagonal entries: 4 + 7 = 11.',
      },
    ),
    icon: Icons.hub_rounded,
  ),

  // Lesson 36 (Preserves topic_final_boss)
  const Lesson(
    id: 'topic_final_boss',
    title: '36. Olympiad Reasoning & Level 500 Mastery',
    category: 'Final Boss',
    stage: 'Stage 6 – Extreme Mathematics',
    stageIndex: 6,
    difficulty: 'Grandmaster',
    conceptSummary:
        'The pinnacle of mathematical problem-solving unites modular arithmetic (Chinese Remainder Theorem), sequence invariants, and multi-step deduction.',
    formula: 'Chinese Remainder Theorem: N ≡ a (mod m), N ≡ b (mod n)',
    whatItIs:
        'High-level competitive mathematics requires combining multiple independent theorems into a unified solving strategy.',
    whyItWorks:
        'By testing candidate values satisfying the first constraint (N = 5k + 3), we quickly locate the unique value that simultaneously satisfies the second constraint (mod 7).',
    howToSolveIt:
        'Step 1: Constraint 1: N ≡ 3 (mod 5). Numbers: 3, 8, 13, 18, 23, 28, 33...\nStep 2: Constraint 2: N ≡ 2 (mod 7).\nStep 3: Test each candidate modulo 7:\n  • 3 mod 7 = 3\n  • 8 mod 7 = 1\n  • 13 mod 7 = 6\n  • 18 mod 7 = 4\n  • 23 mod 7 = 2 (MATCH! 23 = 3 × 7 + 2).\nStep 4: Smallest positive integer N = 23.',
    whenToUseIt:
        'Required to conquer Level 500 (Final Boss) of SMATH, International Mathematical Olympiad (IMO) trials, and algorithmic puzzle contests.',
    stepByStepExplanation:
        'Step 1: Find smallest positive N such that N ≡ 3 (mod 5) and N ≡ 2 (mod 7).\nStep 2: Express N using the first condition: N = 5k + 3 for integers k ≥ 0.\nStep 3: Test values of k:\n  • k = 0 ⟹ N = 3 (3 mod 7 = 3 ≠ 2)\n  • k = 1 ⟹ N = 8 (8 mod 7 = 1 ≠ 2)\n  • k = 2 ⟹ N = 13 (13 mod 7 = 6 ≠ 2)\n  • k = 3 ⟹ N = 18 (18 mod 7 = 4 ≠ 2)\n  • k = 4 ⟹ N = 23 (23 ÷ 7 = 3 with remainder 2. Match!).\nStep 4: Smallest solution is 23.\n(Next solution would be 23 + (5 × 7) = 58).',
    workedExample:
        'Example: N ≡ 1 (mod 2) and N ≡ 1 (mod 3).\nMultiples of 3 plus 1: 4 (even), 7 (odd and 7 mod 3 = 1). Smallest positive N = 7 (or 1).',
    takeaway: 'Break complex multi-variable problems into independent step-by-step modular constraints.',
    commonMistakes: [
      'Testing random numbers instead of stepping systematically through multiples of the larger modulus.',
      'Forgetting that solutions repeat every LCM(m, n) = 35 steps.',
    ],
    shortcutsAndTricks: [
      'Step by the larger modulus (7) to check fewer numbers: 2, 9, 16, 23 (23 ends in 3, so 23 ≡ 3 mod 5!).',
    ],
    alternativeMethods: [
      'Extended Euclidean Algorithm: compute modular inverse of 5 modulo 7 to solve directly.',
    ],
    sandboxType: SandboxDemoType.finalBoss,
    linkedLevels: [480, 490, 495, 499, 500],
    practiceQuestion: PracticeQuestion(
      question: 'Level 500 Grandmaster Trial: If an integer N satisfies N ≡ 3 (mod 5) and N ≡ 2 (mod 7), what is the smallest positive integer N?',
      correctAnswer: '23',
      hint: 'List numbers ending in 3 or 8 (satisfying mod 5): 3, 8, 13, 18, 23... Which one gives remainder 2 when divided by 7?',
      explanation: '23 = 5 × 4 + 3 (so 23 ≡ 3 mod 5) and 23 = 7 × 3 + 2 (so 23 ≡ 2 mod 7). Smallest integer is 23.',
      options: ['23', '18', '33', '37'],
      stepByStepGuidance: '23 = 4(5) + 3 and 23 = 3(7) + 2.',
      wrongOptionExplanations: {
        '18': '18 mod 7 = 4, not 2.',
        '33': '33 mod 7 = 5, not 2.',
        '37': '37 mod 5 = 2, but we need N ≡ 3 mod 5.',
      },
    ),
    icon: Icons.military_tech_rounded,
  ),
];

