import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

/// Stage 2: Basic Mathematics
/// Covers foundational operational rules, number theory, fractions, and proportions.
final List<Lesson> stage2BasicMathematics = [
  // Lesson 7 (Preserves topic_pemdas for backward compatibility)
  const Lesson(
    id: 'topic_pemdas',
    title: '7. Order of Operations (BODMAS / PEMDAS)',
    category: 'Formula Precedence',
    stage: 'Stage 2 – Basic Mathematics',
    stageIndex: 2,
    difficulty: 'Basic',
    conceptSummary:
        'When an expression contains multiple signs, calculate in strict order: Brackets → Orders (Powers) → Division & Multiplication → Addition & Subtraction.',
    formula: 'BODMAS: Brackets → Orders → Division & Multiplication → Addition & Subtraction',
    whatItIs:
        'A universal rule that prevents ambiguity in mathematical expressions so everyone gets the exact same answer.',
    whyItWorks:
        'Multiplication represents groups of items, which must be collected together before loose additions or subtractions can be combined.',
    howToSolveIt:
        'Scan from left to right. Resolve parentheses first, then powers, then perform division and multiplication in order of appearance, and finally addition and subtraction.',
    whenToUseIt:
        'Use BODMAS whenever an equation contains more than one arithmetic operator.',
    stepByStepExplanation:
        'Step 1: Write the problem: 8 + 8 ÷ 4 + 8 × 2 - 4.\nStep 2: Division and Multiplication have top priority:\n  • 8 ÷ 4 = 2\n  • 8 × 2 = 16\nStep 3: Substitute back into expression:\n  8 + 2 + 16 - 4\nStep 4: Now perform addition and subtraction left to right:\n  • 8 + 2 = 10\n  • 10 + 16 = 26\n  • 26 - 4 = 22.\nFinal Answer: 22.',
    workedExample:
        'Example: Evaluate 5 + 3 × 4.\nMultiply first: 3 × 4 = 12.\nThen add: 5 + 12 = 17.',
    takeaway: 'Never add before multiplying unless parentheses explicitly force you to!',
    commonMistakes: [
      'Calculating strictly left-to-right: in 5 + 3 × 4, adding 5+3=8 then 8×4=32 is incorrect!',
      'Thinking addition must always come before subtraction (they share equal priority left to right).',
    ],
    shortcutsAndTricks: [
      'Circle all × and ÷ groups first with your pencil, evaluate them, then combine the additions.',
    ],
    alternativeMethods: [
      'Write intermediate steps directly below the equation to prevent mental drop-off.',
    ],
    sandboxType: SandboxDemoType.bodmas,
    linkedLevels: [1, 5, 12, 25, 50],
    practiceQuestion: PracticeQuestion(
      question: 'Evaluate: 8 + 8 ÷ 4 + 8 × 2 - 4 = ?',
      correctAnswer: '22',
      hint: 'Perform 8 ÷ 4 (=2) and 8 × 2 (=16) first before adding or subtracting.',
      explanation: '8 + (8 ÷ 4) + (8 × 2) - 4 = 8 + 2 + 16 - 4 = 22.',
      options: ['22', '36', '24', '18'],
      stepByStepGuidance: '8 ÷ 4 = 2, 8 × 2 = 16. Then: 8 + 2 + 16 - 4 = 22.',
      wrongOptionExplanations: {
        '36': 'You calculated left to right without respecting division and multiplication priority.',
        '24': 'You made an arithmetic slip in the final addition/subtraction step.',
        '18': 'Check the multiplication step: 8 × 2 = 16.',
      },
    ),
    icon: Icons.calculate_rounded,
  ),

  // Lesson 8
  const Lesson(
    id: 'stage2_lesson8_factors_primes',
    title: '8. Factors, Multiples & Prime Numbers',
    category: 'Number Theory',
    stage: 'Stage 2 – Basic Mathematics',
    stageIndex: 2,
    difficulty: 'Basic',
    conceptSummary:
        'Factors divide evenly into a number. Multiples are times-table results. A Prime number has exactly two distinct factors: 1 and itself.',
    formula: 'Primes: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31...',
    whatItIs:
        'Primes are the indivisible building blocks of all whole numbers. 2 is the smallest prime and the only even prime number.',
    whyItWorks:
        'Every whole number greater than 1 can be broken into a unique tree of prime factors (Fundamental Theorem of Arithmetic).',
    howToSolveIt:
        'To test if a number is prime, check if it divides by 2, 3, 5, or 7. Divisibility rule for 3: if the sum of its digits divides by 3, the number divides by 3.',
    whenToUseIt:
        'Use factors to simplify fractions, find common denominators, and understand modern encryption.',
    stepByStepExplanation:
        'Step 1: Check numbers greater than 20 to find the next prime.\nStep 2: 21 has digit sum 2+1=3, so 21 = 3 × 7 (composite).\nStep 3: 22 ends in 2, so it is even (composite).\nStep 4: 23 has no divisors other than 1 and 23. Thus, 23 is prime.',
    workedExample:
        'Example: Find all factors of 12.\nPairs: 1 × 12, 2 × 6, 3 × 4.\nFactors are: 1, 2, 3, 4, 6, 12.',
    takeaway: '2 is the only even prime number; 1 is neither prime nor composite.',
    commonMistakes: [
      'Thinking 1 is a prime number (a prime must have exactly two distinct factors).',
      'Thinking all odd numbers are prime (e.g., 9, 15, 21, 25, 27 are composite!).',
    ],
    shortcutsAndTricks: [
      'Digit sum trick: 51 is not prime because 5 + 1 = 6, which divides by 3 (51 = 3 × 17).',
    ],
    alternativeMethods: [
      'Factor tree: branch a number into factors until every leaf is prime.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [19, 21, 27, 33],
    practiceQuestion: PracticeQuestion(
      question: 'What is the smallest prime number greater than 20?',
      correctAnswer: '23',
      hint: 'Test 21, 22, 23. Does 23 divide by 2, 3, or 5?',
      explanation: '21 is divisible by 3 and 7; 22 is even. 23 has no divisors other than 1 and 23, making it the smallest prime > 20.',
      options: ['23', '21', '27', '29'],
      stepByStepGuidance: '21 = 3 × 7, 22 = 2 × 11, 23 is prime.',
      wrongOptionExplanations: {
        '21': '21 = 3 × 7, so it is composite.',
        '27': '27 = 3 × 9, so it is composite.',
        '29': '29 is prime, but 23 is smaller than 29.',
      },
    ),
    icon: Icons.grain_rounded,
  ),

  // Lesson 9
  const Lesson(
    id: 'stage2_lesson9_fractions_operations',
    title: '9. Working with Fractions & Decimals',
    category: 'Arithmetic',
    stage: 'Stage 2 – Basic Mathematics',
    stageIndex: 2,
    difficulty: 'Basic',
    conceptSummary:
        'Adding or subtracting fractions requires a Common Denominator. Multiplying fractions simply multiplies numerators and denominators: (a/b) × (c/d) = (ac)/(bd).',
    formula: '1/2 + 1/4 = 2/4 + 1/4 = 3/4',
    whatItIs:
        'Fractions represent exact divisions. To add different sized slices (like halves and quarters), convert them to a shared slice size (common denominator).',
    whyItWorks:
        '1 half is equivalent to 2 quarters (1/2 = 2/4). Now that both pieces have denominator 4, we can add them directly: 2/4 + 1/4 = 3/4.',
    howToSolveIt:
        'Step 1: Find the common denominator.\nStep 2: Convert top numbers.\nStep 3: Add tops, keep bottom the same.\nStep 4: Multiply by the total.',
    whenToUseIt:
        'Use when calculating precise measurements, cooking proportions, and financial interest.',
    stepByStepExplanation:
        'Step 1: Evaluate (1/2 + 1/4) of 40.\nStep 2: Convert 1/2 to fourths: 1/2 = 2/4.\nStep 3: Add fractions: 2/4 + 1/4 = 3/4.\nStep 4: Calculate 3/4 of 40:\n  • 1/4 of 40 = 40 ÷ 4 = 10\n  • 3/4 of 40 = 3 × 10 = 30.',
    workedExample:
        'Example: What is 2/3 × 15?\n15 ÷ 3 = 5. Then 2 × 5 = 10.',
    takeaway: 'Never add denominators together! 1/2 + 1/2 = 2/2 = 1, NOT 2/4.',
    commonMistakes: [
      'Adding denominators together: 1/2 + 1/4 ≠ 2/6.',
      'Forgetting to simplify fractions to lowest terms.',
    ],
    shortcutsAndTricks: [
      'To find a fraction of a number, divide by the bottom and multiply by the top: (40 ÷ 4) × 3 = 30.',
    ],
    alternativeMethods: [
      'Convert to decimals: 1/2 = 0.5, 1/4 = 0.25. Sum is 0.75. 0.75 × 40 = 30.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [22, 28, 45, 62],
    practiceQuestion: PracticeQuestion(
      question: 'Calculate: (1/2 + 1/4) of 40 = ?',
      correctAnswer: '30',
      hint: '1/2 = 2/4. So 1/2 + 1/4 = 3/4. What is 3/4 of 40?',
      explanation: '1/2 + 1/4 = 3/4. 3/4 of 40 = (40 ÷ 4) × 3 = 10 × 3 = 30.',
      options: ['30', '20', '25', '35'],
      stepByStepGuidance: '3/4 × 40 = 30.',
      wrongOptionExplanations: {
        '20': '20 is half (1/2) of 40.',
        '25': 'Check your fraction addition: 1/2 + 1/4 = 3/4, not 5/8.',
        '35': 'Check the multiplication: 3 × 10 = 30, not 35.',
      },
    ),
    icon: Icons.pie_chart_rounded,
  ),

  // Lesson 10
  const Lesson(
    id: 'stage2_lesson10_ratios_proportions',
    title: '10. Ratios, Proportions & Percent Change',
    category: 'Proportions',
    stage: 'Stage 2 – Basic Mathematics',
    stageIndex: 2,
    difficulty: 'Basic',
    conceptSummary:
        'A ratio compares parts: 2:3 means 2 parts to 3 parts (5 total parts). Percent change compares the change to the ORIGINAL value.',
    formula: 'Total Parts = a + b | 1 Part = Total ÷ Total Parts',
    whatItIs:
        'Ratios define proportional relationships. If Alex and Ben share money 2:3, Alex gets 2 parts for every 3 parts Ben gets.',
    whyItWorks:
        'Dividing the total by the sum of parts gives the value of exactly 1 part. Multiplying by each person’s share distributes the total accurately.',
    howToSolveIt:
        'Step 1: Add the ratio numbers: 2 + 3 = 5 parts.\nStep 2: Divide total coins by 5: 60 ÷ 5 = 12 coins per part.\nStep 3: Ben has 3 parts: 3 × 12 = 36 coins.',
    whenToUseIt:
        'Use ratios when mixing paint, dividing lottery winnings fairly, and scaling business partnerships.',
    stepByStepExplanation:
        'Step 1: Total coins = 60. Ratio is 2 : 3.\nStep 2: Total number of parts = 2 + 3 = 5 equal parts.\nStep 3: Value of 1 part = 60 ÷ 5 = 12 coins.\nStep 4: Alex gets 2 parts = 2 × 12 = 24 coins.\nStep 5: Ben gets 3 parts = 3 × 12 = 36 coins.\nCheck: 24 + 36 = 60 coins.',
    workedExample:
        'Example: A shirt originally \$40 is discounted to \$30. What is the percent discount?\nChange is \$10. Divide by original: 10 / 40 = 25%.',
    takeaway: 'Always divide percentage change by the original value, not the new value.',
    commonMistakes: [
      'Dividing the total by only one side of the ratio instead of the sum of parts.',
      'Using the new price as the denominator when calculating percent change.',
    ],
    shortcutsAndTricks: [
      'Check your answer: Alex’s 24 plus Ben’s 36 must equal the original 60 total coins.',
    ],
    alternativeMethods: [
      'Fraction method: Ben receives 3/5 of the total: (3/5) × 60 = 36.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [30, 48, 70, 95],
    practiceQuestion: PracticeQuestion(
      question: 'Divide 60 coins between Alex and Ben in the ratio 2 : 3. How many coins does Ben receive?',
      correctAnswer: '36',
      hint: 'Total parts = 2 + 3 = 5 parts. 1 part = 60 ÷ 5 = 12. Ben gets 3 parts.',
      explanation: 'Total parts = 5. Each part = 60 ÷ 5 = 12. Ben gets 3 × 12 = 36 coins.',
      options: ['36', '24', '30', '40'],
      stepByStepGuidance: '60 ÷ (2 + 3) = 12. Ben gets 3 × 12 = 36.',
      wrongOptionExplanations: {
        '24': '24 is Alex’s share (2 parts). The question asked for Ben’s share.',
        '30': '30 would be an equal 1:1 split, not 2:3.',
        '40': 'Check your multiplication: 3 × 12 = 36.',
      },
    ),
    icon: Icons.balance_rounded,
  ),

  // Lesson 11
  const Lesson(
    id: 'stage2_lesson11_averages_word_problems',
    title: '11. Averages & Everyday Word Problems',
    category: 'Statistics',
    stage: 'Stage 2 – Basic Mathematics',
    stageIndex: 2,
    difficulty: 'Basic',
    conceptSummary:
        'The average (mean) is the sum divided by count. The key shortcut is the Total Sum Rule: Total Sum = Average × Count.',
    formula: 'Total Sum = Average × Number of Items',
    whatItIs:
        'The average balances out differences to represent what each item would be if all values were shared equally.',
    whyItWorks:
        'If 4 numbers have an average of 25, their combined total must be exactly 4 × 25 = 100.',
    howToSolveIt:
        'Step 1: Multiply the average by the count to find the target total sum.\nStep 2: Add up the known numbers.\nStep 3: Subtract the known sum from the target total to reveal the missing number.',
    whenToUseIt:
        'Use when calculating bowling scores, target exam grades, and monthly budget allowances.',
    stepByStepExplanation:
        'Step 1: The average of 4 numbers is 25.\nStep 2: Total sum = 4 × 25 = 100.\nStep 3: Three known numbers are 20, 25, and 30.\nStep 4: Sum of known numbers = 20 + 25 + 30 = 75.\nStep 5: Fourth number = 100 - 75 = 25.',
    workedExample:
        'Example: A student scores 80 and 90 on two tests. What must they score on test 3 to average 85?\nTarget sum = 3 × 85 = 255.\nCurrent sum = 80 + 90 = 170.\nTest 3 = 255 - 170 = 85.',
    takeaway: 'Convert average problems into total sums first: Total = Average × N.',
    commonMistakes: [
      'Averaging percentages directly without weighting by sample size.',
      'Dividing by the wrong count.',
    ],
    shortcutsAndTricks: [
      'Deviation trick: check how far each number is from the target average (+5, -5 cancel out).',
    ],
    alternativeMethods: [
      'Visual balance: imagine weights on a seesaw with the pivot at 25.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [35, 52, 85, 110],
    practiceQuestion: PracticeQuestion(
      question: 'The average of 4 numbers is 25. Three of the numbers are 20, 25, and 30. What is the fourth number?',
      correctAnswer: '25',
      hint: 'Total sum must be 4 × 25 = 100. Subtract the known sum (20 + 25 + 30 = 75).',
      explanation: 'Total required sum = 4 × 25 = 100. Known sum = 20 + 25 + 30 = 75. Fourth number = 100 - 75 = 25.',
      options: ['25', '20', '30', '35'],
      stepByStepGuidance: '100 - (20 + 25 + 30) = 100 - 75 = 25.',
      wrongOptionExplanations: {
        '20': 'A fourth number of 20 gives a total of 95 (average 23.75).',
        '30': 'A fourth number of 30 gives a total of 105 (average 26.25).',
        '35': 'Check your subtraction: 100 - 75 = 25.',
      },
    ),
    icon: Icons.bar_chart_rounded,
  ),

  // Lesson 12
  const Lesson(
    id: 'stage2_lesson12_squares_roots_cubes',
    title: '12. Squares, Square Roots & Cubes',
    category: 'Powers',
    stage: 'Stage 2 – Basic Mathematics',
    stageIndex: 2,
    difficulty: 'Basic',
    conceptSummary:
        'Squaring multiplies a number by itself (3² = 9). The square root (√) undoes squaring (√9 = 3). Cubing multiplies three times (4³ = 64).',
    formula: 'a² = a × a | √x² = x | a³ = a × a × a',
    whatItIs:
        'Squares represent the geometric area of square shapes. Cubes represent the volume of 3D boxes.',
    whyItWorks:
        'A square grid with 3 rows and 3 columns contains 3 × 3 = 9 tiles. Therefore 3² = 9.',
    howToSolveIt:
        'To find 3² + 4²: calculate each square first (3² = 9 and 4² = 16), then add them: 9 + 16 = 25.',
    whenToUseIt:
        'Used extensively in the Pythagorean theorem, floor tile planning, and physics energy formulas (E = mc²).',
    stepByStepExplanation:
        'Step 1: Calculate 3² = 3 × 3 = 9.\nStep 2: Calculate 4² = 4 × 4 = 16.\nStep 3: Add the two results: 9 + 16 = 25.\nNotice: 25 is also a perfect square (5² = 25).',
    workedExample:
        'Example: What is √144?\nWhat number times itself is 144? 12 × 12 = 144, so √144 = 12.',
    takeaway: 'Squares of negative numbers are always positive: (-5)² = 25.',
    commonMistakes: [
      'Multiplying by 2 instead of by itself: 3² is 3 × 3 = 9, NOT 3 × 2 = 6.',
      'Thinking √(a² + b²) = a + b (in 3² + 4² = 9 + 16 = 25, √25 is 5, not 3 + 4 = 7).',
    ],
    shortcutsAndTricks: [
      'Squaring numbers ending in 5: multiply tens digit by next integer and append 25 (35²: 3 × 4 = 12 → 1225).',
    ],
    alternativeMethods: [
      'Prime factor method: 144 = 12² = (2⁴ × 3²). Take half powers: 2² × 3 = 12.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [14, 26, 60, 105],
    practiceQuestion: PracticeQuestion(
      question: 'What is the value of: 3² + 4² = ?',
      correctAnswer: '25',
      hint: '3² = 9 and 4² = 16. Add them together.',
      explanation: '3² = 9 and 4² = 16. 9 + 16 = 25 (which equals 5²).',
      options: ['25', '14', '49', '24'],
      stepByStepGuidance: '9 + 16 = 25.',
      wrongOptionExplanations: {
        '14': 'You multiplied by 2: (3×2) + (4×2) = 6 + 8 = 14. Remember to multiply by itself!',
        '49': 'You added (3+4)=7 then squared 7²=49. Powers must be calculated first!',
        '24': 'Check your addition: 9 + 16 = 25, not 24.',
      },
    ),
    icon: Icons.crop_square_rounded,
  ),
];
