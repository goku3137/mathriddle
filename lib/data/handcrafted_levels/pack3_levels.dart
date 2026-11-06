import '../../models/level_model.dart';

/// Handcrafted levels for Pack 3 (Levels 101–150, Difficulty: Intermediate).
/// Strictly contains zero geometry.
const List<LevelData> pack3HandcraftedLevels = [
  // Level 106: Increasing Difference Sequence
  LevelData(
    id: 'hc_106',
    levelNumber: 106,
    questionType: QuestionType.Formula,
    category: 'Mathematical Sequence Puzzles',
    difficulty: 'Intermediate',
    displayContent: '2, 3, 5, 8, 12, 17, ?',
    correctAnswer: '23',
    hint: 'Differences between terms grow by 1: +1, +2, +3, +4, +5...',
    solution: 'Next difference is +6. 17 + 6 = 23.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 113: Balance Scale Logic (Non-geometry)
  LevelData(
    id: 'hc_113',
    levelNumber: 113,
    questionType: QuestionType.Formula,
    category: 'Balance & Scale Riddles',
    difficulty: 'Intermediate',
    displayContent: 'On a balance scale, 4 identical spheres and an 8 kg weight balance 2 spheres and a 26 kg weight. What is the weight of one sphere in kg?',
    correctAnswer: '9',
    hint: 'Remove 2 spheres from both sides: 2 spheres + 8 kg = 26 kg.',
    solution: '2 spheres = 26 - 8 = 18 kg. 1 sphere = 18 ÷ 2 = 9 kg.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 121: Age Riddle with Invariant Difference
  LevelData(
    id: 'hc_121',
    levelNumber: 121,
    questionType: QuestionType.Formula,
    category: 'Age Riddles',
    difficulty: 'Intermediate',
    displayContent: 'A mother is 34 years old and her daughter is 8. In how many years will the mother be twice as old as her daughter?',
    correctAnswer: '18',
    hint: 'The age difference (26 years) never changes. Daughter will be 26 when mother is 52.',
    solution: '34 - 8 = 26 years difference. When daughter is 26, mother is 52 (twice 26). 26 - 8 = 18 years.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 128: Quadratic Equation Factoring
  LevelData(
    id: 'hc_128',
    levelNumber: 128,
    questionType: QuestionType.Formula,
    category: 'Equation Riddles',
    difficulty: 'Intermediate',
    displayContent: 'x² - 5x = 36\nPositive x = ?',
    correctAnswer: '9',
    hint: 'Rewrite as x(x - 5) = 36. Find two factors of 36 that differ by 5.',
    solution: '9 × (9 - 5) = 9 × 4 = 36. Positive root x = 9.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 135: Missing Number with Mixed Operations
  LevelData(
    id: 'hc_135',
    levelNumber: 135,
    questionType: QuestionType.Formula,
    category: 'Missing Number Puzzles',
    difficulty: 'Intermediate',
    displayContent: '7 × ? - 15 = 48',
    correctAnswer: '9',
    hint: 'Add 15 to 48, then divide by 7.',
    solution: '7 × ? = 48 + 15 = 63. ? = 63 ÷ 7 = 9.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 141: Custom Operator
  LevelData(
    id: 'hc_141',
    levelNumber: 141,
    questionType: QuestionType.Formula,
    category: 'Arithmetic Precedence & Lateral Operators',
    difficulty: 'Intermediate',
    displayContent: 'If a ⊕ b = ab + a - b, what is 6 ⊕ 4?',
    correctAnswer: '26',
    hint: 'Substitute a = 6 and b = 4: (6 × 4) + 6 - 4.',
    solution: '24 + 6 - 4 = 26.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 147: Gauss Summation Trick
  LevelData(
    id: 'hc_147',
    levelNumber: 147,
    questionType: QuestionType.Formula,
    category: 'Mathematical Trick Riddles',
    difficulty: 'Intermediate',
    displayContent: 'What is the sum of all integers from 1 to 20: 1 + 2 + 3 + ... + 20?',
    correctAnswer: '210',
    hint: 'Use Gauss\'s formula: n × (n + 1) ÷ 2 with n = 20.',
    solution: '20 × 21 ÷ 2 = 420 ÷ 2 = 210.',
    sourceType: QuestionSource.handcrafted,
  ),

  // Level 150: Milestone 150 Handcrafted Challenge (Intermediate Final Challenge)
  // Strictly zero geometry.
  LevelData(
    id: 'hc_150',
    levelNumber: 150,
    questionType: QuestionType.Formula,
    category: 'Proportion & Average Riddles',
    difficulty: 'Intermediate',
    displayContent: 'A student scored 75, 85, and 90 on three exams. What must they score on the 4th exam to achieve an overall average of 85?',
    correctAnswer: '90',
    hint: 'Total required score for 4 exams is 4 × 85 = 340.',
    solution: 'Current sum = 75 + 85 + 90 = 250. Required = 340 - 250 = 90.',
    sourceType: QuestionSource.handcrafted,
  ),
];
