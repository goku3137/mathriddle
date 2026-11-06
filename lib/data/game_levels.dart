import '../models/level_model.dart';

final List<LevelData> gameLevels = [
  // Level 1: Order of Operations Formula (Easy)
  const LevelData(
    levelNumber: 1,
    questionType: QuestionType.Formula,
    category: 'Formula Precedence',
    difficulty: 'Beginner',
    displayContent: '2 + 2 × 2 = ?',
    correctAnswer: '6',
    hint: 'Multiplication takes precedence over addition (BODMAS / PEMDAS).',
    solution: '2 × 2 = 4, then 2 + 4 = 6.',
  ),

  // Level 2: Elementary Number Pattern (Easy Beginner Step)
  const LevelData(
    levelNumber: 2,
    questionType: QuestionType.Formula,
    category: 'Number Pattern Riddles',
    difficulty: 'Beginner',
    displayContent: '2, 4, 6, 8, ?',
    correctAnswer: '10',
    hint: 'The pattern adds 2 at each step (+2 arithmetic progression).',
    solution: '8 + 2 = 10.',
  ),

  // Level 3: Simple Missing Number
  const LevelData(
    levelNumber: 3,
    questionType: QuestionType.Formula,
    category: 'Missing Number Puzzles',
    difficulty: 'Beginner',
    displayContent: '10 + ? = 17',
    correctAnswer: '7',
    hint: 'Subtract 10 from 17 to find the missing number.',
    solution: '17 - 10 = 7.',
  ),

  // Level 4: Basic Two-Operator Formula
  const LevelData(
    levelNumber: 4,
    questionType: QuestionType.Formula,
    category: 'Formula Precedence',
    difficulty: 'Beginner',
    displayContent: '3 + 3 × 3 = ?',
    correctAnswer: '12',
    hint: 'Multiply first: 3 × 3 = 9. Then add 3: 3 + 9 = 12.',
    solution: '3 × 3 = 9, then 3 + 9 = 12.',
  ),

  // Level 5: Multiples Progression
  const LevelData(
    levelNumber: 5,
    questionType: QuestionType.Formula,
    category: 'Number Pattern Riddles',
    difficulty: 'Beginner',
    displayContent: '5, 10, 15, 20, ?',
    correctAnswer: '25',
    hint: 'Each number increases by 5 (+5 progression).',
    solution: '20 + 5 = 25.',
  ),

  // Level 6: One-Step Linear Equation
  const LevelData(
    levelNumber: 6,
    questionType: QuestionType.Formula,
    category: 'Equation Riddles',
    difficulty: 'Beginner',
    displayContent: 'x + 7 = 15\nx = ?',
    correctAnswer: '8',
    hint: 'Subtract 7 from both sides: 15 - 7.',
    solution: 'x + 7 = 15\nx = 15 - 7\nx = 8.',
  ),

  // Level 7: Perfect Squares Sequence
  const LevelData(
    levelNumber: 7,
    questionType: QuestionType.Formula,
    category: 'Mathematical Sequence Puzzles',
    difficulty: 'Beginner',
    displayContent: '1, 4, 9, 16, ?',
    correctAnswer: '25',
    hint: 'Consecutive perfect squares: 1², 2², 3², 4², 5².',
    solution: '5² = 25.',
  ),

  // Level 8: Everyday Money Math
  const LevelData(
    levelNumber: 8,
    questionType: QuestionType.Formula,
    category: 'Money & Shopping Riddles',
    difficulty: 'Beginner',
    displayContent: '1 notebook (\$5) + 2 pens (\$2 each). Total = \$?',
    correctAnswer: '9',
    hint: 'Cost of 2 pens = 2 × \$2 = \$4. Plus \$5 notebook = \$9.',
    solution: '5 + (2 × 2) = 5 + 4 = 9.',
  ),

  // Level 9: Zero Multiplication Trick
  const LevelData(
    levelNumber: 9,
    questionType: QuestionType.Formula,
    category: 'Mathematical Trick Riddles',
    difficulty: 'Beginner',
    displayContent: '10 + 10 × 0 + 10 = ?',
    correctAnswer: '20',
    hint: 'Multiplication takes precedence: 10 × 0 = 0. Then add: 10 + 0 + 10.',
    solution: '10 + 0 + 10 = 20.',
  ),

  // Level 10: Simple Digit Logic
  const LevelData(
    levelNumber: 10,
    questionType: QuestionType.Formula,
    category: 'Logic Number Riddles',
    difficulty: 'Beginner',
    displayContent: 'I am an even number between 10 and 20. My ones digit is twice my tens digit. What number am I?',
    correctAnswer: '12',
    hint: 'The tens digit is 1. The ones digit is 2 × 1 = 2.',
    solution: 'Tens digit = 1, ones digit = 2, giving 12.',
  ),

  // Level 11: Introductory Lateral Operator
  const LevelData(
    levelNumber: 11,
    questionType: QuestionType.Formula,
    category: 'Arithmetic Precedence & Lateral Operators',
    difficulty: 'Beginner',
    displayContent: 'If a ⊕ b = a + b + 2, what is 4 ⊕ 5?',
    correctAnswer: '11',
    hint: 'Add the two numbers together, then add 2: 4 + 5 + 2.',
    solution: '4 + 5 + 2 = 11.',
  ),

  // Level 12: Basic Age Proportion
  const LevelData(
    levelNumber: 12,
    questionType: QuestionType.Formula,
    category: 'Age Riddles',
    difficulty: 'Beginner',
    displayContent: 'Sam is 8 years old. His older sister is twice as old as he is. How old is his sister?',
    correctAnswer: '16',
    hint: 'Multiply Sam\'s age by 2.',
    solution: '8 × 2 = 16.',
  ),

  // Level 13: Number Maze Path
  const LevelData(
    levelNumber: 13,
    questionType: QuestionType.Formula,
    category: 'Number Mazes',
    difficulty: 'Beginner',
    displayContent: 'Start: 2 → (×3) → (+4) → (-2) = ?',
    correctAnswer: '8',
    hint: '2 × 3 = 6. Then 6 + 4 = 10. Then 10 - 2 = 8.',
    solution: '(2 × 3 + 4) - 2 = 10 - 2 = 8.',
  ),

  // Level 14: Introductory 3x3 Magic Grid
  const LevelData(
    levelNumber: 14,
    questionType: QuestionType.Grid,
    category: 'Matrix & Numeric Grid Riddles',
    difficulty: 'Beginner',
    displayContent: '3×3 Grid: Row Sum 15 Magic Matrix',
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
    hint: 'All rows sum to 15. Row 3: 4 + 9 + ? = 15.',
    solution: '15 - (4 + 9) = 15 - 13 = 2.',
  ),

  // Level 15: Missing Number Equation (Replaced Geometry)
  const LevelData(
    levelNumber: 15,
    questionType: QuestionType.Formula,
    category: 'Missing Number Puzzles',
    difficulty: 'Beginner',
    displayContent: '4 × ? + 5 = 25',
    correctAnswer: '5',
    hint: 'Subtract 5 from 25, then divide by 4.',
    solution: '4 × ? = 25 - 5 = 20. Then 20 ÷ 4 = 5.',
  ),

  // Level 16: Logic Number Riddle (Replaced Geometry)
  const LevelData(
    levelNumber: 16,
    questionType: QuestionType.Formula,
    category: 'Logic Number Riddles',
    difficulty: 'Beginner',
    displayContent: 'I am a 2-digit number. My tens digit is 3, and my digits sum to 7. What number am I?',
    correctAnswer: '34',
    hint: 'The tens digit is 3. Find the ones digit: 7 - 3.',
    solution: 'Tens digit is 3. Ones digit is 7 - 3 = 4. The number is 34.',
  ),

  // Level 17: Viral Precedence Expression
  const LevelData(
    levelNumber: 17,
    questionType: QuestionType.Formula,
    category: 'Formula Precedence',
    difficulty: 'Beginner',
    displayContent: '6 ÷ 2 × (1 + 2) = ?',
    correctAnswer: '9',
    hint: 'Parentheses first: (1 + 2) = 3. Division and multiplication are evaluated left to right.',
    solution: '6 ÷ 2 = 3, then 3 × 3 = 9.',
  ),

  // Level 18: Multiplication Balance
  const LevelData(
    levelNumber: 18,
    questionType: QuestionType.Formula,
    category: 'Missing Number Puzzles',
    difficulty: 'Beginner',
    displayContent: '8 × ? = 56',
    correctAnswer: '7',
    hint: 'Divide 56 by 8.',
    solution: '56 ÷ 8 = 7.',
  ),

  // Level 19: Two-Step Linear Equation
  const LevelData(
    levelNumber: 19,
    questionType: QuestionType.Formula,
    category: 'Equation Riddles',
    difficulty: 'Beginner',
    displayContent: '2x + 4 = 16\nx = ?',
    correctAnswer: '6',
    hint: 'Subtract 4 to get 2x = 12, then divide by 2.',
    solution: '2x + 4 = 16\n2x = 12\nx = 6.',
  ),

  // Level 20: Fibonacci Sequence Intro
  const LevelData(
    levelNumber: 20,
    questionType: QuestionType.Formula,
    category: 'Mathematical Sequence Puzzles',
    difficulty: 'Beginner',
    displayContent: '1, 1, 2, 3, 5, ?',
    correctAnswer: '8',
    hint: 'Fibonacci sequence: each number is the sum of the two preceding numbers.',
    solution: '3 + 5 = 8.',
  ),
];
