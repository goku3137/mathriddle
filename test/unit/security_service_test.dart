import 'package:flutter_test/flutter_test.dart';
import 'package:math/services/security_service.dart';

void main() {
  group('SecurityService - Local Storage Signature & Tamper Detection', () {
    test('generateStateSignature produces deterministic HMAC-SHA256 signature', () {
      final sig1 = SecurityService.generateStateSignature(
        highestUnlockedLevel: 5,
        completedLevels: ['1', '2', '3', '4'],
        totalScore: 45,
        currentHearts: 5,
        premiumTierIndex: 0,
      );

      final sig2 = SecurityService.generateStateSignature(
        highestUnlockedLevel: 5,
        completedLevels: ['1', '2', '3', '4'],
        totalScore: 45,
        currentHearts: 5,
        premiumTierIndex: 0,
      );

      expect(sig1, equals(sig2));
      expect(sig1.length, equals(64)); // 256 bits = 64 hex characters
    });

    test('verifyStateSignature detects unauthorized modification of totalScore', () {
      final validSig = SecurityService.generateStateSignature(
        highestUnlockedLevel: 5,
        completedLevels: ['1', '2', '3', '4'],
        totalScore: 45,
        currentHearts: 5,
        premiumTierIndex: 0,
      );

      // Attacker altered totalScore in SharedPreferences XML to 99999
      final isTampered = !SecurityService.verifyStateSignature(
        highestUnlockedLevel: 5,
        completedLevels: ['1', '2', '3', '4'],
        totalScore: 99999, // Altered
        currentHearts: 5,
        premiumTierIndex: 0,
        storedSignature: validSig,
      );

      expect(isTampered, isTrue);
    });

    test('verifyStateSignature detects unauthorized modification of highestUnlockedLevel', () {
      final validSig = SecurityService.generateStateSignature(
        highestUnlockedLevel: 2,
        completedLevels: ['1'],
        totalScore: 5,
        currentHearts: 5,
        premiumTierIndex: 0,
      );

      // Attacker unlocked level 500 without solving levels
      final isTampered = !SecurityService.verifyStateSignature(
        highestUnlockedLevel: 500, // Altered
        completedLevels: ['1'],
        totalScore: 5,
        currentHearts: 5,
        premiumTierIndex: 0,
        storedSignature: validSig,
      );

      expect(isTampered, isTrue);
    });
  });

  group('SecurityService - Clock Manipulation & Anti-Tamper', () {
    test('Detects device clock rollback (turning clock backward)', () {
      final now = DateTime.now().millisecondsSinceEpoch;
      final pastTime = now - (2 * 60 * 60 * 1000); // 2 hours in the past

      final violation = SecurityService.checkClockIntegrity(
        currentDeviceTimeMs: pastTime,
        lastRecordedTimeMs: now,
      );

      expect(violation, equals(SecurityViolation.clockRollback));
    });

    test('Allows normal forward time passage within expected drift', () {
      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsed = now + (20 * 60 * 1000); // 20 minutes forward

      final violation = SecurityService.checkClockIntegrity(
        currentDeviceTimeMs: elapsed,
        lastRecordedTimeMs: now,
      );

      expect(violation, equals(SecurityViolation.none));
    });

    test('Detects suspicious forward jump beyond 30 days', () {
      final now = DateTime.now().millisecondsSinceEpoch;
      final futureTime = now + (35 * 24 * 60 * 60 * 1000); // 35 days in future

      final violation = SecurityService.checkClockIntegrity(
        currentDeviceTimeMs: futureTime,
        lastRecordedTimeMs: now,
      );

      expect(violation, equals(SecurityViolation.suspiciousTimeJump));
    });
  });

  group('SecurityService - Numeric Input Sanitization', () {
    test('Accepts valid numeric strings', () {
      expect(SecurityService.sanitizeNumericInput('96'), equals('96'));
      expect(SecurityService.sanitizeNumericInput('0'), equals('0'));
      expect(SecurityService.sanitizeNumericInput('  42  '), equals('42'));
      expect(SecurityService.sanitizeNumericInput('-48'), equals('-48'));
    });

    test('Rejects non-numeric injection characters', () {
      expect(SecurityService.sanitizeNumericInput('96<script>'), equals(''));
      expect(SecurityService.sanitizeNumericInput('drop table'), equals(''));
      expect(SecurityService.sanitizeNumericInput('12a34'), equals(''));
      expect(SecurityService.sanitizeNumericInput('!@#'), equals(''));
    });

    test('Truncates inputs exceeding maximum length', () {
      expect(SecurityService.sanitizeNumericInput('123456789', maxLength: 6), equals('123456'));
    });
  });

  group('SecurityService - Deterministic Score Invariant Checking', () {
    test('Calculates exact theoretical maximum score from achievements', () {
      // 2 riddle levels (1 and 2 = 5 + 5 = 10 pts)
      // 1 learn topic = 50 pts
      // 2 challenges = 6 pts
      // Total max = 66
      final maxScore = SecurityService.computeMaximumValidScore(
        completedLevels: [1, 2],
        completedLearnCount: 1,
        completedChallengeCount: 2,
      );
      expect(maxScore, equals(66));
    });

    test('Scales accurately for higher level brackets', () {
      // Level 1 (5pts) + Level 15 (15pts) + Level 25 (25pts) = 45pts
      final maxScore = SecurityService.computeMaximumValidScore(
        completedLevels: [1, 15, 25],
        completedLearnCount: 0,
        completedChallengeCount: 0,
      );
      expect(maxScore, equals(45));
    });
  });
}

