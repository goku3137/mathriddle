import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

final List<Lesson> chapter5AdvancedBoss = [
  // CHAPTER 5: ADVANCED MATRICES, COMMERCIAL MATH & BOSS MASTERY
  // ===========================================================================

  // 13. Matrix & Numeric Grids
  const Lesson(
    id: 'topic_matrices',
    title: '13. Matrix Transformations & Numeric Grids',
    category: 'Matrices & Grids',
    chapter: 'Chapter 5: Advanced Synthesis & Boss Mastery',
    chapterIndex: 5,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Master 3×3 grid patterns including row/column products, magic sums, and 2×2 determinant kernels.',
    formula: 'Row_Product: Col1 × Col2 = Col3 | Diagonal: a11 × a22 × a33 | Kernel: det = ad - bc',
    whatItIs:
        'Matrix and 3×3 grid riddles structure numbers into rows, columns, and diagonals where consistent algebraic transformations govern transitions across dimensions.',
    whyItWorks:
        'Linear algebra organizes simultaneous data into rows and columns. Relationships like row products, constant trace sums, and 2×2 sub-determinants allow multiple verification paths.',
    howToSolveIt:
        '1. Check Horizontal Rows: Col 1 × Col 2 = Col 3 or Col 1 + Col 2 = Col 3.\n'
        '2. Check Vertical Columns: Row 1 × Row 2 = Row 3.\n'
        '3. Check Magic Constant Sum: Do all rows and columns add up to the same number?\n'
        '4. Check Main Diagonal: Look along top-left to bottom-right diagonal.',
    whenToUseIt:
        'Whenever a 3×3 grid of 9 cells is displayed with numbers in 8 cells and a "?" in the remaining cell.',
    stepByStepExplanation:
        'A 3×3 matrix puzzle can embed patterns across rows, columns, or diagonals:\n'
        '1. Horizontal Row Product: In each row, Column 1 × Column 2 = Column 3.\n'
        '2. Magic Constant Sum: All rows and columns sum to a constant target S.\n'
        '3. Sum & Double: (Col 1 + Col 2) × 2 = Col 3.\n'
        '4. Vertical Column Multipliers: Row 1 × Row 2 = Row 3 in each column.\n'
        '5. Diagonal Product: Multiply the three elements along the main diagonal from top-left to bottom-right: a₁₁ × a₂₂ × a₃₃.\n'
        '6. Determinant Kernel: Upper-left 2×2 kernel determinant: (a·d) - (b·c).',
    workedExample:
        'Example: 3×3 Grid with Row 1 = [3, 4, 12], Row 2 = [5, 6, 30], Row 3 = [7, 8, ?]\n'
        'Row 1: 3 × 4 = 12.\n'
        'Row 2: 5 × 6 = 30.\n'
        'Row 3: 7 × 8 = 56.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Row Product Rule',
        problem: 'Row 1 = [2, 5, 10], Row 2 = [3, 4, 12], Row 3 = [4, 6, ?]. Find ?.',
        stepByStepSolution:
            '• Row 1: 2 × 5 = 10.\n'
            '• Row 2: 3 × 4 = 12.\n'
            '• Row 3: 4 × 6 = 24.',
        answer: '24',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Magic Matrix Sum 15',
        problem: 'Row 1 = [8, 1, 6], Row 2 = [3, 5, 7], Row 3 = [4, 9, ?]. All rows sum to 15. Find ?.',
        stepByStepSolution:
            '• Row 3 sum: 4 + 9 + ? = 15.\n'
            '• 13 + ? = 15 ⇒ ? = 2.\n'
            '• Verify Column 3: 6 + 7 + 2 = 15 (Consistent!).',
        answer: '2',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: '2×2 Determinant Kernel',
        problem: '2×2 matrix kernel [a, b; c, d] has a=5, b=2, c=7, d=4. det = ad - bc = ?',
        stepByStepSolution:
            '• Cross multiply main diagonal: 5 × 4 = 20.\n'
            '• Cross multiply off diagonal: 2 × 7 = 14.\n'
            '• Determinant: 20 - 14 = 6.',
        answer: '6',
      ),
    ],
    commonMistakes: [
      'Assuming patterns must only be horizontal; check vertical columns if rows show no consistent rule.',
    ],
    shortcutsAndTricks: [
      'Row 1 / Row 2 Verification: Always verify your suspected rule on BOTH Row 1 and Row 2 before applying to Row 3.',
    ],
    alternativeMethods: [
      'Transpose Inspection: Look at the grid with rows as columns if you are stuck.',
    ],
    sandboxType: SandboxDemoType.matrices,
    linkedLevels: [3, 11, 15, 35, 49, 105, 399, 497],
    practiceQuestion: PracticeQuestion(
      question: 'In a 3×3 grid, Row 1 = [2, 5, 10], Row 2 = [3, 4, 12]. Row 3 = [4, 6, ?]. What is ?',
      correctAnswer: '24',
      hint: 'Notice that Column 1 × Column 2 = Column 3 in every row.',
      explanation: 'Row 3: 4 × 6 = 24.',
      options: ['20', '22', '24', '26'],
      stepByStepGuidance: 'In each row, Col 1 × Col 2 = Col 3. Row 3 has Col 1 = 4 and Col 2 = 6. 4 × 6 = 24.',
      wrongOptionExplanations: {
        '20': 'Incorrect. 4 × 6 = 24, not 20.',
        '22': 'Incorrect. Check multiplication table for 4 × 6.',
        '26': 'Incorrect. Did you add 4 + 6 and multiply by something?',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Row 1 = [3, 3, 9], Row 2 = [4, 4, 16], Row 3 = [5, 5, ?]. What is ?',
        correctAnswer: '25',
        hint: 'Column 1 × Column 2 = Column 3.',
        explanation: '5 × 5 = 25.',
        options: ['15', '20', '25', '30'],
      ),
    ],
    icon: Icons.grid_3x3_rounded,
  ),

  // 14. Money & Shopping
  const Lesson(
    id: 'topic_money',
    title: '14. Money, Discounts & Commercial Mathematics',
    category: 'Money & Shopping',
    chapter: 'Chapter 5: Advanced Synthesis & Boss Mastery',
    chapterIndex: 5,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Solve unit pricing, percentage discounts, coin exchanges, profit margins, and promotional bundles.',
    formula: 'Discount = Price × (1 - d%) | Cost = Sell / (1 + p%) | Bundles: Paid = Total - ⌊Total / Bundle⌋',
    whatItIs:
        'Commercial mathematics applies proportional reasoning, percentage discounts, simultaneous pricing, and promotional bundles to real-world consumer scenarios.',
    whyItWorks:
        'Percentages represent fractions of 100. A discount of d% leaves (100 - d)% of the price to be paid, allowing direct single-multiplier calculation: Final = Price × (1 - d/100).',
    howToSolveIt:
        '1. Percentage Discount: \$P with d% off = \$P × (1 - d/100).\n'
        '2. Buy N Get 1 Free: In every group of (N + 1) items, 1 item is free. Free items = ⌊Total / (N + 1)⌋.\n'
        '3. Simultaneous Orders: If 1 Coffee + 1 Donut = \$C1 and 2 Coffees + 1 Donut = \$C2, subtract to isolate 1 Coffee = \$C2 - \$C1.',
    whenToUseIt:
        'Look for dollar/cent signs, shopping items, discounts, or promotional deals ("Buy 3 Get 1 Free").',
    stepByStepExplanation:
        'Shopping riddles test practical commercial reasoning:\n'
        '1. Unit Price Scaling: Find the cost of 1 unit first by dividing total cost by quantity. Multiply by target quantity.\n'
        '2. Percentage Discount: A 25% discount means paying (100% - 25%) = 75% of original price.\n'
        '3. Simultaneous Pricing: 1 Coffee + 1 Donut = \$C1, 2 Coffees + 1 Donut = \$C2. The difference (\$C2 - \$C1) is the price of 1 Coffee!\n'
        '4. Coin Denominations: Dimes (10¢) and Nickels (5¢). If all were nickels, they would total Coins × 5¢. Any excess cents must come from dimes (+5¢ each).\n'
        '5. Buy N Get 1 Free: For every (N + 1) items, 1 item is free. Quantity paid = Total - ⌊Total / (N + 1)⌋.',
    workedExample:
        'Example: Buy 3 get 1 free at \$10 each. What is the minimum cost for 11 items?\n'
        'Every 4 items gives 1 free. For 11 items:\n'
        '• 11 ÷ 4 = 2 free items (with 3 remaining).\n'
        '• Paid items = 11 - 2 = 9 items.\n'
        '• Total cost = 9 × \$10 = \$90.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Percentage Discount Calculation',
        problem: 'A \$80 jacket has a 25% discount. What is the final price?',
        stepByStepSolution:
            '• 25% = 1/4. Discount amount: \$80 × 0.25 = \$20.\n'
            '• Final price: \$80 - \$20 = \$60.',
        answer: '60',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Promotional Bundle Logic',
        problem: 'Books cost \$10 each. Special deal: Buy 3 Get 1 Free! What is cost for 11 books?',
        stepByStepSolution:
            '• Every 4 books includes 1 free book.\n'
            '• 11 ÷ 4 = 2 sets of 4 books (2 free books), plus 3 extra books.\n'
            '• Total paid books = 11 - 2 = 9 books.\n'
            '• Total cost = 9 × \$10 = \$90.',
        answer: '90',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Simultaneous Item Pricing',
        problem: '2 coffees and 3 muffins cost \$24. 2 coffees and 1 muffin cost \$16. Find price of 1 coffee.',
        stepByStepSolution:
            '• Subtract equations: 2 muffins = \$24 - \$16 = \$8.\n'
            '• 1 muffin = \$4.\n'
            '• Substitute into second equation: 2 coffees + \$4 = \$16 ⇒ 2 coffees = \$12 ⇒ 1 coffee = \$6.',
        answer: '6',
      ),
    ],
    commonMistakes: [
      'Applying two successive discounts (e.g. 20% off, then 10% off) by adding them as 30%—they must be multiplied successively: (0.80 × 0.90 = 0.72 = 28% off).',
    ],
    shortcutsAndTricks: [
      '25% is 1/4: Divide price by 4 to get discount, or multiply by 0.75 for final price.',
      '10% Rule: Shift decimal left by 1 digit for 10%, then double for 20% or halve for 5%.',
    ],
    alternativeMethods: [
      'Fraction Multiplier: \$80 × (3/4) = \$60 in one mental step.',
    ],
    sandboxType: SandboxDemoType.money,
    linkedLevels: [22, 36, 50, 64, 106, 204, 400],
    practiceQuestion: PracticeQuestion(
      question: 'A \$80 jacket has a 25% discount. What is the final price?',
      correctAnswer: '60',
      hint: '25% of \$80 is \$20. Subtract \$20 from \$80.',
      explanation: '\$80 × 0.25 = \$20 discount. Final price = \$80 - \$20 = \$60.',
      options: ['55', '60', '65', '70'],
      stepByStepGuidance: 'Find 25% of 80: 80 / 4 = 20. Subtract discount: 80 - 20 = 60.',
      wrongOptionExplanations: {
        '55': 'Incorrect. 80 - 20 = 60, not 55.',
        '65': 'Incorrect. Off by five.',
        '70': 'Incorrect. Did you deduct only 10 dollars?',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Buy 2 Get 1 Free at \$5 each. What is the total cost for 6 items?',
        correctAnswer: '20',
        hint: 'Every 3 items gives 1 free. For 6 items, 2 are free. You pay for 4 items.',
        explanation: '4 paid items × \$5 = \$20.',
        options: ['15', '20', '25', '30'],
      ),
    ],
    icon: Icons.monetization_on_rounded,
  ),

  // 15. Grand Singularity (Level 500 Boss Strategy)
  const Lesson(
    id: 'topic_final_boss',
    title: '15. Final Boss: Grand Singularity Master Strategy',
    category: 'Final Boss',
    chapter: 'Chapter 5: Advanced Synthesis & Boss Mastery',
    chapterIndex: 5,
    difficulty: 'Final Boss (Ultimate)',
    conceptSummary: 'Synthesize geometry, matrix diagonals, Fibonacci recurrences, and lateral operators into one equation.',
    formula: 'Singularity: (Δ[v1, v2, v3] × ⊞[Diagonal_Sum]) - F(10) = 575',
    whatItIs:
        'Level 500 represents the Grand Singularity boss puzzle of SMATH, which unifies geometry, linear algebra, recurrences, and precedence into a single interconnected mathematical engine.',
    whyItWorks:
        'Complex engineering systems are networks of mathematical components. The Grand Singularity tests whether you can decompose a multi-layered composite equation into its constituent modules and execute them flawlessly.',
    howToSolveIt:
        '1. Stage 1 (Triangle Vertex Engine): The notation Δ[7, 8, 4] instructs: multiply the base vertices and divide by the top vertex: (7 × 8) ÷ 4 = 56 ÷ 4 = 14.\n'
        '2. Stage 2 (Matrix Kernel Diagonal): The notation ⊞[Diag 12, 15, 18] instructs: sum the main diagonal of the 3×3 matrix: 12 + 15 + 18 = 45.\n'
        '3. Stage 3 (Fibonacci Harmonic): F(10) represents the 10th Fibonacci number: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55. F(10) = 55.\n'
        '4. Final Synthesis: Combine all stages following BODMAS precedence:\n'
        '   (14 × 45) - 55 = 630 - 55 = 575.',
    whenToUseIt:
        'Reserved exclusively for the Ultimate Boss Level 500.',
    stepByStepExplanation:
        'Level 500 represents the culmination of all puzzle concepts in SMATH. To defeat the Final Boss:\n'
        '1. Stage 1 (Triangle Vertex Engine): The notation Δ[7, 8, 4] instructs: multiply the base vertices and divide by the top vertex: (7 × 8) ÷ 4 = 56 ÷ 4 = 14.\n'
        '2. Stage 2 (Matrix Kernel Diagonal): The notation ⊞[Diag 12, 15, 18] instructs: sum the main diagonal of the 3×3 matrix: 12 + 15 + 18 = 45.\n'
        '3. Stage 3 (Fibonacci Harmonic): F(10) represents the 10th Fibonacci number: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55. F(10) = 55.\n'
        '4. Final Synthesis: Combine all stages following BODMAS precedence:\n'
        '   (14 × 45) - 55 = 630 - 55 = 575.',
    workedExample:
        'BOSS Equation: (Δ[7,8,4] × ⊞[Diag 12,15,18]) - F(10) = ?\n'
        '• Stage 1 (Δ): (7 × 8) ÷ 4 = 14\n'
        '• Stage 2 (⊞): 12 + 15 + 18 = 45\n'
        '• Stage 3 (F): F(10) = 55\n'
        '• Grand Singularity: 14 × 45 = 630. 630 - 55 = 575.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Component 1 (Triangle Kernel)',
        problem: 'Evaluate Δ[7, 8, 4] = (7 × 8) ÷ 4.',
        stepByStepSolution:
            '• 7 × 8 = 56.\n'
            '• 56 ÷ 4 = 14.',
        answer: '14',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Component 2 & 3 (Matrix Trace & Fibonacci)',
        problem: 'Evaluate Trace 12 + 15 + 18 and 10th Fibonacci number F(10).',
        stepByStepSolution:
            '• Trace: 12 + 15 + 18 = 45.\n'
            '• F(10) = 55 (from sequence 1, 1, 2, 3, 5, 8, 13, 21, 34, 55).',
        answer: '45 and 55',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Full Grand Singularity Synthesis',
        problem: '(14 × 45) - 55 = ?',
        stepByStepSolution:
            '• Multiplication first: 14 × 45 = 630.\n'
            '• Subtraction: 630 - 55 = 575.',
        answer: '575',
      ),
    ],
    commonMistakes: [
      'Subtracting 55 from 45 before multiplying by 14 (severe BODMAS violation!).',
      'Miscounting the Fibonacci sequence terms (F(1)=1, F(2)=1, F(3)=2... F(10)=55).',
    ],
    shortcutsAndTricks: [
      'Mental Multiplication of 14 × 45: Halve and double! 14 × 45 = 7 × 90 = 630 in 2 seconds flat.',
    ],
    alternativeMethods: [
      'Modular Arithmetic: Compute (14 × 45 - 55) mod 10 = (4 × 5 - 5) mod 10 = 0 - 5 = 5. The answer must end in 5!',
    ],
    sandboxType: SandboxDemoType.finalBoss,
    linkedLevels: [500],
    practiceQuestion: PracticeQuestion(
      question: 'If Stage 1 = 14 and Stage 2 = 45, what is (Stage 1 × Stage 2) - 55?',
      correctAnswer: '575',
      hint: 'Multiply 14 by 45 first (630), then subtract 55.',
      explanation: '14 × 45 = 630. 630 - 55 = 575.',
      options: ['525', '565', '575', '600'],
      stepByStepGuidance: '14 × 45 = 630. 630 - 55 = 575.',
      wrongOptionExplanations: {
        '525': 'Incorrect. 630 - 55 = 575.',
        '565': 'Incorrect. Off by ten.',
        '600': 'Incorrect. Check arithmetic 630 - 55 = 575.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'What is 14 × 45?',
        correctAnswer: '630',
        hint: 'Use the trick: 7 × 90 = ?',
        explanation: '7 × 90 = 630.',
        options: ['580', '610', '630', '650'],
      ),
    ],
    icon: Icons.military_tech_rounded,
  ),
];
