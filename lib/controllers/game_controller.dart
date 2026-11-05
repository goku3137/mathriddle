import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/game_levels.dart';
import '../domain/scoring_rules.dart';
import '../models/level_model.dart';
import '../repositories/level_repository.dart';
import '../services/monetization_service.dart';
import '../services/progress_service.dart';
import '../services/security_service.dart';

class GameState {
  final int activeLevelNumber;
  final LevelData? loadedLevel;
  final String currentInput;
  final bool isError;
  final bool isSolved;
  final bool isHintUnlocked;
  final bool isSolutionUnlocked;
  final int remainingSeconds; // 5-minute countdown (300s)
  final bool isTimerActive;
  final int totalScore;
  final int lastEarnedPoints;
  final int hearts;
  final int secondsUntilNextHeart;
  final bool isUnlimitedHearts;

  const GameState({
    required this.activeLevelNumber,
    this.loadedLevel,
    this.currentInput = '',
    this.isError = false,
    this.isSolved = false,
    this.isHintUnlocked = false,
    this.isSolutionUnlocked = false,
    this.remainingSeconds = 300,
    this.isTimerActive = true,
    this.totalScore = 0,
    this.lastEarnedPoints = 0,
    this.hearts = 5,
    this.secondsUntilNextHeart = 0,
    this.isUnlimitedHearts = false,
  });

  LevelData get currentLevel =>
      loadedLevel ??
      (activeLevelNumber <= gameLevels.length
          ? gameLevels[activeLevelNumber - 1]
          : gameLevels.first);

