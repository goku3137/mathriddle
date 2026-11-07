import '../../models/level_model.dart';

/// Handcrafted levels for Pack 2 (Levels 51–100, Difficulty: Easy–Intermediate).
/// Strictly contains zero geometry.
const List<LevelData> pack2HandcraftedLevels = [
  // Level 55: Doubling Plus One Pattern
  LevelData(
    id: 'hc_055',
    levelNumber: 55,
    questionType: QuestionType.Formula,
    category: 'Number Pattern Riddles',
    difficulty: 'Easy–Intermediate',
    displayContent: '3, 7, 15, 31, ?',
    correctAnswer: '63',
    hint: 'Each number is twice the previous number plus 1: (n × 2) + 1.',
    solution: '31 × 2 + 1 = 62 + 1 = 63.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 62: Two-Step Linear Equation
  LevelData(
    id: 'hc_062',
    levelNumber: 62,
    questionType: QuestionType.Formula,
    category: 'Equation Riddles',
    difficulty: 'Easy–Intermediate',
    displayContent: '3x + 14 = 44\nx = ?',
    correctAnswer: '10',
    hint: 'Subtract 14 from 44, then divide by 3.',
    solution: '3x = 44 - 14 = 30. x = 30 ÷ 3 = 10.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 69: Proportion & Average Riddle (Non-geometry)
  LevelData(
    id: 'hc_069',
    levelNumber: 69,
    questionType: QuestionType.Formula,
    category: 'Proportion & Average Riddles',
    difficulty: 'Easy–Intermediate',
    displayContent: 'Three quiz scores are 14, 18, and 28. What is the average score?',
    correctAnswer: '20',
    hint: 'Sum all three scores and divide by 3.',
    solution: '14 + 18 + 28 = 60. 60 ÷ 3 = 20.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 76: Lateral Operator Definition
  LevelData(
    id: 'hc_076',
    levelNumber: 76,
    questionType: QuestionType.Formula,
    category: 'Arithmetic Precedence & Lateral Operators',
    difficulty: 'Easy–Intermediate',
    displayContent: 'If a ★ b = 3a + 2b, what is 4 ★ 7?',
    correctAnswer: '26',
    hint: 'Substitute a = 4 and b = 7 into the formula: 3(4) + 2(7).',
    solution: '3 × 4 = 12. 2 × 7 = 14. 12 + 14 = 26.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 83: Discount Calculation
  LevelData(
    id: 'hc_083',
    levelNumber: 83,
    questionType: QuestionType.Formula,
    category: 'Money & Shopping Riddles',
    difficulty: 'Easy–Intermediate',
    displayContent: 'A jacket originally priced at \$120 is on sale for 25% off. What is the sale price in dollars?',
    correctAnswer: '90',
    hint: '25% of \$120 is \$30. Subtract the discount from the original price.',
    solution: 'Discount = 120 × 0.25 = 30. Sale price = 120 - 30 = 90.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 89: Reversible Number Maze
  LevelData(
    id: 'hc_089',
    levelNumber: 89,
    questionType: QuestionType.Formula,
    category: 'Number Mazes',
    difficulty: 'Easy–Intermediate',
    displayContent: 'Start: 8 → (+6) → (×3) → (-12) → (÷3) = ?',
    correctAnswer: '10',
    hint: 'Follow the operations step by step in sequence.',
    solution: '8 + 6 = 14. 14 × 3 = 42. 42 - 12 = 30. 30 ÷ 3 = 10.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 95: Digit Deduction Logic
  LevelData(
    id: 'hc_095',
    levelNumber: 95,
    questionType: QuestionType.Formula,
    category: 'Logic Number Riddles',
    difficulty: 'Easy–Intermediate',
    displayContent: 'I am a 2-digit number whose tens digit is 4 times my ones digit. The sum of my digits is 10. What number am I?',
    correctAnswer: '82',
    hint: 'If ones digit is u, tens digit is 4u. 4u + u = 5u = 10.',
    solution: 'u = 10 ÷ 5 = 2. Tens digit = 4 × 2 = 8. The number is 82.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 100: Milestone 100 Handcrafted Challenge (Century Milestone)
  LevelData(
    id: 'hc_100',
    levelNumber: 100,
    questionType: QuestionType.Grid,
    category: 'Matrix & Numeric Grid Riddles',
    difficulty: 'Easy–Intermediate',
    displayContent: '3×3 Grid: Product Matrix (7 × 8)',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '3'),
      PuzzleNode(id: 'r1c2', displayValue: '4'),
      PuzzleNode(id: 'r1c3', displayValue: '12'),
      PuzzleNode(id: 'r2c1', displayValue: '5'),
      PuzzleNode(id: 'r2c2', displayValue: '6'),
      PuzzleNode(id: 'r2c3', displayValue: '30'),
      PuzzleNode(id: 'r3c1', displayValue: '7'),
      PuzzleNode(id: 'r3c2', displayValue: '8'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '56',
    hint: 'In each row, Column 1 × Column 2 = Column 3.',
    solution: 'Row 3: 7 × 8 = 56.',
    sourceType: QuestionSource.handcrafted,
  ),
];
