import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/game_controller.dart';
import '../painters/puzzle_canvas_painter.dart';
import '../theme/game_theme.dart';
import '../widgets/custom_keypad.dart';
import '../widgets/heart_indicator.dart';
import '../widgets/need_help_modal.dart';
import '../widgets/score_badge.dart';
import 'levels_screen.dart';
import 'shop_screen.dart';

class RiddleScreen extends ConsumerStatefulWidget {
  const RiddleScreen({super.key});

  @override
  ConsumerState<RiddleScreen> createState() => _RiddleScreenState();
}

class _RiddleScreenState extends ConsumerState<RiddleScreen>
    with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    // Error shake controller (350ms duration)
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _shakeController.reset();
          ref.read(gameControllerProvider.notifier).resetError();
        }
      });

    // Idle pulse animation for target node
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final gameState = ref.read(gameControllerProvider);
    if (gameState.isOutOfHearts) {
      _showOutOfHeartsModal();
      return;
    }

    final controller = ref.read(gameControllerProvider.notifier);
    final isCorrect = await controller.validateAnswer();

    if (isCorrect) {
      _showLevelClearedModal();
    } else {
      _shakeController.forward(from: 0.0);
    }
  }

  void _showOutOfHeartsModal() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE74C3C)),
        ),
        title: const Row(
          children: [
            Icon(Icons.favorite_border_rounded, color: Color(0xFFE74C3C)),
            SizedBox(width: 8),
            Text(
              'OUT OF HEARTS!',
              style: TextStyle(color: GameTheme.textWhite, fontWeight: FontWeight.w800, fontSize: 16),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'You need at least 1 heart to submit an answer. 1 heart refills every 20 minutes.',
              style: TextStyle(color: GameTheme.textMuted, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, ref, _) {
                final timer = ref.watch(gameControllerProvider).formattedHeartTimer;
                return Text(
                  'Next heart in: $timer',
                  style: const TextStyle(color: GameTheme.amberAccent, fontWeight: FontWeight.w700),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('WAIT', style: TextStyle(color: GameTheme.textMuted)),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: GameTheme.surfaceElevated,
              foregroundColor: GameTheme.amberAccent,
              side: const BorderSide(color: GameTheme.amberAccent),
            ),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await ref.read(gameControllerProvider.notifier).refillHeartWithAd();
            },
            icon: const Icon(Icons.play_circle_outline_rounded, size: 18),
            label: const Text('WATCH AD (+1 ❤️)'),
          ),
        ],
      ),
    );
  }

  void _showLevelClearedModal() {
    final gameState = ref.read(gameControllerProvider);
    final currentLevel = gameState.currentLevel;
    final earned = gameState.lastEarnedPoints;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: GameTheme.amberAccent, width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: GameTheme.amberGlow,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: GameTheme.amberAccent,
                  size: 42,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'CORRECT!',
                style: TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.0,
                ),
              ),
              if (earned > 0) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: GameTheme.surfaceElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.6)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.stars_rounded, color: GameTheme.amberAccent, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '+$earned PTS EARNED!',
                        style: const TextStyle(
                          color: GameTheme.amberAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Text(
                currentLevel.solution,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: GameTheme.textMuted,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // Immediate "Next" button progression
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GameTheme.amberAccent,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    ref.read(gameControllerProvider.notifier).nextLevel();
                  },
                  child: const Text(
                    'NEXT LEVEL',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openNeedHelpModal() {
    final controller = ref.read(gameControllerProvider.notifier);
    controller.pauseTimer();

    final gameState = ref.read(gameControllerProvider);

    showDialog(
      context: context,
      builder: (ctx) => NeedHelpModal(
        level: gameState.currentLevel,
        isHintUnlocked: gameState.isHintUnlocked,
        isSolutionUnlocked: gameState.isSolutionUnlocked,
        onWatchAdForHint: () async {
          controller.resumeTimer();
          await controller.unlockHintWithAd();
        },
        onWatchAdForSolution: () async {
          controller.resumeTimer();
          await controller.unlockSolutionWithAd();
        },
        onOpenShop: () {
          controller.resumeTimer();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ShopScreen()),
          );
        },
      ),
    ).then((_) {
      controller.resumeTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameControllerProvider);
    final progress = ref.watch(progressServiceProvider);
    final controller = ref.read(gameControllerProvider.notifier);

    return Scaffold(
      backgroundColor: GameTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Header Bar: Back, LEVEL X + 5:00 Timer, Grid Shortcut
            _buildTopHeader(context, gameState),

            // 2. Center Puzzle Canvas Stage
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: AnimatedBuilder(
                      animation: Listenable.merge([_shakeController, _pulseController]),
                      builder: (context, child) {
                        final shakeVal = math.sin(_shakeController.value * math.pi * 4) * 10.0;
                        final pulseVal = 1.0 + (_pulseController.value * 0.05);

                        return CustomPaint(
                          painter: PuzzleCanvasPainter(
                            level: gameState.currentLevel,
                            currentInput: gameState.currentInput,
                            shakeOffset: shakeVal,
                            isError: gameState.isError,
                            pulseScale: pulseVal,
                          ),
                          child: const SizedBox.expand(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // 3. Bottom Inbuilt Numeric Keypad with Live Input & Bulb
            CustomKeypad(
              inputString: gameState.currentInput,
              hasVibration: progress.vibrationEnabled,
              onDigitPressed: (digit) => controller.appendDigit(digit),
              onClear: () => controller.clearInput(),
              onHintPressed: _openNeedHelpModal,
              onSubmit: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context, GameState gameState) {
    final isLowTime = gameState.remainingSeconds < 60;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Back button returning to Riddle Grid
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),

          // Center: LEVEL X indicator with active 5:00 countdown timer formatted as MM:SS
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'LEVEL ${gameState.currentLevel.levelNumber}',
                style: const TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isLowTime ? GameTheme.errorRed.withValues(alpha: 0.15) : GameTheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isLowTime ? GameTheme.errorRed : GameTheme.borderSubtle,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: isLowTime ? GameTheme.errorRed : GameTheme.amberAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      gameState.formattedTimer,
                      style: TextStyle(
                        color: isLowTime ? GameTheme.errorRed : GameTheme.textLight,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Right: Heart Indicator, Score badge & Grid icon button
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeartIndicator(compact: true),
              const SizedBox(width: 4),
              const ScoreBadge(compact: true),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.grid_view_rounded, color: GameTheme.textWhite, size: 22),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LevelsScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
