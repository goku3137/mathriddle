import 'dart:collection';
import '../data/game_levels.dart';
import '../models/level_model.dart';

/// Lightweight summary metadata for level select grids and progress displays.
class LevelHeader {
  final int levelNumber;
  final QuestionType questionType;
  final String category;
  final String difficulty;
  final String title;

  const LevelHeader({
    required this.levelNumber,
    required this.questionType,
    required this.category,
    required this.difficulty,
    required this.title,
  });
}

/// Abstract contract for Riddle data access, enabling scalable pagination and lazy loading.
abstract class ILevelRepository {
  /// Total available levels in the catalog (e.g., 500).
  int get totalLevelsCount;

  /// Fetches full LevelData for a specific levelNumber.
  /// Implementations use lazy loading and in-memory LRU caching.
  Future<LevelData> getLevel(int levelNumber);

  /// Synchronously gets a level (from LRU cache, handcrafted list, or on-demand generator).
  LevelData getLevelSync(int levelNumber);

  /// Synchronously gets a level if already cached, otherwise returns null.
  LevelData? getCachedLevel(int levelNumber);

  /// Returns lightweight header metadata for grid pagination without loading geometry nodes.
  LevelHeader getLevelHeader(int levelNumber);

  /// Clears the in-memory cache to release memory if needed.
  void clearCache();
}

/// Production implementation supporting 500+ riddles with memory-efficient LRU caching.
class ScalableLevelRepository implements ILevelRepository {
  static const int defaultTotalLevels = 500;
  static const int _maxCacheSize = 25; // Keep at most 25 full level models in memory

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

  final int _totalLevels;
  final LinkedHashMap<int, LevelData> _lruCache = LinkedHashMap<int, LevelData>();

  ScalableLevelRepository({int totalLevels = defaultTotalLevels})
      : _totalLevels = totalLevels > 0 ? totalLevels : defaultTotalLevels;

  @override
  int get totalLevelsCount => _totalLevels;

  @override
  LevelData? getCachedLevel(int levelNumber) => _lruCache[levelNumber];

  @override
  LevelData getLevelSync(int levelNumber) {
    final clampedLevel = levelNumber.clamp(1, _totalLevels);

    // 1. Check LRU Cache
    if (_lruCache.containsKey(clampedLevel)) {
      final cached = _lruCache.remove(clampedLevel)!;
      _lruCache[clampedLevel] = cached;
      return cached;
    }

    // 2. Load level (handcrafted or generated)
    final LevelData level = generateLevel(clampedLevel);

    // 3. Store in LRU Cache and enforce memory boundary
    _lruCache[clampedLevel] = level;
    if (_lruCache.length > _maxCacheSize) {
      _lruCache.remove(_lruCache.keys.first); // Evict oldest
    }

    return level;
  }

  @override
  Future<LevelData> getLevel(int levelNumber) async {
    return getLevelSync(levelNumber);
  }

  @override
  LevelHeader getLevelHeader(int levelNumber) {
    final clampedLevel = levelNumber.clamp(1, _totalLevels);

    if (clampedLevel <= gameLevels.length) {
      final lvl = gameLevels[clampedLevel - 1];
      return LevelHeader(
        levelNumber: lvl.levelNumber,
        questionType: lvl.questionType,
        category: lvl.category,
        difficulty: lvl.difficulty,
        title: 'Level $clampedLevel',
      );
    }

    if (clampedLevel == 500) {
      return const LevelHeader(
        levelNumber: 500,
        questionType: QuestionType.Formula,
        category: 'Final Boss: Grand Singularity',
        difficulty: 'Final Boss',
        title: 'Level 500: Boss',
      );
    }

    final catIndex = (clampedLevel - 1) % 14;
    final category = categories[catIndex];
    final difficulty = getDifficulty(clampedLevel);
    final qType = _questionTypeForCategory(catIndex);

    return LevelHeader(
      levelNumber: clampedLevel,
      questionType: qType,
      category: category,
      difficulty: difficulty,
      title: 'Level $clampedLevel',
    );
  }

  @override
  void clearCache() {
    _lruCache.clear();
  }

