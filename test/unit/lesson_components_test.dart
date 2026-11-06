import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math/controllers/game_controller.dart';
import 'package:math/features/learning/widgets/lesson_pillars_card.dart';
import 'package:math/features/learning/widgets/lesson_practice_test_card.dart';
import 'package:math/models/lesson_model.dart';
import 'package:math/services/progress_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const testLesson = Lesson(
    id: 'test_lesson_1',
    title: 'Order of Operations',
    category: 'Foundations',
    chapter: 'Foundational Academy',
    difficulty: 'Beginner',
    conceptSummary: 'BODMAS dictates the strict precedence of arithmetic operators.',
    formula: 'BODMAS / PEMDAS: Brackets → Orders → Division → Multiplication → Addition → Subtraction',
    whatItIs: 'BODMAS is the universal operator hierarchy rule.',
    whyItWorks: 'Without precedence, arithmetic operations are inherently ambiguous.',
    howToSolveIt: 'Evaluate parentheses first, then powers, then multiplication/division left to right.',
    whenToUseIt: 'Whenever an algebraic expression contains multiple operators.',
    stepByStepExplanation: 'Step 1: Simplify brackets. Step 2: Multiplication.',
    workedExample: 'Example: 6 + 2 * 3 = 12',
    gradedExamples: [],
    commonMistakes: ['Adding before multiplying'],
    shortcutsAndTricks: ['Scan for high-precedence operators first'],
    alternativeMethods: ['Left-to-right grouping'],
    sandboxType: SandboxDemoType.bodmas,
    linkedLevels: [1, 2],
    practiceQuestion: PracticeQuestion(
      question: 'What is 8 + 2 * 5?',
      correctAnswer: '18',
      hint: 'Multiply 2 * 5 first before adding 8.',
      explanation: '2 * 5 = 10, then 8 + 10 = 18.',
      options: ['18', '50', '20', '16'],
      wrongOptionExplanations: {
        '50': 'You added 8 + 2 first! Remember multiplication takes precedence.',
      },
    ),
    knowledgeTest: [],
    icon: Icons.calculate_rounded,
  );

  group('LessonPillarsCard Widget Tests', () {
    testWidgets('Renders all four pillars of mathematical mastery', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: LessonPillarsCard(lesson: testLesson),
            ),
          ),
        ),
      );

      expect(find.text('1. WHAT IT IS'), findsOneWidget);
      expect(find.text('2. WHY IT WORKS'), findsOneWidget);
      expect(find.text('3. HOW TO SOLVE IT'), findsOneWidget);
      expect(find.text('4. WHEN TO USE IT'), findsOneWidget);
    });
  });

  group('LessonPracticeTestCard Widget Tests', () {
    late ProgressService progressService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      progressService = ProgressService(prefs);
    });

    testWidgets('Displays question, options, and handles correct answer selection', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: LessonPracticeTestCard(lesson: testLesson),
              ),
            ),
          ),
        ),
      );

      // Verify question and options
      expect(find.text('What is 8 + 2 * 5?'), findsOneWidget);
      expect(find.text('18'), findsOneWidget);
      expect(find.text('50'), findsOneWidget);
      expect(find.text('+50 PTS REWARD'), findsOneWidget);

      // Select correct option '18'
      await tester.tap(find.text('18'));
      await tester.pumpAndSettle();

      // Submit answer
      await tester.tap(find.text('SUBMIT ANSWER'));
      await tester.pumpAndSettle();

      // Verify success feedback
      expect(find.text('EXCELLENT! ANSWER CORRECT'), findsOneWidget);
    });

    testWidgets('Toggles hint box on hint button tap', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: LessonPracticeTestCard(lesson: testLesson),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Multiply 2 * 5 first before adding 8.'), findsNothing);

      // Tap HINT button
      await tester.tap(find.text('HINT'));
      await tester.pumpAndSettle();

      expect(find.text('Multiply 2 * 5 first before adding 8.'), findsOneWidget);
      expect(find.text('HIDE HINT'), findsOneWidget);
    });
  });
}
