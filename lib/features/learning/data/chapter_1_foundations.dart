import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

final List<Lesson> chapter1Foundations = [
  // CHAPTER 1: FOUNDATIONAL ARITHMETIC & ORDER OF OPERATIONS
  // ===========================================================================

  // 1. Order of Operations (BODMAS / PEMDAS)
  const Lesson(
    id: 'topic_pemdas',
    title: '1. Order of Operations (BODMAS / PEMDAS)',
    category: 'Formula Precedence',
    chapter: 'Chapter 1: Foundational Arithmetic',
    chapterIndex: 1,
    difficulty: 'Beginner to Advanced',
    conceptSummary: 'Master algebraic evaluation hierarchy, left-to-right evaluation traps, and algebraic factoring shortcuts.',
    formula: 'BODMAS: Brackets → Orders (Powers/Roots) → Division & Multiplication → Addition & Subtraction',
    whatItIs:
        'Order of operations is the universal mathematical convention governing the exact sequence in which arithmetic operators must be evaluated to ensure every expression has a single, unambiguous truth value.',
    whyItWorks:
        'Multiplication represents repeated addition (3 × 4 = 4 + 4 + 4). Therefore, in 2 + 3 × 4, grouping the multiplication first (2 + 12 = 14) preserves the true grouping of quantities. Left-to-right parsing without hierarchy would treat it as (2 + 3) × 4 = 20, destroying the structural identity of the quantities.',
    howToSolveIt:
        '1. Step 1 (Brackets): Evaluate inside parentheses (), brackets [], or curly braces {} first from inside out.\n'
        '2. Step 2 (Orders / Exponents): Calculate all powers (x², x³) and roots (√x).\n'
        '3. Step 3 (Multiplication & Division): Equal precedence! Evaluate strictly left-to-right as they appear.\n'
        '4. Step 4 (Addition & Subtraction): Equal precedence! Evaluate strictly left-to-right as they appear.',
    whenToUseIt:
        'Use whenever an equation contains two or more different operators (+, -, ×, ÷, ^). In SMATH, visual formula riddles frequently place addition before multiplication or chaining division left-to-right to test your precedence discipline.',
    stepByStepExplanation:
        'When evaluating mathematical expressions, operations must follow strict hierarchical precedence:\n'
        '1. Parentheses/Brackets: Always simplify contents inside (), [], or {} first.\n'
        '2. Exponents/Orders: Powers (x², x³, x⁴) and roots (√x) take precedence next.\n'
        '3. Multiplication & Division: Possess equal precedence and must be executed strictly from left to right.\n'
        '4. Addition & Subtraction: Possess equal precedence and are evaluated left to right.\n\n'
        'Advanced Shortcut (Algebraic Identities):\n'
        '• (a⁴ - b⁴) ÷ (a² + b²) = a² - b²\n'
        '• (a³ - b³) ÷ (a - b) - ab = a² + b²',
    workedExample:
        'Example 1: 6 ÷ 2 × (1 + 2) = ?\n'
        'Step 1 (Parentheses): (1 + 2) = 3.\n'
        'Step 2 (Left-to-Right): 6 ÷ 2 = 3.\n'
        'Step 3 (Multiplication): 3 × 3 = 9.\n\n'
        'Example 2: 7 + 7 ÷ 7 + 7 × 7 - 7 = ?\n'
        'Step 1 (Division & Multiplication): 7 ÷ 7 = 1 and 7 × 7 = 49.\n'
        'Step 2 (Addition & Subtraction): 7 + 1 + 49 - 7 = 50.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Two-Operator Precedence',
        problem: '2 + 2 × 2 = ?',
        stepByStepSolution:
            '• Multiplication takes priority over addition: 2 × 2 = 4.\n'
            '• Then perform addition: 2 + 4 = 6.',
        answer: '6',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Left-to-Right Chained Operations',
        problem: '6 ÷ 2 × (1 + 2) = ?',
        stepByStepSolution:
            '• Step 1: Parentheses first: (1 + 2) = 3.\n'
            '• Step 2: Division and Multiplication have equal priority. Evaluate left to right: 6 ÷ 2 = 3.\n'
            '• Step 3: 3 × 3 = 9. (Common trap is multiplying 2 × 3 first to get 1, which violates left-to-right rule).',
        answer: '9',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Mixed Precedence Cancellation Grand Slam',
        problem: '7 + 7 ÷ 7 + 7 × 7 - 7 = ?',
        stepByStepSolution:
            '• High precedence first: 7 ÷ 7 = 1 and 7 × 7 = 49.\n'
            '• Rewrite expression: 7 + 1 + 49 - 7.\n'
            '• Notice +7 and -7 cancel out: 1 + 49 = 50.',
        answer: '50',
      ),
    ],
    commonMistakes: [
      'Evaluating strictly left-to-right without honoring operator hierarchy (e.g., computing 2 + 2 = 4, then 4 × 2 = 8).',
      'Thinking Multiplication ALWAYS comes before Division; they have identical precedence and must be solved left-to-right.',
      'Treating implicit multiplication like 2(3) as higher precedence than explicit division in 6 ÷ 2(3).',
    ],
    shortcutsAndTricks: [
      'Cancellation Shortcut: Scan for identical additive and subtractive terms (+k and -k) across terms to cancel them instantly before computing sums.',
      'Factoring Shortcut: (a³ - b³) ÷ (a - b) - ab simplifies identically to a² + b².',
      'Zero Multiplier: Any complex sub-expression multiplied by 0 evaluates to 0 immediately—do not waste time simplifying what is multiplied by zero.',
    ],
    alternativeMethods: [
      'Fractional Notation: Convert division into fractions: a ÷ b × c = (a/b) · c = (a · c) / b.',
      'Tree Diagramming: Draw an expression parse tree where operations deeper in the branches evaluate before the root.',
    ],
    sandboxType: SandboxDemoType.bodmas,
    linkedLevels: [1, 5, 9, 17, 20, 29, 43, 155, 295, 435],
    practiceQuestion: PracticeQuestion(
      question: 'Evaluate: 8 + 8 ÷ 4 + 8 × 2 - 4 = ?',
      correctAnswer: '22',
      hint: 'Perform division (8 ÷ 4) and multiplication (8 × 2) first, then add and subtract left to right.',
      explanation: '8 ÷ 4 = 2. 8 × 2 = 16. Then 8 + 2 + 16 - 4 = 10 + 16 - 4 = 26 - 4 = 22.',
      options: ['20', '22', '24', '28'],
      stepByStepGuidance: 'Identify high-priority operators: (8 ÷ 4) = 2 and (8 × 2) = 16. Now replace: 8 + 2 + 16 - 4. Add left to right: 10 + 16 = 26. Subtract 4: 26 - 4 = 22.',
      wrongOptionExplanations: {
        '20': 'Incorrect. Check the subtraction at the end: 26 - 4 is 22, not 20.',
        '24': 'Incorrect. Did you accidentally add the final 4 instead of subtracting it?',
        '28': 'Incorrect. Did you evaluate left to right without prioritizing division and multiplication?',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'What is the value of: 10 + 10 × 0 + 10 = ?',
        correctAnswer: '20',
        hint: 'Multiply before adding! 10 × 0 = 0.',
        explanation: '10 × 0 = 0. The expression becomes 10 + 0 + 10 = 20.',
        options: ['0', '10', '20', '30'],
        stepByStepGuidance: 'High precedence: 10 × 0 = 0. Now evaluate addition: 10 + 0 + 10 = 20.',
        wrongOptionExplanations: {
          '0': 'Common mistake! Multiplying by zero only zeroes out that single term (10 × 0 = 0), not the outer additions.',
          '10': 'Incorrect. You missed one of the outer +10 terms.',
          '30': 'Incorrect. Did you add 10 + 10 first before multiplying by zero?',
        },
      ),
      PracticeQuestion(
        question: 'Evaluate: 18 - 3 × (2 + 3) = ?',
        correctAnswer: '3',
        hint: 'Parentheses first: (2 + 3) = 5. Then multiply by 3, then subtract from 18.',
        explanation: '(2 + 3) = 5. 3 × 5 = 15. 18 - 15 = 3.',
        options: ['3', '15', '45', '75'],
        stepByStepGuidance: 'Parentheses: 2 + 3 = 5. Multiplication: 3 × 5 = 15. Subtraction: 18 - 15 = 3.',
        wrongOptionExplanations: {
          '15': 'Incorrect. 15 is the value of 3 × 5, which must still be subtracted from 18.',
          '45': 'Incorrect. Evaluating (18 - 3) first violates precedence!',
          '75': 'Incorrect. Double error in precedence order.',
        },
      ),
    ],
    icon: Icons.functions_rounded,
  ),

  // 2. Lateral Operators
  const Lesson(
    id: 'topic_operators',
    title: '2. Arithmetic Precedence & Lateral Operators',
    category: 'Lateral Operators',
    chapter: 'Chapter 1: Foundational Arithmetic',
    chapterIndex: 1,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Interpret custom symbol operations, composite binary definitions, and modulo arithmetic.',
    formula: 'a ★ b = a + 2b | a ⊕ b = ab + a + b | a ⊗ b = (ab mod 10) + (a+b)',
    whatItIs:
        'Lateral operator riddles introduce novel binary operators (e.g. ★, ⊕, ⊗) that do not follow standard arithmetic rules but are defined by an explicit mathematical rule mapping two inputs (a, b) to an output.',
    whyItWorks:
        'In abstract algebra, a binary operation is simply a function f(a, b). By defining a ★ b = f(a, b), we practice functional substitution and algebraic parameter binding.',
    howToSolveIt:
        '1. Step 1 (Identify Parameters): Identify the left operand as "a" and right operand as "b".\n'
        '2. Step 2 (Direct Substitution): Replace every occurrence of "a" and "b" in the definition with the specific numbers given.\n'
        '3. Step 3 (Inner Precedence): Solve the resulting standard arithmetic expression using BODMAS.\n'
        '4. Step 4 (Nested Operations): If evaluating (a ★ b) ★ c, evaluate inside parentheses first, then use that result as the new "a".',
    whenToUseIt:
        'Look for non-standard symbols like ★, ⊕, ⊗, ⊞, or riddle prompts stating "If 3 # 4 = 14 and 5 # 2 = 12, then 6 # 3 = ?".',
    stepByStepExplanation:
        'Lateral operator riddles introduce novel binary operators defined by explicit formulas:\n'
        '1. Substitute Strictly: Replace variables a and b with the given numbers in the operator definition.\n'
        '2. Double-Term Expansion: If a ⊕ b = ab + (a + b), compute the product and sum separately before adding.\n'
        '3. Modulo Operators: a mod m represents the remainder when a is divided by m (e.g., ab mod 10 extracts the last digit of the product).\n'
        '4. Nested Operations: For (a ★ b) ★ c, evaluate inside parentheses first, then apply the rule to the result with c.',
    workedExample:
        'Example: If a ★ b = a + 2b, then 5 ★ 4 = ?\n'
        '• Substitute a = 5, b = 4.\n'
        '• 5 + (2 × 4) = 5 + 8 = 13.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Linear Lateral Definition',
        problem: 'If a ★ b = 2a + b, find 3 ★ 4.',
        stepByStepSolution:
            '• Assign a = 3, b = 4.\n'
            '• 2(3) + 4 = 6 + 4 = 10.',
        answer: '10',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Composite Product & Sum Operator',
        problem: 'If a ⊕ b = (a × b) + (a + b), find 4 ⊕ 5.',
        stepByStepSolution:
            '• Compute product: 4 × 5 = 20.\n'
            '• Compute sum: 4 + 5 = 9.\n'
            '• Add them: 20 + 9 = 29.',
        answer: '29',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Nested Lateral Evaluation',
        problem: 'If a ★ b = 3a - b, find (2 ★ 1) ★ 3.',
        stepByStepSolution:
            '• Step 1 (Parentheses): 2 ★ 1 = 3(2) - 1 = 6 - 1 = 5.\n'
            '• Step 2: Now evaluate 5 ★ 3 = 3(5) - 3 = 15 - 3 = 12.',
        answer: '12',
      ),
    ],
    commonMistakes: [
      'Reversing the order of operands: lateral operations are rarely commutative (a ★ b ≠ b ★ a).',
      'Forgetting parentheses when substituting negative numbers or multi-digit values.',
    ],
    shortcutsAndTricks: [
      'Commutativity Check: Check if f(a, b) = f(b, a). If symmetric (like ab + a + b), swapping inputs does not change the result!',
      'Parity Shortcut: In rules like a + 2b, the term 2b is always even, so the parity (odd/even) of the result is determined entirely by a.',
    ],
    alternativeMethods: [
      'Tabular Function Grid: For small inputs, write a 2×2 quick value grid to verify consistency.',
    ],
    sandboxType: SandboxDemoType.operators,
    linkedLevels: [25, 39, 53, 67, 109, 207, 361],
    practiceQuestion: PracticeQuestion(
      question: 'If a ★ b = 2a + b, what is 3 ★ 4?',
      correctAnswer: '10',
      hint: 'Multiply the first number by 2, then add the second number: (2 × 3) + 4.',
      explanation: '(2 × 3) + 4 = 6 + 4 = 10.',
      options: ['8', '10', '12', '14'],
      stepByStepGuidance: 'Substitute a = 3 and b = 4 into the definition 2a + b. 2 × 3 = 6. 6 + 4 = 10.',
      wrongOptionExplanations: {
        '8': 'Incorrect. Did you forget to add b = 4?',
        '12': 'Incorrect. Did you multiply 3 by 4 instead of following the formula?',
        '14': 'Incorrect. Check your multiplication 2 × 3 = 6.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'If a ⊕ b = ab - a, what is 5 ⊕ 3?',
        correctAnswer: '10',
        hint: 'Multiply 5 by 3 (15), then subtract 5.',
        explanation: '5 × 3 = 15. 15 - 5 = 10.',
        options: ['8', '10', '12', '15'],
        stepByStepGuidance: 'Compute ab = 5 × 3 = 15. Subtract a = 5: 15 - 5 = 10.',
      ),
    ],
    icon: Icons.alt_route_rounded,
  ),

  // 3. Mathematical Tricks & Shortcuts
  const Lesson(
    id: 'topic_tricks',
    title: '3. Mathematical Tricks & Lateral Shortcuts',
    category: 'Mathematical Tricks',
    chapter: 'Chapter 1: Foundational Arithmetic',
    chapterIndex: 1,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Master handshakes, snail well escapes, harmonic round-trip speeds, clock angles, and balance scales.',
    formula: 'Handshakes: n(n-1)/2 | Snail: Depth - Up + 1 | Harmonic Speed: 2v1·v2 / (v1+v2) | Clock: |30H - 5.5M|°',
    whatItIs:
        'Mathematical trick riddles feature questions that appear difficult or paradoxical on the surface, but reduce to elegant single-line formulas once the underlying mathematical invariant is recognized.',
    whyItWorks:
        'Many trick riddles exploit naive intuition. For example, average round-trip speed is weighted by time, not distance; because more time is spent at the slower speed, the harmonic mean (not arithmetic mean) yields the true speed.',
    howToSolveIt:
        '1. Handshakes: In a group of n people, each person shakes hands with (n - 1) others. Divide by 2 to prevent double-counting: n(n-1)/2.\n'
        '2. Snail in the Well: On the final day, the snail reaches the top and exits without sliding back down. Days = (Depth - Daily Slip) / Net Climb.\n'
        '3. Clock Angles: The hour hand moves at 0.5° per minute (30° per hour). The minute hand moves at 6° per minute. Angle = |30H - 5.5M|°.\n'
        '4. Average Round-Trip Speed: Equal distance each way uses Harmonic Mean = 2·v1·v2 / (v1 + v2).',
    whenToUseIt:
        'Use when word problems involve round trips, meetings between people, analog watch faces, or climbing and slipping cycles.',
    stepByStepExplanation:
        'Trick riddles exploit lateral logic and counter-intuitive mathematical properties:\n'
        '1. Handshake Combinations: Every pair among n people shakes hands once: C(n, 2) = n(n - 1) / 2.\n'
        '2. Snail in the Well: A snail climbs U meters by day and slips D meters by night. On the final day, climbing U meters reaches the top and exits before nightfall! Days = Depth - U + 1.\n'
        '3. Round-Trip Average Speed: If traveling at v1 and returning at v2 over the same distance, average speed is the Harmonic Mean: (2·v1·v2) / (v1 + v2), NOT the arithmetic average!\n'
        '4. Analog Clock Angles: In M minutes, the minute hand moves 6° per minute (360°/60), while the hour hand moves 0.5° per minute (30°/60). Angle = |30H - 5.5M|°.\n'
        '5. Counterfeit Coins on Balance Scale: Each weighing divides candidates into 3 equal piles: Minimum weighings w satisfies 3^w ≥ N.',
    workedExample:
        'Example (Average Speed): Drive at 60 km/h, return at 40 km/h over the same distance. Average speed?\n'
        '• Harmonic formula: (2 × 60 × 40) / (60 + 40) = 4800 / 100 = 48 km/h.\n'
        '(Notice 48 km/h is slower than the naive average of 50 km/h because more time was spent at the slower speed!).',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Handshake Combination Formula',
        problem: '6 people in a meeting each shake hands with every other person once. How many total handshakes occur?',
        stepByStepSolution:
            '• Formula: n(n - 1) ÷ 2 with n = 6.\n'
            '• 6 × (6 - 1) ÷ 2 = 6 × 5 ÷ 2 = 30 ÷ 2 = 15.',
        answer: '15',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Analog Clock Angle at 3:20',
        problem: 'What is the angle between the hands of an analog clock at 3:20?',
        stepByStepSolution:
            '• Formula: |30H - 5.5M|° with H = 3, M = 20.\n'
            '• Hour hand angle: 30 × 3 = 90°.\n'
            '• Minute hand movement: 5.5 × 20 = 110°.\n'
            '• Absolute angle: |90 - 110| = |-20| = 20°.',
        answer: '20',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Harmonic Round-Trip Velocity',
        problem: 'Travel to city at 60 km/h, return at 40 km/h over the same road. What is the average speed for the full trip?',
        stepByStepSolution:
            '• Total Distance = 2D. Time 1 = D/60. Time 2 = D/40.\n'
            '• Average Speed = Total Distance ÷ Total Time = 2D ÷ (D/60 + D/40).\n'
            '• Formula: 2(60)(40) ÷ (60 + 40) = 4800 ÷ 100 = 48 km/h.',
        answer: '48',
      ),
    ],
    commonMistakes: [
      'Averaging speeds directly: (60 + 40)/2 = 50 is WRONG because the traveler spends more time traveling at the slower speed.',
      'Forgetting that on the last day, the snail exits the well before nightfall and does not slip back down.',
    ],
    shortcutsAndTricks: [
      'Handshake Quick Sum: Handshakes among n people equals the sum of the first (n-1) integers: 1 + 2 + ... + (n-1).',
      'Clock Perpendicularity: The hands form a 90° angle approximately twice every hour.',
    ],
    alternativeMethods: [
      'Assume Concrete Distance: When solving round-trip speeds, pick an easy test distance like LCM(60, 40) = 120 km. Outbound time = 2 hrs, return time = 3 hrs. Total 240 km ÷ 5 hrs = 48 km/h!',
    ],
    sandboxType: SandboxDemoType.tricks,
    linkedLevels: [13, 27, 41, 55, 111, 209, 363],
    practiceQuestion: PracticeQuestion(
      question: '6 people in a room each shake hands with everyone once. How many total handshakes occur?',
      correctAnswer: '15',
      hint: 'Use the combination formula: n(n - 1) / 2 with n = 6.',
      explanation: '6 × (6 - 1) / 2 = 6 × 5 / 2 = 30 / 2 = 15 handshakes.',
      options: ['12', '15', '18', '30'],
      stepByStepGuidance: 'Plug n = 6 into n(n - 1) / 2. 6 × 5 = 30. 30 ÷ 2 = 15.',
      wrongOptionExplanations: {
        '12': 'Incorrect. Check formula calculation 6 × 5 / 2.',
        '18': 'Incorrect. Formula is 6 × 5 / 2 = 15.',
        '30': 'Incorrect. 30 counts each handshake twice! You must divide by 2.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'What is the angle between clock hands at 4:00?',
        correctAnswer: '120',
        hint: 'Each hour mark is 30 degrees (360° / 12). 4 hours × 30° = ?',
        explanation: 'At 4:00, minute hand is at 12 and hour hand is at 4. 4 × 30° = 120°.',
        options: ['90', '100', '120', '140'],
      ),
    ],
    icon: Icons.lightbulb_rounded,
  ),

  // ===========================================================================
];
