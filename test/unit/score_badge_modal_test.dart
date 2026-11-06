import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math/controllers/game_controller.dart';
import 'package:math/services/progress_service.dart';
import 'package:math/widgets/score_badge.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ScoreBadge & Scoring System Modal Verification', () {
    late ProgressService progressService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({'math_total_score': 125});
      final prefs = await SharedPreferences.getInstance();
      progressService = ProgressService(prefs);
    });

    testWidgets('ScoreBadge opens scoring dialog without overflow on narrow screens', (tester) async {
      // Simulate narrow 320x640 mobile screen
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: Center(
                child: ScoreBadge(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify ScoreBadge displays current score
      expect(find.text('0'), findsOneWidget);
      expect(find.text('PTS'), findsOneWidget);

      // Tap ScoreBadge to open Scoring System modal
      await tester.tap(find.byType(ScoreBadge));
      await tester.pumpAndSettle();

      // Verify dialog elements exist and no overflow occurred
      expect(find.text('SCORING SYSTEM'), findsOneWidget);
      expect(find.text('Levels 1–10'), findsOneWidget);
      expect(find.text('+5 PTS per solved riddle'), findsOneWidget);
      expect(find.text('Levels 11–20'), findsOneWidget);
      expect(find.text('+15 PTS (+10 increase per 10 levels)'), findsOneWidget);
      expect(find.text('Learn Mode'), findsOneWidget);
      expect(find.text('+50 PTS per completed concept'), findsOneWidget);
      expect(find.text('Speedrun Challenge'), findsOneWidget);
      expect(find.text('+3 PTS per solved challenge'), findsOneWidget);
      expect(find.text('GOT IT'), findsOneWidget);

      // Verify tapping GOT IT dismisses dialog
      await tester.tap(find.text('GOT IT'));
      await tester.pumpAndSettle();

      expect(find.text('SCORING SYSTEM'), findsNothing);
    });
  });
}
