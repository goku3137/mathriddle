import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../domain/scoring_rules.dart';

enum SecurityViolation {
  none,
  tamperedStorage,
  clockRollback,
  suspiciousTimeJump,
  invalidInput,
}

/// Security & anti-tamper service for local storage validation,
/// integrity checksums, and device clock manipulation detection.
class SecurityService {
  // Application internal multi-component HMAC salt derivation
  // Combines package identifier and static runtime integrity pepper
  static const String _appId = 'com.valcire.mathriddle';
  static const String _pepper = 'smath_runtime_integrity_salt_v2_2026';
  static String get _appSalt => '$_appId:$_pepper';

  // Tolerance for minor clock drift (e.g. NTP sync) in seconds
  static const int _clockDriftToleranceSeconds = 60;

  /// Constant-time string comparison to prevent timing side-channel attacks.
  static bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }

  /// Generates an HMAC-SHA256 signature over critical game progression variables.
  static String generateStateSignature({
    required int highestUnlockedLevel,
    required List<String> completedLevels,
    required int totalScore,
    required int currentHearts,
    required int premiumTierIndex,
  }) {
    final sortedLevels = List<String>.from(completedLevels)..sort();
    final payload = '$highestUnlockedLevel|${sortedLevels.join(',')}|$totalScore|$currentHearts|$premiumTierIndex';
    final key = utf8.encode(_appSalt);
    final bytes = utf8.encode(payload);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);
    return digest.toString();
  }

  /// Verifies if the stored state matches its cryptographic signature using constant-time equality.
  static bool verifyStateSignature({
    required int highestUnlockedLevel,
    required List<String> completedLevels,
    required int totalScore,
    required int currentHearts,
    required int premiumTierIndex,
    required String? storedSignature,
  }) {
    // If no signature was ever written (first run), consider it valid
    if (storedSignature == null || storedSignature.isEmpty) {
      return true;
    }

    // Defensive bounds validation
    if (highestUnlockedLevel < 1 || totalScore < 0 || currentHearts < 0 || premiumTierIndex < 0) {
      return false;
    }

    final expectedSignature = generateStateSignature(
      highestUnlockedLevel: highestUnlockedLevel,
      completedLevels: completedLevels,
      totalScore: totalScore,
      currentHearts: currentHearts,
      premiumTierIndex: premiumTierIndex,
    );

    return _constantTimeEquals(expectedSignature, storedSignature);
  }

  /// Computes the absolute mathematical upper bound for total score
  /// based on legitimate completion records.
  static int computeMaximumValidScore({
    required Iterable<int> completedLevels,
    required int completedLearnCount,
    required int completedChallengeCount,
  }) {
    int maxScore = 0;
    for (final level in completedLevels) {
      maxScore += ScoringRules.pointsForRiddleLevel(level);
    }
    maxScore += completedLearnCount * ScoringRules.pointsPerLearnLesson;
    maxScore += completedChallengeCount * ScoringRules.pointsPerChallenge;
    return maxScore;
  }

  /// Detects device clock manipulation (e.g., player setting clock backward or jumping forward).
  static SecurityViolation checkClockIntegrity({
    required int currentDeviceTimeMs,
    required int? lastRecordedTimeMs,
  }) {
    if (lastRecordedTimeMs == null) {
      return SecurityViolation.none;
    }

    // 1. Check for Clock Rollback (player turned clock backward)
    final diffMs = currentDeviceTimeMs - lastRecordedTimeMs;
    if (diffMs < -(_clockDriftToleranceSeconds * 1000)) {
      return SecurityViolation.clockRollback;
    }

    // 2. Check for Suspicious Forward Jump (> 30 days into the future)
    const thirtyDaysMs = 30 * 24 * 60 * 60 * 1000;
    if (diffMs > thirtyDaysMs) {
      return SecurityViolation.suspiciousTimeJump;
    }

    return SecurityViolation.none;
  }

  /// Validates and sanitizes numeric virtual keypad inputs.
  /// Rejects injection attacks, non-numeric strings, and oversized inputs.
  static String sanitizeNumericInput(String rawInput, {int maxLength = 6}) {
    final trimmed = rawInput.trim();
    if (trimmed.isEmpty) return '';

    // Only allow digits '0'-'9' and optional leading '-'
    final regex = RegExp(r'^-?[0-9]*$');
    if (!regex.hasMatch(trimmed)) {
      return '';
    }

    if (trimmed.length > maxLength) {
      return trimmed.substring(0, maxLength);
    }

    return trimmed;
  }
}

