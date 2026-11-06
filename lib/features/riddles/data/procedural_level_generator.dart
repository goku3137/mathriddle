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
        displayContent: 'BOSS: (Δ[7,8,4] × ⊞[Diag 12,15,18]) - F(10) = ?',
        correctAnswer: '575',
        hint: 'Solve Stage 1 (Triangle vertex: 7×8÷4), Stage 2 (Matrix diagonal sum), and subtract the 10th Fibonacci number.',
        solution: 'Stage 1 (Triangle): (7 × 8) ÷ 4 = 14. Stage 2 (Matrix): 12 + 15 + 18 = 45. Stage 3 (Fibonacci): F(10) = 55. Final Singularity: (14 × 45) - 55 = 630 - 55 = 575.',
      );
    }

    final catIndex = (level - 1) % 14;
    final category = (level <= 150 && catIndex == 1)
        ? 'Balance & Scale Riddles'
        : (level <= 150 && catIndex == 9)
            ? 'Proportion & Average Riddles'
            : categories[catIndex];
    final difficulty = getDifficulty(level);
    final tier = getTier(level);
    final k = (level - 1) ~/ 14;

    switch (catIndex) {
      case 0:
        return _generateFormula(level, category, difficulty, tier, k);
      case 1:
        if (level <= 150) {
          return _generateBalanceRiddle(level, category, difficulty, tier, k);
        }
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
        if (level <= 150) {
          return _generateAverageRiddle(level, category, difficulty, tier, k);
        }
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

  // --- Non-Geometry Replacement for catIndex 1 (Levels 1-150): Balance & Scale Riddles ---
  static LevelData _generateBalanceRiddle(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      // Levels 30, 44 (Tier 0)
      final boxes = (k % 2) + 3; // 3 or 4
      final unitWeight = (k * 3 % 4) + 6; // 6..9
      final extra = (k % 3) + 5; // 5..7
      final total = boxes * unitWeight + extra;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'On a balance scale, $boxes identical boxes plus a $extra kg weight balance a $total kg weight. What is the weight of one box in kg?',
        correctAnswer: '$unitWeight',
        hint: 'Subtract the extra $extra kg from $total kg, then divide by $boxes boxes.',
        solution: '$total - $extra = ${total - extra} kg. ${total - extra} ÷ $boxes = $unitWeight kg.',
      );
    } else if (tier <= 1) {
      // Levels 58, 72, 86, 100 (Tier 1)
      final leftBoxes = (k % 3) + 2; // 2..4
      final diffBoxes = (k % 3) + 3; // 3..5
      final rightBoxes = leftBoxes + diffBoxes;
      final unitWeight = (k % 4) + 5; // 5..8
      final weightAdded = diffBoxes * unitWeight;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'On a balance scale, $leftBoxes blocks and a $weightAdded kg weight balance $rightBoxes identical blocks. What is the weight of one block in kg?',
        correctAnswer: '$unitWeight',
        hint: 'Remove $leftBoxes blocks from both sides: $diffBoxes blocks balance $weightAdded kg.',
        solution: '$rightBoxes - $leftBoxes = $diffBoxes blocks. $weightAdded ÷ $diffBoxes = $unitWeight kg.',
      );
    } else {
      // Levels 114, 128, 142 (Tier 2)
      final leftSpheres = (k % 3) + 5; // 5..7
      const rightSpheres = 2;
      final diffSpheres = leftSpheres - rightSpheres; // 3..5
      final unitWeight = (k % 4) + 12; // 12..15
      final leftWeight = (k % 5) + 10; // 10..14
      final rightWeight = leftWeight + diffSpheres * unitWeight;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'On a balance scale, $leftSpheres spheres plus a $leftWeight kg weight balance $rightSpheres spheres plus a $rightWeight kg weight. What is the weight of one sphere in kg?',
        correctAnswer: '$unitWeight',
        hint: 'Subtract $rightSpheres spheres and $leftWeight kg from both sides to isolate the remaining spheres.',
        solution: '$leftSpheres - $rightSpheres = $diffSpheres spheres. $rightWeight - $leftWeight = ${rightWeight - leftWeight} kg. ${rightWeight - leftWeight} ÷ $diffSpheres = $unitWeight kg.',
      );
    }
  }

  // --- Non-Geometry Replacement for catIndex 9 (Levels 1-150): Proportion & Average Riddles ---
  static LevelData _generateAverageRiddle(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      // Levels 24, 38 (Tier 0)
      final avg = 15 + (k % 3) * 5; // 20 or 25
      final n1 = avg - (k % 4 + 3);
      final n2 = avg + (k % 3 + 2);
      final target = 3 * avg - (n1 + n2);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'The average of three numbers is $avg. If two of the numbers are $n1 and $n2, what is the third number?',
        correctAnswer: '$target',
        hint: 'The sum of all three numbers is 3 × $avg = ${3 * avg}. Subtract $n1 and $n2.',
        solution: 'Total sum = 3 × $avg = ${3 * avg}. Third number = ${3 * avg} - ($n1 + $n2) = $target.',
      );
    } else if (tier <= 1) {
      // Levels 52, 66, 80, 94 (Tier 1)
      if (k % 2 == 0) {
        // Average test score
        const targetAvg = 85;
        final t1 = 78 + (k % 3) * 2;
        final t2 = 82 + (k % 4) * 2;
        final t3 = 88 + (k % 3) * 2;
        final target = 4 * targetAvg - (t1 + t2 + t3);
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'A student scored $t1, $t2, and $t3 on three tests. What score is needed on the fourth test to average $targetAvg overall?',
          correctAnswer: '$target',
          hint: 'To average $targetAvg across 4 tests, total score needed is 4 × $targetAvg = ${4 * targetAvg}.',
          solution: 'Total needed = 4 × $targetAvg = ${4 * targetAvg}. Fourth test = ${4 * targetAvg} - ($t1 + $t2 + $t3) = $target.',
        );
      } else {
        // Ratio problem
        final ratioA = (k % 3) + 3; // 3, 4, 5
        final ratioB = ratioA + (k % 2) + 2; // ratioA + 2 or 3
        final mult = (k % 4) + 7; // 7..10
        final countA = ratioA * mult;
        final countB = ratioB * mult;
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The ratio of blue marbles to red marbles in a bag is $ratioA to $ratioB. If there are $countA blue marbles, how many red marbles are there?',
          correctAnswer: '$countB',
          hint: 'Find the value of 1 ratio part: $countA ÷ $ratioA.',
          solution: '1 part = $countA ÷ $ratioA = $mult. Red marbles = $ratioB × $mult = $countB.',
        );
      }
    } else {
      // Levels 108, 122, 136, 150 (Tier 2)
      if (k == 7) {
        // Consecutive integers average
        const avg = 30;
        const largest = 32;
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The average of 5 consecutive integers is $avg. What is the largest of these integers?',
          correctAnswer: '$largest',
          hint: 'In 5 consecutive integers, the middle integer equals their average ($avg).',
          solution: 'The 5 consecutive integers are 28, 29, 30, 31, 32. The largest is 32.',
        );
      } else if (k == 8) {
        // Consecutive even integers average
        const avg = 44;
        const largest = 48;
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The average of 5 consecutive even integers is $avg. What is the largest of these integers?',
          correctAnswer: '$largest',
          hint: 'The middle even integer is $avg. The integers are $avg - 4, $avg - 2, $avg, $avg + 2, $avg + 4.',
          solution: 'The integers are 40, 42, 44, 46, 48. The largest is 48.',
        );
      } else if (k == 9) {
        // Average with removed element
        const count = 6;
        const oldAvg = 18;
        const newAvg = 16;
        const removed = (count * oldAvg) - ((count - 1) * newAvg); // 108 - 80 = 28
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The average of $count numbers is $oldAvg. When one number is removed, the average of the remaining ${count - 1} numbers becomes $newAvg. What was the removed number?',
          correctAnswer: '$removed',
          hint: 'Subtract the new sum (${count - 1} × $newAvg) from the original sum ($count × $oldAvg).',
          solution: 'Original sum = $count × $oldAvg = ${count * oldAvg}. New sum = ${count - 1} × $newAvg = ${(count - 1) * newAvg}. Removed number = ${count * oldAvg} - ${(count - 1) * newAvg} = $removed.',
        );
      } else {
        // Level 150: Average with added element
        const count = 5;
        const oldAvg = 24;
        const added = 36;
        const newAvg = ((count * oldAvg) + added) ~/ (count + 1); // (120 + 36) / 6 = 26
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The average of $count numbers is $oldAvg. If a 6th number with value $added is added, what is the new average of all 6 numbers?',
          correctAnswer: '$newAvg',
          hint: 'Find the total sum of all 6 numbers, then divide by 6.',
          solution: 'Sum of 5 numbers = $count × $oldAvg = ${count * oldAvg}. Total with 6th number = ${count * oldAvg} + $added = ${(count * oldAvg) + added}. New average = ${(count * oldAvg) + added} ÷ 6 = $newAvg.',
        );
      }
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
        displayContent: '$a + $b × $c - $d = ?',
        correctAnswer: '$ans',
        hint: 'Perform multiplication ($b × $c) before addition and subtraction.',
        solution: '$b × $c = ${b * c}. Then $a + ${b * c} - $d = $ans.',
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
        displayContent: '($a + $b) × $c - $d = ?',
        correctAnswer: '$ans',
        hint: 'Parentheses first: ($a + $b), then multiply by $c, then subtract $d.',
        solution: '($a + $b) = ${a + b}. ${a + b} × $c = ${(a + b) * c}. Then ${(a + b) * c} - $d = $ans.',
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
        displayContent: '$a² + $b × ($c - $d) = ?',
        correctAnswer: '$ans',
        hint: 'Evaluate exponent $a² and parentheses ($c - $d) first, then multiply by $b.',
        solution: '$a² = ${a * a}, ($c - $d) = ${c - d}. $b × ${c - d} = ${b * (c - d)}. ${a * a} + ${b * (c - d)} = $ans.',
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
        displayContent: '$a³ - $b × $c + $d = ?',
        correctAnswer: '$ans',
        hint: 'Calculate cube $a³ first, then multiplication $b × $c.',
        solution: '$a³ = ${a * a * a}. $b × $c = ${b * c}. ${a * a * a} - ${b * c} + $d = $ans.',
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
        displayContent: '[($evenSumSq) ÷ $c] × $d - $e = ?',
        correctAnswer: '$ans',
        hint: 'Divide the bracket by $c first, then multiply by $d and subtract $e.',
        solution: '$evenSumSq ÷ $c = ${evenSumSq ~/ c}. Multiplied by $d = ${(evenSumSq ~/ c) * d}. Minus $e = $ans.',
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
        displayContent: '($a⁴ - $b⁴) ÷ ($a² + $b²) + $c² = ?',
        correctAnswer: '$ans',
        hint: 'Factor the numerator: a⁴ - b⁴ = (a² - b²)(a² + b²).',
        solution: '($a⁴ - $b⁴) ÷ ($a² + $b²) = $a² - $b² = ${a * a - b * b}. Adding $c² (${c * c}) gives $ans.',
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
        displayContent: '[($a³ - $b³) ÷ ($a - $b) - ($a × $b)] + ($c × $d) = ?',
        correctAnswer: '$ans',
        hint: 'Algebraic identity: (a³ - b³) ÷ (a - b) = a² + ab + b². Subtracting ab leaves a² + b².',
        solution: '(a³ - b³) ÷ (a - b) - ab = a² + b² = ${a * a + b * b}. Adding $c × $d (${c * d}) yields $ans.',
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

  // --- Category 2: Missing Number Puzzles ---
  static LevelData _generateMissing(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k * 3 % 13) + 4; final b = (k * 2 % 11) + 7; final sum = a + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$a + ? = $sum',
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
        displayContent: '(? × $m) + $add = $total',
        correctAnswer: '$x',
        hint: 'Subtract $add first, then divide by $m.',
        solution: '$total - $add = ${total - add}. Then ${total - add} ÷ $m = $x.',
      );
    } else if (tier <= 2) {
      final x = (k * 2 % 7) + 5; final y = (k % 4) + 2; final sum = x + y; final diff = x - y; final ans = x * y;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A + B = $sum\nA - B = $diff\nA × B = ?',
        correctAnswer: '$ans',
        hint: 'Add equations to find 2A = ${sum + diff}. Then find B and calculate A × B.',
        solution: '2A = ${sum + diff}\nA = $x\nB = $y\nA × B = $x × $y = $ans.',
      );
    } else if (tier <= 3) {
      final target = (k * 2 % 13) + 6; final r1 = (k % 5) + 3; final r2 = (k % 4) + 5; final c1 = (k % 3) + 2; final c2 = (k % 4) + 4;
      final rowSum = r1 + target + r2; final colSum = c1 + target + c2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Row: $r1 + ? + $r2 = $rowSum\nColumn: $c1 + ? + $c2 = $colSum\n? = ?',
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
        displayContent: '$a × ? × $b = $rowProd\n? = ?',
        correctAnswer: '$target',
        hint: 'Divide $rowProd by the product of $a and $b (${a * b}).',
        solution: '$a × $b = ${a * b}. $rowProd ÷ ${a * b} = $target.',
      );
    } else if (tier <= 5) {
      final x = (k * 2 % 7) + 3; final y = (k % 5) + 2; final eq1 = x + 2 * y; final eq2 = 2 * x + y; final ans = (x * x) + (y * y);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'x + 2y = $eq1, 2x + y = $eq2. x² + y² = ?',
        correctAnswer: '$ans',
        hint: 'Multiply the first equation by 2 and subtract the second to isolate y.',
        solution: 'Solving gives x = $x, y = $y. x² + y² = $x² + $y² = ${x * x} + ${y * y} = $ans.',
      );
    } else {
      final a = (k * 2 % 7) + 3; final b = (k % 4) + 2; final c = (k % 5) + 4; final sum = a + b + c; final p1 = a * b; final p2 = b * c; final ans = a * b * c;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A + B + C = $sum, A × B = $p1, B × C = $p2. A × B × C = ?',
        correctAnswer: '$ans',
        hint: 'Find B by factoring common elements of $p1 and $p2.',
        solution: 'Common factor B = $b gives A = $a and C = $c. A+B+C = $sum. A×B×C = $ans.',
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
        displayContent: 'Triangle: Top $top, Left $left, Right $right → Center = ?',
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
        displayContent: 'Triangle: Top $top, Left $left, Right $right → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$top', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$left', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$right', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Add Top and Right vertices, then multiply by Left vertex.',
        solution: '($top + $right) × $left = ${top + right} × $left = $ans.',
      );
    } else if (tier <= 2) {
      final t = ((k % 5) + 2) * 2; final r = ((k % 4) + 1) * 2; const l = 2; final ans = ((t * t) + r) ~/ l;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left $l, Right $r → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Square the top vertex, add the right vertex, then divide by the left.',
        solution: '($t² + $r) ÷ $l = (${t * t} + $r) ÷ $l = ${t * t + r} ÷ $l = $ans.',
      );
    } else if (tier <= 3) {
      final t = (k % 5) + 4; final l = (k % 4) + 3; final r = (k % 3) + 2; final ans = (t * t) + (l * l) - (r * r);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left $l, Right $r → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Sum the squares of Top and Left, then subtract the square of Right.',
        solution: '$t² + $l² - $r² = ${t * t} + ${l * l} - ${r * r} = $ans.',
      );
    } else if (tier <= 4) {
      final t = k - 11;
      final l = (k % 4) + 3;
      final r = (k % 3) + 2;
      final ans = (t * l) + (t * r) - (l * r);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left $l, Right $r → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Formula: (Top × Left) + (Top × Right) - (Left × Right).',
        solution: '($t × $l) + ($t × $r) - ($l × $r) = ${t * l} + ${t * r} - ${l * r} = $ans.',
      );
    } else if (tier <= 5) {
      final t = (k % 4) + 3; final l = (k % 3) + 2; const r = 2; final ans = ((t * t * t) - (l * l)) ~/ r;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left $l, Right $r → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Cube Top, subtract Left squared, then divide by Right.',
        solution: '($t³ - $l²) ÷ $r = (${t * t * t} - ${l * l}) ÷ $r = ${t * t * t - l * l} ÷ $r = $ans.',
      );
    } else {
      final t = (k % 5) + 5; final r = (k % 4) + 3; final targetLeft = (k % 5) + 4; final center = (t * targetLeft) + r;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left ?, Right $r → Center $center',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '?', isTarget: true, relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '$center', relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$targetLeft',
        hint: 'Rule is (Top × Left) + Right = Center. Deduce Left vertex.',
        solution: '($t × ?) + $r = $center\n$t × ? = ${center - r}\n? = $targetLeft.',
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
        solution: '2(A + B + C) = ${ab + bc + ac}\nA + B + C = ${ab + bc + ac} ÷ 2\nA + B + C = $total.',
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
        displayContent: 'x² - ${b}x = $c\nPositive x = ?',
        correctAnswer: '$r',
        hint: 'Factor as (x - $r)(x + $sumCoeff) = 0.',
        solution: 'x² - ${b}x = $c\n($r)² - ($b × $r) = $c\nx = $r.',
      );
    } else if (tier <= 4) {
      final x = (k * 2 % 7) + 3; final y = (k % 5) + 2; final eq1 = 2 * x + 3 * y; final eq2 = 3 * x + y; final ans = x * y;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '2x + 3y = $eq1\n3x + y = $eq2\nx × y = ?',
        correctAnswer: '$ans',
        hint: 'From second equation y = $eq2 - 3x. Substitute into the first equation.',
        solution: 'x = $x\ny = $y\nx × y = $x × $y = $ans.',
      );
    } else if (tier <= 5) {
      final x = (k % 4) + 2; final y = (k * 2 % 5) + 3; final z = (k % 3) + 4; final s = x + y + z; final eq2 = 2 * x - y; final eq3 = 3 * z; final ans = (x * x) + (y * y);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'x + y + z = $s\n2x - y = $eq2\n3z = $eq3\nx² + y² = ?',
        correctAnswer: '$ans',
        hint: 'Find z from 3z = $eq3, then solve the remaining 2 variables.',
        solution: '3z = $eq3\nz = $z\nx + y = ${s - z}\nx = $x\ny = $y\nx² + y² = $ans.',
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

  // --- Category 7: Money & Shopping Riddles ---
  static LevelData _generateMoney(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final unitPrice = (k * 2 % 7) + 3; final count = (k % 4) + 4; final cost = unitPrice * count; final targetCount = count + 2; final ans = unitPrice * targetCount;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If $count pens cost \$$cost, what is the cost of $targetCount pens in dollars?',
        correctAnswer: '$ans',
        hint: 'Find the cost of 1 pen first: \$$cost ÷ $count.',
        solution: '1 pen = \$$cost ÷ $count = \$$unitPrice. $targetCount pens = $targetCount × \$$unitPrice = \$$ans.',
      );
    } else if (tier <= 1) {
      final basePrice = ((k * 3 % 7) + 4) * 20; const discountPercent = 25; final ans = basePrice * 75 ~/ 100;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A jacket originally priced at \$$basePrice is on sale for $discountPercent% off. What is the final price in dollars?',
        correctAnswer: '$ans',
        hint: '25% off means paying 75% of the original price.',
        solution: 'Discount = \$$basePrice × 0.25 = \$${basePrice ~/ 4}. Price = \$$basePrice - \$${basePrice ~/ 4} = \$$ans.',
      );
    } else if (tier <= 2) {
      final coffee = (k * 2 % 7) + 3; final donut = (k % 4) + 2; final c1 = coffee + donut; final c2 = 2 * coffee + donut;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'One coffee and one donut cost \$$c1. Two coffees and one donut cost \$$c2. What is the cost of one coffee in dollars?',
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
        displayContent: 'A collection of $totalCoins coins (dimes and nickels) totals $totalCents¢. How many dimes are there?',
        correctAnswer: '$dimes',
        hint: 'If all were nickels, they would make ${totalCoins * 5}¢. Extra cents come from dimes (+5¢ each).',
        solution: 'Extra = $totalCents - ${totalCoins * 5} = ${totalCents - totalCoins * 5}¢. Dimes = ${totalCents - totalCoins * 5} ÷ 5 = $dimes.',
      );
    } else if (tier <= 4) {
      final cost = ((k * 3 % 7) + 4) * 25; const profit = 20; final sellPrice = cost + (cost * profit ~/ 100);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'An item was sold for \$$sellPrice at a profit of $profit%. What was the original cost price in dollars?',
        correctAnswer: '$cost',
        hint: 'Selling price is 120% of the cost price. Divide by 1.2.',
        solution: 'Cost = \$$sellPrice ÷ 1.20 = \$$cost.',
      );
    } else if (tier <= 5) {
      final original = ((k * 3 % 7) + 5) * 40; final after20 = original * 80 ~/ 100; final finalPrice = after20 * 90 ~/ 100;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'An item priced at \$$original has a 20% discount, followed by an additional 10% off. What is the final price in dollars?',
        correctAnswer: '$finalPrice',
        hint: 'Successive discounts: multiply by 0.80, then by 0.90.',
        solution: '\$$original × 0.80 = \$$after20. Then \$$after20 × 0.90 = \$$finalPrice.',
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
        displayContent: 'A store offers "Buy 3 get 1 free" at \$$unit each. What is the minimum cost for $items items in dollars?',
        correctAnswer: '$ans',
        hint: 'Every 4 items gives 1 free ($free free items). Pay for only $paid items.',
        solution: '$items items = $free free + $paid paid. $paid × \$$unit = \$$ans.',
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
        displayContent: 'What is the even number between $lower and $upper whose digits sum to $sum?',
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
        displayContent: 'A 2-digit number (digits sum to $sum) is 4 times its digit sum. What is the number?',
        correctAnswer: '$num',
        hint: 'Multiply the digit sum $sum by 4.',
        solution: '4 × $sum = $num (digits: $t + $o = $sum).',
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
        displayContent: 'What is the smallest positive number divisible by each of ${item['n']}?',
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
        displayContent: 'What is the 3-digit palindrome whose digits sum to $sum and multiply to $prod?',
        correctAnswer: '$num',
        hint: 'Outer digits are identical. Test factors of $prod.',
        solution: 'Digits are $outer, $inner, $outer: sum = $sum, product = $prod. Number is $num.',
      );
    } else if (tier <= 4) {
      final subIndex = k - 14;
      switch (subIndex) {
        case 0:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What 2-digit number has a square (625) that ends in the number itself?',
            correctAnswer: '25',
            hint: 'Think of a 2-digit multiple of 5.',
            solution: '25² = 625, which ends in 25.',
          );
        case 1:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What 2-digit number has a square (5776) that ends in the number itself?',
            correctAnswer: '76',
            hint: 'A 2-digit number ending in 6.',
            solution: '76² = 5776, which ends in 76.',
          );
        case 2:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What 3-digit number has a square (141376) that ends in the 3-digit number itself?',
            correctAnswer: '376',
            hint: 'Think of a 3-digit number ending in 76.',
            solution: '376² = 141376, which ends in 376.',
          );
        case 3:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What 3-digit number has a square (390625) that ends in the 3-digit number itself?',
            correctAnswer: '625',
            hint: 'Think of a 3-digit power of 5 ending in 25.',
            solution: '625² = 390625, which ends in 625.',
          );
        case 4:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'I am a 2-digit multiple of 9 less than 30. When squared, my digits sum to 9. What number am I?',
            correctAnswer: '18',
            hint: 'The multiples of 9 less than 30 are 18 and 27. Check 18².',
            solution: '18² = 324. Digit sum of 324 is 3 + 2 + 4 = 9. The number is 18.',
          );
        case 5:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'I am a 2-digit number. When squared, my value is 729. What number am I?',
            correctAnswer: '27',
            hint: 'Take the square root of 729.',
            solution: '√729 = 27. The number is 27.',
          );
        default:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'I am the only 2-digit positive integer that is both a perfect square and a perfect cube. What number am I?',
            correctAnswer: '64',
            hint: '64 = 8² and 64 = 4³.',
            solution: '8² = 64 and 4³ = 64. The number is 64.',
          );
      }
    } else if (tier <= 5) {
      final offset = (k - 21).clamp(0, 6);
      final c1 = 3 + offset;
      final c2 = 8;
      final c3 = 4;
      final ans = '$c1$c2$c3';
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Crack the 3-digit lock: ${c1}91 (one digit correct & placed), 2${c2}5 (one digit correct & placed), 7$c3$c2 (two digits correct but misplaced). What is the code?',
        correctAnswer: ans,
        hint: 'Deduce position 1 ($c1), position 2 ($c2), position 3 ($c3).',
        solution: 'Digit 1 is $c1, Digit 2 is $c2, Digit 3 is $c3. Code is $ans.',
      );
    } else {
      final pairs = [
        {'q': 'What 2-digit prime reversed is 97?', 'a': '79'},
        {'q': 'What 2-digit prime reversed is 79?', 'a': '97'},
        {'q': 'What 2-digit prime reversed is equal to 4 × 19 - 5 (71)?', 'a': '17'},
        {'q': 'What 2-digit prime has digits summing to 10 and reverses to 73?', 'a': '37'},
        {'q': 'What 2-digit prime reversed is 31?', 'a': '13'},
        {'q': 'What 2-digit prime reversed is 13?', 'a': '31'},
        {'q': 'What 2-digit prime has digits summing to 10 and reverses to 37?', 'a': '73'},
        {'q': 'What 2-digit prime reversed is 17?', 'a': '71'},
      ];
      final item = pairs[(k - 28) % pairs.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: item['q']!,
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
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Center is the arithmetic average (mean) of the left and right circles.',
        solution: '($a + $b) ÷ 2 = ${a + b} ÷ 2 = $ans.',
      );
    } else if (tier <= 1) {
      final root = (k * 2 % 7) + 3; final a = root * 2; final b = root * 8; final ans = (root * 4);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Multiply outer circles and find the square root: √(Left × Right).',
        solution: '√($a × $b) = √${a * b} = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 9) + 12; final b = (k % 5) + 4; final diff = a - b; final ans = diff * diff;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Subtract the right value from the left value, then square the difference.',
        solution: '($a - $b)² = $diff² = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k * 2 % 7) + 4; final b = (k % 5) + 3; final ans = (a * b) - (a + b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Multiply left and right, then subtract their sum: (Left × Right) - (Left + Right).',
        solution: '($a × $b) - ($a + $b) = ${a * b} - ${a + b} = $ans.',
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
        displayContent: 'Circles: Left ${p['a']}, Right ${p['b']} → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '${p['a']}'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '${p['b']}'),
        ],
        correctAnswer: '${p['ans']}',
        hint: 'Center is the harmonic mean: (2 × Left × Right) ÷ (Left + Right).',
        solution: '(2 × ${p['a']} × ${p['b']}) ÷ (${p['a']} + ${p['b']}) = ${2 * p['a']! * p['b']!} ÷ ${p['a']! + p['b']!} = ${p['ans']}.',
      );
    } else if (tier <= 5) {
      final base = (k * 2 % 7) + 4; final a = base * 3; final b = base * 5; final ans = base;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
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
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Center formula: Left² + Right² + (Left × Right).',
        solution: '$a² + $b² + ($a × $b) = ${a * a} + ${b * b} + ${a * b} = $ans.',
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
        displayContent: 'If a ★ b = a + 2b, then $a ★ $b = ?',
        correctAnswer: '$ans',
        hint: 'Double the second number and add the first number.',
        solution: '$a + (2 × $b) = $a + ${2 * b} = $ans.',
      );
    } else if (tier <= 1) {
      final a = (k * 2 % 7) + 3; final b = (k % 4) + 2; final ans = (a * b) + (a + b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a ⊕ b = (a × b) + (a + b), then $a ⊕ $b = ?',
        correctAnswer: '$ans',
        hint: 'Multiply the numbers, add the numbers, then sum both results.',
        solution: '($a × $b) + ($a + $b) = ${a * b} + ${a + b} = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 7) + 5; final b = (k % 4) + 2; final ans = (a * a) - (b * b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a # b = a² - b², then $a # $b = ?',
        correctAnswer: '$ans',
        hint: 'Calculate $a² and subtract $b².',
        solution: '$a² - $b² = ${a * a} - ${b * b} = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k % 3) + 2; final b = (k % 2) + 3; final c = (k % 3) + 2; final step1 = (a * b) + 1; final ans = (step1 * c) + 1;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If x ★ y = x·y + 1, then ($a ★ $b) ★ $c = ?',
        correctAnswer: '$ans',
        hint: 'Evaluate ($a ★ $b) inside parentheses first, then apply ★ with $c.',
        solution: '($a ★ $b) = ($a × $b) + 1 = $step1. Then $step1 ★ $c = ($step1 × $c) + 1 = $ans.',
      );
    } else if (tier <= 4) {
      final a = (k * 2 % 9) + 4; final b = (k % 5) + 3; const m = 10; final ans = ((a * b) % m) + (a + b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a ⊗ b = (a·b mod 10) + (a+b), then $a ⊗ $b = ?',
        correctAnswer: '$ans',
        hint: 'a·b mod 10 gives the last digit of the product. Add (a + b).',
        solution: '($a × $b = ${a * b}) mod 10 = ${(a * b) % m}. Adding ($a + $b = ${a + b}) yields $ans.',
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
        displayContent: 'If a ⊕ b = a·b + a\n$a ⊕ x = $res\nx = ?',
        correctAnswer: '$targetX',
        hint: 'Substitute into formula: $a·x + $a = $res.',
        solution: '$a·x + $a = $res\n$a·x = ${res - a}\nx = $targetX.',
      );
    } else {
      final a = (k * 2 % 5) + 2; final b = (k % 4) + 3; final ans = (a * a + b) * (b * b - a);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a ⨀ b = (a² + b) × (b² - a), then $a ⨀ $b = ?',
        correctAnswer: '$ans',
        hint: 'Compute left term (a² + b) and right term (b² - a), then multiply.',
        solution: '($a² + $b = ${a * a + b}) × ($b² - $a = ${b * b - a}) = ${a * a + b} × ${b * b - a} = $ans.',
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
        displayContent: 'Sam is $diff years older than Leo. The sum of their ages is $sum. How old is Sam?',
        correctAnswer: '$a',
        hint: 'Subtract difference from sum, divide by 2 for Leo, then add $diff.',
        solution: 'Leo = ($sum - $diff) ÷ 2 = $b. Sam = $b + $diff = $a.',
      );
    } else if (tier <= 1) {
      final son = (k * 2 % 7) + 10; final father = 3 * son; final inYears = (k % 4) + 6; final fFuture = father + inYears;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A father is 3 times as old as his son. In $inYears years, the father will be $fFuture years old. How old is the son now?',
        correctAnswer: '$son',
        hint: 'Find Dad\'s current age first by subtracting $inYears from $fFuture.',
        solution: 'Dad now = $fFuture - $inYears = $father. Son now = $father ÷ 3 = $son.',
      );
    } else if (tier <= 2) {
      final d = (k % 5) + 6; final m = d + 24; final inYears = 24 - d;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A mother is $m years old and her daughter is $d years old. In how many years will the mother be twice as old as her daughter?',
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
        displayContent: 'Person A is 3 times as old as B, and B is twice as old as C. If their ages sum to $total, how old is A?',
        correctAnswer: '$a',
        hint: 'Express in terms of C: B = 2C, A = 6C. Total = 9C.',
        solution: '9C = $total\nC = $c\nA = 6 × $c\nA = $a.',
      );
    } else if (tier <= 4) {
      final mult = (k * 2 % 7) + 7; final sum = 7 * mult; final myAge = 4 * mult;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'I am twice as old as you were when I was your age. Our ages sum to $sum. How old am I?',
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
        displayContent: 'Two brothers differ in age by $diff years, and the product of their ages is $prod. How old is the older brother?',
        correctAnswer: '$a',
        hint: 'Find two factors of $prod that differ by $diff.',
        solution: '$a × $b = $prod and $a - $b = $diff. Older brother is $a.',
      );
    } else {
      final a = (k * 2 % 7) + 12; final b = (k % 5) + 8; final sumSquares = (a * a) + (b * b); final sum = a + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Two ages sum to $sum, and the sum of their squares is $sumSquares. What is the older age?',
        correctAnswer: '$a',
        hint: 'Use 2AB = (A+B)² - (A²+B²) to find their product, then find ages.',
        solution: '2AB = $sum² - $sumSquares\n2AB = ${sum * sum - sumSquares}\nAB = ${a * b}\nAges are $a and $b.',
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
        displayContent: '$val + $val × 0 + $val = ?',
        correctAnswer: '$ans',
        hint: 'Multiplication first: $val × 0 = 0.',
        solution: '$val + 0 + $val = $ans.',
      );
    } else if (tier <= 1) {
      final n = (k * 2 % 7) + 5; final ans = (n * (n - 1)) ~/ 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$n people each shake hands with every other person exactly once. How many total handshakes occur?',
        correctAnswer: '$ans',
        hint: 'Handshake formula is n × (n - 1) ÷ 2.',
        solution: '$n × ${n - 1} ÷ 2 = ${n * (n - 1)} ÷ 2 = $ans.',
      );
    } else if (tier <= 2) {
      final depth = (k * 2 % 7) + 10; const up = 3; final ans = depth - up + 1;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A snail climbs 3m by day and slips back 2m by night in a ${depth}m well. How many days will it take to reach the top?',
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
        displayContent: 'How many straight cuts are needed to divide a ${length}m rope into 5m pieces?',
        correctAnswer: '$cuts',
        hint: 'Number of cuts is always 1 less than the number of pieces.',
        solution: '$length ÷ 5 = ${length ~/ piece} pieces. Cuts = ${length ~/ piece} - 1 = $cuts.',
      );
    } else if (tier <= 4) {
      final pairs = [
        {'v1': 60, 'v2': 40, 'ans': 48},
        {'v1': 30, 'v2': 20, 'ans': 24},
        {'v1': 60, 'v2': 30, 'ans': 40},
        {'v1': 80, 'v2': 20, 'ans': 32},
        {'v1': 120, 'v2': 40, 'ans': 60},
        {'v1': 90, 'v2': 60, 'ans': 72},
        {'v1': 120, 'v2': 60, 'ans': 80},
      ];
      final p = pairs[(k - 14) % pairs.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A car travels to a city at ${p['v1']} km/h and returns along the same route at ${p['v2']} km/h. What is the average speed for the round trip in km/h?',
        correctAnswer: '${p['ans']}',
        hint: 'Average speed is harmonic: 2·v1·v2 ÷ (v1 + v2), NOT arithmetic average!',
        solution: '(2 × ${p['v1']} × ${p['v2']}) ÷ (${p['v1']} + ${p['v2']}) = ${2 * p['v1']! * p['v2']!} ÷ ${p['v1']! + p['v2']!} = ${p['ans']}.',
      );
    } else if (tier <= 5) {
      final clockAngles = [
        {'time': '3:30', 'ans': 75},
        {'time': '2:20', 'ans': 50},
        {'time': '4:40', 'ans': 100},
        {'time': '1:20', 'ans': 80},
        {'time': '5:10', 'ans': 95},
        {'time': '8:20', 'ans': 130},
        {'time': '7:10', 'ans': 155},
      ];
      final c = clockAngles[(k - 21) % clockAngles.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'What is the smaller angle (in degrees) between the hour hand and minute hand of a clock at ${c['time']}?',
        correctAnswer: '${c['ans']}',
        hint: 'Formula: |30×H - 5.5×M| degrees.',
        solution: 'Angle between hands at ${c['time']} is ${c['ans']}°.',
      );
    } else {
      final subIndex = k - 28;
      switch (subIndex) {
        case 0:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What is the minimum number of balance scale weighings needed to find 1 counterfeit coin among 9 coins?',
            correctAnswer: '2',
            hint: 'Divide the coins into 3 piles of 3. 3² = 9.',
            solution: 'Each weighing divides candidates by 3: 3² = 9, so 2 weighings are needed.',
          );
        case 1:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What is the minimum number of balance scale weighings needed to find 1 counterfeit coin among 27 coins?',
            correctAnswer: '3',
            hint: 'Divide into 3 piles of 9. 3³ = 27.',
            solution: 'Each weighing divides candidates by 3: 3³ = 27, so 3 weighings are needed.',
          );
        case 2:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What is the minimum number of balance scale weighings needed to find 1 counterfeit coin among 81 coins?',
            correctAnswer: '4',
            hint: 'Divide into 3 piles of 27. 3⁴ = 81.',
            solution: 'Each weighing divides candidates by 3: 3⁴ = 81, so 4 weighings are needed.',
          );
        case 3:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What is the minimum number of balance scale weighings needed to find 1 counterfeit coin among 243 coins?',
            correctAnswer: '5',
            hint: 'Divide into 3 piles of 81. 3⁵ = 243.',
            solution: 'Each weighing divides candidates by 3: 3⁵ = 243, so 5 weighings are needed.',
          );
        case 4:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'A water lily patch doubles in size every day. If it completely covers a pond on Day 48, on which day did it cover half the pond?',
            correctAnswer: '47',
            hint: 'Since it doubles every day, one day before full coverage it must be half full.',
            solution: 'Working backwards from Day 48, one day earlier (Day 47) it was half of the pond.',
          );
        case 5:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'A bat and a ball cost \$110 in total. The bat costs \$100 more than the ball. What is the cost of the ball in dollars?',
            correctAnswer: '5',
            hint: 'Let the ball cost \$x. Then the bat costs \$(x + 100). Sum = 2x + 100 = 110.',
            solution: '2x + 100 = 110\n2x = 10\nx = 5. The ball costs \$5.',
          );
        default:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'If 5 cats can catch 5 mice in 5 minutes, how many minutes does it take 100 cats to catch 100 mice?',
            correctAnswer: '5',
            hint: 'Each cat takes 5 minutes to catch 1 mouse. With 100 cats working at once, 100 mice are caught in that same time.',
            solution: 'Rate per cat = 1 mouse per 5 minutes. 100 cats catch 100 mice simultaneously in 5 minutes.',
          );
      }
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
