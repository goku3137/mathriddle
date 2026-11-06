import 'dart:math';
import '../../models/challenge_models.dart';

/// Advanced arithmetic challenge generators (Powers, Percentages, BODMAS, Math Tricks).
class AdvancedArithmeticChallengeGenerator {
  const AdvancedArithmeticChallengeGenerator._();

  static ChallengeItem generatePowers(Random rnd, int tier) {
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

  static ChallengeItem generatePercentages(Random rnd, int tier) {
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

  static ChallengeItem generateBodmas(Random rnd, int tier) {
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

  static ChallengeItem generateMathTricks(Random rnd, int tier) {
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
