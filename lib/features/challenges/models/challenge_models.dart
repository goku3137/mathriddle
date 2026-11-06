import 'package:flutter/material.dart';

enum ChallengeType {
  addition,
  subtraction,
  multiplication,
  division,
  powers,
  percentages,
  sequences,
  missingNumbers,
  bodmas,
  lateralOperators,
  mathTricks,
  mixed,
}

class ChallengeItem {
  final String id;
  final String question;
  final String answer;
  final String explanation;

  const ChallengeItem({
    required this.id,
    required this.question,
    required this.answer,
    this.explanation = '',
  });
}

class ChallengeCategoryInfo {
  final ChallengeType type;
  final String title;
  final IconData icon;
  final String symbol;
  final String description;
  final Color accentColor;
  final List<ChallengeItem> items;

  const ChallengeCategoryInfo({
    required this.type,
    required this.title,
    required this.icon,
    required this.symbol,
    required this.description,
    required this.accentColor,
    required this.items,
  });
}

/// Overlay data model displayed on incorrect answer or timeout.
class FeedbackOverlayData {
  final String wrongInput;
  final String correctAnswer;
  final String explanation;
  final bool isTimeout;

  const FeedbackOverlayData({
    required this.wrongInput,
    required this.correctAnswer,
    required this.explanation,
    this.isTimeout = false,
  });
}
