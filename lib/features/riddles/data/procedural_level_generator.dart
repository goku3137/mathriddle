import '../../../data/handcrafted_levels/handcrafted_levels_catalog.dart';
import '../../../models/level_model.dart';
import 'generators/algebra_word_generator.dart';
import 'generators/arithmetic_riddle_generator.dart';
import 'generators/geometry_riddle_generator.dart';
import 'generators/pattern_sequence_generator.dart';

/// Pure procedural math puzzle generation engine for levels 1 to 500 across 14 categories.
/// Seamlessly coordinates with HandcraftedLevelsCatalog so both handcrafted and procedural
/// riddles appear naturally mixed across all 10 packs of 50.
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

  /// Master level generation factory for all 500 levels.
  /// Combines handcrafted and procedural questions naturally throughout the campaign.
  static LevelData generateLevel(int level) {
    // 1. Check if this level is handcrafted
    final handcrafted = HandcraftedLevelsCatalog.getLevel(level);
    if (handcrafted != null) {
      return handcrafted;
    }

    // 2. Procedural generation for remaining levels
    final catIndex = (level - 1) % 14;
    final category = (level <= 150 && catIndex == 1)
        ? 'Balance & Scale Riddles'
        : (level <= 150 && catIndex == 9)
            ? 'Proportion & Average Riddles'
            : categories[catIndex];
    final difficulty = getDifficulty(level);
    final tier = getTier(level);
    final k = (level - 1) ~/ 14;

    final LevelData raw;
    switch (catIndex) {
      case 0:
        raw = ArithmeticRiddleGenerator.generateFormula(level, category, difficulty, tier, k);
        break;
      case 1:
        if (level <= 150) {
          raw = GeometryRiddleGenerator.generateBalanceRiddle(level, category, difficulty, tier, k);
        } else {
          raw = GeometryRiddleGenerator.generateTriangle(level, category, difficulty, tier, k);
        }
        break;
      case 2:
        raw = PatternSequenceGenerator.generatePattern(level, category, difficulty, tier, k);
        break;
      case 3:
        raw = ArithmeticRiddleGenerator.generateMissing(level, category, difficulty, tier, k);
        break;
      case 4:
        raw = AlgebraWordGenerator.generateEquation(level, category, difficulty, tier, k);
        break;
      case 5:
        raw = PatternSequenceGenerator.generateSequence(level, category, difficulty, tier, k);
        break;
      case 6:
        raw = PatternSequenceGenerator.generateGrid(level, category, difficulty, tier, k);
        break;
      case 7:
        raw = AlgebraWordGenerator.generateMoney(level, category, difficulty, tier, k);
        break;
      case 8:
        raw = AlgebraWordGenerator.generateLogic(level, category, difficulty, tier, k);
        break;
      case 9:
        if (level <= 150) {
          raw = GeometryRiddleGenerator.generateAverageRiddle(level, category, difficulty, tier, k);
        } else {
          raw = GeometryRiddleGenerator.generateCircles(level, category, difficulty, tier, k);
        }
        break;
      case 10:
        raw = ArithmeticRiddleGenerator.generateOperator(level, category, difficulty, tier, k);
        break;
      case 11:
        raw = AlgebraWordGenerator.generateAge(level, category, difficulty, tier, k);
        break;
      case 12:
        raw = ArithmeticRiddleGenerator.generateTrick(level, category, difficulty, tier, k);
        break;
      case 13:
      default:
        raw = PatternSequenceGenerator.generateMaze(level, category, difficulty, tier, k);
        break;
    }

    return LevelData(
      id: 'proc_$level',
      levelNumber: level,
      questionType: raw.questionType,
      category: raw.category,
      difficulty: raw.difficulty,
      displayContent: raw.displayContent,
      nodes: raw.nodes,
      correctAnswer: raw.correctAnswer,
      hint: raw.hint,
      solution: raw.solution,
      sourceType: QuestionSource.procedural,
      generationVersion: 1,
      seed: level,
    );
  }
}
