import 'package:flutter/material.dart';

enum ChallengeType {
  addition,
  subtraction,
  multiplication,
  division,
  mixed,
}

class ChallengeItem {
  final String id;
  final String question;
  final String answer;

  const ChallengeItem({
    required this.id,
    required this.question,
    required this.answer,
  });
}

class ChallengeCategoryInfo {
  final ChallengeType type;
  final String title;
  final String symbol;
  final String description;
  final Color accentColor;
  final List<ChallengeItem> items;

  const ChallengeCategoryInfo({
    required this.type,
    required this.title,
    required this.symbol,
    required this.description,
    required this.accentColor,
    required this.items,
  });
}

final List<ChallengeCategoryInfo> challengeCategories = [
  // 1. ADDITION CHALLENGE (+)
  const ChallengeCategoryInfo(
    type: ChallengeType.addition,
    title: 'ADDITION CHALLENGE',
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

  // 5. ALL MIXED SPRINT (All Combined)
  const ChallengeCategoryInfo(
    type: ChallengeType.mixed,
    title: 'ALL MIXED SPRINT',
    symbol: '🔀',
    description: 'All 4 operations combined (+, −, ×, ÷) with BODMAS precedence.',
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
