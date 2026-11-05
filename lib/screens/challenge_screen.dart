import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../theme/game_theme.dart';
import '../widgets/custom_keypad.dart';
import '../widgets/score_badge.dart';

class ChallengeScreen extends ConsumerStatefulWidget {
  const ChallengeScreen({super.key});

  @override
  ConsumerState<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends ConsumerState<ChallengeScreen> {
  int _secondsLeft = 60;
  Timer? _timer;
  int _sessionPoints = 0;
  int _solvedCount = 0;
  String _input = '';
  int _problemIndex = 0;

  final List<Map<String, String>> _challenges = [
    {'id': 'c1', 'q': '7 × 8 - 6 = ?', 'a': '50'},
    {'id': 'c2', 'q': '3² + 4² = ?', 'a': '25'},
    {'id': 'c3', 'q': '4, 9, 16, 25, ?', 'a': '36'},
    {'id': 'c4', 'q': '100 / 4 + 17 = ?', 'a': '42'},
    {'id': 'c5', 'q': '2, 6, 18, 54, ?', 'a': '162'},
    {'id': 'c6', 'q': '12 × 12 - 44 = ?', 'a': '100'},
    {'id': 'c7', 'q': '15 + 25 × 2 = ?', 'a': '65'},
    {'id': 'c8', 'q': '9² - 9 = ?', 'a': '72'},
    {'id': 'c9', 'q': '2³ + 3² = ?', 'a': '17'},
    {'id': 'c10', 'q': '50% of 140 = ?', 'a': '70'},
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    final problem = _challenges[_problemIndex % _challenges.length];
    if (_input.trim() == problem['a']) {
      HapticFeedback.mediumImpact();
      // Each challenge awards 3 points only once per completion
      final wasNew = await ref.read(gameControllerProvider.notifier).completeChallenge(problem['id']!);
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
      setState(() {
        _input = '';
      });
    }
  }

  void _showGameOverModal() {
    final totalScore = ref.read(gameControllerProvider).totalScore;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: GameTheme.amberAccent),
        ),
        title: const Text(
          'TIME IS UP!',
          style: TextStyle(color: GameTheme.textWhite, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bolt_rounded, color: GameTheme.amberAccent, size: 48),
            const SizedBox(height: 12),
            Text(
              '+$_sessionPoints PTS EARNED',
              style: const TextStyle(
                color: GameTheme.amberAccent,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Solved $_solvedCount challenges (+3 PTS each)',
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: GameTheme.amberAccent,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('BACK TO MENU', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final problem = _challenges[_problemIndex % _challenges.length];

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'CHALLENGE',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.0,
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
                        const Icon(Icons.stars_rounded, color: GameTheme.amberAccent, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '+$_sessionPoints PTS (+3/ea)',
                          style: const TextStyle(
                            color: GameTheme.amberAccent,
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
                          problem['q']!,
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
