import 'package:flutter/material.dart';

import '../../../theme/game_theme.dart';

/// Clean question display card showing current question number, solved count, and question string.
class ChallengeQuestionCard extends StatelessWidget {
  final int questionNumber;
  final int sessionSolved;
  final String questionText;

  const ChallengeQuestionCard({
    super.key,
    required this.questionNumber,
    required this.sessionSolved,
    required this.questionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GameTheme.borderSubtle),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'QUESTION $questionNumber • SOLVED: $sessionSolved',
            style: const TextStyle(
              color: GameTheme.textMuted,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GameTheme.textWhite,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}

