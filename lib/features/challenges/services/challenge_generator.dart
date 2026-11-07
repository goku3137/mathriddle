import 'dart:math';
import '../models/challenge_models.dart';
import 'generators/advanced_arithmetic_challenge_generator.dart';
import 'generators/basic_arithmetic_challenge_generator.dart';
import 'generators/sequence_logic_challenge_generator.dart';

/// Central Challenge Generator orchestrator.
/// Continuously generates mathematically verified challenge items on the fly
/// with progressive difficulty across 3 tiers (0, 1, 2).
class ChallengeGenerator {
  static final Random _defaultRng = Random();

  /// Generates a random, mathematically verified challenge problem continuously on the fly.
  /// Supports progressive difficulty tiers:
  /// - Tier 0: Simple 1-digit numbers
  /// - Tier 1: 2-digit numbers
  /// - Tier 2: 3-digit and harder calculations
  static ChallengeItem generate(ChallengeType type, {int tier = 0, Random? rng}) {
    final random = rng ?? _defaultRng;
    final clampedTier = tier.clamp(0, 2);
    switch (type) {
      case ChallengeType.addition:
        return BasicArithmeticChallengeGenerator.generateAddition(random, clampedTier);
      case ChallengeType.subtraction:
        return BasicArithmeticChallengeGenerator.generateSubtraction(random, clampedTier);
      case ChallengeType.multiplication:
        return BasicArithmeticChallengeGenerator.generateMultiplication(random, clampedTier);
      case ChallengeType.division:
        return BasicArithmeticChallengeGenerator.generateDivision(random, clampedTier);
      case ChallengeType.powers:
        return AdvancedArithmeticChallengeGenerator.generatePowers(random, clampedTier);
      case ChallengeType.percentages:
        return AdvancedArithmeticChallengeGenerator.generatePercentages(random, clampedTier);
      case ChallengeType.sequences:
        return SequenceLogicChallengeGenerator.generateSequences(random, clampedTier);
      case ChallengeType.missingNumbers:
        return SequenceLogicChallengeGenerator.generateMissingNumbers(random, clampedTier);
      case ChallengeType.bodmas:
        return AdvancedArithmeticChallengeGenerator.generateBodmas(random, clampedTier);
      case ChallengeType.lateralOperators:
        return SequenceLogicChallengeGenerator.generateLateralOperators(random, clampedTier);
      case ChallengeType.mathTricks:
        return AdvancedArithmeticChallengeGenerator.generateMathTricks(random, clampedTier);
      case ChallengeType.mixed:
        const pool = [
          ChallengeType.addition,
          ChallengeType.subtraction,
          ChallengeType.multiplication,
          ChallengeType.division,
          ChallengeType.powers,
          ChallengeType.percentages,
          ChallengeType.sequences,
          ChallengeType.missingNumbers,
          ChallengeType.bodmas,
          ChallengeType.lateralOperators,
          ChallengeType.mathTricks,
        ];
        final picked = pool[random.nextInt(pool.length)];
        return generate(picked, tier: clampedTier, rng: random);
    }
  }
}
