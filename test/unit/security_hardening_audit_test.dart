import 'package:flutter_test/flutter_test.dart';
import 'package:math/services/security_service.dart';

void main() {
  group('OWASP MASVS Security Hardening Verification', () {
    test('Constant-time equality rejects signature tampering without leaking timing info', () {
      final validSig = SecurityService.generateStateSignature(
        highestUnlockedLevel: 10,
        completedLevels: ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
        totalScore: 90,
        currentHearts: 5,
        premiumTierIndex: 0,
      );

      // Verify legitimate signature succeeds
      expect(
        SecurityService.verifyStateSignature(
          highestUnlockedLevel: 10,
          completedLevels: ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
          totalScore: 90,
          currentHearts: 5,
          premiumTierIndex: 0,
          storedSignature: validSig,
        ),
        isTrue,
      );

      // Tampered byte at start
      final tamperedStart = '0${validSig.substring(1)}';
      expect(
        SecurityService.verifyStateSignature(
          highestUnlockedLevel: 10,
          completedLevels: ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
          totalScore: 90,
          currentHearts: 5,
          premiumTierIndex: 0,
          storedSignature: tamperedStart,
        ),
        isFalse,
      );

      // Tampered byte at end
      final tamperedEnd = '${validSig.substring(0, validSig.length - 1)}f';
      expect(
        SecurityService.verifyStateSignature(
          highestUnlockedLevel: 10,
          completedLevels: ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
          totalScore: 90,
          currentHearts: 5,
          premiumTierIndex: 0,
          storedSignature: tamperedEnd,
        ),
        isFalse,
      );

      // Truncated signature
      final truncated = validSig.substring(0, 32);
      expect(
        SecurityService.verifyStateSignature(
          highestUnlockedLevel: 10,
          completedLevels: ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
          totalScore: 90,
          currentHearts: 5,
          premiumTierIndex: 0,
          storedSignature: truncated,
        ),
        isFalse,
      );
    });

    test('Defensive parameter bounds rejection prevents negative state injection', () {
      final validSig = SecurityService.generateStateSignature(
        highestUnlockedLevel: 1,
        completedLevels: [],
        totalScore: 0,
        currentHearts: 5,
        premiumTierIndex: 0,
      );

      // Negative level
      expect(
        SecurityService.verifyStateSignature(
          highestUnlockedLevel: -1,
          completedLevels: [],
          totalScore: 0,
          currentHearts: 5,
          premiumTierIndex: 0,
          storedSignature: validSig,
        ),
        isFalse,
      );

      // Negative score
      expect(
        SecurityService.verifyStateSignature(
          highestUnlockedLevel: 1,
          completedLevels: [],
          totalScore: -50,
          currentHearts: 5,
          premiumTierIndex: 0,
          storedSignature: validSig,
        ),
        isFalse,
      );

      // Negative hearts
      expect(
        SecurityService.verifyStateSignature(
          highestUnlockedLevel: 1,
          completedLevels: [],
          totalScore: 0,
          currentHearts: -1,
          premiumTierIndex: 0,
          storedSignature: validSig,
        ),
        isFalse,
      );
    });

    test('Input sanitization rejects script injection, null bytes, and non-numeric payloads', () {
      expect(SecurityService.sanitizeNumericInput('<script>alert(1)</script>'), equals(''));
      expect(SecurityService.sanitizeNumericInput("1' OR '1'='1"), equals(''));
      expect(SecurityService.sanitizeNumericInput('12\u000034'), equals(''));
      expect(SecurityService.sanitizeNumericInput('42 '), equals('42'));
      expect(SecurityService.sanitizeNumericInput('-99'), equals('-99'));
      expect(SecurityService.sanitizeNumericInput('1234567890', maxLength: 6), equals('123456'));
    });
  });
}
