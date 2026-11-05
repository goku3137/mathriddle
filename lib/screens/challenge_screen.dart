import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/challenge_data.dart';
import '../features/challenges/widgets/challenge_category_card.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/score_badge.dart';

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
                          'Continuous smart progression: starts with 1-digit calculations and scales to 2-digit and 3-digit after every 20 cumulative solved answers. Runs continue indefinitely with instant feedback on incorrect answers.',
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

            // Challenge Cards in Strict Order
            for (final category in challengeCategories) ...[
              ChallengeCategoryCard(category: category),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