  static QuestionType _questionTypeForCategory(int catIndex) {
    switch (catIndex) {
      case 1: // Geometry: Triangles
      case 9: // Geometry: Intersecting Circles
        return QuestionType.Geometry;
      case 6: // Matrix & Numeric Grid Riddles
        return QuestionType.Grid;
      default:
        return QuestionType.Formula;
    }
  }

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
        hint: 'Algebraic identity: (a³ - b³)/(a - b) = a² + ab + b². Subtracting ab leaves a² + b².',
        solution: '(a³ - b³)/(a - b) - ab = a² + b² = ${a * a + b * b}. Adding $c × $d (${c * d}) yields $ans.',
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
        displayContent: '([?] × $m) + $add = $total',
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
        displayContent: '$a × [?] × $b = $rowProd. [?] = ?',
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
        displayContent: 'A+B+C=$sum, A×B=$p1, B×C=$p2. A×B×C = ?',
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
        displayContent: 'Triangle [Vertex-Sum]: Top $top, Left $left, Right $right → Center [?]',
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
        displayContent: 'Triangle [Sum-Mult]: Top $top, Left $left, Right $right → Center [?]',
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
        displayContent: 'Triangle [Square-Div]: Top $t, Left $l, Right $r → Center [?]',
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
        displayContent: 'Triangle [Pythagorean]: Top $t, Left $l, Right $r → Center [?]',
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
      final ans = (top * left) + (top * right) - (left * right);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle [Cross-Vertex]: Top $top, Left $left, Right $right → Center [?]',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$top', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$left', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$right', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Formula: (Top × Left) + (Top × Right) - (Left × Right).',
        solution: '($top × $left) + ($top × $right) - ($left × $right) = ${top * left} + ${top * right} - ${left * right} = $ans.',
      );
    } else if (tier <= 5) {
      final t = (k % 4) + 3; final l = (k % 3) + 2; const r = 2; final ans = ((t * t * t) - (l * l)) ~/ r;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle [Cubic-Diff]: Top $t, Left $l, Right $r → Center [?]',
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
        displayContent: 'Triangle [Inverse-Left]: Top $t, Left [?], Right $r → Center $center',
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
        displayContent: '3×3 Grid: Diagonal Product = $prod ($a × $b × [?])',
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
        displayContent: '$count pens cost \$$cost. Cost of $targetCount pens? [?]',
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
        displayContent: 'A \$$basePrice jacket has $discountPercent% off discount. Final price? [?]',
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
        displayContent: '$totalCoins coins (dimes & nickels) total $totalCents¢. Number of dimes? [?]',
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
        displayContent: 'Item sold for \$$sellPrice at $profit% profit. Original cost price? [?]',
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
        displayContent: '\$$original item has 20% discount, then extra 10% off. Final price? [?]',
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
        displayContent: 'Buy 3 get 1 free at \$$unit each. Minimum cost for $items items? [?]',
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
        solution: '$ans² = $sq, which ends in $ans.',
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
        displayContent: 'Circles [Average]: Left $a, Right $b → Overlap [?]',
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
        displayContent: 'Circles [Geo-Mean]: Left $a, Right $b → Overlap [?]',
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
        displayContent: 'Circles [Diff-Sq]: Left $a, Right $b → Overlap [?]',
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
        displayContent: 'Circles [Prod-Sum]: Left $a, Right $b → Overlap [?]',
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
        displayContent: 'Circles [Harmonic]: Left ${p['a']}, Right ${p['b']} → Overlap [?]',
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
        displayContent: 'Circles [GCD]: Left $a, Right $b → Overlap [?]',
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
        displayContent: 'Circles [Quad-Sym]: Left $a, Right $b → Overlap [?]',
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
        displayContent: 'Sam is $diff yrs older than Leo. Sum of ages is $sum. Sam\'s age? [?]',
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
        displayContent: 'Dad is 3× Son\'s age. In $inYears yrs, Dad is $fFuture. Son\'s age now? [?]',
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
        displayContent: 'Mom is $m and daughter is $d. In how many years will Mom be 2× daughter? [?]',
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
        displayContent: 'A is 3× B, B is 2× C. Sum of ages is $total. Age of A? [?]',
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
        displayContent: 'I am 2× as old as you were when I was your age. Ages sum to $sum. My age? [?]',
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
        solution: '$a × $b = $prod and $a - $b = $diff. Older brother is $a.',
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
        displayContent: '$n people each shake hands with everyone once. Total handshakes? [?]',
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
        solution: '$length ÷ 5 = ${length ~/ piece} pieces. Cuts = ${length ~/ piece} - 1 = $cuts.',
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
      ];
      final c = clockAngles[k % clockAngles.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Clock #${k + 1}: Angle (in degrees) between hour and minute hand at ${c['time']}? [?]',
        correctAnswer: '${c['ans']}',
        hint: 'Formula: |30×H - 5.5×M| degrees.',
        solution: 'Angle between hands at ${c['time']} is ${c['ans']}°.',
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
        displayContent: 'Start: $s → (+$a) → (×$b) → (-$c) = [?]',
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
        displayContent: 'Start: $s → (+4) → (×2) → (-6) → (÷2) = [?]',
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
        displayContent: 'Path A: $s → (×2) → (+3). Path B: $s → (+3) → (×2). Path A + B = [?]',
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
        displayContent: 'Start: [?] → (×2) → (+6) = $endVal. [?] = ?',
        correctAnswer: '$start',
        hint: 'Work backwards from the exit: subtract 6, then divide by 2.',
        solution: '$endVal - 6 = ${endVal - 6}. ${endVal - 6} ÷ 2 = $start.',
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
        displayContent: 'Rule: Even → ÷2, Odd → ×3+1. Start: $s (maze #${k + 1}) after 4 steps = [?]',
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
        displayContent: 'Start: $s → (×3) → (mod 17) → (+25) = [?]',
        correctAnswer: '$ans',
        hint: 'Multiply $s by 3, find remainder when divided by 17, then add 25.',
        solution: '$s × 3 = ${s * 3}. ${s * 3} mod 17 = ${(s * 3) % 17}. Remainder + 25 = $ans.',
      );
    }
  }
}
