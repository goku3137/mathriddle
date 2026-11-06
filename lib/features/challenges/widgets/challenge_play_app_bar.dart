import 'package:flutter/material.dart';
import '../../../data/challenge_data.dart';
import '../../../services/progress_service.dart';
import '../../../theme/game_theme.dart';
import '../../../widgets/score_badge.dart';

/// App bar for the challenge play screen showing category title, rank badge, and stats.
class ChallengePlayAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChallengeCategoryInfo category;
  final CategoryStats stats;
  final VoidCallback onBack;

  const ChallengePlayAppBar({
    super.key,
    required this.category,
    required this.stats,
    required this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final totalAttempts = stats.attempts;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
        onPressed: onBack,
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  category.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: GameTheme.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: stats.badgeInfo.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: stats.badgeInfo.color.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(stats.badgeInfo.icon, size: 10, color: stats.badgeInfo.color),
                    const SizedBox(width: 3),
                    Text(
                      stats.badgeInfo.title,
                      style: TextStyle(
                        color: stats.badgeInfo.color,
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
          const SizedBox(height: 2),
          Text(
            'Played $totalAttempts ${totalAttempts == 1 ? 'time' : 'times'} • Best: ${stats.highestStreak} • ${stats.accuracyPercent}% ACC',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: GameTheme.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Center(
            child: ScoreBadge(compact: true),
          ),
        ),
      ],
    );
  }
}
