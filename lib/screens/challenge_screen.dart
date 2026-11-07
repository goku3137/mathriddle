import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/challenge_data.dart';
import '../features/challenges/widgets/challenge_category_card.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/score_badge.dart';

class ChallengeScreen extends ConsumerWidget {
  const ChallengeScreen({super.key});

  void _showInfoDialog(BuildContext context, WidgetRef ref) {
    ref.read(soundServiceProvider).playTap();
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: GameTheme.borderSubtle, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: GameTheme.amberGlow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.bolt_rounded, color: GameTheme.amberAccent, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'HOW CHALLENGES WORK',
                      style: TextStyle(
                        color: GameTheme.textWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _buildInfoRow(
                icon: Icons.timer_outlined,
                title: '15-Second Rounds',
                desc: 'Race against the clock to solve as many questions as you can.',
              ),
              const SizedBox(height: 14),
              _buildInfoRow(
                icon: Icons.trending_up_rounded,
                title: 'Smart Progression',
                desc: 'Questions scale from 1-digit to 2-digit and 3-digit as your accuracy increases.',
              ),
              const SizedBox(height: 14),
              _buildInfoRow(
                icon: Icons.all_inclusive_rounded,
                title: 'Endless Practice',
                desc: 'Never kicks you out. Instant solution feedback on mistakes so you can learn and keep going.',
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GameTheme.amberAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text(
                    'GOT IT',
                    style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1.2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: GameTheme.amberAccent, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  color: GameTheme.textMuted,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: GameTheme.textMuted, size: 22),
            tooltip: 'How it works',
            onPressed: () => _showInfoDialog(context, ref),
          ),
          const Padding(
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
            // Minimal Section Header
            Row(
              children: [
                const Icon(Icons.bolt_rounded, color: GameTheme.amberAccent, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'CHALLENGE CATEGORIES',
                  style: TextStyle(
                    color: GameTheme.amberAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
                const Spacer(),
                Text(
                  '${challengeCategories.length} Modes',
                  style: const TextStyle(
                    color: GameTheme.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

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
