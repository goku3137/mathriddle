import 'package:flutter/material.dart';

import '../../../theme/game_theme.dart';
import '../models/challenge_models.dart';

/// Compact feedback overlay replacing large modal dialogs.
/// Displays incorrect answer, correct answer, and one-line explanation.
/// Automatically continues after ~1.6s, or immediately when the player taps.
class ChallengeFeedbackCard extends StatelessWidget {
  final FeedbackOverlayData data;
  final String questionText;
  final VoidCallback onTap;

  const ChallengeFeedbackCard({
    super.key,
    required this.data,
    required this.questionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
          decoration: BoxDecoration(
            color: GameTheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: data.isTimeout
                  ? GameTheme.amberAccent.withValues(alpha: 0.6)
                  : GameTheme.errorRed.withValues(alpha: 0.7),
              width: 1.2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    data.isTimeout ? Icons.timer_off_rounded : Icons.close_rounded,
                    color: data.isTimeout ? GameTheme.amberAccent : GameTheme.errorRed,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    data.isTimeout ? "TIME'S UP" : 'INCORRECT',
                    style: TextStyle(
                      color: data.isTimeout ? GameTheme.amberAccent : GameTheme.errorRed,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Question Statement
              Text(
                questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),

              // Compact Comparison Pill: Incorrect vs Correct
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: GameTheme.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: GameTheme.borderSubtle),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!data.isTimeout) ...[
                      Column(
                        children: [
                          const Text(
                            'YOURS',
                            style: TextStyle(color: GameTheme.textMuted, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            data.wrongInput.isEmpty ? '-' : data.wrongInput,
                            style: const TextStyle(color: GameTheme.errorRed, fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        height: 24,
                        width: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        color: GameTheme.borderSubtle,
                      ),
                    ],
                    Column(
                      children: [
                        const Text(
                          'CORRECT',
                          style: TextStyle(color: GameTheme.textMuted, fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          data.correctAnswer,
                          style: const TextStyle(color: GameTheme.amberAccent, fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // One-line explanation
              if (data.explanation.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  data.explanation,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: GameTheme.textLight,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
              ],
              const SizedBox(height: 12),

              // Tap hint
              const Text(
                'Tap anywhere to continue',
                style: TextStyle(
                  color: GameTheme.textDim,
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
