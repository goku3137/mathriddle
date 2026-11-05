import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/home/widgets/home_menu_button.dart';
import '../features/home/widgets/home_pro_pill.dart';
import '../features/home/widgets/rate_app_dialog.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/heart_indicator.dart';
import '../widgets/score_badge.dart';
import 'challenge_screen.dart';
import 'learn_screen.dart';
import 'levels_screen.dart';
import 'settings_screen.dart';

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
                    const HomeProPill(),
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
                    HomeMenuButton(
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
                    HomeMenuButton(
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
                    HomeMenuButton(
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
                    RateAppDialog.show(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
