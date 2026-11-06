import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/game_theme.dart';
import '../widgets/math_riddle_logo.dart';
import 'home_screen.dart';

/// Opening splash screen displayed when the app launches.
/// Reveals the typographic "MATH RIDDLE" logo with a smooth cinematic fade.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();

    // Smooth automatic transition to HomeScreen after 1.5 seconds
    _navigationTimer = Timer(const Duration(milliseconds: 1600), _navigateToHome);
  }

  void _navigateToHome() {
    if (!mounted) return;
    _navigationTimer?.cancel();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameTheme.background,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _navigateToHome, // Tap-to-skip for instant entry
        child: Stack(
          children: [
            // Ambient Radial Glow Backdrop
            Center(
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      GameTheme.amberAccent.withAlpha(20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Animated Typographic Logo Lockup
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: const MathRiddleLogo(
                    scale: 1.25,
                    showSubtitle: true,
                  ),
                ),
              ),
            ),

            // Understated Bottom Accent
            Positioned(
              bottom: 36,
              left: 0,
              right: 0,
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'PURE BRAIN LOGIC',
                    style: TextStyle(
                      color: GameTheme.textDim,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

