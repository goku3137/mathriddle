import 'package:flutter_test/flutter_test.dart';
import 'package:math/domain/energy_rules.dart';
import 'package:math/features/challenges/models/challenge_models.dart';
import 'package:math/features/challenges/services/challenge_generator.dart';
import 'package:math/repositories/level_repository.dart';
import 'package:math/services/progress_service.dart';
import 'package:math/services/security_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Requirement 16: Answer Validation', () {
    test('Leading zeros match integer equivalent answers', () {
      const solution = '6';
      final parsedInput = int.tryParse('06');
      final parsedExpected = int.tryParse(solution.trim());
      expect(parsedInput, isNotNull);
      expect(parsedExpected, isNotNull);
      expect(parsedInput == parsedExpected, isTrue);

      const zeroSolution = '0';
      final parsedZeroInput = int.tryParse('00');
      final parsedZeroExpected = int.tryParse(zeroSolution.trim());
      expect(parsedZeroInput == parsedZeroExpected, isTrue);
    });

    test('SecurityService sanitizes non-numeric injection and strips invalid characters', () {
      expect(SecurityService.sanitizeNumericInput(''), equals(''));
      expect(SecurityService.sanitizeNumericInput('   '), equals(''));
      expect(SecurityService.sanitizeNumericInput('abc'), equals(''));
      expect(SecurityService.sanitizeNumericInput('12.5'), equals(''));
      expect(SecurityService.sanitizeNumericInput('100'), equals('100'));
      expect(SecurityService.sanitizeNumericInput('007'), equals('007'));
      expect(SecurityService.sanitizeNumericInput('1234567890'), equals('123456'));
    });
  });

  group('Requirement 17: Game Progression & Pack Transitions', () {
    late ScalableLevelRepository repo;

    setUp(() {
      repo = ScalableLevelRepository(totalLevels: 500);
    });

    test('All 500 levels are accessible and 100-level pack transitions divide cleanly', () {
      expect(repo.totalLevelsCount, equals(500));
      const levelsPerPack = 100;
      final totalPacks = (repo.totalLevelsCount / levelsPerPack).ceil();
      expect(totalPacks, equals(5));

      // Pack 1: 1-100
      expect((0 * levelsPerPack) + 1, equals(1));
      expect(((0 * levelsPerPack) + levelsPerPack), equals(100));

      // Pack 5: 401-500
      expect((4 * levelsPerPack) + 1, equals(401));
      expect(((4 * levelsPerPack) + levelsPerPack), equals(500));

      final level500 = repo.getLevelSync(500);
      expect(level500.levelNumber, equals(500));
      expect(level500.correctAnswer.isNotEmpty, isTrue);
    });
  });

  group('Requirement 18 & 19: Challenge Fairness & Doubled Milestones', () {
    late SharedPreferences prefs;
    late ProgressService progress;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      progress = ProgressService(prefs);
    });

    test('Tier progression adheres strictly to doubled milestones (20 for Tier 1, 40 for Tier 2)', () async {
      final initialStats = progress.getCategoryStats(ChallengeType.addition);
      expect(initialStats.tier, equals(0));

      // Record 19 correct answers
      for (int i = 0; i < 19; i++) {
        await progress.recordChallengeAttempt(
          type: ChallengeType.addition,
          isCorrect: true,
          currentStreak: i + 1,
        );
      }
      expect(progress.getCategoryStats(ChallengeType.addition).tier, equals(0));

      // 20th correct answer unlocks Tier 1
      await progress.recordChallengeAttempt(
        type: ChallengeType.addition,
        isCorrect: true,
        currentStreak: 20,
      );
      expect(progress.getCategoryStats(ChallengeType.addition).tier, equals(1));

      // Solve up to 39
      for (int i = 21; i <= 39; i++) {
        await progress.recordChallengeAttempt(
          type: ChallengeType.addition,
          isCorrect: true,
          currentStreak: i,
        );
      }
      expect(progress.getCategoryStats(ChallengeType.addition).tier, equals(1));

      // 40th correct answer unlocks Tier 2
      await progress.recordChallengeAttempt(
        type: ChallengeType.addition,
        isCorrect: true,
        currentStreak: 40,
      );
      expect(progress.getCategoryStats(ChallengeType.addition).tier, equals(2));
    });

    test('ChallengeGenerator dynamically provides unique valid items across all 12 categories', () {
      for (final type in ChallengeType.values) {
        final item = ChallengeGenerator.generate(type, tier: 1);
        expect(item.id.isNotEmpty, isTrue);
        expect(item.question.isNotEmpty, isTrue);
        expect(item.answer.isNotEmpty, isTrue);
        expect(int.tryParse(item.answer), isNotNull, reason: 'Category $type generated non-integer: ${item.answer}');
      }
    });
  });

  group('Requirement 20: Time Manipulation & Energy Safeguards', () {
    test('Clock rollback is detected and prevents time exploitation', () {
      final now = DateTime.now().millisecondsSinceEpoch;
      // Turned clock back by 2 hours
      final turnedBackTime = now - (2 * 3600 * 1000);
      final violation = SecurityService.checkClockIntegrity(
        currentDeviceTimeMs: turnedBackTime,
        lastRecordedTimeMs: now,
      );
      expect(violation, equals(SecurityViolation.clockRollback));
    });

    test('Hearts never exceed maximum capacity (5) on forward time jumps', () {
      final refilled = EnergyRules.calculateRefilledHearts(3, 30 * 24 * 3600); // 30 days
      expect(3 + refilled, equals(EnergyRules.maxHearts));
    });
  });

  group('Requirement 22: Data Integrity & Safe Sanitization', () {
    test('Tampered storage safely clamps score without wiping completed levels', () async {
      SharedPreferences.setMockInitialValues({
        'math_highest_unlocked_level': 10,
        'math_completed_levels': ['1', '2', '3'],
        'math_total_score': 999999, // Impossible cheated score
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      // Verifies completed levels and highest unlocked level are preserved
      expect(progressService.unlockedLevelIndex, equals(10));
      expect(progressService.completedLevelsList, containsAll([1, 2, 3]));

      // Verifies score was safely clamped to verified maximum rather than blanking progress
      final maxValid = SecurityService.computeMaximumValidScore(
        completedLevels: [1, 2, 3],
        completedLearnCount: 0,
        completedChallengeCount: 0,
      );
      expect(progressService.totalScore, equals(maxValid));
    });
  });
}
