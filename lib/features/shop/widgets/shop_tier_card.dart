import 'package:flutter/material.dart';
import '../../../theme/game_theme.dart';

/// Card displaying an individual pricing tier in the shop screen.
class ShopTierCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? originalPrice;
  final String price;
  final String badgeText;
  final List<String> features;
  final VoidCallback onPurchase;
  final String ctaLabel;
  final bool isOwned;
  final bool isBestValue;

  const ShopTierCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.originalPrice,
    required this.price,
    required this.badgeText,
    required this.features,
    required this.onPurchase,
    required this.ctaLabel,
    this.isOwned = false,
    this.isBestValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isBestValue ? const Color(0xFF1E212B) : GameTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isBestValue ? GameTheme.amberAccent : GameTheme.borderCharcoal,
          width: isBestValue ? 1.8 : 1.0,
        ),
        boxShadow: isBestValue
            ? [
                BoxShadow(
                  color: GameTheme.amberAccent.withAlpha(25),
                  blurRadius: 18,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Title + Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isBestValue ? GameTheme.textWhite : GameTheme.textLight,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: GameTheme.textMuted,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isBestValue
                      ? GameTheme.amberAccent.withAlpha(35)
                      : GameTheme.surfaceElevated,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isBestValue
                        ? GameTheme.amberAccent.withAlpha(140)
                        : GameTheme.borderDivider,
                  ),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: isBestValue ? GameTheme.amberAccent : GameTheme.primaryOrange,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Price Row with Strikethrough Anchor
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              if (originalPrice != null) ...[
                const SizedBox(width: 8),
                Text(
                  originalPrice!,
                  style: const TextStyle(
                    color: GameTheme.textDim,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: GameTheme.textDim,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 14),
          const Divider(color: GameTheme.borderDivider, height: 1),
          const SizedBox(height: 14),

          // Feature Checklist
          ...features.map((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 15,
                    color: isBestValue ? GameTheme.amberAccent : GameTheme.primaryOrange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        color: GameTheme.textLightGrey,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 12),

          // CTA Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isOwned
                    ? GameTheme.surfaceElevated
                    : (isBestValue ? GameTheme.amberAccent : GameTheme.primaryOrange),
                foregroundColor: isOwned
                    ? GameTheme.textMuted
                    : (isBestValue ? Colors.black : Colors.white),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: isBestValue ? 2 : 0,
              ),
              onPressed: isOwned ? null : onPurchase,
              child: Text(
                ctaLabel,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: isBestValue ? FontWeight.w800 : FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

