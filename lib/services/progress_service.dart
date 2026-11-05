import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/energy_rules.dart';
import '../domain/scoring_rules.dart';
import 'monetization_service.dart';
import 'security_service.dart';

class ProgressService {
  static const String _keySchemaVersion = 'math_schema_version';
  static const int _currentSchemaVersion = 2;

  static const String _keyHighestUnlocked = 'math_highest_unlocked_level';
  static const String _keyCompletedLevels = 'math_completed_levels';
  static const String _keySound = 'math_sound_enabled';
  static const String _keyVibration = 'math_vibration_enabled';
  static const String _keyPersonalizedAds = 'math_ads_enabled';
  static const String _keyPremiumTier = 'math_premium_tier';
  static const String _keyUnlockedHints = 'math_hints_level_';
  static const String _keyUnlockedSolutions = 'math_solution_level_';
  static const String _keyTotalScore = 'math_total_score';
  static const String _keyCompletedLearnTopics = 'math_completed_learn_topics';
  static const String _keyCompletedChallenges = 'math_completed_challenges';
  static const String _keyHearts = 'math_current_hearts';
  static const String _keyLastHeartTimestamp = 'math_last_heart_timestamp';
  static const String _keyLastDeviceTime = 'math_last_device_time';
  static const String _keyStateSignature = 'math_state_signature';

  static const int maxHearts = EnergyRules.maxHearts;
  static const int refillIntervalSeconds = EnergyRules.refillIntervalSeconds;

  final SharedPreferences _prefs;
  bool _isTampered = false;

  ProgressService(this._prefs) {
    _migrateAndValidate();
  }

