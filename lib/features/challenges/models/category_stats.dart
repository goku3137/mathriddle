import 'challenge_badge.dart';

/// Statistics and progression model for individual challenge categories.
class CategoryStats {
  final int attempts;
  final int correctAnswers;
  final int highestStreak;
  final int tier; // 0: 1-digit, 1: 2-digit, 2: 3-digit / hard
  final int highestBadgeIndex;

  const CategoryStats({
    this.attempts = 0,
    this.correctAnswers = 0,
    this.highestStreak = 0,
    this.tier = 0,
    this.highestBadgeIndex = 0,
  });

  double get accuracy => attempts > 0 ? (correctAnswers / attempts) * 100 : 0.0;
  int get accuracyPercent => accuracy.round();

  String get tierLabel {
    switch (tier) {
      case 0:
        return '1-Digit';
      case 1:
        return '2-Digit';
      case 2:
      default:
        return '3-Digit';
    }
  }

  ChallengeBadge get badge {
    final computed = ChallengeBadgeTier.getBadge(correctAnswers);
    if (computed.index < highestBadgeIndex) {
      return ChallengeBadge.values[highestBadgeIndex.clamp(0, ChallengeBadge.values.length - 1)];
    }
    return computed;
  }

  ChallengeBadgeInfo get badgeInfo => ChallengeBadgeTier.getInfo(badge);
  double get badgeProgress => ChallengeBadgeTier.getProgressFraction(correctAnswers);
  String get badgeProgressText => ChallengeBadgeTier.getProgressText(correctAnswers);
}
