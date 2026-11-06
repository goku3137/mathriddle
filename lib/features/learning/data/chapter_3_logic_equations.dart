import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

final List<Lesson> chapter3LogicEquations = [
  // CHAPTER 3: EQUATIONS, SYSTEMS & DEDUCTIVE LOGIC
  // ===========================================================================

  // 7. Missing Numbers
  const Lesson(
    id: 'topic_missing',
    title: '7. Missing Number Equations & Cross-Balances',
    category: 'Missing Numbers',
    chapter: 'Chapter 3: Equations & Logic',
    chapterIndex: 3,
    difficulty: 'Beginner to Advanced',
    conceptSummary: 'Solve algebraic balance equations, dual row/column intersections, and product factoring.',
    formula: 'A + [?] = Total → [?] = Total - A | Row_k ∩ Col_k = Common Target',
    whatItIs:
        'Missing number puzzles require isolating an unknown target variable constrained simultaneously by one or more intersecting arithmetic balances.',
    whyItWorks:
        'The additive inverse axiom states that for any quantity A, subtracting A cancels it out, leaving the unknown isolated: A + X - A = X.',
    howToSolveIt:
        '1. Sum Inversion: If A + [?] = Sum, then [?] = Sum - A.\n'
        '2. Multiplicative Offset: If (m · [?]) + c = Total, subtract c first, then divide by m.\n'
        '3. Cross-Grid Constraints: When a missing cell intersects row i and column j, solve both equations to cross-verify.',
    whenToUseIt:
        'Look for grid cells with "?" at intersections of rows and columns with given margin sums.',
    stepByStepExplanation:
        'Missing number puzzles require isolating the unknown variable using inverse operations:\n'
        '1. Addition Inversion: If A + [?] = Sum, then [?] = Sum - A.\n'
        '2. Multiplicative Offset: If ([?] × m) + c = Total, subtract c first, then divide by m: [?] = (Total - c) / m.\n'
        '3. Cross-Grid Constraints: When a missing cell belongs to both a horizontal row and vertical column, solve either equation and use the second equation as verification.\n'
        '4. Product Factoring: If A × B = P1 and B × C = P2, B is the common factor gcd(P1, P2).',
    workedExample:
        'Example: Row: 7 + ? + 7 = 22. Col: 4 + ? + 6 = 18. ? = ?\n'
        '• From row: ? = 22 - (7 + 7) = 22 - 14 = 8.\n'
        '• Verify in column: 4 + 8 + 6 = 18 (True!).',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Single-Variable Balance',
        problem: '([?] × 4) + 7 = 39. Solve for [?].',
        stepByStepSolution:
            '• Subtract constant 7: 39 - 7 = 32.\n'
            '• Divide by coefficient 4: 32 ÷ 4 = 8.',
        answer: '8',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Dual Cross Intersection',
        problem: 'Row: 5 + ? + 9 = 22. Column: 3 + ? + 7 = 18. Find [?].',
        stepByStepSolution:
            '• From row: ? = 22 - (5 + 9) = 22 - 14 = 8.\n'
            '• Verify in column: 3 + 8 + 7 = 18 (Consistent!).',
        answer: '8',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'GCD Product Intersection',
        problem: 'Row product A × B = 48. Column product B × C = 60. A, B, C are distinct single digits. Find B.',
        stepByStepSolution:
            '• B must be a common factor of 48 and 60.\n'
            '• Common factors are 1, 2, 3, 4, 6, 12.\n'
            '• Since single digit and A = 48/B must be single digit (≤9), B ≥ 6.\n'
            '• If B = 6: A = 8, C = 10 (not single digit). If B = 12 (not single digit). If B = 6 with other bounds, isolate unique digit B = 6.',
        answer: '6',
      ),
    ],
    commonMistakes: [
      'Dividing before subtracting the additive constant (e.g. dividing 39 by 4 before subtracting 7).',
    ],
    shortcutsAndTricks: [
      'Digit Sum Parity: The parity of a sum is invariant regardless of grouping.',
    ],
    alternativeMethods: [
      'Substitution & Trial: Test candidate values from the options into the equation.',
    ],
    sandboxType: SandboxDemoType.missingNumbers,
    linkedLevels: [7, 31, 45, 59, 199, 297, 437],
    practiceQuestion: PracticeQuestion(
      question: 'Solve for [?]: ([?] × 4) + 7 = 39',
      correctAnswer: '8',
      hint: 'Subtract 7 from 39 first, then divide the result by 4.',
      explanation: '39 - 7 = 32. 32 ÷ 4 = 8.',
      options: ['6', '7', '8', '9'],
      stepByStepGuidance: 'Step 1: 39 - 7 = 32. Step 2: 32 ÷ 4 = 8.',
      wrongOptionExplanations: {
        '6': 'Incorrect. 6 × 4 + 7 = 24 + 7 = 31 ≠ 39.',
        '7': 'Incorrect. 7 × 4 + 7 = 28 + 7 = 35 ≠ 39.',
        '9': 'Incorrect. 9 × 4 + 7 = 36 + 7 = 43 ≠ 39.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'If 4 + [?] + 9 = 21, what is [?]?',
        correctAnswer: '8',
        hint: '4 + 9 = 13. Subtract 13 from 21.',
        explanation: '21 - 13 = 8.',
        options: ['6', '7', '8', '9'],
      ),
    ],
    icon: Icons.help_outline_rounded,
  ),

  // 8. Linear & Quadratic Equations
  const Lesson(
    id: 'topic_equations',
    title: '8. Linear & Quadratic Equations',
    category: 'Equation Riddles',
    chapter: 'Chapter 3: Equations & Logic',
    chapterIndex: 3,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Solve single-variable algebra, two-variable elimination systems, and monic quadratic roots.',
    formula: 'ax + b = c → x = (c - b)/a | Elimination: (2A + B) - (A + B) = A | x² - bx = c',
    whatItIs:
        'Algebraic equations conceal numerical values behind unknown symbols or variables, requiring systematic algebraic transformations to isolate the target solution.',
    whyItWorks:
        'Whatever operation is performed on one side of an equality must be performed on the other to maintain mathematical equilibrium (axiom of equality).',
    howToSolveIt:
        '1. Linear Equations: ax + b = c ⇒ subtract b, then divide by a.\n'
        '2. Systems of Equations: Subtract equations to eliminate identical variables: (2A + B) - (A + B) = A.\n'
        '3. Symmetric Systems: If A+B, B+C, A+C are given, add all 3 equations to get 2(A+B+C), then divide by 2.\n'
        '4. Monic Quadratics: x² - bx = c can be factored as x(x - b) = c to find the positive integer root.',
    whenToUseIt:
        'Look for picture equations with fruits, shapes, or letters standing for values (e.g. Apple + Banana = 10).',
    stepByStepExplanation:
        'Algebraic riddles conceal values behind variables. Use standard systematic techniques:\n'
        '1. Linear Isolation: Move constants to one side, divide by coefficient: ax + b = c ⇒ x = (c - b) / a.\n'
        '2. System Elimination: When given A + B = s1 and 2A + B = s2, subtract equation 1 from equation 2 to isolate A: (2A + B) - (A + B) = A = s2 - s1.\n'
        '3. Symmetric Cycle Sums: If A+B, B+C, and A+C are known, add all three equations together to get 2(A + B + C). Divide by 2 to find A + B + C.\n'
        '4. Monic Quadratics: x² - bx = c is equivalent to x(x - b) = c. Factor into (x - r)(x + k) = 0 to extract the positive root r.',
    workedExample:
        'Example: A + B = 10, 2A + B = 17. A = ?\n'
        'Subtracting equations: (2A + B) - (A + B) = 17 - 10 ⇒ A = 7.\n'
        'Then B = 10 - 7 = 3.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Single-Variable Linear Isolation',
        problem: '3x + 5 = 26. Find x.',
        stepByStepSolution:
            '• Move constant: 3x = 26 - 5 = 21.\n'
            '• Divide by coefficient: x = 21 ÷ 3 = 7.',
        answer: '7',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Elimination in Two Variables',
        problem: 'A + B = 12 and 2A + B = 19. Find A.',
        stepByStepSolution:
            '• Subtract equation 1 from equation 2:\n'
            '• (2A + B) - (A + B) = 19 - 12\n'
            '• A = 7. (Then B = 12 - 7 = 5).',
        answer: '7',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Symmetric Cyclic System',
        problem: 'A + B = 14, B + C = 18, A + C = 16. Find A + B + C.',
        stepByStepSolution:
            '• Add all three equations together:\n'
            '• (A + B) + (B + C) + (A + C) = 14 + 18 + 16\n'
            '• 2A + 2B + 2C = 48\n'
            '• Divide both sides by 2: A + B + C = 24.',
        answer: '24',
      ),
    ],
    commonMistakes: [
      'Assuming all variables must be single digits.',
      'Forgetting that a picture with two bananas has twice the value of a picture with one banana!',
    ],
    shortcutsAndTricks: [
      'Cycle Sum Shortcut: Whenever 3 equations cyclically sum pairs (A+B, B+C, C+A), their total sum is always (Sum1 + Sum2 + Sum3) / 2.',
    ],
    alternativeMethods: [
      'Substitution Method: Isolate B = 10 - A and substitute into the second equation.',
    ],
    sandboxType: SandboxDemoType.equations,
    linkedLevels: [33, 47, 61, 103, 173, 299, 411],
    practiceQuestion: PracticeQuestion(
      question: 'If 3x + 5 = 26, then x = ?',
      correctAnswer: '7',
      hint: 'Subtract 5 from 26 first, then divide by 3.',
      explanation: '3x = 26 - 5 = 21. x = 21 ÷ 3 = 7.',
      options: ['5', '6', '7', '8'],
      stepByStepGuidance: '3x = 26 - 5 = 21. x = 21 / 3 = 7.',
      wrongOptionExplanations: {
        '5': 'Incorrect. 3(5) + 5 = 20 ≠ 26.',
        '6': 'Incorrect. 3(6) + 5 = 23 ≠ 26.',
        '8': 'Incorrect. 3(8) + 5 = 29 ≠ 26.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'If A + B = 15 and A - B = 5, what is A?',
        correctAnswer: '10',
        hint: 'Add the two equations together: (A + B) + (A - B) = 15 + 5.',
        explanation: '2A = 20 → A = 10.',
        options: ['8', '10', '12', '15'],
      ),
    ],
    icon: Icons.calculate_rounded,
  ),

  // 9. Logic & Deductive Number Riddles
  const Lesson(
    id: 'topic_logic',
    title: '9. Logic & Deductive Number Theory',
    category: 'Logic Numbers',
    chapter: 'Chapter 3: Equations & Logic',
    chapterIndex: 3,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Master digit sums, LCM common multiples, palindromes, automorphic squares, and deduction lock codes.',
    formula: 'Number = 10t + u | Automorphic: N² mod 10^k = N | Emirp: Prime reversed is Prime',
    whatItIs:
        'Deductive number riddles combine simultaneous number-theoretic properties (such as digit sums, divisibility rules, palindromes, and lock codes) to uniquely isolate an integer.',
    whyItWorks:
        'Positional base-10 notation represents any two-digit number as 10t + u. Any constraint on its digit sum (t + u) or reverse (10u + t) forms a rigid Diophantine equation with integer constraints 0 ≤ u ≤ 9 and 1 ≤ t ≤ 9.',
    howToSolveIt:
        '1. Divisibility by 3: Sum of digits must be a multiple of 3.\n'
        '2. Divisibility by 4: Last two digits must form a multiple of 4.\n'
        '3. Least Common Multiple (LCM): Find smallest number divisible by all factors.\n'
        '4. Lock Code Elimination: Cross-examine clues: "one number correct and well placed" vs "wrongly placed" to eliminate false candidates.',
    whenToUseIt:
        'Look for clues like "My tens digit is double my units digit", "Smallest number divisible by 3, 4, and 6", or 3-digit lock code riddles.',
    stepByStepExplanation:
        'Deductive riddles restrict numbers using simultaneous arithmetic constraints:\n'
        '1. Digit Sum Constraints: A two-digit number with tens digit t and units digit u has value 10t + u, with digit sum (t + u).\n'
        '2. Least Common Multiple (LCM): Smallest positive integer divisible by all candidates (e.g., LCM(4, 5, 6) = 60).\n'
        '3. Palindromic Constraints: A 3-digit palindrome has form ABA (100A + 10B + A). Outer digits are identical!\n'
        '4. Automorphic Numbers: A number whose square ends in the number itself (e.g., 25² = 625, 76² = 5776).\n'
        '5. Deductive Code Clues: Analyze clues: "one number correct and well-placed" vs "two numbers correct but wrongly-placed" to systematically isolate digits by position.',
    workedExample:
        'Example: A 2-digit number (digits sum to 9) is 4 times its digit sum. Value?\n'
        'Digit sum = 9.\n'
        'Number = 4 × 9 = 36. Verification: 3 + 6 = 9 (True!).',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Least Common Multiple (LCM)',
        problem: 'Find the smallest positive integer divisible by 3, 4, and 6.',
        stepByStepSolution:
            '• Multiples of 6: 6, 12, 18, 24...\n'
            '• Check 6: divisible by 3, but not 4.\n'
            '• Check 12: divisible by 3 (4), 4 (3), and 6 (2). LCM = 12.',
        answer: '12',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Digit Sum Product Constraint',
        problem: 'A two-digit number is 7 times its units digit, and its tens digit is 3. What is the number?',
        stepByStepSolution:
            '• Number = 10(3) + u = 30 + u.\n'
            '• Set up equation: 30 + u = 7u.\n'
            '• 6u = 30 ⇒ u = 5.\n'
            '• Number is 35. Check: 7 × 5 = 35 (True!).',
        answer: '35',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Automorphic Square Invariant',
        problem: 'Find the two-digit number whose square ends in the number itself.',
        stepByStepSolution:
            '• We require N² ≡ N (mod 100), so N(N - 1) is divisible by 100 = 4 × 25.\n'
            '• One of N or N - 1 must be a multiple of 25.\n'
            '• Testing 25: 25² = 625 (ends in 25!). Testing 76: 76² = 5776 (ends in 76!).\n'
            '• Both 25 and 76 are automorphic numbers.',
        answer: '25',
      ),
    ],
    commonMistakes: [
      'Confusing digit sum with product of digits.',
      'Checking only one clue and stopping before verifying all simultaneous constraints.',
    ],
    shortcutsAndTricks: [
      'Divisibility by 9: A number is divisible by 9 if and only if its digit sum is a multiple of 9.',
      'Palindromic Divisibility: Every 4-digit palindrome ABBA is always divisible by 11.',
    ],
    alternativeMethods: [
      'Candidate Elimination Grid: List digits 0..9 and strike out contradicted candidates.',
    ],
    sandboxType: SandboxDemoType.logic,
    linkedLevels: [23, 37, 51, 65, 107, 205, 499],
    practiceQuestion: PracticeQuestion(
      question: 'What is the smallest positive number divisible by 3, 4, and 6?',
      correctAnswer: '12',
      hint: 'Find the Least Common Multiple (LCM) of 3, 4, and 6.',
      explanation: 'Multiples of 6 are 6, 12, 18... 12 is divisible by both 3 and 4. LCM = 12.',
      options: ['6', '12', '18', '24'],
      stepByStepGuidance: 'List multiples of the largest number (6): 6, 12, 18. 12 is divisible by 3 and 4. Thus LCM is 12.',
      wrongOptionExplanations: {
        '6': 'Incorrect. 6 is not divisible by 4.',
        '18': 'Incorrect. 18 is not divisible by 4.',
        '24': 'Incorrect. 24 is a common multiple, but not the SMALLEST positive common multiple (12 is smaller).',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'A number is 4 times its digit sum, and digits sum to 9. Value?',
        correctAnswer: '36',
        hint: 'Multiply the digit sum (9) by 4.',
        explanation: '4 × 9 = 36. Digits: 3 + 6 = 9.',
        options: ['27', '36', '45', '54'],
      ),
    ],
    icon: Icons.psychology_rounded,
  ),

  // 10. Age Riddles
  const Lesson(
    id: 'topic_age',
    title: '10. Age & Time-Shift Word Problems',
    category: 'Age Riddles',
    chapter: 'Chapter 3: Equations & Logic',
    chapterIndex: 3,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Model time-shift equations, age difference invariants, and generational multiplier ratios.',
    formula: 'Difference Invariant: A - B is constant across time | Future: (A + Y) = m(B + Y)',
    whatItIs:
        'Age riddles model temporal shifts where two or more individuals age at the same constant rate (1 year per year), preserving the absolute difference between their ages as a permanent mathematical invariant.',
    whyItWorks:
        'If Person A is currently A and Person B is B, then in Y years their ages become (A + Y) and (B + Y). Their difference is (A + Y) - (B + Y) = A - B, which is completely independent of Y!',
    howToSolveIt:
        '1. Set Up Difference Invariant: Identify the constant difference D = A - B.\n'
        '2. Set Up Future Equality: If in Y years Dad is m times Son: (A + Y) = m(B + Y).\n'
        '3. Substitute & Isolate: Solve for Y or current age using standard linear algebra.',
    whenToUseIt:
        'Look for phrases like "In 5 years, Dad will be twice as old as Son", or "Sam is 4 years older than Leo".',
    stepByStepExplanation:
        'Age riddles rely on a fundamental mathematical invariant: the difference between two people\'s ages never changes over time!\n'
        '1. Sum and Difference: If Sam is D years older than Leo and their ages sum to S:\n'
        '   • Leo = (S - D) / 2\n'
        '   • Sam = Leo + D\n'
        '2. Future Age Multiplier: If Dad is currently 3× Son, and in Y years Dad is F years old:\n'
        '   • Dad\'s current age = F - Y.\n'
        '   • Son\'s current age = (F - Y) / 3.\n'
        '3. Time Shift: Mom is M, Daughter is D. In how many years (x) will Mom be 2× Daughter?\n'
        '   • Set up: M + x = 2(D + x) ⇒ x = M - 2D.',
    workedExample:
        'Example: Sam is 4 yrs older than Leo. Sum of ages is 20. Sam\'s age?\n'
        '• Leo = (20 - 4) / 2 = 16 / 2 = 8.\n'
        '• Sam = 8 + 4 = 12.\n'
        'Verification: 12 + 8 = 20, 12 - 8 = 4 (True!).',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Sum & Difference Formula',
        problem: 'Sam is 4 years older than Leo. The sum of their ages is 20. How old is Sam?',
        stepByStepSolution:
            '• Leo\'s age: (Sum - Difference) ÷ 2 = (20 - 4) ÷ 2 = 16 ÷ 2 = 8.\n'
            '• Sam\'s age: 8 + 4 = 12.',
        answer: '12',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Current Multiplier from Future Age',
        problem: 'Dad is 3 times Son\'s age. In 5 years, Dad will be 35. How old is Son now?',
        stepByStepSolution:
            '• Dad\'s age now: 35 - 5 = 30.\n'
            '• Since Dad is 3× Son now: Son\'s age = 30 ÷ 3 = 10.',
        answer: '10',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Future Multiplier Transition',
        problem: 'Mom is 36, Daughter is 10. In how many years will Mom be exactly twice Daughter\'s age?',
        stepByStepSolution:
            '• Difference is 36 - 10 = 26 years.\n'
            '• When Mom is 2× Daughter, Mom - Daughter = Daughter = 26.\n'
            '• So Daughter must be 26 years old.\n'
            '• Years to wait: 26 - 10 = 16 years.',
        answer: '16',
      ),
    ],
    commonMistakes: [
      'Assuming the ratio between ages remains constant (the difference is constant, NOT the ratio!).',
      'Forgetting to add the years to BOTH people when projecting into the future.',
    ],
    shortcutsAndTricks: [
      'Double-Age Shortcut: When A is twice B, B must equal the age difference between them! (e.g. difference is 26, so B must be 26).',
    ],
    alternativeMethods: [
      'Timeline Table: Make columns for "Now" and "Future (+Y)" to visualize variables clearly.',
    ],
    sandboxType: SandboxDemoType.age,
    linkedLevels: [26, 40, 54, 68, 110, 208, 362],
    practiceQuestion: PracticeQuestion(
      question: 'Dad is 3× Son\'s age. In 5 years, Dad is 35. What is Son\'s age now?',
      correctAnswer: '10',
      hint: 'Find Dad\'s current age first by subtracting 5 years from 35, then divide by 3.',
      explanation: 'Dad now = 35 - 5 = 30. Son now = 30 ÷ 3 = 10.',
      options: ['8', '10', '12', '15'],
      stepByStepGuidance: 'Dad now = 35 - 5 = 30. Son now = 30 ÷ 3 = 10.',
      wrongOptionExplanations: {
        '8': 'Incorrect. 3 × 8 = 24; in 5 years Dad would be 29, not 35.',
        '12': 'Incorrect. 3 × 12 = 36; Dad is already older than 35 now.',
        '15': 'Incorrect. 3 × 15 = 45; too high.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Anna is 6 years older than Ben. Their ages sum to 26. How old is Anna?',
        correctAnswer: '16',
        hint: 'Ben = (26 - 6) / 2 = 10. Anna = 10 + 6.',
        explanation: 'Ben is 10, Anna is 16. Sum = 26, Difference = 6.',
        options: ['12', '14', '16', '18'],
      ),
    ],
    icon: Icons.hourglass_top_rounded,
  ),

  // ===========================================================================
];
