import 'package:flutter/material.dart';
import '../../../theme/game_theme.dart';

/// Status indicator bar in Challenge Mode showing current streak,
/// progressive difficulty tier, and remaining time chip.
class ChallengeStatusBar extends StatelessWidget {
  final int consecutiveCorrect;
  final int currentTier;
  final AnimationController timerController;

  const ChallengeStatusBar({
    super.key,
    required this.consecutiveCorrect,
    required this.currentTier,
    required this.timerController,
  });

  static String getTierLabel(int tier) {
    switch (tier) {
      case 0:
        return '1-Digit';
      case 1:
        return '2-Digit';
      case 2:
      default:
        return '3-Digit';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Current Streak
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: GameTheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: GameTheme.borderSubtle),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bolt_rounded, color: GameTheme.amberAccent, size: 16),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'STREAK: $consecutiveCorrect',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: GameTheme.amberAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Progressive Difficulty Tier Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: GameTheme.surfaceElevated,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: GameTheme.borderSubtle),
            ),
            child: Text(
              getTierLabel(currentTier),
              style: const TextStyle(
                color: GameTheme.textLight,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Remaining Seconds indicator
          AnimatedBuilder(
            animation: timerController,
            builder: (context, _) {
              final secondsLeft = (timerController.value * 15).ceil();
              final isUrgent = secondsLeft <= 4;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isUrgent ? GameTheme.errorRed.withValues(alpha: 0.15) : GameTheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isUrgent ? GameTheme.errorRed : GameTheme.borderSubtle,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: isUrgent ? GameTheme.errorRed : GameTheme.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${secondsLeft}s',
                      style: TextStyle(
                        color: isUrgent ? GameTheme.errorRed : GameTheme.textWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
