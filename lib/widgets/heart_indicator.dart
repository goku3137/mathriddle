import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../screens/shop_screen.dart';
import '../theme/game_theme.dart';

class HeartIndicator extends ConsumerWidget {
  final bool isInteractive;
  final bool compact;

  const HeartIndicator({
    super.key,
    this.isInteractive = true,
    this.compact = false,
  });

  void _showHeartInfoDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(gameControllerProvider);
            final hearts = state.hearts;
            final isUnlimited = state.isUnlimitedHearts;

            return Dialog(
              backgroundColor: GameTheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: GameTheme.borderSubtle, width: 1.2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE74C3C).withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.favorite_rounded, color: Color(0xFFE74C3C), size: 22),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'HEARTS & ENERGY',
                          style: TextStyle(
                            color: GameTheme.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 5 Heart Visual Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final isFilled = isUnlimited || index < hearts;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            isFilled ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: isFilled ? const Color(0xFFE74C3C) : GameTheme.textDim,
                            size: 28,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),

                    // Status & Timer message
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: GameTheme.surfaceElevated,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: GameTheme.borderSubtle),
                      ),
                      child: Column(
                        children: [
                          if (isUnlimited)
                            const Text(
                              'VIP Status: Unlimited Hearts ∞',
                              style: TextStyle(
                                color: GameTheme.amberAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          else if (hearts >= 5)
                            const Text(
                              'All hearts fully charged (5/5)!',
                              style: TextStyle(
                                color: GameTheme.successGreen,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Next heart refill:',
                                  style: TextStyle(color: GameTheme.textMuted, fontSize: 13),
                                ),
                                Text(
                                  state.formattedHeartTimer,
                                  style: const TextStyle(
                                    color: GameTheme.amberAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFeatures: [FontFeature.tabularFigures()],
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 4),
                          const Text(
                            '1 heart refills automatically every 20 minutes.',
                            style: TextStyle(color: GameTheme.textDim, fontSize: 11),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Actions
                    if (!isUnlimited && hearts < 5) ...[
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GameTheme.surfaceElevated,
                          foregroundColor: GameTheme.textWhite,
                          side: const BorderSide(color: GameTheme.amberAccent),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () async {
                          Navigator.of(ctx).pop();
                          await ref.read(gameControllerProvider.notifier).refillHeartWithAd();
                        },
                        icon: const Icon(Icons.play_circle_outline_rounded, color: GameTheme.amberAccent, size: 20),
                        label: const Text(
                          'WATCH AD FOR +1 HEART',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.0),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],

                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: GameTheme.borderSubtle),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ShopScreen()),
                        );
                      },
                      icon: const Icon(Icons.workspace_premium_rounded, color: GameTheme.amberAccent, size: 18),
                      label: const Text(
                        'GET UNLIMITED HEARTS',
                        style: TextStyle(color: GameTheme.amberAccent, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('CLOSE', style: TextStyle(color: GameTheme.textMuted)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heartData = ref.watch(
      gameControllerProvider.select((s) => (
        hearts: s.hearts,
        isUnlimited: s.isUnlimitedHearts,
        formattedHeartTimer: s.formattedHeartTimer,
      )),
    );
    final hearts = heartData.hearts;
    final isUnlimited = heartData.isUnlimited;
    final isLow = !isUnlimited && hearts <= 1;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: isInteractive ? () => _showHeartInfoDialog(context, ref) : null,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 9 : 11,
            vertical: compact ? 5 : 6,
          ),
          decoration: BoxDecoration(
            color: GameTheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLow
                  ? const Color(0xFFE74C3C).withValues(alpha: 0.8)
                  : GameTheme.borderSubtle,
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.favorite_rounded,
                color: isLow ? const Color(0xFFE74C3C) : const Color(0xFFE74C3C).withValues(alpha: 0.9),
                size: 15,
              ),
              const SizedBox(width: 4),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  isUnlimited ? '∞' : '$hearts',
                  key: ValueKey<String>(isUnlimited ? 'inf' : '$hearts'),
                  style: TextStyle(
                    color: isLow ? const Color(0xFFE74C3C) : GameTheme.textWhite,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (!isUnlimited && hearts < 5 && !compact) ...[
                const SizedBox(width: 4),
                Text(
                  heartData.formattedHeartTimer,
                  style: const TextStyle(
                    color: GameTheme.textDim,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
