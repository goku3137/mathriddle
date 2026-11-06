import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

/// Stage 3: Intermediate Mathematics
/// Transitions learners into algebra, equations, sequences, exponents, and rate mechanics.
final List<Lesson> stage3IntermediateMathematics = [
  // Lesson 13
  const Lesson(
    id: 'stage3_lesson13_algebra_fundamentals',
    title: '13. Algebra Fundamentals & Simplifying Expressions',
    category: 'Algebra',
    stage: 'Stage 3 – Intermediate Mathematics',
    stageIndex: 3,
    difficulty: 'Intermediate',
    conceptSummary:
        'A variable (like x) is a container holding an unknown number. We simplify expressions by combining like terms and expanding brackets.',
    formula: 'Distributive Law: a(b + c) = ab + ac | Combine like terms',
    whatItIs:
        'Algebra allows us to write general mathematical statements and solve for unknowns rather than guessing numbers.',
    whyItWorks:
        'Multiplying an entire group inside brackets multiplies every individual term inside: 3(2x - 1) = 6x - 3.',
    howToSolveIt:
        'Step 1: Expand brackets using multiplication.\nStep 2: Collect terms that have the same variable letters.\nStep 3: Combine constant numbers.',
    whenToUseIt:
        'Use algebra whenever a riddle or financial problem has an unknown quantity.',
    stepByStepExplanation:
        'Step 1: Given expression: 3(2x - 1) - 2x with x = 4.\nStep 2: Expand bracket: 3 × 2x = 6x, and 3 × (-1) = -3.\nStep 3: Expression becomes: 6x - 3 - 2x.\nStep 4: Combine like terms: (6x - 2x) - 3 = 4x - 3.\nStep 5: Substitute x = 4: 4(4) - 3 = 16 - 3 = 13.',
    workedExample:
        'Example: Simplify 5x + 7 - 2x + 4.\nGroup like terms: (5x - 2x) + (7 + 4) = 3x + 11.',
    takeaway: 'Terms can only be combined if they have the exact same variable and power.',
    commonMistakes: [
      'Combining unlike terms: 3x + 5 is NOT 8x!',
      'Forgetting to multiply the second term inside brackets: 3(x - 2) is 3x - 6, not 3x - 2.',
    ],
    shortcutsAndTricks: [
      'Substitute the value early or late: both give the exact same answer (3(8-1)-8 = 21-8 = 13).',
    ],
    alternativeMethods: [
      'Evaluate directly: x = 4 → inside brackets is 2(4)-1 = 7. Then 3(7) - 2(4) = 21 - 8 = 13.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [40, 75, 120, 160],
    practiceQuestion: PracticeQuestion(
      question: 'Evaluate the algebraic expression: If x = 4, what is 3(2x - 1) - 2x?',
      correctAnswer: '13',
      hint: 'Substitute x = 4 into 2x - 1 first, or expand 3(2x - 1) to 6x - 3.',
      explanation: 'With x = 4: 2x - 1 = 7. Then 3(7) - 2(4) = 21 - 8 = 13.',
      options: ['13', '15', '11', '18'],
      stepByStepGuidance: '3(7) - 8 = 21 - 8 = 13.',
      wrongOptionExplanations: {
        '15': 'You may have made an error expanding the negative sign.',
        '11': 'Check the subtraction: 21 - 8 = 13, not 11.',
        '18': 'Check the multiplication: 3 × 7 = 21, then 21 - 8 = 13.',
      },
    ),
    icon: Icons.functions_rounded,
  ),

  // Lesson 14 (Preserves topic_equations)
  const Lesson(
    id: 'topic_equations',
    title: '14. Solving Linear Equations (Balance Method)',
    category: 'Equation Riddles',
    stage: 'Stage 3 – Intermediate Mathematics',
    stageIndex: 3,
    difficulty: 'Intermediate',
    conceptSummary:
        'An equation is a perfectly balanced scale. Whatever operation you apply to one side, you must apply equally to the other side to isolate x.',
    formula: 'ax + b = c ⟹ ax = c - b ⟹ x = (c - b) / a',
    whatItIs:
        'The balance method systematically strips away surrounding operations until the unknown variable stands alone.',
    whyItWorks:
        'Maintaining identical operations on both sides preserves equality: if two quantities are equal, adding or subtracting equal amounts leaves them equal.',
    howToSolveIt:
        'Work backwards through the order of operations:\n1. Undo addition or subtraction first.\n2. Undo multiplication or division second.',
    whenToUseIt:
        'Used in finding missing weights, puzzle deductions, and financial breakeven points.',
    stepByStepExplanation:
        'Step 1: Solve 3x - 7 = 17.\nStep 2: Undo the subtraction of 7 by adding 7 to BOTH sides:\n  3x - 7 + 7 = 17 + 7\n  3x = 24.\nStep 3: Undo the multiplication of 3 by dividing BOTH sides by 3:\n  3x ÷ 3 = 24 ÷ 3\n  x = 8.\nCheck: 3(8) - 7 = 24 - 7 = 17. Verified!',
    workedExample:
        'Example: Solve 2x + 10 = 24.\nSubtract 10: 2x = 14.\nDivide by 2: x = 7.',
    takeaway: 'Undo operations in reverse order: undo plus/minus first, then undo times/divide.',
    commonMistakes: [
      'Performing an operation on only one side of the equals sign.',
      'Dividing before subtracting the loose constant term.',
    ],
    shortcutsAndTricks: [
      'Moving a term across the equals sign flips its sign: + becomes -, and - becomes +.',
    ],
    alternativeMethods: [
      'Cover-up method: cover "3x" with your thumb. Thumb - 7 = 17, so thumb must be 24. 3x = 24 → x = 8.',
    ],
    sandboxType: SandboxDemoType.equations,
    linkedLevels: [2, 16, 32, 64, 128],
    practiceQuestion: PracticeQuestion(
      question: 'Solve for x: 3x - 7 = 17. What is x?',
      correctAnswer: '8',
      hint: 'Add 7 to both sides (giving 3x = 24), then divide by 3.',
      explanation: '3x = 17 + 7 = 24. Dividing by 3 gives x = 8.',
      options: ['8', '7', '6', '9'],
      stepByStepGuidance: '3x = 24 ⟹ x = 24 ÷ 3 = 8.',
      wrongOptionExplanations: {
        '7': '3(7) - 7 = 21 - 7 = 14, not 17.',
        '6': '3(6) - 7 = 18 - 7 = 11, not 17.',
        '9': '3(9) - 7 = 27 - 7 = 20, not 17.',
      },
    ),
    icon: Icons.balance_rounded,
  ),

  // Lesson 15
  const Lesson(
    id: 'stage3_lesson15_inequalities',
    title: '15. Simple Inequalities & Number Constraints',
    category: 'Algebra',
    stage: 'Stage 3 – Intermediate Mathematics',
    stageIndex: 3,
    difficulty: 'Intermediate',
    conceptSummary:
        'Inequalities (<, ≤, >, ≥) describe ranges. Solving is identical to equations, except multiplying or dividing by a negative number flips the inequality symbol.',
    formula: 'ax + b < c | Multiply/Divide by negative: flip < to >',
    whatItIs:
        'Instead of a single specific value, inequalities define boundaries and acceptable limits (e.g., spending limits, speed limits).',
    whyItWorks:
        'Because 2 < 5, but multiplying by -1 gives -2 and -5. On a number line, -2 is greater than -5 (-2 > -5), reversing the order.',
    howToSolveIt:
        'Step 1: Subtract or add loose terms from both sides.\nStep 2: Divide by the coefficient.\nStep 3: Find the largest whole number strictly inside the boundary.',
    whenToUseIt:
        'Use when finding maximum capacity, budgeting within limits, or threshold testing in code.',
    stepByStepExplanation:
        'Step 1: Given 4x + 5 < 29.\nStep 2: Subtract 5 from both sides: 4x < 24.\nStep 3: Divide by positive 4 (no flip needed): x < 6.\nStep 4: The inequality states x must be strictly less than 6.\nStep 5: The largest integer strictly less than 6 is 5.',
    workedExample:
        'Example: Solve -2x < 10.\nDivide by -2 and flip sign: x > -5.',
    takeaway: 'Strict inequality (<) does NOT include the endpoint; less than 6 means 5 is the max integer.',
    commonMistakes: [
      'Selecting the boundary number (6) when the symbol is strictly less than (<) rather than ≤.',
      'Forgetting to flip the symbol when dividing by a negative number.',
    ],
    shortcutsAndTricks: [
      'Test your answer: with x = 5, 4(5) + 5 = 25 < 29 (True!). With x = 6, 4(6) + 5 = 29 < 29 (False).',
    ],
    alternativeMethods: [
      'Number line plotting: draw an open circle at 6 and shade everything to the left.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [55, 80, 135, 175],
    practiceQuestion: PracticeQuestion(
      question: 'What is the largest integer value of x that satisfies: 4x + 5 < 29?',
      correctAnswer: '5',
      hint: '4x < 24, which means x < 6. What is the biggest whole number strictly less than 6?',
      explanation: '4x < 24 ⟹ x < 6. Since x must be strictly less than 6, the largest integer is 5.',
      options: ['5', '6', '4', '7'],
      stepByStepGuidance: '4x < 24 ⟹ x < 6. Largest whole number is 5.',
      wrongOptionExplanations: {
        '6': 'If x = 6, 4(6) + 5 = 29, which is not strictly less than 29.',
        '4': '4 satisfies the inequality, but 5 is larger and also satisfies it.',
        '7': '7 gives 33, which is greater than 29.',
      },
    ),
    icon: Icons.linear_scale_rounded,
  ),

  // Lesson 16 (Preserves topic_sequences)
  const Lesson(
    id: 'topic_sequences',
    title: '16. Number Sequences: AP & GP',
    category: 'Sequences',
    stage: 'Stage 3 – Intermediate Mathematics',
    stageIndex: 3,
    difficulty: 'Intermediate',
    conceptSummary:
        'In an Arithmetic Progression (AP), add a constant difference d. In a Geometric Progression (GP), multiply by a constant ratio r.',
    formula: 'AP: an = a1 + (n - 1)d | GP: an = a1 × r^(n - 1)',
    whatItIs:
        'Sequences are ordered lists of numbers following a strict generative rule.',
    whyItWorks:
        'In a geometric sequence, each step multiplies by the ratio r. To reach the n-th term from the 1st term requires multiplying by r exactly (n - 1) times.',
    howToSolveIt:
        'Step 1: Identify if the pattern is adding (AP) or multiplying (GP).\nStep 2: Find the multiplier r by dividing term 2 by term 1.\nStep 3: Apply an = a1 × r^(n - 1).',
    whenToUseIt:
        'Used in compound interest calculations, viral growth models, and puzzle level patterns.',
    stepByStepExplanation:
        'Step 1: Examine sequence: 2, 6, 18, 54, ...\nStep 2: Check ratio: 6 ÷ 2 = 3, 18 ÷ 6 = 3. This is a GP with r = 3 and a1 = 2.\nStep 3: We want the 6th term (n = 6):\n  Term 1: 2\n  Term 2: 2 × 3 = 6\n  Term 3: 6 × 3 = 18\n  Term 4: 18 × 3 = 54\n  Term 5: 54 × 3 = 162\n  Term 6: 162 × 3 = 486.\nFormula: 2 × 3⁵ = 2 × 243 = 486.',
    workedExample:
        'Example: Find the 10th term of AP: 3, 7, 11, ...\nDifference d = 4. Term 10 = 3 + 9(4) = 3 + 36 = 39.',
    takeaway: 'In AP you repeatedly add; in GP you repeatedly multiply.',
    commonMistakes: [
      'Using power n instead of n - 1 (multiplying 6 times instead of 5 times for the 6th term).',
      'Confusing an arithmetic step with a geometric ratio.',
    ],
    shortcutsAndTricks: [
      'Powers of 3: 3¹=3, 3²=9, 3³=27, 3⁴=81, 3⁵=243. 2 × 243 = 486.',
    ],
    alternativeMethods: [
      'Multiply step by step until you reach the 6th term: 2 → 6 → 18 → 54 → 162 → 486.',
    ],
    sandboxType: SandboxDemoType.sequences,
    linkedLevels: [6, 18, 38, 72, 144],
    practiceQuestion: PracticeQuestion(
      question: 'Find the 6th term of the geometric sequence: 2, 6, 18, 54, ...',
      correctAnswer: '486',
      hint: 'Each number is multiplied by 3. Multiply term 4 (54) by 3 to get term 5, then by 3 again.',
      explanation: 'Common ratio r = 3. Term 5 = 54 × 3 = 162. Term 6 = 162 × 3 = 486.',
      options: ['486', '162', '324', '512'],
      stepByStepGuidance: '2 × 3⁵ = 2 × 243 = 486.',
      wrongOptionExplanations: {
        '162': '162 is the 5th term, not the 6th term.',
        '324': 'You multiplied 162 by 2 instead of the ratio 3.',
        '512': '512 is 2⁹ (a power of 2, not a power of 3).',
      },
    ),
    icon: Icons.trending_up_rounded,
  ),

  // Lesson 17
  const Lesson(
    id: 'stage3_lesson17_exponents_powers',
    title: '17. Exponents, Powers & Scientific Notation',
    category: 'Exponents',
    stage: 'Stage 3 – Intermediate Mathematics',
    stageIndex: 3,
    difficulty: 'Intermediate',
    conceptSummary:
        'Exponents follow index laws: aᵐ × aⁿ = aᵐ⁺ⁿ, aᵐ ÷ aⁿ = aᵐ⁻ⁿ, and any non-zero number to power 0 equals 1 (a⁰ = 1).',
    formula: 'Product Rule: aᵐ × aⁿ = aᵐ⁺ⁿ | Quotient Rule: aᵐ ÷ aⁿ = aᵐ⁻ⁿ',
    whatItIs:
        'Exponents count how many times a base multiplies itself. The index rules allow instant simplification without calculating huge numbers.',
    whyItWorks:
        '2³ × 2² = (2 × 2 × 2) × (2 × 2) = 2⁵. The total number of 2s multiplied together is simply the sum of exponents (3 + 2 = 5).',
    howToSolveIt:
        'Step 1: When multiplying like bases, add their exponents.\nStep 2: When dividing like bases, subtract the bottom exponent from the top.',
    whenToUseIt:
        'Used in scientific notation, computing memory byte sizes (gigabytes), and radioactive decay.',
    stepByStepExplanation:
        'Step 1: Simplify (2³ × 2²) ÷ 2⁴.\nStep 2: Multiply numerator: 2³ × 2² = 2³⁺² = 2⁵.\nStep 3: Divide by denominator: 2⁵ ÷ 2⁴ = 2⁵⁻⁴ = 2¹.\nStep 4: Any number to the power of 1 is the number itself: 2¹ = 2.',
    workedExample:
        'Example: What is 5⁰ + 2³?\n5⁰ = 1 and 2³ = 8. Sum = 1 + 8 = 9.',
    takeaway: 'Any non-zero base raised to power 0 equals 1.',
    commonMistakes: [
      'Multiplying bases when multiplying powers: 2³ × 2² is 2⁵, NOT 4⁵!',
      'Thinking a⁰ = 0 (anything to power 0 is 1).',
    ],
    shortcutsAndTricks: [
      'Calculate powers of 2 using your fingers: 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024.',
    ],
    alternativeMethods: [
      'Expand fully: (8 × 4) ÷ 16 = 32 ÷ 16 = 2.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [65, 90, 140, 180],
    practiceQuestion: PracticeQuestion(
      question: 'Simplify and evaluate: (2³ × 2²) ÷ 2⁴ = ?',
      correctAnswer: '2',
      hint: 'Add exponents on top (3 + 2 = 5), then subtract denominator exponent (5 - 4 = 1).',
      explanation: '2³ × 2² = 2⁵ = 32. Then 32 ÷ 2⁴ = 32 ÷ 16 = 2 (or 2⁵⁻⁴ = 2¹ = 2).',
      options: ['2', '4', '8', '1'],
      stepByStepGuidance: '2^(3+2-4) = 2¹ = 2.',
      wrongOptionExplanations: {
        '4': '2² = 4, but our power is 5 - 4 = 1, so 2¹ = 2.',
        '8': '8 is 2³, not 2¹.',
        '1': '1 would be 2⁰.',
      },
    ),
    icon: Icons.superscript_rounded,
  ),

  // Lesson 18 (Preserves topic_money)
  const Lesson(
    id: 'topic_money',
    title: '18. Rates, Speed, Distance & Work Problems',
    category: 'Money & Shopping',
    stage: 'Stage 3 – Intermediate Mathematics',
    stageIndex: 3,
    difficulty: 'Intermediate',
    conceptSummary:
        'Rate connects output over time: Distance = Speed × Time. For work problems, add individual working rates together.',
    formula: 'Distance = Speed × Time | Time = Distance ÷ Speed',
    whatItIs:
        'Rate mechanics govern motion, manufacturing outputs, and simple financial interest over time.',
    whyItWorks:
        'If a train moves 75 kilometers every single hour, in 4 hours it travels 4 groups of 75 km.',
    howToSolveIt:
        'Step 1: Check units (km/h and hours match).\nStep 2: Multiply speed by time to get total distance.\nStep 3: Double 75 twice for instant mental arithmetic.',
    whenToUseIt:
        'Use when planning road trip travel time, fuel consumption, and project delivery schedules.',
    stepByStepExplanation:
        'Step 1: Speed = 75 km/h.\nStep 2: Time = 4 hours.\nStep 3: Distance = Speed × Time = 75 × 4.\nStep 4: Mental shortcut: 75 × 2 = 150, and 150 × 2 = 300.\nTotal Distance = 300 km.',
    workedExample:
        'Example: How long does it take to drive 240 miles at 60 mph?\nTime = Distance ÷ Speed = 240 ÷ 60 = 4 hours.',
    takeaway: 'Multiply to find distance; divide to find speed or travel time.',
    commonMistakes: [
      'Multiplying speed by time when units do not match (e.g., minutes instead of hours).',
      'Averaging speeds directly over equal distances instead of using harmonic mean.',
    ],
    shortcutsAndTricks: [
      'Multiplying by 4 is always doubling twice: 75 → 150 → 300.',
    ],
    alternativeMethods: [
      'Add distance hour by hour: Hour 1 (75), Hour 2 (150), Hour 3 (225), Hour 4 (300).',
    ],
    sandboxType: SandboxDemoType.money,
    linkedLevels: [20, 42, 84, 168],
    practiceQuestion: PracticeQuestion(
      question: 'A train travels at a constant speed of 75 km/h for 4 hours. How many kilometers did it travel?',
      correctAnswer: '300',
      hint: 'Distance = Speed × Time. Multiply 75 by 4.',
      explanation: 'Distance = 75 km/h × 4 h = 300 km.',
      options: ['300', '250', '325', '275'],
      stepByStepGuidance: '75 × 4 = 300.',
      wrongOptionExplanations: {
        '250': 'Check your multiplication: 75 × 4 = 300, not 250.',
        '325': 'Check your addition: 75 × 4 = 300.',
        '275': 'Check mental math: 75 × 2 = 150, 150 × 2 = 300.',
      },
    ),
    icon: Icons.speed_rounded,
  ),
];
