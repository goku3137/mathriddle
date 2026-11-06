import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../data/challenge_data.dart';
import '../features/challenges/widgets/challenge_feedback_card.dart';
import '../features/challenges/widgets/challenge_question_card.dart';
import '../features/challenges/widgets/challenge_status_bar.dart';
import '../features/challenges/widgets/challenge_timer_bar.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/custom_keypad.dart';
import '../widgets/score_badge.dart';


class ChallengePlayScreen extends ConsumerStatefulWidget {
  final ChallengeCategoryInfo category;
  final ChallengeItem Function(ChallengeType type)? questionGenerator;

  const ChallengePlayScreen({
    super.key,
    required this.category,
    this.questionGenerator,
  });

  @override
  ConsumerState<ChallengePlayScreen> createState() => _ChallengePlayScreenState();
}

class _ChallengePlayScreenState extends ConsumerState<ChallengePlayScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  static const int questionDurationMs = 15000;

  late final AnimationController _timerController;
  DateTime? _questionStartTime;
  Timer? _autoAdvanceTimer;

  int _sessionAttempts = 0;
  int _sessionCorrect = 0;
  int _consecutiveCorrect = 0;
  late int _currentTier; // 0: 1-digit, 1: 2-digit, 2: 3-digit
  String _input = '';
  late ChallengeItem _currentQuestion;
  bool _isShowingPopup = false;
  bool _isSubmitting = false;
  FeedbackOverlayData? _feedbackData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: questionDurationMs),
    )..addStatusListener((status) {
        if ((status == AnimationStatus.dismissed || (status == AnimationStatus.completed && _timerController.value <= 0.01)) && !_isShowingPopup) {
          _handleTimeout();
        }
      });

    final progress = ref.read(progressServiceProvider);
    final stats = progress.getCategoryStats(widget.category.type);
    // Start first-time players at Tier 0 (1-digit), or resume player's saved category tier
    _currentTier = stats.tier.clamp(0, 2);
    _currentQuestion = _getNextQuestion();
    _startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(soundServiceProvider).playChallengeStart();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_isShowingPopup && _questionStartTime != null) {
      // Re-sync countdown accurately with real elapsed time when resuming app
      final elapsed = DateTime.now().difference(_questionStartTime!).inMilliseconds;
      if (elapsed >= questionDurationMs) {
        _timerController.value = 0.0;
        _handleTimeout();
      } else {
        final remainingFraction = (1.0 - (elapsed / questionDurationMs)).clamp(0.0, 1.0);
        _timerController.value = remainingFraction;
        _timerController.reverse(from: remainingFraction);
      }
    } else if (state == AppLifecycleState.paused) {
      _timerController.stop();
    }
  }

  ChallengeItem _getNextQuestion() {
    if (widget.questionGenerator != null) {
      return widget.questionGenerator!(widget.category.type);
    }
    return ChallengeGenerator.generate(widget.category.type, tier: _currentTier);
  }

  /// Starts smooth hardware-accelerated timer driven by elapsed time (no 50Hz periodic setState).
  void _startTimer() {
    if (!mounted || _isShowingPopup) return;
    _questionStartTime = DateTime.now();
    _timerController.stop();
    _timerController.reverse(from: 1.0);
  }

  void _stopTimer() {
    _timerController.stop();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timerController.dispose();
    _autoAdvanceTimer?.cancel();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting || _isShowingPopup) return;
    final trimmed = _input.trim();
    if (trimmed.isEmpty) return;

    _isSubmitting = true;
    try {
      final parsedInput = int.tryParse(trimmed);
      final parsedExpected = int.tryParse(_currentQuestion.answer.trim());
      final isCorrect = (parsedInput != null && parsedExpected != null)
          ? parsedInput == parsedExpected
          : trimmed == _currentQuestion.answer;

      if (isCorrect) {
        // Correct answer!
        ref.read(soundServiceProvider).playCorrect();
        unawaited(HapticFeedback.mediumImpact());

        _sessionAttempts++;
        _sessionCorrect++;
        _consecutiveCorrect++;

        // Persist attempt, streak, and tier independently for this category.
        // Difficulty advances based on cumulative correct answers (every 20) with accuracy check.
        final progress = ref.read(progressServiceProvider);
        final beforeStats = progress.getCategoryStats(widget.category.type);
        final oldBadge = beforeStats.badge;
        final oldTier = beforeStats.tier;

        await progress.recordChallengeAttempt(
          type: widget.category.type,
          isCorrect: true,
          currentStreak: _consecutiveCorrect,
        );

        final afterStats = progress.getCategoryStats(widget.category.type);
        final newBadge = afterStats.badge;
        final bool badgeAdvanced = newBadge.index > oldBadge.index;
        final bool tierAdvanced = afterStats.tier > oldTier;
        if (tierAdvanced) {
          _currentTier = afterStats.tier;
        }

        await ref.read(gameControllerProvider.notifier).completeChallenge(_currentQuestion.id);

        if (mounted) {
          if (badgeAdvanced) {
            ref.read(soundServiceProvider).playReward();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: GameTheme.surfaceElevated,
                duration: const Duration(seconds: 3),
                content: Row(
                  children: [
                    Icon(afterStats.badgeInfo.icon, color: afterStats.badgeInfo.color, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'RANK UNLOCKED: ${afterStats.badgeInfo.title}!',
                            style: TextStyle(
                              color: afterStats.badgeInfo.color,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Text(
                            '${afterStats.correctAnswers} solved in ${widget.category.title}',
                            style: const TextStyle(
                              color: GameTheme.textMuted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (tierAdvanced) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: GameTheme.surfaceElevated,
                duration: const Duration(seconds: 2),
                content: Row(
                  children: [
                    const Icon(Icons.arrow_upward_rounded, color: GameTheme.amberAccent, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Level Up! Introduced ${ChallengeStatusBar.getTierLabel(_currentTier)} Calculations!',
                      style: const TextStyle(color: GameTheme.textWhite, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            );
          }

          setState(() {
            _input = '';
            _currentQuestion = _getNextQuestion();
          });
          _startTimer();
        }
      } else {
        // Incorrect answer: challenge NEVER ends! Show wrong answer popup with calculation explanation.
        unawaited(HapticFeedback.vibrate());
        await _handleWrongAnswer(trimmed);
      }
    } finally {
      _isSubmitting = false;
    }
  }

  Future<void> _handleWrongAnswer(String wrongInput) async {
    if (!mounted || _isShowingPopup) return;
    _stopTimer();
    _isShowingPopup = true;

    _sessionAttempts++;
    _consecutiveCorrect = 0; // Streak resets on wrong answer

    ref.read(soundServiceProvider).playIncorrect();

    // Persist attempt independently for this category
    final progress = ref.read(progressServiceProvider);
    await progress.recordChallengeAttempt(
      type: widget.category.type,
      isCorrect: false,
      currentStreak: 0,
      overrideTier: _currentTier,
    );

    if (!mounted) return;

    // Show compact feedback overlay (no interrupting full-screen dialogs)
    setState(() {
      _feedbackData = FeedbackOverlayData(
        wrongInput: wrongInput,
        correctAnswer: _currentQuestion.answer,
        explanation: _currentQuestion.explanation.isNotEmpty
            ? _currentQuestion.explanation
            : '${_currentQuestion.question.replaceAll(' = ?', '')} = ${_currentQuestion.answer}',
        isTimeout: false,
      );
    });

    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = Timer(const Duration(milliseconds: 1600), () {
      _dismissFeedbackAndContinue();
    });
  }

  Future<void> _handleTimeout() async {
    if (!mounted || _isShowingPopup) return;
    _stopTimer();
    _isShowingPopup = true;

    _sessionAttempts++;
    _consecutiveCorrect = 0; // Streak resets on timeout

    ref.read(soundServiceProvider).playChallengeEnd();
    unawaited(HapticFeedback.vibrate());

    final progress = ref.read(progressServiceProvider);
    await progress.recordChallengeAttempt(
      type: widget.category.type,
      isCorrect: false,
      currentStreak: 0,
      overrideTier: _currentTier,
    );

    if (!mounted) return;

    setState(() {
      _feedbackData = FeedbackOverlayData(
        wrongInput: '',
        correctAnswer: _currentQuestion.answer,
        explanation: _currentQuestion.explanation.isNotEmpty
            ? _currentQuestion.explanation
            : '${_currentQuestion.question.replaceAll(' = ?', '')} = ${_currentQuestion.answer}',
        isTimeout: true,
      );
    });

    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = Timer(const Duration(milliseconds: 1600), () {
      _dismissFeedbackAndContinue();
    });
  }

  void _dismissFeedbackAndContinue() {
    _autoAdvanceTimer?.cancel();
    if (!mounted || _feedbackData == null) return;
    setState(() {
      _feedbackData = null;
      _isShowingPopup = false;
      _input = '';
      _currentQuestion = _getNextQuestion();
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final progressService = ref.watch(progressServiceProvider);
    final stats = progressService.getCategoryStats(widget.category.type);
    final totalAttemptsForCategory = stats.attempts;

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () {
            ref.read(soundServiceProvider).playTap();
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    widget.category.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: GameTheme.textWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: stats.badgeInfo.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: stats.badgeInfo.color.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(stats.badgeInfo.icon, size: 10, color: stats.badgeInfo.color),
                      const SizedBox(width: 3),
                      Text(
                        stats.badgeInfo.title,
                        style: TextStyle(
                          color: stats.badgeInfo.color,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Played $totalAttemptsForCategory ${totalAttemptsForCategory == 1 ? 'time' : 'times'} • Best: ${stats.highestStreak} • ${stats.accuracyPercent}% ACC',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: GameTheme.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: ScoreBadge(compact: true),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Hardware-accelerated smooth elapsed-time countdown bar (driven by VSync AnimationController)
            ChallengeTimerBar(animation: _timerController),
            const SizedBox(height: 8),

            // 2. Progressive Indicators: Current Streak, Tier Badge, and 15s Timer
            ChallengeStatusBar(
              consecutiveCorrect: _consecutiveCorrect,
              currentTier: _currentTier,
              timerController: _timerController,
            ),

            // 3. Question Display Box or Compact Feedback Overlay
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _feedbackData != null
                      ? ChallengeFeedbackCard(
                          data: _feedbackData!,
                          questionText: _currentQuestion.question,
                          onTap: _dismissFeedbackAndContinue,
                        )
                      : ChallengeQuestionCard(
                          questionNumber: _sessionAttempts + 1,
                          sessionSolved: _sessionCorrect,
                          questionText: _currentQuestion.question,
                        ),
                ),
              ),
            ),

            // 4. Keypad & Input Row
            CustomKeypad(
              inputString: _input,
              hasVibration: true,
              onDigitPressed: (d) {
                if (_feedbackData != null) {
                  _dismissFeedbackAndContinue();
                  return;
                }
                if (_input.length < 6) {
                  setState(() => _input += d);
                }
              },
              onClear: () {
                if (_feedbackData != null) {
                  _dismissFeedbackAndContinue();
                  return;
                }
                setState(() => _input = '');
              },
              onHintPressed: () {},
              onSubmit: () {
                if (_feedbackData != null) {
                  _dismissFeedbackAndContinue();
                  return;
                }
                _submit();
              },
            ),
          ],
        ),
      ),
    );
  }

}
