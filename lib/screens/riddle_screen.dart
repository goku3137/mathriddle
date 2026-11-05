import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/game_controller.dart';
import '../features/riddles/widgets/level_cleared_modal.dart';
import '../features/riddles/widgets/out_of_hearts_modal.dart';
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
    OutOfHeartsModal.show(context);
  }

  void _showLevelClearedModal() {
    LevelClearedModal.show(context, ref);
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
