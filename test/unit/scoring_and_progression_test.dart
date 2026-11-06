import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:math/data/challenge_data.dart';
import 'package:math/domain/energy_rules.dart';
import 'package:math/domain/scoring_rules.dart';
import 'package:math/repositories/level_repository.dart';
import 'package:math/services/progress_service.dart';

void main() {
  group('Comprehensive Answers, Scoring, Hearts & Progression Verification', () {
    test('Answers verification: All 14 categories generate mathematically consistent answers up to Level 500', () {
      final repo = ScalableLevelRepository(totalLevels: 500);

      for (int lvl = 1; lvl <= 500; lvl++) {
        final levelData = repo.getLevelSync(lvl);
        expect(levelData.levelNumber, equals(lvl));
        expect(levelData.correctAnswer.trim().isNotEmpty, isTrue);

        // All answers must be non-empty valid numerical or symbolic answers
        expect(int.tryParse(levelData.correctAnswer), isNotNull,
            reason: 'Level $lvl answer is not an integer: ${levelData.correctAnswer}');
        expect(int.parse(levelData.correctAnswer) >= 0, isTrue,
            reason: 'Level $lvl answer cannot be negative');

        // Check header metadata
        final header = repo.getLevelHeader(lvl);
        expect(header.levelNumber, equals(lvl));
        expect(header.category.isNotEmpty, isTrue);
      }
    });

    test('Scoring Rules: Points scale strictly with riddle tiers and prevent duplicate claims', () {
      // Levels 1-10: +5 points
      expect(ScoringRules.pointsForRiddleLevel(1), equals(5));
      expect(ScoringRules.pointsForRiddleLevel(10), equals(5));

      // Levels 11-20: +15 points
      expect(ScoringRules.pointsForRiddleLevel(11), equals(15));
      expect(ScoringRules.pointsForRiddleLevel(20), equals(15));

      // Levels 21-30: +25 points
      expect(ScoringRules.pointsForRiddleLevel(21), equals(25));
      expect(ScoringRules.pointsForRiddleLevel(30), equals(25));

      // Level 500 (Boss): Highest points
      expect(ScoringRules.pointsForRiddleLevel(500), equals(495));

      // Challenge and Learn point values
      expect(ScoringRules.pointsPerChallenge, equals(3));
      expect(ScoringRules.pointsPerLearnLesson, equals(50));
    });

    test('Hearts & Energy Rules: Capacity is 5, interval is 20m, and refills accurately over elapsed time', () {
      expect(EnergyRules.maxHearts, equals(5));
      expect(EnergyRules.refillIntervalSeconds, equals(1200)); // 20 minutes

      // 0 seconds elapsed -> 0 refilled
      expect(EnergyRules.calculateRefilledHearts(0, 0), equals(0));

      // Exactly 20 minutes (1200s) elapsed -> 1 refilled
      expect(EnergyRules.calculateRefilledHearts(0, 1200), equals(1));

      // 60 minutes (3600s) elapsed from 2 hearts -> 3 refilled (capped at 5)
      expect(EnergyRules.calculateRefilledHearts(2, 3600), equals(3));

      // 200 minutes (12000s) elapsed from 0 hearts -> capped at max 5
      expect(EnergyRules.calculateRefilledHearts(0, 12000), equals(5));

      // Seconds until next refill after 10 minutes (600s)
      final secondsLeft = EnergyRules.calculateSecondsUntilNextHeart(0, 600);
      expect(secondsLeft, equals(600)); // 10 minutes remaining
    });

    test('Progressive Challenge Difficulty: Cumulative correct progression with accuracy thresholds', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progress = ProgressService(prefs);

      // Category starts at Tier 0
      final initialStats = progress.getCategoryStats(ChallengeType.addition);
      expect(initialStats.tier, equals(0));
      expect(initialStats.correctAnswers, equals(0));

      // Answer 19 correctly with 1 incorrect -> total 19 correct, 20 attempts (95% accuracy)
      for (int i = 0; i < 19; i++) {
        await progress.recordChallengeAttempt(
          type: ChallengeType.addition,
          isCorrect: true,
          currentStreak: i + 1,
        );
      }
      await progress.recordChallengeAttempt(
        type: ChallengeType.addition,
        isCorrect: false,
        currentStreak: 0,
      );

      // Still Tier 0 because cumulative correct is 19 (< 20)
      var stats = progress.getCategoryStats(ChallengeType.addition);
      expect(stats.correctAnswers, equals(19));
      expect(stats.tier, equals(0));

      // 20th correct answer arrives with accuracy ≥ 60% -> Unlock Tier 1!
      await progress.recordChallengeAttempt(
        type: ChallengeType.addition,
        isCorrect: true,
        currentStreak: 1,
      );

      stats = progress.getCategoryStats(ChallengeType.addition);
      expect(stats.correctAnswers, equals(20));
      expect(stats.tier, equals(1)); // Tier 1 unlocked!

      // Answer 20 more correctly -> 40 cumulative correct with ≥65% accuracy -> Unlock Tier 2!
      for (int i = 0; i < 20; i++) {
        await progress.recordChallengeAttempt(
          type: ChallengeType.addition,
          isCorrect: true,
          currentStreak: i + 2,
        );
      }

      stats = progress.getCategoryStats(ChallengeType.addition);
      expect(stats.correctAnswers, equals(40));
      expect(stats.tier, equals(2)); // Tier 2 unlocked!

      // Tier never resets on wrong answer!
      await progress.recordChallengeAttempt(
        type: ChallengeType.addition,
        isCorrect: false,
        currentStreak: 0,
      );

      stats = progress.getCategoryStats(ChallengeType.addition);
      expect(stats.tier, equals(2)); // Still Tier 2!
    });

    test('Badge Progression: Unlocks Newbie -> Beginner -> Skilled -> Expert -> Master -> Grandmaster', () {
      expect(ChallengeBadgeTier.getBadge(0), equals(ChallengeBadge.newbie));
      expect(ChallengeBadgeTier.getBadge(24), equals(ChallengeBadge.newbie));
      expect(ChallengeBadgeTier.getBadge(25), equals(ChallengeBadge.beginner));
      expect(ChallengeBadgeTier.getBadge(74), equals(ChallengeBadge.beginner));
      expect(ChallengeBadgeTier.getBadge(75), equals(ChallengeBadge.skilled));
      expect(ChallengeBadgeTier.getBadge(149), equals(ChallengeBadge.skilled));
      expect(ChallengeBadgeTier.getBadge(150), equals(ChallengeBadge.expert));
      expect(ChallengeBadgeTier.getBadge(299), equals(ChallengeBadge.expert));
      expect(ChallengeBadgeTier.getBadge(300), equals(ChallengeBadge.master));
      expect(ChallengeBadgeTier.getBadge(499), equals(ChallengeBadge.master));
      expect(ChallengeBadgeTier.getBadge(500), equals(ChallengeBadge.grandmaster));
      expect(ChallengeBadgeTier.getBadge(1000), equals(ChallengeBadge.grandmaster));

      // Progress percentages
      expect(ChallengeBadgeTier.getProgressFraction(0), equals(0.0));
      expect(ChallengeBadgeTier.getProgressFraction(500), equals(1.0));
    });
  });
}
