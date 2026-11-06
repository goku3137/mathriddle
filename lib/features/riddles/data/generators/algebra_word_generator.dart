import '../../../../models/level_model.dart';

/// Procedural generators for algebra and word riddles:
/// - Category 4: Equation Riddles
/// - Category 7: Money & Shopping Riddles
/// - Category 8: Logic Number Riddles
/// - Category 11: Age Riddles
class AlgebraWordGenerator {
  const AlgebraWordGenerator._();

  // --- Category 4: Equation Riddles ---
  static LevelData generateEquation(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k % 4) + 2; final b = (k * 2 % 7) + 3; final x = (k * 3 % 8) + 2; final c = a * x + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '${a}x + $b = $c\nx = ?',
        correctAnswer: '$x',
        hint: 'Subtract $b from $c, then divide by $a.',
        solution: '${a}x + $b = $c\n${a}x = ${c - b}\nx = $x.',
      );
    } else if (tier <= 1) {
      final apple = (k * 2 % 9) + 4; final banana = (k % 5) + 2; final s1 = apple + banana; final s2 = 2 * apple + banana;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A + B = $s1\n2A + B = $s2\nA = ?',
        correctAnswer: '$apple',
        hint: 'Subtract the first equation from the second to find A directly.',
        solution: '(2A + B) - (A + B) = A\nA = $s2 - $s1\nA = $apple.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 7) + 3; final b = (k % 5) + 4; final c = (k % 4) + 2; final ab = a + b; final bc = b + c; final ac = a + c; final total = a + b + c;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A + B = $ab\nB + C = $bc\nA + C = $ac\nA + B + C = ?',
        correctAnswer: '$total',
        hint: 'Sum all three equations: 2(A + B + C) = ${ab + bc + ac}. Then divide by 2.',
        solution: '2(A + B + C) = ${ab + bc + ac}\nA + B + C = ${ab + bc + ac} ÷ 2\nA + B + C = $total.',
      );
    } else if (tier <= 3) {
      final step = k - 10;
      final sumCoeff = (step % 3) + 2;
      final b = (step % 4) + 1;
      final r = b + sumCoeff;
      final c = r * sumCoeff;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'x² - ${b}x = $c\nPositive x = ?',
        correctAnswer: '$r',
        hint: 'Factor as (x - $r)(x + $sumCoeff) = 0.',
        solution: 'x² - ${b}x = $c\n($r)² - ($b × $r) = $c\nx = $r.',
      );
    } else if (tier <= 4) {
      final x = (k * 2 % 7) + 3; final y = (k % 5) + 2; final eq1 = 2 * x + 3 * y; final eq2 = 3 * x + y; final ans = x * y;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '2x + 3y = $eq1\n3x + y = $eq2\nx × y = ?',
        correctAnswer: '$ans',
        hint: 'From second equation y = $eq2 - 3x. Substitute into the first equation.',
        solution: 'x = $x\ny = $y\nx × y = $x × $y = $ans.',
      );
    } else if (tier <= 5) {
      final x = (k % 4) + 2; final y = (k * 2 % 5) + 3; final z = (k % 3) + 4; final s = x + y + z; final eq2 = 2 * x - y; final eq3 = 3 * z; final ans = (x * x) + (y * y);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'x + y + z = $s\n2x - y = $eq2\n3z = $eq3\nx² + y² = ?',
        correctAnswer: '$ans',
        hint: 'Find z from 3z = $eq3, then solve the remaining 2 variables.',
        solution: '3z = $eq3\nz = $z\nx + y = ${s - z}\nx = $x\ny = $y\nx² + y² = $ans.',
      );
    } else {
      final step = k - 28;
      final x = (step % 5) + 2; // 2..6 (strictly < 7)
      final y = (step % 4) + 1; // 1..4 (strictly < 5)
      const a = 5;
      const b = 7;
      final c = a * x + b * y;
      final ans = x + y;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '5x + 7y = $c\nPositive x, y\nx + y = ?',
        correctAnswer: '$ans',
        hint: 'Test multiples of 7 subtracted from $c that leave a multiple of 5.',
        solution: '5x + 7y = $c\nx = $x\ny = $y\nx + y = $x + $y = $ans.',
      );
    }
  }

  // --- Category 7: Money & Shopping Riddles ---
  static LevelData generateMoney(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final unitPrice = (k * 2 % 7) + 3; final count = (k % 4) + 4; final cost = unitPrice * count; final targetCount = count + 2; final ans = unitPrice * targetCount;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If $count pens cost \$$cost, what is the cost of $targetCount pens in dollars?',
        correctAnswer: '$ans',
        hint: 'Find the cost of 1 pen first: \$$cost ÷ $count.',
        solution: '1 pen = \$$cost ÷ $count = \$$unitPrice. $targetCount pens = $targetCount × \$$unitPrice = \$$ans.',
      );
    } else if (tier <= 1) {
      final basePrice = ((k * 3 % 7) + 4) * 20; const discountPercent = 25; final ans = basePrice * 75 ~/ 100;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A jacket originally priced at \$$basePrice is on sale for $discountPercent% off. What is the final price in dollars?',
        correctAnswer: '$ans',
        hint: '25% off means paying 75% of the original price.',
        solution: 'Discount = \$$basePrice × 0.25 = \$${basePrice ~/ 4}. Price = \$$basePrice - \$${basePrice ~/ 4} = \$$ans.',
      );
    } else if (tier <= 2) {
      final coffee = (k * 2 % 7) + 3; final donut = (k % 4) + 2; final c1 = coffee + donut; final c2 = 2 * coffee + donut;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'One coffee and one donut cost \$$c1. Two coffees and one donut cost \$$c2. What is the cost of one coffee in dollars?',
        correctAnswer: '$coffee',
        hint: 'The extra coffee accounts for the price difference.',
        solution: 'Coffee = \$$c2 - \$$c1 = \$$coffee.',
      );
    } else if (tier <= 3) {
      final dimes = (k * 2 % 7) + 5; final nickels = (k % 4) + 3; final totalCoins = dimes + nickels; final totalCents = (dimes * 10) + (nickels * 5);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A collection of $totalCoins coins (dimes and nickels) totals $totalCents¢. How many dimes are there?',
        correctAnswer: '$dimes',
        hint: 'If all were nickels, they would make ${totalCoins * 5}¢. Extra cents come from dimes (+5¢ each).',
        solution: 'Extra = $totalCents - ${totalCoins * 5} = ${totalCents - totalCoins * 5}¢. Dimes = ${totalCents - totalCoins * 5} ÷ 5 = $dimes.',
      );
    } else if (tier <= 4) {
      final cost = ((k * 3 % 7) + 4) * 25; const profit = 20; final sellPrice = cost + (cost * profit ~/ 100);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'An item was sold for \$$sellPrice at a profit of $profit%. What was the original cost price in dollars?',
        correctAnswer: '$cost',
        hint: 'Selling price is 120% of the cost price. Divide by 1.2.',
        solution: 'Cost = \$$sellPrice ÷ 1.20 = \$$cost.',
      );
    } else if (tier <= 5) {
      final original = ((k * 3 % 7) + 5) * 40; final after20 = original * 80 ~/ 100; final finalPrice = after20 * 90 ~/ 100;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'An item priced at \$$original has a 20% discount, followed by an additional 10% off. What is the final price in dollars?',
        correctAnswer: '$finalPrice',
        hint: 'Successive discounts: multiply by 0.80, then by 0.90.',
        solution: '\$$original × 0.80 = \$$after20. Then \$$after20 × 0.90 = \$$finalPrice.',
      );
    } else {
      final step = k - 28;
      final items = 11 + step * 4;
      final unit = 10 + (step % 3) * 5;
      final free = items ~/ 4;
      final paid = items - free;
      final ans = paid * unit;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A store offers "Buy 3 get 1 free" at \$$unit each. What is the minimum cost for $items items in dollars?',
        correctAnswer: '$ans',
        hint: 'Every 4 items gives 1 free ($free free items). Pay for only $paid items.',
        solution: '$items items = $free free + $paid paid. $paid × \$$unit = \$$ans.',
      );
    }
  }

  // --- Category 8: Logic Number Riddles ---
  static LevelData generateLogic(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final tens = (k % 4) + 2; final ones = ((k * 2 % 4) + 1) * 2; final num = tens * 10 + ones; final sum = tens + ones; final lower = tens * 10; final upper = lower + 10;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'What is the even number between $lower and $upper whose digits sum to $sum?',
        correctAnswer: '$num',
        hint: 'Tens digit is $tens. Ones digit must be even and add up to $sum.',
        solution: '$tens + $ones = $sum. The number is $num.',
      );
    } else if (tier <= 1) {
      final t = (k % 4) + 1; final o = 2 * t; final num = t * 10 + o; final sum = t + o;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A 2-digit number (digits sum to $sum) is 4 times its digit sum. What is the number?',
        correctAnswer: '$num',
        hint: 'Multiply the digit sum $sum by 4.',
        solution: '4 × $sum = $num (digits: $t + $o = $sum).',
      );
    } else if (tier <= 2) {
      final pools = [
        {'n': '3, 4, 6', 'a': '12'},
        {'n': '4, 5, 6', 'a': '60'},
        {'n': '3, 5, 6', 'a': '30'},
        {'n': '6, 8, 12', 'a': '24'},
        {'n': '4, 6, 8', 'a': '24'},
        {'n': '5, 6, 10', 'a': '30'},
      ];
      final item = pools[k % pools.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'What is the smallest positive number divisible by each of ${item['n']}?',
        correctAnswer: item['a']!,
        hint: 'Find the Least Common Multiple (LCM) of the numbers.',
        solution: 'LCM of ${item['n']} is ${item['a']}.',
      );
    } else if (tier <= 3) {
      final outer = (k % 5) + 2; final inner = (k * 2 % 7) + 1; final num = outer * 100 + inner * 10 + outer; final sum = outer + inner + outer; final prod = outer * inner * outer;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'What is the 3-digit palindrome whose digits sum to $sum and multiply to $prod?',
        correctAnswer: '$num',
        hint: 'Outer digits are identical. Test factors of $prod.',
        solution: 'Digits are $outer, $inner, $outer: sum = $sum, product = $prod. Number is $num.',
      );
    } else if (tier <= 4) {
      final subIndex = k - 14;
      switch (subIndex) {
        case 0:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What 2-digit number has a square (625) that ends in the number itself?',
            correctAnswer: '25',
            hint: 'Think of a 2-digit multiple of 5.',
            solution: '25² = 625, which ends in 25.',
          );
        case 1:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What 2-digit number has a square (5776) that ends in the number itself?',
            correctAnswer: '76',
            hint: 'A 2-digit number ending in 6.',
            solution: '76² = 5776, which ends in 76.',
          );
        case 2:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What 3-digit number has a square (141376) that ends in the 3-digit number itself?',
            correctAnswer: '376',
            hint: 'Think of a 3-digit number ending in 76.',
            solution: '376² = 141376, which ends in 376.',
          );
        case 3:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What 3-digit number has a square (390625) that ends in the 3-digit number itself?',
            correctAnswer: '625',
            hint: 'Think of a 3-digit power of 5 ending in 25.',
            solution: '625² = 390625, which ends in 625.',
          );
        case 4:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'I am a 2-digit multiple of 9 less than 30. When squared, my digits sum to 9. What number am I?',
            correctAnswer: '18',
            hint: 'The multiples of 9 less than 30 are 18 and 27. Check 18².',
            solution: '18² = 324. Digit sum of 324 is 3 + 2 + 4 = 9. The number is 18.',
          );
        case 5:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'I am a 2-digit number. When squared, my value is 729. What number am I?',
            correctAnswer: '27',
            hint: 'Take the square root of 729.',
            solution: '√729 = 27. The number is 27.',
          );
        default:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'I am the only 2-digit positive integer that is both a perfect square and a perfect cube. What number am I?',
            correctAnswer: '64',
            hint: '64 = 8² and 64 = 4³.',
            solution: '8² = 64 and 4³ = 64. The number is 64.',
          );
      }
    } else if (tier <= 5) {
      final offset = (k - 21).clamp(0, 6);
      final c1 = 3 + offset;
      final c2 = 8;
      final c3 = 4;
      final ans = '$c1$c2$c3';
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Crack the 3-digit lock: ${c1}91 (one digit correct & placed), 2${c2}5 (one digit correct & placed), 7$c3$c2 (two digits correct but misplaced). What is the code?',
        correctAnswer: ans,
        hint: 'Deduce position 1 ($c1), position 2 ($c2), position 3 ($c3).',
        solution: 'Digit 1 is $c1, Digit 2 is $c2, Digit 3 is $c3. Code is $ans.',
      );
    } else {
      final pairs = [
        {'q': 'What 2-digit prime reversed is 97?', 'a': '79'},
        {'q': 'What 2-digit prime reversed is 79?', 'a': '97'},
        {'q': 'What 2-digit prime reversed is equal to 4 × 19 - 5 (71)?', 'a': '17'},
        {'q': 'What 2-digit prime has digits summing to 10 and reverses to 73?', 'a': '37'},
        {'q': 'What 2-digit prime reversed is 31?', 'a': '13'},
        {'q': 'What 2-digit prime reversed is 13?', 'a': '31'},
        {'q': 'What 2-digit prime has digits summing to 10 and reverses to 37?', 'a': '73'},
        {'q': 'What 2-digit prime reversed is 17?', 'a': '71'},
      ];
      final item = pairs[(k - 28) % pairs.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: item['q']!,
        correctAnswer: item['a']!,
        hint: 'Reverse the target number to find the answer.',
        solution: 'The prime is ${item['a']}.',
      );
    }
  }

  // --- Category 11: Age Riddles ---
  static LevelData generateAge(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final b = (k * 2 % 7) + 8; final diff = (k % 5) + 4; final a = b + diff; final sum = a + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Sam is $diff years older than Leo. The sum of their ages is $sum. How old is Sam?',
        correctAnswer: '$a',
        hint: 'Subtract difference from sum, divide by 2 for Leo, then add $diff.',
        solution: 'Leo = ($sum - $diff) ÷ 2 = $b. Sam = $b + $diff = $a.',
      );
    } else if (tier <= 1) {
      final son = (k * 2 % 7) + 10; final father = 3 * son; final inYears = (k % 4) + 6; final fFuture = father + inYears;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A father is 3 times as old as his son. In $inYears years, the father will be $fFuture years old. How old is the son now?',
        correctAnswer: '$son',
        hint: 'Find Dad\'s current age first by subtracting $inYears from $fFuture.',
        solution: 'Dad now = $fFuture - $inYears = $father. Son now = $father ÷ 3 = $son.',
      );
    } else if (tier <= 2) {
      final d = (k % 5) + 6; final m = d + 24; final inYears = 24 - d;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A mother is $m years old and her daughter is $d years old. In how many years will the mother be twice as old as her daughter?',
        correctAnswer: '$inYears',
        hint: 'Set up equation: $m + x = 2($d + x).',
        solution: '$m + x = ${2 * d} + 2x\nx = $m - ${2 * d}\nx = $inYears.',
      );
    } else if (tier <= 3) {
      final c = (k % 4) + 4; final b = 2 * c; final a = 3 * b; final total = a + b + c;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Person A is 3 times as old as B, and B is twice as old as C. If their ages sum to $total, how old is A?',
        correctAnswer: '$a',
        hint: 'Express in terms of C: B = 2C, A = 6C. Total = 9C.',
        solution: '9C = $total\nC = $c\nA = 6 × $c\nA = $a.',
      );
    } else if (tier <= 4) {
      final mult = (k * 2 % 7) + 7; final sum = 7 * mult; final myAge = 4 * mult;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'I am twice as old as you were when I was your age. Our ages sum to $sum. How old am I?',
        correctAnswer: '$myAge',
        hint: 'Ratio of my age to your age is 4 : 3.',
        solution: 'My age = 4/7 of $sum = $myAge.',
      );
    } else if (tier <= 5) {
      final diff = (k % 4) + 3; final b = (k * 2 % 7) + 5; final a = b + diff; final prod = a * b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Two brothers differ in age by $diff years, and the product of their ages is $prod. How old is the older brother?',
        correctAnswer: '$a',
        hint: 'Find two factors of $prod that differ by $diff.',
        solution: '$a × $b = $prod and $a - $b = $diff. Older brother is $a.',
      );
    } else {
      final a = (k * 2 % 7) + 12; final b = (k % 5) + 8; final sumSquares = (a * a) + (b * b); final sum = a + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Two ages sum to $sum, and the sum of their squares is $sumSquares. What is the older age?',
        correctAnswer: '$a',
        hint: 'Use 2AB = (A+B)² - (A²+B²) to find their product, then find ages.',
        solution: '2AB = $sum² - $sumSquares\n2AB = ${sum * sum - sumSquares}\nAB = ${a * b}\nAges are $a and $b.',
      );
    }
  }
}
