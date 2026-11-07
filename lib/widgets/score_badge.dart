import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../theme/game_theme.dart';

class ScoreBadge extends ConsumerWidget {
  final bool isInteractive;
  final bool compact;

  const ScoreBadge({
    super.key,
    this.isInteractive = true,
    this.compact = false,
  });

  void _showScoreRulesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: GameTheme.surface,
        insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: GameTheme.amberAccent, width: 1.2),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  children: [
                    Icon(Icons.stars_rounded, color: GameTheme.amberAccent, size: 22),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'SCORING SYSTEM',
                        style: TextStyle(
                          color: GameTheme.textWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildRuleRow('Levels 1–10', '+5 PTS per solved riddle'),
                const SizedBox(height: 8),
                _buildRuleRow('Levels 11–20', '+15 PTS (+10 increase per 10 levels)'),
                const SizedBox(height: 8),
                _buildRuleRow('Learn Mode', '+50 PTS per completed concept'),
                const SizedBox(height: 8),
                _buildRuleRow('Speedrun Challenge', '+3 PTS per solved challenge'),
                const SizedBox(height: 18),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: GameTheme.surfaceElevated,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: GameTheme.borderSubtle),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text(
                    'GOT IT',
                    style: TextStyle(
                      color: GameTheme.amberAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildRuleRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: GameTheme.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: GameTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: GameTheme.textWhite,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.stars_rounded, color: GameTheme.amberAccent, size: 16),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: GameTheme.amberAccent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(gameControllerProvider.select((s) => s.totalScore));

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: isInteractive ? () => _showScoreRulesDialog(context) : null,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 12,
            vertical: compact ? 5 : 6,
          ),
          decoration: BoxDecoration(
            color: GameTheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: GameTheme.amberAccent.withValues(alpha: 0.5),
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: GameTheme.amberGlow,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                color: GameTheme.amberAccent,
                size: 16,
              ),
              const SizedBox(width: 4),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.82, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                    ),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: Row(
                  key: ValueKey<int>(score),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$score',
                      style: const TextStyle(
                        color: GameTheme.amberAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Text(
                      'PTS',
                      style: TextStyle(
                        color: GameTheme.amberAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
