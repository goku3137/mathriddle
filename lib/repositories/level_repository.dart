import 'dart:collection';
import '../data/game_levels.dart';
import '../features/riddles/data/procedural_level_generator.dart';
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

  static List<String> get categories => ProceduralLevelGenerator.categories;

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

    // 2. Load level (handcrafted or procedural generator)
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

  static String getDifficulty(int level) => ProceduralLevelGenerator.getDifficulty(level);

  static int getTier(int level) => ProceduralLevelGenerator.getTier(level);

  /// Master level generation factory for all 500 levels
  static LevelData generateLevel(int level) => ProceduralLevelGenerator.generateLevel(level);
}
