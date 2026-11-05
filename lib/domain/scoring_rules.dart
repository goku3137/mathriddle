/// Encapsulates all mathematical point calculations and reward rules.
class ScoringRules {
  const ScoringRules._();

  /// Riddle points escalation rule:
  /// - Levels 1–10: 5 points
  /// - Levels 11–20: 15 points
  /// - Levels 21–30: 25 points
  /// - Formula: 5 + (10 * ((level - 1) ~/ 10))
  static int pointsForRiddleLevel(int levelNumber) {
    if (levelNumber <= 0) return 0;
    if (levelNumber <= 10) return 5;
    final block = (levelNumber - 1) ~/ 10;
    return 5 + (block * 10);
  }

  /// Points awarded once upon completing an educational Learn concept.
  static const int pointsPerLearnLesson = 50;

  /// Points awarded once upon completing a Speedrun Challenge.
  static const int pointsPerChallenge = 3;
}
