import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math/controllers/game_controller.dart';
import 'package:math/screens/settings_screen.dart';
import 'package:math/services/progress_service.dart';
import 'package:math/services/sound_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Sound Service & Audio Feedback Audit Verification', () {
    test('MockSoundService records all sound triggers accurately', () {
      final mock = MockSoundService();

      expect(mock.playedSounds, isEmpty);
      mock.playTap();
      mock.playCorrect();
      mock.playIncorrect();
      mock.playLevelComplete();
      mock.playHeartLost();
      mock.playReward();
      mock.playChallengeStart();
      mock.playChallengeEnd();
      mock.playHintUnlocked();

      expect(mock.playedSounds.length, equals(9));
      expect(mock.playedSounds, equals([
        SoundType.tap,
        SoundType.correct,
        SoundType.incorrect,
        SoundType.levelComplete,
        SoundType.heartLost,
        SoundType.reward,
        SoundType.challengeStart,
        SoundType.challengeEnd,
        SoundType.hintUnlocked,
      ]));
    });

    test('MockSoundService respects mute setting', () {
      final mock = MockSoundService();
      mock.setEnabled(false);
      mock.playTap();
      mock.playCorrect();
      expect(mock.playedSounds, isEmpty);

      mock.setEnabled(true);
      mock.playTap();
      expect(mock.playedSounds, equals([SoundType.tap]));
    });

    test('ProgressService stores and clamps soundVolume and soundEnabled correctly', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progress = ProgressService(prefs);

      // Default values
      expect(progress.soundEnabled, isTrue);
      expect(progress.soundVolume, closeTo(0.8, 0.001));

      // Mute toggle
      await progress.setSoundEnabled(false);
      expect(progress.soundEnabled, isFalse);
      expect(prefs.getBool('math_sound_enabled'), isFalse);

      // Volume adjustments
      await progress.setSoundVolume(0.5);
      expect(progress.soundVolume, closeTo(0.5, 0.001));
      expect(prefs.getDouble('math_sound_volume'), closeTo(0.5, 0.001));

      // Clamping out-of-range volumes
      await progress.setSoundVolume(1.5);
      expect(progress.soundVolume, equals(1.0));

      await progress.setSoundVolume(-0.2);
      expect(progress.soundVolume, equals(0.0));
    });

    test('ProductionSoundService enforces calibrated gains and anti-overlap debouncing thresholds', () {
      // Verify calibrated gain factors
      expect(ProductionSoundService.gainFor(SoundType.tap), closeTo(0.40, 0.001));
      expect(ProductionSoundService.gainFor(SoundType.correct), closeTo(0.65, 0.001));
      expect(ProductionSoundService.gainFor(SoundType.incorrect), closeTo(0.60, 0.001));
      expect(ProductionSoundService.gainFor(SoundType.levelComplete), closeTo(0.75, 0.001));
      expect(ProductionSoundService.gainFor(SoundType.heartLost), closeTo(0.55, 0.001));
      expect(ProductionSoundService.gainFor(SoundType.reward), closeTo(0.65, 0.001));
      expect(ProductionSoundService.gainFor(SoundType.challengeStart), closeTo(0.65, 0.001));
      expect(ProductionSoundService.gainFor(SoundType.challengeEnd), closeTo(0.60, 0.001));
      expect(ProductionSoundService.gainFor(SoundType.hintUnlocked), closeTo(0.60, 0.001));

      // Verify debounce thresholds
      expect(ProductionSoundService.debounceThreshold(SoundType.tap), equals(45));
      expect(ProductionSoundService.debounceThreshold(SoundType.correct), equals(180));
      expect(ProductionSoundService.debounceThreshold(SoundType.incorrect), equals(180));
      expect(ProductionSoundService.debounceThreshold(SoundType.levelComplete), equals(300));
      expect(ProductionSoundService.debounceThreshold(SoundType.heartLost), equals(200));
      expect(ProductionSoundService.debounceThreshold(SoundType.reward), equals(180));
      expect(ProductionSoundService.debounceThreshold(SoundType.challengeStart), equals(250));
      expect(ProductionSoundService.debounceThreshold(SoundType.challengeEnd), equals(250));
      expect(ProductionSoundService.debounceThreshold(SoundType.hintUnlocked), equals(200));
    });

    test('ProductionSoundService suppresses playback when soundEnabled is false', () async {
      SharedPreferences.setMockInitialValues({'math_sound_enabled': false});
      final prefs = await SharedPreferences.getInstance();
      final progress = ProgressService(prefs);

      final prodService = ProductionSoundService(progress);
      // Calls are safely dropped without throwing
      prodService.playCorrect();
      prodService.playIncorrect();
      prodService.playLevelComplete();
      prodService.dispose();
    });

    test('ProductionSoundService suppresses playback when volume is zero', () async {
      SharedPreferences.setMockInitialValues({'math_sound_volume': 0.0, 'math_sound_enabled': true});
      final prefs = await SharedPreferences.getInstance();
      final progress = ProgressService(prefs);

      final prodService = ProductionSoundService(progress);
      prodService.playTap();
      prodService.dispose();
    });

    testWidgets('Settings Screen displays SOUND toggle and interactive VOLUME slider', (tester) async {
      SharedPreferences.setMockInitialValues({
        'math_sound_enabled': true,
        'math_sound_volume': 0.8,
      });
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);
      final mockSound = MockSoundService();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressServiceProvider.overrideWithValue(progressService),
            soundServiceProvider.overrideWithValue(mockSound),
          ],
          child: const MaterialApp(
            home: SettingsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Sound Row exists with label and active Volume display
      expect(find.text('SOUND'), findsOneWidget);
      expect(find.text('VOLUME'), findsOneWidget);
      expect(find.text('80%'), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);

      // Drag slider to adjust volume
      await tester.drag(find.byType(Slider), const Offset(-50, 0));
      await tester.pumpAndSettle();

      // Verify volume updated
      expect(progressService.soundVolume, isNot(closeTo(0.8, 0.01)));

      // Toggle SOUND off -> Volume slider disappears
      await tester.tap(find.byType(Switch).first);
      await tester.pumpAndSettle();

      expect(progressService.soundEnabled, isFalse);
      expect(find.text('VOLUME'), findsNothing);
      expect(find.byType(Slider), findsNothing);

      // Toggle SOUND back on -> Volume slider reappears and plays tap preview
      await tester.tap(find.byType(Switch).first);
      await tester.pumpAndSettle();

      expect(progressService.soundEnabled, isTrue);
      expect(find.text('VOLUME'), findsOneWidget);
      expect(mockSound.playedSounds, contains(SoundType.tap));
    });
  });
}
