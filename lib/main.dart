import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controllers/game_controller.dart';
import 'screens/home_screen.dart';
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

  // Initialize offline persistent progress service
  final progressService = await ProgressService.init();

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
  const MathRiddlesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Riddles',
      debugShowCheckedModeBanner: false,
      theme: GameTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
