import '../../models/level_model.dart';

/// Handcrafted levels for Pack 5 (Levels 201–250, Difficulty: Expert).
const List<LevelData> pack5HandcraftedLevels = [
  // Level 205: System of Equations
  LevelData(
    id: 'hc_205',
    levelNumber: 205,
    questionType: QuestionType.Formula,
    category: 'Equation Riddles',
    difficulty: 'Expert',
    displayContent: '2x + 3y = 31\nx + y = 12\nx × y = ?',
    correctAnswer: '35',
    hint: 'Subtract 2(x + y) = 24 from the first equation to find y.',
    solution: 'y = 31 - 24 = 7. Then x = 12 - 7 = 5. x × y = 5 × 7 = 35.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 212: Tribonacci Sequence
  LevelData(
    id: 'hc_212',
    levelNumber: 212,
    questionType: QuestionType.Formula,
    category: 'Mathematical Sequence Puzzles',
    difficulty: 'Expert',
    displayContent: '1, 2, 4, 7, 13, 24, ?',
    correctAnswer: '44',
    hint: 'Tribonacci rule: each term is the sum of the preceding three terms.',
    solution: '7 + 13 + 24 = 44.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 219: Geometry: Circles Harmonic Mean
  LevelData(
    id: 'hc_219',
    levelNumber: 219,
    questionType: QuestionType.Geometry,
    category: 'Geometry: Intersecting Circles',
    difficulty: 'Expert',
    displayContent: 'Intersecting Circles: Harmonic Intersection (30, 20)',
    nodes: [
      PuzzleNode(id: 'c_left', displayValue: '30', relX: 0.3, relY: 0.5),
      PuzzleNode(id: 'c_right', displayValue: '20', relX: 0.7, relY: 0.5),
      PuzzleNode(id: 'c_mid', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.5),
    ],
    correctAnswer: '24',
    hint: 'Harmonic mean formula: 2ab ÷ (a + b).',
    solution: '2 × 30 × 20 ÷ (30 + 20) = 1200 ÷ 50 = 24.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 227: Palindromic Digit Logic
  LevelData(
    id: 'hc_227',
    levelNumber: 227,
    questionType: QuestionType.Formula,
    category: 'Logic Number Riddles',
    difficulty: 'Expert',
    displayContent: 'What is the 3-digit palindrome whose digits multiply to 36 and sum to 13?',
    correctAnswer: '292',
    hint: 'Digits are d, m, d. 2d + m = 13 and d² × m = 36. Test d = 2.',
    solution: 'If d = 2: 2² × 9 = 36, and 2 + 9 + 2 = 13. Number is 292.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 234: Age Ratio Invariant
  LevelData(
    id: 'hc_234',
    levelNumber: 234,
    questionType: QuestionType.Formula,
    category: 'Age Riddles',
    difficulty: 'Expert',
    displayContent: 'I am twice as old as you were when I was your age. The sum of our current ages is 63. How old am I?',
    correctAnswer: '36',
    hint: 'The ratio of current ages in this classic riddle is 4 : 3.',
    solution: 'Current ages are 4k and 3k. 4k + 3k = 7k = 63 → k = 9. My age is 4 × 9 = 36.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 241: Handshake Combinatorics
  LevelData(
    id: 'hc_241',
    levelNumber: 241,
    questionType: QuestionType.Formula,
    category: 'Mathematical Trick Riddles',
    difficulty: 'Expert',
    displayContent: 'At a conference of 12 mathematicians, everyone shakes hands with everyone else exactly once. How many total handshakes occur?',
    correctAnswer: '66',
    hint: 'Use the combination formula: n(n - 1) ÷ 2 with n = 12.',
    solution: '12 × 11 ÷ 2 = 132 ÷ 2 = 66.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 247: Formula Squares Combination
  LevelData(
    id: 'hc_247',
    levelNumber: 247,
    questionType: QuestionType.Formula,
    category: 'Formula Precedence',
    difficulty: 'Expert',
    displayContent: '12² - 8² + 6² = ?',
    correctAnswer: '116',
    hint: 'Calculate each square first: 144, 64, 36.',
    solution: '144 - 64 + 36 = 80 + 36 = 116.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 250: Milestone 250 Handcrafted Challenge (Quarter-Century Expert Milestone)
  LevelData(
    id: 'hc_250',
    levelNumber: 250,
    questionType: QuestionType.Formula,
    category: 'Mathematical Trick Riddles',
    difficulty: 'Expert',
    displayContent: 'A car travels 120 km at 60 km/h, then returns along the same route at 40 km/h. What is the average speed for the round trip in km/h?',
    correctAnswer: '48',
    hint: 'Average speed = Total distance ÷ Total time. Outbound takes 2h, return takes 3h.',
    solution: 'Total distance = 240 km. Total time = 2 + 3 = 5h. 240 ÷ 5 = 48 km/h.',
    sourceType: QuestionSource.handcrafted,
  ),
];
