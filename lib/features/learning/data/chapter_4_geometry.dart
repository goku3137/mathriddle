import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

final List<Lesson> chapter4Geometry = [
  // CHAPTER 4: VISUAL & SPATIAL GEOMETRY
  // ===========================================================================

  // 11. Geometry: Triangles
  const Lesson(
    id: 'topic_triangles',
    title: '11. Geometry: Vertex Multiplier Triangles',
    category: 'Geometry: Triangles',
    chapter: 'Chapter 4: Visual Geometry',
    chapterIndex: 4,
    difficulty: 'Intermediate',
    conceptSummary: 'Discover how numbers at the 3 triangle corners work together to make the center number.',
    formula: 'Corner Recipe: (Top × Left) + Right = Center | Or: Add all three corners = Center',
    whatItIs:
        'Triangle riddles show a triangle with numbers at its three corners (Top, Left, Right) and an empty box [?] in the center. Your goal is to find the rule connecting the corners to the center.',
    whyItWorks:
        'Think of the three corners as three teammates. The puzzle combines their numbers—often multiplying the two left corners and adding the right corner—to produce the target goal in the middle.',
    howToSolveIt:
        '1. Step 1 (Try Adding): First, test if adding all 3 corners equals the center: Top + Left + Right.\n'
        '2. Step 2 (Try Multiply & Add): If the center is larger, multiply Top by Left, then add Right: (Top × Left) + Right.\n'
        '3. Step 3 (Try Squares): If the center is very large, square the corners: Top² + Left².',
    whenToUseIt:
        'Use whenever you see a triangle diagram with 3 corner numbers and a question mark in the center (from Level 151 onward in the campaign).',
    stepByStepExplanation:
        'To crack any triangle riddle, try these 3 common corner patterns:\n'
        '1. Add All Three: Center = Top + Left + Right.\n'
        '2. Multiply Left Side, Add Right: Center = (Top × Left) + Right.\n'
        '3. Divide Across: Center = (Top × Left) ÷ Right.\n\n'
        'Tip: If the center is much bigger than the corners, multiplication or squaring is always involved!',
    workedExample:
        'Example: Top = 4, Left = 6, Right = 3. What is Center?\n'
        '• Step 1: Multiply Top by Left: 4 × 6 = 24.\n'
        '• Step 2: Add Right corner: 24 + 3 = 27.\n'
        '• Center is 27.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Multiply Top-Left, Add Right',
        problem: 'Triangle has Top = 4, Left = 6, Right = 3. Using rule (Top × Left) + Right, Center = ?',
        stepByStepSolution:
            '• Multiply Top by Left: 4 × 6 = 24.\n'
            '• Add Right vertex: 24 + 3 = 27.',
        answer: '27',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Pythagorean Triangle Legs',
        problem: 'Right triangle with legs 3 and 4. What is the length of the hypotenuse?',
        stepByStepSolution:
            '• Use Pythagorean theorem: a² + b² = c².\n'
            '• 3² + 4² = 9 + 16 = 25.\n'
            '• Take square root: √25 = 5.',
        answer: '5',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Finding the Missing Corner',
        problem: 'Top = 5, Right = 3, Center = 38. Rule: (Top × Left) + Right = Center. Find Left.',
        stepByStepSolution:
            '• (5 × Left) + 3 = 38.\n'
            '• 5 × Left = 38 - 3 = 35.\n'
            '• Left = 35 ÷ 5 = 7.',
        answer: '7',
      ),
    ],
    commonMistakes: [
      'Assuming all 3 corners are just added together. In advanced levels, check for multiplication!',
      'When the question mark is at a corner instead of the center, remember to work backward.',
    ],
    shortcutsAndTricks: [
      'Corner Size Rule: If the center is big (over 20), multiply the two biggest corners first.',
    ],
    alternativeMethods: [
      'Test the 4 Options: Put each multiple-choice answer into the missing box and see which one makes the arithmetic work.',
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
        '24': 'You multiplied 4 × 6 = 24. Don\'t forget to add the Right corner (+3): 24 + 3 = 27.',
        '30': 'Check the addition: 24 + 3 is 27, not 30.',
        '33': 'Check the calculation: (4 × 6) = 24. 24 + 3 = 27.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'If Top = 5, Left = 4, Right = 2, and Center = (Top × Left) - Right, what is Center?',
        correctAnswer: '18',
        hint: 'Multiply Top and Left: 5 × 4 = 20. Then subtract Right: 20 - 2 = ?',
        explanation: '5 × 4 = 20. 20 - 2 = 18.',
        options: ['16', '18', '20', '22'],
        wrongOptionExplanations: {
          '16': '5 × 4 = 20. 20 - 2 = 18.',
          '20': 'You found 5 × 4 = 20. Now subtract Right (2): 20 - 2 = 18.',
          '22': 'The formula says subtract Right (-2), not add it! 20 - 2 = 18.',
        },
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
    difficulty: 'Intermediate',
    conceptSummary: 'Understand how numbers in two overlapping circles combine into the shared center region.',
    formula: 'Circle Overlap: Average = (Left + Right) ÷ 2 | Or Geometric: √(Left × Right)',
    whatItIs:
        'Intersecting circle riddles display two circles that overlap like a Venn diagram. Each outer circle has a number, and they share a common number in the middle overlap.',
    whyItWorks:
        'The overlap represents the bridge between both circles. In mathematical riddles, this bridge is usually the average of the two circles, the square root of their product, or the squared difference.',
    howToSolveIt:
        '1. Step 1 (Check Average): Add both outer numbers and divide by 2: (Left + Right) ÷ 2.\n'
        '2. Step 2 (Check Difference Squared): Subtract the two numbers, then square the result: (Left - Right)².\n'
        '3. Step 3 (Check Square Root): Multiply both numbers, then take the square root: √(Left × Right).',
    whenToUseIt:
        'Use whenever you see two overlapping circles with a question mark in the center intersection.',
    stepByStepExplanation:
        'Here are the 3 most common rules for overlapping circles:\n'
        '1. Average Rule: Add them together and divide by 2: (12 + 18) ÷ 2 = 15.\n'
        '2. Difference Squared: (15 - 8)² = 7² = 49.\n'
        '3. Square Root of Product: If Left is 9 and Right is 16: 9 × 16 = 144. √144 = 12!',
    workedExample:
        'Example: Left = 12, Right = 18. What is Center?\n'
        '• Rule: Center is the average (mean) of the two circles.\n'
        '• Add them: 12 + 18 = 30.\n'
        '• Divide by 2: 30 ÷ 2 = 15.',
    gradedExamples: [
      WorkedExampleItem(
        difficultyLabel: 'Level 1: Beginner',
        title: 'Average (Mean) Center',
        problem: 'Circles have Left = 12, Right = 18. Center is the average. Find Center.',
        stepByStepSolution:
            '• Sum outer circles: 12 + 18 = 30.\n'
            '• Divide by 2: 30 ÷ 2 = 15.',
        answer: '15',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 2: Standard',
        title: 'Square Root of Product (Geometric Mean)',
        problem: 'Circles have Left = 9, Right = 16. Center is √(Left × Right). Find Center.',
        stepByStepSolution:
            '• Multiply outer circles: 9 × 16 = 144.\n'
            '• Take square root: √144 = 12.',
        answer: '12',
      ),
      WorkedExampleItem(
        difficultyLabel: 'Level 3: Challenging Riddle',
        title: 'Difference Squared',
        problem: 'Circles have Left = 15, Right = 8. Center is (Left - Right)². Find Center.',
        stepByStepSolution:
            '• Subtract Right from Left: 15 - 8 = 7.\n'
            '• Square the difference: 7² = 49.',
        answer: '49',
      ),
    ],
    commonMistakes: [
      'Assuming the overlap is always simple addition. If the middle number is smaller than both, look for subtraction or square roots!',
    ],
    shortcutsAndTricks: [
      'Square Clue: If the center is a square number like 25, 36, or 49, subtract the outer numbers and square the result!',
    ],
    alternativeMethods: [
      'Quick Bounds: The average of 12 and 18 must be right in the middle (15), exactly 3 away from each number.',
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
        '14': '30 ÷ 2 = 15, not 14.',
        '16': 'Close! 12 + 18 = 30. 30 ÷ 2 is 15.',
        '18': '18 is the value of the right circle. The average is (12 + 18) ÷ 2 = 15.',
      },
    ),
    knowledgeTest: [
      PracticeQuestion(
        question: 'Left = 4, Right = 9. If Center is the geometric mean √(L × R), Center = ?',
        correctAnswer: '6',
        hint: 'Multiply 4 × 9 = 36. What is the square root of 36?',
        explanation: '√(4 × 9) = √36 = 6.',
        options: ['4', '5', '6', '7'],
        wrongOptionExplanations: {
          '4': '4 × 9 = 36. The square root of 36 is 6 (since 6 × 6 = 36).',
          '5': '5 × 5 = 25, but 4 × 9 = 36.',
          '7': '7 × 7 = 49. We need √36 = 6.',
        },
      ),
    ],
    icon: Icons.donut_large_rounded,
  ),

  // ===========================================================================
];
