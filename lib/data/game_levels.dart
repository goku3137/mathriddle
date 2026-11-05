import '../models/level_model.dart';

final List<LevelData> gameLevels = [
  // Level 1: Order of Operations Formula
  const LevelData(
    levelNumber: 1,
    questionType: QuestionType.Formula,
    displayContent: '2 + 2 × 2 = ?',
    correctAnswer: '6',
    hint: 'Multiplication takes precedence over addition (BODMAS / PEMDAS).',
    solution: '2 × 2 = 4, then 2 + 4 = 6.',
  ),

  // Level 2: Triangle Geometry
  const LevelData(
    levelNumber: 2,
    questionType: QuestionType.Geometry,
    displayContent: 'Triangle Center Target',
    nodes: [
      PuzzleNode(id: 'top', displayValue: '3', relX: 0.5, relY: 0.16),
      PuzzleNode(id: 'left', displayValue: '5', relX: 0.15, relY: 0.82),
      PuzzleNode(id: 'right', displayValue: '2', relX: 0.85, relY: 0.82),
      PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
    ],
    correctAnswer: '17',
    hint: 'Multiply the top vertex by the bottom-left vertex, then add the bottom-right.',
    solution: '(3 × 5) + 2 = 15 + 2 = 17.',
  ),

  // Level 3: Grid Sequence (Powers)
  const LevelData(
    levelNumber: 3,
    questionType: QuestionType.Grid,
    displayContent: 'Powers of Base Numbers',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '2'),
      PuzzleNode(id: 'r1c2', displayValue: '4'),
      PuzzleNode(id: 'r1c3', displayValue: '8'),
      PuzzleNode(id: 'r2c1', displayValue: '3'),
      PuzzleNode(id: 'r2c2', displayValue: '9'),
      PuzzleNode(id: 'r2c3', displayValue: '27'),
      PuzzleNode(id: 'r3c1', displayValue: '4'),
      PuzzleNode(id: 'r3c2', displayValue: '16'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '64',
    hint: 'Each row consists of exponential powers: n¹, n², n³.',
    solution: 'Row 3 represents powers of 4: 4¹=4, 4²=16, 4³=64.',
  ),

  // Level 4: Intersecting Circles Geometry
  const LevelData(
    levelNumber: 4,
    questionType: QuestionType.Geometry,
    displayContent: 'Overlapping Circles',
    nodes: [
      PuzzleNode(id: 'left', displayValue: '14'),
      PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
      PuzzleNode(id: 'right', displayValue: '22'),
    ],
    correctAnswer: '18',
    hint: 'The center intersection is the arithmetic mean (average) of the outer circles.',
    solution: '(14 + 22) / 2 = 36 / 2 = 18.',
  ),

  // Level 5: Division & Parentheses Precedence
  const LevelData(
    levelNumber: 5,
    questionType: QuestionType.Formula,
    displayContent: '6 ÷ 2 × (1 + 2) = ?',
    correctAnswer: '9',
    hint: 'Parentheses first: (1 + 2) = 3. Division and multiplication are evaluated left to right.',
    solution: '6 ÷ 2 = 3, then 3 × 3 = 9.',
  ),

  // Level 6: Triangle Multiplier & Division
  const LevelData(
    levelNumber: 6,
    questionType: QuestionType.Geometry,
    displayContent: 'Triangle Center Target',
    nodes: [
      PuzzleNode(id: 'top', displayValue: '8'),
      PuzzleNode(id: 'left', displayValue: '6'),
      PuzzleNode(id: 'right', displayValue: '3'),
      PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '16',
    hint: 'Multiply the top vertex by the left vertex, then divide by the right vertex.',
    solution: '(8 × 6) / 3 = 48 / 3 = 16.',
  ),

  // Level 7: Magic Row Sum Grid
  const LevelData(
    levelNumber: 7,
    questionType: QuestionType.Grid,
    displayContent: 'Row Constant Sum',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '8'),
      PuzzleNode(id: 'r1c2', displayValue: '1'),
      PuzzleNode(id: 'r1c3', displayValue: '6'),
      PuzzleNode(id: 'r2c1', displayValue: '3'),
      PuzzleNode(id: 'r2c2', displayValue: '5'),
      PuzzleNode(id: 'r2c3', displayValue: '7'),
      PuzzleNode(id: 'r3c1', displayValue: '4'),
      PuzzleNode(id: 'r3c2', displayValue: '9'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '2',
    hint: 'All rows and columns sum to 15.',
    solution: 'Row 3: 4 + 9 + ? = 15. Thus, 15 - 13 = 2.',
  ),

  // Level 8: Intersecting Circles Geometric Mean
  const LevelData(
    levelNumber: 8,
    questionType: QuestionType.Geometry,
    displayContent: 'Geometric Mean Circles',
    nodes: [
      PuzzleNode(id: 'left', displayValue: '9'),
      PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
      PuzzleNode(id: 'right', displayValue: '16'),
    ],
    correctAnswer: '12',
    hint: 'Multiply the outer values and calculate the square root.',
    solution: '√(9 × 16) = √144 = 12.',
  ),

  // Level 9: Alternating Equation
  const LevelData(
    levelNumber: 9,
    questionType: QuestionType.Formula,
    displayContent: '8 - 8 × 8 + 8 = ?',
    correctAnswer: '-48',
    hint: 'Multiplication first: 8 × 8 = 64.',
    solution: '8 - 64 + 8 = -56 + 8 = -48.',
  ),

  // Level 10: Sum of Vertex Squares
  const LevelData(
    levelNumber: 10,
    questionType: QuestionType.Geometry,
    displayContent: 'Triangle Center Target',
    nodes: [
      PuzzleNode(id: 'top', displayValue: '3'),
      PuzzleNode(id: 'left', displayValue: '4'),
      PuzzleNode(id: 'right', displayValue: '5'),
      PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '50',
    hint: 'Square each vertex and sum them all together.',
    solution: '3² + 4² + 5² = 9 + 16 + 25 = 50.',
  ),

  // Level 11: Multiplicative Grid
  const LevelData(
    levelNumber: 11,
    questionType: QuestionType.Grid,
    displayContent: 'Multiplication Matrix',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '2'),
      PuzzleNode(id: 'r1c2', displayValue: '3'),
      PuzzleNode(id: 'r1c3', displayValue: '6'),
      PuzzleNode(id: 'r2c1', displayValue: '4'),
      PuzzleNode(id: 'r2c2', displayValue: '5'),
      PuzzleNode(id: 'r2c3', displayValue: '20'),
      PuzzleNode(id: 'r3c1', displayValue: '7'),
      PuzzleNode(id: 'r3c2', displayValue: '8'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '56',
    hint: 'In each row, Column 1 multiplied by Column 2 equals Column 3.',
    solution: 'Row 3: 7 × 8 = 56.',
  ),

  // Level 12: Intersecting Circles Sum of Digits
  const LevelData(
    levelNumber: 12,
    questionType: QuestionType.Geometry,
    displayContent: 'Overlapping Circles',
    nodes: [
      PuzzleNode(id: 'left', displayValue: '47'),
      PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
      PuzzleNode(id: 'right', displayValue: '29'),
    ],
    correctAnswer: '22',
    hint: 'Sum all individual digits of the numbers: 4 + 7 + 2 + 9.',
    solution: '(4 + 7) + (2 + 9) = 11 + 11 = 22.',
  ),

  // Level 13: Zero Multiplication Trick
  const LevelData(
    levelNumber: 13,
    questionType: QuestionType.Formula,
    displayContent: '10 + 10 × 0 + 10 = ?',
    correctAnswer: '20',
    hint: '10 × 0 = 0. Then perform the additions.',
    solution: '10 + 0 + 10 = 20.',
  ),

  // Level 14: Triangle Absolute Base Difference
  const LevelData(
    levelNumber: 14,
    questionType: QuestionType.Geometry,
    displayContent: 'Triangle Center Target',
    nodes: [
      PuzzleNode(id: 'top', displayValue: '9'),
      PuzzleNode(id: 'left', displayValue: '4'),
      PuzzleNode(id: 'right', displayValue: '7'),
      PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '27',
    hint: 'Multiply the top vertex by the difference between right and left base vertices.',
    solution: '9 × (7 - 4) = 9 × 3 = 27.',
  ),

  // Level 15: Grid of Perfect Squares
  const LevelData(
    levelNumber: 15,
    questionType: QuestionType.Grid,
    displayContent: 'Square Sequence Matrix',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '1'),
      PuzzleNode(id: 'r1c2', displayValue: '4'),
      PuzzleNode(id: 'r1c3', displayValue: '9'),
      PuzzleNode(id: 'r2c1', displayValue: '16'),
      PuzzleNode(id: 'r2c2', displayValue: '25'),
      PuzzleNode(id: 'r2c3', displayValue: '36'),
      PuzzleNode(id: 'r3c1', displayValue: '49'),
      PuzzleNode(id: 'r3c2', displayValue: '64'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '81',
    hint: 'Consecutive natural squares: 1², 2², 3² ... 8², 9².',
    solution: '9² = 81.',
  ),

  // Level 16: Difference Squared Geometry
  const LevelData(
    levelNumber: 16,
    questionType: QuestionType.Geometry,
    displayContent: 'Overlapping Circles',
    nodes: [
      PuzzleNode(id: 'left', displayValue: '15'),
      PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
      PuzzleNode(id: 'right', displayValue: '8'),
    ],
    correctAnswer: '49',
    hint: 'Subtract the smaller number from the larger number, then square the result.',
    solution: '(15 - 8)² = 7² = 49.',
  ),

  // Level 17: Precedence Cancellation
  const LevelData(
    levelNumber: 17,
    questionType: QuestionType.Formula,
    displayContent: '5 × 5 - 5 × 5 + 5 = ?',
    correctAnswer: '5',
    hint: 'Perform both multiplications first: 25 - 25 + 5.',
    solution: '25 - 25 + 5 = 0 + 5 = 5.',
  ),

  // Level 18: Triangle Vertex Multipliers
  const LevelData(
    levelNumber: 18,
    questionType: QuestionType.Geometry,
    displayContent: 'Triangle Center Target',
    nodes: [
      PuzzleNode(id: 'top', displayValue: '7'),
      PuzzleNode(id: 'left', displayValue: '3'),
      PuzzleNode(id: 'right', displayValue: '5'),
      PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '26',
    hint: 'Multiply Top by Left and add Right: (7 × 3) + 5.',
    solution: '21 + 5 = 26.',
  ),

  // Level 19: Grid Column Doubling
  const LevelData(
    levelNumber: 19,
    questionType: QuestionType.Grid,
    displayContent: 'Geometric Progression Grid',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '3'),
      PuzzleNode(id: 'r1c2', displayValue: '6'),
      PuzzleNode(id: 'r1c3', displayValue: '12'),
      PuzzleNode(id: 'r2c1', displayValue: '5'),
      PuzzleNode(id: 'r2c2', displayValue: '10'),
      PuzzleNode(id: 'r2c3', displayValue: '20'),
      PuzzleNode(id: 'r3c1', displayValue: '7'),
      PuzzleNode(id: 'r3c2', displayValue: '14'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '28',
    hint: 'Each number doubles across the horizontal row.',
    solution: '7 × 2 = 14, 14 × 2 = 28.',
  ),

  // Level 20: Complex Mixed Operations Grand Finale
  const LevelData(
    levelNumber: 20,
    questionType: QuestionType.Formula,
    displayContent: '7 + 7 ÷ 7 + 7 × 7 - 7 = ?',
    correctAnswer: '50',
    hint: 'Division (7 ÷ 7 = 1) and multiplication (7 × 7 = 49) first. Then add and subtract.',
    solution: '7 + 1 + 49 - 7 = 8 + 49 - 7 = 57 - 7 = 50.',
  ),
];
