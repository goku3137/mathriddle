import 'package:flutter/material.dart';
import '../features/riddles/widgets/help_modal_buttons.dart';
import '../models/level_model.dart';
import '../theme/game_theme.dart';

class NeedHelpModal extends StatelessWidget {
  final LevelData level;
  final bool isHintUnlocked;
  final bool isSolutionUnlocked;
  final bool isPremium;
  final VoidCallback onWatchAdForHint;
  final VoidCallback onWatchAdForSolution;
  final VoidCallback onOpenShop;

  const NeedHelpModal({
    super.key,
    required this.level,
    required this.isHintUnlocked,
    required this.isSolutionUnlocked,
    this.isPremium = false,
    required this.onWatchAdForHint,
    required this.onWatchAdForSolution,
    required this.onOpenShop,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: GameTheme.modalSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Row: Icon + Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: GameTheme.amberAccent.withAlpha(40),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lightbulb_rounded,
                      color: GameTheme.amberAccent,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Need Help?',
                    style: TextStyle(
                      color: GameTheme.modalTextDark,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  'Level ${level.levelNumber} Guidance',
                  style: const TextStyle(
                    color: GameTheme.modalTextMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Hint Reveal Card (if unlocked)
              if (isHintUnlocked) ...[
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.tips_and_updates_rounded, color: GameTheme.amberAccent, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'HINT',
                              style: TextStyle(
                                color: GameTheme.modalTextDark,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              level.hint,
                              style: const TextStyle(
                                color: GameTheme.modalTextDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Solution Reveal Card (if unlocked)
              if (isSolutionUnlocked) ...[
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9EE),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: GameTheme.amberAccent.withAlpha(150), width: 1.2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: GameTheme.amberAccent, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'COMPLETE SOLUTION',
                              style: TextStyle(
                                color: GameTheme.warmOrange,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${level.solution}\n\nCorrect Answer: ${level.correctAnswer}',
                              style: const TextStyle(
                                color: GameTheme.modalTextDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // --- BUTTON 1: Watch Ad for Hint ---
              HelpActionButton(
                icon: isHintUnlocked ? Icons.check_circle_rounded : Icons.videocam_rounded,
                title: isHintUnlocked ? 'Hint Unlocked' : 'Watch Ad for Hint',
                subtitle: isHintUnlocked ? 'Revealed above' : 'Free • 1 Short Video Ad',
                isUnlocked: isHintUnlocked,
                isAccent: false,
                onPressed: isHintUnlocked
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        onWatchAdForHint();
                      },
              ),

              const SizedBox(height: 10),

              // --- BUTTON 2: Watch Ad for Solution ---
              HelpActionButton(
                icon: isSolutionUnlocked ? Icons.check_circle_rounded : Icons.play_circle_outline_rounded,
                title: isSolutionUnlocked ? 'Solution Unlocked' : 'Watch Ad for Solution',
                subtitle: isSolutionUnlocked ? 'Revealed above' : 'Free • Full Step-by-Step Logic',
                isUnlocked: isSolutionUnlocked,
                isAccent: false,
                onPressed: isSolutionUnlocked
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        onWatchAdForSolution();
                      },
              ),

              const SizedBox(height: 14),

              // Divider with "OR" text
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.black12, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: GameTheme.modalTextMuted.withAlpha(180),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.black12, thickness: 1)),
                ],
              ),

              const SizedBox(height: 14),

              // --- BUTTON 3: Buy VIP / Premium (Open Shop) ---
              if (!isPremium) ...[
                HelpPremiumButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onOpenShop();
                  },
                ),
                const SizedBox(height: 12),
              ],

              // --- BUTTON 4: No Thanks / Dismiss ---
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'No thanks, keep solving',
                    style: TextStyle(
                      color: GameTheme.modalTextMuted,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
