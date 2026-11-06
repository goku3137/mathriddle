import '../../../../models/level_model.dart';

/// Procedural generators for pattern and sequence riddles:
/// - Category 2: Number Pattern Riddles
/// - Category 5: Mathematical Sequence Puzzles
/// - Category 6: Matrix & Numeric Grid Riddles
/// - Category 13: Number Mazes
class PatternSequenceGenerator {
  const PatternSequenceGenerator._();

  // --- Category 2: Number Pattern Riddles ---
  static LevelData generatePattern(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final start = (k * 2 % 11) + 3;
      final step = (k % 5) + 4;
      final t1 = start; final t2 = t1 + step; final t3 = t2 + step; final t4 = t3 + step;
      final ans = t4 + step;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, ?',
        correctAnswer: '$ans',
        hint: 'Notice the constant addition (+ $step) between consecutive terms.',
        solution: 'Each term increases by $step: $t4 + $step = $ans.',
      );
    } else if (tier <= 1) {
      final start = (k * 3 % 7) + 2;
      final add = (k % 4) + 1;
      final t1 = start; final t2 = t1 * 2 + add; final t3 = t2 * 2 + add; final t4 = t3 * 2 + add;
      final ans = t4 * 2 + add;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, ?',
        correctAnswer: '$ans',
        hint: 'Each number is multiplied by 2, then $add is added.',
        solution: 'Pattern is (n × 2) + $add. Next term is ($t4 × 2) + $add = $ans.',
      );
    } else if (tier <= 2) {
      final start = (k * 2 % 9) + 2;
      final a = (k % 4) + 3;
      const b = 2;
      final t1 = start; final t2 = t1 + a; final t3 = t2 * b; final t4 = t3 + a; final t5 = t4 * b;
      final ans = t5 + a;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, $t5, ?',
        correctAnswer: '$ans',
        hint: 'The operations alternate: +$a, then ×$b, then +$a, then ×$b...',
        solution: 'Following +$a, ×$b: the next operation is +$a. $t5 + $a = $ans.',
      );
    } else if (tier <= 3) {
      final start = (k * 3 % 13) + 4;
      final d1 = (k % 3) + 2;
      final acc = (k % 3) + 2;
      final t1 = start; final t2 = t1 + d1; final t3 = t2 + (d1 + acc); final t4 = t3 + (d1 + 2 * acc);
      final nextDiff = d1 + 3 * acc;
      final ans = t4 + nextDiff;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, ?',
        correctAnswer: '$ans',
        hint: 'Find the differences between terms. The difference itself grows by $acc each time.',
        solution: 'Differences are $d1, ${d1 + acc}, ${d1 + 2 * acc}. Next difference is $nextDiff: $t4 + $nextDiff = $ans.',
      );
    } else if (tier <= 4) {
      final start = (k * 2 % 17) + 2;
      final t1 = start; final t2 = t1 + 1; final t3 = t2 + 8; final t4 = t3 + 27;
      final ans = t4 + 64;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, ?',
        correctAnswer: '$ans',
        hint: 'Look at how much is added each time: 1, 8, 27... think cubes (1³, 2³, 3³).',
        solution: 'Differences are 1³, 2³, 3³. Next difference is 4³ (64): $t4 + 64 = $ans.',
      );
    } else if (tier <= 5) {
      final a = (k * 2 % 11) + 3;
      final b = (k * 3 % 7) + 2;
      final t1 = a; final t2 = b; final t3 = a + 4; final t4 = b * 2; final t5 = a + 8;
      final ans = b * 4;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, $t5, ?',
        correctAnswer: '$ans',
        hint: 'Two sequences are interwoven! Odd terms increase by 4, even terms double.',
        solution: 'Target is at even position 6. Previous even term was $t4. Doubling gives $ans.',
      );
    } else {
      final step = k - 28;
      final c = step + 2;
      final baseOffset = step * 4;
      final t1 = 1 + c + 7 + baseOffset;
      final t2 = 4 + 2 * c + 7 + baseOffset;
      final t3 = 9 + 3 * c + 7 + baseOffset;
      final t4 = 16 + 4 * c + 7 + baseOffset;
      final ans = 25 + 5 * c + 7 + baseOffset;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, ?',
        correctAnswer: '$ans',
        hint: 'The sequence follows the quadratic form n² + $c·n + ${7 + baseOffset}.',
        solution: 'For n = 5: 5² + ($c × 5) + ${7 + baseOffset} = 25 + ${c * 5} + ${7 + baseOffset} = $ans.',
      );
    }
  }

  // --- Category 5: Mathematical Sequence Puzzles ---
  static LevelData generateSequence(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k * 2 % 7) + 2; final t1 = a; final t2 = t1 * 2; final t3 = t2 * 2; final t4 = t3 * 2; final ans = t4 * 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, ?',
        correctAnswer: '$ans',
        hint: 'Each number is twice the previous number.',
        solution: '$t4 × 2 = $ans.',
      );
    } else if (tier <= 1) {
      final base = (k * 2 % 7) + 2; final t1 = base * base; final t2 = (base + 1) * (base + 1); final t3 = (base + 2) * (base + 2); final t4 = (base + 3) * (base + 3); final ans = (base + 4) * (base + 4);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, ?',
        correctAnswer: '$ans',
        hint: 'Sequence of consecutive squares: $base², ${base + 1}², ${base + 2}²...',
        solution: 'Next is ${base + 4}² = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k % 4) + 1;
      final b = a + (k % 3) + 1;
      final t1 = a; final t2 = b; final t3 = t1 + t2; final t4 = t2 + t3; final t5 = t3 + t4; final ans = t4 + t5;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, $t5, ?',
        correctAnswer: '$ans',
        hint: 'Each number is the sum of the two preceding numbers.',
        solution: '$t4 + $t5 = $ans.',
      );
    } else if (tier <= 3) {
      final t1 = (k % 3) + 1; final t2 = (k % 2) + 2; final t3 = (k % 3) + 3; final t4 = t1 + t2 + t3; final t5 = t2 + t3 + t4; final ans = t3 + t4 + t5;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, $t5, ?',
        correctAnswer: '$ans',
        hint: 'Tribonacci rule: sum of the previous three numbers.',
        solution: '$t3 + $t4 + $t5 = $ans.',
      );
    } else if (tier <= 4) {
      const primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71];
      final startIdx = (k % 12);
      final slice = primes.sublist(startIdx, startIdx + 6);
      final ans = slice[5];
      final display = '${slice.sublist(0, 5).join(', ')}, ?';
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: display,
        correctAnswer: '$ans',
        hint: 'Notice these numbers have no divisors other than 1 and themselves (prime numbers).',
        solution: 'Next prime number in the sequence is $ans.',
      );
    } else if (tier <= 5) {
      final start = (k * 3 % 13) + 3;
      final t1 = start; final t2 = t1 + 2; final t3 = t2 + 4; final t4 = t3 + 8; final t5 = t4 + 16; final ans = t5 + 32;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, $t4, $t5, ?',
        correctAnswer: '$ans',
        hint: 'The differences double each time: +2, +4, +8, +16...',
        solution: 'Next difference is 32. $t5 + 32 = $ans.',
      );
    } else {
      final step = k - 28;
      final shift = step;
      final t1 = (1 + shift) * (1 + shift) * (1 + shift) - (1 + shift) * (1 + shift) + 1;
      final t2 = (2 + shift) * (2 + shift) * (2 + shift) - (2 + shift) * (2 + shift) + 1;
      final t3 = (3 + shift) * (3 + shift) * (3 + shift) - (3 + shift) * (3 + shift) + 1;
      final ans = (4 + shift) * (4 + shift) * (4 + shift) - (4 + shift) * (4 + shift) + 1;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$t1, $t2, $t3, ?',
        correctAnswer: '$ans',
        hint: 'Generated by the cubic formula n³ - n² + 1.',
        solution: 'For next n = ${4 + shift}: ${4 + shift}³ - ${4 + shift}² + 1 = $ans.',
      );
    }
  }

  // --- Category 6: Matrix & Numeric Grid Riddles ---
  static LevelData generateGrid(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final s = (k * 2 % 7) + 15;
      final r1c1 = 4; final r1c2 = 9; final r1c3 = s - 13;
      final r2c1 = 8; final r2c2 = 5; final r2c3 = s - 13;
      final r3c1 = 3; final r3c2 = 6; final ans = s - 9;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3×3 Grid: Row Sum $s Matrix',
        nodes: [
          PuzzleNode(id: 'r1c1', displayValue: '$r1c1'),
          PuzzleNode(id: 'r1c2', displayValue: '$r1c2'),
          PuzzleNode(id: 'r1c3', displayValue: '$r1c3'),
          PuzzleNode(id: 'r2c1', displayValue: '$r2c1'),
          PuzzleNode(id: 'r2c2', displayValue: '$r2c2'),
          PuzzleNode(id: 'r2c3', displayValue: '$r2c3'),
          PuzzleNode(id: 'r3c1', displayValue: '$r3c1'),
          PuzzleNode(id: 'r3c2', displayValue: '$r3c2'),
          PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
        ],
        correctAnswer: '$ans',
        hint: 'Each horizontal row sums to $s.',
        solution: 'Row 3: $r3c1 + $r3c2 + ? = $s\n? = $ans.',
      );
    } else if (tier <= 1) {
      final a = (k * 2 % 7) + 2; final b = (k % 5) + 3; final ans = a * b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3×3 Grid: Product Matrix ($a × $b)',
        nodes: [
          PuzzleNode(id: 'r1c1', displayValue: '3'),
          PuzzleNode(id: 'r1c2', displayValue: '4'),
          PuzzleNode(id: 'r1c3', displayValue: '12'),
          PuzzleNode(id: 'r2c1', displayValue: '5'),
          PuzzleNode(id: 'r2c2', displayValue: '6'),
          PuzzleNode(id: 'r2c3', displayValue: '30'),
          PuzzleNode(id: 'r3c1', displayValue: '$a'),
          PuzzleNode(id: 'r3c2', displayValue: '$b'),
          PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
        ],
        correctAnswer: '$ans',
        hint: 'In each row, Column 1 × Column 2 = Column 3.',
        solution: 'Row 3: $a × $b = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 7) + 3; final b = (k % 5) + 4; final ans = (a + b) * 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3×3 Grid: Sum & Double Matrix ($a, $b)',
        nodes: [
          PuzzleNode(id: 'r1c1', displayValue: '2'),
          PuzzleNode(id: 'r1c2', displayValue: '3'),
          PuzzleNode(id: 'r1c3', displayValue: '10'),
          PuzzleNode(id: 'r2c1', displayValue: '4'),
          PuzzleNode(id: 'r2c2', displayValue: '5'),
          PuzzleNode(id: 'r2c3', displayValue: '18'),
          PuzzleNode(id: 'r3c1', displayValue: '$a'),
          PuzzleNode(id: 'r3c2', displayValue: '$b'),
          PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
        ],
        correctAnswer: '$ans',
        hint: 'In each row: (Col 1 + Col 2) × 2 = Col 3.',
        solution: 'Row 3: ($a + $b) × 2 = ${a + b} × 2 = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k * 2 % 7) + 3; final b = (k % 5) + 2; final ans = (a * a) + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3×3 Grid: Square & Addition Matrix ($a, $b)',
        nodes: [
          PuzzleNode(id: 'r1c1', displayValue: '3'),
          PuzzleNode(id: 'r1c2', displayValue: '4'),
          PuzzleNode(id: 'r1c3', displayValue: '13'),
          PuzzleNode(id: 'r2c1', displayValue: '4'),
          PuzzleNode(id: 'r2c2', displayValue: '5'),
          PuzzleNode(id: 'r2c3', displayValue: '21'),
          PuzzleNode(id: 'r3c1', displayValue: '$a'),
          PuzzleNode(id: 'r3c2', displayValue: '$b'),
          PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
        ],
        correctAnswer: '$ans',
        hint: 'Square the first column and add the second column: Col 1² + Col 2 = Col 3.',
        solution: 'Row 3: $a² + $b = ${a * a} + $b = $ans.',
      );
    } else if (tier <= 4) {
      final a = (k * 2 % 7) + 2; final b = (k % 5) + 3; final ans = a * b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3×3 Grid: Column Multiply ($a × $b)',
        nodes: [
          PuzzleNode(id: 'r1c1', displayValue: '2'),
          PuzzleNode(id: 'r1c2', displayValue: '3'),
          PuzzleNode(id: 'r1c3', displayValue: '$a'),
          PuzzleNode(id: 'r2c1', displayValue: '4'),
          PuzzleNode(id: 'r2c2', displayValue: '5'),
          PuzzleNode(id: 'r2c3', displayValue: '$b'),
          PuzzleNode(id: 'r3c1', displayValue: '8'),
          PuzzleNode(id: 'r3c2', displayValue: '15'),
          PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
        ],
        correctAnswer: '$ans',
        hint: 'Look vertically: Row 1 × Row 2 = Row 3 in each column.',
        solution: 'Column 3: $a × $b = $ans.',
      );
    } else if (tier <= 5) {
      final a = (k * 2 % 7) + 2; final b = (k % 4) + 3; final targetC = (k % 3) + 2; final prod = a * b * targetC;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3×3 Grid: Diagonal Product = $prod ($a × $b × ?)',
        nodes: [
          PuzzleNode(id: 'r1c1', displayValue: '$a'),
          PuzzleNode(id: 'r1c2', displayValue: '5'),
          PuzzleNode(id: 'r1c3', displayValue: '7'),
          PuzzleNode(id: 'r2c1', displayValue: '8'),
          PuzzleNode(id: 'r2c2', displayValue: '$b'),
          PuzzleNode(id: 'r2c3', displayValue: '9'),
          PuzzleNode(id: 'r3c1', displayValue: '6'),
          PuzzleNode(id: 'r3c2', displayValue: '4'),
          PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
        ],
        correctAnswer: '$targetC',
        hint: 'Multiply the main diagonal: $a × $b × ? = $prod. Find missing bottom-right element.',
        solution: '$a × $b = ${a * b}. $prod ÷ ${a * b} = $targetC.',
      );
    } else {
      final step = k - 28;
      final a = step + 6;
      final b = (step % 3) + 2;
      final c = (step % 2) + 2;
      final d = step + 5;
      final ans = (a * d) - (b * c);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3×3 Grid: Determinant Kernel ($a, $b, $c, $d)',
        nodes: [
          PuzzleNode(id: 'r1c1', displayValue: '$a'),
          PuzzleNode(id: 'r1c2', displayValue: '$b'),
          PuzzleNode(id: 'r1c3', displayValue: '0'),
          PuzzleNode(id: 'r2c1', displayValue: '$c'),
          PuzzleNode(id: 'r2c2', displayValue: '$d'),
          PuzzleNode(id: 'r2c3', displayValue: '0'),
          PuzzleNode(id: 'r3c1', displayValue: '0'),
          PuzzleNode(id: 'r3c2', displayValue: '0'),
          PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
        ],
        correctAnswer: '$ans',
        hint: 'Target is the determinant of the 2×2 upper-left kernel: (a·d) - (b·c).',
        solution: '($a × $d) - ($b × $c) = ${a * d} - ${b * c} = $ans.',
      );
    }
  }

  // --- Category 13: Number Mazes ---
  static LevelData generateMaze(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final s = (k * 2 % 7) + 3; final a = (k % 5) + 4; const b = 2; final c = (k % 4) + 2; final ans = (s + a) * b - c;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Start: $s → (+$a) → (×$b) → (-$c) = ?',
        correctAnswer: '$ans',
        hint: 'Follow the arrows step by step.',
        solution: '$s + $a = ${s + a}. ${s + a} × $b = ${(s + a) * b}. ${(s + a) * b} - $c = $ans.',
      );
    } else if (tier <= 1) {
      final s = (k * 2 % 7) + 8; final ans = (((s + 4) * 2) - 6) ~/ 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Start: $s → (+4) → (×2) → (-6) → (÷2) = ?',
        correctAnswer: '$ans',
        hint: 'Perform each operation sequentially along the path.',
        solution: '$s + 4 = ${s + 4}\n${s + 4} × 2 = ${(s + 4) * 2}\n${(s + 4) * 2} - 6 = ${(s + 4) * 2 - 6}\n${(s + 4) * 2 - 6} ÷ 2 = $ans.',
      );
    } else if (tier <= 2) {
      final s = (k * 2 % 7) + 5; final p1 = s * 2 + 3; final p2 = (s + 3) * 2; final ans = p1 + p2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Path A: $s → (×2) → (+3). Path B: $s → (+3) → (×2). What is Path A + Path B?',
        correctAnswer: '$ans',
        hint: 'Calculate the end value of both paths, then sum them.',
        solution: 'Path A = $p1. Path B = $p2. Total = $p1 + $p2 = $ans.',
      );
    } else if (tier <= 3) {
      final start = (k * 2 % 7) + 6; final endVal = start * 2 + 6;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Start: ? → (×2) → (+6) = $endVal. Find the starting value.',
        correctAnswer: '$start',
        hint: 'Work backwards from the exit: subtract 6, then divide by 2.',
        solution: '$endVal - 6 = ${endVal - 6}. ${endVal - 6} ÷ 2 = $start.',
      );
    } else if (tier <= 4) {
      final startVals = [12, 14, 20, 24, 28, 30, 36];
      final s = startVals[(k - 14) % startVals.length];
      int curr = s;
      for (int step = 0; step < 4; step++) {
        if (curr % 2 == 0) {
          curr = curr ~/ 2;
        } else {
          curr = curr * 3 + 1;
        }
      }
      final ans = curr;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Collatz rule: If even divide by 2, if odd multiply by 3 and add 1. Starting at $s, what is the value after 4 steps?',
        correctAnswer: '$ans',
        hint: 'Apply the rule 4 times consecutively starting from $s.',
        solution: 'Starting from $s: sequence reaches $ans after 4 steps.',
      );
    } else if (tier <= 5) {
      final a = (k * 2 % 5) + 2; final b = (k % 4) + 3; final c = (k % 3) + 4; final ans = a * b * c - (a + b + c);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Given numbers A = $a, B = $b, and C = $c: What is their product minus their sum: (A × B × C) - (A + B + C)?',
        correctAnswer: '$ans',
        hint: 'Calculate (A × B × C) - (A + B + C).',
        solution: '($a × $b × $c = ${a * b * c}) - ($a + $b + $c = ${a + b + c}) = $ans.',
      );
    } else {
      final s = (k * 2 % 9) + 15; final ans = ((s * 3) % 17) + 25;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Start: $s → (×3) → (mod 17) → (+25) = ?',
        correctAnswer: '$ans',
        hint: 'Multiply $s by 3, find remainder when divided by 17, then add 25.',
        solution: '$s × 3 = ${s * 3}. ${s * 3} mod 17 = ${(s * 3) % 17}. Remainder + 25 = $ans.',
      );
    }
  }
}
