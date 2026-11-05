import 'dart:math';
import 'package:flutter/cupertino.dart';
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

/// Dynamic, continuous random challenge generator for infinite timed challenges.
/// Every question has its answer mathematically derived directly from the generated question.
class ChallengeGenerator {
  static final Random _defaultRng = Random();

  /// Generates a random, mathematically verified challenge problem continuously on the fly.
  /// Supports progressive difficulty tiers:
  /// - Tier 0: Simple 1-digit numbers
  /// - Tier 1: 2-digit numbers
  /// - Tier 2: 3-digit and harder calculations
  static ChallengeItem generate(ChallengeType type, {int tier = 0, Random? rng}) {
    final random = rng ?? _defaultRng;
    final clampedTier = tier.clamp(0, 2);
    switch (type) {
      case ChallengeType.addition:
        return _generateAddition(random, clampedTier);
      case ChallengeType.subtraction:
        return _generateSubtraction(random, clampedTier);
      case ChallengeType.multiplication:
        return _generateMultiplication(random, clampedTier);
      case ChallengeType.division:
        return _generateDivision(random, clampedTier);
      case ChallengeType.powers:
        return _generatePowers(random, clampedTier);
      case ChallengeType.percentages:
        return _generatePercentages(random, clampedTier);
      case ChallengeType.sequences:
        return _generateSequences(random, clampedTier);
      case ChallengeType.missingNumbers:
        return _generateMissingNumbers(random, clampedTier);
      case ChallengeType.bodmas:
        return _generateBodmas(random, clampedTier);
      case ChallengeType.lateralOperators:
        return _generateLateralOperators(random, clampedTier);
      case ChallengeType.mathTricks:
        return _generateMathTricks(random, clampedTier);
      case ChallengeType.mixed:
        const pool = [
          ChallengeType.addition,
          ChallengeType.subtraction,
          ChallengeType.multiplication,
          ChallengeType.division,
          ChallengeType.powers,
          ChallengeType.percentages,
          ChallengeType.sequences,
          ChallengeType.missingNumbers,
          ChallengeType.bodmas,
          ChallengeType.lateralOperators,
          ChallengeType.mathTricks,
        ];
        final picked = pool[random.nextInt(pool.length)];
        return generate(picked, tier: clampedTier, rng: random);
    }
  }

  static ChallengeItem _generateAddition(Random rnd, int tier) {
    int a, b;
    if (tier == 0) {
      // Tier 0: Simple 1-digit numbers (1 to 9)
      a = 1 + rnd.nextInt(9);
      b = 1 + rnd.nextInt(9);
    } else if (tier == 1) {
      // Tier 1: 2-digit numbers (10 to 99)
      a = 10 + rnd.nextInt(90);
      b = 10 + rnd.nextInt(90);
    } else {
      // Tier 2: 3-digit and harder numbers (100 to 899)
      a = 100 + rnd.nextInt(800);
      b = 100 + rnd.nextInt(800);
    }
    final ans = a + b;
    return ChallengeItem(
      id: 'add_${tier}_${a}_$b',
      question: '$a + $b = ?',
      answer: '$ans',
      explanation: '$a + $b = $ans',
    );
  }

  static ChallengeItem _generateSubtraction(Random rnd, int tier) {
    int b, diff, a;
    if (tier == 0) {
      // Tier 0: 1-digit numbers (minuend <= 18, subtrahend 1..9, diff 1..9)
      b = 1 + rnd.nextInt(9);
      diff = 1 + rnd.nextInt(9);
      a = b + diff;
    } else if (tier == 1) {
      // Tier 1: 2-digit numbers
      b = 10 + rnd.nextInt(75);
      diff = 10 + rnd.nextInt(80);
      a = b + diff;
    } else {
      // Tier 2: 3-digit numbers
      b = 100 + rnd.nextInt(600);
      diff = 100 + rnd.nextInt(600);
      a = b + diff;
    }
    return ChallengeItem(
      id: 'sub_${tier}_${a}_$b',
      question: '$a − $b = ?',
      answer: '$diff',
      explanation: '$a − $b = $diff',
    );
  }

  static ChallengeItem _generateMultiplication(Random rnd, int tier) {
    int a, b;
    if (tier == 0) {
      // Tier 0: 1-digit times 1-digit (2 to 9)
      a = 2 + rnd.nextInt(8);
      b = 2 + rnd.nextInt(8);
    } else if (tier == 1) {
      // Tier 1: 2-digit times 1-digit or simple 2-digit
      if (rnd.nextBool()) {
        a = 11 + rnd.nextInt(25);
        b = 3 + rnd.nextInt(7);
      } else {
        a = 11 + rnd.nextInt(9);
        b = 11 + rnd.nextInt(9);
      }
    } else {
      // Tier 2: 2-digit times 2-digit / harder calculations
      a = 14 + rnd.nextInt(45);
      b = 11 + rnd.nextInt(25);
    }
    final ans = a * b;
    return ChallengeItem(
      id: 'mul_${tier}_${a}_$b',
      question: '$a × $b = ?',
      answer: '$ans',
      explanation: '$a × $b = $ans',
    );
  }

  static ChallengeItem _generateDivision(Random rnd, int tier) {
    int divisor, quotient;
    if (tier == 0) {
      // Tier 0: 1-digit divisor and 1-digit quotient (2 to 9)
      divisor = 2 + rnd.nextInt(8);
      quotient = 2 + rnd.nextInt(8);
    } else if (tier == 1) {
      // Tier 1: 2-digit quotient or divisor
      divisor = 3 + rnd.nextInt(10);
      quotient = 11 + rnd.nextInt(20);
    } else {
      // Tier 2: 3-digit dividend with harder division
      divisor = 8 + rnd.nextInt(25);
      quotient = 21 + rnd.nextInt(65);
    }
    final dividend = divisor * quotient;
    return ChallengeItem(
      id: 'div_${tier}_${dividend}_$divisor',
      question: '$dividend ÷ $divisor = ?',
      answer: '$quotient',
      explanation: '$dividend ÷ $divisor = $quotient (since $quotient × $divisor = $dividend)',
    );
  }

