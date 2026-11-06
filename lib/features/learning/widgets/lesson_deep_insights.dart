import 'package:flutter/material.dart';

import '../../../models/lesson_model.dart';
import '../../../theme/game_theme.dart';

/// Renders Common Traps to Avoid, Mental Shortcuts, and Alternative Solving Methods.
class LessonDeepInsights extends StatelessWidget {
  final Lesson lesson;

  const LessonDeepInsights({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    final mistakes = lesson.commonMistakes;
    final shortcuts = lesson.shortcutsAndTricks;
    final alternatives = lesson.alternativeMethods;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GameTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Common Mistakes
          if (mistakes.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: GameTheme.errorRed, size: 16),
                SizedBox(width: 6),
                Text(
                  'COMMON TRAPS TO AVOID',
                  style: TextStyle(
                    color: GameTheme.errorRed,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            for (final m in mistakes) ...[
              Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: GameTheme.errorRed, fontSize: 12)),
                    Expanded(child: Text(m, style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.4))),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
          ],

          // Shortcuts & Tricks
          if (shortcuts.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.flash_on_rounded, color: GameTheme.amberAccent, size: 16),
                SizedBox(width: 6),
                Text(
                  'MENTAL SHORTCUTS & SPEED TRICKS',
                  style: TextStyle(
                    color: GameTheme.amberAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            for (final s in shortcuts) ...[
              Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: GameTheme.amberAccent, fontSize: 12)),
                    Expanded(child: Text(s, style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.4))),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
          ],

          // Alternative Methods
          if (alternatives.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.alt_route_rounded, color: GameTheme.textWhite, size: 16),
                SizedBox(width: 6),
                Text(
                  'ALTERNATIVE SOLVING METHODS',
                  style: TextStyle(
                    color: GameTheme.textWhite,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            for (final a in alternatives) ...[
              Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: GameTheme.textLight, fontSize: 12)),
                    Expanded(child: Text(a, style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.4))),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

