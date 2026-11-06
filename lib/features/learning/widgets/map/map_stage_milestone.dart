import 'package:flutter/material.dart';
import '../../../../theme/game_theme.dart';
import 'map_models.dart';

/// Distinctive milestone banner demarcating stage transitions along the adventure map.
class MapStageMilestone extends StatelessWidget {
  final MapMilestonePosition milestone;

  const MapStageMilestone({super.key, required this.milestone});

  @override
  Widget build(BuildContext context) {
    final isStageDone = milestone.completedInStage == milestone.totalInStage;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: GameTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isStageDone ? GameTheme.successGreen : milestone.accentColor.withValues(alpha: 0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: milestone.accentColor.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Stage Icon Emblem
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: milestone.accentColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: milestone.accentColor.withValues(alpha: 0.5)),
              ),
              child: Icon(milestone.icon, color: milestone.accentColor, size: 24),
            ),
            const SizedBox(width: 12),

            // Stage Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'STAGE ${milestone.stageIndex}',
                        style: TextStyle(
                          color: milestone.accentColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isStageDone
                              ? GameTheme.successGreen.withValues(alpha: 0.2)
                              : GameTheme.surfaceElevated,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          isStageDone ? 'COMPLETED' : '${milestone.completedInStage}/${milestone.totalInStage}',
                          style: TextStyle(
                            color: isStageDone ? GameTheme.successGreen : GameTheme.textMuted,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    milestone.stageName,
                    style: const TextStyle(
                      color: GameTheme.textWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    milestone.subtitle,
                    style: const TextStyle(
                      color: GameTheme.textMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

