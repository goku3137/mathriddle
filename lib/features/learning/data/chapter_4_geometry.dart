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
];
