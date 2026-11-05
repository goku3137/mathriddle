import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../data/challenge_data.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/score_badge.dart';
import 'challenge_play_screen.dart';

class ChallengeScreen extends ConsumerWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () {
            ref.read(soundServiceProvider).playTap();
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'CHALLENGES',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.0,
          ),
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
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Hero Header
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: GameTheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: GameTheme.amberGlow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.bolt_rounded, color: GameTheme.amberAccent, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SMART PROGRESSIVE ARENA',
                          style: TextStyle(
                            color: GameTheme.amberAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Continuous smart progression: starts with 1-digit calculations and scales to 2-digit and 3-digit every 20 streak. Runs continue indefinitely with instant feedback on incorrect answers.',
                          style: TextStyle(
                            color: GameTheme.textLight,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section Label
            const Row(
              children: [
                Icon(Icons.category_rounded, color: GameTheme.amberAccent, size: 16),
                SizedBox(width: 8),
                Text(
                  'SELECT CHALLENGE CATEGORY',
                  style: TextStyle(
                    color: GameTheme.amberAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // The 5 Challenge Cards in Strict Order:
            // 1. Addition (+)
            // 2. Subtraction (-)
            // 3. Multiplication (×)
            // 4. Division (÷)
            // 5. All Mixed (Combined)
            for (final category in challengeCategories) ...[
              _buildChallengeCard(context, ref, category),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(BuildContext context, WidgetRef ref, ChallengeCategoryInfo category) {
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
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: GameTheme.borderSubtle),
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
                        if (stats.attempts > 0) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: GameTheme.surfaceElevated,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: GameTheme.borderSubtle),
                            ),
                            child: Text(
                              '${stats.accuracyPercent}% ACC',
                              style: const TextStyle(
                                color: GameTheme.textMuted,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 10),

                    // 4. Progress bar + next badge target
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Container(
                            height: 4,
                            width: double.infinity,
                            color: GameTheme.surfaceElevated,
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: stats.badgeProgress,
                              child: Container(
                                color: badgeInfo.color,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            stats.badgeProgressText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: badgeInfo.color,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Arrow Button
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: GameTheme.surfaceElevated,
                  shape: BoxShape.circle,
                  border: Border.all(color: GameTheme.borderSubtle),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: GameTheme.textLight,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
