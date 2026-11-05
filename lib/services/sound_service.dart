import 'dart:async';
import 'dart:io' show Platform;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import 'progress_service.dart';

/// Supported acoustic sound effect types in SMATH.
enum SoundType {
  tap,
  correct,
  incorrect,
  levelComplete,
  heartLost,
  reward,
  challengeStart,
  challengeEnd,
  hintUnlocked,
}

/// Abstract contract for sound effects across SMATH.
abstract class ISoundService {
  void play(SoundType type);
  void playTap();
  void playCorrect();
  void playIncorrect();
  void playLevelComplete();
  void playHeartLost();
  void playReward();
  void playChallengeStart();
  void playChallengeEnd();
  void playHintUnlocked();
  void setVolume(double volume);
  void setEnabled(bool enabled);
  void dispose();
}

/// Production implementation using low-latency pooled AudioPlayers.
/// Features intelligent anti-overlap debouncing, volume scaling, and mute safeguards.
class ProductionSoundService implements ISoundService {
  final ProgressService _progress;
  final AudioPlayer Function()? _playerFactory;

  // Dedicated players to prevent acoustic clipping and overlaps
  AudioPlayer? _effectPlayer;
  AudioPlayer? _tapPlayer;
  bool _initAttempted = false;

  // Anti-overlap timestamps per sound type (in milliseconds)
  final Map<SoundType, int> _lastPlayedMs = {};

  // Debounce thresholds: prevents accidental double-playback or audio stuttering
  static const Map<SoundType, int> _debounceThresholds = {
    SoundType.tap: 45,
    SoundType.correct: 180,
    SoundType.incorrect: 180,
    SoundType.levelComplete: 300,
    SoundType.heartLost: 200,
    SoundType.reward: 180,
    SoundType.challengeStart: 250,
    SoundType.challengeEnd: 250,
    SoundType.hintUnlocked: 200,
  };

  // Acoustic master calibration factors for optimal subtle volume
  static const Map<SoundType, double> _relativeGains = {
    SoundType.tap: 0.40,
    SoundType.correct: 0.65,
    SoundType.incorrect: 0.60,
    SoundType.levelComplete: 0.75,
    SoundType.heartLost: 0.55,
    SoundType.reward: 0.65,
    SoundType.challengeStart: 0.65,
    SoundType.challengeEnd: 0.60,
    SoundType.hintUnlocked: 0.60,
  };

  ProductionSoundService(this._progress, [this._playerFactory]);

  /// Expose debounce threshold for testing and inspection
  static int debounceThreshold(SoundType type) => _debounceThresholds[type] ?? 100;

  /// Expose calibrated acoustic gain factor for testing and calibration
  static double gainFor(SoundType type) => _relativeGains[type] ?? 0.5;

  /// Expose last played timestamp for debouncing inspection
  int? lastPlayedTimestamp(SoundType type) => _lastPlayedMs[type];

