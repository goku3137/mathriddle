import 'dart:math';
import '../models/challenge_models.dart';
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
      question: '$a âˆ’ $b = ?',
      answer: '$diff',
      explanation: '$a âˆ’ $b = $diff',
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
      question: '$a Ã— $b = ?',
      answer: '$ans',
      explanation: '$a Ã— $b = $ans',
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
      question: '$dividend Ã· $divisor = ?',
      answer: '$quotient',
      explanation: '$dividend Ã· $divisor = $quotient (since $quotient Ã— $divisor = $dividend)',
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
          question: '$nÂ² = ?',
          answer: '$ans',
          explanation: '$n Ã— $n = $ans',
        );
      } else {
        final sq = n * n;
        return ChallengeItem(
          id: 'pow_0_sqrt_$sq',
          question: 'âˆš$sq = ?',
          answer: '$n',
          explanation: 'âˆš$sq = $n (since $n Ã— $n = $sq)',
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
          question: '$nÂ² = ?',
          answer: '$ans',
          explanation: '$n Ã— $n = $ans',
        );
      } else if (variant == 1) {
        final n = 10 + rnd.nextInt(11);
        final sq = n * n;
        return ChallengeItem(
          id: 'pow_1_sqrt_$sq',
          question: 'âˆš$sq = ?',
          answer: '$n',
          explanation: 'âˆš$sq = $n (since $n Ã— $n = $sq)',
        );
      } else {
        final n = 2 + rnd.nextInt(4);
        final ans = n * n * n;
        return ChallengeItem(
          id: 'pow_1_cb_$n',
          question: '$nÂ³ = ?',
          answer: '$ans',
          explanation: '$n Ã— $n Ã— $n = $ans',
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
          question: '$nÂ² = ?',
          answer: '$ans',
          explanation: '$n Ã— $n = $ans',
        );
      } else if (variant == 1) {
        final n = 21 + rnd.nextInt(15);
        final sq = n * n;
        return ChallengeItem(
          id: 'pow_2_sqrt_$sq',
          question: 'âˆš$sq = ?',
          answer: '$n',
          explanation: 'âˆš$sq = $n (since $n Ã— $n = $sq)',
        );
      } else {
        final n = 6 + rnd.nextInt(5);
        final ans = n * n * n;
        return ChallengeItem(
          id: 'pow_2_cb_$n',
          question: '$nÂ³ = ?',
          answer: '$ans',
          explanation: '$n Ã— $n Ã— $n = $ans',
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
          explanation: '10% of $base = $base Ã· 10 = $ans',
        );
      } else {
        final k = 1 + rnd.nextInt(9);
        final base = k * 2;
        final ans = k;
        return ChallengeItem(
          id: 'pct_0_50_$base',
          question: '50% of $base = ?',
          answer: '$ans',
          explanation: '50% of $base = $base Ã· 2 = $ans',
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
        explanation: '$pct% of $base = ($pct Ã— $base) Ã· 100 = $ans',
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
        explanation: '$pct% of $base = ($pct Ã— $base) Ã· 100 = $ans',
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
          explanation: 'Multiply by 2 each step: $t4 Ã— 2 = $ans',
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
          explanation: 'Consecutive squares: (${offset + 4})Â² = $ans',
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
          explanation: '[?] = $c âˆ’ $a = $b',
        );
      } else {
        final a = 2 + rnd.nextInt(8);
        final b = 2 + rnd.nextInt(8);
        final c = a * b;
        return ChallengeItem(
          id: 'mis_0_mul_${a}_$c',
          question: '$a Ã— [?] = $c',
          answer: '$b',
          explanation: '[?] = $c Ã· $a = $b',
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
          explanation: '[?] = $c âˆ’ $a = $b',
        );
      } else {
        final a = 3 + rnd.nextInt(8);
        final b = 11 + rnd.nextInt(18);
        final c = a * b;
        return ChallengeItem(
          id: 'mis_1_mul_${a}_$c',
          question: '$a Ã— [?] = $c',
          answer: '$b',
          explanation: '[?] = $c Ã· $a = $b',
        );
      }
    } else {
      // Tier 2: Linear equation a Ã— [?] + c = target or 3-digit addition
      if (rnd.nextBool()) {
        final a = 3 + rnd.nextInt(7);
        final b = 4 + rnd.nextInt(15);
        final c = 5 + rnd.nextInt(25);
        final target = a * b + c;
        return ChallengeItem(
          id: 'mis_2_lin_${a}_${c}_$target',
          question: '$a Ã— [?] + $c = $target',
          answer: '$b',
          explanation: '$target âˆ’ $c = ${a * b}, then ${a * b} Ã· $a = $b',
        );
      } else {
        final a = 120 + rnd.nextInt(400);
        final b = 120 + rnd.nextInt(400);
        final c = a + b;
        return ChallengeItem(
          id: 'mis_2_add_${a}_$c',
          question: '$a + [?] = $c',
          answer: '$b',
          explanation: '[?] = $c âˆ’ $a = $b',
        );
      }
    }
  }

  static ChallengeItem _generateBodmas(Random rnd, int tier) {
    if (tier == 0) {
      // Tier 0: 1-digit BODMAS (a + b Ã— c)
      final a = 1 + rnd.nextInt(9);
      final b = 2 + rnd.nextInt(5);
      final c = 2 + rnd.nextInt(5);
      final ans = a + b * c;
      return ChallengeItem(
        id: 'bod_0_${a}_${b}_$c',
        question: '$a + $b Ã— $c = ?',
        answer: '$ans',
        explanation: 'Multiply first: $b Ã— $c = ${b * c}, then $a + ${b * c} = $ans',
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
          question: '($a + $b) Ã— $c = ?',
          answer: '$ans',
          explanation: 'Parentheses first: $a + $b = ${a + b}, then ${a + b} Ã— $c = $ans',
        );
      } else {
        final a = 5 + rnd.nextInt(10);
        final b = 4 + rnd.nextInt(8);
        final c = 2 + rnd.nextInt(15);
        final ans = a * b - c;
        return ChallengeItem(
          id: 'bod_1_sub_${a}_${b}_$c',
          question: '$a Ã— $b âˆ’ $c = ?',
          answer: '$ans',
          explanation: 'Multiply first: $a Ã— $b = ${a * b}, then ${a * b} âˆ’ $c = $ans',
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
        question: '$a Ã— $b âˆ’ $d Ã· $c = ?',
        answer: '$ans',
        explanation: 'Multiply & divide first: $a Ã— $b = ${a * b} and $d Ã· $c = $k, then ${a * b} âˆ’ $k = $ans',
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
        question: 'a â˜… b = 2a + b\n$a â˜… $b = ?',
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
          question: 'a â˜… b = a Ã— b + a\n$a â˜… $b = ?',
          answer: '$ans',
          explanation: 'Substitute: ($a Ã— $b) + $a = ${a * b} + $a = $ans',
        );
      } else {
        final a = 2 + rnd.nextInt(8);
        final b = 2 + rnd.nextInt(8);
        final ans = (a + b) * 3;
        return ChallengeItem(
          id: 'lat_1_par_${a}_$b',
          question: 'a â˜… b = (a + b) Ã— 3\n$a â˜… $b = ?',
          answer: '$ans',
          explanation: 'Substitute: ($a + $b) Ã— 3 = ${a + b} Ã— 3 = $ans',
        );
      }
    } else {
      // Tier 2: Quadratic or multi-variable rule
      final a = 5 + rnd.nextInt(8);
      final b = 2 + rnd.nextInt(5);
      final ans = a * a - b * b;
      return ChallengeItem(
        id: 'lat_2_sq_${a}_$b',
        question: 'a â˜… b = aÂ² âˆ’ bÂ²\n$a â˜… $b = ?',
        answer: '$ans',
        explanation: 'Substitute: $aÂ² âˆ’ $bÂ² = ${a * a} âˆ’ ${b * b} = $ans',
      );
    }
  }

  static ChallengeItem _generateMathTricks(Random rnd, int tier) {
    if (tier == 0) {
      // Tier 0: 1-digit tricks (+9 trick or Ã—5 trick)
      if (rnd.nextBool()) {
        final a = 2 + rnd.nextInt(8);
        final ans = a + 9;
        return ChallengeItem(
          id: 'trk_0_add9_$a',
          question: '$a + 9 = ?',
          answer: '$ans',
          explanation: 'Add 10 and subtract 1: ($a + 10) âˆ’ 1 = $ans',
        );
      } else {
        final a = 2 + rnd.nextInt(7);
        final ans = a * 5;
        return ChallengeItem(
          id: 'trk_0_mul5_$a',
          question: '$a Ã— 5 = ?',
          answer: '$ans',
          explanation: 'Multiply by 10 and halve: ($a Ã— 10) Ã· 2 = $ans',
        );
      }
    } else if (tier == 1) {
      // Tier 1: 2-digit mental math tricks
      if (rnd.nextBool()) {
        final a = 12 + rnd.nextInt(65);
        final ans = a * 11;
        return ChallengeItem(
          id: 'trk_1_11_$a',
          question: '$a Ã— 11 = ?',
          answer: '$ans',
          explanation: '11 trick: $a Ã— 10 + $a = ${a * 10} + $a = $ans',
        );
      } else {
        final n = 5 + rnd.nextInt(6); // 5 to 10 people
        final ans = (n * (n - 1)) ~/ 2;
        return ChallengeItem(
          id: 'trk_1_hand_$n',
          question: 'Handshakes among $n people = ?',
          answer: '$ans',
          explanation: 'Handshake formula: n(nâˆ’1) Ã· 2 = ($n Ã— ${n - 1}) Ã· 2 = $ans',
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
          question: '$a Ã— 25 = ?',
          answer: '$ans',
          explanation: '25 trick: ($a Ã· 4) Ã— 100 = $k Ã— 100 = $ans',
        );
      } else {
        final n = 15 + rnd.nextInt(15);
        final ans = (n * (n + 1)) ~/ 2;
        return ChallengeItem(
          id: 'trk_2_sum_$n',
          question: '1 + 2 + ... + $n = ?',
          answer: '$ans',
          explanation: 'Sum of first n numbers: n(n+1) Ã· 2 = ($n Ã— ${n + 1}) Ã· 2 = $ans',
        );
      }
    }
  }
}

