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
    difficulty: 'Beginner',
    conceptSummary: 'Learn which math operation to do first so you always reach the right answer with confidence.',
    formula: 'BODMAS Rule: ( ) Brackets → Powers/Roots → × and ÷ (Left to Right) → + and - (Left to Right)',
    whatItIs:
        'Order of operations is a simple set of traffic rules for math. When an expression has a mix of plus, minus, times, and divide (like 2 + 3 × 4), it tells you which part to calculate first so everyone gets the exact same correct answer.',
    whyItWorks:
        'Multiplication is just quick addition. For example, 3 × 4 means adding three 4s together (4 + 4 + 4 = 12). If you buy 2 apples for \$2, and then 3 bags with 4 oranges in each bag, your total fruit is 2 + 12 = 14. If you added 2 + 3 first, you would get 20, which is incorrect!',
    howToSolveIt:
        '1. Step 1 (Brackets): Always solve what is inside parentheses ( ) first.\n'
        '2. Step 2 (Orders / Powers): Calculate any squares or roots (like 3² = 9 or √16 = 4).\n'
        '3. Step 3 (Multiply & Divide): Equal priority! Solve them from left to right as you read.\n'
        '4. Step 4 (Add & Subtract): Equal priority! Finish by adding and subtracting from left to right.',
    whenToUseIt:
        'Use this rule whenever a puzzle or equation has two or more different math signs (+, -, ×, ÷). In SMATH riddles, watch out for addition placed before multiplication—always do multiplication first!',
    stepByStepExplanation:
        'To solve any math puzzle without making mistakes, follow these 4 simple steps in order:\n'
        '1. Parentheses First: Clear anything inside brackets ( ) right away.\n'
        '2. Powers & Roots: Next, solve any exponents like 2³ = 8 or √9 = 3.\n'
        '3. Times and Divide: Multiply and divide from left to right.\n'
        '4. Plus and Minus: Finally, add and subtract from left to right.\n\n'
        'Golden Rule: Multiplication and division ALWAYS come before addition and subtraction, unless brackets tell you otherwise!',
    workedExample:
        'Example 1: What is 2 + 3 × 4?\n'
        '• Step 1: Multiply first: 3 × 4 = 12.\n'
        '• Step 2: Now add: 2 + 12 = 14.\n\n'
        'Example 2: What is 20 - 2 × (3 + 5)?\n'
        '• Step 1: Brackets first: (3 + 5) = 8.\n'
        '• Step 2: Multiply: 2 × 8 = 16.\n'
        '• Step 3: Subtract: 20 - 16 = 4.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Two-Step Priority (Multiply First)',
        problem: '2 + 2 × 2 = ?',
        stepByStepSolution:
            '• Rule: Always multiply before adding.\n'
            '• Step 1: 2 × 2 = 4.\n'
            '• Step 2: 2 + 4 = 6.\n'
            '• Result: 6 (Not 8!).',
        answer: '6',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Left-to-Right Chained Division & Multiplication',
        problem: '6 ÷ 2 × (1 + 2) = ?',
        stepByStepSolution:
            '• Step 1: Parentheses first: (1 + 2) = 3.\n'
            '• Step 2: Division and Multiplication have equal priority. Go left to right: 6 ÷ 2 = 3.\n'
            '• Step 3: Now multiply: 3 × 3 = 9.',
        answer: '9',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Mixed Operations with Quick Cancellation',
        problem: '7 + 7 ÷ 7 + 7 × 7 - 7 = ?',
        stepByStepSolution:
            '• Step 1: Do divide and multiply: 7 ÷ 7 = 1 and 7 × 7 = 49.\n'
            '• Step 2: Replace values: 7 + 1 + 49 - 7.\n'
            '• Step 3: Notice the first +7 and the last -7 cancel each other out (7 - 7 = 0).\n'
            '• Step 4: 1 + 49 = 50.',
        answer: '50',
      ),
    ],
    commonMistakes: [
      'Adding from left to right automatically: Thinking 2 + 3 × 4 is 5 × 4 = 20. Remember to multiply first!',
      'Thinking multiplication always beats division: They are equals! If division comes first on the left, do it first.',
      'Forgetting that brackets override everything: If numbers are in brackets like (2 + 3) × 4, solve the brackets first (5 × 4 = 20).',
    ],
    shortcutsAndTricks: [
      'Cancellation Trick: If you see +5 and later -5 in the same addition chain, cross them out immediately to save time!',
      'Zero Trick: If an entire grouped part is multiplied by 0 (like ... × 0), that whole part becomes 0 instantly.',
      'Scan First: Spend 2 seconds scanning for any × or ÷ signs before doing any math.',
    ],
    alternativeMethods: [
      'Underline High Priority: Lightly underline the × and ÷ parts in your mind, calculate them first, then rewrite the simple line.',
      'Money Analogy: Think of operations as physical items: 2 coins plus 3 boxes of 4 coins each.',
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
        '20': 'Close! Check the subtraction at the end: 26 - 4 is 22, not 20.',
        '24': 'Close! Did you accidentally add the final 4 instead of subtracting it?',
        '28': 'Careful! Did you evaluate left to right without doing division and multiplication first?',
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
          '0': 'Common mistake! Multiplying by zero only turns that single term into 0 (10 × 0 = 0). The other +10 terms remain!',
          '10': 'Check carefully: you have a 10 at the start and another 10 at the end (10 + 10 = 20).',
          '30': 'Be careful: did you add 10 + 10 first before multiplying by zero?',
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
          '15': 'You calculated 3 × 5 = 15, which is correct! Now subtract it from 18: 18 - 15 = 3.',
          '45': 'Remember: never subtract 18 - 3 first. The brackets and multiplication have priority!',
          '75': 'Check the order of steps: brackets (5), then multiply (15), then subtract (18 - 15 = 3).',
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
    difficulty: 'Beginner',
    conceptSummary: 'Crack mystery symbol puzzles (like ★, ⊕, or ⊗) by swapping symbols with simple math rules.',
    formula: 'Symbol Recipe: If a ★ b = (2 × a) + b, then replace letters with numbers and solve!',
    whatItIs:
        'Lateral operator riddles introduce mystery symbols like ★ or ⊕ that stand for a secret math recipe. The puzzle gives you the recipe (for example: "a ★ b means double a, then add b"), and you just follow the steps.',
    whyItWorks:
        'Think of a symbol as a button on a machine. If you press the "★" button, the machine takes the left number, doubles it, and adds the right number. Swapping the letters with your numbers gives you standard everyday math.',
    howToSolveIt:
        '1. Step 1 (Find the Recipe): Look at the formula provided in the riddle, like a ★ b = 2a + b.\n'
        '2. Step 2 (Match the Numbers): Identify which number is "a" (left side) and which is "b" (right side).\n'
        '3. Step 3 (Plug In & Solve): Replace "a" and "b" with those numbers, then calculate using normal math rules.',
    whenToUseIt:
        'Use whenever you see unfamiliar symbols like ★, ⊕, ⊗, or when a question says "If 3 # 2 = 8, what is 4 # 3?".',
    stepByStepExplanation:
        'Solving secret symbol puzzles is easy when you follow these 3 steps:\n'
        '1. Write out the recipe: For example, a ★ b = (a × b) + a.\n'
        '2. Match the numbers: If asked for 4 ★ 5, then a = 4 and b = 5.\n'
        '3. Calculate: (4 × 5) + 4 = 20 + 4 = 24.\n\n'
        'Tip: If there are brackets like (2 ★ 3) ★ 4, solve the brackets first, then use that answer for the next step!',
    workedExample:
        'Example: If a ★ b = (2 × a) + b, what is 3 ★ 4?\n'
        '• Left number (a) = 3.\n'
        '• Right number (b) = 4.\n'
        '• Plug into recipe: (2 × 3) + 4 = 6 + 4 = 10.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Simple Double and Add',
        problem: 'If a ★ b = 2a + b, find 3 ★ 4.',
        stepByStepSolution:
            '• a = 3, b = 4.\n'
            '• 2 × 3 = 6.\n'
            '• 6 + 4 = 10.',
        answer: '10',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Multiply and Add Recipe',
        problem: 'If a ⊕ b = (a × b) + (a + b), find 4 ⊕ 5.',
        stepByStepSolution:
            '• Step 1: Multiply them: 4 × 5 = 20.\n'
            '• Step 2: Add them: 4 + 5 = 9.\n'
            '• Step 3: Combine both results: 20 + 9 = 29.',
        answer: '29',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Two-Step Chained Symbol',
        problem: 'If a ★ b = 3a - b, find (2 ★ 1) ★ 3.',
        stepByStepSolution:
            '• Step 1 (Inside Brackets): 2 ★ 1 = (3 × 2) - 1 = 6 - 1 = 5.\n'
            '• Step 2 (Outer Symbol): Now solve 5 ★ 3 = (3 × 5) - 3 = 15 - 3 = 12.',
        answer: '12',
      ),
    ],
    commonMistakes: [
      'Mixing up the left and right numbers: In a ★ b = 2a + b, 3 ★ 4 is (2 × 3) + 4 = 10, but 4 ★ 3 is (2 × 4) + 3 = 11!',
      'Ignoring parentheses: If you have (a ★ b) ★ c, always solve inside the brackets first.',
    ],
    shortcutsAndTricks: [
      'Check for Symmetry: If a recipe only adds and multiplies (like a + b + ab), swapping the order gives the exact same result!',
      'Label Clearly: Underline the first number as "a" and second as "b" to prevent silly mix-ups.',
    ],
    alternativeMethods: [
      'Word Translation: Translate the symbols into plain English: "Multiply the two numbers, then add the first number."',
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
        '8': 'Incorrect. Did you forget to add the second number (4)?',
        '12': 'Incorrect. Did you multiply 3 × 4 instead of following the recipe (2a + b)?',
        '14': 'Incorrect. Check your multiplication: 2 × 3 = 6, plus 4 equals 10.',
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
        wrongOptionExplanations: {
          '8': 'Check the math: 5 × 3 = 15. Then 15 - 5 = 10.',
          '12': 'Did you subtract 3 instead of 5? The formula says subtract a (the first number, 5).',
          '15': 'You found 5 × 3 = 15, which is great! Don\'t forget to subtract a: 15 - 5 = 10.',
        },
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
    difficulty: 'Easy–Intermediate',
    conceptSummary: 'Learn clever mental shortcuts for handshakes, clock angles, and classic riddle traps.',
    formula: 'Handshake Shortcut: People × (People - 1) ÷ 2 | Clock Angle: 30° per hour mark',
    whatItIs:
        'Mathematical trick riddles look tricky or confusing at first glance, but they have clever, beautiful shortcuts that let you find the answer in seconds without tedious calculations.',
    whyItWorks:
        'Take handshakes for example: if 4 people meet, person 1 shakes hands with 3 people, person 2 shakes with 2 new people, and person 3 shakes with 1. That is just 3 + 2 + 1 = 6. The shortcut formula n × (n - 1) ÷ 2 adds these up instantly!',
    howToSolveIt:
        '1. Handshakes at a Party: For n people, multiply n by (n - 1), then divide by 2.\n'
        '2. Clock Face Angles: Every hour number on a clock represents 30° (360° ÷ 12). At 4:00, the angle is 4 × 30° = 120°.\n'
        '3. Snail in a Well: Remember that when the snail reaches the top on the final day, it climbs out immediately and does NOT slip back down!',
    whenToUseIt:
        'Use whenever you encounter questions about groups of people meeting, analog clock angles, or daily progress riddles.',
    stepByStepExplanation:
        'Here are the most popular riddle tricks explained simply:\n'
        '1. Handshakes: If 6 people each shake hands once: 6 × 5 ÷ 2 = 15 handshakes.\n'
        '2. Clock Angles: A full circle is 360°. There are 12 hour numbers, so each hour gap is 360 ÷ 12 = 30 degrees.\n'
        '3. Round-Trip Speeds: If you drive 60 km/h there and 40 km/h back, your average speed is NOT 50! Because you spent more time at the slower speed, the true average is 48 km/h.',
    workedExample:
        'Example: How many handshakes happen when 5 friends meet and everyone shakes hands once?\n'
        '• Formula: 5 × (5 - 1) ÷ 2.\n'
        '• 5 × 4 = 20.\n'
        '• 20 ÷ 2 = 10 handshakes.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Handshake Party Formula',
        problem: '6 people in a meeting each shake hands with every other person once. How many total handshakes occur?',
        stepByStepSolution:
            '• Number of people n = 6.\n'
            '• Multiply by one less: 6 × 5 = 30.\n'
            '• Divide by 2: 30 ÷ 2 = 15 handshakes.',
        answer: '15',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Clock Hour Angle',
        problem: 'What is the angle between clock hands at 4:00?',
        stepByStepSolution:
            '• The minute hand points directly at 12.\n'
            '• The hour hand points at 4.\n'
            '• Each hour mark is 30° (360° ÷ 12).\n'
            '• 4 hour steps × 30° = 120°.',
        answer: '120',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'The Snail in the Well Trap',
        problem: 'A snail is at the bottom of a 10-meter well. Each day it climbs 3 meters, but each night it slides back 2 meters. On which day does it escape?',
        stepByStepSolution:
            '• Each 24-hour cycle gives a net climb of 3 - 2 = 1 meter.\n'
            '• After 7 days and nights, the snail is at 7 meters.\n'
            '• On Day 8, it climbs 3 meters: 7 + 3 = 10 meters! It reaches the top and climbs out.\n'
            '• It never slides down on the 8th night because it is already free! Total days = 8.',
        answer: '8',
      ),
    ],
    commonMistakes: [
      'Counting handshakes twice: Forgetting to divide by 2. When Alice shakes Bob\'s hand, Bob has also shaken Alice\'s hand!',
      'Assuming average speed is simple average: Driving 60 and returning at 40 is not 50 km/h, because you spend more time at 40.',
      'Snail well trap: Forgetting that once the snail reaches the top, it exits and doesn\'t slip down that night.',
    ],
    shortcutsAndTricks: [
      'Handshake Fast Count: Just add the numbers counting down: for 5 people, 4 + 3 + 2 + 1 = 10.',
      'Clock 30° Rule: Every 5-minute jump on a clock face equals 30 degrees.',
    ],
    alternativeMethods: [
      'Draw It Out: For small groups (like 4 people), draw 4 dots and connect them with lines to count them visually.',
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
        '12': 'Check the math: 6 × 5 = 30, and 30 ÷ 2 is 15.',
        '18': 'Check the formula: 6 × 5 = 30. Dividing by 2 gives 15.',
        '30': '30 counts every handshake twice! Since Alice shaking Bob\'s hand is the same handshake, divide 30 by 2 = 15.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'What is the angle between clock hands at 4:00?',
        correctAnswer: '120',
        hint: 'Each hour mark is 30 degrees (360° / 12). 4 hours × 30° = ?',
        explanation: 'At 4:00, minute hand is at 12 and hour hand is at 4. 4 × 30° = 120°.',
        options: ['90', '100', '120', '140'],
        wrongOptionExplanations: {
          '90': '90° is at 3:00 (3 × 30°). At 4:00 it is 4 × 30° = 120°.',
          '100': 'Each hour mark is exactly 30 degrees. 4 × 30 = 120.',
          '140': '4 × 30 = 120 degrees.',
        },
      ),
    ],
    icon: Icons.lightbulb_rounded,
  ),

  // ===========================================================================
];
