import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/game_controller.dart';
import '../../../screens/shop_screen.dart';
import '../../../theme/game_theme.dart';

/// Modal displayed when player has 0 hearts and attempts to submit an answer.
class OutOfHeartsModal extends StatelessWidget {
  const OutOfHeartsModal({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const OutOfHeartsModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            Consumer(
              builder: (context, ref, _) {
                return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GameTheme.surfaceElevated,
                    foregroundColor: GameTheme.textWhite,
                    side: const BorderSide(color: GameTheme.amberAccent),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await ref.read(gameControllerProvider.notifier).refillHeartWithAd();
                  },
                  icon: const Icon(Icons.play_circle_outline_rounded, color: GameTheme.amberAccent, size: 20),
                  label: const Text(
                    'Watch an Ad to Refill Hearts',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                );
              },
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
                Navigator.of(context).pop();
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
              onPressed: () => Navigator.of(context).pop(),
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
                onPressed: () => Navigator.of(context).pop(),
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
    );
  }
}
