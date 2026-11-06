import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math/controllers/game_controller.dart';
import 'package:math/features/riddles/widgets/level_cleared_modal.dart';
import 'package:math/screens/levels_screen.dart';
import 'package:math/services/progress_service.dart';
import 'package:math/services/sound_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LevelClearedModal (Option 1: Smart Auto-Advance)', () {
    late ProgressService progressService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        'math_current_hearts': 5,
        'math_highest_unlocked_level': 1,
      });
      final prefs = await SharedPreferences.getInstance();
      progressService = ProgressService(prefs);
    });

    testWidgets('renders celebration, solution, and countdown bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
            soundServiceProvider.overrideWithValue(MockSoundService()),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: Consumer(
                  builder: (context, ref, _) => ElevatedButton(
                    onPressed: () => LevelClearedModal.show(context, ref),
                    child: const Text('SHOW'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('SHOW'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('CORRECT!'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.text('Auto-advancing... tap anywhere to skip'), findsOneWidget);
      expect(find.text('LEVELS'), findsOneWidget);

      // Fast-forward past countdown (2 seconds)
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Modal has auto-advanced and dismissed!
      expect(find.text('CORRECT!'), findsNothing);
    });

    testWidgets('tapping anywhere skips countdown immediately and advances', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
            soundServiceProvider.overrideWithValue(MockSoundService()),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: Consumer(
                  builder: (context, ref, _) => ElevatedButton(
                    onPressed: () => LevelClearedModal.show(context, ref),
                    child: const Text('SHOW'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('SHOW'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('CORRECT!'), findsOneWidget);

      // Tap on modal card to skip countdown immediately
      await tester.tap(find.text('CORRECT!'));
      await tester.pump();
      await tester.pumpAndSettle();

      // Skipped immediately without waiting 2 seconds!
      expect(find.text('CORRECT!'), findsNothing);
    });

    testWidgets('tapping LEVELS navigates to LevelsScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
            soundServiceProvider.overrideWithValue(MockSoundService()),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: Consumer(
                  builder: (context, ref, _) => ElevatedButton(
                    onPressed: () => LevelClearedModal.show(context, ref),
                    child: const Text('SHOW'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('SHOW'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('LEVELS'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(LevelsScreen), findsOneWidget);
    });
  });
}
