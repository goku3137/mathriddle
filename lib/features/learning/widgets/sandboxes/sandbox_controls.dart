import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../services/sound_service.dart';
import '../../../../theme/game_theme.dart';

/// Reusable filter choice chip for sandbox options.
class SandboxChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const SandboxChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: isSelected,
      label: Text(label),
      selectedColor: GameTheme.amberAccent.withValues(alpha: 0.25),
      backgroundColor: GameTheme.surfaceElevated,
      side: BorderSide(color: isSelected ? GameTheme.amberAccent : GameTheme.borderSubtle),
      labelStyle: TextStyle(
        color: isSelected ? GameTheme.amberAccent : GameTheme.textLight,
        fontSize: 11,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      ),
      onSelected: (val) {
        if (val) onSelected();
      },
    );
  }
}

/// Stepper input control for manipulating numbers in sandbox demos.
class SandboxStepper extends ConsumerWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const SandboxStepper({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: GameTheme.textMuted, fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: GameTheme.surfaceElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: GameTheme.borderSubtle),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(Icons.remove_rounded, color: GameTheme.amberAccent, size: 16),
                onPressed: () {
                  ref.read(soundServiceProvider).playTap();
                  onChanged(value - 1);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '$value',
                  style: const TextStyle(color: GameTheme.textWhite, fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(Icons.add_rounded, color: GameTheme.amberAccent, size: 16),
                onPressed: () {
                  ref.read(soundServiceProvider).playTap();
                  onChanged(value + 1);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Live calculation output box for sandbox demonstrations.
class SandboxResultBox extends StatelessWidget {
  final String expression;
  final String stepExplanation;
  final String result;

  const SandboxResultBox({
    super.key,
    required this.expression,
    required this.stepExplanation,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: GameTheme.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: GameTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                expression,
                style: const TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: GameTheme.amberGlow,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '= $result',
                  style: const TextStyle(color: GameTheme.amberAccent, fontSize: 13, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            stepExplanation,
            style: const TextStyle(color: GameTheme.textLight, fontSize: 11, height: 1.45),
          ),
        ],
      ),
    );
  }
}
