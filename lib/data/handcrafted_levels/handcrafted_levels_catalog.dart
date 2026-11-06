import '../../models/level_model.dart';
import 'pack10_levels.dart';
import 'pack1_levels.dart';
import 'pack2_levels.dart';
import 'pack3_levels.dart';
import 'pack4_levels.dart';
import 'pack5_levels.dart';
import 'pack6_levels.dart';
import 'pack7_levels.dart';
import 'pack8_levels.dart';
import 'pack9_levels.dart';

/// Central repository catalog of all curated handcrafted riddle levels.
/// Handcrafted questions appear organically mixed with procedural levels
/// throughout all 10 packs of 50 (Levels 1 to 500).
class HandcraftedLevelsCatalog {
  HandcraftedLevelsCatalog._();

  static final Map<int, LevelData> _catalog = {
    for (final lvl in pack1HandcraftedLevels) lvl.levelNumber: lvl,
    for (final lvl in pack2HandcraftedLevels) lvl.levelNumber: lvl,
    for (final lvl in pack3HandcraftedLevels) lvl.levelNumber: lvl,
    for (final lvl in pack4HandcraftedLevels) lvl.levelNumber: lvl,
    for (final lvl in pack5HandcraftedLevels) lvl.levelNumber: lvl,
    for (final lvl in pack6HandcraftedLevels) lvl.levelNumber: lvl,
    for (final lvl in pack7HandcraftedLevels) lvl.levelNumber: lvl,
    for (final lvl in pack8HandcraftedLevels) lvl.levelNumber: lvl,
    for (final lvl in pack9HandcraftedLevels) lvl.levelNumber: lvl,
    for (final lvl in pack10HandcraftedLevels) lvl.levelNumber: lvl,
  };

  /// Returns true if the specified levelNumber is handcrafted.
  static bool isHandcrafted(int levelNumber) => _catalog.containsKey(levelNumber);

  /// Returns the handcrafted LevelData for the specified levelNumber, or null if procedural.
  static LevelData? getLevel(int levelNumber) => _catalog[levelNumber];

  /// Total count of curated handcrafted levels across all 500 levels.
  static int get totalCount => _catalog.length;

  /// All handcrafted level numbers in ascending order.
  static List<int> get levelNumbers => (_catalog.keys.toList()..sort());

  /// Full map of handcrafted levels by levelNumber.
  static Map<int, LevelData> get allLevels => Map.unmodifiable(_catalog);
}
