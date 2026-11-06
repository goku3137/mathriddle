import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math/controllers/game_controller.dart';
import 'package:math/screens/challenge_screen.dart';
import 'package:math/screens/levels_screen.dart';
import 'package:math/screens/riddle_screen.dart';
import 'package:math/screens/shop_screen.dart';
import 'package:math/services/monetization_service.dart';
import 'package:math/services/progress_service.dart';

void main() {
  group('Codebase Bug Audit & Edge Case Verification', () {
    test('ProgressService completedLevelsList safely ignores corrupt non-numeric entries without falsely injecting level 1', () async {
      SharedPreferences.setMockInitialValues({
        'math_completed_levels': <String>['corrupt_data', '', 'NaN', '5', '12'],
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      final completed = progressService.completedLevelsList;
      expect(completed.contains(5), isTrue);
      expect(completed.contains(12), isTrue);
      expect(completed.contains(1), isFalse); // Level 1 is NOT falsely injected
      expect(completed.length, 2);
    });

    testWidgets('RiddleScreen top header renders cleanly without RenderFlex overflow on narrow 320px screen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({
        'math_highest_unlocked_level': 500, // Longest level title: 'LEVEL 500'
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: const MaterialApp(home: RiddleScreen()),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(tester.takeException(), isNull);
      expect(find.text('LEVEL 500'), findsOneWidget);
    });

    testWidgets('LevelsScreen safely bounds _currentPack when highest unlocked level exceeds 500', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'math_highest_unlocked_level': 501, // Max levels completed
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: const MaterialApp(home: LevelsScreen()),
        ),
      );

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      // Valid pack 5 (levels 401–500)
      expect(find.text('PACK 5 (401–500)'), findsOneWidget);
    });

    testWidgets('ChallengeScreen timer does not crash if popped before expiration', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ChallengeScreen()),
                ),
                child: const Text('GO'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('GO'));
      await tester.pumpAndSettle();

      // Pop widget while 60s timer is running
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Fast forward time past countdown
      await tester.pump(const Duration(seconds: 65));
      expect(tester.takeException(), isNull);
    });

    testWidgets('ShopScreen purchase updates GameController and activates Unlimited Hearts', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: const MaterialApp(home: ShopScreen()),
        ),
      );

      await tester.pumpAndSettle();

      // Tap REMOVE ALL ADS purchase
      expect(find.text('REMOVE ALL ADS'), findsOneWidget);
      await tester.tap(find.text('REMOVE ALL ADS'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(progressService.isAdsRemoved, isTrue);
      expect(progressService.premiumTier, equals(PremiumTier.removeAds));
      expect(find.text('CURRENTLY ACTIVE'), findsOneWidget);
    });
  });
}
