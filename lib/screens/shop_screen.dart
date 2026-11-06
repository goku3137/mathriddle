import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../features/shop/widgets/shop_tier_card.dart';
import '../services/monetization_service.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(gameControllerProvider);
    final billing = ref.read(billingServiceProvider);
    final progress = ref.watch(progressServiceProvider);

    final isLifetimeOwned = progress.premiumTier == PremiumTier.lifetimePremium;
    final isMonthOwned = progress.premiumTier == PremiumTier.monthPremium;
    final isAdsRemovedOwned = progress.isAdsRemoved;

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: GameTheme.textWhite, size: 24),
          onPressed: () {
            ref.read(soundServiceProvider).playTap();
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'UPGRADE ACCESS',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            // Header Hero Section
            Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: GameTheme.amberGlow,
                  shape: BoxShape.circle,
                  border: Border.all(color: GameTheme.amberAccent.withAlpha(120), width: 1.5),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: GameTheme.amberAccent,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'DISTRACTION-FREE BRAIN TRAINING',
                style: TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                'Focus purely on logic. No interruptions, no wait times.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: GameTheme.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Card 1: LIFETIME VIP (HERO / BEST VALUE TIER)
            ShopTierCard(
              title: 'LIFETIME VIP PASS',
              subtitle: 'Pay Once • Unlimited Forever',
              originalPrice: '₹399 / \$9.99',
              price: '₹199 / \$4.99',
              badgeText: '⭐ BEST VALUE • 50% OFF',
              isBestValue: true,
              isOwned: isLifetimeOwned,
              ctaLabel: isLifetimeOwned ? 'CURRENTLY ACTIVE' : 'GET LIFETIME VIP',
              features: const [
                'Zero ads forever (no interstitials or popups)',
                'Unlimited Hearts (never wait 20m for refills)',
                'Instant Hints & Step-by-Step Solutions',
                'All 500 levels & all future content packs',
                'Golden VIP badge on profile & home screen',
              ],
              onPurchase: () async {
                final success = await billing.purchaseLifetimePremium();
                if (success) {
                  ref.read(soundServiceProvider).playReward();
                  await progress.setPremiumTier(PremiumTier.lifetimePremium);
                  ref.invalidate(gameControllerProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('🎉 Lifetime VIP activated permanently!')),
                    );
                  }
                }
              },
            ),

            const SizedBox(height: 16),

            // Card 2: AD-FREE STARTER
            ShopTierCard(
              title: 'AD-FREE STARTER',
              subtitle: 'Single Purchase • Lifetime Ad Removal',
              originalPrice: null,
              price: '₹49 / \$0.99',
              badgeText: 'POPULAR',
              isBestValue: false,
              isOwned: isAdsRemovedOwned,
              ctaLabel: isAdsRemovedOwned ? 'CURRENTLY ACTIVE' : 'REMOVE ALL ADS',
              features: const [
                'Completely remove forced ads between levels',
                'Smooth uninterrupted puzzle solving flow',
                'Hints & solutions remain accessible anytime',
              ],
              onPurchase: () async {
                final success = await billing.purchaseRemoveAds();
                if (success) {
                  ref.read(soundServiceProvider).playReward();
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

            const SizedBox(height: 16),

            // Card 3: 30-DAY PRO PASS (DECOY TIER)
            ShopTierCard(
              title: '30-DAY PRO PASS',
              subtitle: '30 Days Full Access',
              originalPrice: null,
              price: '₹99 / \$1.99',
              badgeText: 'FLEXIBLE',
              isBestValue: false,
              isOwned: isMonthOwned,
              ctaLabel: isMonthOwned ? 'CURRENTLY ACTIVE' : 'ACTIVATE 30 DAYS',
              features: const [
                'Unlimited Hearts for 30 consecutive days',
                'Zero forced ads between levels',
                'Instant step-by-step hints and solutions',
              ],
              onPurchase: () async {
                final success = await billing.purchaseMonthlyPremium();
                if (success) {
                  ref.read(soundServiceProvider).playReward();
                  await progress.setPremiumTier(PremiumTier.monthPremium);
                  ref.invalidate(gameControllerProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('30-Day Pro Pass activated!')),
                    );
                  }
                }
              },
            ),

            const SizedBox(height: 24),

            // Trust Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTrustItem(Icons.lock_outline_rounded, 'Secure Play Billing'),
                const SizedBox(width: 16),
                _buildTrustItem(Icons.offline_pin_outlined, '100% Offline Ready'),
                const SizedBox(width: 16),
                _buildTrustItem(Icons.history_rounded, 'Restore Anytime'),
              ],
            ),

            const SizedBox(height: 12),

            // Restore Purchases Action
            Center(
              child: TextButton.icon(
                onPressed: () async {
                  final restoredTier = await billing.restorePurchases();
                  if (restoredTier != PremiumTier.none) {
                    await progress.setPremiumTier(restoredTier);
                    ref.invalidate(gameControllerProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Purchases restored successfully!')),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No active purchases found to restore.')),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.refresh_rounded, size: 14, color: GameTheme.textMuted),
                label: const Text(
                  'Restore Previous Purchases',
                  style: TextStyle(
                    color: GameTheme.textMuted,
                    fontSize: 12,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: GameTheme.textDim),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: GameTheme.textDim,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
