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
    expect(find.text('Rate Math Riddles'), findsOneWidget);

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

  test('ProgressService sanitizes impossible score to verified maximum on launch', () async {
    // Attacker modified SharedPreferences with 99,999 score without completing levels
    SharedPreferences.setMockInitialValues({
      'math_total_score': 99999,
      'math_completed_levels': <String>['1'], // Only level 1 is completed (max 5 pts)
    });
    final prefs = await SharedPreferences.getInstance();
    final progressService = ProgressService(prefs);

    // Score must be clamped to the verified theoretical maximum (5)
    expect(progressService.totalScore, equals(5));
    expect(progressService.isStorageTampered, isTrue);
  });

  test('GameController loads procedural level cleanly on cold start for levels > 20', () async {
    SharedPreferences.setMockInitialValues({
      'math_highest_unlocked_level': 25,
      'math_completed_levels': List.generate(24, (i) => '${i + 1}'),
    });
    final prefs = await SharedPreferences.getInstance();
    final progressService = ProgressService(prefs);

    final container = ProviderContainer(
      overrides: [
        progressServiceProvider.overrideWithValue(progressService),
      ],
    );
    addTearDown(container.dispose);

    final state = container.read(gameControllerProvider);
    expect(state.activeLevelNumber, equals(25));
    expect(state.loadedLevel, isNotNull);
    expect(state.loadedLevel!.levelNumber, equals(25));
    expect(state.currentLevel.levelNumber, equals(25));
  });

  testWidgets('Learn Screen navigates, presents curriculum, and awards 50 points on correct practice question', (WidgetTester tester) async {
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
        child: const MathRiddlesApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Tap LEARN button
    expect(find.text('LEARN'), findsOneWidget);
    await tester.tap(find.text('LEARN'));
    await tester.pumpAndSettle();

    // Verify Learn Screen UI elements
    expect(find.text('LEARNING CURRICULUM'), findsOneWidget);
    expect(find.text('0 of 36 Concepts Mastered'), findsOneWidget);
    expect(find.text('+0 PTS'), findsOneWidget);
    expect(find.text('1. Understanding Numbers & Place Values'), findsOneWidget);

    // Tap first lesson
    await tester.tap(find.text('1. Understanding Numbers & Place Values'));
    await tester.pumpAndSettle();

    // Verify Lesson Detail Screen
    expect(find.text('CORE FORMULA & SHORTCUT'), findsOneWidget);
    expect(find.text('STEP-BY-STEP REASONING'), findsOneWidget);

    // Drag down to reveal interactive practice question
    await tester.drag(find.byType(ListView), const Offset(0, -1400));
    await tester.pumpAndSettle();

    expect(find.text('INTERACTIVE PRACTICE TEST'), findsOneWidget);
    expect(find.text('In the number 752, what is the value of the digit 5?'), findsOneWidget);

    // Select correct option '50'
    await tester.tap(find.text('50'));
    await tester.pump();

    // Tap SUBMIT ANSWER
    await tester.tap(find.text('SUBMIT ANSWER'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify success feedback and score update
    expect(find.text('EXCELLENT! ANSWER CORRECT'), findsOneWidget);
    expect(progressService.totalScore, equals(50));
    expect(progressService.isLearnTopicCompleted('stage1_lesson1_place_values'), isTrue);

    // Return back to Learn Screen
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    // Verify progress card now reflects 1 mastered and +50 PTS
    expect(find.text('1 of 36 Concepts Mastered'), findsOneWidget);
    expect(find.text('+50 PTS'), findsOneWidget);
  });
}
