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
    difficulty: 'Beginner',
    conceptSummary: 'Find unknown numbers marked with [?] using balance scale logic and inverse math.',
    formula: 'Balance Scale Rule: To isolate [?], undo additions with subtraction and multiplications with division!',
    whatItIs:
        'Missing number puzzles give you an equation or a scale with an empty box [?]. Your goal is to work out the mystery number that makes both sides balance perfectly.',
    whyItWorks:
        'Think of a balance scale with weights on both sides. If you take away 7 kg from the left pan, you must take away 7 kg from the right pan to keep the scale level.',
    howToSolveIt:
        '1. Step 1 (Undo the Extra Weight): If you see ([?] × 4) + 7 = 39, subtract 7 from 39 first: 39 - 7 = 32.\n'
        '2. Step 2 (Divide the Bundles): Now you have [?] × 4 = 32. Divide 32 by 4: 32 ÷ 4 = 8.\n'
        '3. Step 3 (Check Your Work): Put 8 back into the box: (8 × 4) + 7 = 32 + 7 = 39. Balanced!',
    whenToUseIt:
        'Use whenever you see equations with unknown boxes [?], missing row numbers, or two-pan balance scale riddles.',
    stepByStepExplanation:
        'To find any missing number, undo what was done to it in reverse order:\n'
        '1. Undo addition by subtracting.\n'
        '2. Undo subtraction by adding.\n'
        '3. Undo multiplication by dividing.\n'
        '4. Undo division by multiplying.\n\n'
        'Example: If 3 × [?] + 5 = 20:\n'
        '• Subtract 5: 20 - 5 = 15.\n'
        '• Divide by 3: 15 ÷ 3 = 5. The missing number is 5!',
    workedExample:
        'Example: Find [?] in: ([?] × 4) + 7 = 39.\n'
        '• Step 1: Undo the +7 by subtracting: 39 - 7 = 32.\n'
        '• Step 2: Undo the ×4 by dividing: 32 ÷ 4 = 8.\n'
        '• The missing number is 8.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Simple Missing Number Balance',
        problem: '([?] × 4) + 7 = 39. Solve for [?].',
        stepByStepSolution:
            '• Subtract 7 from both sides: 39 - 7 = 32.\n'
            '• Divide by 4: 32 ÷ 4 = 8.\n'
            '• [?] = 8.',
        answer: '8',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Two Rows Crossing at a Missing Cell',
        problem: 'Row sum: 5 + ? + 9 = 22. Column sum: 3 + ? + 7 = 18. Find [?].',
        stepByStepSolution:
            '• From the row: 5 + 9 = 14. ? = 22 - 14 = 8.\n'
            '• Verify in the column: 3 + 8 + 7 = 18. Both match!\n'
            '• [?] = 8.',
        answer: '8',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Common Multiplier Between Two Clues',
        problem: 'A × B = 48 and B × C = 60. A, B, and C are positive single-digit numbers. Find B.',
        stepByStepSolution:
            '• B is multiplied in both equations, so B must divide both 48 and 60.\n'
            '• Factors of 48: 1, 2, 3, 4, 6, 8, 12...\n'
            '• Factors of 60: 1, 2, 3, 4, 5, 6, 10, 12...\n'
            '• If B = 6: A = 48 ÷ 6 = 8 (single digit!) and C = 60 ÷ 6 = 10 (not single digit).\n'
            '• Single-digit match where all work gives B = 6.',
        answer: '6',
      ),
    ],
    commonMistakes: [
      'Dividing before subtracting: In ([?] × 4) + 7 = 39, never divide by 4 first! Always subtract the +7 first.',
    ],
    shortcutsAndTricks: [
      'Balance Principle: Whatever you do to the left side, do the exact same thing to the right side.',
    ],
    alternativeMethods: [
      'Option Testing: If you have multiple choices (6, 7, 8, 9), test each one: 8 × 4 + 7 = 39!',
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
        '6': 'Test it: 6 × 4 + 7 = 24 + 7 = 31 (we need 39). Try a bigger number!',
        '7': 'Test it: 7 × 4 + 7 = 28 + 7 = 35 (we need 39). Getting warmer!',
        '9': 'Test it: 9 × 4 + 7 = 36 + 7 = 43 (too high).',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'If 4 + [?] + 9 = 21, what is [?]?',
        correctAnswer: '8',
        hint: 'Add 4 and 9 first: 4 + 9 = 13. Then subtract 13 from 21.',
        explanation: '4 + 9 = 13. 21 - 13 = 8.',
        options: ['6', '7', '8', '9'],
        wrongOptionExplanations: {
          '6': '4 + 6 + 9 = 19 (we need 21).',
          '7': '4 + 7 + 9 = 20 (almost!).',
          '9': '4 + 9 + 9 = 22 (one too many).',
        },
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
    difficulty: 'Easy–Intermediate',
    conceptSummary: 'Solve picture equations and two-variable puzzles using simple elimination.',
    formula: 'Elimination Shortcut: (A + B = 12 and 2A + B = 19) → Subtract to find A = 7!',
    whatItIs:
        'Equation riddles hide numbers behind letters or pictures (like apples and bananas). By comparing two clues, you can easily find the value of each item.',
    whyItWorks:
        'If 1 burger and 1 drink cost \$10, but 2 burgers and 1 drink cost \$16, the extra burger MUST be the difference: \$16 - \$10 = \$6. Once you know a burger is \$6, the drink is \$10 - \$6 = \$4!',
    howToSolveIt:
        '1. Step 1 (Compare Clues): Look at what changed between the two clues.\n'
        '2. Step 2 (Subtract to Find One Item): Subtract the smaller clue from the larger clue to cancel out the shared item.\n'
        '3. Step 3 (Find the Other Item): Put your first answer back into the easiest clue to find the remaining item.',
    whenToUseIt:
        'Use whenever you see equations like A + B = 10 and 2A + B = 17, or picture puzzles with items on scales.',
    stepByStepExplanation:
        'Solving two-variable riddles step by step:\n'
        '1. Clue 1: A + B = 12\n'
        '2. Clue 2: 2A + B = 19\n'
        '3. Notice that Clue 2 has one extra "A", and the total is 7 higher (19 - 12 = 7).\n'
        '4. That means A = 7!\n'
        '5. Now find B: 7 + B = 12, so B = 5.',
    workedExample:
        'Example: A + B = 10, and 2A + B = 17. Find A.\n'
        '• Compare both clues: Clue 2 has one more A than Clue 1.\n'
        '• The difference is 17 - 10 = 7.\n'
        '• Therefore, A = 7 (and B = 10 - 7 = 3).',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Single-Variable Equation',
        problem: '3x + 5 = 26. Find x.',
        stepByStepSolution:
            '• Subtract 5: 3x = 26 - 5 = 21.\n'
            '• Divide by 3: x = 21 ÷ 3 = 7.',
        answer: '7',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Finding the Extra Item',
        problem: 'A + B = 12 and 2A + B = 19. Find A.',
        stepByStepSolution:
            '• Subtract equation 1 from equation 2:\n'
            '• (2A + B) - (A + B) = 19 - 12.\n'
            '• A = 7. (Then B = 12 - 7 = 5).',
        answer: '7',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Sum and Difference Shortcut',
        problem: 'A + B = 20 and A - B = 6. Find A.',
        stepByStepSolution:
            '• Shortcut: When you know the sum and the difference of two numbers, add them together and divide by 2!\n'
            '• (20 + 6) ÷ 2 = 26 ÷ 2 = 13.\n'
            '• A = 13 (and B = 20 - 13 = 7).',
        answer: '13',
      ),
    ],
    commonMistakes: [
      'Trying to guess numbers randomly instead of subtracting the two clues to find the difference.',
      'In picture puzzles, watch out for visual changes (like 2 bananas instead of 1, or a cat without a collar).',
    ],
    shortcutsAndTricks: [
      'Sum & Difference Trick: If you know A + B and A - B, the larger number is always (Sum + Diff) ÷ 2, and the smaller is (Sum - Diff) ÷ 2!',
    ],
    alternativeMethods: [
      'Substitution: If A + B = 12, then B = 12 - A. Put that in place of B in the second equation.',
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
        '5': 'Check: 3 × 5 + 5 = 15 + 5 = 20 (we need 26).',
        '6': 'Check: 3 × 6 + 5 = 18 + 5 = 23 (we need 26).',
        '8': 'Check: 3 × 8 + 5 = 24 + 5 = 29 (a little too high).',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'If A + B = 15 and A - B = 5, what is A?',
        correctAnswer: '10',
        hint: 'Add the two equations together: (15 + 5) ÷ 2 = ?',
        explanation: 'Add equations: 2A = 20 → A = 10.',
        options: ['8', '10', '12', '15'],
        wrongOptionExplanations: {
          '8': 'If A = 8, then B = 7. But 8 - 7 = 1, not 5.',
          '12': 'If A = 12, then B = 3. But 12 - 3 = 9, not 5.',
          '15': 'If A = 15, B would be 0. But 15 + 0 = 15 and 15 - 0 = 15 (we need difference 5).',
        },
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
    difficulty: 'Intermediate',
    conceptSummary: 'Use elimination clues, digit properties, and multiples to crack secret numbers.',
    formula: 'Clue Detective: Digits must satisfy all rules at once → Eliminate impossible numbers step by step!',
    whatItIs:
        'Logic number riddles describe a mystery number using clues about its digits (for example: "I am a two-digit number, my tens digit is double my units digit, and my digits add up to 9").',
    whyItWorks:
        'Each clue eliminates most numbers from 0 to 99. By testing candidate numbers against all clues, only one single number will satisfy every requirement.',
    howToSolveIt:
        '1. Step 1 (Read Clue 1): What kind of number is it? (e.g. Two-digit, greater than 40).\n'
        '2. Step 2 (Read Clue 2): What do the digits do? (e.g. Tens digit is double the units digit: could be 21, 42, 63, 84).\n'
        '3. Step 3 (Combine Clues): Greater than 40 and digits sum to 9? Out of 42, 63, 84, only 63 sums to 9 (6 + 3 = 9)!',
    whenToUseIt:
        'Use when riddles say "Who am I?", "Find the smallest number divisible by...", or in lock code riddles.',
    stepByStepExplanation:
        'Cracking deductive number puzzles:\n'
        '1. Write down candidates from the strongest clue.\n'
        '2. Cross out candidates that fail any remaining clue.\n'
        '3. The Least Common Multiple (LCM): To find the smallest number divisible by 3, 4, and 6, list multiples of the biggest number (6, 12, 18...). 12 is divisible by both 3 and 4, so 12 is the answer!',
    workedExample:
        'Example: What is the smallest positive number divisible by both 4 and 6?\n'
        '• Multiples of 6: 6, 12, 18, 24...\n'
        '• Check 6: 6 is not divisible by 4.\n'
        '• Check 12: 12 ÷ 4 = 3, and 12 ÷ 6 = 2. Yes! 12 is the smallest.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Smallest Common Multiplier',
        problem: 'Find the smallest positive integer divisible by 3, 4, and 6.',
        stepByStepSolution:
            '• Multiples of the largest number 6: 6, 12, 18, 24...\n'
            '• 6 is not divisible by 4.\n'
            '• 12 is divisible by 3 (4), 4 (3), and 6 (2).\n'
            '• The smallest common multiple is 12.',
        answer: '12',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Two-Digit Clue Deduction',
        problem: 'I am a 2-digit number. My tens digit is 3. I am 7 times my units digit. What number am I?',
        stepByStepSolution:
            '• The number is "3" followed by units digit u (30 + u).\n'
            '• The riddle says the number equals 7 × u.\n'
            '• 30 + u = 7u ⇒ 6u = 30 ⇒ u = 5.\n'
            '• The number is 35 (Check: 7 × 5 = 35!).',
        answer: '35',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Self-Ending Squares',
        problem: 'Find the two-digit number ending in 5 whose square ends in the number itself.',
        stepByStepSolution:
            '• Test numbers ending in 5:\n'
            '• 15² = 225 (ends in 25, not 15).\n'
            '• 25² = 625 (ends in 25! It ends in itself!).\n'
            '• The number is 25.',
        answer: '25',
      ),
    ],
    commonMistakes: [
      'Picking a common multiple that is not the SMALLEST: 24 is divisible by 3, 4, and 6, but 12 is smaller!',
      'Stopping after checking only one clue instead of verifying all of them.',
    ],
    shortcutsAndTricks: [
      'Multiples of 9: A number is divisible by 9 if and only if all its digits add up to 9, 18, or 27.',
    ],
    alternativeMethods: [
      'Process of Elimination: Test the 4 multiple choice options one by one against the clues.',
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
        '6': '6 is divisible by 3 and 6, but not by 4 (6 ÷ 4 has a remainder).',
        '18': '18 is divisible by 3 and 6, but not by 4.',
        '24': '24 is divisible by all three, but it is not the SMALLEST (12 is smaller!).',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'A number is 4 times its digit sum, and digits sum to 9. Value?',
        correctAnswer: '36',
        hint: 'Multiply the digit sum (9) by 4.',
        explanation: '4 × 9 = 36. Digits: 3 + 6 = 9.',
        options: ['27', '36', '45', '54'],
        wrongOptionExplanations: {
          '27': '4 × 9 = 36, not 27.',
          '45': '4 × 9 = 36, not 45.',
          '54': '4 × 9 = 36, not 54.',
        },
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
    difficulty: 'Easy–Intermediate',
    conceptSummary: 'Solve age puzzles easily using the secret rule: the age gap never changes!',
    formula: 'Golden Age Rule: Age Gap = Person A - Person B (This difference is constant forever!)',
    whatItIs:
        'Age riddles ask you to find how old people are today, or in how many years one person will be twice as old as another.',
    whyItWorks:
        'Everyone ages at the exact same speed: 1 year per year. If an older brother is 5 years older than you today, he will still be exactly 5 years older in 10, 20, or 50 years!',
    howToSolveIt:
        '1. Step 1 (Find the Gap): If Sam is 4 years older than Leo, their age difference is 4.\n'
        '2. Step 2 (Sum and Difference Trick): If their ages add up to 20:\n'
        '   • Younger brother (Leo) = (Sum - Gap) ÷ 2 = (20 - 4) ÷ 2 = 8.\n'
        '   • Older brother (Sam) = Leo + Gap = 8 + 4 = 12.\n'
        '3. Step 3 (Verify): 12 + 8 = 20, and 12 - 8 = 4. Done!',
    whenToUseIt:
        'Use whenever word problems mention ages, birthdays, past years, or future years.',
    stepByStepExplanation:
        'Here is the foolproof way to solve age riddles:\n'
        '1. Two people with a known sum and gap:\n'
        '   • Take the Sum, subtract the Gap, and divide by 2 to get the younger age.\n'
        '   • Add the Gap to get the older age.\n'
        '2. When will Dad be twice as old as Son?\n'
        '   • When Dad is twice as old as Son, the Son\'s age MUST equal the age gap!\n'
        '   • If Dad is 30 and Son is 6, the gap is 30 - 6 = 24.\n'
        '   • Dad will be double the Son when Son turns 24 (which is 24 - 6 = 18 years from now).',
    workedExample:
        'Example: Sam is 4 years older than Leo. The sum of their ages is 20. How old is Sam?\n'
        '• Age gap = 4.\n'
        '• Leo\'s age = (20 - 4) ÷ 2 = 16 ÷ 2 = 8.\n'
        '• Sam\'s age = 8 + 4 = 12.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Sum & Difference Age Formula',
        problem: 'Sam is 4 years older than Leo. The sum of their ages is 20. How old is Sam?',
        stepByStepSolution:
            '• Leo\'s age: (Sum - Gap) ÷ 2 = (20 - 4) ÷ 2 = 16 ÷ 2 = 8.\n'
            '• Sam\'s age: Leo + Gap = 8 + 4 = 12.',
        answer: '12',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Future Age Multiplier',
        problem: 'A father is 32 and his daughter is 8. In how many years will the father be 3 times as old as his daughter?',
        stepByStepSolution:
            '• Age gap = 32 - 8 = 24 years.\n'
            '• When dad is 3× daughter, the gap represents 2 parts (Dad is 3 parts, daughter is 1 part; difference is 2 parts).\n'
            '• 2 parts = 24 ⇒ 1 part (daughter\'s future age) = 12.\n'
            '• Daughter is currently 8, so 12 - 8 = 4 years from now!',
        answer: '4',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Simultaneous Time Shift',
        problem: 'The sum of ages of two brothers is 40. Five years ago, the older brother was twice as old as the younger brother. How old is the older brother today?',
        stepByStepSolution:
            '• 5 years ago, each brother was 5 years younger, so their sum was 40 - 10 = 30.\n'
            '• Older was double younger: 2 parts + 1 part = 3 parts = 30 ⇒ 1 part = 10.\n'
            '• 5 years ago: Younger was 10, Older was 20.\n'
            '• Today: Older brother is 20 + 5 = 25.',
        answer: '25',
      ),
    ],
    commonMistakes: [
      'Forgetting that time shifts affect BOTH people: 5 years ago, two brothers together lost 10 years (5 years each!), not 5.',
      'Assuming the age ratio stays the same: If dad is 4 times older now, he will NOT be 4 times older in 10 years.',
    ],
    shortcutsAndTricks: [
      'Constant Gap Rule: Always compute the age gap first. It never changes, no matter how many years pass!',
    ],
    alternativeMethods: [
      'Simple Guess & Check: If ages sum to 20 and gap is 4, test pairs that add to 20: 11+9=20 (gap 2), 12+8=20 (gap 4!).',
    ],
    sandboxType: SandboxDemoType.age,
    linkedLevels: [35, 49, 63, 105, 175, 301, 442],
    practiceQuestion: PracticeQuestion(
      question: 'Sam is 4 years older than Leo. The sum of their ages is 20. How old is Sam?',
      correctAnswer: '12',
      hint: 'Subtract the difference (4) from the sum (20), divide by 2 to find Leo, then add 4 for Sam.',
      explanation: 'Leo is (20 - 4) / 2 = 8. Sam is 8 + 4 = 12.',
      options: ['10', '12', '14', '16'],
      stepByStepGuidance: 'Step 1: 20 - 4 = 16. Step 2: 16 / 2 = 8 (Leo). Step 3: 8 + 4 = 12 (Sam).',
      wrongOptionExplanations: {
        '10': 'If Sam is 10, Leo would be 6 (gap 4). But 10 + 6 = 16, not 20.',
        '14': 'If Sam is 14, Leo would be 10 (gap 4). But 14 + 10 = 24, not 20.',
        '16': '16 is too old; if Sam were 16, Leo would be 12 (sum 28).',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Dad is 30, son is 6. In how many years is Dad twice as old as Son?',
        correctAnswer: '18',
        hint: 'Age gap is 30 - 6 = 24. Dad is twice as old when Son reaches age 24. How many years from 6 to 24?',
        explanation: 'Age gap = 24. When Dad is 2× Son, Son must be 24. 24 - 6 = 18 years.',
        options: ['12', '15', '18', '24'],
        wrongOptionExplanations: {
          '12': 'In 12 years: Dad is 42, Son is 18 (42 is not double 18).',
          '15': 'In 15 years: Dad is 45, Son is 21 (45 is not double 21).',
          '24': 'In 18 years: Dad is 48, Son is 24 (48 is exactly double 24!).',
        },
      ),
    ],
    icon: Icons.hourglass_top_rounded,
  ),

  // ===========================================================================
];
