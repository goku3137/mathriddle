import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controllers/game_controller.dart';
import 'screens/splash_screen.dart';
import 'services/progress_service.dart';
import 'theme/game_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Immersive OLED dark system bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: GameTheme.background,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Lock to tactile, one-handed mobile portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize offline persistent progress service
  final progressService = await ProgressService.init();

  // Production-grade error boundary fallback: prevents blank or grey screen on unexpected render glitches
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: GameTheme.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.refresh_rounded, color: GameTheme.amberAccent, size: 36),
              SizedBox(height: 12),
              Text(
                'Something went wrong',
                style: TextStyle(color: GameTheme.textWhite, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              Text(
                'Your progress is safely preserved.',
                style: TextStyle(color: GameTheme.textMuted, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  };

  runApp(
    ProviderScope(
      overrides: [
        progressServiceProvider.overrideWithValue(progressService),
      ],
      child: const MathRiddlesApp(),
    ),
  );
}

class MathRiddlesApp extends StatelessWidget {
  final Widget? home;
  const MathRiddlesApp({super.key, this.home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Riddle',
      debugShowCheckedModeBanner: false,
      theme: GameTheme.darkTheme,
      home: home ?? const SplashScreen(),
    );
  }
}
