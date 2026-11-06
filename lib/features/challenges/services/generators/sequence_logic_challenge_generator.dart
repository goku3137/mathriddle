import 'dart:math';
import '../../models/challenge_models.dart';

/// Sequence, missing number, and lateral logic challenge generators.
class SequenceLogicChallengeGenerator {
  const SequenceLogicChallengeGenerator._();

  static ChallengeItem generateSequences(Random rnd, int tier) {
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

  static ChallengeItem generateMissingNumbers(Random rnd, int tier) {
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

  static ChallengeItem generateLateralOperators(Random rnd, int tier) {
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
      // Tier 2: Quadratic or multi-variable rule (guarantee a > b for non-negative result)
      final b = 2 + rnd.nextInt(4);
      final a = b + 1 + rnd.nextInt(6);
      final ans = a * a - b * b;
      return ChallengeItem(
        id: 'lat_2_sq_${a}_$b',
        question: 'a ★ b = a² − b²\n$a ★ $b = ?',
        answer: '$ans',
        explanation: 'Substitute: $a² − $b² = ${a * a} − ${b * b} = $ans',
      );
    }
  }
}

