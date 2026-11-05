import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/sound_service.dart';
import '../services/store_service.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Top-Right Cluster: Hearts, Points, PRO, and Settings in ONE horizontal row
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Hearts Indicator (5 hearts, 20-min refill)
                    const HeartIndicator(compact: true),
                    const SizedBox(width: 6),

                    // Points Score Indicator
                    const ScoreBadge(compact: true),
                    const SizedBox(width: 6),

                    // Understated PRO Pill (Visible but subtle, lets players discover naturally)
                    _buildProPill(context, ref),
                    const SizedBox(width: 2),

                    // Settings Gear Button
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, color: GameTheme.textLight, size: 22),
                      tooltip: 'Settings',
                      padding: const EdgeInsets.all(6),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        ref.read(soundServiceProvider).playTap();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // 2. Center Branding & Primary Game Modes
              Center(
                child: Column(
                  children: [
                    // Primary Game Title: Strong, clean font with reduced letter spacing
                    const Text(
                      'MATH RIDDLES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GameTheme.textWhite,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle / Hero Quote: Smaller, understated, keeping game modes as the main focus
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: Text(
                        '“Logic is the anatomy of thought. Challenge your limits.”',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: GameTheme.textDim,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.4,
                          height: 1.35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 4. RIDDLE Button: Primary call to action with subtle filled amber accent
                    _buildMenuButton(
                      context: context,
                      ref: ref,
                      label: 'RIDDLE',
                      icon: Icons.play_arrow_rounded,
                      isAccent: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LevelsScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // 5. CHALLENGE Button: Consistent dimensions, spacing & icon styling
                    _buildMenuButton(
                      context: context,
                      ref: ref,
                      label: 'CHALLENGE',
                      icon: Icons.bolt_rounded,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ChallengeScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // 5. LEARN Button: Consistent dimensions, spacing & icon styling
                    _buildMenuButton(
                      context: context,
                      ref: ref,
                      label: 'LEARN',
                      icon: Icons.school_rounded,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LearnScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // 6. Screen Footer: Subtle Rate Us button without competing large stars
              Center(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    foregroundColor: GameTheme.textDim,
                  ),
                  icon: const Icon(
                    Icons.star_outline_rounded,
                    color: GameTheme.textDim,
                    size: 15,
                  ),
                  label: const Text(
                    'Rate Math Riddles',
                    style: TextStyle(
                      color: GameTheme.textDim,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                    ),
                  ),
                  onPressed: () {
                    ref.read(soundServiceProvider).playTap();
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: GameTheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: GameTheme.borderSubtle),
                        ),
                        title: const Text(
                          'Enjoying Math Riddles?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: GameTheme.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        content: const Text(
                          'Your review helps us craft more mathematical riddles and logic puzzles.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: GameTheme.textMuted,
                            fontSize: 13,
                            height: 1.4,
                          ),
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
                            onPressed: () async {
                              ref.read(soundServiceProvider).playTap();
                              Navigator.of(ctx).pop();
                              await StoreService.openPlayStoreReview();
                            },
                            child: const Text('RATE APP', style: TextStyle(fontWeight: FontWeight.w700)),
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

  /// Subtle, understated PRO pill integrated seamlessly into the top cluster.
  Widget _buildProPill(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          ref.read(soundServiceProvider).playTap();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ShopScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          decoration: BoxDecoration(
            color: GameTheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: GameTheme.amberAccent.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.workspace_premium_rounded,
                color: GameTheme.amberAccent,
                size: 14,
              ),
              SizedBox(width: 4),
              Text(
                'PRO',
                style: TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Standardized menu button ensuring consistent dimensions, spacing, and icon styling across all game modes.
  Widget _buildMenuButton({
    required BuildContext context,
    required WidgetRef ref,
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
        color: isAccent
            ? GameTheme.amberAccent.withValues(alpha: 0.12)
            : GameTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAccent
              ? GameTheme.amberAccent.withValues(alpha: 0.5)
              : GameTheme.borderSubtle,
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            ref.read(soundServiceProvider).playTap();
            onTap();
          },
          splashColor: GameTheme.amberAccent.withValues(alpha: 0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isAccent ? GameTheme.amberAccent : GameTheme.textLight,
                  size: 22,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isAccent ? GameTheme.textWhite : GameTheme.textLight,
                      fontSize: 14,
                      fontWeight: isAccent ? FontWeight.w700 : FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isAccent
                      ? GameTheme.amberAccent.withValues(alpha: 0.7)
                      : GameTheme.textDim,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
