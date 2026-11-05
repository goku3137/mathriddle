import '../../../data/game_levels.dart';
import '../../../models/level_model.dart';

/// Pure procedural math puzzle generation engine for levels 21 to 500 across 14 categories.
class ProceduralLevelGenerator {
  ProceduralLevelGenerator._();

  static const List<String> categories = [
    'Formula Precedence',                        // 0
    'Geometry: Triangles',                       // 1
    'Number Pattern Riddles',                    // 2
    'Missing Number Puzzles',                    // 3
    'Equation Riddles',                          // 4
    'Mathematical Sequence Puzzles',             // 5
    'Matrix & Numeric Grid Riddles',             // 6
    'Money & Shopping Riddles',                  // 7
    'Logic Number Riddles',                      // 8
    'Geometry: Intersecting Circles',            // 9
    'Arithmetic Precedence & Lateral Operators', // 10
    'Age Riddles',                               // 11
    'Mathematical Trick Riddles',                // 12
    'Number Mazes',                              // 13
  ];

  static String getDifficulty(int level) {
    if (level <= 50) return 'Beginner';
    if (level <= 100) return 'Easy–Intermediate';
    if (level <= 150) return 'Intermediate';
    if (level <= 199) return 'Advanced';
    if (level <= 299) return 'Expert';
    if (level <= 399) return 'Very Expert';
    if (level <= 499) return 'Extreme';
    return 'Final Boss';
  }

  static int getTier(int level) {
    if (level <= 50) return 0;
    if (level <= 100) return 1;
    if (level <= 150) return 2;
    if (level <= 199) return 3;
    if (level <= 299) return 4;
    if (level <= 399) return 5;
    if (level <= 499) return 6;
    return 7;
  }
  /// Master level generation factory for all 500 levels
  static LevelData generateLevel(int level) {
    if (level <= gameLevels.length) {
      return gameLevels[level - 1];
    }

    if (level == 500) {
      return const LevelData(
        levelNumber: 500,
        questionType: QuestionType.Formula,
        category: 'Final Boss: Grand Singularity',
        difficulty: 'Final Boss',
        displayContent: 'BOSS: (Î”[7,8,4] Ã— âŠž[Diag 12,15,18]) - F(10) = ?',
        correctAnswer: '575',
        hint: 'Solve Stage 1 (Triangle vertex: 7Ã—8Ã·4), Stage 2 (Matrix diagonal sum), and subtract the 10th Fibonacci number.',
        solution: 'Stage 1 (Triangle): (7 Ã— 8) Ã· 4 = 14. Stage 2 (Matrix): 12 + 15 + 18 = 45. Stage 3 (Fibonacci): F(10) = 55. Final Singularity: (14 Ã— 45) - 55 = 630 - 55 = 575.',
      );
    }

    final catIndex = (level - 1) % 14;
    final category = categories[catIndex];
    final difficulty = getDifficulty(level);
    final tier = getTier(level);
    final k = (level - 1) ~/ 14;

    switch (catIndex) {
      case 0:
        return _generateFormula(level, category, difficulty, tier, k);
      case 1:
        return _generateTriangle(level, category, difficulty, tier, k);
      case 2:
        return _generatePattern(level, category, difficulty, tier, k);
      case 3:
        return _generateMissing(level, category, difficulty, tier, k);
      case 4:
        return _generateEquation(level, category, difficulty, tier, k);
      case 5:
        return _generateSequence(level, category, difficulty, tier, k);
      case 6:
        return _generateGrid(level, category, difficulty, tier, k);
      case 7:
        return _generateMoney(level, category, difficulty, tier, k);
      case 8:
        return _generateLogic(level, category, difficulty, tier, k);
      case 9:
        return _generateCircles(level, category, difficulty, tier, k);
      case 10:
        return _generateOperator(level, category, difficulty, tier, k);
      case 11:
        return _generateAge(level, category, difficulty, tier, k);
      case 12:
        return _generateTrick(level, category, difficulty, tier, k);
      case 13:
      default:
        return _generateMaze(level, category, difficulty, tier, k);
    }
  }

