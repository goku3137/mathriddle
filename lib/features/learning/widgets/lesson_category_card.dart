import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/lesson_model.dart';
import '../../../screens/lesson_detail_screen.dart';
import '../../../services/sound_service.dart';
import '../../../theme/game_theme.dart';

/// Clean, pedagogical lesson card displaying title, friendly summary, and clear status.
class LessonCategoryCard extends ConsumerWidget {
  final Lesson lesson;
  final bool isCompleted;
  final bool isLocked;
  final bool isCurrent;

  const LessonCategoryCard({
    super.key,
    required this.lesson,
    required this.isCompleted,
    this.isLocked = false,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color borderColor;
    Color iconBgColor;
    Color iconColor;
    Widget statusBadge;

    if (isCompleted) {
      borderColor = GameTheme.successGreen.withValues(alpha: 0.5);
      iconBgColor = GameTheme.successGreen.withValues(alpha: 0.15);
      iconColor = GameTheme.successGreen;
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: GameTheme.successGreen.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: GameTheme.successGreen.withValues(alpha: 0.4)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_rounded, size: 12, color: GameTheme.successGreen),
            SizedBox(width: 4),
            Text(
              'COMPLETED (+50 PTS)',
              style: TextStyle(
                color: GameTheme.successGreen,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      );
    } else if (isCurrent) {
      borderColor = GameTheme.amberAccent;
      iconBgColor = GameTheme.amberGlow;
      iconColor = GameTheme.amberAccent;
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: GameTheme.amberGlow,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.5)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_arrow_rounded, size: 12, color: GameTheme.amberAccent),
            SizedBox(width: 4),
            Text(
              'NEXT UP (+50 PTS)',
              style: TextStyle(
                color: GameTheme.amberAccent,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      );
    } else {
      borderColor = GameTheme.borderSubtle.withValues(alpha: 0.6);
      iconBgColor = GameTheme.surfaceElevated;
      iconColor = GameTheme.textMuted;
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: GameTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: GameTheme.borderSubtle),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline_rounded, size: 11, color: GameTheme.textMuted),
            SizedBox(width: 4),
            Text(
              'LOCKED',
              style: TextStyle(
                color: GameTheme.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: isLocked ? GameTheme.surface.withValues(alpha: 0.5) : GameTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: isCurrent ? 1.5 : 1.0),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: GameTheme.amberAccent.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            ref.read(soundServiceProvider).playTap();
            if (isLocked) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: GameTheme.surfaceElevated,
                  duration: Duration(seconds: 2),
                  content: Text(
                    'Complete earlier lessons to unlock this topic!',
                    style: TextStyle(color: GameTheme.textWhite, fontSize: 13),
                  ),
                ),
              );
              return;
            }
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => LessonDetailScreen(lesson: lesson),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Category + Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: iconBgColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isLocked ? Icons.lock_rounded : lesson.icon,
                            size: 16,
                            color: iconColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          lesson.category.toUpperCase(),
                          style: TextStyle(
                            color: isLocked ? GameTheme.textMuted : GameTheme.amberAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    statusBadge,
                  ],
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  lesson.title,
                  style: TextStyle(
                    color: isLocked ? GameTheme.textMuted : GameTheme.textWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),

                // Friendly Concept Summary
                Text(
                  lesson.conceptSummary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isLocked ? GameTheme.textDim : GameTheme.textLight,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),

                // Clean Footer Action Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isCompleted
                          ? 'Review Concept'
                          : isCurrent
                              ? 'Start Lesson'
                              : 'Complete previous to unlock',
                      style: TextStyle(
                        color: isCompleted
                            ? GameTheme.successGreen
                            : isCurrent
                                ? GameTheme.amberAccent
                                : GameTheme.textDim,
                        fontSize: 12,
                        fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                      ),
                    ),
                    Icon(
                      isLocked
                          ? Icons.lock_outline_rounded
                          : Icons.arrow_forward_ios_rounded,
                      color: isCompleted
                          ? GameTheme.successGreen
                          : isCurrent
                              ? GameTheme.amberAccent
                              : GameTheme.textDim,
                      size: 13,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
