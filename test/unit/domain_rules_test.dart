import 'package:flutter_test/flutter_test.dart';
import 'package:math/domain/energy_rules.dart';
import 'package:math/domain/scoring_rules.dart';

void main() {
  group('ScoringRules Domain Logic', () {
    test('Calculates points for levels 1 to 10 (+5 points)', () {
      expect(ScoringRules.pointsForRiddleLevel(1), equals(5));
      expect(ScoringRules.pointsForRiddleLevel(5), equals(5));
      expect(ScoringRules.pointsForRiddleLevel(10), equals(5));
    });

    test('Calculates points for levels 11 to 20 (+15 points: +10 increase)', () {
      expect(ScoringRules.pointsForRiddleLevel(11), equals(15));
      expect(ScoringRules.pointsForRiddleLevel(15), equals(15));
      expect(ScoringRules.pointsForRiddleLevel(20), equals(15));
    });

    test('Calculates points for levels 21 to 30 (+25 points)', () {
      expect(ScoringRules.pointsForRiddleLevel(21), equals(25));
      expect(ScoringRules.pointsForRiddleLevel(30), equals(25));
    });

    test('Scales accurately for higher levels up to 500', () {
      expect(ScoringRules.pointsForRiddleLevel(100), equals(95));
      expect(ScoringRules.pointsForRiddleLevel(500), equals(495));
    });

    test('Learn and Challenge constants match specification', () {
      expect(ScoringRules.pointsPerLearnLesson, equals(50));
      expect(ScoringRules.pointsPerChallenge, equals(3));
    });
  });

  group('EnergyRules Domain Logic', () {
    test('Capacity and refill intervals', () {
      expect(EnergyRules.maxHearts, equals(5));
      expect(EnergyRules.refillIntervalSeconds, equals(1200)); // 20 minutes
    });

    test('Calculates refilled hearts over elapsed time', () {
      // 0 minutes elapsed -> 0 refilled
      expect(EnergyRules.calculateRefilledHearts(3, 0), equals(0));

      // 19 minutes (1140s) -> 0 refilled
      expect(EnergyRules.calculateRefilledHearts(3, 1140), equals(0));

      // 20 minutes (1200s) -> 1 refilled (3 + 1 = 4)
      expect(EnergyRules.calculateRefilledHearts(3, 1200), equals(1));

      // 45 minutes (2700s) -> 2 refilled (3 + 2 = 5)
      expect(EnergyRules.calculateRefilledHearts(3, 2700), equals(2));

      // 5 hours (18000s) -> capped at max 5 (3 + 2 = 5)
      expect(EnergyRules.calculateRefilledHearts(3, 18000), equals(2));
    });

    test('Calculates seconds until next heart refill', () {
      // At full capacity (5), 0 seconds remaining
      expect(EnergyRules.calculateSecondsUntilNextHeart(5, 500), equals(0));

      // 5 minutes (300s) elapsed into a 20-min cycle -> 900s (15 min) remaining
      expect(EnergyRules.calculateSecondsUntilNextHeart(3, 300), equals(900));

      // 20 minutes (1200s) exact -> 1200s remaining for subsequent heart
      expect(EnergyRules.calculateSecondsUntilNextHeart(3, 1200), equals(1200));
    });
  });
}