  // --- Category 0: Formula Precedence ---
  static LevelData _generateFormula(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k % 5) + 3;
      final b = (k % 4) + 2;
      final c = (k % 6) + 3;
      final d = (k % 4) + 1;
      final ans = a + (b * c) - d;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$a + $b Ã— $c - $d = ?',
        correctAnswer: '$ans',
        hint: 'Perform multiplication ($b Ã— $c) before addition and subtraction.',
        solution: '$b Ã— $c = ${b * c}. Then $a + ${b * c} - $d = $ans.',
      );
    } else if (tier <= 1) {
      final a = (k % 6) + 2;
      final b = (k % 5) + 3;
      final c = (k % 4) + 2;
      final d = (k % 4) + 1;
      final ans = (a + b) * c - d;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '($a + $b) Ã— $c - $d = ?',
        correctAnswer: '$ans',
        hint: 'Parentheses first: ($a + $b), then multiply by $c, then subtract $d.',
        solution: '($a + $b) = ${a + b}. ${a + b} Ã— $c = ${(a + b) * c}. Then ${(a + b) * c} - $d = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k % 4) + 3;
      final b = (k % 3) + 2;
      final c = (k % 5) + 4;
      final d = (k % 3) + 2;
      final ans = (a * a) + b * (c - d);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$aÂ² + $b Ã— ($c - $d) = ?',
        correctAnswer: '$ans',
        hint: 'Evaluate exponent $aÂ² and parentheses ($c - $d) first, then multiply by $b.',
        solution: '$aÂ² = ${a * a}, ($c - $d) = ${c - d}. $b Ã— ${c - d} = ${b * (c - d)}. ${a * a} + ${b * (c - d)} = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k % 3) + 3;
      final b = (k % 4) + 2;
      final c = (k % 3) + 2;
      final d = (k % 5) + 10;
      final ans = (a * a * a) - (b * c) + d;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$aÂ³ - $b Ã— $c + $d = ?',
        correctAnswer: '$ans',
        hint: 'Calculate cube $aÂ³ first, then multiplication $b Ã— $c.',
        solution: '$aÂ³ = ${a * a * a}. $b Ã— $c = ${b * c}. ${a * a * a} - ${b * c} + $d = $ans.',
      );
    } else if (tier <= 4) {
      final a = (k % 4) + 4;
      final b = (k % 3) + 2;
      const c = 2;
      final d = (k % 4) + 3;
      final e = (k % 5) + 2;
      final sumSq = a * a + b * b;
      final evenSumSq = (sumSq % 2 == 0) ? sumSq : sumSq + 1;
      final ans = ((evenSumSq) ~/ c) * d - e;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '[($evenSumSq) Ã· $c] Ã— $d - $e = ?',
        correctAnswer: '$ans',
        hint: 'Divide the bracket by $c first, then multiply by $d and subtract $e.',
        solution: '$evenSumSq Ã· $c = ${evenSumSq ~/ c}. Multiplied by $d = ${(evenSumSq ~/ c) * d}. Minus $e = $ans.',
      );
    } else if (tier <= 5) {
      final a = (k % 3) + 3;
      final b = (k % 3) + 2;
      final diff = (a * a * a * a) - (b * b * b * b);
      final denom = (a * a) + (b * b);
      final c = (k % 5) + 6;
      final ans = (diff ~/ denom) + (c * c);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '($aâ´ - $bâ´) Ã· ($aÂ² + $bÂ²) + $cÂ² = ?',
        correctAnswer: '$ans',
        hint: 'Factor the numerator: aâ´ - bâ´ = (aÂ² - bÂ²)(aÂ² + bÂ²).',
        solution: '($aâ´ - $bâ´) Ã· ($aÂ² + $bÂ²) = $aÂ² - $bÂ² = ${a * a - b * b}. Adding $cÂ² (${c * c}) gives $ans.',
      );
    } else {
      final b = (k % 3) + 2;
      final a = b + (k % 3) + 2; // a strictly > b, so (a - b) >= 2, no div-by-zero
      final c = (k % 4) + 3;
      final d = (k % 5) + 5;
      final ans = ((a * a * a - b * b * b) ~/ (a - b)) - (a * b) + (c * d);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '[($aÂ³ - $bÂ³) Ã· ($a - $b) - ($a Ã— $b)] + ($c Ã— $d) = ?',
        correctAnswer: '$ans',
        hint: 'Algebraic identity: (aÂ³ - bÂ³)/(a - b) = aÂ² + ab + bÂ². Subtracting ab leaves aÂ² + bÂ².',
        solution: '(aÂ³ - bÂ³)/(a - b) - ab = aÂ² + bÂ² = ${a * a + b * b}. Adding $c Ã— $d (${c * d}) yields $ans.',
      );
    }
  }

  // --- Category 1: Number Pattern Riddles ---
  static LevelData _generatePattern(int level, String category, String difficulty, int tier, int k) {
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
        solution: 'Pattern is (n Ã— 2) + $add. Next term is ($t4 Ã— 2) + $add = $ans.',
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
        hint: 'The operations alternate: +$a, then Ã—$b, then +$a, then Ã—$b...',
        solution: 'Following +$a, Ã—$b: the next operation is +$a. $t5 + $a = $ans.',
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
        hint: 'Look at how much is added each time: 1, 8, 27... think cubes (1Â³, 2Â³, 3Â³).',
        solution: 'Differences are 1Â³, 2Â³, 3Â³. Next difference is 4Â³ (64): $t4 + 64 = $ans.',
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
        hint: 'The sequence follows the quadratic form nÂ² + $cÂ·n + ${7 + baseOffset}.',
        solution: 'For n = 5: 5Â² + ($c Ã— 5) + ${7 + baseOffset} = 25 + ${c * 5} + ${7 + baseOffset} = $ans.',
      );
    }
  }

  // --- Category 2: Missing Number Puzzles ---
  static LevelData _generateMissing(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k * 3 % 13) + 4; final b = (k * 2 % 11) + 7; final sum = a + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$a + [?] = $sum',
        correctAnswer: '$b',
        hint: 'Subtract $a from $sum.',
        solution: '$sum - $a = $b.',
      );
    } else if (tier <= 1) {
      final m = (k % 4) + 3; final add = (k * 2 % 9) + 4; final x = (k * 3 % 7) + 3; final total = m * x + add;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '([?] Ã— $m) + $add = $total',
        correctAnswer: '$x',
        hint: 'Subtract $add first, then divide by $m.',
        solution: '$total - $add = ${total - add}. Then ${total - add} Ã· $m = $x.',
      );
    } else if (tier <= 2) {
      final x = (k * 2 % 7) + 5; final y = (k % 4) + 2; final sum = x + y; final diff = x - y; final ans = x * y;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A + B = $sum\nA - B = $diff\nA Ã— B = ?',
        correctAnswer: '$ans',
        hint: 'Add equations to find 2A = ${sum + diff}. Then find B and calculate A Ã— B.',
        solution: '2A = ${sum + diff}\nA = $x\nB = $y\nA Ã— B = $x Ã— $y = $ans.',
      );
    } else if (tier <= 3) {
      final target = (k * 2 % 13) + 6; final r1 = (k % 5) + 3; final r2 = (k % 4) + 5; final c1 = (k % 3) + 2; final c2 = (k % 4) + 4;
      final rowSum = r1 + target + r2; final colSum = c1 + target + c2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Row: $r1 + ? + $r2 = $rowSum. Col: $c1 + ? + $c2 = $colSum. ? = ?',
        correctAnswer: '$target',
        hint: 'Solve either row or column equation for the missing common value.',
        solution: 'From row: ? = $rowSum - ($r1 + $r2) = $target. Verified in col: $c1 + $target + $c2 = $colSum.',
      );
    } else if (tier <= 4) {
      final target = (k * 2 % 9) + 4; final a = (k % 3) + 2; final b = (k % 3) + 3; final rowProd = a * target * b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$a Ã— [?] Ã— $b = $rowProd. [?] = ?',
        correctAnswer: '$target',
        hint: 'Divide $rowProd by the product of $a and $b (${a * b}).',
        solution: '$a Ã— $b = ${a * b}. $rowProd Ã· ${a * b} = $target.',
      );
    } else if (tier <= 5) {
      final x = (k * 2 % 7) + 3; final y = (k % 5) + 2; final eq1 = x + 2 * y; final eq2 = 2 * x + y; final ans = (x * x) + (y * y);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'x + 2y = $eq1, 2x + y = $eq2. xÂ² + yÂ² = ?',
        correctAnswer: '$ans',
        hint: 'Multiply the first equation by 2 and subtract the second to isolate y.',
        solution: 'Solving gives x = $x, y = $y. xÂ² + yÂ² = $xÂ² + $yÂ² = ${x * x} + ${y * y} = $ans.',
      );
    } else {
      final a = (k * 2 % 7) + 3; final b = (k % 4) + 2; final c = (k % 5) + 4; final sum = a + b + c; final p1 = a * b; final p2 = b * c; final ans = a * b * c;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A+B+C=$sum, AÃ—B=$p1, BÃ—C=$p2. AÃ—BÃ—C = ?',
        correctAnswer: '$ans',
        hint: 'Find B by factoring common elements of $p1 and $p2.',
        solution: 'Common factor B = $b gives A = $a and C = $c. A+B+C = $sum. AÃ—BÃ—C = $ans.',
      );
    }
  }

  // --- Category 3: Geometry: Triangles ---
  static LevelData _generateTriangle(int level, String category, String difficulty, int tier, int k) {
    final top = (k * 2 % 9) + 3; final left = (k % 7) + 2; final right = (k % 5) + 2;

    if (tier <= 0) {
      final ans = top + left + right;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle [Vertex-Sum]: Top $top, Left $left, Right $right â†’ Center [?]',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$top', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$left', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$right', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Add all three outer vertices together to find the center.',
        solution: '$top + $left + $right = $ans.',
      );
    } else if (tier <= 1) {
      final ans = (top + right) * left;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle [Sum-Mult]: Top $top, Left $left, Right $right â†’ Center [?]',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$top', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$left', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$right', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Add Top and Right vertices, then multiply by Left vertex.',
        solution: '($top + $right) Ã— $left = ${top + right} Ã— $left = $ans.',
      );
    } else if (tier <= 2) {
      final t = ((k % 5) + 2) * 2; final r = ((k % 4) + 1) * 2; const l = 2; final ans = ((t * t) + r) ~/ l;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle [Square-Div]: Top $t, Left $l, Right $r â†’ Center [?]',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Square the top vertex, add the right vertex, then divide by the left.',
        solution: '($tÂ² + $r) Ã· $l = (${t * t} + $r) Ã· $l = ${t * t + r} Ã· $l = $ans.',
      );
    } else if (tier <= 3) {
      final t = (k % 5) + 4; final l = (k % 4) + 3; final r = (k % 3) + 2; final ans = (t * t) + (l * l) - (r * r);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle [Pythagorean]: Top $t, Left $l, Right $r â†’ Center [?]',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Sum the squares of Top and Left, then subtract the square of Right.',
        solution: '$tÂ² + $lÂ² - $rÂ² = ${t * t} + ${l * l} - ${r * r} = $ans.',
      );
    } else if (tier <= 4) {
      final ans = (top * left) + (top * right) - (left * right);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle [Cross-Vertex]: Top $top, Left $left, Right $right â†’ Center [?]',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$top', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$left', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$right', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Formula: (Top Ã— Left) + (Top Ã— Right) - (Left Ã— Right).',
        solution: '($top Ã— $left) + ($top Ã— $right) - ($left Ã— $right) = ${top * left} + ${top * right} - ${left * right} = $ans.',
      );
    } else if (tier <= 5) {
      final t = (k % 4) + 3; final l = (k % 3) + 2; const r = 2; final ans = ((t * t * t) - (l * l)) ~/ r;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle [Cubic-Diff]: Top $t, Left $l, Right $r â†’ Center [?]',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Cube Top, subtract Left squared, then divide by Right.',
        solution: '($tÂ³ - $lÂ²) Ã· $r = (${t * t * t} - ${l * l}) Ã· $r = ${t * t * t - l * l} Ã· $r = $ans.',
      );
    } else {
      final t = (k % 5) + 5; final r = (k % 4) + 3; final targetLeft = (k % 5) + 4; final center = (t * targetLeft) + r;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle [Inverse-Left]: Top $t, Left [?], Right $r â†’ Center $center',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '?', isTarget: true, relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '$center', relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$targetLeft',
        hint: 'Rule is (Top Ã— Left) + Right = Center. Deduce Left vertex.',
        solution: '($t Ã— ?) + $r = $center\n$t Ã— ? = ${center - r}\n? = $targetLeft.',
      );
    }
  }

  // --- Category 4: Equation Riddles ---
  static LevelData _generateEquation(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k % 4) + 2; final b = (k * 2 % 7) + 3; final x = (k * 3 % 8) + 2; final c = a * x + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '${a}x + $b = $c\nx = ?',
        correctAnswer: '$x',
        hint: 'Subtract $b from $c, then divide by $a.',
        solution: '${a}x + $b = $c\n${a}x = ${c - b}\nx = $x.',
      );
    } else if (tier <= 1) {
      final apple = (k * 2 % 9) + 4; final banana = (k % 5) + 2; final s1 = apple + banana; final s2 = 2 * apple + banana;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A + B = $s1\n2A + B = $s2\nA = ?',
        correctAnswer: '$apple',
        hint: 'Subtract the first equation from the second to find A directly.',
        solution: '(2A + B) - (A + B) = A\nA = $s2 - $s1\nA = $apple.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 7) + 3; final b = (k % 5) + 4; final c = (k % 4) + 2; final ab = a + b; final bc = b + c; final ac = a + c; final total = a + b + c;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A + B = $ab\nB + C = $bc\nA + C = $ac\nA + B + C = ?',
        correctAnswer: '$total',
        hint: 'Sum all three equations: 2(A + B + C) = ${ab + bc + ac}. Then divide by 2.',
        solution: '2(A + B + C) = ${ab + bc + ac}\nA + B + C = ${ab + bc + ac} Ã· 2\nA + B + C = $total.',
      );
    } else if (tier <= 3) {
      final step = k - 10;
      final sumCoeff = (step % 3) + 2;
      final b = (step % 4) + 1;
      final r = b + sumCoeff;
      final c = r * sumCoeff;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'xÂ² - ${b}x = $c\nPositive x = ?',
        correctAnswer: '$r',
        hint: 'Factor as (x - $r)(x + $sumCoeff) = 0.',
        solution: 'xÂ² - ${b}x = $c\n($r)Â² - ($b Ã— $r) = $c\nx = $r.',
      );
    } else if (tier <= 4) {
      final x = (k * 2 % 7) + 3; final y = (k % 5) + 2; final eq1 = 2 * x + 3 * y; final eq2 = 3 * x + y; final ans = x * y;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '2x + 3y = $eq1\n3x + y = $eq2\nx Ã— y = ?',
        correctAnswer: '$ans',
        hint: 'From second equation y = $eq2 - 3x. Substitute into the first equation.',
        solution: 'x = $x\ny = $y\nx Ã— y = $x Ã— $y = $ans.',
      );
    } else if (tier <= 5) {
      final x = (k % 4) + 2; final y = (k * 2 % 5) + 3; final z = (k % 3) + 4; final s = x + y + z; final eq2 = 2 * x - y; final eq3 = 3 * z; final ans = (x * x) + (y * y);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'x + y + z = $s\n2x - y = $eq2\n3z = $eq3\nxÂ² + yÂ² = ?',
        correctAnswer: '$ans',
        hint: 'Find z from 3z = $eq3, then solve the remaining 2 variables.',
        solution: '3z = $eq3\nz = $z\nx + y = ${s - z}\nx = $x\ny = $y\nxÂ² + yÂ² = $ans.',
      );
    } else {
      final step = k - 28;
      final x = (step % 5) + 2; // 2..6 (strictly < 7)
      final y = (step % 4) + 1; // 1..4 (strictly < 5)
      const a = 5;
      const b = 7;
      final c = a * x + b * y;
      final ans = x + y;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '5x + 7y = $c\nPositive x, y\nx + y = ?',
        correctAnswer: '$ans',
        hint: 'Test multiples of 7 subtracted from $c that leave a multiple of 5.',
        solution: '5x + 7y = $c\nx = $x\ny = $y\nx + y = $x + $y = $ans.',
      );
    }
  }

  // --- Category 5: Mathematical Sequence Puzzles ---
  static LevelData _generateSequence(int level, String category, String difficulty, int tier, int k) {
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
        solution: '$t4 Ã— 2 = $ans.',
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
        hint: 'Sequence of consecutive squares: $baseÂ², ${base + 1}Â², ${base + 2}Â²...',
        solution: 'Next is ${base + 4}Â² = $ans.',
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
        hint: 'Generated by the cubic formula nÂ³ - nÂ² + 1.',
        solution: 'For next n = ${4 + shift}: ${4 + shift}Â³ - ${4 + shift}Â² + 1 = $ans.',
      );
    }
  }

  // --- Category 6: Matrix & Numeric Grid Riddles ---
  static LevelData _generateGrid(int level, String category, String difficulty, int tier, int k) {
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
        displayContent: '3Ã—3 Grid: Row Sum $s Matrix',
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
        displayContent: '3Ã—3 Grid: Product Matrix ($a Ã— $b)',
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
        hint: 'In each row, Column 1 Ã— Column 2 = Column 3.',
        solution: 'Row 3: $a Ã— $b = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 7) + 3; final b = (k % 5) + 4; final ans = (a + b) * 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3Ã—3 Grid: Sum & Double Matrix ($a, $b)',
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
        hint: 'In each row: (Col 1 + Col 2) Ã— 2 = Col 3.',
        solution: 'Row 3: ($a + $b) Ã— 2 = ${a + b} Ã— 2 = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k * 2 % 7) + 3; final b = (k % 5) + 2; final ans = (a * a) + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3Ã—3 Grid: Square & Addition Matrix ($a, $b)',
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
        hint: 'Square the first column and add the second column: Col 1Â² + Col 2 = Col 3.',
        solution: 'Row 3: $aÂ² + $b = ${a * a} + $b = $ans.',
      );
    } else if (tier <= 4) {
      final a = (k * 2 % 7) + 2; final b = (k % 5) + 3; final ans = a * b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3Ã—3 Grid: Column Multiply ($a Ã— $b)',
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
        hint: 'Look vertically: Row 1 Ã— Row 2 = Row 3 in each column.',
        solution: 'Column 3: $a Ã— $b = $ans.',
      );
    } else if (tier <= 5) {
      final a = (k * 2 % 7) + 2; final b = (k % 4) + 3; final targetC = (k % 3) + 2; final prod = a * b * targetC;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Grid,
        category: category,
        difficulty: difficulty,
        displayContent: '3Ã—3 Grid: Diagonal Product = $prod ($a Ã— $b Ã— [?])',
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
        hint: 'Multiply the main diagonal: $a Ã— $b Ã— ? = $prod. Find missing bottom-right element.',
        solution: '$a Ã— $b = ${a * b}. $prod Ã· ${a * b} = $targetC.',
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
        displayContent: '3Ã—3 Grid: Determinant Kernel ($a, $b, $c, $d)',
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
        hint: 'Target is the determinant of the 2Ã—2 upper-left kernel: (aÂ·d) - (bÂ·c).',
        solution: '($a Ã— $d) - ($b Ã— $c) = ${a * d} - ${b * c} = $ans.',
      );
    }
  }

  // --- Category 7: Money & Shopping Riddles ---
  static LevelData _generateMoney(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final unitPrice = (k * 2 % 7) + 3; final count = (k % 4) + 4; final cost = unitPrice * count; final targetCount = count + 2; final ans = unitPrice * targetCount;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$count pens cost \$$cost. Cost of $targetCount pens? [?]',
        correctAnswer: '$ans',
        hint: 'Find the cost of 1 pen first: \$$cost Ã· $count.',
        solution: '1 pen = \$$cost Ã· $count = \$$unitPrice. $targetCount pens = $targetCount Ã— \$$unitPrice = \$$ans.',
      );
    } else if (tier <= 1) {
      final basePrice = ((k * 3 % 7) + 4) * 20; const discountPercent = 25; final ans = basePrice * 75 ~/ 100;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A \$$basePrice jacket has $discountPercent% off discount. Final price? [?]',
        correctAnswer: '$ans',
        hint: '25% off means paying 75% of the original price.',
        solution: 'Discount = \$$basePrice Ã— 0.25 = \$${basePrice ~/ 4}. Price = \$$basePrice - \$${basePrice ~/ 4} = \$$ans.',
      );
    } else if (tier <= 2) {
      final coffee = (k * 2 % 7) + 3; final donut = (k % 4) + 2; final c1 = coffee + donut; final c2 = 2 * coffee + donut;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '1 coffee + 1 donut = \$$c1. 2 coffees + 1 donut = \$$c2. Coffee cost? [?]',
        correctAnswer: '$coffee',
        hint: 'The extra coffee accounts for the price difference.',
        solution: 'Coffee = \$$c2 - \$$c1 = \$$coffee.',
      );
    } else if (tier <= 3) {
      final dimes = (k * 2 % 7) + 5; final nickels = (k % 4) + 3; final totalCoins = dimes + nickels; final totalCents = (dimes * 10) + (nickels * 5);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$totalCoins coins (dimes & nickels) total $totalCentsÂ¢. Number of dimes? [?]',
        correctAnswer: '$dimes',
        hint: 'If all were nickels, they would make ${totalCoins * 5}Â¢. Extra cents come from dimes (+5Â¢ each).',
        solution: 'Extra = $totalCents - ${totalCoins * 5} = ${totalCents - totalCoins * 5}Â¢. Dimes = ${totalCents - totalCoins * 5} Ã· 5 = $dimes.',
      );
    } else if (tier <= 4) {
      final cost = ((k * 3 % 7) + 4) * 25; const profit = 20; final sellPrice = cost + (cost * profit ~/ 100);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Item sold for \$$sellPrice at $profit% profit. Original cost price? [?]',
        correctAnswer: '$cost',
        hint: 'Selling price is 120% of the cost price. Divide by 1.2.',
        solution: 'Cost = \$$sellPrice Ã· 1.20 = \$$cost.',
      );
    } else if (tier <= 5) {
      final original = ((k * 3 % 7) + 5) * 40; final after20 = original * 80 ~/ 100; final finalPrice = after20 * 90 ~/ 100;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '\$$original item has 20% discount, then extra 10% off. Final price? [?]',
        correctAnswer: '$finalPrice',
        hint: 'Successive discounts: multiply by 0.80, then by 0.90.',
        solution: '\$$original Ã— 0.80 = \$$after20. Then \$$after20 Ã— 0.90 = \$$finalPrice.',
      );
    } else {
      final step = k - 28;
      final items = 11 + step * 4;
      final unit = 10 + (step % 3) * 5;
      final free = items ~/ 4;
      final paid = items - free;
      final ans = paid * unit;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Buy 3 get 1 free at \$$unit each. Minimum cost for $items items? [?]',
        correctAnswer: '$ans',
        hint: 'Every 4 items gives 1 free ($free free items). Pay for only $paid items.',
        solution: '$items items = $free free + $paid paid. $paid Ã— \$$unit = \$$ans.',
      );
    }
  }

  // --- Category 8: Logic Number Riddles ---
  static LevelData _generateLogic(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final tens = (k % 4) + 2; final ones = ((k * 2 % 4) + 1) * 2; final num = tens * 10 + ones; final sum = tens + ones; final lower = tens * 10; final upper = lower + 10;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Even number between $lower and $upper whose digits sum to $sum? [?]',
        correctAnswer: '$num',
        hint: 'Tens digit is $tens. Ones digit must be even and add up to $sum.',
        solution: '$tens + $ones = $sum. The number is $num.',
      );
    } else if (tier <= 1) {
      final t = (k % 4) + 1; final o = 2 * t; final num = t * 10 + o; final sum = t + o;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A 2-digit number (digits sum to $sum) is 4 times its digit sum. Value? [?]',
        correctAnswer: '$num',
        hint: 'Multiply the digit sum $sum by 4.',
        solution: '4 Ã— $sum = $num (digits: $t + $o = $sum).',
      );
    } else if (tier <= 2) {
      final pools = [
        {'n': '3, 4, 6', 'a': '12'},
        {'n': '4, 5, 6', 'a': '60'},
        {'n': '3, 5, 6', 'a': '30'},
        {'n': '6, 8, 12', 'a': '24'},
        {'n': '4, 6, 8', 'a': '24'},
        {'n': '5, 6, 10', 'a': '30'},
      ];
      final item = pools[k % pools.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Smallest positive number divisible by ${item['n']}? [?]',
        correctAnswer: item['a']!,
        hint: 'Find the Least Common Multiple (LCM) of the numbers.',
        solution: 'LCM of ${item['n']} is ${item['a']}.',
      );
    } else if (tier <= 3) {
      final outer = (k % 5) + 2; final inner = (k * 2 % 7) + 1; final num = outer * 100 + inner * 10 + outer; final sum = outer + inner + outer; final prod = outer * inner * outer;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '3-digit palindrome whose digits sum to $sum and multiply to $prod? [?]',
        correctAnswer: '$num',
        hint: 'Outer digits are identical. Test factors of $prod.',
        solution: 'Digits are $outer, $inner, $outer: sum = $sum, product = $prod. Number is $num.',
      );
    } else if (tier <= 4) {
      final val = (k % 2 == 0) ? 25 : 76;
      final sq = val * val;
      final ans = val;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '2-digit number (seed #${k + 1}) whose square ($sq) ends in the number itself? [?]',
        correctAnswer: '$ans',
        hint: (ans == 25) ? 'Think of a multiple of 5.' : 'A 2-digit number ending in 6.',
        solution: '$ansÂ² = $sq, which ends in $ans.',
      );
    } else if (tier <= 5) {
      final offset = (k % 5);
      final c1 = 3 + offset;
      final c2 = 8;
      final c3 = 4;
      final ans = '$c1$c2$c3';
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Code clue (pattern #${k + 1}): ${c1}91 (one right placed), 2${c2}5 (one right placed), 7$c3$c2 (two right wrongly placed). Code? [?]',
        correctAnswer: ans,
        hint: 'Deduce position 1 ($c1), position 2 ($c2), position 3 ($c3).',
        solution: 'Digit 1 is $c1, Digit 2 is $c2, Digit 3 is $c3. Code is $ans.',
      );
    } else {
      final pairs = [
        {'q': 'Two-digit prime whose reverse is 4 times 19 - 5 (71)? [?]', 'a': '17'},
        {'q': 'Two-digit prime whose digits sum to 10 and reverse is 73? [?]', 'a': '37'},
        {'q': 'Two-digit prime whose reverse is 31? [?]', 'a': '13'},
        {'q': 'Two-digit prime whose reverse is 97? [?]', 'a': '79'},
        {'q': 'Two-digit prime whose reverse is 79? [?]', 'a': '97'},
      ];
      final item = pairs[k % pairs.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Clue #${k + 1}: ${item['q']!}',
        correctAnswer: item['a']!,
        hint: 'Reverse the target number to find the answer.',
        solution: 'The prime is ${item['a']}.',
      );
    }
  }

  // --- Category 9: Geometry: Intersecting Circles ---
  static LevelData _generateCircles(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = ((k * 2 % 9) + 3) * 2; final b = ((k % 7) + 7) * 2; final ans = (a + b) ~/ 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles [Average]: Left $a, Right $b â†’ Overlap [?]',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Center is the arithmetic average (mean) of the left and right circles.',
        solution: '($a + $b) Ã· 2 = ${a + b} Ã· 2 = $ans.',
      );
    } else if (tier <= 1) {
      final root = (k * 2 % 7) + 3; final a = root * 2; final b = root * 8; final ans = (root * 4);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles [Geo-Mean]: Left $a, Right $b â†’ Overlap [?]',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Multiply outer circles and find the square root: âˆš(Left Ã— Right).',
        solution: 'âˆš($a Ã— $b) = âˆš${a * b} = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 9) + 12; final b = (k % 5) + 4; final diff = a - b; final ans = diff * diff;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles [Diff-Sq]: Left $a, Right $b â†’ Overlap [?]',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Subtract the right value from the left value, then square the difference.',
        solution: '($a - $b)Â² = $diffÂ² = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k * 2 % 7) + 4; final b = (k % 5) + 3; final ans = (a * b) - (a + b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles [Prod-Sum]: Left $a, Right $b â†’ Overlap [?]',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Multiply left and right, then subtract their sum: (Left Ã— Right) - (Left + Right).',
        solution: '($a Ã— $b) - ($a + $b) = ${a * b} - ${a + b} = $ans.',
      );
    } else if (tier <= 4) {
      final pairs = [
        {'a': 30, 'b': 60, 'ans': 40},
        {'a': 20, 'b': 30, 'ans': 24},
        {'a': 12, 'b': 24, 'ans': 16},
        {'a': 15, 'b': 60, 'ans': 24},
        {'a': 10, 'b': 40, 'ans': 16},
        {'a': 40, 'b': 60, 'ans': 48},
        {'a': 18, 'b': 36, 'ans': 24},
      ];
      final p = pairs[k % pairs.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles [Harmonic]: Left ${p['a']}, Right ${p['b']} â†’ Overlap [?]',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '${p['a']}'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '${p['b']}'),
        ],
        correctAnswer: '${p['ans']}',
        hint: 'Center is the harmonic mean: (2 Ã— Left Ã— Right) Ã· (Left + Right).',
        solution: '(2 Ã— ${p['a']} Ã— ${p['b']}) Ã· (${p['a']} + ${p['b']}) = ${2 * p['a']! * p['b']!} Ã· ${p['a']! + p['b']!} = ${p['ans']}.',
      );
    } else if (tier <= 5) {
      final base = (k * 2 % 7) + 4; final a = base * 3; final b = base * 5; final ans = base;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles [GCD]: Left $a, Right $b â†’ Overlap [?]',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Center represents the Greatest Common Divisor (GCD) of both circles.',
        solution: 'GCD($a, $b) = $ans.',
      );
    } else {
      final a = (k * 2 % 7) + 5; final b = (k % 5) + 4; final ans = (a * a) + (b * b) + (a * b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles [Quad-Sym]: Left $a, Right $b â†’ Overlap [?]',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Center formula: LeftÂ² + RightÂ² + (Left Ã— Right).',
        solution: '$aÂ² + $bÂ² + ($a Ã— $b) = ${a * a} + ${b * b} + ${a * b} = $ans.',
      );
    }
  }

  // --- Category 10: Arithmetic Precedence & Lateral Operators ---
  static LevelData _generateOperator(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k * 2 % 9) + 3; final b = (k % 5) + 2; final ans = a + 2 * b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a â˜… b = a + 2b, then $a â˜… $b = ?',
        correctAnswer: '$ans',
        hint: 'Double the second number and add the first number.',
        solution: '$a + (2 Ã— $b) = $a + ${2 * b} = $ans.',
      );
    } else if (tier <= 1) {
      final a = (k * 2 % 7) + 3; final b = (k % 4) + 2; final ans = (a * b) + (a + b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a âŠ• b = (a Ã— b) + (a + b), then $a âŠ• $b = ?',
        correctAnswer: '$ans',
        hint: 'Multiply the numbers, add the numbers, then sum both results.',
        solution: '($a Ã— $b) + ($a + $b) = ${a * b} + ${a + b} = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 7) + 5; final b = (k % 4) + 2; final ans = (a * a) - (b * b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a # b = aÂ² - bÂ², then $a # $b = ?',
        correctAnswer: '$ans',
        hint: 'Calculate $aÂ² and subtract $bÂ².',
        solution: '$aÂ² - $bÂ² = ${a * a} - ${b * b} = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k % 3) + 2; final b = (k % 2) + 3; final c = (k % 3) + 2; final step1 = (a * b) + 1; final ans = (step1 * c) + 1;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If x â˜… y = xÂ·y + 1, then ($a â˜… $b) â˜… $c = ?',
        correctAnswer: '$ans',
        hint: 'Evaluate ($a â˜… $b) inside parentheses first, then apply â˜… with $c.',
        solution: '($a â˜… $b) = ($a Ã— $b) + 1 = $step1. Then $step1 â˜… $c = ($step1 Ã— $c) + 1 = $ans.',
      );
    } else if (tier <= 4) {
      final a = (k * 2 % 9) + 4; final b = (k % 5) + 3; const m = 10; final ans = ((a * b) % m) + (a + b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a âŠ— b = (aÂ·b mod 10) + (a+b), then $a âŠ— $b = ?',
        correctAnswer: '$ans',
        hint: 'aÂ·b mod 10 gives the last digit of the product. Add (a + b).',
        solution: '($a Ã— $b = ${a * b}) mod 10 = ${(a * b) % m}. Adding ($a + $b = ${a + b}) yields $ans.',
      );
    } else if (tier <= 5) {
      final step = k - 21;
      final a = step + 3;
      final targetX = (step * 2 % 5) + 4;
      final res = (a * targetX) + a;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a âŠ• b = aÂ·b + a\n$a âŠ• x = $res\nx = ?',
        correctAnswer: '$targetX',
        hint: 'Substitute into formula: $aÂ·x + $a = $res.',
        solution: '$aÂ·x + $a = $res\n$aÂ·x = ${res - a}\nx = $targetX.',
      );
    } else {
      final a = (k * 2 % 5) + 2; final b = (k % 4) + 3; final ans = (a * a + b) * (b * b - a);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a â¨€ b = (aÂ² + b) Ã— (bÂ² - a), then $a â¨€ $b = ?',
        correctAnswer: '$ans',
        hint: 'Compute left term (aÂ² + b) and right term (bÂ² - a), then multiply.',
        solution: '($aÂ² + $b = ${a * a + b}) Ã— ($bÂ² - $a = ${b * b - a}) = ${a * a + b} Ã— ${b * b - a} = $ans.',
      );
    }
  }

  // --- Category 11: Age Riddles ---
  static LevelData _generateAge(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final b = (k * 2 % 7) + 8; final diff = (k % 5) + 4; final a = b + diff; final sum = a + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Sam is $diff yrs older than Leo. Sum of ages is $sum. Sam\'s age? [?]',
        correctAnswer: '$a',
        hint: 'Subtract difference from sum, divide by 2 for Leo, then add $diff.',
        solution: 'Leo = ($sum - $diff) Ã· 2 = $b. Sam = $b + $diff = $a.',
      );
    } else if (tier <= 1) {
      final son = (k * 2 % 7) + 10; final father = 3 * son; final inYears = (k % 4) + 6; final fFuture = father + inYears;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Dad is 3Ã— Son\'s age. In $inYears yrs, Dad is $fFuture. Son\'s age now? [?]',
        correctAnswer: '$son',
        hint: 'Find Dad\'s current age first by subtracting $inYears from $fFuture.',
        solution: 'Dad now = $fFuture - $inYears = $father. Son now = $father Ã· 3 = $son.',
      );
    } else if (tier <= 2) {
      final d = (k % 5) + 6; final m = d + 24; final inYears = 24 - d;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Mom is $m and daughter is $d. In how many years will Mom be 2Ã— daughter? [?]',
        correctAnswer: '$inYears',
        hint: 'Set up equation: $m + x = 2($d + x).',
        solution: '$m + x = ${2 * d} + 2x\nx = $m - ${2 * d}\nx = $inYears.',
      );
    } else if (tier <= 3) {
      final c = (k % 4) + 4; final b = 2 * c; final a = 3 * b; final total = a + b + c;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A is 3Ã— B, B is 2Ã— C. Sum of ages is $total. Age of A? [?]',
        correctAnswer: '$a',
        hint: 'Express in terms of C: B = 2C, A = 6C. Total = 9C.',
        solution: '9C = $total\nC = $c\nA = 6 Ã— $c\nA = $a.',
      );
    } else if (tier <= 4) {
      final mult = (k * 2 % 7) + 7; final sum = 7 * mult; final myAge = 4 * mult;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'I am 2Ã— as old as you were when I was your age. Ages sum to $sum. My age? [?]',
        correctAnswer: '$myAge',
        hint: 'Ratio of my age to your age is 4 : 3.',
        solution: 'My age = 4/7 of $sum = $myAge.',
      );
    } else if (tier <= 5) {
      final diff = (k % 4) + 3; final b = (k * 2 % 7) + 5; final a = b + diff; final prod = a * b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Two brothers differ by $diff years. Product of ages is $prod. Older brother? [?]',
        correctAnswer: '$a',
        hint: 'Find two factors of $prod that differ by $diff.',
        solution: '$a Ã— $b = $prod and $a - $b = $diff. Older brother is $a.',
      );
    } else {
      final a = (k * 2 % 7) + 12; final b = (k % 5) + 8; final sumSquares = (a * a) + (b * b); final sum = a + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Ages sum to $sum. Sum of their squares is $sumSquares. Older age? [?]',
        correctAnswer: '$a',
        hint: 'Use 2AB = (A+B)Â² - (AÂ²+BÂ²) to find their product, then find ages.',
        solution: '2AB = $sumÂ² - $sumSquares\n2AB = ${sum * sum - sumSquares}\nAB = ${a * b}\nAges are $a and $b.',
      );
    }
  }

  // --- Category 12: Mathematical Trick Riddles ---
  static LevelData _generateTrick(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final val = (k * 2 % 11) + 12; final ans = val + val;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$val + $val Ã— 0 + $val = ?',
        correctAnswer: '$ans',
        hint: 'Multiplication first: $val Ã— 0 = 0.',
        solution: '$val + 0 + $val = $ans.',
      );
    } else if (tier <= 1) {
      final n = (k * 2 % 7) + 5; final ans = (n * (n - 1)) ~/ 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$n people each shake hands with everyone once. Total handshakes? [?]',
        correctAnswer: '$ans',
        hint: 'Handshake formula is n Ã— (n - 1) Ã· 2.',
        solution: '$n Ã— ${n - 1} Ã· 2 = ${n * (n - 1)} Ã· 2 = $ans.',
      );
    } else if (tier <= 2) {
      final depth = (k * 2 % 7) + 10; const up = 3; final ans = depth - up + 1;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Snail climbs 3m by day, slips 2m by night in a ${depth}m well. Days to escape? [?]',
        correctAnswer: '$ans',
        hint: 'On the final day, climbing 3m escapes before nightfall!',
        solution: 'After ${ans - 1} full days, reaches ${ans - 1}m. On day $ans, climbs 3m to $depth m and exits.',
      );
    } else if (tier <= 3) {
      final length = ((k * 2 % 7) + 4) * 5; const piece = 5; final cuts = (length ~/ piece) - 1;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Cuts needed to divide a ${length}m rope into 5m pieces? [?]',
        correctAnswer: '$cuts',
        hint: 'Number of cuts is always 1 less than the number of pieces.',
        solution: '$length Ã· 5 = ${length ~/ piece} pieces. Cuts = ${length ~/ piece} - 1 = $cuts.',
      );
    } else if (tier <= 4) {
      final pairs = [
        {'v1': 60, 'v2': 40, 'ans': 48},
        {'v1': 30, 'v2': 20, 'ans': 24},
        {'v1': 60, 'v2': 30, 'ans': 40},
        {'v1': 80, 'v2': 20, 'ans': 32},
        {'v1': 120, 'v2': 40, 'ans': 60},
      ];
      final p = pairs[k % pairs.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Drive to city at ${p['v1']} km/h, return at ${p['v2']} km/h (route #${k + 1}). Avg speed? [?]',
        correctAnswer: '${p['ans']}',
        hint: 'Average speed is harmonic: 2Â·v1Â·v2 Ã· (v1 + v2), NOT arithmetic average!',
        solution: '(2 Ã— ${p['v1']} Ã— ${p['v2']}) Ã· (${p['v1']} + ${p['v2']}) = ${2 * p['v1']! * p['v2']!} Ã· ${p['v1']! + p['v2']!} = ${p['ans']}.',
      );
    } else if (tier <= 5) {
      final clockAngles = [
        {'time': '3:30', 'ans': 75},
        {'time': '2:20', 'ans': 50},
        {'time': '4:40', 'ans': 100},
        {'time': '1:20', 'ans': 80},
        {'time': '5:10', 'ans': 95},
        {'time': '8:20', 'ans': 130},
      ];
      final c = clockAngles[k % clockAngles.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Clock #${k + 1}: Angle (in degrees) between hour and minute hand at ${c['time']}? [?]',
        correctAnswer: '${c['ans']}',
        hint: 'Formula: |30Ã—H - 5.5Ã—M| degrees.',
        solution: 'Angle between hands at ${c['time']} is ${c['ans']}Â°.',
      );
    } else {
      final coins = [9, 27, 81];
      final weighings = [2, 3, 4];
      final idx = k % coins.length;
      final coinCount = coins[idx];
      final ans = weighings[idx];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Minimum weighings on a balance scale to find 1 counterfeit among $coinCount coins (case #${k + 1})? [?]',
        correctAnswer: '$ans',
        hint: 'Each weighing divides candidates into 3 equal piles: 3^w >= N.',
        solution: '3^$ans = $coinCount, so exactly $ans weighings are sufficient.',
      );
    }
  }

  // --- Category 13: Number Mazes ---
  static LevelData _generateMaze(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final s = (k * 2 % 7) + 3; final a = (k % 5) + 4; const b = 2; final c = (k % 4) + 2; final ans = (s + a) * b - c;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Start: $s â†’ (+$a) â†’ (Ã—$b) â†’ (-$c) = [?]',
        correctAnswer: '$ans',
        hint: 'Follow the arrows step by step.',
        solution: '$s + $a = ${s + a}. ${s + a} Ã— $b = ${(s + a) * b}. ${(s + a) * b} - $c = $ans.',
      );
    } else if (tier <= 1) {
      final s = (k * 2 % 7) + 8; final ans = (((s + 4) * 2) - 6) ~/ 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Start: $s â†’ (+4) â†’ (Ã—2) â†’ (-6) â†’ (Ã·2) = [?]',
        correctAnswer: '$ans',
        hint: 'Perform each operation sequentially along the path.',
        solution: '$s + 4 = ${s + 4}\n${s + 4} Ã— 2 = ${(s + 4) * 2}\n${(s + 4) * 2} - 6 = ${(s + 4) * 2 - 6}\n${(s + 4) * 2 - 6} Ã· 2 = $ans.',
      );
    } else if (tier <= 2) {
      final s = (k * 2 % 7) + 5; final p1 = s * 2 + 3; final p2 = (s + 3) * 2; final ans = p1 + p2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Path A: $s â†’ (Ã—2) â†’ (+3). Path B: $s â†’ (+3) â†’ (Ã—2). Path A + B = [?]',
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
        displayContent: 'Start: [?] â†’ (Ã—2) â†’ (+6) = $endVal. [?] = ?',
        correctAnswer: '$start',
        hint: 'Work backwards from the exit: subtract 6, then divide by 2.',
        solution: '$endVal - 6 = ${endVal - 6}. ${endVal - 6} Ã· 2 = $start.',
      );
    } else if (tier <= 4) {
      final startVals = [12, 14, 20, 24, 28, 30]; final s = startVals[k % startVals.length];
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
        displayContent: 'Rule: Even â†’ Ã·2, Odd â†’ Ã—3+1. Start: $s (maze #${k + 1}) after 4 steps = [?]',
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
        displayContent: 'Nodes: A=$a, B=$b, C=$c (case #${k + 1}). Product of nodes minus Sum? [?]',
        correctAnswer: '$ans',
        hint: 'Calculate (A Ã— B Ã— C) - (A + B + C).',
        solution: '($a Ã— $b Ã— $c = ${a * b * c}) - ($a + $b + $c = ${a + b + c}) = $ans.',
      );
    } else {
      final s = (k * 2 % 9) + 15; final ans = ((s * 3) % 17) + 25;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Start: $s â†’ (Ã—3) â†’ (mod 17) â†’ (+25) = [?]',
        correctAnswer: '$ans',
        hint: 'Multiply $s by 3, find remainder when divided by 17, then add 25.',
        solution: '$s Ã— 3 = ${s * 3}. ${s * 3} mod 17 = ${(s * 3) % 17}. Remainder + 25 = $ans.',
      );
    }
  }
}
