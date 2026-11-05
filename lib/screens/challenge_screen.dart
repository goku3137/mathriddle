import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                          'SPEED SPRINT ARENA',
                          style: TextStyle(
                            color: GameTheme.amberAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Select a challenge category to test your speed. Each question has a 15s timer that resets on every correct answer. One wrong answer or timeout ends the run!',
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
              color: category.type == ChallengeType.mixed
                  ? GameTheme.amberAccent.withValues(alpha: 0.6)
                  : GameTheme.borderSubtle,
              width: category.type == ChallengeType.mixed ? 1.4 : 1.0,
            ),
            boxShadow: category.type == ChallengeType.mixed
                ? const [
                    BoxShadow(
                      color: GameTheme.amberGlow,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Icon Avatar: Clean, consistent 24px vector icon with standardized stroke & alignment
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: category.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: category.accentColor.withValues(alpha: 0.4)),
                ),
                child: Center(
                  child: Icon(
                    category.icon,
                    size: 24,
                    color: category.accentColor,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Title, Description & Badges
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                        if (category.type == ChallengeType.mixed) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: GameTheme.amberGlow,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'GRAND SPRINT',
                              style: TextStyle(
                                color: GameTheme.amberAccent,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.description,
                      style: const TextStyle(
                        color: GameTheme.textMuted,
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: GameTheme.surfaceElevated,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: GameTheme.borderSubtle),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.timer_outlined, size: 11, color: GameTheme.amberAccent),
                              SizedBox(width: 4),
                              Text(
                                '15s / Q',
                                style: TextStyle(color: GameTheme.textLight, fontSize: 10, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: category.accentColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '+3 PTS / solve',
                            style: TextStyle(
                              color: category.accentColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
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
