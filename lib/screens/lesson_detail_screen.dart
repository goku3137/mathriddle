import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../features/learning/widgets/lesson_deep_insights.dart';
import '../features/learning/widgets/lesson_graded_examples.dart';
import '../features/learning/widgets/lesson_pillars_card.dart';
import '../features/learning/widgets/lesson_practice_test_card.dart';
import '../models/lesson_model.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/interactive_lesson_sandbox.dart';
import '../widgets/score_badge.dart';
import 'riddle_screen.dart';

/// Detailed educational lesson view presenting interactive concepts,
/// progressive worked examples, deep insights, and interactive knowledge checks.
class LessonDetailScreen extends ConsumerWidget {
  final Lesson lesson;

  const LessonDetailScreen({
    super.key,
    required this.lesson,
  });

  void _navigateToLevel(BuildContext context, WidgetRef ref, int levelNumber) async {
    await ref.read(gameControllerProvider.notifier).selectLevel(levelNumber);
    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const RiddleScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Selectively watch score and completion status to minimize unnecessary rebuilds
    final progress = ref.watch(progressServiceProvider);
    final isAlreadyCompleted = progress.isLearnTopicCompleted(lesson.id);

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
        title: Text(
          lesson.category.toUpperCase(),
          style: const TextStyle(
            color: GameTheme.textWhite,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // 1. Header Banner
            _buildHeaderBanner(isAlreadyCompleted),
            const SizedBox(height: 18),

            // 2. Concept Summary
            Text(
              lesson.conceptSummary,
              style: const TextStyle(
                color: GameTheme.textLight,
                fontSize: 14,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18),

            // 3. Formula Highlight Card
            _buildFormulaCard(),
            const SizedBox(height: 22),

            // 4. The Four Pillars of Mathematical Mastery
            _buildSectionHeader('THE FOUR PILLARS OF MASTERY', Icons.account_balance_rounded),
            const SizedBox(height: 10),
            LessonPillarsCard(lesson: lesson),
            const SizedBox(height: 22),

            // 5. Real-Time Interactive Demonstration Sandbox
            InteractiveLessonSandbox(demoType: lesson.sandboxType),
            const SizedBox(height: 22),

            // 6. Step-by-Step Educational Explanation
            _buildSectionHeader('STEP-BY-STEP REASONING', Icons.menu_book_rounded),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: GameTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: GameTheme.borderSubtle),
              ),
              child: Text(
                lesson.stepByStepExplanation,
                style: const TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 22),

            // 7. Worked Walkthrough (Multiple Graded Examples: Easy to Challenging)
            _buildSectionHeader('WORKED WALKTHROUGH', Icons.psychology_alt_rounded),
            const SizedBox(height: 10),
            LessonGradedExamples(lesson: lesson),
            const SizedBox(height: 22),

            // 8. Deep Insights: Common Mistakes, Shortcuts & Alternative Methods
            _buildSectionHeader('COMMON TRAPS & PRO SHORTCUTS', Icons.tips_and_updates_rounded),
            const SizedBox(height: 10),
            LessonDeepInsights(lesson: lesson),
            const SizedBox(height: 24),

            // 9. Linked Game Levels Section
            _buildSectionHeader('APPLIED IN GAME LEVELS', Icons.play_arrow_rounded),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: lesson.linkedLevels.map((lvl) {
                final isUnlocked = lvl <= progress.unlockedLevelIndex;
                return ActionChip(
                  backgroundColor: isUnlocked ? GameTheme.surface : GameTheme.surfaceElevated,
                  side: BorderSide(
                    color: isUnlocked ? GameTheme.amberAccent.withValues(alpha: 0.5) : GameTheme.borderSubtle,
                  ),
                  avatar: Icon(
                    isUnlocked ? Icons.lock_open_rounded : Icons.lock_rounded,
                    color: isUnlocked ? GameTheme.amberAccent : GameTheme.textMuted,
                    size: 14,
                  ),
                  label: Text(
                    'Level $lvl',
                    style: TextStyle(
                      color: isUnlocked ? GameTheme.textWhite : GameTheme.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: isUnlocked ? () => _navigateToLevel(context, ref, lvl) : null,
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // 10. Interactive Practice Test
            _buildSectionHeader('INTERACTIVE PRACTICE TEST', Icons.quiz_rounded),
            const SizedBox(height: 10),
            LessonPracticeTestCard(lesson: lesson),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner(bool isAlreadyCompleted) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isAlreadyCompleted
                ? GameTheme.successGreen.withValues(alpha: 0.15)
                : GameTheme.amberGlow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isAlreadyCompleted
                  ? GameTheme.successGreen.withValues(alpha: 0.4)
                  : GameTheme.amberAccent.withValues(alpha: 0.3),
            ),
          ),
          child: Icon(
            isAlreadyCompleted ? Icons.check_circle_rounded : lesson.icon,
            color: isAlreadyCompleted ? GameTheme.successGreen : GameTheme.amberAccent,
            size: 28,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lesson.chapter.toUpperCase(),
                style: const TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                lesson.title,
                style: const TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: GameTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: GameTheme.borderSubtle),
                    ),
                    child: Text(
                      lesson.difficulty,
                      style: const TextStyle(
                        color: GameTheme.amberAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (isAlreadyCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: GameTheme.successGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: GameTheme.successGreen.withValues(alpha: 0.4)),
                      ),
                      child: const Text(
                        'MASTERED (+50 PTS)',
                        style: TextStyle(
                          color: GameTheme.successGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormulaCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.5), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.functions_rounded, color: GameTheme.amberAccent, size: 18),
              SizedBox(width: 8),
              Text(
                'CORE FORMULA & SHORTCUT',
                style: TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            lesson.formula,
            style: const TextStyle(
              color: GameTheme.textWhite,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.4,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: GameTheme.amberAccent, size: 16),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: GameTheme.amberAccent,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
