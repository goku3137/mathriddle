import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../data/learning_curriculum.dart';
import '../features/learning/widgets/map/adventure_progress_bar.dart';
import '../features/learning/widgets/map/map_level_node.dart';
import '../features/learning/widgets/map/map_models.dart';
import '../features/learning/widgets/map/map_path_painter.dart';
import '../features/learning/widgets/map/map_stage_milestone.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/score_badge.dart';

/// Candy Crush-inspired adventure level map for the SMATH Learning curriculum.
/// Renders a vertically winding path connecting 36 circular lesson nodes across 6 milestone stages.
class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({super.key});

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen> {
  final ScrollController _scrollController = ScrollController();
  double _currentLessonY = 0.0;

  // Horizontal position waves for odd and even stages (ratio of screen width)
  static const List<double> _oddStageRatios = [0.50, 0.72, 0.80, 0.50, 0.20, 0.28];
  static const List<double> _evenStageRatios = [0.50, 0.28, 0.20, 0.50, 0.80, 0.72];

  // Stage milestone definitions
  static const List<_StageConfig> _stageConfigs = [
    _StageConfig(
      index: 1,
      name: 'Stage 1: Beginner',
      subtitle: 'Foundations & Number Sense',
      icon: Icons.explore_rounded,
      accentColor: Color(0xFF10B981),
    ),
    _StageConfig(
      index: 2,
      name: 'Stage 2: Basic Mathematics',
      subtitle: 'Operations, Factors & Proportions',
      icon: Icons.calculate_rounded,
      accentColor: Color(0xFF0284C7),
    ),
    _StageConfig(
      index: 3,
      name: 'Stage 3: Intermediate',
      subtitle: 'Algebra, Equations & Sequences',
      icon: Icons.auto_graph_rounded,
      accentColor: Color(0xFF8B5CF6),
    ),
    _StageConfig(
      index: 4,
      name: 'Stage 4: Advanced',
      subtitle: 'Geometry, Quadratics & Probability',
      icon: Icons.change_history_rounded,
      accentColor: Color(0xFFF59E0B),
    ),
    _StageConfig(
      index: 5,
      name: 'Stage 5: Expert',
      subtitle: 'Calculus, Matrices & Complex Plane',
      icon: Icons.grain_rounded,
      accentColor: Color(0xFFEC4899),
    ),
    _StageConfig(
      index: 6,
      name: 'Stage 6: Extreme Mathematics',
      subtitle: 'Olympiad & Grandmaster Mastery',
      icon: Icons.military_tech_rounded,
      accentColor: Color(0xFFEAB308),
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentLesson();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentLesson() {
    if (!_scrollController.hasClients || _currentLessonY <= 0) return;

    final targetOffset = (_currentLessonY - 260.0).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(gameControllerProvider);
    final progress = ref.watch(progressServiceProvider);
    final completedTopics = progress.completedLearnTopics;

    final totalCompleted = learningCurriculum
        .where((lesson) => completedTopics.contains(lesson.id))
        .length;
    final totalLessons = learningCurriculum.length;
    final pointsEarned = totalCompleted * 50;

    final currentLesson = learningCurriculum.firstWhere(
      (l) => !completedTopics.contains(l.id),
      orElse: () => learningCurriculum.last,
    );
    final currentStageName = currentLesson.stage;

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: GameTheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () {
            ref.read(soundServiceProvider).playTap();
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'LEARNING CURRICULUM',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: ScoreBadge(compact: true),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Floating Adventure Progress Bar
            AdventureProgressBar(
              totalCompleted: totalCompleted,
              totalLessons: totalLessons,
              pointsEarned: pointsEarned,
              currentStageName: currentStageName,
              onJumpToCurrent: _scrollToCurrentLesson,
            ),

            // 2. Continuous Winding Adventure Map
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final nodes = <MapNodePosition>[];
                  final milestones = <MapMilestonePosition>[];

                  double currentY = 24.0;
                  const double vStep = 115.0;
                  const double milestoneHeight = 90.0;

                  for (int stageIndex = 1; stageIndex <= 6; stageIndex++) {
                    final config = _stageConfigs[stageIndex - 1];

                    // Count completions in this stage
                    final stageLessons = learningCurriculum.where((l) => l.stageIndex == stageIndex);
                    final completedInStage = stageLessons.where((l) => completedTopics.contains(l.id)).length;

                    // 1. Milestone position
                    milestones.add(
                      MapMilestonePosition(
                        stageIndex: stageIndex,
                        stageName: config.name,
                        subtitle: config.subtitle,
                        icon: config.icon,
                        accentColor: config.accentColor,
                        y: currentY,
                        completedInStage: completedInStage,
                        totalInStage: stageLessons.length,
                      ),
                    );

                    currentY += milestoneHeight + 10;

                    // 2. Lesson nodes for this stage (6 lessons)
                    final ratios = (stageIndex % 2 == 1) ? _oddStageRatios : _evenStageRatios;
                    for (int j = 0; j < 6; j++) {
                      final globalIndex = (stageIndex - 1) * 6 + j;
                      if (globalIndex >= learningCurriculum.length) break;

                      final lesson = learningCurriculum[globalIndex];
                      final isCompleted = completedTopics.contains(lesson.id);
                      final isLocked = globalIndex > 0 &&
                          !completedTopics.contains(learningCurriculum[globalIndex - 1].id) &&
                          !isCompleted;
                      final isCurrent = !isCompleted && !isLocked;

                      final ratio = ratios[j];
                      // Clamp horizontal center so node and pill have margin from screen edges
                      final nodeCenterX = (width * ratio).clamp(42.0, width - 42.0);
                      final nodeCenter = Offset(nodeCenterX, currentY + 30.0);

                      if (isCurrent) {
                        _currentLessonY = nodeCenter.dy;
                      }

                      nodes.add(
                        MapNodePosition(
                          lesson: lesson,
                          globalIndex: globalIndex + 1,
                          center: nodeCenter,
                          isCompleted: isCompleted,
                          isCurrent: isCurrent,
                          isLocked: isLocked,
                          horizontalRatio: ratio,
                        ),
                      );

                      currentY += vStep;
                    }

                    currentY += 20.0; // Spacing before next stage milestone
                  }

                  final totalMapHeight = currentY + 60.0;

                  return SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      width: width,
                      height: totalMapHeight,
                      child: Stack(
                        children: [
                          // A. Smooth Continuous Winding Path (CustomPainter)
                          Positioned.fill(
                            child: CustomPaint(
                              painter: MapPathPainter(nodes: nodes),
                            ),
                          ),

                          // B. Milestone Banners
                          ...milestones.map((m) {
                            return Positioned(
                              top: m.y,
                              left: 20,
                              right: 20,
                              child: MapStageMilestone(milestone: m),
                            );
                          }),

                          // C. Circular Level Nodes & Title Pills
                          ...nodes.map((pos) {
                            final isRightSide = pos.horizontalRatio > 0.5;

                            if (isRightSide) {
                              return Positioned(
                                top: pos.center.dy - 32,
                                right: width - pos.center.dx - 32,
                                child: MapLevelNode(position: pos),
                              );
                            } else {
                              return Positioned(
                                top: pos.center.dy - 32,
                                left: pos.center.dx - 32,
                                child: MapLevelNode(position: pos),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StageConfig {
  final int index;
  final String name;
  final String subtitle;
  final IconData icon;
  final Color accentColor;

  const _StageConfig({
    required this.index,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
  });
}
