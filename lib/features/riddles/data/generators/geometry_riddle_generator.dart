import '../../../../models/level_model.dart';

/// Procedural generators for geometry and equilibrium riddles:
/// - Category 1: Balance & Scale Riddles (levels <= 150) / Geometry: Triangles (levels > 150)
/// - Category 9: Proportion & Average Riddles (levels <= 150) / Geometry: Intersecting Circles (levels > 150)
class GeometryRiddleGenerator {
  const GeometryRiddleGenerator._();

  // --- Non-Geometry Replacement for catIndex 1 (Levels 1-150): Balance & Scale Riddles ---
  static LevelData generateBalanceRiddle(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      // Levels 30, 44 (Tier 0)
      final boxes = (k % 2) + 3; // 3 or 4
      final unitWeight = (k * 3 % 4) + 6; // 6..9
      final extra = (k % 3) + 5; // 5..7
      final total = boxes * unitWeight + extra;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'On a balance scale, $boxes identical boxes plus a $extra kg weight balance a $total kg weight. What is the weight of one box in kg?',
        correctAnswer: '$unitWeight',
        hint: 'Subtract the extra $extra kg from $total kg, then divide by $boxes boxes.',
        solution: '$total - $extra = ${total - extra} kg. ${total - extra} ÷ $boxes = $unitWeight kg.',
      );
    } else if (tier <= 1) {
      // Levels 58, 72, 86, 100 (Tier 1)
      final leftBoxes = (k % 3) + 2; // 2..4
      final diffBoxes = (k % 3) + 3; // 3..5
      final rightBoxes = leftBoxes + diffBoxes;
      final unitWeight = (k % 4) + 5; // 5..8
      final weightAdded = diffBoxes * unitWeight;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'On a balance scale, $leftBoxes blocks and a $weightAdded kg weight balance $rightBoxes identical blocks. What is the weight of one block in kg?',
        correctAnswer: '$unitWeight',
        hint: 'Remove $leftBoxes blocks from both sides: $diffBoxes blocks balance $weightAdded kg.',
        solution: '$rightBoxes - $leftBoxes = $diffBoxes blocks. $weightAdded ÷ $diffBoxes = $unitWeight kg.',
      );
    } else {
      // Levels 114, 128, 142 (Tier 2)
      final leftSpheres = (k % 3) + 5; // 5..7
      const rightSpheres = 2;
      final diffSpheres = leftSpheres - rightSpheres; // 3..5
      final unitWeight = (k % 4) + 12; // 12..15
      final leftWeight = (k % 5) + 10; // 10..14
      final rightWeight = leftWeight + diffSpheres * unitWeight;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'On a balance scale, $leftSpheres spheres plus a $leftWeight kg weight balance $rightSpheres spheres plus a $rightWeight kg weight. What is the weight of one sphere in kg?',
        correctAnswer: '$unitWeight',
        hint: 'Subtract $rightSpheres spheres and $leftWeight kg from both sides to isolate the remaining spheres.',
        solution: '$leftSpheres - $rightSpheres = $diffSpheres spheres. $rightWeight - $leftWeight = ${rightWeight - leftWeight} kg. ${rightWeight - leftWeight} ÷ $diffSpheres = $unitWeight kg.',
      );
    }
  }

  // --- Category 1 (Levels > 150): Geometry: Triangles ---
  static LevelData generateTriangle(int level, String category, String difficulty, int tier, int k) {
    final top = (k * 2 % 9) + 3; final left = (k % 7) + 2; final right = (k % 5) + 2;

    if (tier <= 0) {
      final ans = top + left + right;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $top, Left $left, Right $right → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$top', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$left', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$right', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Add all three outer vertices together to find the center.',
        solution: '$top + $left + $right = $ans.',
      );
    } else if (tier <= 1) {
      final ans = (top + right) * left;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $top, Left $left, Right $right → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$top', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$left', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$right', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Add Top and Right vertices, then multiply by Left vertex.',
        solution: '($top + $right) × $left = ${top + right} × $left = $ans.',
      );
    } else if (tier <= 2) {
      final t = ((k % 5) + 2) * 2; final r = ((k % 4) + 1) * 2; const l = 2; final ans = ((t * t) + r) ~/ l;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left $l, Right $r → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Square the top vertex, add the right vertex, then divide by the left.',
        solution: '($t² + $r) ÷ $l = (${t * t} + $r) ÷ $l = ${t * t + r} ÷ $l = $ans.',
      );
    } else if (tier <= 3) {
      final t = (k % 5) + 4; final l = (k % 4) + 3; final r = (k % 3) + 2; final ans = (t * t) + (l * l) - (r * r);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left $l, Right $r → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Sum the squares of Top and Left, then subtract the square of Right.',
        solution: '$t² + $l² - $r² = ${t * t} + ${l * l} - ${r * r} = $ans.',
      );
    } else if (tier <= 4) {
      final t = k - 11;
      final l = (k % 4) + 3;
      final r = (k % 3) + 2;
      final ans = (t * l) + (t * r) - (l * r);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left $l, Right $r → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Formula: (Top × Left) + (Top × Right) - (Left × Right).',
        solution: '($t × $l) + ($t × $r) - ($l × $r) = ${t * l} + ${t * r} - ${l * r} = $ans.',
      );
    } else if (tier <= 5) {
      final t = (k % 4) + 3; final l = (k % 3) + 2; const r = 2; final ans = ((t * t * t) - (l * l)) ~/ r;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left $l, Right $r → Center = ?',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '$l', relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true, relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$ans',
        hint: 'Cube Top, subtract Left squared, then divide by Right.',
        solution: '($t³ - $l²) ÷ $r = (${t * t * t} - ${l * l}) ÷ $r = ${t * t * t - l * l} ÷ $r = $ans.',
      );
    } else {
      final t = (k % 5) + 5; final r = (k % 4) + 3; final targetLeft = (k % 5) + 4; final center = (t * targetLeft) + r;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Triangle: Top $t, Left ?, Right $r → Center $center',
        nodes: [
          PuzzleNode(id: 'top', displayValue: '$t', relX: 0.5, relY: 0.16),
          PuzzleNode(id: 'left', displayValue: '?', isTarget: true, relX: 0.15, relY: 0.82),
          PuzzleNode(id: 'right', displayValue: '$r', relX: 0.85, relY: 0.82),
          PuzzleNode(id: 'center', displayValue: '$center', relX: 0.5, relY: 0.56),
        ],
        correctAnswer: '$targetLeft',
        hint: 'Rule is (Top × Left) + Right = Center. Deduce Left vertex.',
        solution: '($t × ?) + $r = $center\n$t × ? = ${center - r}\n? = $targetLeft.',
      );
    }
  }

  // --- Non-Geometry Replacement for catIndex 9 (Levels 1-150): Proportion & Average Riddles ---
  static LevelData generateAverageRiddle(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      // Levels 24, 38 (Tier 0)
      final avg = 15 + (k % 3) * 5; // 20 or 25
      final n1 = avg - (k % 4 + 3);
      final n2 = avg + (k % 3 + 2);
      final target = 3 * avg - (n1 + n2);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Formula,
        category: category,
        difficulty: difficulty,
        displayContent: 'The average of three numbers is $avg. If two of the numbers are $n1 and $n2, what is the third number?',
        correctAnswer: '$target',
        hint: 'The sum of all three numbers is 3 × $avg = ${3 * avg}. Subtract $n1 and $n2.',
        solution: 'Total sum = 3 × $avg = ${3 * avg}. Third number = ${3 * avg} - ($n1 + $n2) = $target.',
      );
    } else if (tier <= 1) {
      // Levels 52, 66, 80, 94 (Tier 1)
      if (k % 2 == 0) {
        // Average test score
        const targetAvg = 85;
        final t1 = 78 + (k % 3) * 2;
        final t2 = 82 + (k % 4) * 2;
        final t3 = 88 + (k % 3) * 2;
        final target = 4 * targetAvg - (t1 + t2 + t3);
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'A student scored $t1, $t2, and $t3 on three tests. What score is needed on the fourth test to average $targetAvg overall?',
          correctAnswer: '$target',
          hint: 'To average $targetAvg across 4 tests, total score needed is 4 × $targetAvg = ${4 * targetAvg}.',
          solution: 'Total needed = 4 × $targetAvg = ${4 * targetAvg}. Fourth test = ${4 * targetAvg} - ($t1 + $t2 + $t3) = $target.',
        );
      } else {
        // Ratio problem
        final ratioA = (k % 3) + 3; // 3, 4, 5
        final ratioB = ratioA + (k % 2) + 2; // ratioA + 2 or 3
        final mult = (k % 4) + 7; // 7..10
        final countA = ratioA * mult;
        final countB = ratioB * mult;
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The ratio of blue marbles to red marbles in a bag is $ratioA to $ratioB. If there are $countA blue marbles, how many red marbles are there?',
          correctAnswer: '$countB',
          hint: 'Find the value of 1 ratio part: $countA ÷ $ratioA.',
          solution: '1 part = $countA ÷ $ratioA = $mult. Red marbles = $ratioB × $mult = $countB.',
        );
      }
    } else {
      // Levels 108, 122, 136, 150 (Tier 2)
      if (k == 7) {
        // Consecutive integers average
        const avg = 30;
        const largest = 32;
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The average of 5 consecutive integers is $avg. What is the largest of these integers?',
          correctAnswer: '$largest',
          hint: 'In 5 consecutive integers, the middle integer equals their average ($avg).',
          solution: 'The 5 consecutive integers are 28, 29, 30, 31, 32. The largest is 32.',
        );
      } else if (k == 8) {
        // Consecutive even integers average
        const avg = 44;
        const largest = 48;
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The average of 5 consecutive even integers is $avg. What is the largest of these integers?',
          correctAnswer: '$largest',
          hint: 'The middle even integer is $avg. The integers are $avg - 4, $avg - 2, $avg, $avg + 2, $avg + 4.',
          solution: 'The integers are 40, 42, 44, 46, 48. The largest is 48.',
        );
      } else if (k == 9) {
        // Average with removed element
        const count = 6;
        const oldAvg = 18;
        const newAvg = 16;
        const removed = (count * oldAvg) - ((count - 1) * newAvg); // 108 - 80 = 28
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The average of $count numbers is $oldAvg. When one number is removed, the average of the remaining ${count - 1} numbers becomes $newAvg. What was the removed number?',
          correctAnswer: '$removed',
          hint: 'Subtract the new sum (${count - 1} × $newAvg) from the original sum ($count × $oldAvg).',
          solution: 'Original sum = $count × $oldAvg = ${count * oldAvg}. New sum = ${count - 1} × $newAvg = ${(count - 1) * newAvg}. Removed number = ${count * oldAvg} - ${(count - 1) * newAvg} = $removed.',
        );
      } else {
        // Level 150: Average with added element
        const count = 5;
        const oldAvg = 24;
        const added = 36;
        const newAvg = ((count * oldAvg) + added) ~/ (count + 1); // (120 + 36) / 6 = 26
        return LevelData(
          levelNumber: level,
          questionType: QuestionType.Formula,
          category: category,
          difficulty: difficulty,
          displayContent: 'The average of $count numbers is $oldAvg. If a 6th number with value $added is added, what is the new average of all 6 numbers?',
          correctAnswer: '$newAvg',
          hint: 'Find the total sum of all 6 numbers, then divide by 6.',
          solution: 'Sum of 5 numbers = $count × $oldAvg = ${count * oldAvg}. Total with 6th number = ${count * oldAvg} + $added = ${(count * oldAvg) + added}. New average = ${(count * oldAvg) + added} ÷ 6 = $newAvg.',
        );
      }
    }
  }

  // --- Category 9 (Levels > 150): Geometry: Intersecting Circles ---
  static LevelData generateCircles(int level, String category, String difficulty, int tier, int k) {
    if (tier <= 0) {
      final a = ((k * 2 % 9) + 3) * 2; final b = ((k % 7) + 7) * 2; final ans = (a + b) ~/ 2;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Center is the arithmetic average (mean) of the left and right circles.',
        solution: '($a + $b) ÷ 2 = ${a + b} ÷ 2 = $ans.',
      );
    } else if (tier <= 1) {
      final root = (k * 2 % 7) + 3; final a = root * 2; final b = root * 8; final ans = (root * 4);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Multiply outer circles and find the square root: √(Left × Right).',
        solution: '√($a × $b) = √${a * b} = $ans.',
      );
    } else if (tier <= 2) {
      final a = (k * 2 % 9) + 12; final b = (k % 5) + 4; final diff = a - b; final ans = diff * diff;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Subtract the right value from the left value, then square the difference.',
        solution: '($a - $b)² = $diff² = $ans.',
      );
    } else if (tier <= 3) {
      final a = (k * 2 % 7) + 4; final b = (k % 5) + 3; final ans = (a * b) - (a + b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Multiply left and right, then subtract their sum: (Left × Right) - (Left + Right).',
        solution: '($a × $b) - ($a + $b) = ${a * b} - ${a + b} = $ans.',
      );
    } else if (tier <= 4) {
      final pairs = [
        {'a': 30, 'b': 60, 'ans': 40},
        {'a': 20, 'b': 30, 'ans': 24},
        {'a': 12, 'b': 24, 'ans': 16},
        {'a': 15, 'b': 60, 'ans': 24},
        {'a': 10, 'b': 40, 'ans': 16},
        {'a': 40, 'b': 60, 'ans': 48},
        {'a': 18, 'b': 36, 'ans': 24},
      ];
      final p = pairs[k % pairs.length];
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left ${p['a']}, Right ${p['b']} → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '${p['a']}'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '${p['b']}'),
        ],
        correctAnswer: '${p['ans']}',
        hint: 'Center is the harmonic mean: (2 × Left × Right) ÷ (Left + Right).',
        solution: '(2 × ${p['a']} × ${p['b']}) ÷ (${p['a']} + ${p['b']}) = ${2 * p['a']! * p['b']!} ÷ ${p['a']! + p['b']!} = ${p['ans']}.',
      );
    } else if (tier <= 5) {
      final base = (k * 2 % 7) + 4; final a = base * 3; final b = base * 5; final ans = base;
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Center represents the Greatest Common Divisor (GCD) of both circles.',
        solution: 'GCD($a, $b) = $ans.',
      );
    } else {
      final a = (k * 2 % 7) + 5; final b = (k % 5) + 4; final ans = (a * a) + (b * b) + (a * b);
      return LevelData(
        levelNumber: level,
        questionType: QuestionType.Geometry,
        category: category,
        difficulty: difficulty,
        displayContent: 'Circles: Left $a, Right $b → Overlap = ?',
        nodes: [
          PuzzleNode(id: 'left', displayValue: '$a'),
          PuzzleNode(id: 'center', displayValue: '?', isTarget: true),
          PuzzleNode(id: 'right', displayValue: '$b'),
        ],
        correctAnswer: '$ans',
        hint: 'Center formula: Left² + Right² + (Left × Right).',
        solution: '$a² + $b² + ($a × $b) = ${a * a} + ${b * b} + ${a * b} = $ans.',
      );
    }
  }
}
