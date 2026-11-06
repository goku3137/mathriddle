import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';

class CustomKeypad extends ConsumerWidget {
  final String inputString;
  final ValueChanged<String> onDigitPressed;
  final VoidCallback onClear;
  final VoidCallback? onDelete;
  final VoidCallback onHintPressed;
  final VoidCallback onSubmit;
  final bool hasVibration;
  final bool showHint;

  const CustomKeypad({
    super.key,
    required this.inputString,
    required this.onDigitPressed,
    required this.onClear,
    this.onDelete,
    required this.onHintPressed,
    required this.onSubmit,
    this.hasVibration = true,
    this.showHint = true,
  });

  void _feedback(WidgetRef ref) {
    if (hasVibration) {
      HapticFeedback.lightImpact();
    }
    ref.read(soundServiceProvider).playTap();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: GameTheme.background,
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Live Input Indicator Bar with optional Bulb action
          _buildTopActionRow(ref),
          const SizedBox(height: 10),

          // 2. Standard 4-Row × 3-Column Ergonomic Numeric Pad (1-9, 0, DEL, ENTER)
          _buildNumericRow(ref, ['1', '2', '3']),
          const SizedBox(height: 8),
          _buildNumericRow(ref, ['4', '5', '6']),
          const SizedBox(height: 8),
          _buildNumericRow(ref, ['7', '8', '9']),
          const SizedBox(height: 8),
          _buildBottomActionRow(ref),
        ],
      ),
    );
  }

  Widget _buildTopActionRow(WidgetRef ref) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: GameTheme.borderSubtle, width: 1.0),
      ),
      child: Row(
        children: [
          // Left: User input display with Clear '✕' trigger
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      inputString.isEmpty ? 'Answer' : inputString,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: inputString.isEmpty ? GameTheme.textDim : GameTheme.textWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ),
                  if (inputString.isNotEmpty)
                    Semantics(
                      button: true,
                      label: 'Clear input',
                      child: GestureDetector(
                        onTap: () {
                          _feedback(ref);
                          onClear();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(Icons.close_rounded, color: GameTheme.textMuted, size: 20),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          if (showHint) ...[
            // Divider
            Container(width: 1, height: 26, color: GameTheme.borderSubtle),

            // Lightbulb Icon (Triggers Need Help Modal)
            IconButton(
              icon: const Icon(Icons.lightbulb_outline_rounded, color: GameTheme.amberAccent, size: 22),
              tooltip: 'Need Help?',
              onPressed: () {
                _feedback(ref);
                onHintPressed();
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNumericRow(WidgetRef ref, List<String> digits) {
    return Row(
      children: digits
          .map(
            (digit) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildDigitButton(ref, digit),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBottomActionRow(WidgetRef ref) {
    return Row(
      children: [
        // Bottom-Left: Backspace / DEL
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildDeleteButton(ref),
          ),
        ),

        // Bottom-Center: '0' Digit
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildDigitButton(ref, '0'),
          ),
        ),

        // Bottom-Right: 'ENTER' Submit
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildSubmitButton(ref),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitButton(WidgetRef ref, String digit) {
    return Material(
      color: GameTheme.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          _feedback(ref);
          onDigitPressed(digit);
        },
        splashColor: GameTheme.amberAccent.withValues(alpha: 0.15),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: GameTheme.borderSubtle, width: 1.0),
          ),
          child: Text(
            digit,
            style: const TextStyle(
              color: GameTheme.textWhite,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(WidgetRef ref) {
    return Material(
      color: GameTheme.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          _feedback(ref);
          if (onDelete != null) {
            onDelete!();
          } else {
            onClear();
          }
        },
        onLongPress: () {
          _feedback(ref);
          onClear();
        },
        splashColor: GameTheme.amberAccent.withValues(alpha: 0.15),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: GameTheme.borderSubtle, width: 1.0),
          ),
          child: Semantics(
            button: true,
            label: 'Backspace',
            child: const Icon(
              Icons.backspace_outlined,
              color: GameTheme.textMuted,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(WidgetRef ref) {
    return Material(
      color: GameTheme.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          _feedback(ref);
          onSubmit();
        },
        splashColor: GameTheme.amberAccent.withValues(alpha: 0.25),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.4), width: 1.2),
            color: GameTheme.amberAccent.withValues(alpha: 0.08),
          ),
          child: const Text(
            'ENTER',
            style: TextStyle(
              color: GameTheme.amberAccent,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
