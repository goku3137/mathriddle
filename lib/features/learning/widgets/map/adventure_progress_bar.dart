import 'package:flutter/material.dart';
import '../../../../theme/game_theme.dart';

/// Floating adventure progress header displaying stage name, concepts mastered, points, and linear bar.
class AdventureProgressBar extends StatelessWidget {
  final int totalCompleted;
  final int totalLessons;
  final int pointsEarned;
  final String currentStageName;
  final VoidCallback? onJumpToCurrent;

  const AdventureProgressBar({
    super.key,
    required this.totalCompleted,
    required this.totalLessons,
    required this.pointsEarned,
    required this.currentStageName,
    this.onJumpToCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final progressFraction = totalLessons > 0 ? (totalCompleted / totalLessons) : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: GameTheme.surface.withValues(alpha: 0.95),
        border: const Border(
          bottom: BorderSide(color: GameTheme.borderSubtle, width: 1.0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentStageName.toUpperCase(),
                      style: const TextStyle(
                        color: GameTheme.amberAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$totalCompleted of $totalLessons Concepts Mastered',
                      style: const TextStyle(
                        color: GameTheme.textWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: GameTheme.amberGlow,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      '+$pointsEarned PTS',
                      style: const TextStyle(
                        color: GameTheme.amberAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  if (onJumpToCurrent != null) ...[
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.my_location_rounded, color: GameTheme.amberAccent, size: 20),
                      tooltip: 'Jump to Next Lesson',
                      onPressed: onJumpToCurrent,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progressFraction,
              minHeight: 5,
              backgroundColor: GameTheme.surfaceElevated,
              valueColor: const AlwaysStoppedAnimation<Color>(GameTheme.amberAccent),
            ),
          ),
        ],
      ),
    );
  }
}

