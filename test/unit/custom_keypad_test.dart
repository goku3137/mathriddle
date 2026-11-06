import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math/services/sound_service.dart';
import 'package:math/widgets/custom_keypad.dart';

void main() {
  group('CustomKeypad (Option A: 4-Row x 3-Column Ergonomic Keypad)', () {
    testWidgets('renders all 10 digits, backspace, and ENTER in 4x3 layout', (WidgetTester tester) async {
      String currentInput = '';
      bool submitted = false;
      bool hintPressed = false;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            soundServiceProvider.overrideWithValue(MockSoundService()),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return CustomKeypad(
                    inputString: currentInput,
                    hasVibration: false,
                    showHint: true,
                    onDigitPressed: (d) => setState(() => currentInput += d),
                    onClear: () => setState(() => currentInput = ''),
                    onDelete: () => setState(() {
                      if (currentInput.isNotEmpty) {
                        currentInput = currentInput.substring(0, currentInput.length - 1);
                      }
                    }),
                    onHintPressed: () => hintPressed = true,
                    onSubmit: () => submitted = true,
                  );
                },
              ),
            ),
          ),
        ),
      );

      // Verify all digits '0'-'9' are present
      for (int i = 0; i <= 9; i++) {
        expect(find.text('$i'), findsOneWidget);
      }

      // Verify ENTER and Backspace
      expect(find.text('ENTER'), findsOneWidget);
      expect(find.byIcon(Icons.backspace_outlined), findsOneWidget);
      expect(find.byIcon(Icons.lightbulb_outline_rounded), findsOneWidget);

      // Test typing digits: 4, 2
      await tester.tap(find.text('4'));
      await tester.pump();
      await tester.tap(find.text('2'));
      await tester.pump();

      expect(find.text('42'), findsOneWidget);

      // Test backspace: deletes '2', leaving '4'
      await tester.tap(find.byIcon(Icons.backspace_outlined));
      await tester.pump();
      expect(find.text('4'), findsWidgets); // One in pad, one in display

      // Tap 5: '45'
      await tester.tap(find.text('5'));
      await tester.pump();

      // Test submit
      await tester.tap(find.text('ENTER'));
      await tester.pump();
      expect(submitted, isTrue);

      // Test hint
      await tester.tap(find.byIcon(Icons.lightbulb_outline_rounded));
      await tester.pump();
      expect(hintPressed, isTrue);

      // Test clear '✕' button in display bar
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump();
      expect(find.text('Answer'), findsOneWidget);
    });

    testWidgets('hides hint bulb when showHint is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            soundServiceProvider.overrideWithValue(MockSoundService()),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: CustomKeypad(
                inputString: '',
                hasVibration: false,
                showHint: false,
                onDigitPressed: (_) {},
                onClear: () {},
                onHintPressed: () {},
                onSubmit: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.lightbulb_outline_rounded), findsNothing);
      expect(find.text('ENTER'), findsOneWidget);
      expect(find.byIcon(Icons.backspace_outlined), findsOneWidget);
    });
  });
}
