import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math/controllers/game_controller.dart';
import 'package:math/screens/riddle_screen.dart';
import 'package:math/screens/shop_screen.dart';
import 'package:math/services/monetization_service.dart';
import 'package:math/services/progress_service.dart';

class MockAdService implements IAdService {
  int rewardedAdCount = 0;
  bool returnSuccess = true;

  @override
  Future<void> initialize() async {}

  @override
  bool get isRewardedAdAvailable => true;

  @override
  Future<bool> showInterstitialAd() async => true;

  @override
  Future<bool> showChallengeExitInterstitial() async => true;

  @override
  Future<bool> showRewardedAd({
    required VoidCallback onRewardEarned,
    VoidCallback? onFailed,
  }) async {
    rewardedAdCount++;
    if (returnSuccess) {
      onRewardEarned();
      return true;
    }
    onFailed?.call();
    return false;
  }
}

void main() {
  group('Heart Deduction & Out-of-Hearts Flow Verification', () {
    test('Deducts exactly 1 heart immediately on incorrect answer without delay and persists after restart', () async {
      SharedPreferences.setMockInitialValues({
        'math_current_hearts': 5,
        'math_highest_unlocked_level': 1,
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      final containerRef = ProviderContainer(
        overrides: [
          progressServiceProvider.overrideWithValue(progressService),
        ],
      );
      addTearDown(containerRef.dispose);

      final controller = containerRef.read(gameControllerProvider.notifier);
      expect(containerRef.read(gameControllerProvider).hearts, equals(5));

      // Append incorrect digit for Level 1 (correct is '6')
      controller.appendDigit('9');
      expect(containerRef.read(gameControllerProvider).currentInput, equals('9'));

      // Validate answer
      final isCorrect = await controller.validateAnswer();
      expect(isCorrect, isFalse);

      // Heart must be deducted immediately to 4
      expect(containerRef.read(gameControllerProvider).hearts, equals(4));
      expect(progressService.currentHearts, equals(4));

      // Simulate App Restart with saved prefs: must retain 4 hearts
      final restartPrefs = await SharedPreferences.getInstance();
      final restartProgress = ProgressService(restartPrefs);
      expect(restartProgress.currentHearts, equals(4));

      final restartContainer = ProviderContainer(
        overrides: [
          progressServiceProvider.overrideWithValue(restartProgress),
        ],
      );
      addTearDown(restartContainer.dispose);
      expect(restartContainer.read(gameControllerProvider).hearts, equals(4));
    });

    test('Correct answers never consume hearts', () async {
      SharedPreferences.setMockInitialValues({
        'math_current_hearts': 4,
        'math_highest_unlocked_level': 1,
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      final container = ProviderContainer(
        overrides: [
          progressServiceProvider.overrideWithValue(progressService),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(gameControllerProvider.notifier);
      expect(container.read(gameControllerProvider).hearts, equals(4));

      // Level 1 solution is '6'
      controller.appendDigit('6');
      final isCorrect = await controller.validateAnswer();
      expect(isCorrect, isTrue);

      // Hearts count must remain 4 (never deducted on correct answer)
      expect(container.read(gameControllerProvider).hearts, equals(4));
      expect(progressService.currentHearts, equals(4));
    });

    test('Deduction occurs exactly once per incorrect attempt', () async {
      SharedPreferences.setMockInitialValues({
        'math_current_hearts': 3,
        'math_highest_unlocked_level': 1,
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      final container = ProviderContainer(
        overrides: [
          progressServiceProvider.overrideWithValue(progressService),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(gameControllerProvider.notifier);
      controller.appendDigit('8'); // incorrect for level 1

      // Single attempt validation
      final isCorrect = await controller.validateAnswer();
      expect(isCorrect, isFalse);

      // Exactly 1 heart deducted (3 -> 2)
      expect(container.read(gameControllerProvider).hearts, equals(2));
      expect(progressService.currentHearts, equals(2));
    });

    testWidgets('When all 5 hearts are exhausted, shows elegant popup with all 4 choices and preserves progress', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final mockAds = MockAdService();
      SharedPreferences.setMockInitialValues({
        'math_current_hearts': 1, // Only 1 heart remaining before exhaustion
        'math_highest_unlocked_level': 1,
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
            adServiceProvider.overrideWithValue(mockAds),
          ],
          child: const MaterialApp(
            home: RiddleScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Ensure Level 1 is active
      expect(find.text('LEVEL 1'), findsOneWidget);

      // Enter incorrect answer '9'
      await tester.tap(find.text('9'));
      await tester.pump();

      // Submit incorrect answer
      await tester.tap(find.text('ENTER'));
      await tester.pump(); // immediate frame

      // Heart count updates immediately to 0
      expect(progressService.currentHearts, equals(0));

      // Settle dialog animation
      await tester.pump(const Duration(milliseconds: 400));

      // Out-of-hearts popup must appear
      expect(find.text('Out of Hearts'), findsOneWidget);
      expect(find.textContaining('You need at least 1 heart to submit an answer'), findsOneWidget);

      // Verify all 4 required choices are present
      expect(find.text('Watch an Ad for 5 Hearts (Full Refill)'), findsOneWidget);
      expect(find.text('Buy Premium for Unlimited Hearts'), findsOneWidget);
      expect(find.text('Wait for Hearts to Refill'), findsOneWidget);
      expect(find.text('No Thanks'), findsOneWidget);

      // Test "No Thanks" option: dismisses popup without pressure and preserves level & progress
      await tester.tap(find.text('No Thanks'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Dialog is dismissed
      expect(find.text('Out of Hearts'), findsNothing);
      // Player is still on Level 1, progress intact
      expect(find.text('LEVEL 1'), findsOneWidget);

      // Tap ENTER again while out of hearts
      await tester.tap(find.text('ENTER'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Popup reappears
      expect(find.text('Out of Hearts'), findsOneWidget);

      // Test "Wait for Hearts to Refill": closes popup smoothly
      await tester.tap(find.text('Wait for Hearts to Refill'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Out of Hearts'), findsNothing);
      expect(find.text('LEVEL 1'), findsOneWidget);

      // Open popup again and test "Watch an Ad for 5 Hearts (Full Refill)"
      await tester.tap(find.text('ENTER'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Out of Hearts'), findsOneWidget);

      await tester.tap(find.text('Watch an Ad for 5 Hearts (Full Refill)'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Ad reward granted full 5 hearts
      expect(mockAds.rewardedAdCount, equals(1));
      expect(progressService.currentHearts, equals(5));
      expect(find.text('Out of Hearts'), findsNothing);
    });

    testWidgets('Buy Premium for Unlimited Hearts navigates to ShopScreen and returns with level intact', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({
        'math_current_hearts': 0, // Exhausted
        'math_highest_unlocked_level': 1,
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: const MaterialApp(
            home: RiddleScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap ENTER to trigger out of hearts popup
      await tester.tap(find.text('ENTER'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Out of Hearts'), findsOneWidget);

      // Tap Buy Premium for Unlimited Hearts
      await tester.tap(find.text('Buy Premium for Unlimited Hearts'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      // Navigated to ShopScreen
      expect(find.byType(ShopScreen), findsOneWidget);
      expect(find.text('UPGRADE ACCESS'), findsOneWidget);

      // Close ShopScreen to return to RiddleScreen
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      // Returned to RiddleScreen: Level 1 and progress fully preserved
      expect(find.byType(RiddleScreen), findsOneWidget);
      expect(find.text('LEVEL 1'), findsOneWidget);
    });
  });
}