  static ChallengeItem _generatePowers(Random rnd, int tier) {
    if (tier == 0) {
      // Tier 0: 1-digit squares and roots (2 to 9)
      final n = 2 + rnd.nextInt(8);
      if (rnd.nextBool()) {
        final ans = n * n;
        return ChallengeItem(
          id: 'pow_0_sq_$n',
          question: '$n² = ?',
          answer: '$ans',
          explanation: '$n × $n = $ans',
        );
      } else {
        final sq = n * n;
        return ChallengeItem(
          id: 'pow_0_sqrt_$sq',
          question: '√$sq = ?',
          answer: '$n',
          explanation: '√$sq = $n (since $n × $n = $sq)',
        );
      }
    } else if (tier == 1) {
      // Tier 1: 2-digit squares (10 to 20) or 1-digit cubes (2 to 5)
      final variant = rnd.nextInt(3);
      if (variant == 0) {
        final n = 10 + rnd.nextInt(11);
        final ans = n * n;
        return ChallengeItem(
          id: 'pow_1_sq_$n',
          question: '$n² = ?',
          answer: '$ans',
          explanation: '$n × $n = $ans',
        );
      } else if (variant == 1) {
        final n = 10 + rnd.nextInt(11);
        final sq = n * n;
        return ChallengeItem(
          id: 'pow_1_sqrt_$sq',
          question: '√$sq = ?',
          answer: '$n',
          explanation: '√$sq = $n (since $n × $n = $sq)',
        );
      } else {
        final n = 2 + rnd.nextInt(4);
        final ans = n * n * n;
        return ChallengeItem(
          id: 'pow_1_cb_$n',
          question: '$n³ = ?',
          answer: '$ans',
          explanation: '$n × $n × $n = $ans',
        );
      }
    } else {
      // Tier 2: Higher squares (21 to 35) or higher cubes (6 to 10)
      final variant = rnd.nextInt(3);
      if (variant == 0) {
        final n = 21 + rnd.nextInt(15);
        final ans = n * n;
        return ChallengeItem(
          id: 'pow_2_sq_$n',
          question: '$n² = ?',
          answer: '$ans',
          explanation: '$n × $n = $ans',
        );
      } else if (variant == 1) {
        final n = 21 + rnd.nextInt(15);
        final sq = n * n;
        return ChallengeItem(
          id: 'pow_2_sqrt_$sq',
          question: '√$sq = ?',
          answer: '$n',
          explanation: '√$sq = $n (since $n × $n = $sq)',
        );
      } else {
        final n = 6 + rnd.nextInt(5);
        final ans = n * n * n;
        return ChallengeItem(
          id: 'pow_2_cb_$n',
          question: '$n³ = ?',
          answer: '$ans',
          explanation: '$n × $n × $n = $ans',
        );
      }
    }
  }

  static ChallengeItem _generatePercentages(Random rnd, int tier) {
    if (tier == 0) {
      // Tier 0: 10% or 50% of round numbers with 1-digit answer
      if (rnd.nextBool()) {
        final k = 1 + rnd.nextInt(9);
        final base = k * 10;
        final ans = k;
        return ChallengeItem(
          id: 'pct_0_10_$base',
          question: '10% of $base = ?',
          answer: '$ans',
          explanation: '10% of $base = $base ÷ 10 = $ans',
        );
      } else {
        final k = 1 + rnd.nextInt(9);
        final base = k * 2;
        final ans = k;
        return ChallengeItem(
          id: 'pct_0_50_$base',
          question: '50% of $base = ?',
          answer: '$ans',
          explanation: '50% of $base = $base ÷ 2 = $ans',
        );
      }
    } else if (tier == 1) {
      // Tier 1: 20%, 25%, 30%, 40%, 50%, 75%
      const pcts = [20, 25, 30, 40, 50, 75];
      final pct = pcts[rnd.nextInt(pcts.length)];
      int base;
      if (pct == 25 || pct == 75) {
        base = (3 + rnd.nextInt(18)) * 4;
      } else if (pct == 50) {
        base = (6 + rnd.nextInt(40)) * 2;
      } else {
        base = (2 + rnd.nextInt(15)) * 10;
      }
      final ans = (pct * base) ~/ 100;
      return ChallengeItem(
        id: 'pct_1_${pct}_$base',
        question: '$pct% of $base = ?',
        answer: '$ans',
        explanation: '$pct% of $base = ($pct × $base) ÷ 100 = $ans',
      );
    } else {
      // Tier 2: 15%, 35%, 45%, 65%, 85% with 3-digit base
      const pcts = [15, 35, 45, 65, 85];
      final pct = pcts[rnd.nextInt(pcts.length)];
      final base = (6 + rnd.nextInt(20)) * 20; // 120 to 500
      final ans = (pct * base) ~/ 100;
      return ChallengeItem(
        id: 'pct_2_${pct}_$base',
        question: '$pct% of $base = ?',
        answer: '$ans',
        explanation: '$pct% of $base = ($pct × $base) ÷ 100 = $ans',
      );
    }
  }

