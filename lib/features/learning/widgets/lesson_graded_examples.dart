import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/lesson_model.dart';
import '../../../services/sound_service.dart';
import '../../../theme/game_theme.dart';

/// Interactive tabs and display card for graded worked examples (Beginner, Standard, Advanced).
class LessonGradedExamples extends ConsumerStatefulWidget {
  final Lesson lesson;

  const LessonGradedExamples({
    super.key,
    required this.lesson,
  });

  @override
  ConsumerState<LessonGradedExamples> createState() => _LessonGradedExamplesState();
}

class _LessonGradedExamplesState extends ConsumerState<LessonGradedExamples> {
  int _activeExampleIndex = 0;

  @override
  Widget build(BuildContext context) {
    final examples = widget.lesson.gradedExamples;

    if (examples.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: GameTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: GameTheme.borderSubtle),
        ),
        child: Text(
          widget.lesson.workedExample,
          style: const TextStyle(
            color: GameTheme.amberAccent,
            fontSize: 13,
            height: 1.5,
            fontFamily: 'monospace',
          ),
        ),
      );
    }

    return Column(
      children: [
        // Tabs for Level 1, Level 2, Level 3
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(examples.length, (idx) {
              final isSelected = _activeExampleIndex == idx;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  selected: isSelected,
                  label: Text(examples[idx].difficultyLabel),
                  selectedColor: GameTheme.amberAccent.withValues(alpha: 0.25),
                  backgroundColor: GameTheme.surfaceElevated,
                  side: BorderSide(color: isSelected ? GameTheme.amberAccent : GameTheme.borderSubtle),
                  labelStyle: TextStyle(
                    color: isSelected ? GameTheme.amberAccent : GameTheme.textMuted,
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  onSelected: (val) {
                    if (val) {
                      ref.read(soundServiceProvider).playTap();
                      setState(() => _activeExampleIndex = idx);
                    }
                  },
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 10),

        // Active Example Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: GameTheme.surfaceElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: GameTheme.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                examples[_activeExampleIndex].title.toUpperCase(),
                style: const TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Problem: ${examples[_activeExampleIndex].problem}',
                style: const TextStyle(color: GameTheme.textWhite, fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                examples[_activeExampleIndex].stepByStepSolution,
                style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.45, fontFamily: 'monospace'),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: GameTheme.amberGlow,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Final Answer: ${examples[_activeExampleIndex].answer}',
                  style: const TextStyle(color: GameTheme.amberAccent, fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

