import 'dart:collection';
import '../data/game_levels.dart';
import '../models/level_model.dart';

/// Lightweight summary metadata for level select grids and progress displays.
class LevelHeader {
  final int levelNumber;
  final QuestionType questionType;
  final String title;

  const LevelHeader({
    required this.levelNumber,
    required this.questionType,
    required this.title,
  });
}

/// Abstract contract for Riddle data access, enabling scalable pagination and lazy loading.
abstract class ILevelRepository {
  /// Total available levels in the catalog (e.g., 500).
  int get totalLevelsCount;

  /// Fetches full LevelData for a specific levelNumber.
  /// Implementations should use lazy loading and in-memory LRU caching.
  Future<LevelData> getLevel(int levelNumber);

  /// Synchronously gets a level if already cached, otherwise returns null.
  LevelData? getCachedLevel(int levelNumber);

  /// Returns lightweight header metadata for grid pagination without loading geometry nodes.
  LevelHeader getLevelHeader(int levelNumber);

  /// Clears the in-memory cache to release memory if needed.
  void clearCache();
}

/// Production implementation supporting 500+ riddles with memory-efficient LRU caching.
class ScalableLevelRepository implements ILevelRepository {
  static const int _defaultTotalLevels = 500;
  static const int _maxCacheSize = 25; // Keep at most 25 full level models in memory

  final int _totalLevels;
  final LinkedHashMap<int, LevelData> _lruCache = LinkedHashMap<int, LevelData>();

  ScalableLevelRepository({int totalLevels = _defaultTotalLevels})
      : _totalLevels = totalLevels;

  @override
  int get totalLevelsCount => _totalLevels;

  @override
  LevelData? getCachedLevel(int levelNumber) => _lruCache[levelNumber];

  @override
  Future<LevelData> getLevel(int levelNumber) async {
    final clampedLevel = levelNumber.clamp(1, _totalLevels);

    // 1. Check LRU Cache
    if (_lruCache.containsKey(clampedLevel)) {
      // Re-insert to mark as recently used
      final cached = _lruCache.remove(clampedLevel)!;
      _lruCache[clampedLevel] = cached;
      return cached;
    }

    // 2. Load level (handcrafted or generated)
    final LevelData level;
    if (clampedLevel <= gameLevels.length) {
      level = gameLevels[clampedLevel - 1];
    } else {
      level = _generateProceduralRiddle(clampedLevel);
    }

    // 3. Store in LRU Cache and enforce memory boundary
    _lruCache[clampedLevel] = level;
    if (_lruCache.length > _maxCacheSize) {
      _lruCache.remove(_lruCache.keys.first); // Evict oldest
    }

    return level;
  }

  @override
  LevelHeader getLevelHeader(int levelNumber) {
    final clampedLevel = levelNumber.clamp(1, _totalLevels);
    if (clampedLevel <= gameLevels.length) {
      final lvl = gameLevels[clampedLevel - 1];
      return LevelHeader(
        levelNumber: lvl.levelNumber,
        questionType: lvl.questionType,
        title: 'Level $clampedLevel',
      );
    }

    // Header without generating full geometry
    final types = [QuestionType.Formula, QuestionType.Geometry, QuestionType.Grid];
    final type = types[(clampedLevel - 1) % types.length];
    return LevelHeader(
      levelNumber: clampedLevel,
      questionType: type,
      title: 'Level $clampedLevel',
    );
  }

  @override
  void clearCache() {
    _lruCache.clear();
  }

