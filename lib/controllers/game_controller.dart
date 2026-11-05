import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/game_levels.dart';
import '../models/level_model.dart';
import '../services/monetization_service.dart';
import '../services/progress_service.dart';

class GameState {
  final int activeLevelNumber; // 1 to 20
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
      gameLevels[(activeLevelNumber - 1).clamp(0, gameLevels.length - 1)];

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

final adServiceProvider = Provider<IAdService>((ref) {
  return ProductionAdService();
});

final billingServiceProvider = Provider<IBillingService>((ref) {
  return ProductionBillingService();
});

// Game Controller
class GameController extends Notifier<GameState> {
  ProgressService get _progress => ref.read(progressServiceProvider);
  IAdService get _ads => ref.read(adServiceProvider);
  Timer? _countdownTimer;

  @override
  GameState build() {
    final progress = ref.watch(progressServiceProvider);
    final highestUnlocked = progress.unlockedLevelIndex;
    final initialLevelId = highestUnlocked.clamp(1, gameLevels.length);

    _startTimer();

    ref.onDispose(() {
      _countdownTimer?.cancel();
    });

    return GameState(
      activeLevelNumber: initialLevelId,
      isHintUnlocked: progress.isHintUnlocked(initialLevelId),
      isSolutionUnlocked: progress.isSolutionUnlocked(initialLevelId),
      totalScore: progress.totalScore,
      hearts: progress.currentHearts,
      secondsUntilNextHeart: progress.secondsUntilNextHeart,
      isUnlimitedHearts: progress.isPremiumUser,
    );
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
    state = state.copyWith(
      currentInput: state.currentInput + digit,
      isError: false,
    );
  }

  void clearInput() {
    if (state.isSolved) return;
    state = state.copyWith(
      currentInput: '',
      isError: false,
    );
  }

  int getPointsForLevel(int levelNumber) {
    if (levelNumber <= 10) {
      return 5;
    } else {
      // after each 10 levels, increase by 10
      final tenBlock = (levelNumber - 1) ~/ 10;
      return 5 + (tenBlock * 10);
    }
  }

  Future<bool> validateAnswer() async {
    if (state.currentInput.isEmpty) return false;

    final trimmedInput = state.currentInput.trim();
    final trimmedSolution = state.currentLevel.correctAnswer.trim();
    final isCorrect = trimmedInput == trimmedSolution;

    if (isCorrect) {
      if (_progress.vibrationEnabled) {
        HapticFeedback.heavyImpact();
      }

      final alreadyCompleted = _progress.completedLevelsList.contains(state.currentLevel.levelNumber);
      int earnedPoints = 0;
      if (!alreadyCompleted) {
        earnedPoints = getPointsForLevel(state.currentLevel.levelNumber);
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
        lastEarnedPoints: 50,
      );
    }
    return granted;
  }

  Future<bool> completeChallenge(String challengeId) async {
    final granted = await _progress.markChallengeCompleted(challengeId);
    if (granted) {
      state = state.copyWith(
        totalScore: _progress.totalScore,
        lastEarnedPoints: 3,
      );
    }
    return granted;
  }

  Future<void> addChallengeScore([int points = 3]) async {
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

  void selectLevel(int levelNumber) {
    final targetLevel = levelNumber.clamp(1, gameLevels.length);
    state = GameState(
      activeLevelNumber: targetLevel,
      currentInput: '',
      isError: false,
      isSolved: false,
      isHintUnlocked: _progress.isHintUnlocked(targetLevel),
      isSolutionUnlocked: _progress.isSolutionUnlocked(targetLevel),
      remainingSeconds: 300,
      isTimerActive: true,
      totalScore: _progress.totalScore,
      hearts: _progress.currentHearts,
      secondsUntilNextHeart: _progress.secondsUntilNextHeart,
      isUnlimitedHearts: _progress.isPremiumUser,
    );
  }

  void nextLevel() {
    final nextId = state.currentLevel.levelNumber + 1;
    if (nextId <= gameLevels.length) {
      selectLevel(nextId);
    } else {
      selectLevel(gameLevels.length);
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
