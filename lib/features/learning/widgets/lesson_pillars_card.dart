import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';
import '../../../theme/game_theme.dart';

/// The Four Pillars of Mathematical Mastery expandable component:
/// 1. What It Is
/// 2. Why It Works
/// 3. How to Solve It
/// 4. When to Use It
class LessonPillarsCard extends StatelessWidget {
  final Lesson lesson;

  const LessonPillarsCard({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: GameTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: GameTheme.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildPillarTile(
            context: context,
            title: '1. WHAT IT IS',
            icon: Icons.lightbulb_outline_rounded,
            content: lesson.whatItIs.isNotEmpty ? lesson.whatItIs : lesson.conceptSummary,
          ),
          const Divider(color: GameTheme.borderSubtle, height: 1),
          _buildPillarTile(
            context: context,
            title: '2. WHY IT WORKS',
            icon: Icons.psychology_rounded,
            content: lesson.whyItWorks.isNotEmpty
                ? lesson.whyItWorks
                : 'Governed by formal algebraic axioms and mathematical structural invariances.',
          ),
          const Divider(color: GameTheme.borderSubtle, height: 1),
          _buildPillarTile(
            context: context,
            title: '3. HOW TO SOLVE IT',
            icon: Icons.checklist_rounded,
            content: lesson.howToSolveIt.isNotEmpty ? lesson.howToSolveIt : lesson.stepByStepExplanation,
          ),
          const Divider(color: GameTheme.borderSubtle, height: 1),
          _buildPillarTile(
            context: context,
            title: '4. WHEN TO USE IT',
            icon: Icons.visibility_rounded,
            content: lesson.whenToUseIt.isNotEmpty
                ? lesson.whenToUseIt
                : 'Recognize visual puzzle patterns and operator clues in SMATH riddles.',
          ),
        ],
      ),
    );
  }

  Widget _buildPillarTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String content,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Material(
        type: MaterialType.transparency,
        child: ExpansionTile(
          initiallyExpanded: title.startsWith('1.'),
          leading: Icon(icon, color: GameTheme.amberAccent, size: 18),
          title: Text(
            title,
            style: const TextStyle(
              color: GameTheme.textWhite,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                content,
                style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

