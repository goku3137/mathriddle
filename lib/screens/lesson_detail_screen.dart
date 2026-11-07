import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../data/learning_curriculum.dart';
import '../features/learning/widgets/lesson_practice_test_card.dart';
import '../models/lesson_model.dart';
import '../services/sound_service.dart';
import '../theme/learning_theme.dart';
import '../widgets/score_badge.dart';
import 'riddle_screen.dart';

/// Readability-first educational lesson view designed for clarity, contrast, and cognitive focus.
/// Employs an 8-step minimal-text visual hierarchy with high-contrast mathematical typography.
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
    final progress = ref.watch(progressServiceProvider);
    final isAlreadyCompleted = progress.isLearnTopicCompleted(lesson.id);

    // Global position in the 36-lesson curriculum
    final lessonIndex = learningCurriculum.indexWhere((l) => l.id == lesson.id);
    final displayIndex = lessonIndex >= 0 ? lessonIndex + 1 : lesson.stageIndex;
    final totalLessons = learningCurriculum.length;

    return Scaffold(
      backgroundColor: LearningTheme.background,
      appBar: AppBar(
        backgroundColor: LearningTheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: LearningTheme.textPrimary, size: 20),
          onPressed: () {
            ref.read(soundServiceProvider).playTap();
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'STAGE ${lesson.stageIndex} • LESSON $displayIndex OF $totalLessons',
          style: const TextStyle(
            color: LearningTheme.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: LearningTheme.divider, height: 1),
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          children: [
            // 1. Stage & Category Badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: LearningTheme.stageBlueBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    lesson.stage.toUpperCase(),
                    style: const TextStyle(
                      color: LearningTheme.stageBlue,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  lesson.category.toUpperCase(),
                  style: const TextStyle(
                    color: LearningTheme.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 2. Lesson Title
            Text(
              lesson.title,
              style: const TextStyle(
                color: LearningTheme.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 8),

            // Difficulty & Completion Status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: LearningTheme.surfaceSubtle,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: LearningTheme.border),
                  ),
                  child: Text(
                    lesson.difficulty.toUpperCase(),
                    style: const TextStyle(
                      color: LearningTheme.textSecondary,
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
                      color: LearningTheme.correctBg,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: LearningTheme.correctGreen.withValues(alpha: 0.4)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_rounded, size: 12, color: LearningTheme.correctGreen),
                        SizedBox(width: 4),
                        Text(
                          'MASTERED (+50 PTS)',
                          style: TextStyle(
                            color: LearningTheme.correctGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const Text(
                    '+50 PTS on completion',
                    style: TextStyle(
                      color: LearningTheme.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // 3. Concept Summary
            Text(
              lesson.conceptSummary,
              style: const TextStyle(
                color: LearningTheme.textSecondary,
                fontSize: 15,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),

            // 4. Visual Example & Core Formula
            _buildSectionLabel('CORE FORMULA & SHORTCUT'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: LearningTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: LearningTheme.border, width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x06000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                lesson.formula,
                style: const TextStyle(
                  color: LearningTheme.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1.45,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 5. Step-by-Step Educational Explanation
            _buildSectionLabel('STEP-BY-STEP REASONING'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: LearningTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: LearningTheme.border),
              ),
              child: Text(
                lesson.stepByStepExplanation,
                style: const TextStyle(
                  color: LearningTheme.textSecondary,
                  fontSize: 14.5,
                  height: 1.65,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 6. Remember Callout (Key Takeaway)
            _buildRememberCard(),
            const SizedBox(height: 28),

            // 7. Interactive Practice Test
            _buildSectionLabel('INTERACTIVE PRACTICE TEST'),
            const SizedBox(height: 8),
            LessonPracticeTestCard(lesson: lesson),
            const SizedBox(height: 28),

            // 8. Applied in Game Levels
            if (lesson.linkedLevels.isNotEmpty) ...[
              _buildSectionLabel('APPLIED IN GAME LEVELS'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: lesson.linkedLevels.map((lvl) {
                  final isUnlocked = lvl <= progress.unlockedLevelIndex;
                  return ActionChip(
                    backgroundColor: isUnlocked ? LearningTheme.surface : LearningTheme.surfaceSubtle,
                    side: BorderSide(
                      color: isUnlocked ? LearningTheme.stageBlue : LearningTheme.border,
                    ),
                    avatar: Icon(
                      isUnlocked ? Icons.lock_open_rounded : Icons.lock_rounded,
                      color: isUnlocked ? LearningTheme.stageBlue : LearningTheme.textMuted,
                      size: 14,
                    ),
                    label: Text(
                      'Level $lvl',
                      style: TextStyle(
                        color: isUnlocked ? LearningTheme.textPrimary : LearningTheme.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: isUnlocked ? () => _navigateToLevel(context, ref, lvl) : null,
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
            ],

            // Continue / Back to Curriculum Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LearningTheme.border),
                  backgroundColor: LearningTheme.surface,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  ref.read(soundServiceProvider).playTap();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'BACK TO CURRICULUM',
                  style: TextStyle(
                    color: LearningTheme.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: LearningTheme.textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildRememberCard() {
    final takeawayText = lesson.takeaway.isNotEmpty
        ? lesson.takeaway
        : (lesson.shortcutsAndTricks.isNotEmpty ? lesson.shortcutsAndTricks.first : 'Practice makes math intuitive.');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: LearningTheme.takeawayBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: LearningTheme.takeawayBorder, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_rounded, color: LearningTheme.takeawayText, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'REMEMBER',
                  style: TextStyle(
                    color: LearningTheme.takeawayText,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  takeawayText,
                  style: const TextStyle(
                    color: LearningTheme.takeawayText,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
