import '../../models/level_model.dart';

/// Handcrafted levels for Pack 4 (Levels 151–200, Difficulty: Advanced).
/// Geometry is introduced from Level 151 onward.
const List<LevelData> pack4HandcraftedLevels = [
  // Level 154: Introduction to Geometry: Triangles
  LevelData(
    id: 'hc_154',
    levelNumber: 154,
    questionType: QuestionType.Geometry,
    category: 'Geometry: Triangles',
    difficulty: 'Advanced',
    displayContent: 'Triangle: Vertex Product & Base Ratio (Δ[6,8,4])',
    nodes: [
      PuzzleNode(id: 't_top', displayValue: '6', relX: 0.5, relY: 0.15),
      PuzzleNode(id: 't_left', displayValue: '8', relX: 0.15, relY: 0.8),
      PuzzleNode(id: 't_right', displayValue: '4', relX: 0.85, relY: 0.8),
      PuzzleNode(id: 't_center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.55),
    ],
    correctAnswer: '12',
    hint: 'Multiply the top and left vertices, then divide by the base right vertex: (6 × 8) ÷ 4.',
    solution: '(6 × 8) ÷ 4 = 48 ÷ 4 = 12.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 161: Consecutive Cubes Sequence
  LevelData(
    id: 'hc_161',
    levelNumber: 161,
    questionType: QuestionType.Formula,
    category: 'Mathematical Sequence Puzzles',
    difficulty: 'Advanced',
    displayContent: '1, 8, 27, 64, ?',
    correctAnswer: '125',
    hint: 'Sequence of consecutive perfect cubes: 1³, 2³, 3³, 4³...',
    solution: '5³ = 5 × 5 × 5 = 125.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 168: Automorphic Number Logic
  LevelData(
    id: 'hc_168',
    levelNumber: 168,
    questionType: QuestionType.Formula,
    category: 'Logic Number Riddles',
    difficulty: 'Advanced',
    displayContent: 'What 2-digit number has a square (625) that ends in the number itself?',
    correctAnswer: '25',
    hint: 'Think of a 2-digit multiple of 5.',
    solution: '25² = 625, which ends in 25.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 175: Geometry: Intersecting Circles
  LevelData(
    id: 'hc_175',
    levelNumber: 175,
    questionType: QuestionType.Geometry,
    category: 'Geometry: Intersecting Circles',
    difficulty: 'Advanced',
    displayContent: 'Intersecting Circles: Geometric Mean Center (16, 36)',
    nodes: [
      PuzzleNode(id: 'c_left', displayValue: '16', relX: 0.3, relY: 0.5),
      PuzzleNode(id: 'c_right', displayValue: '36', relX: 0.7, relY: 0.5),
      PuzzleNode(id: 'c_mid', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.5),
    ],
    correctAnswer: '24',
    hint: 'The central overlap represents the geometric mean: √(Left × Right).',
    solution: '√(16 × 36) = √576 = 24.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 182: Successive Discounts
  LevelData(
    id: 'hc_182',
    levelNumber: 182,
    questionType: QuestionType.Formula,
    category: 'Money & Shopping Riddles',
    difficulty: 'Advanced',
    displayContent: 'A jacket originally priced at \$500 has a 30% discount, followed by an additional 20% clearance markdown. What is the final price in dollars?',
    correctAnswer: '280',
    hint: 'First discount: 500 × 0.70 = 350. Clearance markdown: 350 × 0.80.',
    solution: '\$500 × 0.70 = \$350. Then \$350 × 0.80 = \$280.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 189: Matrix Determinant Kernel
  LevelData(
    id: 'hc_189',
    levelNumber: 189,
    questionType: QuestionType.Grid,
    category: 'Matrix & Numeric Grid Riddles',
    difficulty: 'Advanced',
    displayContent: '3×3 Grid: Determinant Kernel (a=8, b=5, c=3, d=7)',
    nodes: [
      PuzzleNode(id: 'r1c1', displayValue: '8'),
      PuzzleNode(id: 'r1c2', displayValue: '5'),
      PuzzleNode(id: 'r1c3', displayValue: '0'),
      PuzzleNode(id: 'r2c1', displayValue: '3'),
      PuzzleNode(id: 'r2c2', displayValue: '7'),
      PuzzleNode(id: 'r2c3', displayValue: '0'),
      PuzzleNode(id: 'r3c1', displayValue: '0'),
      PuzzleNode(id: 'r3c2', displayValue: '0'),
      PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
    ],
    correctAnswer: '41',
    hint: 'Determinant of 2×2 kernel: (a × d) - (b × c).',
    solution: '(8 × 7) - (5 × 3) = 56 - 15 = 41.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 196: Collatz Conjecture Path Maze
  LevelData(
    id: 'hc_196',
    levelNumber: 196,
    questionType: QuestionType.Formula,
    category: 'Number Mazes',
    difficulty: 'Advanced',
    displayContent: 'Collatz rule: If even divide by 2, if odd multiply by 3 and add 1. Starting at 18, what is the value after 4 steps?',
    correctAnswer: '7',
    hint: 'Step 1: 18÷2=9. Step 2: 9×3+1=28. Step 3: 28÷2=14. Step 4: 14÷2=?',
    solution: '18 → 9 → 28 → 14 → 7. After 4 steps the value is 7.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 200: Milestone 200 Handcrafted Challenge (Advanced Milestone / Gateway)
  LevelData(
    id: 'hc_200',
    levelNumber: 200,
    questionType: QuestionType.Geometry,
    category: 'Geometry: Triangles',
    difficulty: 'Expert',
    displayContent: 'Right triangle with perpendicular legs 15 and 20. What is the length of the hypotenuse?',
    nodes: [
      PuzzleNode(id: 't_vert', displayValue: '15', relX: 0.20, relY: 0.50),
      PuzzleNode(id: 't_base', displayValue: '20', relX: 0.50, relY: 0.85),
      PuzzleNode(id: 't_hyp', displayValue: '?', isTarget: true, relX: 0.65, relY: 0.45),
    ],
    correctAnswer: '25',
    hint: 'Use the Pythagorean theorem: a² + b² = c².',
    solution: '15² + 20² = 225 + 400 = 625. √625 = 25.',
    sourceType: QuestionSource.handcrafted,
  ),
];
