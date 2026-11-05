import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math/data/challenge_data.dart';
import 'package:math/services/progress_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SMATH Smart Progressive Challenges Verification', () {
    test('Requirement 1: Tier 0 starts first-time players with simple 1-digit numbers', () {
      final digitRegex = RegExp(r'^[0-9]$');

      for (int i = 0; i < 50; i++) {
        // Addition Tier 0: operands are 1-digit (1..9)
        final add = ChallengeGenerator.generate(ChallengeType.addition, tier: 0);
        final addParts = add.question.split('+');
        final a = int.parse(addParts[0].trim());
        final b = int.parse(addParts[1].replaceAll('=', '').replaceAll('?', '').trim());
        expect(a >= 1 && a <= 9, isTrue, reason: 'Operand A must be 1-digit: $a');
        expect(b >= 1 && b <= 9, isTrue, reason: 'Operand B must be 1-digit: $b');
        expect(add.explanation.isNotEmpty, isTrue);

        // Multiplication Tier 0: operands are 1-digit (2..9)
        final mul = ChallengeGenerator.generate(ChallengeType.multiplication, tier: 0);
        final mulParts = mul.question.split('×');
        final ma = int.parse(mulParts[0].trim());
        final mb = int.parse(mulParts[1].replaceAll('=', '').replaceAll('?', '').trim());
        expect(ma >= 2 && ma <= 9, isTrue, reason: 'Mul A must be 1-digit: $ma');
        expect(mb >= 2 && mb <= 9, isTrue, reason: 'Mul B must be 1-digit: $mb');
        expect(mul.explanation.isNotEmpty, isTrue);

        // Division Tier 0: 1-digit divisor and quotient (2..9)
        final div = ChallengeGenerator.generate(ChallengeType.division, tier: 0);
        final q = int.parse(div.answer);
        expect(digitRegex.hasMatch(div.answer), isTrue, reason: 'Div quotient must be 1-digit: $q');
        expect(div.explanation.isNotEmpty, isTrue);
      }
    });

    test('Requirement 2: Smart Progression across Tier 1 (2-digit) and Tier 2 (3-digit/hard)', () {
      for (int i = 0; i < 30; i++) {
        // Addition Tier 1 (2-digit numbers: 10..99)
        final addT1 = ChallengeGenerator.generate(ChallengeType.addition, tier: 1);
        final add1Parts = addT1.question.split('+');
        final a1 = int.parse(add1Parts[0].trim());
        final b1 = int.parse(add1Parts[1].replaceAll('=', '').replaceAll('?', '').trim());
        expect(a1 >= 10 && a1 <= 99, isTrue, reason: 'Tier 1 add operand must be 2-digit: $a1');
        expect(b1 >= 10 && b1 <= 99, isTrue, reason: 'Tier 1 add operand must be 2-digit: $b1');

        // Addition Tier 2 (3-digit numbers: 100..899)
        final addT2 = ChallengeGenerator.generate(ChallengeType.addition, tier: 2);
        final add2Parts = addT2.question.split('+');
        final a2 = int.parse(add2Parts[0].trim());
        final b2 = int.parse(add2Parts[1].replaceAll('=', '').replaceAll('?', '').trim());
        expect(a2 >= 100 && a2 <= 999, isTrue, reason: 'Tier 2 add operand must be 3-digit: $a2');
        expect(b2 >= 100 && b2 <= 999, isTrue, reason: 'Tier 2 add operand must be 3-digit: $b2');
      }
    });

    test('Requirement 10: All 12 categories generate valid items with explanations across all 3 tiers', () {
      final intRegex = RegExp(r'^[0-9]+$');

      for (final type in ChallengeType.values) {
        for (int tier = 0; tier <= 2; tier++) {
          for (int i = 0; i < 10; i++) {
            final item = ChallengeGenerator.generate(type, tier: tier);
            expect(item.id.isNotEmpty, isTrue);
            expect(item.question.isNotEmpty, isTrue);
            expect(intRegex.hasMatch(item.answer.trim()), isTrue,
                reason: 'Answer "${item.answer}" must be non-negative integer for $type at tier $tier');
            expect(item.explanation.isNotEmpty, isTrue,
                reason: 'Missing explanation for $type at tier $tier');
          }
        }
      }
    });

    test('Requirements 3 & 4: Independent Tracking per category (attempts, correct, streak, accuracy, tier)', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progress = ProgressService(prefs);

      // Verify clean initial stats
      final initialStats = progress.getCategoryStats(ChallengeType.addition);
      expect(initialStats.attempts, equals(0));
      expect(initialStats.correctAnswers, equals(0));
      expect(initialStats.highestStreak, equals(0));
      expect(initialStats.tier, equals(0));
      expect(initialStats.accuracyPercent, equals(0));
      expect(initialStats.tierLabel, equals('1-Digit'));

      // Record 15 correct answers in Addition
      for (int i = 1; i <= 15; i++) {
        await progress.recordChallengeAttempt(
          type: ChallengeType.addition,
          isCorrect: true,
          currentStreak: i,
        );
      }

      final addStats = progress.getCategoryStats(ChallengeType.addition);
      expect(addStats.attempts, equals(15));
      expect(addStats.correctAnswers, equals(15));
      expect(addStats.highestStreak, equals(15));
      expect(addStats.accuracyPercent, equals(100));
      expect(addStats.tier, equals(0)); // Still tier 0 (< 20)

      // Other categories remain completely untouched (independent tracking)
      final subStats = progress.getCategoryStats(ChallengeType.subtraction);
      expect(subStats.attempts, equals(0));
      expect(subStats.correctAnswers, equals(0));
      expect(subStats.tier, equals(0));

      // Advance past 20 consecutive correct answers -> unlocks Tier 1 (2-Digit)
      for (int i = 16; i <= 20; i++) {
        await progress.recordChallengeAttempt(
          type: ChallengeType.addition,
          isCorrect: true,
          currentStreak: i,
        );
      }

      final tier1Stats = progress.getCategoryStats(ChallengeType.addition);
      expect(tier1Stats.attempts, equals(20));
      expect(tier1Stats.highestStreak, equals(20));
      expect(tier1Stats.tier, equals(1));
      expect(tier1Stats.tierLabel, equals('2-Digit'));

      // Advance past 40 consecutive correct answers -> unlocks Tier 2 (3-Digit)
      for (int i = 21; i <= 40; i++) {
        await progress.recordChallengeAttempt(
          type: ChallengeType.addition,
          isCorrect: true,
          currentStreak: i,
        );
      }

      final tier2Stats = progress.getCategoryStats(ChallengeType.addition);
      expect(tier2Stats.attempts, equals(40));
      expect(tier2Stats.highestStreak, equals(40));
      expect(tier2Stats.tier, equals(2));
      expect(tier2Stats.tierLabel, equals('3-Digit'));
    });

    test('Requirement 9: Persistent progress survives app restart (new ProgressService instance)', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progress1 = ProgressService(prefs);

      // Record 5 attempts in Multiplication (4 correct, 1 wrong)
      await progress1.recordChallengeAttempt(type: ChallengeType.multiplication, isCorrect: true, currentStreak: 1);
      await progress1.recordChallengeAttempt(type: ChallengeType.multiplication, isCorrect: true, currentStreak: 2);
      await progress1.recordChallengeAttempt(type: ChallengeType.multiplication, isCorrect: true, currentStreak: 3);
      await progress1.recordChallengeAttempt(type: ChallengeType.multiplication, isCorrect: false, currentStreak: 0);
      await progress1.recordChallengeAttempt(type: ChallengeType.multiplication, isCorrect: true, currentStreak: 1);
      await progress1.setCategoryTier(ChallengeType.multiplication, 1);

      // Simulate App Restart by instantiating new ProgressService reading from same SharedPreferences
      final restartedProgress = ProgressService(prefs);
      final persistedStats = restartedProgress.getCategoryStats(ChallengeType.multiplication);

      expect(persistedStats.attempts, equals(5));
      expect(persistedStats.correctAnswers, equals(4));
      expect(persistedStats.highestStreak, equals(3));
      expect(persistedStats.tier, equals(1));
      expect(persistedStats.accuracyPercent, equals(80)); // 4 / 5 = 80%
      expect(persistedStats.tierLabel, equals('2-Digit'));
    });
  });
}

