import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math/features/challenges/widgets/challenge_status_bar.dart';

void main() {
  group('ChallengeStatusBar Widget Tests', () {
    testWidgets('Renders streak counter and tier badge correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                final vsync = tester;
                final anim = AnimationController(
                  vsync: vsync,
                  duration: const Duration(seconds: 15),
                  value: 0.8, // 12 seconds remaining
                );
                return ChallengeStatusBar(
                  consecutiveCorrect: 14,
                  currentTier: 1,
                  timerController: anim,
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('STREAK: 14'), findsOneWidget);
      expect(find.text('2-Digit'), findsOneWidget);
      expect(find.text('12s'), findsOneWidget);
    });

    test('getTierLabel returns expected string across all tiers', () {
      expect(ChallengeStatusBar.getTierLabel(0), equals('1-Digit'));
      expect(ChallengeStatusBar.getTierLabel(1), equals('2-Digit'));
      expect(ChallengeStatusBar.getTierLabel(2), equals('3-Digit'));
      expect(ChallengeStatusBar.getTierLabel(99), equals('3-Digit'));
    });
  });
}
