import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../services/monetization_service.dart';
import '../theme/game_theme.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(gameControllerProvider);
    final billing = ref.read(billingServiceProvider);
    final progress = ref.watch(progressServiceProvider);

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: GameTheme.textWhite, size: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'SHOP',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w300,
            letterSpacing: 3.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Subtitle
            const Center(
              child: Text(
                'ENJOY DISTRACTION-FREE LOGIC',
                style: TextStyle(
                  color: GameTheme.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Card 1: REMOVE ADS
            _buildShopCard(
              context: context,
              title: 'REMOVE ADS',
              accessType: 'Lifetime Access',
              description: 'No forced ads between levels. Rewarded ads for hints remain optional.',
              badgeText: 'AD FREE',
              priceText: '₹49 / \$0.99',
              isOwned: progress.isAdsRemoved,
              onPurchase: () async {
                final success = await billing.purchaseRemoveAds();
                if (success) {
                  await progress.setPremiumTier(PremiumTier.removeAds);
                  ref.invalidate(gameControllerProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ads removed successfully!')),
                    );
                  }
                }
              },
            ),

            const SizedBox(height: 18),

            // Card 2: A MONTH PREMIUM
            _buildShopCard(
              context: context,
              title: 'A MONTH PREMIUM',
              accessType: '30 Day Access',
              description: 'Free hints, free solutions, zero forced ads for 30 consecutive days.',
              badgeText: '30',
              hasCrownBadge: true,
              priceText: '₹99 / \$1.99',
              isOwned: progress.premiumTier == PremiumTier.monthPremium,
              onPurchase: () async {
                final success = await billing.purchaseMonthlyPremium();
                if (success) {
                  await progress.setPremiumTier(PremiumTier.monthPremium);
                  ref.invalidate(gameControllerProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('30-Day Premium activated!')),
                    );
                  }
                }
              },
            ),

            const SizedBox(height: 18),

            // Card 3: LIFETIME PREMIUM
            _buildShopCard(
              context: context,
              title: 'LIFETIME PREMIUM',
              accessType: 'Lifetime Access',
              description: 'All future levels, instant free solutions, zero ads permanently unlocked.',
              badgeText: '∞',
              hasCrownBadge: true,
              priceText: '₹199 / \$4.99',
              isOwned: progress.premiumTier == PremiumTier.lifetimePremium,
              isBestValue: true,
              onPurchase: () async {
                final success = await billing.purchaseLifetimePremium();
                if (success) {
                  await progress.setPremiumTier(PremiumTier.lifetimePremium);
                  ref.invalidate(gameControllerProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lifetime Premium activated!')),
                    );
                  }
                }
              },
            ),

            const SizedBox(height: 24),

            // Restore purchase link
            Center(
              child: TextButton(
                onPressed: () async {
                  final restoredTier = await billing.restorePurchases();
                  if (restoredTier != PremiumTier.none) {
                    await progress.setPremiumTier(restoredTier);
                    ref.invalidate(gameControllerProvider);
                  }
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Purchase status refreshed.')),
                    );
                  }
                },
                child: const Text(
                  'Restore Purchases',
                  style: TextStyle(
                    color: GameTheme.textMuted,
                    fontSize: 12,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopCard({
    required BuildContext context,
    required String title,
    required String accessType,
    required String description,
    required String badgeText,
    required String priceText,
    required VoidCallback onPurchase,
    bool isOwned = false,
    bool hasCrownBadge = false,
    bool isBestValue = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isBestValue ? GameTheme.primaryOrange : GameTheme.borderCharcoal,
          width: isBestValue ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: GameTheme.surfaceElevated,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: GameTheme.borderDivider),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasCrownBadge) ...[
                      const Icon(Icons.workspace_premium_rounded, color: GameTheme.primaryOrange, size: 14),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      badgeText,
                      style: const TextStyle(
                        color: GameTheme.primaryOrange,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            accessType,
            style: const TextStyle(
              color: GameTheme.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: GameTheme.textLightGrey,
              fontSize: 13,
              fontWeight: FontWeight.w300,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isOwned ? GameTheme.surfaceElevated : GameTheme.primaryOrange,
                foregroundColor: isOwned ? GameTheme.textMuted : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              onPressed: isOwned ? null : onPurchase,
              child: Text(
                isOwned ? 'CURRENTLY ACTIVE' : priceText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