  void _ensureInitialized() {
    if (_initAttempted) return;
    _initAttempted = true;
    try {
      final factory = _playerFactory ?? () => AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
      _effectPlayer = factory();
      _tapPlayer = factory();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ProductionSoundService: AudioPlayer initialization suppressed: $e');
      }
    }
  }

  String _assetPath(SoundType type) {
    switch (type) {
      case SoundType.tap:
        return 'sounds/tap.wav';
      case SoundType.correct:
        return 'sounds/correct.wav';
      case SoundType.incorrect:
        return 'sounds/incorrect.wav';
      case SoundType.levelComplete:
        return 'sounds/level_complete.wav';
      case SoundType.heartLost:
        return 'sounds/heart_lost.wav';
      case SoundType.reward:
        return 'sounds/reward.wav';
      case SoundType.challengeStart:
        return 'sounds/challenge_start.wav';
      case SoundType.challengeEnd:
        return 'sounds/challenge_end.wav';
      case SoundType.hintUnlocked:
        return 'sounds/hint_unlocked.wav';
    }
  }

  @override
  void play(SoundType type) {
    // 1. Mute guard
    if (!_progress.soundEnabled) return;

    final volumeSetting = _progress.soundVolume;
    if (volumeSetting <= 0.0) return;

    // 2. Anti-overlap & debouncing guard
    final now = DateTime.now().millisecondsSinceEpoch;
    final lastTime = _lastPlayedMs[type] ?? 0;
    final threshold = _debounceThresholds[type] ?? 100;
    if (now - lastTime < threshold) return;
    _lastPlayedMs[type] = now;

    // 3. Compute calibrated playback volume
    final gain = _relativeGains[type] ?? 0.5;
    final finalVolume = (volumeSetting * gain).clamp(0.0, 1.0);

    // 4. Safe playback with error interception to prevent crashes
    unawaited(() async {
      try {
        _ensureInitialized();
        final path = _assetPath(type);
        if (type == SoundType.tap) {
          final player = _tapPlayer;
          if (player != null) {
            await player.stop();
            await player.setVolume(finalVolume);
            await player.play(AssetSource(path));
          }
        } else {
          final player = _effectPlayer;
          if (player != null) {
            await player.stop();
            await player.setVolume(finalVolume);
            await player.play(AssetSource(path));
          }
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Audio playback suppressed: $e');
        }
      }
    }());
  }

  @override
  void playTap() => play(SoundType.tap);

  @override
  void playCorrect() => play(SoundType.correct);

  @override
  void playIncorrect() => play(SoundType.incorrect);

  @override
  void playLevelComplete() => play(SoundType.levelComplete);

  @override
  void playHeartLost() => play(SoundType.heartLost);

  @override
  void playReward() => play(SoundType.reward);

  @override
  void playChallengeStart() => play(SoundType.challengeStart);

  @override
  void playChallengeEnd() => play(SoundType.challengeEnd);

  @override
  void playHintUnlocked() => play(SoundType.hintUnlocked);

  @override
  void setVolume(double volume) {
    _progress.setSoundVolume(volume);
  }

  @override
  void setEnabled(bool enabled) {
    _progress.setSoundEnabled(enabled);
  }

  @override
  void dispose() {
    try {
      _effectPlayer?.dispose();
      _tapPlayer?.dispose();
    } catch (_) {}
  }
}

/// In-memory mock sound service for unit & widget testing.
class MockSoundService implements ISoundService {
  final List<SoundType> playedSounds = [];
  bool enabled = true;
  double volume = 0.8;

  @override
  void play(SoundType type) {
    if (!enabled || volume <= 0.0) return;
    playedSounds.add(type);
  }

  @override
  void playTap() => play(SoundType.tap);

  @override
  void playCorrect() => play(SoundType.correct);

  @override
  void playIncorrect() => play(SoundType.incorrect);

  @override
  void playLevelComplete() => play(SoundType.levelComplete);

  @override
  void playHeartLost() => play(SoundType.heartLost);

  @override
  void playReward() => play(SoundType.reward);

  @override
  void playChallengeStart() => play(SoundType.challengeStart);

  @override
  void playChallengeEnd() => play(SoundType.challengeEnd);

  @override
  void playHintUnlocked() => play(SoundType.hintUnlocked);

  @override
  void setVolume(double volume) {
    this.volume = volume;
  }

  @override
  void setEnabled(bool enabled) {
    this.enabled = enabled;
  }

  @override
  void dispose() {}
}

/// Global provider for sound service across SMATH.
final soundServiceProvider = Provider<ISoundService>((ref) {
  final progress = ref.watch(progressServiceProvider);
  if (!kIsWeb && Platform.environment.containsKey('FLUTTER_TEST')) {
    return MockSoundService();
  }
  final service = ProductionSoundService(progress);
  ref.onDispose(service.dispose);
  return service;
});
