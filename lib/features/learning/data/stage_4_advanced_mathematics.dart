import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

/// Stage 4: Advanced Mathematics
/// Covers multi-variable systems, quadratics, geometry, trigonometry, and probability.
final List<Lesson> stage4AdvancedMathematics = [
  // Lesson 19 (Preserves topic_logic)
  const Lesson(
    id: 'topic_logic',
    title: '19. Simultaneous Equations & Elimination',
    category: 'Logic Numbers',
    stage: 'Stage 4 – Advanced Mathematics',
    stageIndex: 4,
    difficulty: 'Advanced',
    conceptSummary:
        'When a problem contains two unknowns, you need two equations. Subtracting one equation from the other eliminates one variable completely.',
    formula: 'Elimination: (2x + y) - (x + y) = 11 - 7 ⟹ x = 4',
    whatItIs:
        'A system of equations represents multiple simultaneous conditions. Solving finds the exact point where both conditions are satisfied.',
    whyItWorks:
        'Since both equations contain the exact same amount of y (+1y), subtracting the entire second equation from the first completely cancels out y.',
    howToSolveIt:
        'Step 1: Line up equations vertically with matching variables.\nStep 2: Subtract equation 2 from equation 1 to eliminate y.\nStep 3: Solve the remaining single-variable equation for x.\nStep 4: Substitute x back to find y.',
    whenToUseIt:
        'Use when buying mixed items (e.g., 2 coffees and 1 muffin cost \$11, while 1 coffee and 1 muffin cost \$7).',
    stepByStepExplanation:
        'Step 1: Equation (1): 2x + y = 11.\nStep 2: Equation (2): x + y = 7.\nStep 3: Subtract Equation (2) from Equation (1):\n  (2x - x) + (y - y) = 11 - 7\n  x + 0 = 4 ⟹ x = 4.\nStep 4: Substitute x = 4 into (2):\n  4 + y = 7 ⟹ y = 3.\nCheck in (1): 2(4) + 3 = 8 + 3 = 11. Verified!',
    workedExample:
        'Example: x + y = 10 and x - y = 2.\nAdd equations to eliminate y: 2x = 12 ⟹ x = 6, y = 4.',
    takeaway: 'Equal coefficients allow instant elimination by subtraction.',
    commonMistakes: [
      'Subtracting the left side but forgetting to subtract the right side constants.',
      'Sign errors when subtracting negative terms: y - (-y) = 2y, not 0.',
    ],
    shortcutsAndTricks: [
      'If signs match (+y and +y), subtract. If signs differ (+y and -y), add!',
    ],
    alternativeMethods: [
      'Substitution: rearrange (2) to y = 7 - x, then replace y in (1): 2x + (7 - x) = 11 → x = 4.',
    ],
    sandboxType: SandboxDemoType.logic,
    linkedLevels: [8, 24, 76, 155],
    practiceQuestion: PracticeQuestion(
      question: 'If 2x + y = 11 and x + y = 7, what is the value of x?',
      correctAnswer: '4',
      hint: 'Subtract the second equation from the first equation: (2x + y) - (x + y) = 11 - 7.',
      explanation: 'Subtracting leaves (2x - x) = (11 - 7), so x = 4.',
      options: ['4', '3', '5', '2'],
      stepByStepGuidance: '2x - x = 11 - 7 ⟹ x = 4.',
      wrongOptionExplanations: {
        '3': '3 is the value of y (because 4 + 3 = 7). The question asked for x.',
        '5': 'If x = 5 and y = 2, then 2(5) + 2 = 12, not 11.',
        '2': 'If x = 2 and y = 5, then 2(2) + 5 = 9, not 11.',
      },
    ),
    icon: Icons.alt_route_rounded,
  ),

  // Lesson 20
  const Lesson(
    id: 'stage4_lesson20_quadratic_factoring',
    title: '20. Quadratic Equations & Factoring',
    category: 'Algebra',
    stage: 'Stage 4 – Advanced Mathematics',
    stageIndex: 4,
    difficulty: 'Advanced',
    conceptSummary:
        'A quadratic equation contains an x² term. By factoring into (x - a)(x + a) = 0 or using the Zero Product Property, we reveal the roots.',
    formula: 'Difference of Squares: x² - a² = (x - a)(x + a) = 0',
    whatItIs:
        'Quadratics form U-shaped parabolas. The roots are where the curve crosses the horizontal x-axis.',
    whyItWorks:
        'Zero Product Property: If two factors multiply to zero (A × B = 0), at least one of the factors MUST be equal to zero.',
    howToSolveIt:
        'Step 1: Move all terms to one side so the equation equals zero.\nStep 2: Recognize the difference of squares: x² - 9 = x² - 3².\nStep 3: Factor: (x - 3)(x + 3) = 0.\nStep 4: Set each factor to zero: x = 3 or x = -3.',
    whenToUseIt:
        'Used to calculate gravitational trajectories of rockets, ballistics, and profit curve vertexes.',
    stepByStepExplanation:
        'Step 1: Solve x² - 9 = 0.\nStep 2: Add 9 to both sides: x² = 9.\nStep 3: Take the square root of both sides: x = ±√9 = ±3.\nStep 4: The problem asks for the POSITIVE root.\nStep 5: Positive root = 3.',
    workedExample:
        'Example: Solve x² - 5x + 6 = 0.\nFactors that multiply to 6 and add to -5: -2 and -3.\n(x - 2)(x - 3) = 0 ⟹ x = 2 or x = 3.',
    takeaway: 'Taking a square root always introduces both positive and negative solutions (±).',
    commonMistakes: [
      'Forgetting the negative root when solving x² = 9 (both 3 and -3 square to 9).',
      'Dividing by x, which accidentally eliminates the x = 0 root.',
    ],
    shortcutsAndTricks: [
      'Difference of squares shortcut: a² - b² = (a - b)(a + b).',
    ],
    alternativeMethods: [
      'Quadratic Formula: x = (-b ± √(b² - 4ac)) / (2a). For x² - 9 = 0: a=1, b=0, c=-9.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [151, 165, 210, 280],
    practiceQuestion: PracticeQuestion(
      question: 'What is the positive root of the quadratic equation: x² - 9 = 0?',
      correctAnswer: '3',
      hint: 'Add 9 to both sides to get x² = 9. What positive number squared equals 9?',
      explanation: 'x² = 9 ⟹ x = ±3. The positive root is 3.',
      options: ['3', '9', '6', '1'],
      stepByStepGuidance: 'x² = 9 ⟹ x = √9 = 3.',
      wrongOptionExplanations: {
        '9': '9 is x², not x. √9 = 3.',
        '6': '6 squared is 36, not 9.',
        '1': '1 squared is 1, not 9.',
      },
    ),
    icon: Icons.all_inclusive_rounded,
  ),

  // Lesson 21
  const Lesson(
    id: 'stage4_lesson21_coordinate_geometry',
    title: '21. Coordinate Geometry & Linear Slopes',
    category: 'Geometry',
    stage: 'Stage 4 – Advanced Mathematics',
    stageIndex: 4,
    difficulty: 'Advanced',
    conceptSummary:
        'Points are ordered pairs (x, y). Slope (m) measures the rate of rise over run: m = (y2 - y1) / (x2 - x1).',
    formula: 'Slope m = (y2 - y1) / (x2 - x1) | Line equation: y = mx + c',
    whatItIs:
        'Coordinate geometry unites numbers and shapes, allowing geometric lines to be written as algebraic equations.',
    whyItWorks:
        'Slope is constant along any straight line. For every unit you step right (run), you rise by m units.',
    howToSolveIt:
        'Step 1: Identify coordinates: (x1, y1) = (1, 3) and (x2, y2) = (3, 11).\nStep 2: Calculate change in y: Δy = 11 - 3 = 8.\nStep 3: Calculate change in x: Δx = 3 - 1 = 2.\nStep 4: Divide rise by run: m = 8 ÷ 2 = 4.',
    whenToUseIt:
        'Used in video game player positioning, GPS navigation, and machine learning linear regression.',
    stepByStepExplanation:
        'Step 1: Point 1 = (1, 3), Point 2 = (3, 11).\nStep 2: Rise (vertical change) = y2 - y1 = 11 - 3 = 8.\nStep 3: Run (horizontal change) = x2 - x1 = 3 - 1 = 2.\nStep 4: Slope m = Rise / Run = 8 / 2 = 4.\nConclusion: The slope of the line is 4.',
    workedExample:
        'Example: Find the slope between (0, 0) and (2, 6).\nRise = 6 - 0 = 6. Run = 2 - 0 = 2. Slope m = 6 / 2 = 3.',
    takeaway: 'Slope is always Rise over Run: vertical change divided by horizontal change.',
    commonMistakes: [
      'Inverting the fraction: Run over Rise (Δx / Δy) instead of Rise over Run (Δy / Δx).',
      'Mixing up the order of points: (y2 - y1) / (x1 - x2) will produce an incorrect negative sign.',
    ],
    shortcutsAndTricks: [
      'Horizontal lines have slope 0; vertical lines have undefined slope.',
    ],
    alternativeMethods: [
      'Visual grid counting: plot points on graph paper and count units up and units right.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [158, 185, 240, 310],
    practiceQuestion: PracticeQuestion(
      question: 'What is the slope (m) of the line passing through points (1, 3) and (3, 11)?',
      correctAnswer: '4',
      hint: 'Slope = (y2 - y1) ÷ (x2 - x1) = (11 - 3) ÷ (3 - 1).',
      explanation: 'm = (11 - 3) / (3 - 1) = 8 / 2 = 4.',
      options: ['4', '3', '8', '2'],
      stepByStepGuidance: 'Δy = 8, Δx = 2. m = 8 ÷ 2 = 4.',
      wrongOptionExplanations: {
        '3': 'Check the division: 8 ÷ 2 = 4, not 3.',
        '8': '8 is the vertical rise (Δy), but you must divide by the run Δx = 2.',
        '2': '2 is the horizontal run (Δx), not the slope.',
      },
    ),
    icon: Icons.timeline_rounded,
  ),

  // Lesson 22 (Preserves topic_triangles)
  const Lesson(
    id: 'topic_triangles',
    title: '22. Angles, Triangles & Pythagorean Theorem',
    category: 'Geometry: Triangles',
    stage: 'Stage 4 – Advanced Mathematics',
    stageIndex: 4,
    difficulty: 'Advanced',
    conceptSummary:
        'In any right-angled triangle, the square of the hypotenuse equals the sum of the squares of the other two sides: a² + b² = c².',
    formula: 'a² + b² = c² | Triangle angle sum = 180°',
    whatItIs:
        'The foundational theorem of geometry connecting triangle side lengths and Euclidean 2D distance.',
    whyItWorks:
        'Constructing physical squares on sides a and b shows their combined area perfectly fills a square built on hypotenuse c.',
    howToSolveIt:
        'Step 1: Square leg a: 9² = 81.\nStep 2: Square leg b: 12² = 144.\nStep 3: Add the squares: 81 + 144 = 225.\nStep 4: Take the square root: c = √225 = 15.',
    whenToUseIt:
        'Essential for construction, carpenter squaring, video game hitboxes, and distance between 2D/3D points.',
    stepByStepExplanation:
        'Step 1: Leg a = 9, Leg b = 12.\nStep 2: a² = 81, b² = 144.\nStep 3: c² = a² + b² = 81 + 144 = 225.\nStep 4: c = √225.\nStep 5: Since 15 × 15 = 225, c = 15.\nNotice: This is a 3-4-5 triangle scaled by a factor of 3 (3×3, 4×3, 5×3 = 9, 12, 15).',
    workedExample:
        'Example: Legs are 3 and 4. Hypotenuse = √(3² + 4²) = √(9 + 16) = √25 = 5.',
    takeaway: 'The hypotenuse c is always the longest side and faces the 90° angle.',
    commonMistakes: [
      'Applying Pythagoras to non-right triangles (only valid if one angle is 90°).',
      'Adding sides before squaring (9 + 12 = 21, which is NOT 15!).',
    ],
    shortcutsAndTricks: [
      'Memorize Pythagorean Triples: 3-4-5, 5-12-13, 8-15-17. Any multiple is also valid (e.g., 9-12-15).',
    ],
    alternativeMethods: [
      'Scale reduction: divide 9 and 12 by 3 to get 3 and 4. The hypotenuse is 5, then scale back: 5 × 3 = 15.',
    ],
    sandboxType: SandboxDemoType.triangles,
    linkedLevels: [152, 170, 225, 320],
    practiceQuestion: PracticeQuestion(
      question: 'In a right triangle with legs of length 9 and 12, what is the length of the hypotenuse?',
      correctAnswer: '15',
      hint: 'c² = 9² + 12² = 81 + 144 = 225. What is the square root of 225?',
      explanation: 'c² = 81 + 144 = 225 ⟹ c = √225 = 15 (a 3-4-5 triple scaled by 3).',
      options: ['15', '14', '16', '21'],
      stepByStepGuidance: 'c = √(81 + 144) = √225 = 15.',
      wrongOptionExplanations: {
        '14': '14² = 196, not 225.',
        '16': '16² = 256, not 225.',
        '21': 'You added 9 + 12 directly. You must square the sides first!',
      },
    ),
    icon: Icons.change_history_rounded,
  ),

  // Lesson 23 (Preserves topic_circles)
  const Lesson(
    id: 'topic_circles',
    title: '23. Circles, Overlaps, Area & Volume',
    category: 'Geometry: Intersecting Circles',
    stage: 'Stage 4 – Advanced Mathematics',
    stageIndex: 4,
    difficulty: 'Advanced',
    conceptSummary:
        'Circle Area = πr², Circumference = 2πr. For intersecting shapes: Total Area = Area(A) + Area(B) - Overlap.',
    formula: 'Area = πr² | Total Union = A + B - Overlap',
    whatItIs:
        'Circles are shapes formed by all points equidistant from a center. Overlap subtraction prevents double-counting shared regions.',
    whyItWorks:
        'When calculating the combined area of two overlapping circles, the shared lens region belongs to both circles. Adding Area A and Area B counts the lens twice, so it must be subtracted once.',
    howToSolveIt:
        'Step 1: Formula for circle area: A = πr².\nStep 2: Radius r = 7, and π ≈ 22/7.\nStep 3: r² = 7 × 7 = 49.\nStep 4: Multiply by π: (22/7) × 49 = 22 × 7 = 154.',
    whenToUseIt:
        'Used in Venn diagrams, wireless router coverage overlap, satellite dish sizing, and pipeline capacities.',
    stepByStepExplanation:
        'Step 1: Circle radius r = 7.\nStep 2: Use standard approximation π = 22/7.\nStep 3: Area = π × r² = (22/7) × 7².\nStep 4: 7² = 49.\nStep 5: Area = (22/7) × 49 = 22 × (49 ÷ 7) = 22 × 7 = 154.',
    workedExample:
        'Example: Find circumference of circle with radius 7.\nC = 2πr = 2 × (22/7) × 7 = 44.',
    takeaway: 'Always subtract the overlapping intersection once so it is not double-counted.',
    commonMistakes: [
      'Using diameter instead of radius (if diameter is 14, radius is 7).',
      'Confusing Circumference (2πr) with Area (πr²).',
    ],
    shortcutsAndTricks: [
      'When radius is a multiple of 7, using 22/7 cancels denominators cleanly.',
    ],
    alternativeMethods: [
      'Decimal calculation: 3.14159 × 49 ≈ 153.94 ≈ 154.',
    ],
    sandboxType: SandboxDemoType.circles,
    linkedLevels: [160, 205, 275, 350],
    practiceQuestion: PracticeQuestion(
      question: 'A circle has a radius of 7. Using π = 22/7, what is the area of the circle?',
      correctAnswer: '154',
      hint: 'Area = π × r² = (22/7) × 7 × 7. Cancel one 7 with the denominator.',
      explanation: 'Area = (22/7) × 49 = 22 × 7 = 154.',
      options: ['154', '44', '77', '308'],
      stepByStepGuidance: 'Area = (22/7) × 49 = 154.',
      wrongOptionExplanations: {
        '44': '44 is the Circumference (2πr = 2 × 22/7 × 7), not the Area.',
        '77': 'Check your arithmetic: 22 × 7 = 154, not 77.',
        '308': '308 is double the actual area (you multiplied by diameter 14 instead of radius 7).',
      },
    ),
    icon: Icons.lens_outlined,
  ),

  // Lesson 24
  const Lesson(
    id: 'stage4_lesson24_probability_combinatorics',
    title: '24. Probability, Permutations & Combinations',
    category: 'Probability',
    stage: 'Stage 4 – Advanced Mathematics',
    stageIndex: 4,
    difficulty: 'Advanced',
    conceptSummary:
        'Probability is favorable outcomes divided by total outcomes. Permutations count orderings: n! = n × (n - 1) × ... × 1.',
    formula: 'Factorial: n! = n × (n-1)...× 1 | P(Event) = Favorable ÷ Total',
    whatItIs:
        'Combinatorics counts possibilities without listing them one by one. Factorials tell how many distinct arrangements exist for n items.',
    whyItWorks:
        'For 4 books: 4 choices for the 1st slot, 3 for the 2nd, 2 for the 3rd, and 1 for the last: 4 × 3 × 2 × 1 = 24 arrangements.',
    howToSolveIt:
        'Step 1: Identify that order matters (arranging on a shelf).\nStep 2: Use factorial notation: 4! = 4 × 3 × 2 × 1.\nStep 3: Multiply: 4 × 3 = 12; 12 × 2 = 24; 24 × 1 = 24.',
    whenToUseIt:
        'Used in password entropy, card games (poker hand odds), tournament seeding, and genetic variation.',
    stepByStepExplanation:
        'Step 1: We have 4 books to arrange on a shelf.\nStep 2: Position 1 can take any of the 4 books.\nStep 3: Position 2 can take any of the 3 remaining books.\nStep 4: Position 3 can take either of the 2 remaining books.\nStep 5: Position 4 gets the final 1 book.\nTotal distinct arrangements = 4 × 3 × 2 × 1 = 24.',
    workedExample:
        'Example: What is the probability of rolling an even number on a 6-sided die?\nEven numbers: 2, 4, 6 (3 outcomes). Total sides: 6. Probability = 3/6 = 1/2.',
    takeaway: 'Probability is always between 0 (impossible) and 1 (certain).',
    commonMistakes: [
      'Adding choices instead of multiplying: 4 + 3 + 2 + 1 = 10 (incorrect!).',
      'Confusing Permutations (order matters) with Combinations (order does not matter).',
    ],
    shortcutsAndTricks: [
      'Remember common factorials: 3! = 6, 4! = 24, 5! = 120, 6! = 720.',
    ],
    alternativeMethods: [
      'Decision tree: branch 4 paths from root, then 3 from each branch, counting 24 leaves.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [172, 230, 315, 390],
    practiceQuestion: PracticeQuestion(
      question: 'In how many different orders can 4 distinct books be arranged on a single shelf?',
      correctAnswer: '24',
      hint: 'Calculate 4! (4 factorial): 4 × 3 × 2 × 1 = ?',
      explanation: '4! = 4 × 3 × 2 × 1 = 24 distinct orderings.',
      options: ['24', '16', '12', '8'],
      stepByStepGuidance: '4 × 3 × 2 × 1 = 24.',
      wrongOptionExplanations: {
        '16': '16 is 4² (4 × 4), not 4 factorial.',
        '12': '12 is only 4 × 3; you must multiply by 2 as well.',
        '8': '8 is 4 × 2, not 4!.',
      },
    ),
    icon: Icons.casino_rounded,
  ),
];
