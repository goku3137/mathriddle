import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/game_controller.dart';
import '../../../screens/levels_screen.dart';
import '../../../services/sound_service.dart';
import '../../../theme/game_theme.dart';

/// Modal celebrating successful level completion with Smart Auto-Advance (Option 1).
/// Shows solution, earned points, animated countdown, and auto-advances to the next level.
/// Players can tap anywhere or press NEXT to skip the countdown immediately.
class LevelClearedModal extends ConsumerStatefulWidget {
  const LevelClearedModal({super.key});

  static Future<void> show(BuildContext context, WidgetRef ref) {
    ref.read(soundServiceProvider).playLevelComplete();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const LevelClearedModal(),
    );
  }

  @override
  ConsumerState<LevelClearedModal> createState() => _LevelClearedModalState();
}

class _LevelClearedModalState extends ConsumerState<LevelClearedModal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _countdownController;
  bool _hasHandled = false;

  @override
  void initState() {
    super.initState();
    final gameState = ref.read(gameControllerProvider);
    final totalLevels = ref.read(levelRepositoryProvider).totalLevelsCount;
    final isFinalLevel = gameState.currentLevel.levelNumber >= totalLevels;

    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    if (!isFinalLevel) {
      _countdownController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _advance();
        }
      });
      _countdownController.forward();
    }
  }

  @override
  void dispose() {
    _countdownController.dispose();
    super.dispose();
  }

  void _advance() {
    if (_hasHandled || !mounted) return;
    _hasHandled = true;
    _countdownController.stop();

    final gameState = ref.read(gameControllerProvider);
    final totalLevels = ref.read(levelRepositoryProvider).totalLevelsCount;
    final isFinalLevel = gameState.currentLevel.levelNumber >= totalLevels;

    final nav = Navigator.of(context);
    if (nav.canPop()) {
      nav.pop();
    }
    if (isFinalLevel) {
      nav.pushReplacement(
        MaterialPageRoute(builder: (_) => const LevelsScreen()),
      );
    } else {
      ref.read(gameControllerProvider.notifier).nextLevel();
    }
  }

  void _goToLevels() {
    if (_hasHandled || !mounted) return;
    _hasHandled = true;
    _countdownController.stop();

    final nav = Navigator.of(context);
    if (nav.canPop()) {
      nav.pop();
    }
    nav.push(
      MaterialPageRoute(builder: (_) => const LevelsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.read(gameControllerProvider);
    final currentLevel = gameState.currentLevel;
    final earned = gameState.lastEarnedPoints;
    final totalLevels = ref.read(levelRepositoryProvider).totalLevelsCount;
    final isFinalLevel = currentLevel.levelNumber >= totalLevels;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!_hasHandled) {
          _advance();
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _advance, // Tapping backdrop skips countdown immediately
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _advance, // Tapping card skips countdown immediately
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                color: GameTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: GameTheme.amberAccent, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: GameTheme.amberAccent.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Celebration Badge
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
                  const SizedBox(height: 12),
                  // Solution text
                  Text(
                    currentLevel.solution,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: GameTheme.textMuted,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Actions: [ LEVELS ] and [ NEXT (auto) ]
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: GameTheme.textMuted,
                            side: const BorderSide(color: GameTheme.borderSubtle),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            ref.read(soundServiceProvider).playTap();
                            _goToLevels();
                          },
                          child: const Text('LEVELS', style: TextStyle(letterSpacing: 1.5)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: AnimatedBuilder(
                          animation: _countdownController,
                          builder: (context, child) {
                            final secondsLeft = isFinalLevel
                                ? 0
                                : ((1.0 - _countdownController.value) * 2.0).ceil();
                            final label = isFinalLevel
                                ? 'COMPLETE'
                                : (secondsLeft > 0 ? 'NEXT (${secondsLeft}s)' : 'NEXT');

                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: GameTheme.amberAccent,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                ref.read(soundServiceProvider).playTap();
                                _advance();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    label,
                                    style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1.5),
                                  ),
                                  if (!isFinalLevel) ...[
                                    const SizedBox(width: 4),
                                    const Icon(Icons.arrow_forward_rounded, size: 16),
                                  ],
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  if (!isFinalLevel) ...[
                    const SizedBox(height: 12),
                    // Auto-advance linear progress indicator
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: AnimatedBuilder(
                        animation: _countdownController,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _countdownController.value,
                            backgroundColor: GameTheme.surfaceElevated,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              GameTheme.amberAccent.withValues(alpha: 0.6),
                            ),
                            minHeight: 3,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Auto-advancing... tap anywhere to skip',
                      style: TextStyle(
                        color: GameTheme.textDim,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
