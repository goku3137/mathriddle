import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/game_controller.dart';
import '../../../screens/shop_screen.dart';
import '../../../services/sound_service.dart';
import '../../../theme/game_theme.dart';

/// Understated PRO pill integrated into top-right header cluster.
class HomeProPill extends ConsumerWidget {
  const HomeProPill({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasUnlimitedHearts = ref.watch(gameControllerProvider).isUnlimitedHearts;
    if (hasUnlimitedHearts) return const SizedBox.shrink();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ref.read(soundServiceProvider).playTap();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ShopScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          decoration: BoxDecoration(
            color: GameTheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.5)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.workspace_premium_rounded, color: GameTheme.amberAccent, size: 13),
              SizedBox(width: 3),
              Text(
                'PRO',
                style: TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
