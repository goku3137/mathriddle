import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

/// Stage 1: Absolute Beginner
/// Designed for learners with little to no previous math background.
final List<Lesson> stage1AbsoluteBeginner = [
  // Lesson 1
  const Lesson(
    id: 'stage1_lesson1_place_values',
    title: '1. Understanding Numbers & Place Values',
    category: 'Foundations',
    stage: 'Stage 1 – Absolute Beginner',
    stageIndex: 1,
    difficulty: 'Beginner',
    conceptSummary:
        'All numbers are built using just 10 digits (0 through 9). Where a digit sits determines what it is worth: Units, Tens, or Hundreds.',
    formula: 'Place Values: 100s (Hundreds) | 10s (Tens) | 1s (Units)',
    whatItIs:
        'Numbers count objects in the world. Instead of creating new symbols for every number, we reuse digits 0 to 9 in different positions called place values.',
    whyItWorks:
        'Each step to the left multiplies a digit by 10. In 345, the 3 is worth 300, the 4 is worth 40, and the 5 is worth 5.',
    howToSolveIt:
        'Start at the far right: that is the Units (1s). Move one place left: that is the Tens (10s). Move another place left: that is Hundreds (100s).',
    whenToUseIt:
        'Use place values whenever reading price tags, counting money bills, or telling which number is bigger.',
    stepByStepExplanation:
        'Step 1: Look at the number 752.\nStep 2: The rightmost digit 2 represents 2 units (2 × 1 = 2).\nStep 3: The middle digit 5 sits in the Tens column, so it is worth 5 tens (5 × 10 = 50).\nStep 4: The leftmost digit 7 sits in Hundreds, worth 700.\nTotal: 700 + 50 + 2 = 752.',
    workedExample:
        'Example: In the number 834, what is the value of the 3?\nThe 3 is in the Tens position. 3 × 10 = 30.',
    takeaway: 'Each position to the left makes a digit 10 times more valuable.',
    commonMistakes: [
      'Confusing the digit with its value (in 52, thinking 5 is just 5 instead of 50).',
      'Forgetting that 0 holds an empty place (in 104, the 0 holds the tens place).',
    ],
    shortcutsAndTricks: [
      'To find the value of a digit, replace every digit to its right with a zero: in 472, the 4 is worth 400.',
    ],
    alternativeMethods: [
      'Count using money bills: 7 hundreds (\$100), 5 tens (\$10), and 2 ones (\$1).',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [1, 2, 3],
    practiceQuestion: PracticeQuestion(
      question: 'In the number 752, what is the value of the digit 5?',
      correctAnswer: '50',
      hint: 'The 5 is in the middle column (the Tens column). Multiply 5 by 10.',
      explanation:
          'Because 5 sits in the Tens position, it represents 5 groups of ten, which equals 50.',
      options: ['50', '5', '500', '52'],
      stepByStepGuidance:
          'Rightmost is Units (2). Second from right is Tens (5 × 10 = 50).',
      wrongOptionExplanations: {
        '5': '5 is just the face digit. Its position in the tens column makes it worth 50.',
        '500': '500 would mean 5 is in the hundreds column. Here, 7 is in hundreds.',
        '52': '52 includes both the 5 and the 2. The 5 alone is worth 50.',
      },
    ),
    icon: Icons.tag_rounded,
  ),

  // Lesson 2
  const Lesson(
    id: 'stage1_lesson2_addition_subtraction',
    title: '2. Addition, Subtraction & Comparing Numbers',
    category: 'Foundations',
    stage: 'Stage 1 – Absolute Beginner',
    stageIndex: 1,
    difficulty: 'Beginner',
    conceptSummary:
        'Addition (+) combines amounts together. Subtraction (-) takes an amount away. Comparing uses greater than (>), less than (<), and equal (=).',
    formula: 'Combine (+) | Take Away (-) | Bigger > Smaller',
    whatItIs:
        'Addition puts groups together into a total sum. Subtraction removes an amount to find what is left or the difference between two numbers.',
    whyItWorks:
        'Addition and subtraction are inverse operations. If 15 + 7 = 22, then subtracting 7 returns you back to 15 (22 - 7 = 15).',
    howToSolveIt:
        'To add or subtract easily, split numbers into tens and units. For 14 + 8: add 6 to reach 20, then add the remaining 2 to get 22.',
    whenToUseIt:
        'Use addition to find total cost; use subtraction to calculate change at the store.',
    stepByStepExplanation:
        'Step 1: Start with 15 coins.\nStep 2: You spend 7 coins, meaning you subtract 7.\nStep 3: Subtract 5 to reach 10, then subtract 2 more: 10 - 2 = 8.\nStep 4: You have 8 coins left over.',
    workedExample:
        'Example: Compare 25 and 18.\n25 has 2 tens; 18 has only 1 ten. 25 is bigger, so we write 25 > 18.',
    takeaway: 'The open mouth of the > symbol always eats the bigger number.',
    commonMistakes: [
      'Borrowing errors in subtraction when the top unit is smaller than the bottom unit.',
      'Mixing up > and < symbols.',
    ],
    shortcutsAndTricks: [
      'Bridge to 10: to add 9, add 10 and subtract 1 (e.g., 27 + 9 = 27 + 10 - 1 = 36).',
    ],
    alternativeMethods: [
      'Use a number line: jump forward for addition, jump backward for subtraction.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [4, 5, 6],
    practiceQuestion: PracticeQuestion(
      question: 'If you have 15 coins and spend 7 coins, how many coins do you have left?',
      correctAnswer: '8',
      hint: 'Subtract 7 from 15: 15 - 7 = ?',
      explanation:
          'Starting with 15 and removing 7 leaves 8 coins (because 8 + 7 = 15).',
      options: ['8', '7', '9', '22'],
      stepByStepGuidance: '15 - 5 = 10, then 10 - 2 = 8.',
      wrongOptionExplanations: {
        '7': '7 is the amount spent, not the amount remaining.',
        '9': 'Off by 1. 15 - 7 = 8, while 16 - 7 = 9.',
        '22': 'You added 15 + 7 instead of subtracting the spent coins.',
      },
    ),
    icon: Icons.add_circle_outline_rounded,
  ),

  // Lesson 3
  const Lesson(
    id: 'stage1_lesson3_multiplication_tables',
    title: '3. Multiplication & Times Tables',
    category: 'Foundations',
    stage: 'Stage 1 – Absolute Beginner',
    stageIndex: 1,
    difficulty: 'Beginner',
    conceptSummary:
        'Multiplication (×) is fast repeated addition. 4 × 3 means adding 3 four times: 3 + 3 + 3 + 3 = 12.',
    formula: 'a × b = b × a (Order does not change the product)',
    whatItIs:
        'Instead of adding the same number over and over, multiplication groups identical amounts together to find the total immediately.',
    whyItWorks:
        'Arranging 3 rows of 4 chairs gives 12 chairs. Turning the room gives 4 rows of 3 chairs (still 12). 3 × 4 is always equal to 4 × 3.',
    howToSolveIt:
        'Break hard multiplication into easier pieces you know. For 6 × 7: think (6 × 5) + (6 × 2) = 30 + 12 = 42.',
    whenToUseIt:
        'Use multiplication whenever items are grouped into equal packs, boxes, rows, or hourly rates.',
    stepByStepExplanation:
        'Step 1: A bakery packs cookies into boxes of 6.\nStep 2: A customer orders 7 boxes.\nStep 3: This is 7 groups of 6, or 7 × 6.\nStep 4: 7 × 5 = 35. Add one more 7 to reach 42 cookies.',
    workedExample:
        'Example: What is 8 × 4?\nDouble 8 twice: 8 × 2 = 16, and 16 × 2 = 32.',
    takeaway: 'Multiplying by 4 is just doubling a number twice.',
    commonMistakes: [
      'Multiplying by 0 and getting the number back (anything × 0 is always 0).',
      'Confusing multiplication with addition (3 × 3 = 9, not 6).',
    ],
    shortcutsAndTricks: [
      'Times 9 trick: the tens digit is 1 less than the number, and both digits always add to 9 (e.g., 9 × 4 = 36; 3 + 6 = 9).',
    ],
    alternativeMethods: [
      'Draw a grid or array: count the squares in a 6 by 7 rectangle.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [7, 8, 9],
    practiceQuestion: PracticeQuestion(
      question: 'A bakery packs cookies into boxes of 6. How many cookies are in 7 boxes?',
      correctAnswer: '42',
      hint: 'Multiply the number of boxes (7) by cookies per box (6). 7 × 6 = ?',
      explanation: '7 boxes containing 6 cookies each give 7 × 6 = 42 cookies in total.',
      options: ['42', '36', '48', '13'],
      stepByStepGuidance: '7 × 6 = (7 × 5) + (7 × 1) = 35 + 7 = 42.',
      wrongOptionExplanations: {
        '36': '36 is 6 × 6 (only 6 boxes). You have 7 boxes.',
        '48': '48 is 8 × 6 (8 boxes).',
        '13': 'You added 6 + 7 instead of multiplying the groups.',
      },
    ),
    icon: Icons.close_rounded,
  ),

  // Lesson 4
  const Lesson(
    id: 'stage1_lesson4_division_remainders',
    title: '4. Division, Equal Sharing & Remainders',
    category: 'Foundations',
    stage: 'Stage 1 – Absolute Beginner',
    stageIndex: 1,
    difficulty: 'Beginner',
    conceptSummary:
        'Division (÷) splits an amount into equal groups. If an amount cannot be split completely evenly, the leftover is the remainder.',
    formula: 'Total = (Groups × Size) + Remainder',
    whatItIs:
        'Division tells you either how many items go into each group or how many equal groups you can make from a total.',
    whyItWorks:
        'Division is the reverse of multiplication. If 4 × 5 = 20, then dividing 20 by 4 gives 5.',
    howToSolveIt:
        'Ask yourself: what number multiplied by the divisor gets as close as possible to the total without going over? The difference is your remainder.',
    whenToUseIt:
        'Use division to split dinner bills fairly, pack items into containers, or distribute cards to players.',
    stepByStepExplanation:
        'Step 1: You have 27 pencils to divide equally among 4 students.\nStep 2: Check 4-times table: 4 × 6 = 24 (close), 4 × 7 = 28 (too big!).\nStep 3: Each student receives 6 pencils.\nStep 4: Subtract 24 from 27: 27 - 24 = 3 pencils remaining.',
    workedExample:
        'Example: 19 ÷ 3 = ?\n3 × 6 = 18. 19 - 18 = 1. So 19 ÷ 3 = 6 with a remainder of 1.',
    takeaway: 'The remainder must always be strictly smaller than the divisor.',
    commonMistakes: [
      'Dividing by zero (impossible in mathematics).',
      'Leaving a remainder that is larger than or equal to the divisor.',
    ],
    shortcutsAndTricks: [
      'To test if a number divides evenly by 2, check if the last digit is even (0, 2, 4, 6, 8).',
    ],
    alternativeMethods: [
      'Repeated subtraction: keep taking away 4 from 27 until less than 4 remains.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [10, 11, 12],
    practiceQuestion: PracticeQuestion(
      question: 'Divide 27 pencils equally among 4 students. How many pencils are left over (the remainder)?',
      correctAnswer: '3',
      hint: 'Find the largest multiple of 4 less than 27. 4 × 6 = 24. How many are left?',
      explanation: '4 × 6 = 24 pencils shared. 27 - 24 = 3 pencils left over.',
      options: ['3', '6', '4', '1'],
      stepByStepGuidance: '27 ÷ 4 = 6 groups of 4, with 3 left over.',
      wrongOptionExplanations: {
        '6': '6 is how many pencils each student receives, not the leftover remainder.',
        '4': 'A remainder can never equal the divisor 4.',
        '1': 'Check your subtraction: 27 - 24 = 3, not 1.',
      },
    ),
    icon: Icons.safety_divider_rounded,
  ),

  // Lesson 5
  const Lesson(
    id: 'stage1_lesson5_odd_even_negatives',
    title: '5. Even, Odd & Negative Numbers',
    category: 'Foundations',
    stage: 'Stage 1 – Absolute Beginner',
    stageIndex: 1,
    difficulty: 'Beginner',
    conceptSummary:
        'Even numbers end in 0, 2, 4, 6, 8 and pair up with no remainder. Odd numbers end in 1, 3, 5, 7, 9. Negative numbers are values below zero.',
    formula: 'Even + Even = Even | Odd + Odd = Even | Odd + Even = Odd',
    whatItIs:
        'Numbers have patterns: parity (even vs odd) tells if items pair up evenly. Negative numbers represent values to the left of zero on the number line.',
    whyItWorks:
        'Two odd numbers each have 1 leftover piece. When added together, the two leftovers pair up to make an even sum.',
    howToSolveIt:
        'To tell if any giant number is even or odd, look ONLY at the very last digit. If the last digit is 0, 2, 4, 6, 8 it is even.',
    whenToUseIt:
        'Use even/odd to quickly verify calculation sanity; use negative numbers for debts, elevator basements, and sub-zero temperatures.',
    stepByStepExplanation:
        'Step 1: Check number 48. Its last digit is 8.\nStep 2: 8 divides evenly into 2 equal teams of 4.\nStep 3: Therefore, 48 is an even number.\nStep 4: Numbers ending in 7, 5, 9 have 1 left out, making them odd.',
    workedExample:
        'Example: Is 53 odd or even?\nLast digit is 3. 3 ÷ 2 = 1 with remainder 1. 53 is odd.',
    takeaway: 'Look only at the final digit to know instantly if any number is even or odd.',
    commonMistakes: [
      'Looking at the first digit instead of the last digit.',
      'Thinking 0 is odd (0 is an even number).',
    ],
    shortcutsAndTricks: [
      'Adding two odd numbers ALWAYS yields an even number: 3 + 5 = 8; 7 + 9 = 16.',
    ],
    alternativeMethods: [
      'Pair up dots: if every dot has a partner, it is even. If one dot is alone, it is odd.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [13, 14, 15],
    practiceQuestion: PracticeQuestion(
      question: 'Which of the following numbers is an EVEN number?',
      correctAnswer: '48',
      hint: 'Look at the last digit of each choice. Even numbers end in 0, 2, 4, 6, or 8.',
      explanation: '48 ends in 8, so it divides evenly by 2 without remainder. 37, 55, and 19 all end in odd digits.',
      options: ['48', '37', '55', '19'],
      stepByStepGuidance: 'Check the units digit: 8 is even, so 48 is even.',
      wrongOptionExplanations: {
        '37': 'Ends in 7, which is an odd digit.',
        '55': 'Ends in 5, which is an odd digit.',
        '19': 'Ends in 9, which is an odd digit.',
      },
    ),
    icon: Icons.compare_arrows_rounded,
  ),

  // Lesson 6
  const Lesson(
    id: 'stage1_lesson6_fractions_decimals_percents',
    title: '6. Basic Fractions, Decimals & Percentages',
    category: 'Foundations',
    stage: 'Stage 1 – Absolute Beginner',
    stageIndex: 1,
    difficulty: 'Beginner',
    conceptSummary:
        'Fractions, decimals, and percentages are three ways to describe part of a whole. Half is 1/2 = 0.5 = 50%.',
    formula: '1/4 = 25% | 1/2 = 50% | 3/4 = 75% | 1 = 100%',
    whatItIs:
        'When a whole object is cut into equal pieces, a fraction tells you how many pieces you have out of the total. Percent means "parts per 100".',
    whyItWorks:
        'In fraction a/b, the bottom number (denominator) tells how many equal pieces the whole was cut into. The top number (numerator) tells how many pieces you hold.',
    howToSolveIt:
        'To find 25% of any number, remember that 25% is one-quarter (1/4). Divide the number by 4.',
    whenToUseIt:
        'Use percentages when calculating store discounts, battery levels, phone charge, and exam grades.',
    stepByStepExplanation:
        'Step 1: We want to find 25% of 80.\nStep 2: 25% means 25 out of 100, which simplifies to the fraction 1/4.\nStep 3: Finding 1/4 of 80 means dividing 80 by 4.\nStep 4: 80 ÷ 4 = 20.\nConclusion: 25% of 80 is 20.',
    workedExample:
        'Example: What is 50% of 60?\n50% is half (1/2). Half of 60 is 60 ÷ 2 = 30.',
    takeaway: '50% means divide by 2; 25% means divide by 4; 10% means divide by 10.',
    commonMistakes: [
      'Thinking a bigger denominator means a bigger slice (1/8 is much smaller than 1/2!).',
      'Confusing 25% with dividing by 25 instead of dividing by 4.',
    ],
    shortcutsAndTricks: [
      'To find 10% of any number ending in zero, just drop the last zero: 10% of 70 is 7.',
    ],
    alternativeMethods: [
      'Pizza diagram: cut a pizza into 4 slices. 1 slice is 25%.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [16, 17, 18],
    practiceQuestion: PracticeQuestion(
      question: 'What is 25% of 80?',
      correctAnswer: '20',
      hint: '25% is one-quarter (1/4). Divide 80 by 4.',
      explanation: '25% = 1/4. 80 divided by 4 equals 20.',
      options: ['20', '40', '25', '15'],
      stepByStepGuidance: '80 ÷ 4 = 20.',
      wrongOptionExplanations: {
        '40': '40 is 50% (half) of 80, not 25%.',
        '25': '25 is the percentage rate, not the calculated value.',
        '15': 'Check your division: 80 ÷ 4 = 20, not 15.',
      },
    ),
    icon: Icons.pie_chart_outline_rounded,
  ),
];

