import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/game_controller.dart';
import '../../../screens/levels_screen.dart';
import '../../../services/sound_service.dart';
import '../../../theme/game_theme.dart';

/// Modal celebrating successful level completion, showing solution and navigation to next level.
class LevelClearedModal extends ConsumerWidget {
  const LevelClearedModal({super.key});

  static Future<void> show(BuildContext context, WidgetRef ref) {
    ref.read(soundServiceProvider).playLevelComplete();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const LevelClearedModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.read(gameControllerProvider);
    final currentLevel = gameState.currentLevel;
    final earned = gameState.lastEarnedPoints;

    return Dialog(
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
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: GameTheme.textMuted,
                      side: const BorderSide(color: GameTheme.borderSubtle),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      ref.read(soundServiceProvider).playTap();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LevelsScreen()),
                      );
                    },
                    child: const Text('LEVELS', style: TextStyle(letterSpacing: 1.5)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GameTheme.amberAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      ref.read(soundServiceProvider).playTap();
                      Navigator.of(context).pop();
                      ref.read(gameControllerProvider.notifier).nextLevel();
                    },
                    child: const Text(
                      'NEXT',
                      style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

