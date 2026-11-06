import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/sound_service.dart';
import '../../../services/store_service.dart';
import '../../../theme/game_theme.dart';

/// Rating dialog prompting the player to support Math Riddles on Google Play Store.
class RateAppDialog extends ConsumerWidget {
  const RateAppDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => const RateAppDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: GameTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: GameTheme.borderSubtle),
      ),
      title: const Text(
        'Enjoying Math Riddle?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: GameTheme.textWhite,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: const Text(
        'Your review helps us craft more mathematical riddles and logic puzzles.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: GameTheme.textMuted,
          fontSize: 13,
          height: 1.4,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('LATER', style: TextStyle(color: GameTheme.textMuted)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: GameTheme.amberAccent,
            foregroundColor: Colors.black87,
          ),
          onPressed: () async {
            ref.read(soundServiceProvider).playTap();
            Navigator.of(context).pop();
            await StoreService.openPlayStoreReview();
          },
          child: const Text('RATE APP', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