  /// Generates deterministic, pattern-based mathematical riddles for levels > 20.
  /// Guarantees that memory is only allocated when a user actually loads that level.
  LevelData _generateProceduralRiddle(int levelNumber) {
    final patternIndex = (levelNumber - 1) % 5;

    switch (patternIndex) {
      case 0:
        // Multiplicative Precedence: a + b × c
        final a = (levelNumber % 7) + 2;
        final b = (levelNumber % 5) + 3;
        final c = (levelNumber % 6) + 2;
        final ans = a + (b * c);
        return LevelData(
          levelNumber: levelNumber,
          questionType: QuestionType.Formula,
          displayContent: '$a + $b × $c = ?',
          correctAnswer: '$ans',
          hint: 'Multiplication takes precedence over addition (PEMDAS).',
          solution: '$b × $c = ${b * c}, then $a + ${b * c} = $ans.',
        );

      case 1:
        // Vertex Triangle Geometry: (Top × Left) + Right = Center
        final top = (levelNumber % 8) + 2;
        final left = (levelNumber % 6) + 2;
        final right = (levelNumber % 7) + 1;
        final centerAns = (top * left) + right;
        return LevelData(
          levelNumber: levelNumber,
          questionType: QuestionType.Geometry,
          displayContent: 'Triangle Center Target',
          nodes: [
            PuzzleNode(id: 'top', displayValue: '$top', relX: 0.5, relY: 0.16),
            PuzzleNode(id: 'left', displayValue: '$left', relX: 0.15, relY: 0.82),
            PuzzleNode(id: 'right', displayValue: '$right', relX: 0.85, relY: 0.82),
            PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
          ],
          correctAnswer: '$centerAns',
          hint: 'Multiply Top by Left and add Right vertex: ($top × $left) + $right.',
          solution: '($top × $left) + $right = ${top * left} + $right = $centerAns.',
        );

      case 2:
        // Grid Progression Matrix: n, 2n, 4n
        final base = (levelNumber % 9) + 2;
        final ans = base * 4;
        return LevelData(
          levelNumber: levelNumber,
          questionType: QuestionType.Grid,
          displayContent: 'Doubling Grid Progression',
          nodes: [
            PuzzleNode(id: 'r1c1', displayValue: '$base'),
            PuzzleNode(id: 'r1c2', displayValue: '${base * 2}'),
            PuzzleNode(id: 'r1c3', displayValue: '$ans'),
            PuzzleNode(id: 'r2c1', displayValue: '${base + 1}'),
            PuzzleNode(id: 'r2c2', displayValue: '${(base + 1) * 2}'),
            PuzzleNode(id: 'r2c3', displayValue: '${(base + 1) * 4}'),
            PuzzleNode(id: 'r3c1', displayValue: '${base + 2}'),
            PuzzleNode(id: 'r3c2', displayValue: '${(base + 2) * 2}'),
            PuzzleNode(id: 'r3c3', displayValue: '?', isTarget: true),
          ],
          correctAnswer: '${(base + 2) * 4}',
          hint: 'Each row doubles from left to right.',
          solution: '${base + 2} × 2 = ${(base + 2) * 2}, ${(base + 2) * 2} × 2 = ${(base + 2) * 4}.',
        );

      case 3:
        // Intersecting Circles Average: (Left + Right) / 2
        final leftVal = ((levelNumber % 10) + 1) * 2;
        final rightVal = ((levelNumber % 8) + 3) * 2;
        final avgAns = (leftVal + rightVal) ~/ 2;
        return LevelData(
          levelNumber: levelNumber,
          questionType: QuestionType.Geometry,
          displayContent: 'Overlapping Circles',
          nodes: [
            PuzzleNode(id: 'left', displayValue: '$leftVal'),
            PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
            PuzzleNode(id: 'right', displayValue: '$rightVal'),
          ],
          correctAnswer: '$avgAns',
          hint: 'The center is the arithmetic mean of the outer circles.',
          solution: '($leftVal + $rightVal) / 2 = ${leftVal + rightVal} / 2 = $avgAns.',
        );

      default:
        // Difference Squared: (a - b)^2
        final a = (levelNumber % 10) + 6;
        final b = (levelNumber % 5) + 1;
        final diffAns = (a - b) * (a - b);
        return LevelData(
          levelNumber: levelNumber,
          questionType: QuestionType.Formula,
          displayContent: '($a - $b)² = ?',
          correctAnswer: '$diffAns',
          hint: 'Evaluate the difference inside parentheses, then square it.',
          solution: '($a - $b) = ${a - b}. Then ${a - b}² = $diffAns.',
        );
    }
  }
}
