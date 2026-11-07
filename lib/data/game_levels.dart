import '../models/level_model.dart';
import 'handcrafted_levels/handcrafted_levels_catalog.dart';

/// Legacy export pointing to the curated handcrafted levels across all packs.
final List<LevelData> gameLevels = HandcraftedLevelsCatalog.allLevels.values.toList();