  static Future<ProgressService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return ProgressService(prefs);
  }

  /// Verifies state cryptographic integrity and performs schema migrations.
  void _migrateAndValidate() {
    try {
      final currentVersion = _prefs.getInt(_keySchemaVersion) ?? 1;
      if (currentVersion < _currentSchemaVersion) {
        // Safe migration: schema upgrades
        _prefs.setInt(_keySchemaVersion, _currentSchemaVersion);
      }

      // Verify cryptographic signature of local state to detect external tampering
      final storedSig = _prefs.getString(_keyStateSignature);
      final isValid = SecurityService.verifyStateSignature(
        highestUnlockedLevel: _safeGetInt(_keyHighestUnlocked, 1),
        completedLevels: _prefs.getStringList(_keyCompletedLevels) ?? [],
        totalScore: _safeGetInt(_keyTotalScore, 0),
        currentHearts: _safeGetInt(_keyHearts, maxHearts),
        premiumTierIndex: _safeGetInt(_keyPremiumTier, 0),
        storedSignature: storedSig,
      );

      if (!isValid) {
        _isTampered = true;
        developer.log('SECURITY WARNING: Local storage signature mismatch detected! Sanitizing state.', name: 'SMATH.Security');
      }

      // Verify deterministic score invariant: stored score can NEVER exceed max valid score
      final completed = completedLevelsList;
      final maxValidScore = SecurityService.computeMaximumValidScore(
        completedLevels: completed,
        completedLearnCount: completedLearnTopics.length,
        completedChallengeCount: completedChallenges.length,
      );

      final currentScore = _safeGetInt(_keyTotalScore, 0);
      if (currentScore > maxValidScore || !isValid) {
        if (currentScore > maxValidScore) {
          _isTampered = true;
          developer.log('SECURITY WARNING: Impossible score ($currentScore > $maxValidScore) detected! Resetting to verified maximum.', name: 'SMATH.Security');
        }
        _prefs.setInt(_keyTotalScore, maxValidScore.clamp(0, currentScore));
      }

      // Initial heart sync & clock audit
      _checkAndRefillOfflineHearts();
      _updateSignature();
    } catch (e, stack) {
      developer.log('Error during progress service initialization: $e', stackTrace: stack, name: 'SMATH.Progress');
    }
  }

  bool get isStorageTampered => _isTampered;

  int _safeGetInt(String key, int defaultValue) {
    try {
      return _prefs.getInt(key) ?? defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Recalculates and persists HMAC signature over critical state.
  Future<void> _updateSignature() async {
    try {
      final sig = SecurityService.generateStateSignature(
        highestUnlockedLevel: unlockedLevelIndex,
        completedLevels: _prefs.getStringList(_keyCompletedLevels) ?? [],
        totalScore: totalScore,
        currentHearts: _safeGetInt(_keyHearts, maxHearts),
        premiumTierIndex: _safeGetInt(_keyPremiumTier, 0),
      );
      await _prefs.setString(_keyStateSignature, sig);
    } catch (e) {
      developer.log('Failed to update state signature: $e', name: 'SMATH.Security');
    }
  }

  // --- Single Source of Truth for Level Progression ---
  int get unlockedLevelIndex => _safeGetInt(_keyHighestUnlocked, 1);

  int getHighestUnlockedLevel() => unlockedLevelIndex;

  Future<void> setHighestUnlockedLevel(int level) async {
    final current = unlockedLevelIndex;
    if (level > current) {
      await _prefs.setInt(_keyHighestUnlocked, level);
      await _updateSignature();
    }
  }

  bool isLevelUnlocked(int level) {
    if (level <= 1) return true;
    return level <= unlockedLevelIndex;
  }

  Set<int> get completedLevelsList {
    try {
      final list = _prefs.getStringList(_keyCompletedLevels) ?? [];
      return list.map(int.tryParse).whereType<int>().toSet();
    } catch (_) {
      return <int>{};
    }
  }

  Set<int> getCompletedLevels() => completedLevelsList;

  Future<void> markLevelCompleted(int level) async {
    final completed = getCompletedLevels();
    completed.add(level);
    await _prefs.setStringList(
      _keyCompletedLevels,
      completed.map((e) => e.toString()).toList(),
    );
    // Linear progression: solving level N unlocks level N + 1
    await setHighestUnlockedLevel(level + 1);
    await _updateSignature();
  }

  // --- Score & Achievements System ---
  int get totalScore => _safeGetInt(_keyTotalScore, 0);

  Future<void> addScore(int points) async {
    if (points <= 0) return;
    final newScore = totalScore + points;
    await _prefs.setInt(_keyTotalScore, newScore);
    await _updateSignature();
  }

  Future<void> setScore(int score) async {
    if (score < 0) return;
    await _prefs.setInt(_keyTotalScore, score);
    await _updateSignature();
  }

  Set<String> get completedLearnTopics {
    try {
      final list = _prefs.getStringList(_keyCompletedLearnTopics) ?? [];
      return list.toSet();
    } catch (_) {
      return <String>{};
    }
  }

  bool isLearnTopicCompleted(String topicId) {
    return completedLearnTopics.contains(topicId);
  }

  Future<bool> markLearnTopicCompleted(String topicId) async {
    final topics = completedLearnTopics;
    if (!topics.contains(topicId)) {
      topics.add(topicId);
      await _prefs.setStringList(_keyCompletedLearnTopics, topics.toList());
      await addScore(ScoringRules.pointsPerLearnLesson);
      return true;
    }
    return false;
  }

  Set<String> get completedChallenges {
    try {
      final list = _prefs.getStringList(_keyCompletedChallenges) ?? [];
      return list.toSet();
    } catch (_) {
      return <String>{};
    }
  }

  bool isChallengeCompleted(String challengeId) {
    return completedChallenges.contains(challengeId);
  }

  Future<bool> markChallengeCompleted(String challengeId) async {
    final completed = completedChallenges;
    if (!completed.contains(challengeId)) {
      completed.add(challengeId);
      await _prefs.setStringList(_keyCompletedChallenges, completed.toList());
      await addScore(ScoringRules.pointsPerChallenge);
      return true;
    }
    return false;
  }

  // --- Hints & Solutions ---
  bool isHintUnlocked(int level) {
    if (isPremiumUser) return true;
    return _prefs.getBool('$_keyUnlockedHints$level') ?? false;
  }

  Future<void> unlockHint(int level) async {
    await _prefs.setBool('$_keyUnlockedHints$level', true);
  }

  bool isSolutionUnlocked(int level) {
    if (isPremiumUser) return true;
    return _prefs.getBool('$_keyUnlockedSolutions$level') ?? false;
  }

  Future<void> unlockSolution(int level) async {
    await _prefs.setBool('$_keyUnlockedSolutions$level', true);
  }

  // --- Hearts & Energy System (5 Hearts, 20m Refill with Anti-Tamper) ---
  int get currentHearts {
    if (isPremiumUser) return maxHearts;
    _checkAndRefillOfflineHearts();
    return _safeGetInt(_keyHearts, maxHearts);
  }

  void _checkAndRefillOfflineHearts() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final lastDeviceTime = _prefs.getInt(_keyLastDeviceTime);

    // Clock tamper detection
    final clockViolation = SecurityService.checkClockIntegrity(
      currentDeviceTimeMs: now,
      lastRecordedTimeMs: lastDeviceTime,
    );

    // Record last device timestamp
    _prefs.setInt(_keyLastDeviceTime, now);

    if (clockViolation == SecurityViolation.clockRollback) {
      developer.log('SECURITY WARNING: Clock rollback detected! Heart refill frozen.', name: 'SMATH.Security');
      return;
    }

    final hearts = _safeGetInt(_keyHearts, maxHearts);
    if (hearts >= maxHearts) {
      if (_prefs.containsKey(_keyLastHeartTimestamp)) {
        _prefs.remove(_keyLastHeartTimestamp);
      }
      return;
    }

    final lastTimestamp = _prefs.getInt(_keyLastHeartTimestamp);
    if (lastTimestamp == null) {
      _prefs.setInt(_keyLastHeartTimestamp, now);
      return;
    }

    final elapsedSeconds = (now - lastTimestamp) ~/ 1000;
    if (elapsedSeconds >= refillIntervalSeconds) {
      final heartsToAdd = EnergyRules.calculateRefilledHearts(hearts, elapsedSeconds);
      final newHearts = (hearts + heartsToAdd).clamp(0, maxHearts);
      _prefs.setInt(_keyHearts, newHearts);
      if (newHearts >= maxHearts) {
        _prefs.remove(_keyLastHeartTimestamp);
      } else {
        final remainderTimestamp = lastTimestamp + (heartsToAdd * refillIntervalSeconds * 1000);
        _prefs.setInt(_keyLastHeartTimestamp, remainderTimestamp);
      }
      _updateSignature();
    }
  }

  int get secondsUntilNextHeart {
    if (isPremiumUser) return 0;
    _checkAndRefillOfflineHearts();
    final hearts = _safeGetInt(_keyHearts, maxHearts);
    if (hearts >= maxHearts) return 0;

    final lastTimestamp = _prefs.getInt(_keyLastHeartTimestamp);
    if (lastTimestamp == null) return refillIntervalSeconds;

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsedSeconds = (now - lastTimestamp) ~/ 1000;
    return EnergyRules.calculateSecondsUntilNextHeart(hearts, elapsedSeconds);
  }

  Future<bool> consumeHeart() async {
    if (isPremiumUser) return true;
    _checkAndRefillOfflineHearts();
    final hearts = _safeGetInt(_keyHearts, maxHearts);
    if (hearts <= 0) return false;

    final newHearts = hearts - 1;
    await _prefs.setInt(_keyHearts, newHearts);
    if (hearts == maxHearts) {
      await _prefs.setInt(_keyLastHeartTimestamp, DateTime.now().millisecondsSinceEpoch);
    }
    await _updateSignature();
    return true;
  }

  Future<void> addHearts([int count = 1]) async {
    final hearts = _safeGetInt(_keyHearts, maxHearts);
    final newHearts = (hearts + count).clamp(0, maxHearts);
    await _prefs.setInt(_keyHearts, newHearts);
    if (newHearts >= maxHearts) {
      await _prefs.remove(_keyLastHeartTimestamp);
    }
    await _updateSignature();
  }

  Future<void> refillAllHearts() async {
    await _prefs.setInt(_keyHearts, maxHearts);
    await _prefs.remove(_keyLastHeartTimestamp);
    await _updateSignature();
  }

  // --- Preferences & Settings ---
  bool get soundEnabled => _prefs.getBool(_keySound) ?? true;
  Future<void> setSoundEnabled(bool value) async => _prefs.setBool(_keySound, value);

  bool get vibrationEnabled => _prefs.getBool(_keyVibration) ?? true;
  Future<void> setVibrationEnabled(bool value) async => _prefs.setBool(_keyVibration, value);

  bool get personalizedAdsEnabled => _prefs.getBool(_keyPersonalizedAds) ?? true;
  Future<void> setPersonalizedAdsEnabled(bool value) async => _prefs.setBool(_keyPersonalizedAds, value);

  PremiumTier get premiumTier {
    final index = _safeGetInt(_keyPremiumTier, 0);
    return PremiumTier.values[index.clamp(0, PremiumTier.values.length - 1)];
  }

  Future<void> setPremiumTier(PremiumTier tier) async {
    await _prefs.setInt(_keyPremiumTier, tier.index);
    await _updateSignature();
  }

  bool get isPremiumUser =>
      premiumTier == PremiumTier.monthPremium || premiumTier == PremiumTier.lifetimePremium;

  bool get isAdsRemoved =>
      isPremiumUser || premiumTier == PremiumTier.removeAds;

  // --- Reset All Data ---
  Future<void> resetAllData() async {
    await _prefs.clear();
    await _prefs.setInt(_keySchemaVersion, _currentSchemaVersion);
    _isTampered = false;
    await _updateSignature();
  }
}
