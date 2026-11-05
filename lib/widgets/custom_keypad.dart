import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/game_theme.dart';

class CustomKeypad extends StatelessWidget {
  final String inputString;
  final ValueChanged<String> onDigitPressed;
  final VoidCallback onClear;
  final VoidCallback onHintPressed;
  final VoidCallback onSubmit;
  final bool hasVibration;

  const CustomKeypad({
    super.key,
    required this.inputString,
    required this.onDigitPressed,
    required this.onClear,
    required this.onHintPressed,
    required this.onSubmit,
    this.hasVibration = true,
  });

  void _vibrate() {
    if (hasVibration) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GameTheme.background,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Live Input Indicator Bar with Bulb and Enter Actions
          _buildTopActionRow(),
          const SizedBox(height: 12),

          // 2. Strict Inbuilt 2-Row × 5-Column Numeric Pad (0-9)
          _buildNumericRow(['1', '2', '3', '4', '5']),
          const SizedBox(height: 8),
          _buildNumericRow(['6', '7', '8', '9', '0']),
        ],
      ),
    );
  }

  Widget _buildTopActionRow() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: GameTheme.borderSubtle, width: 1.0),
      ),
      child: Row(
        children: [
          // Left: User input display with Clear '✕' trigger
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  if (inputString.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _vibrate();
                        onClear();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(Icons.close_rounded, color: GameTheme.textMuted, size: 20),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Divider
          Container(width: 1, height: 26, color: GameTheme.borderSubtle),

          // Center: Lightbulb Icon (Triggers Need Help Modal)
          IconButton(
            icon: const Icon(Icons.lightbulb_outline_rounded, color: GameTheme.amberAccent, size: 22),
            tooltip: 'Need Help?',
            onPressed: () {
              _vibrate();
              onHintPressed();
            },
          ),

          // Divider
          Container(width: 1, height: 26, color: GameTheme.borderSubtle),

          // Right: Bold ENTER button
          InkWell(
            onTap: () {
              _vibrate();
              onSubmit();
            },
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: const Text(
                'ENTER',
                style: TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumericRow(List<String> digits) {
    return Row(
      children: digits
          .map(
            (digit) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildDigitButton(digit),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDigitButton(String digit) {
    return Material(
      color: GameTheme.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          _vibrate();
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
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
