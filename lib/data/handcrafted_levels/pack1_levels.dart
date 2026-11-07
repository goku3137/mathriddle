import '../../models/level_model.dart';

/// Handcrafted levels for Pack 1 (Levels 1–50, Difficulty: Beginner).
/// Strictly contains zero geometry.
const List<LevelData> pack1HandcraftedLevels = [
  // Level 1: Classic Order of Operations (Beginner Intro)
  LevelData(
    id: 'hc_001',
    levelNumber: 1,
    questionType: QuestionType.Formula,
    category: 'Formula Precedence',
    difficulty: 'Beginner',
    displayContent: '2 + 2 × 2 = ?',
    correctAnswer: '6',
    hint: 'Multiplication takes precedence over addition (BODMAS / PEMDAS).',
    solution: '2 × 2 = 4, then 2 + 4 = 6.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 4: Basic Two-Operator Formula
  LevelData(
    id: 'hc_004',
    levelNumber: 4,
    questionType: QuestionType.Formula,
    category: 'Formula Precedence',
    difficulty: 'Beginner',
    displayContent: '3 + 3 × 3 = ?',
    correctAnswer: '12',
    hint: 'Multiply first: 3 × 3 = 9. Then add 3: 3 + 9 = 12.',
    solution: '3 × 3 = 9, then 3 + 9 = 12.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 9: Zero Multiplication Trick
  LevelData(
    id: 'hc_009',
    levelNumber: 9,
    questionType: QuestionType.Formula,
    category: 'Mathematical Trick Riddles',
    difficulty: 'Beginner',
    displayContent: '10 + 10 × 0 + 10 = ?',
    correctAnswer: '20',
    hint: 'Multiplication takes precedence: 10 × 0 = 0. Then add: 10 + 0 + 10.',
    solution: '10 + 0 + 10 = 20.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 14: Introductory 3x3 Magic Grid
  LevelData(
    id: 'hc_014',
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
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 22: Balance & Scale Riddle (Non-geometry)
  LevelData(
    id: 'hc_022',
    levelNumber: 22,
    questionType: QuestionType.Formula,
    category: 'Balance & Scale Riddles',
    difficulty: 'Beginner',
    displayContent: 'On a balance scale, 3 identical boxes and a 4 kg weight balance a 19 kg weight. What is the weight of one box in kg?',
    correctAnswer: '5',
    hint: 'Subtract the extra 4 kg from 19 kg, then divide the remainder by 3.',
    solution: '19 - 4 = 15 kg. 15 ÷ 3 = 5 kg per box.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 31: Everyday Shopping & Money Riddle
  LevelData(
    id: 'hc_031',
    levelNumber: 31,
    questionType: QuestionType.Formula,
    category: 'Money & Shopping Riddles',
    difficulty: 'Beginner',
    displayContent: 'A notebook costs \$7 and 3 pens cost \$2 each. What is the total cost in dollars?',
    correctAnswer: '13',
    hint: 'Calculate the total cost of the 3 pens first, then add the notebook.',
    solution: '3 pens cost 3 × \$2 = \$6. Total = \$7 + \$6 = \$13.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 42: Age Riddle (Beginner)
  LevelData(
    id: 'hc_042',
    levelNumber: 42,
    questionType: QuestionType.Formula,
    category: 'Age Riddles',
    difficulty: 'Beginner',
    displayContent: 'Leo is 9 years old. In 7 years, his brother will be twice as old as Leo is today. How old is his brother now?',
    correctAnswer: '11',
    hint: 'Twice Leo\'s current age is 18. Subtract 7 years to find his brother\'s age now.',
    solution: 'Twice Leo\'s age = 2 × 9 = 18. In 7 years brother is 18, so today brother is 18 - 7 = 11.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 50: Milestone 50 Handcrafted Challenge (Beginner Final Challenge)
  LevelData(
    id: 'hc_050',
    levelNumber: 50,
    questionType: QuestionType.Formula,
    category: 'Formula Precedence',
    difficulty: 'Beginner',
    displayContent: '(5 + 5) × 5 - (5 ÷ 5) = ?',
    correctAnswer: '49',
    hint: 'Evaluate both parentheses first, then multiply, then subtract.',
    solution: '(5 + 5) = 10. (5 ÷ 5) = 1. Then 10 × 5 = 50. Finally 50 - 1 = 49.',
    sourceType: QuestionSource.handcrafted,
  ),
];