  static ChallengeItem _generateSequences(Random rnd, int tier) {
    if (tier == 0) {
      // Tier 0: 1-digit step arithmetic progression
      final a = 1 + rnd.nextInt(5);
      final d = 1 + rnd.nextInt(4);
      final t1 = a;
      final t2 = a + d;
      final t3 = a + 2 * d;
      final t4 = a + 3 * d;
      final ans = a + 4 * d;
      return ChallengeItem(
        id: 'seq_0_${a}_$d',
        question: '$t1, $t2, $t3, $t4, [?]',
        answer: '$ans',
        explanation: 'Add $d each step: $t4 + $d = $ans',
      );
    } else if (tier == 1) {
      // Tier 1: 2-digit step or doubling geometric sequence
      if (rnd.nextBool()) {
        final a = 10 + rnd.nextInt(20);
        final d = 5 + rnd.nextInt(10);
        final t1 = a;
        final t2 = a + d;
        final t3 = a + 2 * d;
        final t4 = a + 3 * d;
        final ans = a + 4 * d;
        return ChallengeItem(
          id: 'seq_1_ap_${a}_$d',
          question: '$t1, $t2, $t3, $t4, [?]',
          answer: '$ans',
          explanation: 'Add $d each step: $t4 + $d = $ans',
        );
      } else {
        final a = 2 + rnd.nextInt(4);
        final t1 = a;
        final t2 = a * 2;
        final t3 = t2 * 2;
        final t4 = t3 * 2;
        final ans = t4 * 2;
        return ChallengeItem(
          id: 'seq_1_gp_$a',
          question: '$t1, $t2, $t3, $t4, [?]',
          answer: '$ans',
          explanation: 'Multiply by 2 each step: $t4 × 2 = $ans',
        );
      }
    } else {
      // Tier 2: Increasing difference sequence (+2, +4, +6...) or squares
      if (rnd.nextBool()) {
        final a = 2 + rnd.nextInt(8);
        final t1 = a;
        final t2 = t1 + 2;
        final t3 = t2 + 4;
        final t4 = t3 + 6;
        final ans = t4 + 8;
        return ChallengeItem(
          id: 'seq_2_quad_$a',
          question: '$t1, $t2, $t3, $t4, [?]',
          answer: '$ans',
          explanation: 'Differences increase by +2 (+2, +4, +6, +8): $t4 + 8 = $ans',
        );
      } else {
        final offset = 1 + rnd.nextInt(6);
        final t1 = offset * offset;
        final t2 = (offset + 1) * (offset + 1);
        final t3 = (offset + 2) * (offset + 2);
        final t4 = (offset + 3) * (offset + 3);
        final ans = (offset + 4) * (offset + 4);
        return ChallengeItem(
          id: 'seq_2_sq_$offset',
          question: '$t1, $t2, $t3, $t4, [?]',
          answer: '$ans',
          explanation: 'Consecutive squares: (${offset + 4})² = $ans',
        );
      }
    }
  }

  static ChallengeItem _generateMissingNumbers(Random rnd, int tier) {
    if (tier == 0) {
      // Tier 0: 1-digit addition or multiplication
      if (rnd.nextBool()) {
        final a = 1 + rnd.nextInt(9);
        final b = 1 + rnd.nextInt(9);
        final c = a + b;
        return ChallengeItem(
          id: 'mis_0_add_${a}_$c',
          question: '$a + [?] = $c',
          answer: '$b',
          explanation: '[?] = $c − $a = $b',
        );
      } else {
        final a = 2 + rnd.nextInt(8);
        final b = 2 + rnd.nextInt(8);
        final c = a * b;
        return ChallengeItem(
          id: 'mis_0_mul_${a}_$c',
          question: '$a × [?] = $c',
          answer: '$b',
          explanation: '[?] = $c ÷ $a = $b',
        );
      }
    } else if (tier == 1) {
      // Tier 1: 2-digit missing addition or 2-digit multiplication
      if (rnd.nextBool()) {
        final a = 12 + rnd.nextInt(50);
        final b = 12 + rnd.nextInt(50);
        final c = a + b;
        return ChallengeItem(
          id: 'mis_1_add_${a}_$c',
          question: '$a + [?] = $c',
          answer: '$b',
          explanation: '[?] = $c − $a = $b',
        );
      } else {
        final a = 3 + rnd.nextInt(8);
        final b = 11 + rnd.nextInt(18);
        final c = a * b;
        return ChallengeItem(
          id: 'mis_1_mul_${a}_$c',
          question: '$a × [?] = $c',
          answer: '$b',
          explanation: '[?] = $c ÷ $a = $b',
        );
      }
    } else {
      // Tier 2: Linear equation a × [?] + c = target or 3-digit addition
      if (rnd.nextBool()) {
        final a = 3 + rnd.nextInt(7);
        final b = 4 + rnd.nextInt(15);
        final c = 5 + rnd.nextInt(25);
        final target = a * b + c;
        return ChallengeItem(
          id: 'mis_2_lin_${a}_${c}_$target',
          question: '$a × [?] + $c = $target',
          answer: '$b',
          explanation: '$target − $c = ${a * b}, then ${a * b} ÷ $a = $b',
        );
      } else {
        final a = 120 + rnd.nextInt(400);
        final b = 120 + rnd.nextInt(400);
        final c = a + b;
        return ChallengeItem(
          id: 'mis_2_add_${a}_$c',
          question: '$a + [?] = $c',
          answer: '$b',
          explanation: '[?] = $c − $a = $b',
        );
      }
    }
  }

  static ChallengeItem _generateBodmas(Random rnd, int tier) {
    if (tier == 0) {
      // Tier 0: 1-digit BODMAS (a + b × c)
      final a = 1 + rnd.nextInt(9);
      final b = 2 + rnd.nextInt(5);
      final c = 2 + rnd.nextInt(5);
      final ans = a + b * c;
      return ChallengeItem(
        id: 'bod_0_${a}_${b}_$c',
        question: '$a + $b × $c = ?',
        answer: '$ans',
        explanation: 'Multiply first: $b × $c = ${b * c}, then $a + ${b * c} = $ans',
      );
    } else if (tier == 1) {
      // Tier 1: Parentheses or subtraction
      if (rnd.nextBool()) {
        final a = 2 + rnd.nextInt(8);
        final b = 2 + rnd.nextInt(8);
        final c = 3 + rnd.nextInt(6);
        final ans = (a + b) * c;
        return ChallengeItem(
          id: 'bod_1_par_${a}_${b}_$c',
          question: '($a + $b) × $c = ?',
          answer: '$ans',
          explanation: 'Parentheses first: $a + $b = ${a + b}, then ${a + b} × $c = $ans',
        );
      } else {
        final a = 5 + rnd.nextInt(10);
        final b = 4 + rnd.nextInt(8);
        final c = 2 + rnd.nextInt(15);
        final ans = a * b - c;
        return ChallengeItem(
          id: 'bod_1_sub_${a}_${b}_$c',
          question: '$a × $b − $c = ?',
          answer: '$ans',
          explanation: 'Multiply first: $a × $b = ${a * b}, then ${a * b} − $c = $ans',
        );
      }
    } else {
      // Tier 2: 3-digit or combined operations
      final a = 10 + rnd.nextInt(35);
      final b = 4 + rnd.nextInt(8);
      final c = 2 + rnd.nextInt(8);
      final k = 2 + rnd.nextInt(8);
      final d = c * k;
      final ans = a * b - k;
      return ChallengeItem(
        id: 'bod_2_${a}_${b}_${d}_$c',
        question: '$a × $b − $d ÷ $c = ?',
        answer: '$ans',
        explanation: 'Multiply & divide first: $a × $b = ${a * b} and $d ÷ $c = $k, then ${a * b} − $k = $ans',
      );
    }
  }

