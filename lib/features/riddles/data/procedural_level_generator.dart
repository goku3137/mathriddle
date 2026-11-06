import '../../../data/game_levels.dart';
import '../../../models/level_model.dart';
import 'generators/algebra_word_generator.dart';
import 'generators/arithmetic_riddle_generator.dart';
import 'generators/geometry_riddle_generator.dart';
import 'generators/pattern_sequence_generator.dart';

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
        return ArithmeticRiddleGenerator.generateFormula(level, category, difficulty, tier, k);
      case 1:
        if (level <= 150) {
          return GeometryRiddleGenerator.generateBalanceRiddle(level, category, difficulty, tier, k);
        }
        return GeometryRiddleGenerator.generateTriangle(level, category, difficulty, tier, k);
      case 2:
        return PatternSequenceGenerator.generatePattern(level, category, difficulty, tier, k);
      case 3:
        return ArithmeticRiddleGenerator.generateMissing(level, category, difficulty, tier, k);
      case 4:
        return AlgebraWordGenerator.generateEquation(level, category, difficulty, tier, k);
      case 5:
        return PatternSequenceGenerator.generateSequence(level, category, difficulty, tier, k);
      case 6:
        return PatternSequenceGenerator.generateGrid(level, category, difficulty, tier, k);
      case 7:
        return AlgebraWordGenerator.generateMoney(level, category, difficulty, tier, k);
      case 8:
        return AlgebraWordGenerator.generateLogic(level, category, difficulty, tier, k);
      case 9:
        if (level <= 150) {
          return GeometryRiddleGenerator.generateAverageRiddle(level, category, difficulty, tier, k);
        }
        return GeometryRiddleGenerator.generateCircles(level, category, difficulty, tier, k);
      case 10:
        return ArithmeticRiddleGenerator.generateOperator(level, category, difficulty, tier, k);
      case 11:
        return AlgebraWordGenerator.generateAge(level, category, difficulty, tier, k);
      case 12:
        return ArithmeticRiddleGenerator.generateTrick(level, category, difficulty, tier, k);
      case 13:
      default:
        return PatternSequenceGenerator.generateMaze(level, category, difficulty, tier, k);
    }
  }
}
