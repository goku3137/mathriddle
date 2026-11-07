import '../../models/level_model.dart';

/// Handcrafted levels for Pack 6 (Levels 251–300, Difficulty: Expert).
const List<LevelData> pack6HandcraftedLevels = [
  // Level 255: Geometry: Triangles
  LevelData(
    id: 'hc_255',
    levelNumber: 255,
    questionType: QuestionType.Geometry,
    category: 'Geometry: Triangles',
    difficulty: 'Expert',
    displayContent: 'Triangle: (Top × Left) - Right (Δ[8,9,6])',
    nodes: [
      PuzzleNode(id: 't_top', displayValue: '8', relX: 0.5, relY: 0.15),
      PuzzleNode(id: 't_left', displayValue: '9', relX: 0.15, relY: 0.8),
      PuzzleNode(id: 't_right', displayValue: '6', relX: 0.85, relY: 0.8),
      PuzzleNode(id: 't_center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.55),
    ],
    correctAnswer: '66',
    hint: 'Multiply top vertex 8 by left vertex 9, then subtract right vertex 6.',
    solution: '(8 × 9) - 6 = 72 - 6 = 66.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 262: Diophantine Linear Equation
  LevelData(
    id: 'hc_262',
    levelNumber: 262,
    questionType: QuestionType.Formula,
    category: 'Equation Riddles',
    difficulty: 'Expert',
    displayContent: '5x + 7y = 47\nPositive integers x, y\nx + y = ?',
    correctAnswer: '7',
    hint: 'Test multiples of 7: 47 - 7(6) = 5 (so x = 1, y = 6).',
    solution: '5(1) + 7(6) = 5 + 42 = 47. Therefore x = 1, y = 6, and x + y = 7.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 270: Missing Number Balance
  LevelData(
    id: 'hc_270',
    levelNumber: 270,
    questionType: QuestionType.Formula,
    category: 'Missing Number Puzzles',
    difficulty: 'Expert',
    displayContent: '15 + 4 × ? = 75',
    correctAnswer: '15',
    hint: 'Subtract 15 from 75, then divide by 4.',
    solution: '4 × ? = 75 - 15 = 60. ? = 60 ÷ 4 = 15.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 277: Matrix Diagonal Product
  LevelData(
    id: 'hc_277',
    levelNumber: 277,
    questionType: QuestionType.Grid,
    category: 'Matrix & Numeric Grid Riddles',
    difficulty: 'Expert',
    displayContent: '3×3 Grid: Diagonal Product = 96 (3 × 4 × ?)',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '3'),
      PuzzleNode(id: 'r1c2', displayValue: '5'),
      PuzzleNode(id: 'r1c3', displayValue: '7'),
      PuzzleNode(id: 'r2c1', displayValue: '8'),
      PuzzleNode(id: 'r2c2', displayValue: '4'),
      PuzzleNode(id: 'r2c3', displayValue: '9'),
      PuzzleNode(id: 'r3c1', displayValue: '6'),
      PuzzleNode(id: 'r3c2', displayValue: '2'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '8',
    hint: 'Multiply the main diagonal: 3 × 4 × ? = 96.',
    solution: '3 × 4 = 12. 96 ÷ 12 = 8.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 284: Prime Number Sequence
  LevelData(
    id: 'hc_284',
    levelNumber: 284,
    questionType: QuestionType.Formula,
    category: 'Mathematical Sequence Puzzles',
    difficulty: 'Expert',
    displayContent: '29, 31, 37, 41, 43, ?',
    correctAnswer: '47',
    hint: 'Consecutive prime numbers greater than 25.',
    solution: 'The prime number immediately following 43 is 47.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 291: Profit Margin & Retail
  LevelData(
    id: 'hc_291',
    levelNumber: 291,
    questionType: QuestionType.Formula,
    category: 'Money & Shopping Riddles',
    difficulty: 'Expert',
    displayContent: 'An item purchased for \$250 is sold at a 20% profit. What is the selling price in dollars?',
    correctAnswer: '300',
    hint: '20% profit means selling at 120% of the cost price.',
    solution: '\$250 × 1.20 = \$300.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 297: Modulo Arithmetic Maze
  LevelData(
    id: 'hc_297',
    levelNumber: 297,
    questionType: QuestionType.Formula,
    category: 'Number Mazes',
    difficulty: 'Expert',
    displayContent: 'Start: 25 → (×3) → (mod 17) → (+25) = ?',
    correctAnswer: '32',
    hint: '25 × 3 = 75. 75 divided by 17 leaves a remainder of 7.',
    solution: '25 × 3 = 75. 75 mod 17 = 7 (since 17 × 4 = 68). 7 + 25 = 32.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 300: Milestone 300 Handcrafted Challenge (Triple-Century Milestone)
  LevelData(
    id: 'hc_300',
    levelNumber: 300,
    questionType: QuestionType.Grid,
    category: 'Matrix & Numeric Grid Riddles',
    difficulty: 'Very Expert',
    displayContent: '3×3 Grid: Sum & Double Matrix (12, 15)',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '2'),
      PuzzleNode(id: 'r1c2', displayValue: '3'),
      PuzzleNode(id: 'r1c3', displayValue: '10'),
      PuzzleNode(id: 'r2c1', displayValue: '4'),
      PuzzleNode(id: 'r2c2', displayValue: '5'),
      PuzzleNode(id: 'r2c3', displayValue: '18'),
      PuzzleNode(id: 'r3c1', displayValue: '12'),
      PuzzleNode(id: 'r3c2', displayValue: '15'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '54',
    hint: 'In each row: (Col 1 + Col 2) × 2 = Col 3.',
    solution: 'Row 3: (12 + 15) × 2 = 27 × 2 = 54.',
    sourceType: QuestionSource.handcrafted,
  ),
];
