import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../theme/game_theme.dart';
import '../widgets/score_badge.dart';

class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressServiceProvider);
    final completedTopics = progress.completedLearnTopics;

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'LEARN',
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            _buildConceptCard(
              topicId: 'topic_pemdas',
              title: '1. Order of Operations (PEMDAS / BODMAS)',
              subtitle: 'Precedence rule in algebraic equations',
              formula: 'Parentheses → Exponents → Multiplication/Division → Addition/Subtraction',
              walkthrough: 'Example: 2 + 2 × 2 = ?\nMultiplication is evaluated before addition: 2 × 2 = 4, then 2 + 4 = 6.',
              icon: Icons.functions_rounded,
              isCompleted: completedTopics.contains('topic_pemdas'),
              onComplete: () {
                ref.read(gameControllerProvider.notifier).completeLearnTopic('topic_pemdas');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Concept mastered! +50 PTS added to score.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: GameTheme.surfaceElevated,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildConceptCard(
              topicId: 'topic_triangles',
              title: '2. Vertex Multiplier Triangles',
              subtitle: 'Geometric core interaction formulas',
              formula: 'Center = (Top × Bottom Left) + Bottom Right',
              walkthrough: 'Example: Top=3, Left=5, Right=2 → (3 × 5) + 2 = 17.\nVertices frequently relate via multiplication paired with base addition or division.',
              icon: Icons.change_history_rounded,
              isCompleted: completedTopics.contains('topic_triangles'),
              onComplete: () {
                ref.read(gameControllerProvider.notifier).completeLearnTopic('topic_triangles');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Concept mastered! +50 PTS added to score.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: GameTheme.surfaceElevated,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildConceptCard(
              topicId: 'topic_grid_magic',
              title: '3. Magic Grid Sequence Transformations',
              subtitle: 'Row and column mathematical properties',
              formula: 'Row_k = [n¹, n², n³] or Row_Sum = 15',
              walkthrough: 'Example: Row 1 = [2, 4, 8]. Row 2 = [3, 9, 27]. Row 3 = [4, 16, 64].\nInspect rows horizontally for power or multiplier relations.',
              icon: Icons.grid_3x3_rounded,
              isCompleted: completedTopics.contains('topic_grid_magic'),
              onComplete: () {
                ref.read(gameControllerProvider.notifier).completeLearnTopic('topic_grid_magic');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Concept mastered! +50 PTS added to score.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: GameTheme.surfaceElevated,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildConceptCard(
              topicId: 'topic_intersecting_regions',
              title: '4. Intersecting Geometric Regions',
              subtitle: 'Averages and shared intersection values',
              formula: 'Center = (Left + Right) / 2',
              walkthrough: 'Example: Left=14, Right=22 → Center = (14 + 22) / 2 = 18.\nIntersections commonly symbolize arithmetic or geometric means.',
              icon: Icons.donut_large_rounded,
              isCompleted: completedTopics.contains('topic_intersecting_regions'),
              onComplete: () {
                ref.read(gameControllerProvider.notifier).completeLearnTopic('topic_intersecting_regions');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Concept mastered! +50 PTS added to score.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: GameTheme.surfaceElevated,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptCard({
    required String topicId,
    required String title,
    required String subtitle,
    required String formula,
    required String walkthrough,
    required IconData icon,
    required bool isCompleted,
    required VoidCallback onComplete,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCompleted
              ? GameTheme.successGreen.withValues(alpha: 0.5)
              : GameTheme.borderSubtle,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? GameTheme.successGreen.withValues(alpha: 0.15)
                      : GameTheme.amberGlow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isCompleted ? Icons.check_circle_rounded : icon,
                  color: isCompleted ? GameTheme.successGreen : GameTheme.amberAccent,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: GameTheme.textWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(color: GameTheme.textMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: GameTheme.surfaceElevated,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.3)),
            ),
            child: Text(
              formula,
              style: const TextStyle(
                color: GameTheme.amberAccent,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            walkthrough,
            style: const TextStyle(
              color: GameTheme.textLight,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: GameTheme.successGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: GameTheme.successGreen.withValues(alpha: 0.5)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_rounded, color: GameTheme.successGreen, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'COMPLETED (+50 PTS)',
                        style: TextStyle(
                          color: GameTheme.successGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                )
              else
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: GameTheme.amberAccent, width: 1.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  onPressed: onComplete,
                  icon: const Icon(Icons.stars_rounded, color: GameTheme.amberAccent, size: 16),
                  label: const Text(
                    'CLAIM +50 PTS',
                    style: TextStyle(
                      color: GameTheme.amberAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
