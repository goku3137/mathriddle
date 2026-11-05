import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/game_theme.dart';
import '../widgets/heart_indicator.dart';
import '../widgets/score_badge.dart';
import 'challenge_screen.dart';
import 'learn_screen.dart';
import 'levels_screen.dart';
import 'settings_screen.dart';
import 'shop_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: GameTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Top-Right Navigation: Compact amber score indicator (★ Total Points) beside Settings
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 5 Hearts with 20-min refill
                        const HeartIndicator(compact: true),
                        const SizedBox(width: 6),

                        // Compact amber score indicator (★ Total Points) beside Settings
                        const ScoreBadge(compact: true),
                        const SizedBox(width: 4),

                        // Gear Icon
                        IconButton(
                          icon: const Icon(Icons.settings_outlined, color: GameTheme.textWhite, size: 24),
                          tooltip: 'Settings',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const SettingsScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),

                    // Premium / VIP Badge directly beneath Settings Icon
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ShopScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: GameTheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.6)),
                          boxShadow: const [
                            BoxShadow(
                              color: GameTheme.amberGlow,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.workspace_premium_rounded, color: GameTheme.amberAccent, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'PRO',
                              style: TextStyle(
                                color: GameTheme.amberAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // 2. Center Branding & Tagline (placed slightly above center)
              Center(
                child: Column(
                  children: [
                    // Primary Game Title
                    const Text(
                      'MATH RIDDLES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GameTheme.textWhite,
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4.5,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Subtitle / Hero Quote
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '“Logic is the anatomy of thought. Challenge your limits.”',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: GameTheme.textMuted,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.2,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // 3. Core Menu Buttons: RIDDLE, LEARN, CHALLENGE
                    _buildMenuButton(
                      context: context,
                      label: 'RIDDLE',
                      icon: Icons.play_arrow_rounded,
                      isAccent: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LevelsScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    _buildMenuButton(
                      context: context,
                      label: 'LEARN',
                      icon: Icons.menu_book_rounded,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LearnScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    _buildMenuButton(
                      context: context,
                      label: 'CHALLENGE',
                      icon: Icons.bolt_rounded,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ChallengeScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // 4. Screen Footer: Centered Rate Us Button (Star Badge)
              Center(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  icon: const Icon(Icons.star_rate_rounded, color: GameTheme.amberAccent, size: 20),
                  label: const Text(
                    'Rate Us ★★★★★',
                    style: TextStyle(
                      color: GameTheme.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: GameTheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: GameTheme.amberAccent),
                        ),
                        title: const Text(
                          'Enjoying Math Riddles?',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: GameTheme.textWhite, fontWeight: FontWeight.w700),
                        ),
                        content: const Text(
                          'Your 5-star review helps us craft more mathematical riddles and logic puzzles.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: GameTheme.textMuted, fontSize: 13, height: 1.4),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('LATER', style: TextStyle(color: GameTheme.textMuted)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GameTheme.amberAccent,
                              foregroundColor: Colors.black87,
                            ),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Thank you for supporting Math Riddles!')),
                              );
                            },
                            child: const Text('RATE 5 STARS', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool isAccent = false,
  }) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      height: 52,
      decoration: BoxDecoration(
        color: isAccent ? GameTheme.surfaceElevated : GameTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isAccent ? GameTheme.amberAccent : GameTheme.borderSubtle,
          width: isAccent ? 1.5 : 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          splashColor: GameTheme.amberAccent.withValues(alpha: 0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isAccent ? GameTheme.amberAccent : GameTheme.textLight,
                  size: 20,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isAccent ? GameTheme.textWhite : GameTheme.textLight,
                      fontSize: 14,
                      fontWeight: isAccent ? FontWeight.w700 : FontWeight.w500,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: GameTheme.textDim, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
