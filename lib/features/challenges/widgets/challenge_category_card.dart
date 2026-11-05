import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/game_controller.dart';
import '../../../screens/challenge_play_screen.dart';
import '../../../services/sound_service.dart';
import '../../../theme/game_theme.dart';
import '../models/challenge_badge.dart';
import '../models/challenge_models.dart';

/// Reusable category card displaying category details, current badge, and progress bar.
class ChallengeCategoryCard extends ConsumerWidget {
  final ChallengeCategoryInfo category;

  const ChallengeCategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressServiceProvider);
    final stats = progress.getCategoryStats(category.type);
    final badgeInfo = stats.badgeInfo;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          ref.read(soundServiceProvider).playTap();
          HapticFeedback.lightImpact();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChallengePlayScreen(category: category),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: GameTheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: GameTheme.borderSubtle,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              // Icon Avatar: Clean neutral surface & icon (Consistent across all categories)
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: GameTheme.surfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: GameTheme.borderSubtle),
                ),
                child: Center(
                  child: Icon(
                    category.icon,
                    size: 22,
                    color: GameTheme.textLight,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Title, Description & Badges
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Category name + achievement badge
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        Text(
                          category.title,
                          style: const TextStyle(
                            color: GameTheme.textWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                        // Shared achievement color badge (Only achievement rank changes color)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: badgeInfo.color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: badgeInfo.color.withValues(alpha: 0.4)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(badgeInfo.icon, size: 11, color: badgeInfo.color),
                              const SizedBox(width: 3),
                              Text(
                                badgeInfo.title,
                                style: TextStyle(
                                  color: badgeInfo.color,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // 2. Short description
                    Text(
                      category.description,
                      style: const TextStyle(
                        color: GameTheme.textMuted,
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 3. Clean stats row: ONLY Played count and Accuracy
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: GameTheme.surfaceElevated,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Played ${stats.attempts} ${stats.attempts == 1 ? 'time' : 'times'}',
                            style: const TextStyle(
                              color: GameTheme.textLight,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${stats.accuracy.toStringAsFixed(0)}% acc',
                          style: TextStyle(
                            color: stats.accuracy >= 80
                                ? GameTheme.amberAccent
                                : GameTheme.textMuted,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // 4. Progress bar + next badge target
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ChallengeBadgeTier.getProgressText(stats.correctAnswers),
                              style: const TextStyle(
                                color: GameTheme.textMuted,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${(ChallengeBadgeTier.getProgressFraction(stats.correctAnswers) * 100).toInt()}%',
                              style: TextStyle(
                                color: badgeInfo.color,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: ChallengeBadgeTier.getProgressFraction(stats.correctAnswers),
                            backgroundColor: GameTheme.surfaceElevated,
                            valueColor: AlwaysStoppedAnimation<Color>(badgeInfo.color),
                            minHeight: 4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: GameTheme.textDim,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
