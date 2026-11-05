import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/game_theme.dart';
import '../widgets/custom_keypad.dart';

class DailyChallengesScreen extends StatefulWidget {
  const DailyChallengesScreen({super.key});

  @override
  State<DailyChallengesScreen> createState() => _DailyChallengesScreenState();
}

class _DailyChallengesScreenState extends State<DailyChallengesScreen> {
  int _secondsLeft = 300;
  Timer? _timer;
  String _input = '';
  int _step = 0;
  bool _isCompleted = false;

  final List<Map<String, String>> _dailyPool = [
    {
      'q': '3 × 3 + 3 × 3 = ?',
      'a': '18',
      'hint': 'Multiplications first: 9 + 9.',
    },
    {
      'q': '10² - 8² = ?',
      'a': '36',
      'hint': '100 - 64 = 36 (6²).',
    },
    {
      'q': '4, 12, 36, ?',
      'a': '108',
      'hint': 'Multiply previous number by 3.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0 && !_isCompleted) {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _submit() {
    if (_isCompleted) return;
    final current = _dailyPool[_step];
    if (_input == current['a']) {
      if (_step < _dailyPool.length - 1) {
        setState(() {
          _step++;
          _input = '';
        });
      } else {
        setState(() {
          _isCompleted = true;
          _input = '';
        });
      }
    } else {
      setState(() => _input = '');
    }
  }

  String get _formattedTime {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
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
          'DAILY CHALLENGES',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w300,
            letterSpacing: 3.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Challenge Progress & Timer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CHALLENGE ${_step + 1} / ${_dailyPool.length}',
                    style: const TextStyle(
                      color: GameTheme.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: GameTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: GameTheme.borderDivider),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.timer_outlined, color: GameTheme.primaryOrange, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          _formattedTime,
                          style: const TextStyle(
                            color: GameTheme.textWhite,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Stage
            Expanded(
              child: Center(
                child: _isCompleted
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.workspace_premium_rounded, color: GameTheme.primaryOrange, size: 54),
                          const SizedBox(height: 16),
                          const Text(
                            'DAILY COMPLETE!',
                            style: TextStyle(
                              color: GameTheme.textWhite,
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 3.0,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Come back tomorrow for new geometric logic puzzles.',
                            style: TextStyle(color: GameTheme.textMuted, fontSize: 13),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GameTheme.primaryOrange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('BACK TO HOME'),
                          ),
                        ],
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
                        decoration: BoxDecoration(
                          color: GameTheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: GameTheme.borderDivider),
                        ),
                        child: Text(
                          _dailyPool[_step]['q']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: GameTheme.textWhite,
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
              ),
            ),

            if (!_isCompleted)
              CustomKeypad(
                inputString: _input,
                onDigitPressed: (digit) {
                  if (_input.length < 5) setState(() => _input += digit);
                },
                onClear: () => setState(() => _input = ''),
                onHintPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Hint: ${_dailyPool[_step]['hint']}')),
                  );
                },
                onSubmit: _submit,
              ),
          ],
        ),
      ),
    );
  }
}

