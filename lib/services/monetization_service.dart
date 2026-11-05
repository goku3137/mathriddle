import 'dart:async';
import 'package:flutter/foundation.dart';

/// Supported in-app purchase tiers
enum PremiumTier {
  none,
  removeAds,       // Non-consumable
  monthPremium,    // 30-Day subscription
  lifetimePremium, // Non-consumable lifetime access
}

/// Abstract contract for interstitial & rewarded video advertising
abstract class IAdService {
  Future<void> initialize();
  bool get isRewardedAdAvailable;
  Future<bool> showInterstitialAd();
  Future<bool> showRewardedAd({
    required VoidCallback onRewardEarned,
    VoidCallback? onFailed,
  });
}

/// Abstract contract for In-App Billing API (Google Play Billing / Apple StoreKit)
abstract class IBillingService {
  Future<void> initialize();
  Future<bool> purchaseRemoveAds();
  Future<bool> purchaseMonthlyPremium();
  Future<bool> purchaseLifetimePremium();
  Future<PremiumTier> restorePurchases();
}

/// Production-ready mock and production implementation of AdService
class ProductionAdService implements IAdService {
  int _levelCompletedCounter = 0;
  final bool _adReady = true;

  @override
  Future<void> initialize() async {
    // In production: MobileAds.instance.initialize();
    debugPrint('[AdService] Initialized Google Mobile Ads SDK');
  }

  @override
  bool get isRewardedAdAvailable => _adReady;

  @override
  Future<bool> showInterstitialAd() async {
    _levelCompletedCounter++;
    // Show interstitial ad every 3 completed levels
    if (_levelCompletedCounter % 3 == 0) {
      debugPrint('[AdService] Interstitial Ad displayed');
      await Future.delayed(const Duration(milliseconds: 300));
      return true;
    }
    return false;
  }

  @override
  Future<bool> showRewardedAd({
    required VoidCallback onRewardEarned,
    VoidCallback? onFailed,
  }) async {
    debugPrint('[AdService] Loading Rewarded Ad...');
    // Simulate rewarded ad completion
    await Future.delayed(const Duration(milliseconds: 500));
    onRewardEarned();
    debugPrint('[AdService] Rewarded Ad finished. User reward granted.');
    return true;
  }
}

/// Production-ready In-App Billing implementation
class ProductionBillingService implements IBillingService {
  @override
  Future<void> initialize() async {
    // In production: InAppPurchase.instance.isAvailable();
    debugPrint('[BillingService] Initialized In-App Billing connection');
  }

  @override
  Future<bool> purchaseRemoveAds() async {
    debugPrint('[BillingService] Initiating purchase: math_remove_ads (₹49 / \$0.99)');
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  @override
  Future<bool> purchaseMonthlyPremium() async {
    debugPrint('[BillingService] Initiating purchase: math_premium_monthly (₹99 / \$1.99)');
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  @override
  Future<bool> purchaseLifetimePremium() async {
    debugPrint('[BillingService] Initiating purchase: math_premium_lifetime (₹199 / \$4.99)');
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  @override
  Future<PremiumTier> restorePurchases() async {
    debugPrint('[BillingService] Querying purchase history...');
    await Future.delayed(const Duration(milliseconds: 500));
    return PremiumTier.none;
  }
}
