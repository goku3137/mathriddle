import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../services/monetization_service.dart';
import '../services/progress_service.dart';
import '../theme/game_theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(progressServiceProvider);
    final billing = ref.read(billingServiceProvider);

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'SETTINGS',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // Configuration Controls Encapsulated in Outlined Card Rows
              Container(
                decoration: BoxDecoration(
                  color: GameTheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: GameTheme.borderSubtle, width: 1.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SOUND Toggle Switch
                    _buildSwitchRow(
                      icon: Icons.volume_up_outlined,
                      label: 'SOUND',
                      value: progress.soundEnabled,
                      onChanged: (val) async {
                        await progress.setSoundEnabled(val);
                        setState(() {});
                      },
                    ),
                    const Divider(color: GameTheme.borderSubtle, height: 1),

                    // VIBRATION Toggle Switch
                    _buildSwitchRow(
                      icon: Icons.vibration_rounded,
                      label: 'VIBRATION',
                      value: progress.vibrationEnabled,
                      onChanged: (val) async {
                        await progress.setVibrationEnabled(val);
                        setState(() {});
                      },
                    ),
                    const Divider(color: GameTheme.borderSubtle, height: 1),

                    // ADS SETTING Toggle Switch
                    _buildSwitchRow(
                      icon: Icons.ad_units_outlined,
                      label: 'ADS SETTING',
                      value: progress.personalizedAdsEnabled,
                      onChanged: (val) async {
                        await progress.setPersonalizedAdsEnabled(val);
                        setState(() {});
                      },
                    ),
                    const Divider(color: GameTheme.borderSubtle, height: 1),

                    // RESTORE PURCHASE Actionable Row
                    _buildActionRow(
                      icon: Icons.restore_rounded,
                      label: 'RESTORE PURCHASE',
                      onTap: () async {
                        final restored = await billing.restorePurchases();
                        if (restored != PremiumTier.none) {
                          await progress.setPremiumTier(restored);
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: GameTheme.surface,
                              content: Text('Purchases queried and restored.'),
                            ),
                          );
                        }
                      },
                    ),
                    const Divider(color: GameTheme.borderSubtle, height: 1),

                    // DELETE DATA Warning-Accented Row
                    _buildActionRow(
                      icon: Icons.delete_outline_rounded,
                      label: 'DELETE DATA',
                      isDestructive: true,
                      onTap: () => _showDeleteConfirmation(context, progress),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Footer Legal Links: Clean text links pinned at the bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _showLegalDialog(
                      context,
                      'Privacy Policy',
                      'Math Riddles operates with an offline-first privacy standard. No user tracking or behavioral telemetry is transmitted. All game progress and settings remain local on this device.',
                    ),
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: GameTheme.textMuted,
                        fontSize: 12,
                        letterSpacing: 1.0,
                        decoration: TextDecoration.underline,
                        decorationColor: GameTheme.textDim,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('|', style: TextStyle(color: GameTheme.textDim, fontSize: 12)),
                  ),
                  GestureDetector(
                    onTap: () => _showLegalDialog(
                      context,
                      'Terms of Services',
                      'By playing Math Riddles, you agree to fair use for personal cognitive exercise. All mathematical puzzles and vector geometry are protected intellectual properties of the publisher.',
                    ),
                    child: const Text(
                      'Terms of Services',
                      style: TextStyle(
                        color: GameTheme.textMuted,
                        fontSize: 12,
                        letterSpacing: 1.0,
                        decoration: TextDecoration.underline,
                        decorationColor: GameTheme.textDim,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: GameTheme.textLight, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: GameTheme.textWhite,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: GameTheme.amberAccent,
            activeTrackColor: GameTheme.amberGlow,
            inactiveThumbColor: GameTheme.textDim,
            inactiveTrackColor: GameTheme.surfaceElevated,
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? GameTheme.errorRed : GameTheme.textLight;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: isDestructive ? GameTheme.errorRed : GameTheme.textMuted, size: 20),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: GameTheme.textDim, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, ProgressService progress) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text(
          'RESET PROGRESS?',
          style: TextStyle(color: GameTheme.errorRed, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 1.5),
        ),
        content: const Text(
          'This will permanently reset your solved levels, timer records, and unlocked stages. You will return to Level 1.',
          style: TextStyle(color: GameTheme.textMuted, fontSize: 13, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('CANCEL', style: TextStyle(color: GameTheme.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: GameTheme.errorRed,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await progress.resetAllData();
              ref.invalidate(gameControllerProvider);
              if (ctx.mounted) Navigator.of(ctx).pop();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All local data and level progress reset.')),
                );
              }
            },
            child: const Text('CONFIRM RESET'),
          ),
        ],
      ),
    );
  }

  void _showLegalDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(title, style: const TextStyle(color: GameTheme.textWhite, letterSpacing: 1.5)),
        content: Text(content, style: const TextStyle(color: GameTheme.textMuted, fontSize: 13, height: 1.4)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('CLOSE', style: TextStyle(color: GameTheme.amberAccent)),
          ),
        ],
      ),
    );
  }
}
