import 'package:flutter/material.dart';

/// Achievement badges unlocked across progressive correct-answer milestones.
enum ChallengeBadge {
  newbie,
  beginner,
  skilled,
  expert,
  master,
  grandmaster,
}

/// Metadata and visual properties for achievement badges.
class ChallengeBadgeInfo {
  final ChallengeBadge badge;
  final String title;
  final int requiredCorrect;
  final int? nextMilestone;
  final Color color;
  final IconData icon;

  const ChallengeBadgeInfo({
    required this.badge,
    required this.title,
    required this.requiredCorrect,
    required this.nextMilestone,
    required this.color,
    required this.icon,
  });
}

/// Unified badge progression rules, milestones, and shared color palette across all categories.
class ChallengeBadgeTier {
  static const List<int> milestones = [0, 25, 75, 150, 300, 500];

  static ChallengeBadge getBadge(int correctCount) {
    if (correctCount >= 500) return ChallengeBadge.grandmaster;
    if (correctCount >= 300) return ChallengeBadge.master;
    if (correctCount >= 150) return ChallengeBadge.expert;
    if (correctCount >= 75) return ChallengeBadge.skilled;
    if (correctCount >= 25) return ChallengeBadge.beginner;
    return ChallengeBadge.newbie;
  }

  static ChallengeBadgeInfo getInfo(ChallengeBadge badge) {
    switch (badge) {
      case ChallengeBadge.newbie:
        return const ChallengeBadgeInfo(
          badge: ChallengeBadge.newbie,
          title: 'NEWBIE',
          requiredCorrect: 0,
          nextMilestone: 25,
          color: Color(0xFF8E99A2), // Slate Pewter
          icon: Icons.shield_outlined,
        );
      case ChallengeBadge.beginner:
        return const ChallengeBadgeInfo(
          badge: ChallengeBadge.beginner,
          title: 'BEGINNER',
          requiredCorrect: 25,
          nextMilestone: 75,
          color: Color(0xFFCD7F32), // Warm Bronze
          icon: Icons.military_tech_outlined,
        );
      case ChallengeBadge.skilled:
        return const ChallengeBadgeInfo(
          badge: ChallengeBadge.skilled,
          title: 'SKILLED',
          requiredCorrect: 75,
          nextMilestone: 150,
          color: Color(0xFFB0BEC5), // Steel Silver
          icon: Icons.military_tech_rounded,
        );
      case ChallengeBadge.expert:
        return const ChallengeBadgeInfo(
          badge: ChallengeBadge.expert,
          title: 'EXPERT',
          requiredCorrect: 150,
          nextMilestone: 300,
          color: Color(0xFFFFB300), // Rich Gold
          icon: Icons.workspace_premium_rounded,
        );
      case ChallengeBadge.master:
        return const ChallengeBadgeInfo(
          badge: ChallengeBadge.master,
          title: 'MASTER',
          requiredCorrect: 300,
          nextMilestone: 500,
          color: Color(0xFF00E5FF), // Diamond Cyan
          icon: Icons.diamond_outlined,
        );
      case ChallengeBadge.grandmaster:
        return const ChallengeBadgeInfo(
          badge: ChallengeBadge.grandmaster,
          title: 'GRANDMASTER',
          requiredCorrect: 500,
          nextMilestone: null,
          color: Color(0xFFE040FB), // Radiant Amethyst
          icon: Icons.stars_rounded,
        );
    }
  }

  static double getProgressFraction(int correctCount) {
    if (correctCount >= 500) return 1.0;
    if (correctCount >= 300) return ((correctCount - 300) / (500 - 300)).clamp(0.0, 1.0);
    if (correctCount >= 150) return ((correctCount - 150) / (300 - 150)).clamp(0.0, 1.0);
    if (correctCount >= 75) return ((correctCount - 75) / (150 - 75)).clamp(0.0, 1.0);
    if (correctCount >= 25) return ((correctCount - 25) / (75 - 25)).clamp(0.0, 1.0);
    return (correctCount / 25).clamp(0.0, 1.0);
  }

  static String getProgressText(int correctCount) {
    if (correctCount >= 500) return 'MAX RANK (500+ Solved)';
    if (correctCount >= 300) return '$correctCount / 500 to Grandmaster';
    if (correctCount >= 150) return '$correctCount / 300 to Master';
    if (correctCount >= 75) return '$correctCount / 150 to Expert';
    if (correctCount >= 25) return '$correctCount / 75 to Skilled';
    return '$correctCount / 25 to Beginner';
  }
}
