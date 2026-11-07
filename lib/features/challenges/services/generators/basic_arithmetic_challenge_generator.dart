import 'dart:math';
import '../../models/challenge_models.dart';

/// Basic 4-operation challenge generators (Addition, Subtraction, Multiplication, Division).
class BasicArithmeticChallengeGenerator {
  const BasicArithmeticChallengeGenerator._();

  static ChallengeItem generateAddition(Random rnd, int tier) {
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

  static ChallengeItem generateSubtraction(Random rnd, int tier) {
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

  static ChallengeItem generateMultiplication(Random rnd, int tier) {
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

  static ChallengeItem generateDivision(Random rnd, int tier) {
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
}

