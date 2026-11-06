import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../features/settings/widgets/settings_dialogs.dart';
import '../features/settings/widgets/settings_tiles.dart';
import '../services/monetization_service.dart';
import '../services/sound_service.dart';
import '../services/store_service.dart';
import '../theme/game_theme.dart';

/// Clean, minimalistic settings screen organizing game preferences,
/// audio controls, purchases, and data management.
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
          onPressed: () {
            ref.read(soundServiceProvider).playTap();
            Navigator.of(context).pop();
          },
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
                    SettingsSwitchTile(
                      icon: progress.soundEnabled ? Icons.volume_up_outlined : Icons.volume_off_outlined,
                      label: 'SOUND',
                      value: progress.soundEnabled,
                      onChanged: (val) async {
                        await progress.setSoundEnabled(val);
                        if (val) {
                          ref.read(soundServiceProvider).playTap();
                        }
                        setState(() {});
                      },
                    ),
                    if (progress.soundEnabled) ...[
                      const Divider(color: GameTheme.borderSubtle, height: 1),
                      SettingsVolumeTile(
                        progress: progress,
                        onChanged: (val) async {
                          await progress.setSoundVolume(val);
                          setState(() {});
                        },
                        onChangeEnd: (val) {
                          ref.read(soundServiceProvider).playTap();
                        },
                      ),
                    ],
                    const Divider(color: GameTheme.borderSubtle, height: 1),

                    // VIBRATION Toggle Switch
                    SettingsSwitchTile(
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
                    SettingsSwitchTile(
                      icon: Icons.ad_units_outlined,
                      label: 'ADS SETTING',
                      value: progress.personalizedAdsEnabled,
                      onChanged: (val) async {
                        await progress.setPersonalizedAdsEnabled(val);
                        setState(() {});
                      },
                    ),
                    const Divider(color: GameTheme.borderSubtle, height: 1),

                    // RATE US Actionable Row
                    SettingsActionTile(
                      icon: Icons.star_rate_rounded,
                      label: 'RATE US',
                      onTap: () async {
                        ref.read(soundServiceProvider).playTap();
                        await StoreService.openPlayStoreReview();
                      },
                    ),
                    const Divider(color: GameTheme.borderSubtle, height: 1),

                    // RESTORE PURCHASE Actionable Row
                    SettingsActionTile(
                      icon: Icons.restore_rounded,
                      label: 'RESTORE PURCHASE',
                      onTap: () async {
                        final restored = await billing.restorePurchases();
                        if (restored != PremiumTier.none) {
                          await progress.setPremiumTier(restored);
                          ref.invalidate(gameControllerProvider);
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: GameTheme.surface,
                              content: Text(
                                restored != PremiumTier.none
                                    ? 'Purchases successfully restored.'
                                    : 'No previous purchases found to restore.',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const Divider(color: GameTheme.borderSubtle, height: 1),

                    // DELETE DATA Warning-Accented Row
                    SettingsActionTile(
                      icon: Icons.delete_outline_rounded,
                      label: 'DELETE DATA',
                      isDestructive: true,
                      onTap: () => SettingsDialogs.showDeleteConfirmation(context, ref, progress),
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
                    onTap: () => SettingsDialogs.showPrivacyPolicy(context),
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
                    onTap: () => SettingsDialogs.showTermsAndConditions(context),
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
}
