import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math/features/settings/data/legal_data.dart';
import 'package:math/features/settings/widgets/settings_dialogs.dart';

void main() {
  group('Legal Documents & In-App Viewer Verification', () {
    test('LegalData models are comprehensive and structured for Math Riddle', () {
      expect(LegalData.privacyPolicy.appName, 'Math Riddle');
      expect(LegalData.privacyPolicy.title, 'PRIVACY POLICY');
      expect(LegalData.privacyPolicy.sections.length, greaterThanOrEqualTo(10));
      expect(
        LegalData.privacyPolicy.sections.any((s) => s.bulletPoints != null && s.bulletPoints!.isNotEmpty),
        isTrue,
      );

      expect(LegalData.termsAndConditions.appName, 'Math Riddle');
      expect(LegalData.termsAndConditions.title, 'TERMS AND CONDITIONS');
      expect(LegalData.termsAndConditions.sections.length, greaterThanOrEqualTo(10));
      expect(
        LegalData.termsAndConditions.sections.any((s) => s.bulletPoints != null && s.bulletPoints!.isNotEmpty),
        isTrue,
      );
    });

    testWidgets('LegalDocumentDialog renders Privacy Policy modal cleanly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => SettingsDialogs.showPrivacyPolicy(context),
                  child: const Text('OPEN PRIVACY'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('OPEN PRIVACY'));
      await tester.pumpAndSettle();

      expect(find.text('PRIVACY POLICY'), findsOneWidget);
      expect(find.text('Math Riddle • November 7, 2026'), findsOneWidget);
      expect(find.text('OFFLINE-FIRST PRIVACY & ZERO TELEMETRY'), findsOneWidget);
      expect(find.text('1. Introduction & Overview'), findsOneWidget);
      expect(find.text('CLOSE'), findsOneWidget);

      await tester.tap(find.text('CLOSE'));
      await tester.pumpAndSettle();
      expect(find.text('PRIVACY POLICY'), findsNothing);
    });

    testWidgets('LegalDocumentDialog renders Terms and Conditions modal cleanly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => SettingsDialogs.showTermsAndConditions(context),
                  child: const Text('OPEN TERMS'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('OPEN TERMS'));
      await tester.pumpAndSettle();

      expect(find.text('TERMS AND CONDITIONS'), findsOneWidget);
      expect(find.text('Math Riddle • November 7, 2026'), findsOneWidget);
      expect(find.text('END USER LICENSE AGREEMENT & TERMS OF SERVICE'), findsOneWidget);
      expect(find.text('1. Agreement to Terms'), findsOneWidget);
      expect(find.text('CLOSE'), findsOneWidget);

      await tester.tap(find.text('CLOSE'));
      await tester.pumpAndSettle();
      expect(find.text('TERMS AND CONDITIONS'), findsNothing);
    });
  });
}