  String get formattedTimer {
    final m = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get formattedHeartTimer {
    final m = (secondsUntilNextHeart ~/ 60).toString().padLeft(2, '0');
    final s = (secondsUntilNextHeart % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  bool get isOutOfHearts => !isUnlimitedHearts && hearts <= 0;

  GameState copyWith({
    int? activeLevelNumber,
    LevelData? loadedLevel,
    String? currentInput,
    bool? isError,
    bool? isSolved,
    bool? isHintUnlocked,
    bool? isSolutionUnlocked,
    int? remainingSeconds,
    bool? isTimerActive,
    int? totalScore,
    int? lastEarnedPoints,
    int? hearts,
    int? secondsUntilNextHeart,
    bool? isUnlimitedHearts,
  }) {
    return GameState(
      activeLevelNumber: activeLevelNumber ?? this.activeLevelNumber,
      loadedLevel: loadedLevel ?? this.loadedLevel,
      currentInput: currentInput ?? this.currentInput,
      isError: isError ?? this.isError,
      isSolved: isSolved ?? this.isSolved,
      isHintUnlocked: isHintUnlocked ?? this.isHintUnlocked,
      isSolutionUnlocked: isSolutionUnlocked ?? this.isSolutionUnlocked,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isTimerActive: isTimerActive ?? this.isTimerActive,
      totalScore: totalScore ?? this.totalScore,
      lastEarnedPoints: lastEarnedPoints ?? this.lastEarnedPoints,
      hearts: hearts ?? this.hearts,
      secondsUntilNextHeart: secondsUntilNextHeart ?? this.secondsUntilNextHeart,
      isUnlimitedHearts: isUnlimitedHearts ?? this.isUnlimitedHearts,
    );
  }
}

// Providers
final progressServiceProvider = Provider<ProgressService>((ref) {
  throw UnimplementedError('ProgressService must be initialized in main()');
});

final levelRepositoryProvider = Provider<ILevelRepository>((ref) {
  return ScalableLevelRepository(totalLevels: 500);
});

final adServiceProvider = Provider<IAdService>((ref) {
  return ProductionAdService();
});

final billingServiceProvider = Provider<IBillingService>((ref) {
  return ProductionBillingService();
});

// Game Controller
class GameController extends Notifier<GameState> with WidgetsBindingObserver {
  ProgressService get _progress => ref.read(progressServiceProvider);
  ILevelRepository get _levelRepo => ref.read(levelRepositoryProvider);
  IAdService get _ads => ref.read(adServiceProvider);

  Timer? _countdownTimer;
  bool _isValidating = false;

  @override
  GameState build() {
    final progress = ref.watch(progressServiceProvider);
    final levelRepo = ref.watch(levelRepositoryProvider);
    final highestUnlocked = progress.unlockedLevelIndex;
    final initialLevelId = highestUnlocked.clamp(1, levelRepo.totalLevelsCount);

    WidgetsBinding.instance.addObserver(this);
    _startTimer();

    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
      _countdownTimer?.cancel();
    });

    final initialLevel = levelRepo.getLevelSync(initialLevelId);

    return GameState(
      activeLevelNumber: initialLevelId,
      loadedLevel: initialLevel,
      isHintUnlocked: progress.isHintUnlocked(initialLevelId),
      isSolutionUnlocked: progress.isSolutionUnlocked(initialLevelId),
      totalScore: progress.totalScore,
      hearts: progress.currentHearts,
      secondsUntilNextHeart: progress.secondsUntilNextHeart,
      isUnlimitedHearts: progress.isPremiumUser,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      pauseTimer();
    } else if (state == AppLifecycleState.resumed) {
      if (!this.state.isSolved) {
        resumeTimer();
      }
      // Re-synchronize offline hearts immediately on foreground resume
      this.state = this.state.copyWith(
        hearts: _progress.currentHearts,
        secondsUntilNextHeart: _progress.secondsUntilNextHeart,
      );
    }
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int newRemaining = state.remainingSeconds;
      if (state.isTimerActive && state.remainingSeconds > 0 && !state.isSolved) {
        newRemaining = state.remainingSeconds - 1;
      }

      state = state.copyWith(
        remainingSeconds: newRemaining,
        hearts: _progress.currentHearts,
        secondsUntilNextHeart: _progress.secondsUntilNextHeart,
      );
    });
  }

  void pauseTimer() {
    state = state.copyWith(isTimerActive: false);
  }

  void resumeTimer() {
    state = state.copyWith(isTimerActive: true);
  }

  void resetTimer() {
    state = state.copyWith(remainingSeconds: 300, isTimerActive: true);
  }

  void appendDigit(String digit) {
    if (state.isSolved) return;
    if (state.currentInput.length >= 6) return;

    final sanitized = SecurityService.sanitizeNumericInput(state.currentInput + digit);
    if (sanitized.isNotEmpty && sanitized.length <= 6) {
      state = state.copyWith(
        currentInput: sanitized,
        isError: false,
      );
    }
  }

  void clearInput() {
    if (state.isSolved) return;
    state = state.copyWith(
      currentInput: '',
      isError: false,
    );
  }

  int getPointsForLevel(int levelNumber) {
    return ScoringRules.pointsForRiddleLevel(levelNumber);
  }

  /// Validates answer with mutex lock to prevent concurrent double-submissions
  Future<bool> validateAnswer() async {
    if (_isValidating) return false;
    if (state.currentInput.isEmpty) return false;

    _isValidating = true;
    try {
      final sanitizedInput = SecurityService.sanitizeNumericInput(state.currentInput);
      if (sanitizedInput.isEmpty) {
        state = state.copyWith(isError: true);
        return false;
      }

      final trimmedSolution = state.currentLevel.correctAnswer.trim();
      final isCorrect = sanitizedInput == trimmedSolution;

      if (isCorrect) {
        if (_progress.vibrationEnabled) {
          HapticFeedback.heavyImpact();
        }

        final alreadyCompleted = _progress.completedLevelsList.contains(state.currentLevel.levelNumber);
        int earnedPoints = 0;
        if (!alreadyCompleted) {
          earnedPoints = ScoringRules.pointsForRiddleLevel(state.currentLevel.levelNumber);
          await _progress.addScore(earnedPoints);
        }

        await _progress.markLevelCompleted(state.currentLevel.levelNumber);

        // Trigger periodic interstitial ad
        if (!_progress.isAdsRemoved) {
          await _ads.showInterstitialAd();
        }

        state = state.copyWith(
          isSolved: true,
          isError: false,
          isTimerActive: false,
          totalScore: _progress.totalScore,
          lastEarnedPoints: earnedPoints,
        );
        return true;
      } else {
        if (_progress.vibrationEnabled) {
          HapticFeedback.vibrate();
        }
        // Consume 1 heart on incorrect answer
        await _progress.consumeHeart();
        state = state.copyWith(
          isError: true,
          hearts: _progress.currentHearts,
          secondsUntilNextHeart: _progress.secondsUntilNextHeart,
        );
        return false;
      }
    } finally {
      _isValidating = false;
    }
  }

  Future<void> refillHeartWithAd() async {
    await _ads.showRewardedAd(
      onRewardEarned: () async {
        await _progress.addHearts(1);
        state = state.copyWith(
          hearts: _progress.currentHearts,
          secondsUntilNextHeart: _progress.secondsUntilNextHeart,
        );
      },
    );
  }

  Future<void> refillAllHearts() async {
    await _progress.refillAllHearts();
    state = state.copyWith(
      hearts: _progress.currentHearts,
      secondsUntilNextHeart: 0,
    );
  }

  Future<bool> completeLearnTopic(String topicId) async {
    final granted = await _progress.markLearnTopicCompleted(topicId);
    if (granted) {
      state = state.copyWith(
        totalScore: _progress.totalScore,
        lastEarnedPoints: ScoringRules.pointsPerLearnLesson,
      );
    }
    return granted;
  }

  Future<bool> completeChallenge(String challengeId) async {
    final granted = await _progress.markChallengeCompleted(challengeId);
    if (granted) {
      state = state.copyWith(
        totalScore: _progress.totalScore,
        lastEarnedPoints: ScoringRules.pointsPerChallenge,
      );
    }
    return granted;
  }

  Future<void> addChallengeScore([int points = ScoringRules.pointsPerChallenge]) async {
    await _progress.addScore(points);
    state = state.copyWith(
      totalScore: _progress.totalScore,
      lastEarnedPoints: points,
    );
  }

  void refreshScore() {
    state = state.copyWith(totalScore: _progress.totalScore);
  }

  void resetError() {
    state = state.copyWith(isError: false, currentInput: '');
  }

  Future<void> selectLevel(int levelNumber) async {
    final clampedLevel = levelNumber.clamp(1, _levelRepo.totalLevelsCount);
    final levelData = await _levelRepo.getLevel(clampedLevel);

    state = GameState(
      activeLevelNumber: clampedLevel,
      loadedLevel: levelData,
      currentInput: '',
      isError: false,
      isSolved: false,
      isHintUnlocked: _progress.isHintUnlocked(clampedLevel),
      isSolutionUnlocked: _progress.isSolutionUnlocked(clampedLevel),
      remainingSeconds: 300,
      isTimerActive: true,
      totalScore: _progress.totalScore,
      hearts: _progress.currentHearts,
      secondsUntilNextHeart: _progress.secondsUntilNextHeart,
      isUnlimitedHearts: _progress.isPremiumUser,
    );
  }

  Future<void> nextLevel() async {
    final nextId = state.currentLevel.levelNumber + 1;
    if (nextId <= _levelRepo.totalLevelsCount) {
      await selectLevel(nextId);
    } else {
      await selectLevel(_levelRepo.totalLevelsCount);
    }
  }

  Future<void> unlockHintWithAd() async {
    await _ads.showRewardedAd(
      onRewardEarned: () async {
        await _progress.unlockHint(state.currentLevel.levelNumber);
        state = state.copyWith(isHintUnlocked: true);
      },
    );
  }

  Future<void> unlockSolutionWithAd() async {
    await _ads.showRewardedAd(
      onRewardEarned: () async {
        await _progress.unlockSolution(state.currentLevel.levelNumber);
        state = state.copyWith(isSolutionUnlocked: true);
      },
    );
  }
}

final gameControllerProvider =
    NotifierProvider<GameController, GameState>(GameController.new);
