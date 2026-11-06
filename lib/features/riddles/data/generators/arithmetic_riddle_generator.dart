import '../../../../models/level_model.dart';

/// Procedural generators for arithmetic riddles:
/// - Category 0: Formula Precedence
/// - Category 3: Missing Number Puzzles
/// - Category 10: Arithmetic Precedence & Lateral Operators
/// - Category 12: Mathematical Trick Riddles
class ArithmeticRiddleGenerator {
  const ArithmeticRiddleGenerator._();

  // --- Category 0: Formula Precedence ---
  static LevelData generateFormula(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k % 5) + 3;
      final b = (k % 4) + 2;
      final c = (k % 6) + 3;
      final d = (k % 4) + 1;
      final ans = a + (b * c) - d;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$a + $b × $c - $d = ?',
        correctAnswer: '$ans',
        hint: 'Perform multiplication ($b × $c) before addition and subtraction.',
        solution: '$b × $c = ${b * c}. Then $a + ${b * c} - $d = $ans.',
      );
    } else if (tier <= 1) {
      final a = (k % 6) + 2;
      final b = (k % 5) + 3;
      final c = (k % 4) + 2;
      final d = (k % 4) + 1;
      final ans = (a + b) * c - d;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '($a + $b) × $c - $d = ?',
        correctAnswer: '$ans',
        hint: 'Parentheses first: ($a + $b), then multiply by $c, then subtract $d.',
        solution: '($a + $b) = ${a + b}. ${a + b} × $c = ${(a + b) * c}. Then ${(a + b) * c} - $d = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k % 4) + 3;
      final b = (k % 3) + 2;
      final c = (k % 5) + 4;
      final d = (k % 3) + 2;
      final ans = (a * a) + b * (c - d);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$a² + $b × ($c - $d) = ?',
        correctAnswer: '$ans',
        hint: 'Evaluate exponent $a² and parentheses ($c - $d) first, then multiply by $b.',
        solution: '$a² = ${a * a}, ($c - $d) = ${c - d}. $b × ${c - d} = ${b * (c - d)}. ${a * a} + ${b * (c - d)} = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k % 3) + 3;
      final b = (k % 4) + 2;
      final c = (k % 3) + 2;
      final d = (k % 5) + 10;
      final ans = (a * a * a) - (b * c) + d;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$a³ - $b × $c + $d = ?',
        correctAnswer: '$ans',
        hint: 'Calculate cube $a³ first, then multiplication $b × $c.',
        solution: '$a³ = ${a * a * a}. $b × $c = ${b * c}. ${a * a * a} - ${b * c} + $d = $ans.',
      );
    } else if (tier <= 4) {
      final a = (k % 4) + 4;
      final b = (k % 3) + 2;
      const c = 2;
      final d = (k % 4) + 3;
      final e = (k % 5) + 2;
      final sumSq = a * a + b * b;
      final evenSumSq = (sumSq % 2 == 0) ? sumSq : sumSq + 1;
      final ans = ((evenSumSq) ~/ c) * d - e;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '[($evenSumSq) ÷ $c] × $d - $e = ?',
        correctAnswer: '$ans',
        hint: 'Divide the bracket by $c first, then multiply by $d and subtract $e.',
        solution: '$evenSumSq ÷ $c = ${evenSumSq ~/ c}. Multiplied by $d = ${(evenSumSq ~/ c) * d}. Minus $e = $ans.',
      );
    } else if (tier <= 5) {
      final a = (k % 3) + 3;
      final b = (k % 3) + 2;
      final diff = (a * a * a * a) - (b * b * b * b);
      final denom = (a * a) + (b * b);
      final c = (k % 5) + 6;
      final ans = (diff ~/ denom) + (c * c);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '($a⁴ - $b⁴) ÷ ($a² + $b²) + $c² = ?',
        correctAnswer: '$ans',
        hint: 'Factor the numerator: a⁴ - b⁴ = (a² - b²)(a² + b²).',
        solution: '($a⁴ - $b⁴) ÷ ($a² + $b²) = $a² - $b² = ${a * a - b * b}. Adding $c² (${c * c}) gives $ans.',
      );
    } else {
      final b = (k % 3) + 2;
      final a = b + (k % 3) + 2; // a strictly > b, so (a - b) >= 2, no div-by-zero
      final c = (k % 4) + 3;
      final d = (k % 5) + 5;
      final ans = ((a * a * a - b * b * b) ~/ (a - b)) - (a * b) + (c * d);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '[($a³ - $b³) ÷ ($a - $b) - ($a × $b)] + ($c × $d) = ?',
        correctAnswer: '$ans',
        hint: 'Algebraic identity: (a³ - b³) ÷ (a - b) = a² + ab + b². Subtracting ab leaves a² + b².',
        solution: '(a³ - b³) ÷ (a - b) - ab = a² + b² = ${a * a + b * b}. Adding $c × $d (${c * d}) yields $ans.',
      );
    }
  }

  // --- Category 3: Missing Number Puzzles ---
  static LevelData generateMissing(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k * 3 % 13) + 4; final b = (k * 2 % 11) + 7; final sum = a + b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$a + ? = $sum',
        correctAnswer: '$b',
        hint: 'Subtract $a from $sum.',
        solution: '$sum - $a = $b.',
      );
    } else if (tier <= 1) {
      final m = (k % 4) + 3; final add = (k * 2 % 9) + 4; final x = (k * 3 % 7) + 3; final total = m * x + add;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '(? × $m) + $add = $total',
        correctAnswer: '$x',
        hint: 'Subtract $add first, then divide by $m.',
        solution: '$total - $add = ${total - add}. Then ${total - add} ÷ $m = $x.',
      );
    } else if (tier <= 2) {
      final x = (k * 2 % 7) + 5; final y = (k % 4) + 2; final sum = x + y; final diff = x - y; final ans = x * y;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A + B = $sum\nA - B = $diff\nA × B = ?',
        correctAnswer: '$ans',
        hint: 'Add equations to find 2A = ${sum + diff}. Then find B and calculate A × B.',
        solution: '2A = ${sum + diff}\nA = $x\nB = $y\nA × B = $x × $y = $ans.',
      );
    } else if (tier <= 3) {
      final target = (k * 2 % 13) + 6; final r1 = (k % 5) + 3; final r2 = (k % 4) + 5; final c1 = (k % 3) + 2; final c2 = (k % 4) + 4;
      final rowSum = r1 + target + r2; final colSum = c1 + target + c2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'Row: $r1 + ? + $r2 = $rowSum\nColumn: $c1 + ? + $c2 = $colSum\n? = ?',
        correctAnswer: '$target',
        hint: 'Solve either row or column equation for the missing common value.',
        solution: 'From row: ? = $rowSum - ($r1 + $r2) = $target. Verified in col: $c1 + $target + $c2 = $colSum.',
      );
    } else if (tier <= 4) {
      final target = (k * 2 % 9) + 4; final a = (k % 3) + 2; final b = (k % 3) + 3; final rowProd = a * target * b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$a × ? × $b = $rowProd\n? = ?',
        correctAnswer: '$target',
        hint: 'Divide $rowProd by the product of $a and $b (${a * b}).',
        solution: '$a × $b = ${a * b}. $rowProd ÷ ${a * b} = $target.',
      );
    } else if (tier <= 5) {
      final x = (k * 2 % 7) + 3; final y = (k % 5) + 2; final eq1 = x + 2 * y; final eq2 = 2 * x + y; final ans = (x * x) + (y * y);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'x + 2y = $eq1, 2x + y = $eq2. x² + y² = ?',
        correctAnswer: '$ans',
        hint: 'Multiply the first equation by 2 and subtract the second to isolate y.',
        solution: 'Solving gives x = $x, y = $y. x² + y² = $x² + $y² = ${x * x} + ${y * y} = $ans.',
      );
    } else {
      final a = (k * 2 % 7) + 3; final b = (k % 4) + 2; final c = (k % 5) + 4; final sum = a + b + c; final p1 = a * b; final p2 = b * c; final ans = a * b * c;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A + B + C = $sum, A × B = $p1, B × C = $p2. A × B × C = ?',
        correctAnswer: '$ans',
        hint: 'Find B by factoring common elements of $p1 and $p2.',
        solution: 'Common factor B = $b gives A = $a and C = $c. A+B+C = $sum. A×B×C = $ans.',
      );
    }
  }

  // --- Category 10: Arithmetic Precedence & Lateral Operators ---
  static LevelData generateOperator(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = (k * 2 % 9) + 3; final b = (k % 5) + 2; final ans = a + 2 * b;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a ★ b = a + 2b, then $a ★ $b = ?',
        correctAnswer: '$ans',
        hint: 'Double the second number and add the first number.',
        solution: '$a + (2 × $b) = $a + ${2 * b} = $ans.',
      );
    } else if (tier <= 1) {
      final a = (k * 2 % 7) + 3; final b = (k % 4) + 2; final ans = (a * b) + (a + b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a ⊕ b = (a × b) + (a + b), then $a ⊕ $b = ?',
        correctAnswer: '$ans',
        hint: 'Multiply the numbers, add the numbers, then sum both results.',
        solution: '($a × $b) + ($a + $b) = ${a * b} + ${a + b} = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 7) + 5; final b = (k % 4) + 2; final ans = (a * a) - (b * b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a # b = a² - b², then $a # $b = ?',
        correctAnswer: '$ans',
        hint: 'Calculate $a² and subtract $b².',
        solution: '$a² - $b² = ${a * a} - ${b * b} = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k % 3) + 2; final b = (k % 2) + 3; final c = (k % 3) + 2; final step1 = (a * b) + 1; final ans = (step1 * c) + 1;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If x ★ y = x·y + 1, then ($a ★ $b) ★ $c = ?',
        correctAnswer: '$ans',
        hint: 'Evaluate ($a ★ $b) inside parentheses first, then apply ★ with $c.',
        solution: '($a ★ $b) = ($a × $b) + 1 = $step1. Then $step1 ★ $c = ($step1 × $c) + 1 = $ans.',
      );
    } else if (tier <= 4) {
      final a = (k * 2 % 9) + 4; final b = (k % 5) + 3; const m = 10; final ans = ((a * b) % m) + (a + b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a ⊗ b = (a·b mod 10) + (a+b), then $a ⊗ $b = ?',
        correctAnswer: '$ans',
        hint: 'a·b mod 10 gives the last digit of the product. Add (a + b).',
        solution: '($a × $b = ${a * b}) mod 10 = ${(a * b) % m}. Adding ($a + $b = ${a + b}) yields $ans.',
      );
    } else if (tier <= 5) {
      final step = k - 21;
      final a = step + 3;
      final targetX = (step * 2 % 5) + 4;
      final res = (a * targetX) + a;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a ⊕ b = a·b + a\n$a ⊕ x = $res\nx = ?',
        correctAnswer: '$targetX',
        hint: 'Substitute into formula: $a·x + $a = $res.',
        solution: '$a·x + $a = $res\n$a·x = ${res - a}\nx = $targetX.',
      );
    } else {
      final a = (k * 2 % 5) + 2; final b = (k % 4) + 3; final ans = (a * a + b) * (b * b - a);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'If a ⨀ b = (a² + b) × (b² - a), then $a ⨀ $b = ?',
        correctAnswer: '$ans',
        hint: 'Compute left term (a² + b) and right term (b² - a), then multiply.',
        solution: '($a² + $b = ${a * a + b}) × ($b² - $a = ${b * b - a}) = ${a * a + b} × ${b * b - a} = $ans.',
      );
    }
  }

  // --- Category 12: Mathematical Trick Riddles ---
  static LevelData generateTrick(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final val = (k * 2 % 11) + 12; final ans = val + val;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$val + $val × 0 + $val = ?',
        correctAnswer: '$ans',
        hint: 'Multiplication first: $val × 0 = 0.',
        solution: '$val + 0 + $val = $ans.',
      );
    } else if (tier <= 1) {
      final n = (k * 2 % 7) + 5; final ans = (n * (n - 1)) ~/ 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: '$n people each shake hands with every other person exactly once. How many total handshakes occur?',
        correctAnswer: '$ans',
        hint: 'Handshake formula is n × (n - 1) ÷ 2.',
        solution: '$n × ${n - 1} ÷ 2 = ${n * (n - 1)} ÷ 2 = $ans.',
      );
    } else if (tier <= 2) {
      final depth = (k * 2 % 7) + 10; const up = 3; final ans = depth - up + 1;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A snail climbs 3m by day and slips back 2m by night in a ${depth}m well. How many days will it take to reach the top?',
        correctAnswer: '$ans',
        hint: 'On the final day, climbing 3m escapes before nightfall!',
        solution: 'After ${ans - 1} full days, reaches ${ans - 1}m. On day $ans, climbs 3m to $depth m and exits.',
      );
    } else if (tier <= 3) {
      final length = ((k * 2 % 7) + 4) * 5; const piece = 5; final cuts = (length ~/ piece) - 1;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'How many straight cuts are needed to divide a ${length}m rope into 5m pieces?',
        correctAnswer: '$cuts',
        hint: 'Number of cuts is always 1 less than the number of pieces.',
        solution: '$length ÷ 5 = ${length ~/ piece} pieces. Cuts = ${length ~/ piece} - 1 = $cuts.',
      );
    } else if (tier <= 4) {
      final pairs = [
        {'v1': 60, 'v2': 40, 'ans': 48},
        {'v1': 30, 'v2': 20, 'ans': 24},
        {'v1': 60, 'v2': 30, 'ans': 40},
        {'v1': 80, 'v2': 20, 'ans': 32},
        {'v1': 120, 'v2': 40, 'ans': 60},
        {'v1': 90, 'v2': 60, 'ans': 72},
        {'v1': 120, 'v2': 60, 'ans': 80},
      ];
      final p = pairs[(k - 14) % pairs.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'A car travels to a city at ${p['v1']} km/h and returns along the same route at ${p['v2']} km/h. What is the average speed for the round trip in km/h?',
        correctAnswer: '${p['ans']}',
        hint: 'Average speed is harmonic: 2·v1·v2 ÷ (v1 + v2), NOT arithmetic average!',
        solution: '(2 × ${p['v1']} × ${p['v2']}) ÷ (${p['v1']} + ${p['v2']}) = ${2 * p['v1']! * p['v2']!} ÷ ${p['v1']! + p['v2']!} = ${p['ans']}.',
      );
    } else if (tier <= 5) {
      final clockAngles = [
        {'time': '3:30', 'ans': 75},
        {'time': '2:20', 'ans': 50},
        {'time': '4:40', 'ans': 100},
        {'time': '1:20', 'ans': 80},
        {'time': '5:10', 'ans': 95},
        {'time': '8:20', 'ans': 130},
        {'time': '7:10', 'ans': 155},
      ];
      final c = clockAngles[(k - 21) % clockAngles.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'What is the smaller angle (in degrees) between the hour hand and minute hand of a clock at ${c['time']}?',
        correctAnswer: '${c['ans']}',
        hint: 'Formula: |30×H - 5.5×M| degrees.',
        solution: 'Angle between hands at ${c['time']} is ${c['ans']}°.',
      );
    } else {
      final subIndex = k - 28;
      switch (subIndex) {
        case 0:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What is the minimum number of balance scale weighings needed to find 1 counterfeit coin among 9 coins?',
            correctAnswer: '2',
            hint: 'Divide the coins into 3 piles of 3. 3² = 9.',
            solution: 'Each weighing divides candidates by 3: 3² = 9, so 2 weighings are needed.',
          );
        case 1:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What is the minimum number of balance scale weighings needed to find 1 counterfeit coin among 27 coins?',
            correctAnswer: '3',
            hint: 'Divide into 3 piles of 9. 3³ = 27.',
            solution: 'Each weighing divides candidates by 3: 3³ = 27, so 3 weighings are needed.',
          );
        case 2:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What is the minimum number of balance scale weighings needed to find 1 counterfeit coin among 81 coins?',
            correctAnswer: '4',
            hint: 'Divide into 3 piles of 27. 3⁴ = 81.',
            solution: 'Each weighing divides candidates by 3: 3⁴ = 81, so 4 weighings are needed.',
          );
        case 3:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'What is the minimum number of balance scale weighings needed to find 1 counterfeit coin among 243 coins?',
            correctAnswer: '5',
            hint: 'Divide into 3 piles of 81. 3⁵ = 243.',
            solution: 'Each weighing divides candidates by 3: 3⁵ = 243, so 5 weighings are needed.',
          );
        case 4:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'A water lily patch doubles in size every day. If it completely covers a pond on Day 48, on which day did it cover half the pond?',
            correctAnswer: '47',
            hint: 'Since it doubles every day, one day before full coverage it must be half full.',
            solution: 'Working backwards from Day 48, one day earlier (Day 47) it was half of the pond.',
          );
        case 5:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'A bat and a ball cost \$110 in total. The bat costs \$100 more than the ball. What is the cost of the ball in dollars?',
            correctAnswer: '5',
            hint: 'Let the ball cost \$x. Then the bat costs \$(x + 100). Sum = 2x + 100 = 110.',
            solution: '2x + 100 = 110\n2x = 10\nx = 5. The ball costs \$5.',
          );
        default:
          return LevelData(
            levelNumber: level,
            questionType: QuestionType.Formula,
            category: category,
            difficulty: difficulty,
            displayContent: 'If 5 cats can catch 5 mice in 5 minutes, how many minutes does it take 100 cats to catch 100 mice?',
            correctAnswer: '5',
            hint: 'Each cat takes 5 minutes to catch 1 mouse. With 100 cats working at once, 100 mice are caught in that same time.',
            solution: 'Rate per cat = 1 mouse per 5 minutes. 100 cats catch 100 mice simultaneously in 5 minutes.',
          );
      }
    }
  }
}