  static ChallengeItem _generateLateralOperators(Random rnd, int tier) {
    if (tier == 0) {
      // Tier 0: 1-digit rule
      final a = 2 + rnd.nextInt(6);
      final b = 1 + rnd.nextInt(6);
      final ans = 2 * a + b;
      return ChallengeItem(
        id: 'lat_0_${a}_$b',
        question: 'a ★ b = 2a + b\n$a ★ $b = ?',
        answer: '$ans',
        explanation: 'Substitute: 2($a) + $b = ${2 * a} + $b = $ans',
      );
    } else if (tier == 1) {
      // Tier 1: 2-digit result rule
      if (rnd.nextBool()) {
        final a = 3 + rnd.nextInt(7);
        final b = 3 + rnd.nextInt(7);
        final ans = a * b + a;
        return ChallengeItem(
          id: 'lat_1_mul_${a}_$b',
          question: 'a ★ b = a × b + a\n$a ★ $b = ?',
          answer: '$ans',
          explanation: 'Substitute: ($a × $b) + $a = ${a * b} + $a = $ans',
        );
      } else {
        final a = 2 + rnd.nextInt(8);
        final b = 2 + rnd.nextInt(8);
        final ans = (a + b) * 3;
        return ChallengeItem(
          id: 'lat_1_par_${a}_$b',
          question: 'a ★ b = (a + b) × 3\n$a ★ $b = ?',
          answer: '$ans',
          explanation: 'Substitute: ($a + $b) × 3 = ${a + b} × 3 = $ans',
        );
      }
    } else {
      // Tier 2: Quadratic or multi-variable rule
      final a = 5 + rnd.nextInt(8);
      final b = 2 + rnd.nextInt(5);
      final ans = a * a - b * b;
      return ChallengeItem(
        id: 'lat_2_sq_${a}_$b',
        question: 'a ★ b = a² − b²\n$a ★ $b = ?',
        answer: '$ans',
        explanation: 'Substitute: $a² − $b² = ${a * a} − ${b * b} = $ans',
      );
    }
  }

  static ChallengeItem _generateMathTricks(Random rnd, int tier) {
    if (tier == 0) {
      // Tier 0: 1-digit tricks (+9 trick or ×5 trick)
      if (rnd.nextBool()) {
        final a = 2 + rnd.nextInt(8);
        final ans = a + 9;
        return ChallengeItem(
          id: 'trk_0_add9_$a',
          question: '$a + 9 = ?',
          answer: '$ans',
          explanation: 'Add 10 and subtract 1: ($a + 10) − 1 = $ans',
        );
      } else {
        final a = 2 + rnd.nextInt(7);
        final ans = a * 5;
        return ChallengeItem(
          id: 'trk_0_mul5_$a',
          question: '$a × 5 = ?',
          answer: '$ans',
          explanation: 'Multiply by 10 and halve: ($a × 10) ÷ 2 = $ans',
        );
      }
    } else if (tier == 1) {
      // Tier 1: 2-digit mental math tricks
      if (rnd.nextBool()) {
        final a = 12 + rnd.nextInt(65);
        final ans = a * 11;
        return ChallengeItem(
          id: 'trk_1_11_$a',
          question: '$a × 11 = ?',
          answer: '$ans',
          explanation: '11 trick: $a × 10 + $a = ${a * 10} + $a = $ans',
        );
      } else {
        final n = 5 + rnd.nextInt(6); // 5 to 10 people
        final ans = (n * (n - 1)) ~/ 2;
        return ChallengeItem(
          id: 'trk_1_hand_$n',
          question: 'Handshakes among $n people = ?',
          answer: '$ans',
          explanation: 'Handshake formula: n(n−1) ÷ 2 = ($n × ${n - 1}) ÷ 2 = $ans',
        );
      }
    } else {
      // Tier 2: 25 multiplication or sum of first n numbers
      if (rnd.nextBool()) {
        final k = 3 + rnd.nextInt(15);
        final a = k * 4;
        final ans = k * 100;
        return ChallengeItem(
          id: 'trk_2_25_$a',
          question: '$a × 25 = ?',
          answer: '$ans',
          explanation: '25 trick: ($a ÷ 4) × 100 = $k × 100 = $ans',
        );
      } else {
        final n = 15 + rnd.nextInt(15);
        final ans = (n * (n + 1)) ~/ 2;
        return ChallengeItem(
          id: 'trk_2_sum_$n',
          question: '1 + 2 + ... + $n = ?',
          answer: '$ans',
          explanation: 'Sum of first n numbers: n(n+1) ÷ 2 = ($n × ${n + 1}) ÷ 2 = $ans',
        );
      }
    }
  }
}

