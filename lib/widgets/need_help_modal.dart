import 'package:flutter/material.dart';
import '../models/level_model.dart';
import '../theme/game_theme.dart';

class NeedHelpModal extends StatelessWidget {
  final LevelData level;
  final bool isHintUnlocked;
  final bool isSolutionUnlocked;
  final VoidCallback onWatchAdForHint;
  final VoidCallback onWatchAdForSolution;
  final VoidCallback onOpenShop;

  const NeedHelpModal({
    super.key,
    required this.level,
    required this.isHintUnlocked,
    required this.isSolutionUnlocked,
    required this.onWatchAdForHint,
    required this.onWatchAdForSolution,
    required this.onOpenShop,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: GameTheme.modalSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Modal Title: Need Help?
            const Center(
              child: Text(
                'Need Help?',
                style: TextStyle(
                  color: GameTheme.modalTextDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Hint Reveal Card (if unlocked)
            if (isHintUnlocked) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),
                ),
                child: Text(
                  'HINT: ${level.hint}',
                  style: const TextStyle(
                    color: GameTheme.modalTextDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ),
            ],

            // Solution Reveal Card (if unlocked)
            if (isSolutionUnlocked) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: GameTheme.amberAccent),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SOLUTION:',
                      style: TextStyle(
                        color: GameTheme.amberAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${level.solution}\nAnswer: ${level.correctAnswer}',
                      style: const TextStyle(
                        color: GameTheme.modalTextDark,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Option 1: Watch Ad for Hint
            _buildDarkButton(
              icon: Icons.movie_outlined,
              label: isHintUnlocked ? 'Hint Unlocked' : 'Watch Ad for Hint',
              onPressed: isHintUnlocked
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      onWatchAdForHint();
                    },
            ),
            const SizedBox(height: 10),

            // Option 2: Watch Ad for Solution OR Be Premium
            _buildDarkButton(
              icon: Icons.workspace_premium_outlined,
              label: isSolutionUnlocked
                  ? 'Solution Unlocked'
                  : 'Watch Ad for Solution OR Be Premium',
              isAccent: true,
              onPressed: isSolutionUnlocked
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      onWatchAdForSolution();
                    },
            ),
            const SizedBox(height: 14),

            // Subtle dismiss option: No thanks
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'No thanks',
                  style: TextStyle(
                    color: GameTheme.modalTextMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkButton({
    required IconData icon,
    required String label,
    VoidCallback? onPressed,
    bool isAccent = false,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isAccent ? GameTheme.amberAccent : GameTheme.modalButtonDark,
        foregroundColor: isAccent ? Colors.black87 : Colors.white,
        disabledBackgroundColor: Colors.black12,
        disabledForegroundColor: Colors.black38,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isAccent ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
