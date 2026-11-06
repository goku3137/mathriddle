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
    difficulty: 'Intermediate',
    conceptSummary: 'Crack 3×3 grid puzzles by checking row rules, column rules, and magic square sums.',
    formula: 'Grid Rule: Check Row 1: Col 1 × Col 2 = Col 3 | Or check if all rows sum to the same number!',
    whatItIs:
        'A matrix puzzle is a 3×3 grid of 9 boxes. Eight boxes contain numbers, and one box has a question mark [?]. Your goal is to spot the pattern across the rows or columns to find the missing number.',
    whyItWorks:
        'In a grid, numbers connect in straight lines. If Row 1 multiplies (3 × 4 = 12) and Row 2 multiplies (5 × 6 = 30), then Row 3 is guaranteed to follow the exact same rule (7 × 8 = 56)!',
    howToSolveIt:
        '1. Step 1 (Check Rows): Look across Row 1 from left to right. Do the first two boxes add or multiply to make the third box?\n'
        '2. Step 2 (Check Columns): If rows don\'t show a rule, look down each column from top to bottom.\n'
        '3. Step 3 (Check Magic Sums): Do all three numbers in each row add up to the same target (like 15)?\n'
        '4. Step 4 (Apply to Row 3): Once you confirm the rule in both Row 1 and Row 2, apply it to find [?].',
    whenToUseIt:
        'Use whenever you see a 3×3 square grid of numbers with an empty box.',
    stepByStepExplanation:
        'To solve any 3×3 grid puzzle, test these 3 simple possibilities:\n'
        '1. Row Multipliers: Column 1 × Column 2 = Column 3 (e.g. 2 × 5 = 10).\n'
        '2. Magic Constant Sum: Every row adds up to 15 (e.g. 8 + 1 + 6 = 15).\n'
        '3. Sum & Double: Add the first two boxes, then double the answer: (Col 1 + Col 2) × 2 = Col 3.',
    workedExample:
        'Example: Row 1 = [3, 4, 12], Row 2 = [5, 6, 30], Row 3 = [7, 8, ?]\n'
        '• Look across Row 1: 3 × 4 = 12.\n'
        '• Check Row 2: 5 × 6 = 30. The rule is confirmed!\n'
        '• Apply to Row 3: 7 × 8 = 56.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Row Multiplication Rule',
        problem: 'Row 1 = [2, 5, 10], Row 2 = [3, 4, 12], Row 3 = [4, 6, ?]. Find ?.',
        stepByStepSolution:
            '• Row 1: 2 × 5 = 10.\n'
            '• Row 2: 3 × 4 = 12.\n'
            '• Row 3: 4 × 6 = 24.',
        answer: '24',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Magic Sum of 15',
        problem: 'Row 1 = [8, 1, 6], Row 2 = [3, 5, 7], Row 3 = [4, 9, ?]. All rows sum to 15. Find ?.',
        stepByStepSolution:
            '• Row 3 sum must equal 15:\n'
            '• 4 + 9 + ? = 15\n'
            '• 13 + ? = 15 ⇒ ? = 2.',
        answer: '2',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: '2×2 Cross Multiplication (Determinant)',
        problem: 'In a 2×2 box [a, b; c, d] where a=5, b=2, c=7, d=4, rule is (a × d) - (b × c). Value = ?',
        stepByStepSolution:
            '• Multiply diagonal 1: 5 × 4 = 20.\n'
            '• Multiply diagonal 2: 2 × 7 = 14.\n'
            '• Subtract: 20 - 14 = 6.',
        answer: '6',
      ),
    ],
    commonMistakes: [
      'Checking only Row 1 and guessing: always make sure the rule works in BOTH Row 1 and Row 2 before solving Row 3.',
      'Only looking horizontally: sometimes numbers connect vertically in columns!',
    ],
    shortcutsAndTricks: [
      'Two-Row Verification: If a rule works in Row 1 AND Row 2, it is 100% the intended answer for Row 3.',
    ],
    alternativeMethods: [
      'Turn it into an equation: Write Col 1 [op] Col 2 = Col 3 and find the operation that fits.',
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
        '20': '4 × 6 = 24, not 20.',
        '22': 'Check your 4 times table: 4 × 6 = 24.',
        '26': '4 × 6 = 24.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Row 1 = [3, 3, 9], Row 2 = [4, 4, 16], Row 3 = [5, 5, ?]. What is ?',
        correctAnswer: '25',
        hint: 'Multiply Column 1 by Column 2: 5 × 5 = ?',
        explanation: '5 × 5 = 25.',
        options: ['15', '20', '25', '30'],
        wrongOptionExplanations: {
          '15': '5 × 5 = 25 (not 5 + 5 + 5).',
          '20': '5 × 5 = 25.',
          '30': '5 × 5 = 25.',
        },
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
    difficulty: 'Easy–Intermediate',
    conceptSummary: 'Master discounts, sales tax, unit pricing, and "Buy 2 Get 1 Free" store deals.',
    formula: 'Discount Shortcut: 20% off means you pay 80% | 10% off is just moving the decimal point one spot left!',
    whatItIs:
        'Shopping riddles test practical math you use every day in stores: calculating discounts, comparing prices, and working out special promotions like "Buy 2 Get 1 Free".',
    whyItWorks:
        'A discount is money you get to keep in your pocket! If a store gives 25% off an \$80 jacket, they are taking off one-quarter (\$20), meaning you only pay \$60.',
    howToSolveIt:
        '1. Step 1 (Find 10% Fast): Move the decimal point one place left (10% of \$80 is \$8). For 20%, double it (\$16)!\n'
        '2. Step 2 (25% Shortcut): 25% is just dividing by 4. So 25% off \$80 is \$80 ÷ 4 = \$20 off.\n'
        '3. Step 3 (Buy N Get 1 Free): Group items into bundles. In "Buy 2 Get 1 Free", every 3 items gives 1 free item.',
    whenToUseIt:
        'Use whenever riddles mention dollars, discounts, shopping carts, or special bundle offers.',
    stepByStepExplanation:
        'Practical shopping math shortcuts:\n'
        '1. 10% Shortcut: Shift decimal left once: 10% of \$60 = \$6.\n'
        '2. 20% Shortcut: Double the 10%: \$6 × 2 = \$12 discount. Final price = \$60 - \$12 = \$48.\n'
        '3. Buy 2 Get 1 Free: For 6 items, you get two sets of 3. In each set of 3, you only pay for 2. Total paid = 4 items!',
    workedExample:
        'Example: A jacket originally costs \$80 and has a 25% discount. What is the final price?\n'
        '• 25% means one-quarter (1/4).\n'
        '• Discount = \$80 ÷ 4 = \$20.\n'
        '• Final price = \$80 - \$20 = \$60.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Percentage Discount',
        problem: 'A \$80 jacket has a 25% discount. What is the final price?',
        stepByStepSolution:
            '• 25% = 1/4 of \$80 = \$20 discount.\n'
            '• Final price: \$80 - \$20 = \$60.',
        answer: '60',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Buy 3 Get 1 Free Bundle',
        problem: 'Books cost \$10 each. Deal: Buy 3 Get 1 Free! What is the cost for 11 books?',
        stepByStepSolution:
            '• Every 4 books includes 1 free book.\n'
            '• 11 ÷ 4 = 2 groups of 4 (so 2 free books), plus 3 extra books.\n'
            '• Paid books = 11 - 2 = 9 books.\n'
            '• Total cost = 9 × \$10 = \$90.',
        answer: '90',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Comparing Two Store Orders',
        problem: '2 coffees and 3 muffins cost \$24. 2 coffees and 1 muffin cost \$16. How much is 1 coffee?',
        stepByStepSolution:
            '• Compare orders: the first order has 2 extra muffins for \$24 - \$16 = \$8.\n'
            '• 1 muffin = \$4.\n'
            '• Now find coffee: 2 coffees + \$4 = \$16 ⇒ 2 coffees = \$12 ⇒ 1 coffee = \$6.',
        answer: '6',
      ),
    ],
    commonMistakes: [
      'Adding two discounts together: A 20% discount followed by a 10% discount is NOT 30% off! The second discount is calculated on the already reduced price.',
    ],
    shortcutsAndTricks: [
      'The 10% Rule: To find 10% of anything, just drop the last zero or move the decimal point!',
    ],
    alternativeMethods: [
      'Multiply by remaining percent: 25% off means you pay 75%. \$80 × 0.75 = \$60.',
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
        '55': 'Check your subtraction: 80 - 20 = 60, not 55.',
        '65': '80 - 20 = 60.',
        '70': 'You only deducted \$10! A 25% discount is \$20 off: 80 - 20 = 60.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Buy 2 Get 1 Free at \$5 each. What is the total cost for 6 items?',
        correctAnswer: '20',
        hint: 'Every 3 items gives 1 free. For 6 items, 2 are free. You pay for 4 items.',
        explanation: '4 paid items × \$5 = \$20.',
        options: ['15', '20', '25', '30'],
        wrongOptionExplanations: {
          '15': 'For 6 items, 2 are free, so 4 are paid: 4 × \$5 = \$20.',
          '25': 'You pay for 4 items: 4 × \$5 = \$20.',
          '30': '30 would be paying for all 6 items without using the discount!',
        },
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
    difficulty: 'Advanced',
    conceptSummary: 'Learn how to conquer the final boss puzzle by breaking it down into 3 easy pieces.',
    formula: 'Boss Strategy: Break the giant puzzle into 3 small steps, solve each one, then combine them!',
    whatItIs:
        'Level 500 is the grand finale of SMATH! It combines shapes, grid diagonals, and sequences into one thrilling ultimate riddle.',
    whyItWorks:
        'Big, intimidating puzzles are just small, easy puzzles glued together! By solving one piece at a time, what looks impossible becomes simple.',
    howToSolveIt:
        '1. Step 1 (Triangle Piece): Multiply the bottom numbers and divide by the top number: (7 × 8) ÷ 4 = 56 ÷ 4 = 14.\n'
        '2. Step 2 (Grid Diagonal Piece): Add the diagonal numbers: 12 + 15 + 18 = 45.\n'
        '3. Step 3 (Combine with Precedence): Multiply Piece 1 by Piece 2, then subtract the Fibonacci number 55:\n'
        '   (14 × 45) - 55 = 630 - 55 = 575!',
    whenToUseIt:
        'Use when facing Level 500 or any multi-step challenge riddle.',
    stepByStepExplanation:
        'Here is the complete blueprint to defeat the Final Boss:\n'
        '• Piece 1 (Triangle): (7 × 8) ÷ 4 = 14.\n'
        '• Piece 2 (Grid Trace): 12 + 15 + 18 = 45.\n'
        '• Piece 3 (Fibonacci): The 10th number in the sequence 1, 1, 2, 3, 5, 8, 13, 21, 34, 55 is 55.\n'
        '• Combine: (14 × 45) - 55 = 630 - 55 = 575.',
    workedExample:
        'Example: Solve (14 × 45) - 55 = ?\n'
        '• Step 1: Multiply first: 14 × 45 = 630.\n'
        '• Step 2: Subtract: 630 - 55 = 575.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Piece 1 (Triangle Corner Math)',
        problem: 'Evaluate (7 × 8) ÷ 4.',
        stepByStepSolution:
            '• 7 × 8 = 56.\n'
            '• 56 ÷ 4 = 14.',
        answer: '14',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Piece 2 (Diagonal Addition)',
        problem: 'Add the three diagonal numbers: 12 + 15 + 18.',
        stepByStepSolution:
            '• 12 + 15 = 27.\n'
            '• 27 + 18 = 45.',
        answer: '45',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Final Boss Synthesis',
        problem: '(14 × 45) - 55 = ?',
        stepByStepSolution:
            '• Multiplication first: 14 × 45 = 630.\n'
            '• Subtract 55: 630 - 55 = 575.',
        answer: '575',
      ),
    ],
    commonMistakes: [
      'Subtracting 55 from 45 before multiplying by 14: Remember BODMAS! Always multiply 14 × 45 first.',
    ],
    shortcutsAndTricks: [
      'Fast Mental Multiplication: 14 × 45 is the same as 7 × 90 = 630!',
    ],
    alternativeMethods: [
      'Solve in bite-sized chunks: Write down the answer to each piece, then do the final line.',
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
        '525': '14 × 45 = 630. 630 - 55 = 575.',
        '565': 'Close! 630 - 55 = 575.',
        '600': '630 - 55 = 575. Check the subtraction.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'What is 14 × 45?',
        correctAnswer: '630',
        hint: 'Use the doubling trick: 7 × 90 = ?',
        explanation: '7 × 90 = 630.',
        options: ['580', '610', '630', '650'],
        wrongOptionExplanations: {
          '580': '7 × 90 = 630.',
          '610': '7 × 90 = 630.',
          '650': '7 × 90 = 630.',
        },
      ),
    ],
    icon: Icons.military_tech_rounded,
  ),
];
