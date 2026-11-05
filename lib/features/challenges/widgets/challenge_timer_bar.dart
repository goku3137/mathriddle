import 'package:flutter/material.dart';
import '../../../theme/game_theme.dart';

/// Hardware-accelerated smooth elapsed-time countdown progress bar.
class ChallengeTimerBar extends StatelessWidget {
  final Animation<double> animation;

  const ChallengeTimerBar({
    super.key,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final progress = animation.value.clamp(0.0, 1.0);
        final secondsLeft = (progress * 15).ceil();
        final isCriticalTime = secondsLeft <= 5;
        final timerColor = isCriticalTime ? GameTheme.errorRed : GameTheme.amberAccent;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 5,
              width: double.infinity,
              color: GameTheme.surface,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: timerColor,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: isCriticalTime
                        ? [
                            BoxShadow(
                              color: GameTheme.errorRed.withValues(alpha: 0.5),
                              blurRadius: 4,
                              spreadRadius: 0.5,
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