final List<ChallengeCategoryInfo> challengeCategories = [
  // 1. ADDITION CHALLENGE (+)
  const ChallengeCategoryInfo(
    type: ChallengeType.addition,
    title: 'ADDITION CHALLENGE',
    icon: Icons.add_rounded,
    symbol: '+',
    description: 'Rapid mental addition, two-digit carrying & running sums.',
    accentColor: Color(0xFF2ECC71), // Emerald green
    items: [
      ChallengeItem(id: 'add_1', question: '15 + 18 = ?', answer: '33'),
      ChallengeItem(id: 'add_2', question: '27 + 36 = ?', answer: '63'),
      ChallengeItem(id: 'add_3', question: '48 + 55 = ?', answer: '103'),
      ChallengeItem(id: 'add_4', question: '64 + 79 = ?', answer: '143'),
      ChallengeItem(id: 'add_5', question: '125 + 85 = ?', answer: '210'),
      ChallengeItem(id: 'add_6', question: '99 + 48 = ?', answer: '147'),
      ChallengeItem(id: 'add_7', question: '156 + 78 = ?', answer: '234'),
      ChallengeItem(id: 'add_8', question: '234 + 189 = ?', answer: '423'),
      ChallengeItem(id: 'add_9', question: '345 + 267 = ?', answer: '612'),
      ChallengeItem(id: 'add_10', question: '489 + 512 = ?', answer: '1001'),
      ChallengeItem(id: 'add_11', question: '75 + 75 + 50 = ?', answer: '200'),
      ChallengeItem(id: 'add_12', question: '112 + 224 = ?', answer: '336'),
      ChallengeItem(id: 'add_13', question: '365 + 135 = ?', answer: '500'),
      ChallengeItem(id: 'add_14', question: '88 + 99 = ?', answer: '187'),
      ChallengeItem(id: 'add_15', question: '540 + 460 = ?', answer: '1000'),
    ],
  ),

  // 2. SUBTRACTION CHALLENGE (-)
  const ChallengeCategoryInfo(
    type: ChallengeType.subtraction,
    title: 'SUBTRACTION CHALLENGE',
    icon: Icons.remove_rounded,
    symbol: '−',
    description: 'Speed borrows, subtraction shortcuts & mental differences.',
    accentColor: Color(0xFFE74C3C), // Coral red
    items: [
      ChallengeItem(id: 'sub_1', question: '35 - 18 = ?', answer: '17'),
      ChallengeItem(id: 'sub_2', question: '52 - 27 = ?', answer: '25'),
      ChallengeItem(id: 'sub_3', question: '84 - 39 = ?', answer: '45'),
      ChallengeItem(id: 'sub_4', question: '100 - 43 = ?', answer: '57'),
      ChallengeItem(id: 'sub_5', question: '142 - 68 = ?', answer: '74'),
      ChallengeItem(id: 'sub_6', question: '200 - 85 = ?', answer: '115'),
      ChallengeItem(id: 'sub_7', question: '250 - 137 = ?', answer: '113'),
      ChallengeItem(id: 'sub_8', question: '314 - 158 = ?', answer: '156'),
      ChallengeItem(id: 'sub_9', question: '500 - 246 = ?', answer: '254'),
      ChallengeItem(id: 'sub_10', question: '1000 - 375 = ?', answer: '625'),
      ChallengeItem(id: 'sub_11', question: '90 - 45 - 15 = ?', answer: '30'),
      ChallengeItem(id: 'sub_12', question: '180 - 95 = ?', answer: '85'),
      ChallengeItem(id: 'sub_13', question: '420 - 165 = ?', answer: '255'),
      ChallengeItem(id: 'sub_14', question: '150 - 88 = ?', answer: '62'),
      ChallengeItem(id: 'sub_15', question: '750 - 385 = ?', answer: '365'),
    ],
  ),

  // 3. MULTIPLICATION CHALLENGE (×)
  const ChallengeCategoryInfo(
    type: ChallengeType.multiplication,
    title: 'MULTIPLICATION CHALLENGE',
    icon: Icons.close_rounded,
    symbol: '×',
    description: 'Times tables, cross-products & rapid factor calculations.',
    accentColor: Color(0xFF9B59B6), // Purple
    items: [
      ChallengeItem(id: 'mul_1', question: '6 × 7 = ?', answer: '42'),
      ChallengeItem(id: 'mul_2', question: '8 × 9 = ?', answer: '72'),
      ChallengeItem(id: 'mul_3', question: '12 × 6 = ?', answer: '72'),
      ChallengeItem(id: 'mul_4', question: '15 × 4 = ?', answer: '60'),
      ChallengeItem(id: 'mul_5', question: '13 × 7 = ?', answer: '91'),
      ChallengeItem(id: 'mul_6', question: '16 × 5 = ?', answer: '80'),
      ChallengeItem(id: 'mul_7', question: '12 × 12 = ?', answer: '144'),
      ChallengeItem(id: 'mul_8', question: '14 × 8 = ?', answer: '112'),
      ChallengeItem(id: 'mul_9', question: '25 × 6 = ?', answer: '150'),
      ChallengeItem(id: 'mul_10', question: '15 × 15 = ?', answer: '225'),
      ChallengeItem(id: 'mul_11', question: '20 × 18 = ?', answer: '360'),
      ChallengeItem(id: 'mul_12', question: '35 × 4 = ?', answer: '140'),
      ChallengeItem(id: 'mul_13', question: '18 × 9 = ?', answer: '162'),
      ChallengeItem(id: 'mul_14', question: '45 × 4 = ?', answer: '180'),
      ChallengeItem(id: 'mul_15', question: '24 × 5 = ?', answer: '120'),
    ],
  ),

  // 4. DIVISION CHALLENGE (÷)
  const ChallengeCategoryInfo(
    type: ChallengeType.division,
    title: 'DIVISION CHALLENGE',
    icon: CupertinoIcons.divide,
    symbol: '÷',
    description: 'Integer quotient factors, divisibility rules & split factors.',
    accentColor: Color(0xFF3498DB), // Sky blue
    items: [
      ChallengeItem(id: 'div_1', question: '48 ÷ 6 = ?', answer: '8'),
      ChallengeItem(id: 'div_2', question: '72 ÷ 8 = ?', answer: '9'),
      ChallengeItem(id: 'div_3', question: '96 ÷ 8 = ?', answer: '12'),
      ChallengeItem(id: 'div_4', question: '108 ÷ 9 = ?', answer: '12'),
      ChallengeItem(id: 'div_5', question: '144 ÷ 12 = ?', answer: '12'),
      ChallengeItem(id: 'div_6', question: '175 ÷ 5 = ?', answer: '35'),
      ChallengeItem(id: 'div_7', question: '225 ÷ 15 = ?', answer: '15'),
      ChallengeItem(id: 'div_8', question: '256 ÷ 16 = ?', answer: '16'),
      ChallengeItem(id: 'div_9', question: '300 ÷ 12 = ?', answer: '25'),
      ChallengeItem(id: 'div_10', question: '400 ÷ 25 = ?', answer: '16'),
      ChallengeItem(id: 'div_11', question: '180 ÷ 4 = ?', answer: '45'),
      ChallengeItem(id: 'div_12', question: '500 ÷ 20 = ?', answer: '25'),
      ChallengeItem(id: 'div_13', question: '360 ÷ 8 = ?', answer: '45'),
      ChallengeItem(id: 'div_14', question: '196 ÷ 14 = ?', answer: '14'),
      ChallengeItem(id: 'div_15', question: '720 ÷ 9 = ?', answer: '80'),
    ],
  ),

  // 5. SQUARES & POWERS CHALLENGE (x²)
  const ChallengeCategoryInfo(
    type: ChallengeType.powers,
    title: 'SQUARES & POWERS',
    icon: Icons.superscript_rounded,
    symbol: 'x²',
    description: 'Mental square numbers, cubes, power exponents & roots.',
    accentColor: Color(0xFFE67E22), // Deep Orange
    items: [
      ChallengeItem(id: 'pow_1', question: '7² = ?', answer: '49'),
      ChallengeItem(id: 'pow_2', question: '9² = ?', answer: '81'),
      ChallengeItem(id: 'pow_3', question: '12² = ?', answer: '144'),
      ChallengeItem(id: 'pow_4', question: '15² = ?', answer: '225'),
      ChallengeItem(id: 'pow_5', question: '20² = ?', answer: '400'),
      ChallengeItem(id: 'pow_6', question: '2⁴ = ?', answer: '16'),
      ChallengeItem(id: 'pow_7', question: '3³ = ?', answer: '27'),
      ChallengeItem(id: 'pow_8', question: '4³ = ?', answer: '64'),
      ChallengeItem(id: 'pow_9', question: '5³ = ?', answer: '125'),
      ChallengeItem(id: 'pow_10', question: '2⁵ = ?', answer: '32'),
      ChallengeItem(id: 'pow_11', question: '3² + 4² = ?', answer: '25'),
      ChallengeItem(id: 'pow_12', question: '6² + 8² = ?', answer: '100'),
      ChallengeItem(id: 'pow_13', question: '5² + 12² = ?', answer: '169'),
      ChallengeItem(id: 'pow_14', question: '10³ - 10² = ?', answer: '900'),
      ChallengeItem(id: 'pow_15', question: '2⁶ = ?', answer: '64'),
    ],
  ),

  // 6. PERCENTAGES & COMMERCIAL MATH (%)
  const ChallengeCategoryInfo(
    type: ChallengeType.percentages,
    title: 'PERCENTAGES & RATES',
    icon: Icons.percent_rounded,
    symbol: '%',
    description: 'Quick mental percentages, fractional discounts & commercial rates.',
    accentColor: Color(0xFF1ABC9C), // Teal
    items: [
      ChallengeItem(id: 'pct_1', question: '50% of 80 = ?', answer: '40'),
      ChallengeItem(id: 'pct_2', question: '25% of 120 = ?', answer: '30'),
      ChallengeItem(id: 'pct_3', question: '10% of 450 = ?', answer: '45'),
      ChallengeItem(id: 'pct_4', question: '20% of 150 = ?', answer: '30'),
      ChallengeItem(id: 'pct_5', question: '75% of 200 = ?', answer: '150'),
      ChallengeItem(id: 'pct_6', question: '50% of 140 = ?', answer: '70'),
      ChallengeItem(id: 'pct_7', question: '30% of 90 = ?', answer: '27'),
      ChallengeItem(id: 'pct_8', question: '40% of 250 = ?', answer: '100'),
      ChallengeItem(id: 'pct_9', question: '15% of 200 = ?', answer: '30'),
      ChallengeItem(id: 'pct_10', question: '5% of 600 = ?', answer: '30'),
      ChallengeItem(id: 'pct_11', question: '25% off \$80 item. Price = \$?', answer: '60'),
      ChallengeItem(id: 'pct_12', question: '20% off \$150 item. Price = \$?', answer: '120'),
      ChallengeItem(id: 'pct_13', question: '50% of 360 = ?', answer: '180'),
      ChallengeItem(id: 'pct_14', question: '10% of 1200 = ?', answer: '120'),
      ChallengeItem(id: 'pct_15', question: '75% of 80 = ?', answer: '60'),
    ],
  ),

  // 7. NUMBER SEQUENCES & PROGRESSIONS (...)
  const ChallengeCategoryInfo(
    type: ChallengeType.sequences,
    title: 'SEQUENCES & PATTERNS',
    icon: Icons.trending_up_rounded,
    symbol: '⋯',
    description: 'Find the next term in arithmetic, geometric & Fibonacci series.',
    accentColor: Color(0xFF8E44AD), // Dark purple
    items: [
      ChallengeItem(id: 'seq_1', question: '3, 7, 11, 15, ?', answer: '19'),
      ChallengeItem(id: 'seq_2', question: '2, 6, 18, 54, ?', answer: '162'),
      ChallengeItem(id: 'seq_3', question: '4, 9, 16, 25, ?', answer: '36'),
      ChallengeItem(id: 'seq_4', question: '1, 1, 2, 3, 5, 8, ?', answer: '13'),
      ChallengeItem(id: 'seq_5', question: '5, 10, 20, 40, ?', answer: '80'),
      ChallengeItem(id: 'seq_6', question: '1, 8, 27, 64, ?', answer: '125'),
      ChallengeItem(id: 'seq_7', question: '100, 95, 85, 70, ?', answer: '50'),
      ChallengeItem(id: 'seq_8', question: '2, 5, 10, 17, 26, ?', answer: '37'),
      ChallengeItem(id: 'seq_9', question: '6, 11, 21, 36, 56, ?', answer: '81'),
      ChallengeItem(id: 'seq_10', question: '3, 6, 12, 24, 48, ?', answer: '96'),
      ChallengeItem(id: 'seq_11', question: '2, 3, 5, 8, 12, ?', answer: '17'),
      ChallengeItem(id: 'seq_12', question: '1, 4, 10, 22, 46, ?', answer: '94'),
      ChallengeItem(id: 'seq_13', question: '7, 14, 28, 56, ?', answer: '112'),
      ChallengeItem(id: 'seq_14', question: '81, 64, 49, 36, ?', answer: '25'),
      ChallengeItem(id: 'seq_15', question: '10, 20, 25, 50, 55, ?', answer: '110'),
    ],
  ),

  // 8. MISSING NUMBER & BALANCES (?)
  const ChallengeCategoryInfo(
    type: ChallengeType.missingNumbers,
    title: 'MISSING NUMBER PUZZLES',
    icon: Icons.question_mark_rounded,
    symbol: '?',
    description: 'Solve the missing variable in arithmetic equations & balances.',
    accentColor: Color(0xFFD35400), // Amber-Red
    items: [
      ChallengeItem(id: 'mis_1', question: '14 + [?] = 39', answer: '25'),
      ChallengeItem(id: 'mis_2', question: '5 × [?] = 65', answer: '13'),
      ChallengeItem(id: 'mis_3', question: '[?] - 28 = 45', answer: '73'),
      ChallengeItem(id: 'mis_4', question: '84 ÷ [?] = 7', answer: '12'),
      ChallengeItem(id: 'mis_5', question: '(3 × [?]) + 7 = 31', answer: '8'),
      ChallengeItem(id: 'mis_6', question: '(4 × [?]) - 12 = 28', answer: '10'),
      ChallengeItem(id: 'mis_7', question: '15 + [?] + 20 = 50', answer: '15'),
      ChallengeItem(id: 'mis_8', question: '[?] × 6 + 9 = 57', answer: '8'),
      ChallengeItem(id: 'mis_9', question: '100 - [?] = 37', answer: '63'),
      ChallengeItem(id: 'mis_10', question: '[?] ÷ 5 + 14 = 20', answer: '30'),
      ChallengeItem(id: 'mis_11', question: '(2 × [?]) + 15 = 45', answer: '15'),
      ChallengeItem(id: 'mis_12', question: '70 - (3 × [?]) = 25', answer: '15'),
      ChallengeItem(id: 'mis_13', question: '[?] × 9 = 108', answer: '12'),
      ChallengeItem(id: 'mis_14', question: '45 + [?] = 100', answer: '55'),
      ChallengeItem(id: 'mis_15', question: '(5 × [?]) + 25 = 100', answer: '15'),
    ],
  ),

  // 9. BODMAS & ORDER OF OPERATIONS
  const ChallengeCategoryInfo(
    type: ChallengeType.bodmas,
    title: 'BODMAS PRECEDENCE',
    icon: Icons.balance_rounded,
    symbol: 'BODMAS',
    description: 'Hierarchical operator evaluation, parentheses & precedence traps.',
    accentColor: Color(0xFF2980B9), // Strong Blue
    items: [
      ChallengeItem(id: 'bod_1', question: '8 + 8 × 2 = ?', answer: '24'),
      ChallengeItem(id: 'bod_2', question: '20 - 10 ÷ 2 = ?', answer: '15'),
      ChallengeItem(id: 'bod_3', question: '6 ÷ 2 × (1 + 2) = ?', answer: '9'),
      ChallengeItem(id: 'bod_4', question: '15 + 5 × 4 - 10 = ?', answer: '25'),
      ChallengeItem(id: 'bod_5', question: '50 - 5 × 5 + 5 = ?', answer: '30'),
      ChallengeItem(id: 'bod_6', question: '8 + 8 ÷ 8 + 8 = ?', answer: '17'),
      ChallengeItem(id: 'bod_7', question: '(12 - 4) × (3 + 2) = ?', answer: '40'),
      ChallengeItem(id: 'bod_8', question: '100 - 20 × 4 + 10 = ?', answer: '30'),
      ChallengeItem(id: 'bod_9', question: '60 ÷ 5 × 3 = ?', answer: '36'),
      ChallengeItem(id: 'bod_10', question: '18 - 3 × (2 + 3) = ?', answer: '3'),
      ChallengeItem(id: 'bod_11', question: '4 × 5 + 6 × 3 = ?', answer: '38'),
      ChallengeItem(id: 'bod_12', question: '30 - 2 × 3² = ?', answer: '12'),
      ChallengeItem(id: 'bod_13', question: '(15 + 25) ÷ 4 + 7 = ?', answer: '17'),
      ChallengeItem(id: 'bod_14', question: '7 + 7 ÷ 7 + 7 × 7 - 7 = ?', answer: '50'),
      ChallengeItem(id: 'bod_15', question: '5 × (10 - 2) - 4² = ?', answer: '24'),
    ],
  ),

  // 10. LATERAL OPERATORS & CUSTOM MATH (⊕)
  const ChallengeCategoryInfo(
    type: ChallengeType.lateralOperators,
    title: 'LATERAL OPERATORS',
    icon: Icons.change_circle_outlined,
    symbol: '⊕',
    description: 'Solve custom non-standard algebraic operator functions.',
    accentColor: Color(0xFFC0392B), // Deep Red
    items: [
      ChallengeItem(id: 'lat_1', question: 'If a ⊕ b = a + 2b, then 5 ⊕ 4 = ?', answer: '13'),
      ChallengeItem(id: 'lat_2', question: 'If a ★ b = a × b - a, then 6 ★ 5 = ?', answer: '24'),
      ChallengeItem(id: 'lat_3', question: 'If a ⨁ b = 2a + 3b, then 4 ⨁ 3 = ?', answer: '17'),
      ChallengeItem(id: 'lat_4', question: 'If a ⊗ b = a² - b, then 7 ⊗ 15 = ?', answer: '34'),
      ChallengeItem(id: 'lat_5', question: 'If a ⊙ b = (a + b) × 2, then 8 ⊙ 7 = ?', answer: '30'),
      ChallengeItem(id: 'lat_6', question: 'If a ⊘ b = a × b + 5, then 6 ⊘ 6 = ?', answer: '41'),
      ChallengeItem(id: 'lat_7', question: 'If a ⧫ b = a² - b², then 10 ⧫ 6 = ?', answer: '64'),
      ChallengeItem(id: 'lat_8', question: 'If a ⋈ b = 3a - b, then 9 ⋈ 7 = ?', answer: '20'),
      ChallengeItem(id: 'lat_9', question: 'If a ∇ b = (a × b) ÷ 2, then 8 ∇ 6 = ?', answer: '24'),
      ChallengeItem(id: 'lat_10', question: 'If a ⊛ b = a + b + a × b, then 4 ⊛ 5 = ?', answer: '29'),
      ChallengeItem(id: 'lat_11', question: 'If a ⊞ b = 2(a + b) + 1, then 6 ⊞ 4 = ?', answer: '21'),
      ChallengeItem(id: 'lat_12', question: 'If a ⨂ b = a² + b², then 4 ⨂ 5 = ?', answer: '41'),
      ChallengeItem(id: 'lat_13', question: 'If a △ b = (a - b)², then 12 △ 5 = ?', answer: '49'),
      ChallengeItem(id: 'lat_14', question: 'If a ◇ b = 4a - 2b, then 7 ◇ 5 = ?', answer: '18'),
      ChallengeItem(id: 'lat_15', question: 'If a ⨝ b = (a + b) × (a - b), then 8 ⨝ 2 = ?', answer: '60'),
    ],
  ),

  // 11. SPEED MATH TRICKS & SHORTCUTS
  const ChallengeCategoryInfo(
    type: ChallengeType.mathTricks,
    title: 'SPEED MATH TRICKS',
    icon: Icons.lightbulb_outline_rounded,
    symbol: 'TRICK',
    description: 'Mental shortcuts, handshake formulas & clock angle secrets.',
    accentColor: Color(0xFFF39C12), // Bright Orange-Gold
    items: [
      ChallengeItem(id: 'trk_1', question: '10 + 10 × 0 + 10 = ?', answer: '20'),
      ChallengeItem(id: 'trk_2', question: '4 people shake hands with each other once. Total handshakes? [?]', answer: '6'),
      ChallengeItem(id: 'trk_3', question: '6 people shake hands with each other once. Total handshakes? [?]', answer: '15'),
      ChallengeItem(id: 'trk_4', question: '8 people shake hands with each other once. Total handshakes? [?]', answer: '28'),
      ChallengeItem(id: 'trk_5', question: 'Angle between clock hands at 3:00? [?]°', answer: '90'),
      ChallengeItem(id: 'trk_6', question: 'Angle between clock hands at 4:00? [?]°', answer: '120'),
      ChallengeItem(id: 'trk_7', question: 'Angle between clock hands at 6:00? [?]°', answer: '180'),
      ChallengeItem(id: 'trk_8', question: '99 × 6 = ?', answer: '594'),
      ChallengeItem(id: 'trk_9', question: '99 × 8 = ?', answer: '792'),
      ChallengeItem(id: 'trk_10', question: '1000 - 364 = ?', answer: '636'),
      ChallengeItem(id: 'trk_11', question: 'Sum of numbers from 1 to 10? [?]', answer: '55'),
      ChallengeItem(id: 'trk_12', question: 'Sum of numbers from 1 to 8? [?]', answer: '36'),
      ChallengeItem(id: 'trk_13', question: 'Snail climbs 3ft, slips 2ft daily. Days to escape 10ft well? [?]', answer: '8'),
      ChallengeItem(id: 'trk_14', question: '101 × 15 = ?', answer: '1515'),
      ChallengeItem(id: 'trk_15', question: '15 × 16 = ?', answer: '240'),
    ],
  ),

  // 12. MIXED CHALLENGE (Combines all available categories)
  const ChallengeCategoryInfo(
    type: ChallengeType.mixed,
    title: 'MIXED CHALLENGE',
    icon: Icons.shuffle_rounded,
    symbol: 'MIX',
    description: 'Combines questions from all available challenge categories in a continuous mixed session.',
    accentColor: Color(0xFFF5A623), // Amber gold
    items: [
      ChallengeItem(id: 'c1', question: '7 × 8 - 6 = ?', answer: '50'),
      ChallengeItem(id: 'c2', question: '3² + 4² = ?', answer: '25'),
      ChallengeItem(id: 'c3', question: '4, 9, 16, 25, ?', answer: '36'),
      ChallengeItem(id: 'c4', question: '100 / 4 + 17 = ?', answer: '42'),
      ChallengeItem(id: 'c5', question: '2, 6, 18, 54, ?', answer: '162'),
      ChallengeItem(id: 'c6', question: '12 × 12 - 44 = ?', answer: '100'),
      ChallengeItem(id: 'c7', question: '15 + 25 × 2 = ?', answer: '65'),
      ChallengeItem(id: 'c8', question: '9² - 9 = ?', answer: '72'),
      ChallengeItem(id: 'c9', question: '2³ + 3² = ?', answer: '17'),
      ChallengeItem(id: 'c10', question: '50% of 140 = ?', answer: '70'),
      ChallengeItem(id: 'c11', question: '60 ÷ 5 × 3 = ?', answer: '36'),
      ChallengeItem(id: 'c12', question: '8 + 8 × 8 - 8 = ?', answer: '64'),
      ChallengeItem(id: 'c13', question: '150 - 25 × 4 = ?', answer: '50'),
      ChallengeItem(id: 'c14', question: '(20 + 30) × 2 = ?', answer: '100'),
      ChallengeItem(id: 'c15', question: '180 ÷ (3 × 2) = ?', answer: '30'),
    ],
  ),
];
