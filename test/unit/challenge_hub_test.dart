import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math/controllers/game_controller.dart';
import 'package:math/data/challenge_data.dart';
import 'package:math/screens/challenge_screen.dart';
import 'package:math/screens/challenge_play_screen.dart';
import 'package:math/services/progress_service.dart';

void main() {
  group('Challenge Hub & Arithmetic Categories Verification', () {
    test('Verify all 12 challenge category icons exist in icon libraries', () {
      expect(Icons.add_rounded, isNotNull);
      expect(Icons.remove_rounded, isNotNull);
      expect(Icons.close_rounded, isNotNull);
      expect(CupertinoIcons.divide, isNotNull);
      expect(Icons.superscript_rounded, isNotNull);
      expect(Icons.percent_rounded, isNotNull);
      expect(Icons.trending_up_rounded, isNotNull);
      expect(Icons.question_mark_rounded, isNotNull);
      expect(Icons.balance_rounded, isNotNull);
      expect(Icons.change_circle_outlined, isNotNull);
      expect(Icons.lightbulb_outline_rounded, isNotNull);
      expect(Icons.shuffle_rounded, isNotNull);
    });

    test('Categories are strictly ordered across 12 distinct categories', () {
      expect(challengeCategories.length, equals(12));

      expect(challengeCategories[0].type, equals(ChallengeType.addition));
      expect(challengeCategories[0].title, equals('ADDITION CHALLENGE'));
      expect(challengeCategories[0].icon, equals(Icons.add_rounded));
      expect(challengeCategories[0].symbol, equals('+'));

      expect(challengeCategories[1].type, equals(ChallengeType.subtraction));
      expect(challengeCategories[1].title, equals('SUBTRACTION CHALLENGE'));
      expect(challengeCategories[1].icon, equals(Icons.remove_rounded));
      expect(challengeCategories[1].symbol, equals('−'));

      expect(challengeCategories[2].type, equals(ChallengeType.multiplication));
      expect(challengeCategories[2].title, equals('MULTIPLICATION CHALLENGE'));
      expect(challengeCategories[2].icon, equals(Icons.close_rounded));
      expect(challengeCategories[2].symbol, equals('×'));

      expect(challengeCategories[3].type, equals(ChallengeType.division));
      expect(challengeCategories[3].title, equals('DIVISION CHALLENGE'));
      expect(challengeCategories[3].icon, equals(CupertinoIcons.divide));
      expect(challengeCategories[3].symbol, equals('÷'));

      expect(challengeCategories[4].type, equals(ChallengeType.powers));
      expect(challengeCategories[4].title, equals('SQUARES & POWERS'));
      expect(challengeCategories[4].icon, equals(Icons.superscript_rounded));
      expect(challengeCategories[4].symbol, equals('x²'));

      expect(challengeCategories[5].type, equals(ChallengeType.percentages));
      expect(challengeCategories[5].title, equals('PERCENTAGES & RATES'));
      expect(challengeCategories[5].icon, equals(Icons.percent_rounded));
      expect(challengeCategories[5].symbol, equals('%'));

      expect(challengeCategories[6].type, equals(ChallengeType.sequences));
      expect(challengeCategories[6].title, equals('SEQUENCES & PATTERNS'));
      expect(challengeCategories[6].icon, equals(Icons.trending_up_rounded));
      expect(challengeCategories[6].symbol, equals('⋯'));

      expect(challengeCategories[7].type, equals(ChallengeType.missingNumbers));
      expect(challengeCategories[7].title, equals('MISSING NUMBER PUZZLES'));
      expect(challengeCategories[7].icon, equals(Icons.question_mark_rounded));
      expect(challengeCategories[7].symbol, equals('?'));

      expect(challengeCategories[8].type, equals(ChallengeType.bodmas));
      expect(challengeCategories[8].title, equals('BODMAS PRECEDENCE'));
      expect(challengeCategories[8].icon, equals(Icons.balance_rounded));
      expect(challengeCategories[8].symbol, equals('BODMAS'));

      expect(challengeCategories[9].type, equals(ChallengeType.lateralOperators));
      expect(challengeCategories[9].title, equals('LATERAL OPERATORS'));
      expect(challengeCategories[9].icon, equals(Icons.change_circle_outlined));
      expect(challengeCategories[9].symbol, equals('⊕'));

      expect(challengeCategories[10].type, equals(ChallengeType.mathTricks));
      expect(challengeCategories[10].title, equals('SPEED MATH TRICKS'));
      expect(challengeCategories[10].icon, equals(Icons.lightbulb_outline_rounded));
      expect(challengeCategories[10].symbol, equals('TRICK'));

      expect(challengeCategories[11].type, equals(ChallengeType.mixed));
      expect(challengeCategories[11].title, equals('ALL MIXED GRAND SPRINT'));
      expect(challengeCategories[11].icon, equals(Icons.shuffle_rounded));
      expect(challengeCategories[11].symbol, equals('MIX'));
    });

    test('All sample items across all categories have mathematically correct, non-negative integer answers', () {
      final digitRegex = RegExp(r'^[0-9]+$');

      for (final cat in challengeCategories) {
        expect(cat.items.isNotEmpty, isTrue, reason: '${cat.title} has no items');
        for (final item in cat.items) {
          expect(digitRegex.hasMatch(item.answer.trim()), isTrue,
              reason: 'Invalid answer "${item.answer}" in ${cat.title}');
          expect(int.parse(item.answer) >= 0, isTrue);
        }
      }
    });

    test('ChallengeGenerator dynamically generates continuous random questions for all 12 categories', () {
      final digitRegex = RegExp(r'^[0-9]+$');

      for (final catType in ChallengeType.values) {
        for (int i = 0; i < 25; i++) {
          final item = ChallengeGenerator.generate(catType);
          expect(item.id.isNotEmpty, isTrue);
          expect(item.question.contains('?'), isTrue, reason: 'Missing question mark in ${item.question}');
          expect(digitRegex.hasMatch(item.answer.trim()), isTrue,
              reason: 'Invalid non-integer answer "${item.answer}" for type $catType');
          expect(int.parse(item.answer) >= 0, isTrue);
        }
      }
    });

    testWidgets('ChallengeScreen displays categories in order and launches active infinite challenge', (WidgetTester tester) async {
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
          child: const MaterialApp(home: ChallengeScreen()),
        ),
      );

      await tester.pumpAndSettle();

      // Verify initial categories are displayed in strict order
      expect(find.text('ADDITION CHALLENGE'), findsOneWidget);
      expect(find.text('SUBTRACTION CHALLENGE'), findsOneWidget);
      expect(find.text('MULTIPLICATION CHALLENGE'), findsOneWidget);
      expect(find.text('DIVISION CHALLENGE'), findsOneWidget);

      // Scroll to the bottom to verify ALL MIXED GRAND SPRINT is at the end
      await tester.scrollUntilVisible(
        find.text('ALL MIXED GRAND SPRINT'),
        500.0,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('ALL MIXED GRAND SPRINT'), findsOneWidget);

      // Scroll back up to ADDITION CHALLENGE
      await tester.scrollUntilVisible(
        find.text('ADDITION CHALLENGE'),
        -500.0,
        scrollable: find.byType(Scrollable).first,
      );

      // Tap ADDITION CHALLENGE
      await tester.tap(find.text('ADDITION CHALLENGE'));
      await tester.pumpAndSettle();

      // Verify ChallengePlayScreen opened in 15-second infinite mode
      expect(find.byType(ChallengePlayScreen), findsOneWidget);
      expect(find.textContaining('QUESTION 1'), findsOneWidget);
      expect(find.text('15s'), findsOneWidget);
      expect(find.text('Played 0 times'), findsOneWidget);

      // Pop back to Challenge Hub
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Hub is visible again
      expect(find.text('ADDITION CHALLENGE'), findsOneWidget);
    });

    testWidgets('ChallengePlayScreen resets 15s timer on correct answer and advances to next question', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      int questionCounter = 0;
      final testQuestions = [
        const ChallengeItem(id: 'test_1', question: '5 + 3 = ?', answer: '8', explanation: '5 + 3 = 8'),
        const ChallengeItem(id: 'test_2', question: '7 + 2 = ?', answer: '9', explanation: '7 + 2 = 9'),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: MaterialApp(
            home: ChallengePlayScreen(
              category: challengeCategories[0],
              questionGenerator: (_) => testQuestions[questionCounter++ % testQuestions.length],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Initial state
      expect(find.textContaining('QUESTION 1'), findsOneWidget);
      expect(find.text('5 + 3 = ?'), findsOneWidget);
      expect(find.text('15s'), findsOneWidget);
      expect(find.text('1-Digit'), findsOneWidget);

      // Fast-forward 5 seconds
      await tester.pump(const Duration(seconds: 5));
      expect(find.text('10s'), findsOneWidget);

      // Input correct answer '8'
      await tester.tap(find.widgetWithText(InkWell, '8'));
      await tester.pump();

      // Submit
      await tester.tap(find.text('ENTER'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Verify timer reset back to 15s and advanced to Question 2
      expect(find.textContaining('QUESTION 2'), findsOneWidget);
      expect(find.text('7 + 2 = ?'), findsOneWidget);
      expect(find.text('15s'), findsOneWidget);
      expect(find.text('STREAK: 1 (+3 PTS)'), findsOneWidget);
      expect(progressService.totalScore, equals(3));
    });

    testWidgets('ChallengePlayScreen never terminates on wrong answer, shows explanation popup, and continues', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      int questionCounter = 0;
      final testQuestions = [
        const ChallengeItem(id: 'q1', question: '4 + 5 = ?', answer: '9', explanation: '4 + 5 = 9'),
        const ChallengeItem(id: 'q2', question: '6 + 3 = ?', answer: '9', explanation: '6 + 3 = 9'),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: MaterialApp(
            home: ChallengePlayScreen(
              category: challengeCategories[0],
              questionGenerator: (_) => testQuestions[questionCounter++ % testQuestions.length],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Input wrong answer '7'
      await tester.tap(find.widgetWithText(InkWell, '7'));
      await tester.pump();

      // Submit wrong answer
      await tester.tap(find.text('ENTER'));
      await tester.pumpAndSettle();

      // Verify Wrong Answer Popup appeared displaying "INCORRECT", correct answer, and explanation
      expect(find.text('INCORRECT'), findsOneWidget);
      expect(find.text('Correct answer:'), findsOneWidget);
      expect(find.text('Your answer:'), findsOneWidget);
      expect(find.descendant(of: find.byType(AlertDialog), matching: find.text('7')), findsOneWidget);
      expect(find.descendant(of: find.byType(AlertDialog), matching: find.text('9')), findsOneWidget);
      expect(find.text('4 + 5 = 9'), findsOneWidget);
      expect(find.text('CONTINUE'), findsOneWidget);

      // Dismiss popup via CONTINUE
      await tester.tap(find.text('CONTINUE'));
      await tester.pumpAndSettle();

      // Requirement 5 & 7: Challenge NEVER ended! Immediately loaded next question with fresh 15s timer
      expect(find.text('INCORRECT'), findsNothing);
      expect(find.text('6 + 3 = ?'), findsOneWidget);
      expect(find.text('15s'), findsOneWidget);
      expect(find.textContaining('QUESTION 2'), findsOneWidget);
      expect(find.text('Played 1 time'), findsOneWidget);
    });

    testWidgets('ChallengePlayScreen timeout shows correct answer & explanation and continues to next question', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      int questionCounter = 0;
      final testQuestions = [
        const ChallengeItem(id: 'q_to1', question: '7 + 8 = ?', answer: '15', explanation: '7 + 8 = 15'),
        const ChallengeItem(id: 'q_to2', question: '9 + 4 = ?', answer: '13', explanation: '9 + 4 = 13'),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: MaterialApp(
            home: ChallengePlayScreen(
              category: challengeCategories[0],
              questionGenerator: (_) => testQuestions[questionCounter++ % testQuestions.length],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('15s'), findsOneWidget);

      // Fast forward 15 seconds to let timer expire
      await tester.pump(const Duration(seconds: 15));
      await tester.pumpAndSettle();

      // Verify timeout modal shows "TIME'S UP", correct answer and explanation
      expect(find.text("TIME'S UP"), findsOneWidget);
      expect(find.text('Correct answer:'), findsOneWidget);
      expect(find.descendant(of: find.byType(AlertDialog), matching: find.text('15')), findsOneWidget);
      expect(find.text('7 + 8 = 15'), findsOneWidget);
      expect(find.text('NEXT QUESTION'), findsOneWidget);

      // Tap NEXT QUESTION to continue
      await tester.tap(find.text('NEXT QUESTION'));
      await tester.pumpAndSettle();

      // Session continues indefinitely to question 2 with fresh 15s timer
      expect(find.text("TIME'S UP"), findsNothing);
      expect(find.text('9 + 4 = ?'), findsOneWidget);
      expect(find.text('15s'), findsOneWidget);
      expect(find.textContaining('QUESTION 2'), findsOneWidget);
      expect(find.text('Played 1 time'), findsOneWidget);
    });
  });
}
