import 'package:flutter_test/flutter_test.dart';
import 'package:math/services/monetization_service.dart';

void main() {
  group('Interstitial Ad Policy (Polite SMATH Standard)', () {
    late ProductionAdService adService;

    setUp(() {
      adService = ProductionAdService();
    });

    test('Riddle Section: Interstitial only triggers on every 9th level', () async {
      // Levels 1 to 8: Should return false (no ad)
      for (int level = 1; level <= 8; level++) {
        final shown = await adService.showInterstitialAd();
        expect(shown, isFalse, reason: 'Level $level should not trigger an interstitial');
      }

      // Level 9: Should trigger true
      final shownAt9 = await adService.showInterstitialAd();
      expect(shownAt9, isTrue, reason: 'Level 9 should trigger an interstitial');

      // Level 10: Should return false
      final shownAt10 = await adService.showInterstitialAd();
      expect(shownAt10, isFalse, reason: 'Level 10 should not trigger an interstitial');
    });

    test('120-second cooldown suppresses interstitial if triggered too soon', () async {
      // Simulate level 9 trigger
      for (int i = 0; i < 8; i++) {
        await adService.showInterstitialAd();
      }
      final firstAd = await adService.showInterstitialAd();
      expect(firstAd, isTrue);

      // Now trigger challenge exit immediately: should be suppressed by 120s cooldown
      final challengeExitAd = await adService.showChallengeExitInterstitial();
      expect(challengeExitAd, isFalse, reason: 'Challenge exit should be suppressed by 120s cooldown');
    });

    test('Challenge Exit triggers interstitial ad when cooldown is satisfied', () async {
      final shown = await adService.showChallengeExitInterstitial();
      expect(shown, isTrue, reason: 'Challenge exit should trigger an interstitial when no cooldown active');

      // Second immediate exit should be suppressed
      final secondShown = await adService.showChallengeExitInterstitial();
      expect(secondShown, isFalse, reason: 'Immediate repeat exit must be suppressed by cooldown');
    });
  });
}

