import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';
import '../../../theme/game_theme.dart';
import 'sandboxes/algebra_applied_sandboxes.dart';
import 'sandboxes/arithmetic_sandboxes.dart';
import 'sandboxes/geometry_boss_sandboxes.dart';
import 'sandboxes/pattern_sequence_sandboxes.dart';

/// Interactive laboratory demonstration widget allowing users to manipulate
/// numbers, operators, and parameters to see the math recompute in real-time.
class InteractiveLessonSandbox extends StatelessWidget {
  final SandboxDemoType demoType;

  const InteractiveLessonSandbox({
    super.key,
    required this.demoType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.4), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: GameTheme.amberGlow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.tune_rounded, color: GameTheme.amberAccent, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'INTERACTIVE LAB DEMONSTRATION',
                    style: TextStyle(
                      color: GameTheme.amberAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: GameTheme.surfaceElevated,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: GameTheme.borderSubtle),
                ),
                child: const Text(
                  'LIVE SANDBOX',
                  style: TextStyle(
                    color: GameTheme.textMuted,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Dynamic Demonstration Content
          _buildActiveDemo(),
        ],
      ),
    );
  }

  Widget _buildActiveDemo() {
    switch (demoType) {
      case SandboxDemoType.bodmas:
        return const BodmasDemoWidget();
      case SandboxDemoType.patterns:
        return const PatternsDemoWidget();
      case SandboxDemoType.missingNumbers:
        return const MissingNumbersDemoWidget();
      case SandboxDemoType.triangles:
        return const TrianglesDemoWidget();
      case SandboxDemoType.equations:
        return const EquationsDemoWidget();
      case SandboxDemoType.sequences:
        return const SequencesDemoWidget();
      case SandboxDemoType.matrices:
        return const MatricesDemoWidget();
      case SandboxDemoType.money:
        return const MoneyDemoWidget();
      case SandboxDemoType.logic:
        return const LogicDemoWidget();
      case SandboxDemoType.circles:
        return const CirclesDemoWidget();
      case SandboxDemoType.operators:
        return const OperatorsDemoWidget();
      case SandboxDemoType.age:
        return const AgeDemoWidget();
      case SandboxDemoType.tricks:
        return const TricksDemoWidget();
      case SandboxDemoType.mazes:
        return const MazesDemoWidget();
      case SandboxDemoType.finalBoss:
        return const FinalBossDemoWidget();
      case SandboxDemoType.general:
        return const BodmasDemoWidget();
    }
  }
}
