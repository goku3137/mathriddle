import 'package:flutter/material.dart';
import '../models/lesson_model.dart';

final List<Lesson> learningCurriculum = [
  // ===========================================================================
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
  // CHAPTER 2: SEQUENCES, PATTERNS & RECURRENCES
  // ===========================================================================

  // 4. Number Pattern Riddles
  const Lesson(
    id: 'topic_patterns',
    title: '4. Number Patterns & Lateral Progressions',
    category: 'Number Patterns',
    chapter: 'Chapter 2: Sequences & Patterns',
    chapterIndex: 2,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Identify constant steps, alternating operators, second-order differences, and interleaved chains.',
    formula: 'Δ_k = Term_{k+1} - Term_k | Quadratic: n² + cn + d | Interleaved: Odd/Even split',
    whatItIs:
        'Number patterns are ordered sequences of numerical terms generated by a recurring mathematical rule relating each term to its position or predecessors.',
    whyItWorks:
        'Calculus of finite differences proves that any polynomial sequence of degree d has constant differences at the d-th order (e.g. quadratic sequences have constant 2nd differences; cubic sequences have constant 3rd differences).',
    howToSolveIt:
        '1. Step 1 (First Differences Δ1): Subtract adjacent terms: T2 - T1, T3 - T2. If constant, the rule is linear (+d).\n'
        '2. Step 2 (Second Differences Δ2): If Δ1 grows steadily, subtract differences. Constant Δ2 means a quadratic rule (n²).\n'
        '3. Step 3 (Alternating Operators): Check if operations alternate (+a, ×b, +a, ×b).\n'
        '4. Step 4 (Interleaved Split): Split odd and even positions into two separate independent sequences.',
    whenToUseIt:
        'Whenever a riddle displays a horizontal row of numbers ending in "?" like 2, 5, 10, 13, 26, ?.',
    stepByStepExplanation:
        'When analyzing an unfamiliar sequence of numbers:\n'
        '1. Find the First Differences (Δ1): Subtract each term from its successor. If constant, it is arithmetic (+d).\n'
        '2. Find the Second Differences (Δ2): If the differences themselves grow at a steady rate (+acc), the pattern is quadratic (n²).\n'
        '3. Test Alternating Operations: Many riddles alternate between two operations, e.g., (+a, ×b, +a, ×b).\n'
        '4. Check for Interleaved Sequences: Odd-positioned terms (1st, 3rd, 5th) may follow one rule, while even-positioned terms (2nd, 4th, 6th) follow another.',
    workedExample:
        'Example 1 (Alternating): 2, 5, 10, 13, 26, ?\n'
        '• 2 + 3 = 5\n'
        '• 5 × 2 = 10\n'
        '• 10 + 3 = 13\n'
        '• 13 × 2 = 26\n'
        'Next operation is +3: 26 + 3 = 29.\n\n'
        'Example 2 (Cubic Differences): 2, 3, 11, 38, ?\n'
        'Differences: +1 (1³), +8 (2³), +27 (3³). Next is +64 (4³): 38 + 64 = 102.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Alternating Operations (+4, ×2)',
        problem: '3, 7, 14, 18, 36, ?',
        stepByStepSolution:
            '• 3 + 4 = 7\n'
            '• 7 × 2 = 14\n'
            '• 14 + 4 = 18\n'
            '• 18 × 2 = 36\n'
            '• Next operation is +4: 36 + 4 = 40.',
        answer: '40',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Second-Order Quadratic Differences',
        problem: '2, 5, 10, 17, 26, ?',
        stepByStepSolution:
            '• First differences: 5-2 = +3, 10-5 = +5, 17-10 = +7, 26-17 = +9.\n'
            '• The differences are odd numbers increasing by 2.\n'
            '• Next difference is +11: 26 + 11 = 37 (Rule: n² + 1).',
        answer: '37',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Interleaved Twin Chains',
        problem: '4, 20, 7, 17, 10, 14, 13, ?',
        stepByStepSolution:
            '• Separate odd positions: 4, 7, 10, 13 (+3 each step).\n'
            '• Separate even positions: 20, 17, 14, ? (-3 each step).\n'
            '• Next even term is 14 - 3 = 11.',
        answer: '11',
      ),
    ],
    commonMistakes: [
      'Assuming the rule is always single-operator (+k) without checking if operations alternate (+, ×, +, ×).',
      'Missing interleaved chains when terms fluctuate up and down irregularly.',
    ],
    shortcutsAndTricks: [
      'N-Squared Plus Constant: Compare terms with perfect squares (1, 4, 9, 16, 25, 36...). If each is shifted by a constant (e.g. +1: 2, 5, 10, 17, 26), the formula is n² + 1 immediately!',
    ],
    alternativeMethods: [
      'Ratio Testing: Divide consecutive terms T(k+1) / T(k). If ratio is constant, the sequence is geometric.',
    ],
    sandboxType: SandboxDemoType.patterns,
    linkedLevels: [30, 44, 58, 100, 156, 296, 436],
    practiceQuestion: PracticeQuestion(
      question: 'What is the next number: 3, 7, 14, 18, 36, ?',
      correctAnswer: '40',
      hint: 'Inspect the operations between consecutive numbers: (+4, ×2, +4, ×2...).',
      explanation: 'The pattern alternates +4 and ×2: 3+4=7, 7×2=14, 14+4=18, 18×2=36. Next is 36 + 4 = 40.',
      options: ['38', '40', '42', '72'],
      stepByStepGuidance: 'Check differences: 3 to 7 is +4. 7 to 14 is ×2. 14 to 18 is +4. 18 to 36 is ×2. Next operation must be +4: 36 + 4 = 40.',
      wrongOptionExplanations: {
        '38': 'Incorrect. Did you add 2 instead of 4?',
        '42': 'Incorrect. Check the addition step 36 + 4 = 40.',
        '72': 'Incorrect. 72 would be 36 × 2, but the pattern alternates (+4, ×2, +4, ×2). The next operation is +4.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Find the next term: 2, 6, 12, 20, 30, ?',
        correctAnswer: '42',
        hint: 'Inspect the differences: +4, +6, +8, +10. What is next?',
        explanation: 'Differences increase by 2: +4, +6, +8, +10, +12. 30 + 12 = 42 (also n(n+1): 6 × 7 = 42).',
        options: ['38', '40', '42', '44'],
      ),
    ],
    icon: Icons.trending_up_rounded,
  ),

  // 5. Mathematical Sequences
  const Lesson(
    id: 'topic_sequences',
    title: '5. Mathematical Sequences & Recurrence',
    category: 'Sequences',
    chapter: 'Chapter 2: Sequences & Patterns',
    chapterIndex: 2,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Explore geometric doubling, square series, Fibonacci recurrences, and Tribonacci sums.',
    formula: 'Fibonacci: F_n = F_{n-1} + F_{n-2} | Tribonacci: T_n = T_{n-1} + T_{n-2} + T_{n-3}',
    whatItIs:
        'A sequence recurrence relation expresses each term as a mathematical function of its preceding terms, defining sequences such as Fibonacci, Tribonacci, and geometric doublings.',
    whyItWorks:
        'Recurrence relations model growth dynamics where current capacity depends directly on prior states (e.g. population reproduction, branching logic trees).',
    howToSolveIt:
        '1. Test 2-term sum: Does Term 3 = Term 1 + Term 2? If so, it is a Fibonacci-type sequence.\n'
        '2. Test 3-term sum: Does Term 4 = Term 1 + Term 2 + Term 3? If so, it is Tribonacci.\n'
        '3. Test Prime filters: 2, 3, 5, 7, 11, 13, 17, 19, 23 (numbers with exactly two divisors).\n'
        '4. Test Factorial growth: 1, 2, 6, 24, 120 (n!).',
    whenToUseIt:
        'Use when terms start slow and grow at accelerating rates (e.g., 1, 1, 2, 3, 5, 8, 13).',
    stepByStepExplanation:
        'A mathematical sequence is governed by a recurring formula connecting subsequent terms:\n'
        '1. Geometric Multipliers: Each term is multiplied by a constant ratio (e.g., ×2: 3, 6, 12, 24, 48).\n'
        '2. Square Series: Consecutive perfect squares n²: 1, 4, 9, 16, 25, 36, 49...\n'
        '3. Fibonacci Recurrence: Each term equals the sum of the two preceding terms (e.g., 2, 3, 5, 8, 13, 21).\n'
        '4. Tribonacci Recurrence: Each term equals the sum of the three preceding terms (e.g., 1, 2, 3, 6, 11, 20).\n'
        '5. Prime Number Sequences: Numbers with exactly two distinct divisors: 2, 3, 5, 7, 11, 13, 17, 19, 23...',
    workedExample:
        'Example: 2, 3, 5, 8, 13, ?\n'
        'Observe: 2 + 3 = 5, 3 + 5 = 8, 5 + 8 = 13.\n'
        'Next term is the sum of the last two: 8 + 13 = 21.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Classic Fibonacci Recurrence',
        problem: '3, 5, 8, 13, 21, ?',
        stepByStepSolution:
            '• Notice: 3 + 5 = 8, 5 + 8 = 13, 8 + 13 = 21.\n'
            '• Next term is 13 + 21 = 34.',
        answer: '34',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Tribonacci (Three-Term Sum)',
        problem: '1, 2, 4, 7, 13, 24, ?',
        stepByStepSolution:
            '• 1 + 2 + 4 = 7\n'
            '• 2 + 4 + 7 = 13\n'
            '• 4 + 7 + 13 = 24\n'
            '• Next term is sum of last three: 7 + 13 + 24 = 44.',
        answer: '44',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Prime Squared Sequences',
        problem: '4, 9, 25, 49, 121, ?',
        stepByStepSolution:
            '• Recognize the roots: √4 = 2, √9 = 3, √25 = 5, √49 = 7, √121 = 11.\n'
            '• The bases are prime numbers: 2, 3, 5, 7, 11.\n'
            '• The next prime is 13. Therefore, 13² = 169.',
        answer: '169',
      ),
    ],
    commonMistakes: [
      'Assuming 1 is a prime number (primes have strictly two distinct divisors; 1 only has one).',
      'Confusing Fibonacci with powers of two.',
    ],
    shortcutsAndTricks: [
      'Golden Ratio Limit: In Fibonacci sequences, F(n+1) / F(n) rapidly converges to the Golden Ratio φ ≈ 1.618.',
    ],
    alternativeMethods: [
      'Binet\'s Formula: F(n) = (φ^n - ψ^n) / √5 to calculate any Fibonacci index directly.',
    ],
    sandboxType: SandboxDemoType.sequences,
    linkedLevels: [19, 34, 48, 62, 104, 300, 440],
    practiceQuestion: PracticeQuestion(
      question: 'Find the next term: 3, 5, 8, 13, 21, ?',
      correctAnswer: '34',
      hint: 'Each number is the sum of the two preceding numbers (Fibonacci rule).',
      explanation: '13 + 21 = 34.',
      options: ['31', '33', '34', '36'],
      stepByStepGuidance: 'Add the last two terms: 13 + 21 = 34.',
      wrongOptionExplanations: {
        '31': 'Incorrect. Check addition 13 + 21 = 34.',
        '33': 'Incorrect. Off by one.',
        '36': 'Incorrect. Did you add 15 instead of 13?',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'What is the 10th Fibonacci number starting 1, 1, 2, 3, 5, 8, 13, 21, 34, ?',
        correctAnswer: '55',
        hint: 'Add the 8th term (21) and 9th term (34).',
        explanation: '21 + 34 = 55. F(10) = 55.',
        options: ['48', '50', '55', '60'],
      ),
    ],
    icon: Icons.auto_stories_rounded,
  ),

  // 6. Number Mazes
  const Lesson(
    id: 'topic_mazes',
    title: '6. Number Mazes & Algorithmic Pathways',
    category: 'Number Mazes',
    chapter: 'Chapter 2: Sequences & Patterns',
    chapterIndex: 2,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Follow step-by-step arithmetic chains, path branching, backward exits, and Collatz simulations.',
    formula: 'Forward: s → (op1) → (op2) | Backward: Exit → (inv_op2) → (inv_op1) | Collatz: Even: ÷2, Odd: ×3+1',
    whatItIs:
        'Number mazes are directional arithmetic graphs where a starting value undergoes a sequence of mathematical operations along a pathway to produce an exit target.',
    whyItWorks:
        'Every invertible arithmetic operation (+k, -k, ×m, ÷m) has an exact inverse. Therefore, any forward maze path can be solved backward with 100% determinism.',
    howToSolveIt:
        '1. Forward Search: Apply each operation in sequence from entrance to exit.\n'
        '2. Working Backward (Inversion): If the starting value is missing ([?]) and exit is known, invert every operator in reverse order (+ becomes -, × becomes ÷).\n'
        '3. Branch Pruning: If multiple pathways fork, test parity constraints at forks.',
    whenToUseIt:
        'When puzzles present chained boxes with directional arrows (e.g. [?] → (+3) → (×2) = 22).',
    stepByStepExplanation:
        'Number mazes challenge working memory and directional arithmetic:\n'
        '1. Sequential Forward Chains: Apply operations strictly in step order from start to finish.\n'
        '2. Working Backwards: If the exit value is given and the starting number is unknown, invert every operation in reverse order (addition becomes subtraction; multiplication becomes division).\n'
        '3. Branching Paths: When multiple paths diverge from the start, compute the final value of each path independently and combine them as requested.\n'
        '4. Collatz Algorithmic Steps: If even, divide by 2; if odd, multiply by 3 and add 1. Apply iteratively step by step.',
    workedExample:
        'Example: Start: [?] → (×2) → (+6) = 22. [?] = ?\n'
        'Work backwards from 22:\n'
        '• Reverse (+6): 22 - 6 = 16.\n'
        '• Reverse (×2): 16 ÷ 2 = 8.\n'
        'Starting number is 8.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Forward Sequential Chain',
        problem: 'Start: 5 → (+3) → (×2) → (-4) = [?]',
        stepByStepSolution:
            '• 5 + 3 = 8\n'
            '• 8 × 2 = 16\n'
            '• 16 - 4 = 12.',
        answer: '12',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Working Backwards from Exit',
        problem: 'Start: [?] → (×3) → (+7) → (÷2) = 17. Find [?].',
        stepByStepSolution:
            '• Reverse (÷2): 17 × 2 = 34.\n'
            '• Reverse (+7): 34 - 7 = 27.\n'
            '• Reverse (×3): 27 ÷ 3 = 9.\n'
            '• Verification: 9 × 3 = 27, 27 + 7 = 34, 34 ÷ 2 = 17 (True!).',
        answer: '9',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Collatz Algorithmic Step Chain',
        problem: 'Apply 3 Collatz steps starting at 6: If even ÷2; if odd ×3 + 1.',
        stepByStepSolution:
            '• Step 1: 6 is even → 6 ÷ 2 = 3.\n'
            '• Step 2: 3 is odd → 3(3) + 1 = 9 + 1 = 10.\n'
            '• Step 3: 10 is even → 10 ÷ 2 = 5.',
        answer: '5',
      ),
    ],
    commonMistakes: [
      'Forgetting to invert the order of operations when working backward (you must reverse the steps from last to first).',
    ],
    shortcutsAndTricks: [
      'Intermediate Parity Check: If a step divides by 2, the intermediate value right before it MUST be even.',
    ],
    alternativeMethods: [
      'Algebraic Modeling: Express the whole chain as a single equation: ((3x + 7) / 2) = 17 and solve algebraically.',
    ],
    sandboxType: SandboxDemoType.mazes,
    linkedLevels: [28, 42, 56, 70, 112, 210, 364],
    practiceQuestion: PracticeQuestion(
      question: 'Start: 5 → (+3) → (×2) → (-4) = [?]',
      correctAnswer: '12',
      hint: 'Perform each operation sequentially: 5 + 3 = 8, then 8 × 2, then subtract 4.',
      explanation: '5 + 3 = 8. 8 × 2 = 16. 16 - 4 = 12.',
      options: ['10', '12', '14', '16'],
      stepByStepGuidance: 'Step 1: 5 + 3 = 8. Step 2: 8 × 2 = 16. Step 3: 16 - 4 = 12.',
      wrongOptionExplanations: {
        '10': 'Incorrect. Check the subtraction 16 - 4 = 12.',
        '14': 'Incorrect. Off by two.',
        '16': 'Incorrect. 16 is the result before the final (-4) subtraction.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Solve backwards: [?] → (+6) → (×2) = 24. What is [?]?',
        correctAnswer: '6',
        hint: 'Reverse (×2) first: 24 ÷ 2 = 12. Then reverse (+6): 12 - 6 = ?',
        explanation: '24 ÷ 2 = 12. 12 - 6 = 6.',
        options: ['4', '6', '8', '10'],
      ),
    ],
    icon: Icons.navigation_rounded,
  ),

  // ===========================================================================
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
  // CHAPTER 4: VISUAL & SPATIAL GEOMETRY
  // ===========================================================================

  // 11. Geometry: Triangles
  const Lesson(
    id: 'topic_triangles',
    title: '11. Geometry: Vertex Multiplier Triangles',
    category: 'Geometry: Triangles',
    chapter: 'Chapter 4: Visual Geometry',
    chapterIndex: 4,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Understand how vertex coordinates interact mathematically to produce the center target node.',
    formula: 'Center = (Top × Left) + Right | Center = Top² + Left² - Right² | Cross: Top(Left+Right) - Left·Right',
    whatItIs:
        'Geometric triangle puzzles present three outer vertex nodes (Top, Bottom-Left, Bottom-Right) whose values algebraically determine the center target node according to a consistent geometric formula.',
    whyItWorks:
        'By mapping 3 spatial inputs to a central scalar, these puzzles test spatial-relational reasoning and algebraic balance across symmetrical and asymmetrical geometric topologies.',
    howToSolveIt:
        '1. Tier 0 (Beginner): (Top × Left) + Right = Center.\n'
        '2. Tier 1 (Easy-Int): (Top + Right) × Left = Center.\n'
        '3. Tier 2 (Intermediate): (Top² + Right) ÷ Left = Center.\n'
        '4. Tier 3 (Advanced): Top² + Left² - Right² = Center (Pythagorean interaction).\n'
        '5. Tier 4 (Expert): (Top × Left) + (Top × Right) - (Left × Right) = Center.\n'
        '6. Tier 5 (Very Expert): (Top³ - Left²) ÷ Right = Center.\n'
        '7. Tier 6 (Extreme Inverse): Center and Top/Right are given; isolate the missing Left vertex algebraically!',
    whenToUseIt:
        'Whenever you see an equilateral triangle diagram with 3 corner numbers and a central missing number box "[?]".',
    stepByStepExplanation:
        'In SMATH geometric triangle puzzles, three outer vertex nodes (Top, Bottom-Left, Bottom-Right) determine the Center node:\n'
        '1. Tier 0 (Beginner): (Top × Left) + Right = Center.\n'
        '2. Tier 1 (Easy-Int): (Top + Right) × Left = Center.\n'
        '3. Tier 2 (Intermediate): (Top² + Right) ÷ Left = Center.\n'
        '4. Tier 3 (Advanced): Top² + Left² - Right² = Center (Pythagorean interaction).\n'
        '5. Tier 4 (Expert): (Top × Left) + (Top × Right) - (Left × Right) = Center.\n'
        '6. Tier 5 (Very Expert): (Top³ - Left²) ÷ Right = Center.\n'
        '7. Tier 6 (Extreme): Inverse deduction — Center and Top/Right are given; isolate the missing Left vertex!',
    workedExample:
        'Example 1: Top=3, Left=5, Right=2 → Center [?]\n'
        'Rule: (Top × Left) + Right = (3 × 5) + 2 = 15 + 2 = 17.\n\n'
        'Example 2: Top=8, Left=6, Right=3 → Center [?]\n'
        'Rule: (Top × Left) ÷ Right = (8 × 6) ÷ 3 = 48 ÷ 3 = 16.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Mult-Add Vertex Rule',
        problem: 'Triangle has Top = 4, Left = 6, Right = 3. Using rule (Top × Left) + Right, Center = ?',
        stepByStepSolution:
            '• Multiply Top by Left: 4 × 6 = 24.\n'
            '• Add Right vertex: 24 + 3 = 27.',
        answer: '27',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Pythagorean Vertex Interaction',
        problem: 'Top = 3, Left = 4, Right = 5. Rule is Top² + Left² - Right² + 50. Center = ?',
        stepByStepSolution:
            '• 3² + 4² - 5² = 9 + 16 - 25 = 25 - 25 = 0.\n'
            '• Center = 0 + 50 = 50.',
        answer: '50',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Inverse Vertex Deduction',
        problem: 'Top = 5, Right = 3, Center = 38. Rule: (Top × Left) + Right = Center. Find Left vertex.',
        stepByStepSolution:
            '• (5 × Left) + 3 = 38.\n'
            '• 5 × Left = 38 - 3 = 35.\n'
            '• Left = 35 ÷ 5 = 7.',
        answer: '7',
      ),
    ],
    commonMistakes: [
      'Assuming the operation between Top and vertices is always symmetrical addition.',
      'Forgetting that when the target node is at a vertex (Tier 6), you must solve backward from Center.',
    ],
    shortcutsAndTricks: [
      'Base Vertex Inspection: If Center is significantly larger than vertices, look for multiplication between the two largest numbers or square terms.',
    ],
    alternativeMethods: [
      'Coordinate Equation Matrix: Write Center = a·T + b·L + c·R and solve coefficients.',
    ],
    sandboxType: SandboxDemoType.triangles,
    linkedLevels: [2, 6, 10, 14, 18, 32, 200, 312, 424],
    practiceQuestion: PracticeQuestion(
      question: 'Triangle has Top = 4, Left = 6, Right = 3. Using rule (Top × Left) + Right, Center = ?',
      correctAnswer: '27',
      hint: 'Multiply Top (4) by Left (6), then add Right (3).',
      explanation: '(4 × 6) + 3 = 24 + 3 = 27.',
      options: ['24', '27', '30', '33'],
      stepByStepGuidance: 'Top × Left = 4 × 6 = 24. 24 + Right (3) = 27.',
      wrongOptionExplanations: {
        '24': 'Incorrect. 24 is 4 × 6; you forgot to add the Right vertex (+3).',
        '30': 'Incorrect. 24 + 3 is 27, not 30.',
        '33': 'Incorrect. Check addition step.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'If Top = 5, Left = 4, Right = 2, and Center = (Top × Left) - Right, what is Center?',
        correctAnswer: '18',
        hint: '5 × 4 = 20. 20 - 2 = ?',
        explanation: '20 - 2 = 18.',
        options: ['16', '18', '20', '22'],
      ),
    ],
    icon: Icons.change_history_rounded,
  ),

  // 12. Geometry: Intersecting Circles
  const Lesson(
    id: 'topic_circles',
    title: '12. Geometry: Intersecting Circles',
    category: 'Geometry: Intersecting Circles',
    chapter: 'Chapter 4: Visual Geometry',
    chapterIndex: 4,
    difficulty: 'Beginner to Extreme',
    conceptSummary: 'Understand arithmetic means, geometric roots, harmonic means, and GCD in overlapping circular regions.',
    formula: 'Mean: (A + B)/2 | Geometric: √(A · B) | Harmonic: 2AB / (A + B) | Difference-Sq: (A - B)²',
    whatItIs:
        'Intersecting circle puzzles display two overlapping circular regions (Left and Right) sharing a central intersection area whose value is synthesized from both circles.',
    whyItWorks:
        'Venn and Euler diagrams represent intersection as a shared set. In numeric circles, the overlap mathematically symbolizes shared properties (such as common divisors, geometric means, or arithmetic averages).',
    howToSolveIt:
        '1. Arithmetic Mean: Center = (Left + Right) / 2.\n'
        '2. Geometric Mean: Center = √(Left × Right).\n'
        '3. Difference Squared: Center = (Left - Right)².\n'
        '4. Product Minus Sum: Center = (Left × Right) - (Left + Right).\n'
        '5. Harmonic Mean: Center = 2·Left·Right / (Left + Right).\n'
        '6. Greatest Common Divisor: Center = gcd(Left, Right).',
    whenToUseIt:
        'Look for two overlapping circles drawn on screen with values in Left, Right, and "?" in the center overlap.',
    stepByStepExplanation:
        'In SMATH intersecting circle riddles, two outer circles (Left and Right) overlap to define the Center intersection:\n'
        '1. Arithmetic Mean: Center = (Left + Right) / 2.\n'
        '2. Geometric Mean: Center = √(Left × Right).\n'
        '3. Difference Squared: Center = (Left - Right)².\n'
        '4. Product Minus Sum: Center = (Left × Right) - (Left + Right).\n'
        '5. Harmonic Mean: Center = (2 × Left × Right) / (Left + Right).\n'
        '6. Greatest Common Divisor: Center = gcd(Left, Right).\n'
        '7. Quadratic Symmetric Form: Center = Left² + Right² + (Left × Right).',
    workedExample:
        'Example 1: Left=9, Right=16 → Overlap [?]\n'
        'Rule: √(Left × Right) = √(9 × 16) = √144 = 12.\n\n'
        'Example 2: Left=15, Right=8 → Overlap [?]\n'
        'Rule: (Left - Right)² = (15 - 8)² = 7² = 49.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Arithmetic Mean Center',
        problem: 'Circles have Left = 12, Right = 18. Center is arithmetic mean. Find Center.',
        stepByStepSolution:
            '• Sum outer circles: 12 + 18 = 30.\n'
            '• Divide by 2: 30 ÷ 2 = 15.',
        answer: '15',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Geometric Mean Center',
        problem: 'Circles have Left = 9, Right = 16. Center is geometric mean. Find Center.',
        stepByStepSolution:
            '• Multiply outer circles: 9 × 16 = 144.\n'
            '• Take square root: √144 = 12.',
        answer: '12',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Difference-Squared Center',
        problem: 'Circles have Left = 15, Right = 8. Center is (Left - Right)². Find Center.',
        stepByStepSolution:
            '• Subtract Right from Left: 15 - 8 = 7.\n'
            '• Square the difference: 7² = 49.',
        answer: '49',
      ),
    ],
    commonMistakes: [
      'Assuming overlap is always addition or subtraction without checking for roots or squares.',
    ],
    shortcutsAndTricks: [
      'Square Clue: If the center value is a perfect square (e.g. 16, 25, 49, 64), immediately test (Left - Right)²!',
    ],
    alternativeMethods: [
      'Test Integer Square Roots: If Left and Right are themselves perfect squares (e.g. 9 and 16), then √(L × R) = √L × √R = 3 × 4 = 12.',
    ],
    sandboxType: SandboxDemoType.circles,
    linkedLevels: [4, 8, 12, 16, 24, 38, 150, 290],
    practiceQuestion: PracticeQuestion(
      question: 'Intersecting circles have Left = 12, Right = 18. If the center is the arithmetic mean, Center = ?',
      correctAnswer: '15',
      hint: 'Add Left and Right, then divide by 2: (12 + 18) / 2.',
      explanation: '(12 + 18) ÷ 2 = 30 ÷ 2 = 15.',
      options: ['14', '15', '16', '18'],
      stepByStepGuidance: '(12 + 18) / 2 = 30 / 2 = 15.',
      wrongOptionExplanations: {
        '14': 'Incorrect. 30 ÷ 2 = 15, not 14.',
        '16': 'Incorrect. Off by one.',
        '18': 'Incorrect. 18 is the right circle value, not the average.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Left = 4, Right = 9. If Center is the geometric mean √(L × R), Center = ?',
        correctAnswer: '6',
        hint: '4 × 9 = 36. √36 = ?',
        explanation: '√(4 × 9) = √36 = 6.',
        options: ['4', '5', '6', '7'],
      ),
    ],
    icon: Icons.donut_large_rounded,
  ),

  // ===========================================================================
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
