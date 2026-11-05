import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../data/challenge_data.dart';
import '../theme/game_theme.dart';
import '../widgets/custom_keypad.dart';
import '../widgets/score_badge.dart';

class ChallengePlayScreen extends ConsumerStatefulWidget {
  final ChallengeCategoryInfo category;

  const ChallengePlayScreen({
    super.key,
    required this.category,
  });

  @override
  ConsumerState<ChallengePlayScreen> createState() => _ChallengePlayScreenState();
}

class _ChallengePlayScreenState extends ConsumerState<ChallengePlayScreen> {
  int _secondsLeft = 60;
  Timer? _timer;
  int _sessionPoints = 0;
  int _solvedCount = 0;
  String _input = '';
  int _problemIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _timer?.cancel();
        _showGameOverModal();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _submit() async {
    final items = widget.category.items;
    final problem = items[_problemIndex % items.length];
    if (_input.trim() == problem.answer) {
      HapticFeedback.mediumImpact();
      final wasNew = await ref.read(gameControllerProvider.notifier).completeChallenge(problem.id);
      if (mounted) {
        setState(() {
          if (wasNew) {
            _sessionPoints += 3;
          }
          _solvedCount++;
          _input = '';
          _problemIndex++;
        });
      }
    } else {
      HapticFeedback.vibrate();
      if (mounted) {
        setState(() {
          _input = '';
        });
      }
    }
  }

  void _showGameOverModal() {
    if (!mounted) return;
    final totalScore = ref.read(gameControllerProvider).totalScore;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: widget.category.accentColor, width: 1.5),
        ),
        title: const Text(
          'TIME IS UP!',
          style: TextStyle(color: GameTheme.textWhite, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt_rounded, color: widget.category.accentColor, size: 48),
            const SizedBox(height: 12),
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
              'Solved $_solvedCount ${widget.category.title.toLowerCase()} (+3 PTS each)',
              textAlign: TextAlign.center,
              style: const TextStyle(color: GameTheme.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Score: $totalScore PTS',
              style: const TextStyle(
                color: GameTheme.textWhite,
                fontSize: 14,
                fontWeight: FontWeight.w600,
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
                    side: BorderSide(color: GameTheme.borderSubtle),
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
                      _secondsLeft = 60;
                      _sessionPoints = 0;
                      _solvedCount = 0;
                      _input = '';
                      _problemIndex = 0;
                    });
                    _startTimer();
                  },
                  child: const Text('RETRY', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
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
    final items = widget.category.items;
    final problem = items[_problemIndex % items.length];

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
            // Top Bar: Session Points & Timer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                        Icon(Icons.stars_rounded, color: widget.category.accentColor, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '+$_sessionPoints PTS (+3/ea)',
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
                      color: _secondsLeft < 15
                          ? GameTheme.errorRed.withValues(alpha: 0.15)
                          : GameTheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _secondsLeft < 15 ? GameTheme.errorRed : GameTheme.borderSubtle,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 16,
                          color: _secondsLeft < 15 ? GameTheme.errorRed : GameTheme.amberAccent,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_secondsLeft}s',
                          style: TextStyle(
                            color: _secondsLeft < 15 ? GameTheme.errorRed : GameTheme.textWhite,
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
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    decoration: BoxDecoration(
                      color: GameTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: GameTheme.borderSubtle),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Question ${_problemIndex + 1}',
                          style: const TextStyle(
                            color: GameTheme.textMuted,
                            fontSize: 14,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          problem.question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: GameTheme.textWhite,
                            fontSize: 30,
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
