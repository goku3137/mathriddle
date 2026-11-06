import 'package:flutter/material.dart';
import '../../../models/lesson_model.dart';

/// Stage 5: Expert Mathematics
/// Introduces complex numbers, logarithms, matrices, vector algebra, and differential limits.
final List<Lesson> stage5ExpertMathematics = [
  // Lesson 25
  const Lesson(
    id: 'stage5_lesson25_complex_numbers',
    title: '25. Complex Numbers & the Argand Plane',
    category: 'Complex Analysis',
    stage: 'Stage 5 – Expert Mathematics',
    stageIndex: 5,
    difficulty: 'Expert',
    conceptSummary:
        'The imaginary unit i satisfies i² = -1. A complex number has the form z = a + bi, with modulus (distance from origin) |z| = √(a² + b²).',
    formula: 'i² = -1 | Modulus: |z| = √(a² + b²)',
    whatItIs:
        'Complex numbers extend the 1D real number line into a 2D plane (Argand plane), where the horizontal axis is real and the vertical axis is imaginary.',
    whyItWorks:
        'Just as negative numbers allow us to solve x + 5 = 2, complex numbers allow us to solve x² = -1. The modulus is Euclidean distance in the complex plane.',
    howToSolveIt:
        'Step 1: Given z = 6 + 8i, real part a = 6, imaginary part b = 8.\nStep 2: Calculate a² = 6² = 36.\nStep 3: Calculate b² = 8² = 64.\nStep 4: Add squares: 36 + 64 = 100.\nStep 5: Take square root: |z| = √100 = 10.',
    whenToUseIt:
        'Vital in electrical engineering (AC impedance, alternating currents), quantum wave mechanics, and fractal geometry (Mandelbrot set).',
    stepByStepExplanation:
        'Step 1: Complex number z = 6 + 8i.\nStep 2: Real component a = 6, Imaginary component b = 8.\nStep 3: Modulus formula |z| = √(a² + b²).\nStep 4: Substitute: |z| = √(6² + 8²) = √(36 + 64) = √100.\nStep 5: √100 = 10.\nConclusion: The modulus of 6 + 8i is 10.',
    workedExample:
        'Example: Find modulus of z = 3 + 4i.\n|z| = √(3² + 4²) = √(9 + 16) = √25 = 5.',
    takeaway: 'The modulus of a + bi is the distance from the point (a, b) to the origin (0, 0).',
    commonMistakes: [
      'Including i when calculating modulus: √(a² + (bi)²) would give √(a² - b²), which is wrong! Modulus uses b, not bi.',
      'Thinking i is a variable; i is a fixed constant representing √-1.',
    ],
    shortcutsAndTricks: [
      'Powers of i cycle in 4s: i¹ = i, i² = -1, i³ = -i, i⁴ = 1.',
    ],
    alternativeMethods: [
      'Polar form: z = r(cos θ + i sin θ), where r = 10 is the modulus.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [250, 305, 365, 420],
    practiceQuestion: PracticeQuestion(
      question: 'What is the modulus |z| of the complex number z = 6 + 8i?',
      correctAnswer: '10',
      hint: '|z| = √(6² + 8²) = √(36 + 64). What is the square root of 100?',
      explanation: '|z| = √(36 + 64) = √100 = 10.',
      options: ['10', '14', '12', '100'],
      stepByStepGuidance: '|z| = √(6² + 8²) = √100 = 10.',
      wrongOptionExplanations: {
        '14': 'You added 6 + 8 directly. You must square each term first!',
        '12': 'Check your arithmetic: √100 = 10, not 12.',
        '100': '100 is |z|², you must take the square root to find |z|.',
      },
    ),
    icon: Icons.grain_rounded,
  ),

  // Lesson 26
  const Lesson(
    id: 'stage5_lesson26_logarithms_exponentials',
    title: '26. Logarithms & Exponential Growth',
    category: 'Analysis',
    stage: 'Stage 5 – Expert Mathematics',
    stageIndex: 5,
    difficulty: 'Expert',
    conceptSummary:
        'Logarithms answer: "What power was the base raised to?". log_b(x) = y means bʸ = x. Logs turn multiplication into addition.',
    formula: 'log_b(x) = y ⟺ bʸ = x | log(a × b) = log(a) + log(b)',
    whatItIs:
        'Logarithms are the exact mathematical inverse of exponential functions.',
    whyItWorks:
        'Because powers add when multiplying like bases (bˣ × bʸ = bˣ⁺ʸ), taking the logarithm of a product converts it into a sum of logs.',
    howToSolveIt:
        'Step 1: Evaluate log₂(64): ask "2 to what power equals 64?". Since 2⁶ = 64, log₂(64) = 6.\nStep 2: Evaluate log₃(27): ask "3 to what power equals 27?". Since 3³ = 27, log₃(27) = 3.\nStep 3: Add results: 6 + 3 = 9.',
    whenToUseIt:
        'Used in the Richter scale for earthquake magnitude, decibels for sound loudness, pH scale in chemistry, and algorithmic time complexity O(log n).',
    stepByStepExplanation:
        'Step 1: Problem: log₂(64) + log₃(27).\nStep 2: Powers of 2: 2, 4, 8, 16, 32, 64 (which is 2⁶). So log₂(64) = 6.\nStep 3: Powers of 3: 3, 9, 27 (which is 3³). So log₃(27) = 3.\nStep 4: Combine terms: 6 + 3 = 9.\nFinal Result: 9.',
    workedExample:
        'Example: Evaluate log₁₀(1000).\n10³ = 1000, therefore log₁₀(1000) = 3.',
    takeaway: 'A logarithm simply counts how many times the base was multiplied.',
    commonMistakes: [
      'Dividing instead of finding the exponent: log₂(64) is 6, NOT 64 ÷ 2 = 32!',
      'Attempting to evaluate log of 0 or a negative number (undefined in real numbers).',
    ],
    shortcutsAndTricks: [
      'Change of Base formula: log_b(a) = ln(a) / ln(b).',
    ],
    alternativeMethods: [
      'Repeated division: divide 64 by 2 repeatedly until 1: 64→32→16→8→4→2→1 (took 6 divisions).',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [265, 320, 380, 435],
    practiceQuestion: PracticeQuestion(
      question: 'Evaluate the logarithmic sum: log₂(64) + log₃(27) = ?',
      correctAnswer: '9',
      hint: '2⁶ = 64 so log₂(64) = 6. 3³ = 27 so log₃(27) = 3. Add them together.',
      explanation: 'log₂(64) = 6 and log₃(27) = 3. 6 + 3 = 9.',
      options: ['9', '8', '10', '12'],
      stepByStepGuidance: '6 + 3 = 9.',
      wrongOptionExplanations: {
        '8': 'Check the powers: 2⁶ = 64, not 2⁵.',
        '10': 'Check your addition: 6 + 3 = 9.',
        '12': 'Check powers: log₃(27) = 3, not 6.',
      },
    ),
    icon: Icons.auto_graph_rounded,
  ),

  // Lesson 27
  const Lesson(
    id: 'stage5_lesson27_advanced_trigonometry',
    title: '27. Advanced Trigonometry & the Unit Circle',
    category: 'Trigonometry',
    stage: 'Stage 5 – Expert Mathematics',
    stageIndex: 5,
    difficulty: 'Expert',
    conceptSummary:
        'On a circle of radius 1, points are (cos θ, sin θ). The fundamental Pythagorean identity states that sin²θ + cos²θ = 1 for any angle.',
    formula: 'sin²θ + cos²θ = 1 ⟹ cos²θ = 1 - sin²θ',
    whatItIs:
        'Trigonometry relates triangle side ratios to periodic rotational motion and cyclical waveforms.',
    whyItWorks:
        'In the unit circle, x = cos θ and y = sin θ. By the Pythagorean theorem, x² + y² = 1², which yields sin²θ + cos²θ = 1.',
    howToSolveIt:
        'Step 1: Given sin θ = 3/5.\nStep 2: Square it: sin²θ = (3/5)² = 9/25.\nStep 3: Find cos²θ: 1 - 9/25 = 16/25.\nStep 4: Problem asks for 25 × cos²θ: 25 × (16/25) = 16.',
    whenToUseIt:
        'Used in Fourier audio analysis, wave mechanics, satellite tracking, robotics joint inverse kinematics, and game physics engines.',
    stepByStepExplanation:
        'Step 1: Given sin θ = 3/5.\nStep 2: We know the fundamental identity: sin²θ + cos²θ = 1.\nStep 3: Rearrange to find cos²θ: cos²θ = 1 - sin²θ.\nStep 4: Substitute sin θ: cos²θ = 1 - (3/5)² = 1 - 9/25 = 16/25.\nStep 5: Multiply by 25: 25 × (16/25) = 16.',
    workedExample:
        'Example: If cos θ = 4/5, what is sin²θ?\nsin²θ = 1 - (4/5)² = 1 - 16/25 = 9/25.',
    takeaway: 'sin²θ + cos²θ = 1 holds true for every angle in the universe.',
    commonMistakes: [
      'Confusing sin²θ with sin(θ²). sin²θ means [sin(θ)]².',
      'Forgetting to square the denominator: (3/5)² is 9/25, not 9/5.',
    ],
    shortcutsAndTricks: [
      'Recognize the 3-4-5 right triangle: if sin is 3/5, cos must be 4/5.',
    ],
    alternativeMethods: [
      'Geometric right triangle: opposite = 3, hypotenuse = 5. Adjacent side = √(25 - 9) = 4. cos θ = 4/5. 25 × (4/5)² = 16.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [285, 340, 395, 450],
    practiceQuestion: PracticeQuestion(
      question: 'If sin(θ) = 3/5, what is the value of 25 × (cos²(θ))?',
      correctAnswer: '16',
      hint: 'cos²θ = 1 - sin²θ = 1 - (9/25) = 16/25. Multiply by 25.',
      explanation: 'cos²θ = 1 - (3/5)² = 16/25. Then 25 × (16/25) = 16.',
      options: ['16', '9', '20', '25'],
      stepByStepGuidance: '25 × (1 - 9/25) = 25 × (16/25) = 16.',
      wrongOptionExplanations: {
        '9': '9 is 25 × sin²θ (25 × 9/25 = 9). The question asked for cos²θ.',
        '20': 'Check your arithmetic: 25 × (16/25) = 16.',
        '25': '25 would be 25 × (sin²θ + cos²θ) = 25 × 1 = 25.',
      },
    ),
    icon: Icons.waves_rounded,
  ),

  // Lesson 28 (Preserves topic_matrices)
  const Lesson(
    id: 'topic_matrices',
    title: '28. Matrices, Determinants & Transformations',
    category: 'Matrices & Grids',
    stage: 'Stage 5 – Expert Mathematics',
    stageIndex: 5,
    difficulty: 'Expert',
    conceptSummary:
        'A matrix is a 2D grid of numbers. For a 2×2 matrix [[a, b], [c, d]], its determinant is det(A) = ad - bc, representing geometric area scaling.',
    formula: 'det([[a, b], [c, d]]) = ad - bc',
    whatItIs:
        'Matrices represent linear transformations: rotations, shears, and scaling of geometric space.',
    whyItWorks:
        'The determinant ad - bc computes the signed area of the parallelogram formed by the transformed unit basis vectors.',
    howToSolveIt:
        'Step 1: Identify matrix entries: [[5, 2], [3, 4]] where a = 5, b = 2, c = 3, d = 4.\nStep 2: Multiply the main diagonal: a × d = 5 × 4 = 20.\nStep 3: Multiply the off diagonal: b × c = 2 × 3 = 6.\nStep 4: Subtract off-diagonal from main diagonal: 20 - 6 = 14.',
    whenToUseIt:
        'Powers 3D graphic rendering pipelines in GPUs, solves multi-variable electrical circuits, and optimizes neural network weights in AI.',
    stepByStepExplanation:
        'Step 1: Given matrix A = [[5, 2], [3, 4]].\nStep 2: Main diagonal (top-left to bottom-right): 5 × 4 = 20.\nStep 3: Anti-diagonal (top-right to bottom-left): 2 × 3 = 6.\nStep 4: Determinant formula: det(A) = ad - bc.\nStep 5: det(A) = 20 - 6 = 14.',
    workedExample:
        'Example: Find determinant of [[4, 1], [2, 3]].\ndet = (4 × 3) - (1 × 2) = 12 - 2 = 10.',
    takeaway: 'If det(A) = 0, the matrix has no inverse because it squashes 2D space into a 1D line.',
    commonMistakes: [
      'Adding diagonals instead of subtracting: ad + bc is incorrect!',
      'Reversing the subtraction: bc - ad produces an incorrect negative sign.',
    ],
    shortcutsAndTricks: [
      'Diagonal trick: trace an X through the 2×2 matrix: multiply down, multiply up, then subtract.',
    ],
    alternativeMethods: [
      'Geometric vector cross-product: (5, 3) × (2, 4) = 5(4) - 3(2) = 14.',
    ],
    sandboxType: SandboxDemoType.matrices,
    linkedLevels: [7, 21, 63, 189, 400],
    practiceQuestion: PracticeQuestion(
      question: 'Find the determinant of the 2x2 matrix: [[5, 2], [3, 4]]',
      correctAnswer: '14',
      hint: 'Multiply main diagonal (5 × 4 = 20) and subtract off diagonal (2 × 3 = 6).',
      explanation: 'det = (5 × 4) - (2 × 3) = 20 - 6 = 14.',
      options: ['14', '16', '10', '26'],
      stepByStepGuidance: '(5 × 4) - (2 × 3) = 20 - 6 = 14.',
      wrongOptionExplanations: {
        '16': 'Check the multiplication: 5 × 4 = 20, not 22.',
        '10': 'Check your subtraction: 20 - 6 = 14, not 10.',
        '26': 'You added the diagonals (20 + 6 = 26). Determinant requires subtraction: ad - bc.',
      },
    ),
    icon: Icons.grid_on_rounded,
  ),

  // Lesson 29
  const Lesson(
    id: 'stage5_lesson29_vectors_dot_product',
    title: '29. Vectors & Dot Product',
    category: 'Vector Calculus',
    stage: 'Stage 5 – Expert Mathematics',
    stageIndex: 5,
    difficulty: 'Expert',
    conceptSummary:
        'A vector has magnitude and direction. The dot product u · v = (ux × vx) + (uy × vy) = |u||v|cos θ measures directional alignment.',
    formula: 'u · v = ux·vx + uy·vy | Perpendicular if u · v = 0',
    whatItIs:
        'Vectors represent directed quantities such as force, velocity, acceleration, and displacement.',
    whyItWorks:
        'The dot product projects one vector onto another. When vectors are perpendicular (90°), cos 90° = 0, so their dot product is zero.',
    howToSolveIt:
        'Step 1: Identify components: u = (3, 5) and v = (4, 2).\nStep 2: Multiply x-components: 3 × 4 = 12.\nStep 3: Multiply y-components: 5 × 2 = 10.\nStep 4: Add the two products: 12 + 10 = 22.',
    whenToUseIt:
        'Used in video game shading and lighting reflections, calculating physical work done by a force, and recommendation similarity algorithms.',
    stepByStepExplanation:
        'Step 1: Vector u = (3, 5), Vector v = (4, 2).\nStep 2: Dot product formula u · v = ux·vx + uy·vy.\nStep 3: ux·vx = 3 × 4 = 12.\nStep 4: uy·vy = 5 × 2 = 10.\nStep 5: Sum = 12 + 10 = 22.\nConclusion: The dot product is a single scalar number: 22.',
    workedExample:
        'Example: Are u = (2, -1) and v = (2, 4) perpendicular?\nu · v = 2(2) + (-1)(4) = 4 - 4 = 0. Yes, they are perpendicular!',
    takeaway: 'The dot product of two perpendicular vectors is ALWAYS zero.',
    commonMistakes: [
      'Producing another vector instead of a scalar number (dot product results in a single number).',
      'Confusing dot product with cross product.',
    ],
    shortcutsAndTricks: [
      'If both vectors point in similar directions, dot product is positive; if pointing opposite, it is negative.',
    ],
    alternativeMethods: [
      'Geometric formula: |u||v|cos θ gives the exact same result.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [300, 360, 410, 460],
    practiceQuestion: PracticeQuestion(
      question: 'Compute the dot product of vectors u = (3, 5) and v = (4, 2):',
      correctAnswer: '22',
      hint: 'Multiply x-coordinates (3 × 4 = 12) and y-coordinates (5 × 2 = 10), then add them.',
      explanation: 'u · v = (3 × 4) + (5 × 2) = 12 + 10 = 22.',
      options: ['22', '20', '24', '18'],
      stepByStepGuidance: '12 + 10 = 22.',
      wrongOptionExplanations: {
        '20': 'Check your addition: 12 + 10 = 22, not 20.',
        '24': 'Check components: (3×4) + (5×2) = 12 + 10 = 22.',
        '18': 'Check multiplication: 3 × 4 = 12 and 5 × 2 = 10.',
      },
    ),
    icon: Icons.navigation_rounded,
  ),

  // Lesson 30
  const Lesson(
    id: 'stage5_lesson30_limits_calculus_intro',
    title: '30. Limits & Introduction to Calculus',
    category: 'Calculus',
    stage: 'Stage 5 – Expert Mathematics',
    stageIndex: 5,
    difficulty: 'Expert',
    conceptSummary:
        'A derivative f\'(x) measures instantaneous slope. The Power Rule states: if f(x) = axⁿ, then f\'(x) = a·n·xⁿ⁻¹.',
    formula: 'Power Rule: d/dx [axⁿ] = a · n · xⁿ⁻¹',
    whatItIs:
        'Calculus is the mathematics of continuous change. While algebra studies static values, calculus studies rates of change and acceleration.',
    whyItWorks:
        'By taking the limit as two points on a curve get infinitely close together (Δx → 0), the secant line becomes the exact tangent slope.',
    howToSolveIt:
        'Step 1: Function f(x) = 4x².\nStep 2: Apply power rule: multiply coefficient by exponent (4 × 2 = 8).\nStep 3: Decrease exponent by 1 (2 - 1 = 1): f\'(x) = 8x.\nStep 4: Evaluate at x = 3: f\'(3) = 8 × 3 = 24.',
    whenToUseIt:
        'Used to calculate speedometer readings from position sensors, rocket acceleration, and financial stock volatility.',
    stepByStepExplanation:
        'Step 1: Given function f(x) = 4x².\nStep 2: Differentiate with respect to x using the Power Rule:\n  f\'(x) = d/dx [4x²] = 4 × (2x²⁻¹) = 8x.\nStep 3: Evaluate the derivative at x = 3:\n  f\'(3) = 8 × (3) = 24.\nConclusion: The instantaneous rate of change at x = 3 is 24.',
    workedExample:
        'Example: Find derivative of f(x) = x³.\nf\'(x) = 3x².',
    takeaway: 'The derivative of a constant number (like 5) is always 0 because constants never change.',
    commonMistakes: [
      'Forgetting to reduce the exponent by 1 (thinking derivative of x² is 2x²).',
      'Plugging in x before differentiating (f(3) = 36, whose derivative would incorrectly look like 0).',
    ],
    shortcutsAndTricks: [
      'Multiply the front number by the power, then drop the power by 1.',
    ],
    alternativeMethods: [
      'First principles limit: lim_{h→0} [4(x+h)² - 4x²] / h = 8x.',
    ],
    sandboxType: SandboxDemoType.general,
    linkedLevels: [325, 375, 425, 470],
    practiceQuestion: PracticeQuestion(
      question: 'What is the derivative of f(x) = 4x² evaluated at x = 3?',
      correctAnswer: '24',
      hint: 'First differentiate: f\'(x) = 4 × 2x = 8x. Then plug in x = 3: 8 × 3 = ?',
      explanation: 'f\'(x) = 8x. At x = 3: f\'(3) = 8 × 3 = 24.',
      options: ['24', '36', '12', '18'],
      stepByStepGuidance: 'f\'(x) = 8x ⟹ f\'(3) = 8(3) = 24.',
      wrongOptionExplanations: {
        '36': '36 is f(3) = 4(3)² = 36 (the original function value, not the derivative slope).',
        '12': 'Check your arithmetic: 8 × 3 = 24, not 12.',
        '18': 'Check the power rule: 4 × 2 = 8, then 8 × 3 = 24.',
      },
    ),
    icon: Icons.show_chart_rounded,
  ),
];

