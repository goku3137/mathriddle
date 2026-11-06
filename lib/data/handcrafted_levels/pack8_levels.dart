import '../../models/level_model.dart';

/// Handcrafted levels for Pack 8 (Levels 351–400, Difficulty: Very Expert).
const List<LevelData> pack8HandcraftedLevels = [
  // Level 355: Geometry: Triangles
  LevelData(
    id: 'hc_355',
    levelNumber: 355,
    questionType: QuestionType.Geometry,
    category: 'Geometry: Triangles',
    difficulty: 'Very Expert',
    displayContent: 'Triangle: Top² + Left² - Right² (Δ[12,9,10])',
    nodes: [
      PuzzleNode(id: 't_top', displayValue: '12', relX: 0.5, relY: 0.15),
      PuzzleNode(id: 't_left', displayValue: '9', relX: 0.15, relY: 0.8),
      PuzzleNode(id: 't_right', displayValue: '10', relX: 0.85, relY: 0.8),
      PuzzleNode(id: 't_center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.55),
    ],
    correctAnswer: '125',
    hint: 'Square each vertex: 12² + 9² - 10² = 144 + 81 - 100.',
    solution: '144 + 81 - 100 = 225 - 100 = 125.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 362: 25 Multiplication Mental Trick
  LevelData(
    id: 'hc_362',
    levelNumber: 362,
    questionType: QuestionType.Formula,
    category: 'Mathematical Trick Riddles',
    difficulty: 'Very Expert',
    displayContent: '84 × 25 = ?',
    correctAnswer: '2100',
    hint: 'To multiply by 25, divide by 4 then multiply by 100: (84 ÷ 4) × 100.',
    solution: '84 ÷ 4 = 21. 21 × 100 = 2100.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 370: Reversible Prime Logic
  LevelData(
    id: 'hc_370',
    levelNumber: 370,
    questionType: QuestionType.Formula,
    category: 'Logic Number Riddles',
    difficulty: 'Very Expert',
    displayContent: 'What 2-digit prime number, when its digits are reversed, equals 79?',
    correctAnswer: '97',
    hint: 'Reverse the digits of 79.',
    solution: 'Reversing 79 yields 97, which is a prime number.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 377: Quadratic Sequence Form
  LevelData(
    id: 'hc_377',
    levelNumber: 377,
    questionType: QuestionType.Formula,
    category: 'Number Pattern Riddles',
    difficulty: 'Very Expert',
    displayContent: '16, 23, 32, 43, 56, ?',
    correctAnswer: '71',
    hint: 'Differences increase by 2: +7, +9, +11, +13... Next difference is +15.',
    solution: '56 + 15 = 71 (follows n² + 4n + 11 for n = 6).',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 385: Markup and Discount Retail
  LevelData(
    id: 'hc_385',
    levelNumber: 385,
    questionType: QuestionType.Formula,
    category: 'Money & Shopping Riddles',
    difficulty: 'Very Expert',
    displayContent: 'A store buys an item for \$300, marks it up by 40%, then offers a 10% cash discount. What is the final selling price in dollars?',
    correctAnswer: '378',
    hint: 'Marked price is 300 × 1.40 = 420. Discounted price is 420 × 0.90.',
    solution: '300 × 1.40 = \$420. \$420 × 0.90 = \$378.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 392: 2x2 Matrix Determinant Kernel
  LevelData(
    id: 'hc_392',
    levelNumber: 392,
    questionType: QuestionType.Grid,
    category: 'Matrix & Numeric Grid Riddles',
    difficulty: 'Very Expert',
    displayContent: '3×3 Grid: Determinant Kernel (14, 5, 4, 12)',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '14'),
      PuzzleNode(id: 'r1c2', displayValue: '5'),
      PuzzleNode(id: 'r1c3', displayValue: '0'),
      PuzzleNode(id: 'r2c1', displayValue: '4'),
      PuzzleNode(id: 'r2c2', displayValue: '12'),
      PuzzleNode(id: 'r2c3', displayValue: '0'),
      PuzzleNode(id: 'r3c1', displayValue: '0'),
      PuzzleNode(id: 'r3c2', displayValue: '0'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '148',
    hint: 'Target is determinant (ad - bc) of upper-left 2×2 kernel.',
    solution: '(14 × 12) - (5 × 4) = 168 - 20 = 148.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 398: Difference of Squares Product Operator
  LevelData(
    id: 'hc_398',
    levelNumber: 398,
    questionType: QuestionType.Formula,
    category: 'Arithmetic Precedence & Lateral Operators',
    difficulty: 'Very Expert',
    displayContent: 'If a ★ b = (a + b) × (a - b), what is 25 ★ 15?',
    correctAnswer: '400',
    hint: 'Calculate sum and difference: (25 + 15) × (25 - 15).',
    solution: '40 × 10 = 400 (which equals 25² - 15² = 625 - 225 = 400).',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 400: Milestone 400 Handcrafted Challenge (Quad-Century Milestone)
  LevelData(
    id: 'hc_400',
    levelNumber: 400,
    questionType: QuestionType.Formula,
    category: 'Mathematical Sequence Puzzles',
    difficulty: 'Extreme',
    displayContent: 'Find the 12th Fibonacci number F(12), where F(1)=1, F(2)=1, F(3)=2, F(4)=3, F(5)=5...',
    correctAnswer: '144',
    hint: 'F(10) = 55, F(11) = 89. Add them together.',
    solution: 'F(12) = F(11) + F(10) = 89 + 55 = 144 (which is also 12²).',
    sourceType: QuestionSource.handcrafted,
  ),
];
