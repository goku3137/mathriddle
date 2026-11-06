import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

final List<Lesson> chapter2Sequences = [
  // CHAPTER 2: SEQUENCES, PATTERNS & RECURRENCES
  // ===========================================================================

  // 4. Number Pattern Riddles
  const Lesson(
    id: 'topic_patterns',
    title: '4. Number Patterns & Lateral Progressions',
    category: 'Number Patterns',
    chapter: 'Chapter 2: Sequences & Patterns',
    chapterIndex: 2,
    difficulty: 'Easy–Intermediate',
    conceptSummary: 'Spot the hidden rhythm in any row of numbers by checking the steps between them.',
    formula: 'Pattern Detective: Check differences between neighbors → If they change, check how the gaps grow!',
    whatItIs:
        'A number pattern is a row of numbers that changes according to a hidden rule. Your goal is to find the rule so you can predict the next number.',
    whyItWorks:
        'Every pattern has a beat. Just like walking up stairs where each step is 2 cm taller than the last, the gaps between numbers usually stay constant (+3, +3, +3) or grow by a steady amount (+2, +4, +6, +8).',
    howToSolveIt:
        '1. Step 1 (Find the Gap): Subtract each number from the one after it to find the gaps.\n'
        '2. Step 2 (Check for Constant Step): If all gaps are the same (e.g., +4), just add 4 to the last number!\n'
        '3. Step 3 (Check for Growing Gaps): If the gaps are +2, +4, +6, the next gap will be +8.\n'
        '4. Step 4 (Check for Alternating Rules): Look to see if it takes turns, like +3, then ×2, then +3, then ×2.',
    whenToUseIt:
        'Use whenever you see a row of numbers ending in a question mark, such as 3, 7, 14, 18, 36, ?.',
    stepByStepExplanation:
        'To find the missing number in any sequence, follow this simple checklist:\n'
        '1. Find the differences: How much do you add or multiply to get from one number to the next?\n'
        '2. Look for alternating operations: Does the pattern switch between two actions, like (+4) then (×2)?\n'
        '3. Look for leapfrog patterns: Sometimes the 1st, 3rd, and 5th numbers follow one rule, while the 2nd, 4th, and 6th numbers follow another!',
    workedExample:
        'Example: What comes next in: 3, 7, 14, 18, 36, ?\n'
        '• 3 to 7: Add 4 (+4)\n'
        '• 7 to 14: Multiply by 2 (×2)\n'
        '• 14 to 18: Add 4 (+4)\n'
        '• 18 to 36: Multiply by 2 (×2)\n'
        '• Pattern alternates: +4, ×2, +4, ×2. Next is +4: 36 + 4 = 40.',
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
            '• Next step is +4: 36 + 4 = 40.',
        answer: '40',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Stepping Gaps (+3, +5, +7, +9)',
        problem: '2, 5, 10, 17, 26, ?',
        stepByStepSolution:
            '• From 2 to 5 is +3\n'
            '• From 5 to 10 is +5\n'
            '• From 10 to 17 is +7\n'
            '• From 17 to 26 is +9\n'
            '• The gaps are odd numbers (+3, +5, +7, +9). Next gap is +11: 26 + 11 = 37.',
        answer: '37',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Two Patterns Taking Turns (Leapfrog)',
        problem: '4, 20, 7, 17, 10, 14, 13, ?',
        stepByStepSolution:
            '• Look at every other number:\n'
            '• Pattern A (1st, 3rd, 5th, 7th): 4, 7, 10, 13 (adds 3 each time).\n'
            '• Pattern B (2nd, 4th, 6th, 8th): 20, 17, 14, ? (subtracts 3 each time).\n'
            '• The next number belongs to Pattern B: 14 - 3 = 11.',
        answer: '11',
      ),
    ],
    commonMistakes: [
      'Assuming the rule is always just adding the same number. Always check if the operations alternate (+ then ×)!',
      'Missing leapfrog patterns: If numbers jump up and down irregularly, split them into two alternating chains.',
    ],
    shortcutsAndTricks: [
      'Square Lookups: Always keep square numbers in mind (1, 4, 9, 16, 25, 36). Patterns like 2, 5, 10, 17, 26 are just squares plus 1!',
    ],
    alternativeMethods: [
      'Write gaps underneath: Scribble the difference above or below each pair of numbers to see the gap pattern clearly.',
    ],
    sandboxType: SandboxDemoType.patterns,
    linkedLevels: [30, 44, 58, 100, 156, 296, 436],
    practiceQuestion: PracticeQuestion(
      question: 'What is the next number: 3, 7, 14, 18, 36, ?',
      correctAnswer: '40',
      hint: 'Look at what happens between numbers: (+4, ×2, +4, ×2...). What comes after ×2?',
      explanation: 'The pattern alternates +4 and ×2: 3+4=7, 7×2=14, 14+4=18, 18×2=36. Next is 36 + 4 = 40.',
      options: ['38', '40', '42', '72'],
      stepByStepGuidance: 'Check differences: 3 to 7 is +4. 7 to 14 is ×2. 14 to 18 is +4. 18 to 36 is ×2. Next operation must be +4: 36 + 4 = 40.',
      wrongOptionExplanations: {
        '38': 'Close, but check the addition: 36 + 4 = 40, not 38.',
        '42': 'Check the addition step: 36 + 4 is 40.',
        '72': '72 would be 36 × 2. But the pattern alternates (+4, ×2, +4, ×2). Since the last step was ×2, the next must be +4 (36 + 4 = 40).',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Find the next number: 2, 6, 12, 20, 30, ?',
        correctAnswer: '42',
        hint: 'Inspect the gaps: +4, +6, +8, +10. What gap comes next?',
        explanation: 'The gaps grow by 2 each time: +4, +6, +8, +10, so the next gap is +12. 30 + 12 = 42.',
        options: ['38', '40', '42', '44'],
        wrongOptionExplanations: {
          '38': 'Check the gap: the previous gap was +10, so the next gap is +12. 30 + 12 = 42.',
          '40': 'Add the next gap (+12) to 30: 30 + 12 = 42.',
          '44': '30 + 12 = 42.',
        },
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
    difficulty: 'Easy–Intermediate',
    conceptSummary: 'Master the famous Fibonacci sequence, squares, cubes, and doubling chains.',
    formula: 'Fibonacci Rule: Add the last two numbers together to get the next number: F(n) = F(n-1) + F(n-2)',
    whatItIs:
        'A sequence is a chain of numbers where every new number is made by combining the numbers that came right before it. The most famous example is the Fibonacci sequence: 1, 1, 2, 3, 5, 8, 13...',
    whyItWorks:
        'In a Fibonacci sequence, each number is simply the sum of its two previous neighbors. For example: 1+1=2, 1+2=3, 2+3=5, 3+5=8, 5+8=13. Nature uses this rule for flower petals, pinecones, and seashells!',
    howToSolveIt:
        '1. Step 1 (Test 2-Number Sum): Add the first two numbers. Does it equal the third? (e.g. 2 + 3 = 5, 3 + 5 = 8). If yes, it is Fibonacci!\n'
        '2. Step 2 (Doubling Check): Does each number double? (3, 6, 12, 24...).\n'
        '3. Step 3 (Squares Check): Are they square numbers? (1, 4, 9, 16, 25, 36...).\n'
        '4. Step 4 (Find the Next Number): Once identified, apply the rule to the last two numbers.',
    whenToUseIt:
        'Use whenever you see numbers that start slowly and begin adding up quickly (like 2, 3, 5, 8, 13, 21).',
    stepByStepExplanation:
        'Here are the three sequence types every riddle solver must know:\n'
        '1. Doubling Sequences: Multiply by 2 each time: 3, 6, 12, 24, 48...\n'
        '2. Square Numbers: Multiply a number by itself: 1, 4, 9, 16, 25, 36, 49...\n'
        '3. Fibonacci Rule: Add the previous two numbers: 2 + 3 = 5, 3 + 5 = 8, 5 + 8 = 13. Next is 8 + 13 = 21!',
    workedExample:
        'Example: Find the next number in: 2, 3, 5, 8, 13, ?\n'
        '• Notice: 2 + 3 = 5\n'
        '• 3 + 5 = 8\n'
        '• 5 + 8 = 13\n'
        '• To find the next number, add the last two: 8 + 13 = 21.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Classic Fibonacci Addition',
        problem: '3, 5, 8, 13, 21, ?',
        stepByStepSolution:
            '• Notice: 3 + 5 = 8, 5 + 8 = 13, 8 + 13 = 21.\n'
            '• Next number is 13 + 21 = 34.',
        answer: '34',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Three-Number Sum (Tribonacci)',
        problem: '1, 2, 4, 7, 13, 24, ?',
        stepByStepSolution:
            '• Add the last THREE numbers together:\n'
            '• 1 + 2 + 4 = 7\n'
            '• 2 + 4 + 7 = 13\n'
            '• 4 + 7 + 13 = 24\n'
            '• Next term is 7 + 13 + 24 = 44.',
        answer: '44',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Squares of Prime Numbers',
        problem: '4, 9, 25, 49, 121, ?',
        stepByStepSolution:
            '• Notice the square roots: √4 = 2, √9 = 3, √25 = 5, √49 = 7, √121 = 11.\n'
            '• These base numbers (2, 3, 5, 7, 11) are prime numbers!\n'
            '• The next prime number after 11 is 13.\n'
            '• 13 × 13 = 169.',
        answer: '169',
      ),
    ],
    commonMistakes: [
      'Assuming the sequence is just multiplying by 2. Always test adding the previous two numbers!',
      'Thinking 1 is a prime number (primes must have exactly two factors: 1 and itself, so primes start at 2).',
    ],
    shortcutsAndTricks: [
      'Quick Fibonacci Check: If you see 5, 8, 13 anywhere in a puzzle, it is almost certainly a Fibonacci sequence!',
    ],
    alternativeMethods: [
      'Write Previous Two: Put your fingers on the last two numbers, add them aloud, and write the sum down.',
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
        '31': 'Check your addition: 13 + 21 = 34.',
        '33': 'Close! 13 + 21 = 34.',
        '36': '13 + 21 = 34. Check the addition carefully.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'What is the 10th Fibonacci number starting 1, 1, 2, 3, 5, 8, 13, 21, 34, ?',
        correctAnswer: '55',
        hint: 'Add the last two numbers: 21 + 34 = ?',
        explanation: '21 + 34 = 55. F(10) = 55.',
        options: ['48', '50', '55', '60'],
        wrongOptionExplanations: {
          '48': 'Add 21 + 34: 20 + 30 = 50, 1 + 4 = 5. Total is 55.',
          '50': 'Don\'t forget to add the 1 and 4: 21 + 34 = 55.',
          '60': '21 + 34 = 55.',
        },
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
    difficulty: 'Intermediate',
    conceptSummary: 'Follow step-by-step arithmetic chains and learn how to solve puzzles backward with ease.',
    formula: 'Forward: Start → (+3) → (×2) | Backward: Exit → (÷2) → (-3) = Start',
    whatItIs:
        'A number maze is a path of arithmetic boxes connected by arrows. You start with a number at the entrance, follow the math instructions step by step along the path, and find the number at the exit.',
    whyItWorks:
        'Every math operation has an exact opposite (inverse): the opposite of plus is minus, and the opposite of multiply is divide. If you know the exit number, you can easily walk backward to find where you started!',
    howToSolveIt:
        '1. Forward Path: Simply do the math one step at a time in order from start to end.\n'
        '2. Backward Path (If Start is Missing): Start at the exit and do the opposite of each step in reverse order:\n'
        '   • If the step was +5, subtract 5.\n'
        '   • If the step was ×2, divide by 2.\n'
        '3. Check Your Work: Run your answer forward from the start to make sure it reaches the correct exit number.',
    whenToUseIt:
        'Use when puzzles show chained boxes with arrows, such as: [?] → (+3) → (×2) = 22.',
    stepByStepExplanation:
        'Solving number paths is simple:\n'
        '• Forward Chain: Just calculate step by step: 5 → (+3) is 8 → (×2) is 16 → (-4) is 12.\n'
        '• Solving Backward: If you have [?] → (×2) → (+6) = 22:\n'
        '  1. Start at 22.\n'
        '  2. Reverse (+6) by subtracting: 22 - 6 = 16.\n'
        '  3. Reverse (×2) by dividing: 16 ÷ 2 = 8.\n'
        '  The starting number was 8!',
    workedExample:
        'Example: Find the starting number: [?] → (×3) → (+5) = 26.\n'
        '• Walk backward from 26:\n'
        '• Reverse (+5): 26 - 5 = 21.\n'
        '• Reverse (×3): 21 ÷ 3 = 7.\n'
        '• Starting number is 7 (Check: 7 × 3 = 21, 21 + 5 = 26. Perfect!).',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Forward Step Chain',
        problem: 'Start: 5 → (+3) → (×2) → (-4) = [?]',
        stepByStepSolution:
            '• Step 1: 5 + 3 = 8\n'
            '• Step 2: 8 × 2 = 16\n'
            '• Step 3: 16 - 4 = 12.',
        answer: '12',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Working Backwards from Exit',
        problem: 'Start: [?] → (×3) → (+7) → (÷2) = 17. Find [?].',
        stepByStepSolution:
            '• Reverse (÷2) by multiplying: 17 × 2 = 34.\n'
            '• Reverse (+7) by subtracting: 34 - 7 = 27.\n'
            '• Reverse (×3) by dividing: 27 ÷ 3 = 9.\n'
            '• Starting number is 9.',
        answer: '9',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Even / Odd Rule Steps (Collatz)',
        problem: 'Apply 3 steps starting at 6: If even, divide by 2; if odd, multiply by 3 and add 1.',
        stepByStepSolution:
            '• Step 1: 6 is even → 6 ÷ 2 = 3.\n'
            '• Step 2: 3 is odd → (3 × 3) + 1 = 9 + 1 = 10.\n'
            '• Step 3: 10 is even → 10 ÷ 2 = 5.\n'
            '• Final number is 5.',
        answer: '5',
      ),
    ],
    commonMistakes: [
      'Forgetting to reverse the order when working backward: you must undo the last step first, then work back to the beginning.',
      'Forgetting to swap the signs: plus becomes minus, and times becomes divide when walking backward.',
    ],
    shortcutsAndTricks: [
      'Quick Check: Always take your final answer and run it forward through the steps to see if it lands on the target exit number.',
    ],
    alternativeMethods: [
      'Write it as an equation: If [?] × 2 + 6 = 22, treat [?] as an unknown box and solve it.',
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
        '10': 'Check the subtraction: 16 - 4 = 12, not 10.',
        '14': 'Check the subtraction: 16 - 4 = 12.',
        '16': '16 is the result before the final (-4) subtraction. 16 - 4 = 12.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Solve backwards: [?] → (+6) → (×2) = 24. What is [?]?',
        correctAnswer: '6',
        hint: 'Reverse (×2) first: 24 ÷ 2 = 12. Then reverse (+6): 12 - 6 = ?',
        explanation: '24 ÷ 2 = 12. 12 - 6 = 6.',
        options: ['4', '6', '8', '10'],
        wrongOptionExplanations: {
          '4': 'Reverse carefully: 24 ÷ 2 = 12. Then 12 - 6 = 6.',
          '8': 'Check the subtraction: 12 - 6 = 6.',
          '10': '24 ÷ 2 = 12, then 12 - 6 = 6.',
        },
      ),
    ],
    icon: Icons.navigation_rounded,
  ),

  // ===========================================================================
];
