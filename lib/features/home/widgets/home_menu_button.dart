import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/sound_service.dart';
import '../../../theme/game_theme.dart';

/// Reusable clean menu button for primary home actions (RIDDLE, CHALLENGE, LEARN).
class HomeMenuButton extends ConsumerWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isAccent;

  const HomeMenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 250,
      height: 52,
      child: Material(
        color: isAccent
            ? GameTheme.amberAccent.withValues(alpha: 0.14)
            : GameTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: isAccent ? GameTheme.amberAccent : GameTheme.borderSubtle,
            width: isAccent ? 1.4 : 1.0,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            ref.read(soundServiceProvider).playTap();
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isAccent ? GameTheme.amberAccent : GameTheme.textLight,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isAccent ? GameTheme.amberAccent : GameTheme.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

