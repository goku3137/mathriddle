import 'package:flutter/material.dart';
import '../../../../models/lesson_model.dart';

/// Pre-calculated spatial coordinate and state for a single lesson node on the adventure map.
class MapNodePosition {
  final Lesson lesson;
  final int globalIndex; // 1-based index (1..36)
  final Offset center;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLocked;
  final double horizontalRatio; // 0.0 (far left) to 1.0 (far right)

  const MapNodePosition({
    required this.lesson,
    required this.globalIndex,
    required this.center,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLocked,
    required this.horizontalRatio,
  });
}

/// Stage milestone checkpoint metadata positioned along the vertical adventure journey.
class MapMilestonePosition {
  final int stageIndex;
  final String stageName;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final double y;
  final int completedInStage;
  final int totalInStage;

  const MapMilestonePosition({
    required this.stageIndex,
    required this.stageName,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.y,
    required this.completedInStage,
    this.totalInStage = 6,
  });
}

