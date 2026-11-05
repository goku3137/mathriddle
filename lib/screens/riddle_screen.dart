import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/game_controller.dart';
import '../painters/puzzle_canvas_painter.dart';
import '../services/sound_service.dart';
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
  bool _isSubmitting = false;

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
    if (_isSubmitting) return;
    final gameState = ref.read(gameControllerProvider);
    if (gameState.isSolved) return;
    if (gameState.isOutOfHearts) {
      _showOutOfHeartsModal();
      return;
    }

    _isSubmitting = true;
    try {
      final controller = ref.read(gameControllerProvider.notifier);
      final isCorrect = await controller.validateAnswer();

      if (isCorrect) {
        if (mounted) {
          _showLevelClearedModal();
        }
      } else {
        if (mounted) {
          _shakeController.forward(from: 0.0);
          final updatedState = ref.read(gameControllerProvider);
          if (updatedState.isOutOfHearts) {
            _showOutOfHeartsModal();
          }
        }
      }
    } finally {
      _isSubmitting = false;
    }
  }

  void _showOutOfHeartsModal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: GameTheme.borderSubtle, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Subtle, minimal header with clean heart icon
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: GameTheme.surfaceElevated,
                      shape: BoxShape.circle,
                      border: Border.all(color: GameTheme.borderSubtle),
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      color: Color(0xFFE74C3C),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Out of Hearts',
                    style: TextStyle(
                      color: GameTheme.textWhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Informative, non-aggressive description
              const Text(
                'You need at least 1 heart to submit an answer. 1 heart refills automatically every 20 minutes.',
                style: TextStyle(color: GameTheme.textMuted, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 12),

              // Subtle live countdown timer
              Consumer(
                builder: (context, ref, _) {
                  final timer = ref.watch(gameControllerProvider).formattedHeartTimer;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: GameTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: GameTheme.borderSubtle),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.schedule_rounded, size: 15, color: GameTheme.textMuted),
                        const SizedBox(width: 8),
                        Text(
                          'Next heart in: $timer',
                          style: const TextStyle(
                            color: GameTheme.amberAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 18),

              // Option 1: Watch an Ad to Refill Hearts
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GameTheme.surfaceElevated,
                  foregroundColor: GameTheme.textWhite,
                  side: const BorderSide(color: GameTheme.amberAccent),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  await ref.read(gameControllerProvider.notifier).refillHeartWithAd();
                },
                icon: const Icon(Icons.play_circle_outline_rounded, color: GameTheme.amberAccent, size: 20),
                label: const Text(
                  'Watch an Ad to Refill Hearts',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),

              // Option 2: Buy Premium for Unlimited Hearts
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: GameTheme.textWhite,
                  side: const BorderSide(color: GameTheme.borderSubtle),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ShopScreen()),
                  );
                },
                icon: const Icon(Icons.all_inclusive_rounded, color: GameTheme.amberAccent, size: 20),
                label: const Text(
                  'Buy Premium for Unlimited Hearts',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),

              // Option 3: Wait for Hearts to Refill
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: GameTheme.textMuted,
                  side: const BorderSide(color: GameTheme.borderSubtle),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () => Navigator.of(ctx).pop(),
                icon: const Icon(Icons.hourglass_empty_rounded, color: GameTheme.textMuted, size: 18),
                label: const Text(
                  'Wait for Hearts to Refill',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),

              // Option 4: No Thanks (easy to find, pressure-free dismissal)
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: GameTheme.textDim,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text(
                    'No Thanks',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: GameTheme.textMuted,
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

  void _showLevelClearedModal() {
    final gameState = ref.read(gameControllerProvider);
    final currentLevel = gameState.currentLevel;
    final earned = gameState.lastEarnedPoints;

    ref.read(soundServiceProvider).playLevelComplete();

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
                    ref.read(soundServiceProvider).playTap();
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          // Left: Back button returning to Riddle Grid
          IconButton(
            padding: const EdgeInsets.all(6),
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 18),
            onPressed: () {
              ref.read(soundServiceProvider).playTap();
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(width: 6),

          // Center: LEVEL X indicator with active 5:00 countdown timer formatted as MM:SS
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LEVEL ${gameState.currentLevel.levelNumber}',
                    style: const TextStyle(
                      color: GameTheme.textWhite,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: isLowTime ? GameTheme.errorRed.withValues(alpha: 0.15) : GameTheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isLowTime ? GameTheme.errorRed : GameTheme.borderSubtle,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 13,
                          color: isLowTime ? GameTheme.errorRed : GameTheme.amberAccent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          gameState.formattedTimer,
                          style: TextStyle(
                            color: isLowTime ? GameTheme.errorRed : GameTheme.textLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),

          // Right: Heart Indicator, Score badge & Grid icon button
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeartIndicator(compact: true),
                const SizedBox(width: 4),
                const ScoreBadge(compact: true),
                const SizedBox(width: 2),
                IconButton(
                  padding: const EdgeInsets.all(6),
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.grid_view_rounded, color: GameTheme.textWhite, size: 20),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LevelsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
