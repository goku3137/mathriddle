import 'package:flutter/material.dart';
import '../../../services/progress_service.dart';
import '../../../theme/game_theme.dart';

/// Reusable settings tile widgets: toggle switches, volume slider, and action rows.
class SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
}

class SettingsVolumeTile extends StatelessWidget {
  final ProgressService progress;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;

  const SettingsVolumeTile({
    super.key,
    required this.progress,
    required this.onChanged,
    required this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress.soundVolume * 100).round();
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.volume_down_rounded, color: GameTheme.textMuted, size: 20),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'VOLUME',
                  style: TextStyle(
                    color: GameTheme.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Text(
                '$percent%',
                style: const TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: GameTheme.amberAccent,
              inactiveTrackColor: GameTheme.borderSubtle,
              thumbColor: GameTheme.amberAccent,
              overlayColor: GameTheme.amberAccent.withValues(alpha: 0.2),
              trackHeight: 3.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
            ),
            child: Slider(
              value: progress.soundVolume,
              min: 0.0,
              max: 1.0,
              divisions: 20,
              onChanged: onChanged,
              onChangeEnd: onChangeEnd,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? GameTheme.errorRed : GameTheme.textLight,
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isDestructive ? GameTheme.errorRed : GameTheme.textWhite,
                  fontSize: 14,
                  fontWeight: isDestructive ? FontWeight.w600 : FontWeight.w400,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDestructive ? GameTheme.errorRed : GameTheme.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

