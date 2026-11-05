import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math/controllers/game_controller.dart';
import 'package:math/main.dart';
import 'package:math/services/progress_service.dart';

void main() {
  testWidgets('Math Riddles loads Home Screen with Top-Right Hearts and Score badge beside Settings', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final progressService = ProgressService(prefs);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          progressServiceProvider.overrideWithValue(progressService),
        ],
        child: const MathRiddlesApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify Title & Hero Quote
    expect(find.text('MATH RIDDLES'), findsOneWidget);
    expect(find.text('“Logic is the anatomy of thought. Challenge your limits.”'), findsOneWidget);

    // Verify Top-Right Hearts (5) and Score Badge (0 PTS) are present beside Settings
    expect(find.text('5'), findsOneWidget); // 5 Hearts
    expect(find.text('0'), findsOneWidget); // 0 PTS
    expect(find.text('PTS'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

    // Tap Score Badge to verify rules modal
    await tester.tap(find.text('PTS'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('SCORING SYSTEM'), findsOneWidget);
    expect(find.text('+5 PTS per solved riddle'), findsOneWidget);
    expect(find.text('+15 PTS (+10 increase per 10 levels)'), findsOneWidget);
    expect(find.text('+50 PTS per completed concept'), findsOneWidget);
    expect(find.text('+3 PTS per solved challenge'), findsOneWidget);

    // Dismiss dialog
    await tester.tap(find.text('GOT IT'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify 3 Core Menu Buttons
    expect(find.text('RIDDLE'), findsOneWidget);
    expect(find.text('LEARN'), findsOneWidget);
    expect(find.text('CHALLENGE'), findsOneWidget);

    // Verify Top-Right Crown PRO Badge & Rate Us Footer
    expect(find.text('PRO'), findsOneWidget);
    expect(find.text('Rate Us ★★★★★'), findsOneWidget);

    // Tap RIDDLE button to navigate to Level Select
    await tester.tap(find.text('RIDDLE'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify LEVEL SELECT screen header and 20 containers
    expect(find.text('LEVEL SELECT'), findsOneWidget);
    expect(find.text('1'), findsOneWidget); // Box 1 unlocked
    expect(find.byIcon(Icons.lock_outline_rounded), findsWidgets); // Locked boxes 2-20
  });

  test('Scoring calculations award points only once across riddles, learn, and challenges', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final progressService = ProgressService(prefs);

    final container = ProviderContainer(
      overrides: [
        progressServiceProvider.overrideWithValue(progressService),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(gameControllerProvider.notifier);

    // 1. Point escalation formula: +5 for 1-10, +15 for 11-20, +25 for 21-30 (+10 per 10 levels)
    expect(controller.getPointsForLevel(1), equals(5));
    expect(controller.getPointsForLevel(10), equals(5));
    expect(controller.getPointsForLevel(11), equals(15));
    expect(controller.getPointsForLevel(20), equals(15));
    expect(controller.getPointsForLevel(21), equals(25));

    // 2. Solving level 1 awards 5 points once
    controller.appendDigit('6'); // Correct answer for Level 1 is '6'
    final isCorrect = await controller.validateAnswer();
    expect(isCorrect, isTrue);
    expect(progressService.totalScore, equals(5));
    expect(container.read(gameControllerProvider).totalScore, equals(5));

    // Attempting to solve level 1 again does not duplicate points
    controller.appendDigit('6');
    final isDuplicateCorrect = await controller.validateAnswer();
    expect(isDuplicateCorrect, isTrue);
    expect(progressService.totalScore, equals(5)); // Remains 5

    // 3. Completing Learn lesson awards 50 points once
    final learnAwarded = await controller.completeLearnTopic('topic_pemdas');
    expect(learnAwarded, isTrue);
    expect(progressService.totalScore, equals(55)); // 5 + 50 = 55
    expect(container.read(gameControllerProvider).totalScore, equals(55));

    // Re-completing the same learn lesson does not duplicate points
    final duplicateLearn = await controller.completeLearnTopic('topic_pemdas');
    expect(duplicateLearn, isFalse);
    expect(progressService.totalScore, equals(55));

    // 4. Completing Challenge awards 3 points once
    final challengeAwarded = await controller.completeChallenge('c1');
    expect(challengeAwarded, isTrue);
    expect(progressService.totalScore, equals(58)); // 55 + 3 = 58
    expect(container.read(gameControllerProvider).totalScore, equals(58));

    // Re-completing the same challenge does not duplicate points
    final duplicateChallenge = await controller.completeChallenge('c1');
    expect(duplicateChallenge, isFalse);
    expect(progressService.totalScore, equals(58)); // Remains 58
  });

  test('Heart system starts with 5 hearts, consumes on error, and refills after 20 minutes', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final progressService = ProgressService(prefs);

    // Initial state: 5 hearts
    expect(progressService.currentHearts, equals(5));
    expect(progressService.secondsUntilNextHeart, equals(0));

    // Consuming a heart (e.g. wrong answer)
    final consumed = await progressService.consumeHeart();
    expect(consumed, isTrue);
    expect(progressService.currentHearts, equals(4));
    expect(progressService.secondsUntilNextHeart, inInclusiveRange(1190, 1200)); // ~20 min

    // Consume down to 0
    await progressService.consumeHeart();
    await progressService.consumeHeart();
    await progressService.consumeHeart();
    await progressService.consumeHeart();
    expect(progressService.currentHearts, equals(0));

    // Consuming with 0 hearts returns false
    final consumeFailed = await progressService.consumeHeart();
    expect(consumeFailed, isFalse);

    // Fast-forward 20 minutes (1200 seconds): 1 heart should refill!
    final lastTime = prefs.getInt('math_last_heart_timestamp')!;
    await prefs.setInt('math_last_heart_timestamp', lastTime - (20 * 60 * 1000));
    expect(progressService.currentHearts, equals(1));

    // Fast-forward 80 more minutes (4 * 20 min): all remaining 4 hearts refill to max 5!
    await prefs.setInt('math_last_heart_timestamp', lastTime - (100 * 60 * 1000));
    expect(progressService.currentHearts, equals(5));
    expect(progressService.secondsUntilNextHeart, equals(0));
  });
}
