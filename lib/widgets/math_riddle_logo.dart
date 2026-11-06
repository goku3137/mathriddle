import 'package:flutter/material.dart';
import '../theme/game_theme.dart';

/// Pure typographic wordmark logo for "MATH RIDDLE".
/// Clean, architectural, and distraction-free without cluttered graphic illustrations.
class MathRiddleLogo extends StatelessWidget {
  final double scale;
  final bool showSubtitle;
  final bool isHorizontal;

  const MathRiddleLogo({
    super.key,
    this.scale = 1.0,
    this.showSubtitle = true,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _buildHorizontalLogo();
    }
    return _buildStackedLogo();
  }

  Widget _buildStackedLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Subtle Top Minimalist Framing Corner (Left)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Word 1: MATH
              Text(
                'MATH',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 38 * scale,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 8.0 * scale,
                  height: 1.1,
                ),
              ),

              // Architectural Golden Accent Rule
              SizedBox(height: 6 * scale),
              Container(
                width: 90 * scale,
                height: 2.2 * scale,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      GameTheme.amberAccent.withAlpha(40),
                      GameTheme.amberAccent,
                      GameTheme.amberAccent.withAlpha(40),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 8 * scale),

              // Word 2: RIDDLE
              Text(
                'RIDDLE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 10.0 * scale,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),

        if (showSubtitle) ...[
          SizedBox(height: 8 * scale),
          Text(
            'MIND & LOGIC',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: GameTheme.textMuted,
              fontSize: 10 * scale,
              fontWeight: FontWeight.w500,
              letterSpacing: 4.0 * scale,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHorizontalLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'MATH',
              style: TextStyle(
                color: GameTheme.textWhite,
                fontSize: 24 * scale,
                fontWeight: FontWeight.w900,
                letterSpacing: 4.0 * scale,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8 * scale),
              child: Container(
                width: 4 * scale,
                height: 4 * scale,
                decoration: const BoxDecoration(
                  color: GameTheme.amberAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Text(
              'RIDDLE',
              style: TextStyle(
                color: GameTheme.amberAccent,
                fontSize: 24 * scale,
                fontWeight: FontWeight.w700,
                letterSpacing: 4.0 * scale,
              ),
            ),
          ],
        ),
        if (showSubtitle) ...[
          SizedBox(height: 4 * scale),
          Text(
            'LOGIC & PUZZLES',
            style: TextStyle(
              color: GameTheme.textDim,
              fontSize: 9 * scale,
              fontWeight: FontWeight.w500,
              letterSpacing: 3.0 * scale,
            ),
          ),
        ],
      ],
    );
  }
}

