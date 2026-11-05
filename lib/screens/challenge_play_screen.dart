import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../data/challenge_data.dart';
import '../domain/scoring_rules.dart';
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

class _ChallengePlayScreenState extends ConsumerState<ChallengePlayScreen> {
  static const int questionDurationMs = 15000;
  static const int timerTickMs = 20; // 50 updates per second for silky smooth continuous motion

  int _remainingMs = questionDurationMs;
  Timer? _timer;
  int _sessionPoints = 0;
  int _solvedCount = 0;
  String _input = '';
  late ChallengeItem _currentQuestion;
  bool _isGameOver = false;

  @override
  void initState() {
    super.initState();
    _currentQuestion = _getNextQuestion();
    _resetTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(soundServiceProvider).playChallengeStart();
      }
    });
  }

  ChallengeItem _getNextQuestion() {
    if (widget.questionGenerator != null) {
      return widget.questionGenerator!(widget.category.type);
    }
    return ChallengeGenerator.generate(widget.category.type);
  }

  /// Resets countdown timer smoothly to 15 seconds for every new question.
  void _resetTimer() {
    _timer?.cancel();
    if (!mounted) return;
    setState(() => _remainingMs = questionDurationMs);

    _timer = Timer.periodic(const Duration(milliseconds: timerTickMs), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remainingMs > timerTickMs) {
        setState(() => _remainingMs -= timerTickMs);
      } else {
        timer.cancel();
        setState(() => _remainingMs = 0);
        _handleGameOver(isTimeOut: true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isGameOver) return;
    final trimmed = _input.trim();
    if (trimmed.isEmpty) return;

    if (trimmed == _currentQuestion.answer) {
      // Correct answer!
      ref.read(soundServiceProvider).playCorrect();
      unawaited(HapticFeedback.mediumImpact());
      final wasNew = await ref.read(gameControllerProvider.notifier).completeChallenge(_currentQuestion.id);
      if (mounted) {
        setState(() {
          if (wasNew) {
            _sessionPoints += ScoringRules.pointsPerChallenge;
          }
          _solvedCount++;
          _input = '';
          _currentQuestion = _getNextQuestion();
        });
        // Automatically smoothly reset 15-second timer for the new question!
        _resetTimer();
      }
    } else {
      // Incorrect answer ends challenge immediately!
      unawaited(HapticFeedback.vibrate());
      _handleGameOver(isTimeOut: false, wrongInput: trimmed);
    }
  }

  void _handleGameOver({required bool isTimeOut, String? wrongInput}) {
    if (!mounted || _isGameOver) return;
    _timer?.cancel();
    ref.read(soundServiceProvider).playChallengeEnd();
    setState(() => _isGameOver = true);

    final totalScore = ref.read(gameControllerProvider).totalScore;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isTimeOut ? GameTheme.errorRed : widget.category.accentColor,
            width: 1.5,
          ),
        ),
        title: Text(
          isTimeOut ? "TIME'S UP!" : 'INCORRECT ANSWER!',
          style: TextStyle(
            color: isTimeOut ? GameTheme.errorRed : GameTheme.textWhite,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (isTimeOut ? GameTheme.errorRed : widget.category.accentColor).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isTimeOut ? Icons.timer_off_rounded : Icons.close_rounded,
                color: isTimeOut ? GameTheme.errorRed : widget.category.accentColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              '+$_sessionPoints PTS EARNED',
              style: TextStyle(
                color: widget.category.accentColor,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Streak: $_solvedCount questions solved',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: GameTheme.textLight,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: GameTheme.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: GameTheme.borderSubtle),
              ),
              child: Column(
                children: [
                  if (!isTimeOut && wrongInput != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Your Input:', style: TextStyle(color: GameTheme.textMuted, fontSize: 12)),
                        Text(
                          wrongInput,
                          style: const TextStyle(
                            color: GameTheme.errorRed,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Correct Answer:', style: TextStyle(color: GameTheme.textMuted, fontSize: 12)),
                      Text(
                        _currentQuestion.answer,
                        style: const TextStyle(
                          color: GameTheme.successGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Total Score: $totalScore PTS',
              style: const TextStyle(
                color: GameTheme.textLight,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: GameTheme.borderSubtle),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pop(); // Back to hub
                  },
                  child: const Text('ALL MODES', style: TextStyle(color: GameTheme.textLight, fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.category.accentColor,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    setState(() {
                      _isGameOver = false;
                      _sessionPoints = 0;
                      _solvedCount = 0;
                      _input = '';
                      _currentQuestion = _getNextQuestion();
                    });
                    _resetTimer();
                  },
                  child: const Text('TRY AGAIN', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_remainingMs / questionDurationMs).clamp(0.0, 1.0);
    final secondsLeft = (_remainingMs / 1000).ceil();
    final isCriticalTime = secondsLeft <= 5;
    final timerColor = isCriticalTime ? GameTheme.errorRed : widget.category.accentColor;

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.category.title,
          style: const TextStyle(
            color: GameTheme.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
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
            // Silky smooth 50Hz continuous fluid countdown bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  height: 5,
                  width: double.infinity,
                  color: GameTheme.surface,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: constraints.maxWidth * progress,
                          height: 5,
                          decoration: BoxDecoration(
                            color: timerColor,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: isCriticalTime
                                ? [
                                    BoxShadow(
                                      color: GameTheme.errorRed.withValues(alpha: 0.5),
                                      blurRadius: 4,
                                      spreadRadius: 0.5,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Top Bar: Session Streak & 15s Timer Badge
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: GameTheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: GameTheme.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.bolt_rounded, color: widget.category.accentColor, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          'STREAK: $_solvedCount (+3/ea)',
                          style: TextStyle(
                            color: widget.category.accentColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isCriticalTime
                          ? GameTheme.errorRed.withValues(alpha: 0.15)
                          : GameTheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isCriticalTime ? GameTheme.errorRed : GameTheme.borderSubtle,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 16,
                          color: isCriticalTime ? GameTheme.errorRed : GameTheme.amberAccent,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${secondsLeft}s',
                          style: TextStyle(
                            color: isCriticalTime ? GameTheme.errorRed : GameTheme.textWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Question Display Box
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
                    decoration: BoxDecoration(
                      color: GameTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isCriticalTime ? GameTheme.errorRed.withValues(alpha: 0.5) : GameTheme.borderSubtle,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'QUESTION ${_solvedCount + 1}',
                          style: const TextStyle(
                            color: GameTheme.textMuted,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _currentQuestion.question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: GameTheme.textWhite,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Keypad & Input Row
            CustomKeypad(
              inputString: _input,
              hasVibration: true,
              onDigitPressed: (d) {
                if (_input.length < 6) {
                  setState(() => _input += d);
                }
              },
              onClear: () => setState(() => _input = ''),
              onHintPressed: () {},
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
