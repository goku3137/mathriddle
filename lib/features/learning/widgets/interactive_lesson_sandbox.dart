import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/lesson_model.dart';
import '../../../services/sound_service.dart';
import '../../../theme/game_theme.dart';

/// Interactive laboratory demonstration widget allowing users to manipulate
/// numbers, operators, and parameters to see the math recompute in real-time.
class InteractiveLessonSandbox extends ConsumerStatefulWidget {
  final SandboxDemoType demoType;

  const InteractiveLessonSandbox({
    super.key,
    required this.demoType,
  });

  @override
  ConsumerState<InteractiveLessonSandbox> createState() => _InteractiveLessonSandboxState();
}

class _InteractiveLessonSandboxState extends ConsumerState<InteractiveLessonSandbox> {
  // Shared state variables
  int _valA = 6;
  int _valB = 3;
  int _valC = 2;
  int _selectedRuleIndex = 0;
  bool _toggleParentheses = false;

  @override
  void initState() {
    super.initState();
    _initDefaultsForType();
  }

  void _initDefaultsForType() {
    switch (widget.demoType) {
      case SandboxDemoType.bodmas:
        _valA = 6;
        _valB = 2;
        _valC = 3;
        break;
      case SandboxDemoType.patterns:
        _valA = 3; // start
        _valB = 4; // step
        _selectedRuleIndex = 0; // 0: +d, 1: ×r, 2: +n²
        break;
      case SandboxDemoType.missingNumbers:
        _valA = 7;
        _valB = 5;
        _valC = 20; // target sum
        break;
      case SandboxDemoType.triangles:
        _valA = 4; // Top
        _valB = 6; // Left
        _valC = 3; // Right
        break;
      case SandboxDemoType.equations:
        _valA = 3; // a
        _valB = 5; // b
        _valC = 26; // c (3x + 5 = 26 -> x = 7)
        break;
      case SandboxDemoType.sequences:
        _valA = 1;
        _valB = 1;
        _selectedRuleIndex = 0; // 0: Fibonacci, 1: Powers, 2: Doubling
        break;
      case SandboxDemoType.matrices:
        _valA = 4;
        _valB = 6;
        break;
      case SandboxDemoType.money:
        _valA = 80; // Price
        _valB = 25; // Discount %
        break;
      case SandboxDemoType.logic:
        _valA = 3; // tens digit
        _valB = 6; // units digit -> 36
        break;
      case SandboxDemoType.circles:
        _valA = 12; // Left
        _valB = 18; // Right
        _selectedRuleIndex = 0; // 0: Mean, 1: Geo-Mean, 2: Diff-Sq, 3: Harmonic
        break;
      case SandboxDemoType.operators:
        _valA = 4;
        _valB = 5;
        _selectedRuleIndex = 0; // 0: 2a + b, 1: ab + a + b, 2: a² - b²
        break;
      case SandboxDemoType.age:
        _valA = 30; // Person A
        _valB = 10; // Person B
        _valC = 5; // Year shift
        break;
      case SandboxDemoType.tricks:
        _valA = 60; // v1
        _valB = 40; // v2
        _selectedRuleIndex = 0; // 0: Harmonic Speed, 1: Handshakes, 2: Clock Angle
        break;
      case SandboxDemoType.mazes:
        _valA = 5; // Start
        _valB = 3; // op1 add
        _valC = 2; // op2 mult
        break;
      case SandboxDemoType.finalBoss:
        _valA = 14; // Stage 1
        _valB = 45; // Stage 2
        _valC = 55; // F(10)
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.4), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: GameTheme.amberGlow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.tune_rounded, color: GameTheme.amberAccent, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'INTERACTIVE LAB DEMONSTRATION',
                    style: TextStyle(
                      color: GameTheme.amberAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: GameTheme.surfaceElevated,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: GameTheme.borderSubtle),
                ),
                child: const Text(
                  'LIVE SANDBOX',
                  style: TextStyle(
                    color: GameTheme.textMuted,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Dynamic Demonstration Content
          _buildActiveDemo(),
        ],
      ),
    );
  }

  Widget _buildActiveDemo() {
    switch (widget.demoType) {
      case SandboxDemoType.bodmas:
        return _buildBodmasDemo();
      case SandboxDemoType.patterns:
        return _buildPatternsDemo();
      case SandboxDemoType.missingNumbers:
        return _buildMissingNumbersDemo();
      case SandboxDemoType.triangles:
        return _buildTrianglesDemo();
      case SandboxDemoType.equations:
        return _buildEquationsDemo();
      case SandboxDemoType.sequences:
        return _buildSequencesDemo();
      case SandboxDemoType.matrices:
        return _buildMatricesDemo();
      case SandboxDemoType.money:
        return _buildMoneyDemo();
      case SandboxDemoType.logic:
        return _buildLogicDemo();
      case SandboxDemoType.circles:
        return _buildCirclesDemo();
      case SandboxDemoType.operators:
        return _buildOperatorsDemo();
      case SandboxDemoType.age:
        return _buildAgeDemo();
      case SandboxDemoType.tricks:
        return _buildTricksDemo();
      case SandboxDemoType.mazes:
        return _buildMazesDemo();
      case SandboxDemoType.finalBoss:
        return _buildFinalBossDemo();
    }
  }

  // 1. BODMAS Sandbox
  Widget _buildBodmasDemo() {
    final standardResult = _valA + (_valB * _valC);
    final parenResult = (_valA + _valB) * _valC;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tweak numbers & parentheses to see how evaluation order alters the result:',
          style: TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 12),

        // Steppers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('A', _valA, (v) => setState(() => _valA = v.clamp(1, 20))),
            _buildStepper('B', _valB, (v) => setState(() => _valB = v.clamp(1, 20))),
            _buildStepper('C', _valC, (v) => setState(() => _valC = v.clamp(1, 20))),
          ],
        ),
        const SizedBox(height: 14),

        // Parentheses toggle chip
        Center(
          child: FilterChip(
            selected: _toggleParentheses,
            label: Text(_toggleParentheses ? 'Parentheses ON: (A + B) × C' : 'Standard BODMAS: A + B × C'),
            selectedColor: GameTheme.amberAccent.withValues(alpha: 0.25),
            checkmarkColor: GameTheme.amberAccent,
            backgroundColor: GameTheme.surfaceElevated,
            side: BorderSide(color: _toggleParentheses ? GameTheme.amberAccent : GameTheme.borderSubtle),
            labelStyle: TextStyle(
              color: _toggleParentheses ? GameTheme.amberAccent : GameTheme.textLight,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            onSelected: (val) => setState(() => _toggleParentheses = val),
          ),
        ),
        const SizedBox(height: 14),

        // Live calculation output box
        _buildResultBox(
          expression: _toggleParentheses
              ? '($_valA + $_valB) × $_valC'
              : '$_valA + $_valB × $_valC',
          stepExplanation: _toggleParentheses
              ? 'Step 1: Simplify brackets ($_valA + $_valB) = ${_valA + _valB}\nStep 2: Multiply by $_valC → ${_valA + _valB} × $_valC = $parenResult'
              : 'Step 1: Multiply first ($_valB × $_valC) = ${_valB * _valC}\nStep 2: Add $_valA → $_valA + ${_valB * _valC} = $standardResult',
          result: '${_toggleParentheses ? parenResult : standardResult}',
        ),
      ],
    );
  }

  // 2. Number Patterns Sandbox
  Widget _buildPatternsDemo() {
    final terms = <int>[];
    for (int i = 0; i < 5; i++) {
      if (_selectedRuleIndex == 0) {
        terms.add(_valA + (i * _valB)); // Arithmetic +d
      } else if (_selectedRuleIndex == 1) {
        terms.add(_valA * math.pow(_valB.clamp(2, 4), i).toInt()); // Geometric ×r
      } else {
        terms.add(_valA + (i * i * _valB)); // Quadratic +n²
      }
    }
    final nextTerm = _selectedRuleIndex == 0
        ? _valA + (5 * _valB)
        : _selectedRuleIndex == 1
            ? _valA * math.pow(_valB.clamp(2, 4), 5).toInt()
            : _valA + (25 * _valB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rule selector
        Wrap(
          spacing: 8,
          children: [
            _buildChoiceChip('Arithmetic (+d)', 0),
            _buildChoiceChip('Geometric (×r)', 1),
            _buildChoiceChip('Quadratic (+n²·d)', 2),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Start (a)', _valA, (v) => setState(() => _valA = v.clamp(1, 20))),
            _buildStepper(_selectedRuleIndex == 1 ? 'Ratio (r)' : 'Step (d)', _valB,
                (v) => setState(() => _valB = v.clamp(1, _selectedRuleIndex == 1 ? 4 : 10))),
          ],
        ),
        const SizedBox(height: 14),

        // Live Series Pills
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final t in terms) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: GameTheme.surfaceElevated,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: GameTheme.borderSubtle),
                  ),
                  child: Text('$t', style: const TextStyle(color: GameTheme.textWhite, fontSize: 14, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 8),
              ],
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: GameTheme.amberGlow,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: GameTheme.amberAccent),
                ),
                child: Text('? = $nextTerm', style: const TextStyle(color: GameTheme.amberAccent, fontSize: 14, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. Missing Numbers Sandbox
  Widget _buildMissingNumbersDemo() {
    final missing = _valC - (_valA + _valB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Balance equation: A + [?] + B = Target Sum',
          style: TextStyle(color: GameTheme.textLight, fontSize: 12),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('A', _valA, (v) => setState(() => _valA = v.clamp(1, 15))),
            _buildStepper('B', _valB, (v) => setState(() => _valB = v.clamp(1, 15))),
            _buildStepper('Target Sum', _valC, (v) => setState(() => _valC = v.clamp(_valA + _valB + 1, 50))),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: '$_valA + [?] + $_valB = $_valC',
          stepExplanation: 'Sum known terms: $_valA + $_valB = ${_valA + _valB}\nIsolate unknown: [?] = $_valC - ${_valA + _valB} = $missing',
          result: '$missing',
        ),
      ],
    );
  }

  // 4. Triangles Geometry Sandbox
  Widget _buildTrianglesDemo() {
    final centerMultAdd = (_valA * _valB) + _valC;
    final centerPythagorean = (_valA * _valA) + (_valB * _valB) - (_valC * _valC);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Top', _valA, (v) => setState(() => _valA = v.clamp(1, 12))),
            _buildStepper('Left', _valB, (v) => setState(() => _valB = v.clamp(1, 12))),
            _buildStepper('Right', _valC, (v) => setState(() => _valC = v.clamp(1, 12))),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          children: [
            _buildChoiceChip('(Top × Left) + Right', 0),
            _buildChoiceChip('Top² + Left² - Right²', 1),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: _selectedRuleIndex == 0
              ? '($_valA × $_valB) + $_valC'
              : '$_valA² + $_valB² - $_valC²',
          stepExplanation: _selectedRuleIndex == 0
              ? '($_valA × $_valB) = ${_valA * _valB}, then add $_valC = $centerMultAdd'
              : '($_valA² + $_valB²) = ${_valA * _valA + _valB * _valB}, subtract $_valC² (${_valC * _valC}) = $centerPythagorean',
          result: '${_selectedRuleIndex == 0 ? centerMultAdd : centerPythagorean}',
        ),
      ],
    );
  }

  // 5. Linear Equation Sandbox
  Widget _buildEquationsDemo() {
    // ax + b = c
    final numerator = _valC - _valB;
    final isDivisible = numerator % _valA == 0;
    final root = numerator ~/ _valA;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('a', _valA, (v) => setState(() => _valA = v.clamp(1, 8))),
            _buildStepper('b', _valB, (v) => setState(() => _valB = v.clamp(1, 15))),
            _buildStepper('c', _valC, (v) => setState(() => _valC = v.clamp(_valB + 1, 60))),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: '${_valA}x + $_valB = $_valC',
          stepExplanation: 'Subtract $_valB from both sides: ${_valA}x = $_valC - $_valB = $numerator\nDivide by $_valA: x = $numerator ÷ $_valA${isDivisible ? ' = $root' : ' = ${(numerator / _valA).toStringAsFixed(2)}'}',
          result: isDivisible ? '$root' : (numerator / _valA).toStringAsFixed(2),
        ),
      ],
    );
  }

  // 6. Sequences Sandbox
  Widget _buildSequencesDemo() {
    final fib = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55];
    final squares = [1, 4, 9, 16, 25, 36, 49, 64];

    final isFib = _selectedRuleIndex == 0;
    final series = isFib ? fib.sublist(0, 6) : squares.sublist(0, 6);
    final target = isFib ? fib[6] : squares[6];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: [
            _buildChoiceChip('Fibonacci Recurrence F(n)', 0),
            _buildChoiceChip('Square Sequence n²', 1),
          ],
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final val in series) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: GameTheme.surfaceElevated,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: GameTheme.borderSubtle),
                  ),
                  child: Text('$val', style: const TextStyle(color: GameTheme.textWhite, fontSize: 14, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 8),
              ],
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: GameTheme.amberGlow,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: GameTheme.amberAccent),
                ),
                child: Text('? = $target', style: const TextStyle(color: GameTheme.amberAccent, fontSize: 14, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isFib
              ? 'Rule: Every term equals the sum of previous two: ${series[series.length - 2]} + ${series.last} = $target'
              : 'Rule: Natural numbers squared: 7² = 49',
          style: const TextStyle(color: GameTheme.textMuted, fontSize: 12),
        ),
      ],
    );
  }

  // 7. Matrices Sandbox
  Widget _buildMatricesDemo() {
    final product = _valA * _valB;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Row Col 1', _valA, (v) => setState(() => _valA = v.clamp(1, 10))),
            _buildStepper('Row Col 2', _valB, (v) => setState(() => _valB = v.clamp(1, 10))),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: '[$_valA, $_valB, ?]',
          stepExplanation: 'Row Product Rule: Col 1 × Col 2 = Col 3\n$_valA × $_valB = $product',
          result: '$product',
        ),
      ],
    );
  }

  // 8. Money & Shopping Sandbox
  Widget _buildMoneyDemo() {
    final discountAmount = (_valA * _valB) / 100;
    final finalPrice = _valA - discountAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Price (\$)', _valA, (v) => setState(() => _valA = v.clamp(10, 200))),
            _buildStepper('Discount (%)', _valB, (v) => setState(() => _valB = v.clamp(5, 75))),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: '\$$_valA with $_valB% OFF',
          stepExplanation: 'Discount = \$$_valA × 0.${_valB.toString().padLeft(2, '0')} = \$${discountAmount.toStringAsFixed(1)}\nFinal Price = \$$_valA - \$${discountAmount.toStringAsFixed(1)} = \$${finalPrice.toStringAsFixed(1)}',
          result: '\$${finalPrice.toStringAsFixed(0)}',
        ),
      ],
    );
  }

  // 9. Logic & Digit Deductions Sandbox
  Widget _buildLogicDemo() {
    final numVal = (_valA * 10) + _valB;
    final digitSum = _valA + _valB;
    final isDiv3 = numVal % 3 == 0;
    final isDiv4 = numVal % 4 == 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Tens (t)', _valA, (v) => setState(() => _valA = v.clamp(1, 9))),
            _buildStepper('Units (u)', _valB, (v) => setState(() => _valB = v.clamp(0, 9))),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: 'Number = $numVal',
          stepExplanation: 'Digit Sum (t + u) = $_valA + $_valB = $digitSum\nDivisible by 3: ${isDiv3 ? "YES (digit sum $digitSum is multiple of 3)" : "NO"}\nDivisible by 4: ${isDiv4 ? "YES (last two digits divisible)" : "NO"}',
          result: '$numVal',
        ),
      ],
    );
  }

  // 10. Circles Sandbox
  Widget _buildCirclesDemo() {
    final mean = (_valA + _valB) / 2;
    final geoMean = math.sqrt(_valA * _valB);
    final diffSq = (_valA - _valB) * (_valA - _valB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Left (A)', _valA, (v) => setState(() => _valA = v.clamp(2, 30))),
            _buildStepper('Right (B)', _valB, (v) => setState(() => _valB = v.clamp(2, 30))),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          children: [
            _buildChoiceChip('Arithmetic Mean (A+B)/2', 0),
            _buildChoiceChip('Geometric √(A·B)', 1),
            _buildChoiceChip('Difference-Sq (A-B)²', 2),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: _selectedRuleIndex == 0
              ? '($_valA + $_valB) ÷ 2'
              : _selectedRuleIndex == 1
                  ? '√($_valA × $_valB)'
                  : '($_valA - $_valB)²',
          stepExplanation: _selectedRuleIndex == 0
              ? '($_valA + $_valB) = ${_valA + _valB} ÷ 2 = $mean'
              : _selectedRuleIndex == 1
                  ? '√(${_valA * _valB}) = ${geoMean.toStringAsFixed(2)}'
                  : '($_valA - $_valB) = ${_valA - _valB} squared = $diffSq',
          result: _selectedRuleIndex == 0
              ? '${mean.toInt()}'
              : _selectedRuleIndex == 1
                  ? geoMean.toStringAsFixed(1)
                  : '$diffSq',
        ),
      ],
    );
  }

  // 11. Lateral Operators Sandbox
  Widget _buildOperatorsDemo() {
    final res1 = (2 * _valA) + _valB;
    final res2 = (_valA * _valB) + _valA + _valB;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('a', _valA, (v) => setState(() => _valA = v.clamp(1, 15))),
            _buildStepper('b', _valB, (v) => setState(() => _valB = v.clamp(1, 15))),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          children: [
            _buildChoiceChip('a ★ b = 2a + b', 0),
            _buildChoiceChip('a ⊕ b = ab + a + b', 1),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: _selectedRuleIndex == 0 ? '$_valA ★ $_valB' : '$_valA ⊕ $_valB',
          stepExplanation: _selectedRuleIndex == 0
              ? '(2 × $_valA) + $_valB = ${2 * _valA} + $_valB = $res1'
              : '($_valA × $_valB) + $_valA + $_valB = ${_valA * _valB} + $_valA + $_valB = $res2',
          result: '${_selectedRuleIndex == 0 ? res1 : res2}',
        ),
      ],
    );
  }

  // 12. Age Shift Sandbox
  Widget _buildAgeDemo() {
    final diff = _valA - _valB;
    final futureA = _valA + _valC;
    final futureB = _valB + _valC;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Dad Now', _valA, (v) => setState(() => _valA = v.clamp(20, 60))),
            _buildStepper('Son Now', _valB, (v) => setState(() => _valB = v.clamp(2, 30))),
            _buildStepper('Years (+y)', _valC, (v) => setState(() => _valC = v.clamp(1, 20))),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: 'Age Invariant Difference = $diff years',
          stepExplanation: 'Current Difference: $_valA - $_valB = $diff yrs\nIn $_valC Years: Dad is $futureA, Son is $futureB\nDifference remains exactly: $futureA - $futureB = $diff yrs (Invariant!)',
          result: '$diff yrs',
        ),
      ],
    );
  }

  // 13. Mathematical Tricks Sandbox
  Widget _buildTricksDemo() {
    // Round-trip harmonic speed: 2v1v2 / (v1 + v2)
    final harmonic = (2 * _valA * _valB) / (_valA + _valB);
    final naive = (_valA + _valB) / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Speed 1 (km/h)', _valA, (v) => setState(() => _valA = v.clamp(20, 100))),
            _buildStepper('Speed 2 (km/h)', _valB, (v) => setState(() => _valB = v.clamp(20, 100))),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: 'Round Trip Speed at $_valA and $_valB km/h',
          stepExplanation: 'Harmonic Formula: (2 × $_valA × $_valB) ÷ ($_valA + $_valB)\n= ${2 * _valA * _valB} ÷ ${_valA + _valB} = ${harmonic.toStringAsFixed(1)} km/h\n(Notice: Slower than naive average of ${naive.toStringAsFixed(1)} km/h!)',
          result: '${harmonic.toStringAsFixed(1)} km/h',
        ),
      ],
    );
  }

  // 14. Mazes Sandbox
  Widget _buildMazesDemo() {
    final step1 = _valA + _valB;
    final step2 = step1 * _valC;
    final finalExit = step2 - 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Start', _valA, (v) => setState(() => _valA = v.clamp(1, 20))),
            _buildStepper('Add (+)', _valB, (v) => setState(() => _valB = v.clamp(1, 10))),
            _buildStepper('Mult (×)', _valC, (v) => setState(() => _valC = v.clamp(2, 5))),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: '$_valA → (+$_valB) → (×$_valC) → (-4)',
          stepExplanation: 'Forward: $_valA + $_valB = $step1 → $step1 × $_valC = $step2 → $step2 - 4 = $finalExit\nReverse: $finalExit + 4 = $step2 → $step2 ÷ $_valC = $step1 → $step1 - $_valB = $_valA',
          result: '$finalExit',
        ),
      ],
    );
  }

  // 15. Final Boss Sandbox
  Widget _buildFinalBossDemo() {
    final res = (_valA * _valB) - _valC;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepper('Stage 1 (Δ)', _valA, (v) => setState(() => _valA = v.clamp(10, 20))),
            _buildStepper('Stage 2 (⊞)', _valB, (v) => setState(() => _valB = v.clamp(30, 60))),
            _buildStepper('Stage 3 (F)', _valC, (v) => setState(() => _valC = v.clamp(40, 60))),
          ],
        ),
        const SizedBox(height: 14),
        _buildResultBox(
          expression: '($_valA × $_valB) - $_valC',
          stepExplanation: 'Multiply geometry & matrix terms: $_valA × $_valB = ${_valA * _valB}\nSubtract Fibonacci harmonic: ${_valA * _valB} - $_valC = $res',
          result: '$res',
        ),
      ],
    );
  }

  // Helper UI Builders
  Widget _buildChoiceChip(String label, int index) {
    final isSelected = _selectedRuleIndex == index;
    return ChoiceChip(
      selected: isSelected,
      label: Text(label),
      selectedColor: GameTheme.amberAccent.withValues(alpha: 0.25),
      backgroundColor: GameTheme.surfaceElevated,
      side: BorderSide(color: isSelected ? GameTheme.amberAccent : GameTheme.borderSubtle),
      labelStyle: TextStyle(
        color: isSelected ? GameTheme.amberAccent : GameTheme.textLight,
        fontSize: 11,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      ),
      onSelected: (val) {
        if (val) setState(() => _selectedRuleIndex = index);
      },
    );
  }

  Widget _buildStepper(String label, int value, ValueChanged<int> onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: GameTheme.textMuted, fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: GameTheme.surfaceElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: GameTheme.borderSubtle),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(Icons.remove_rounded, color: GameTheme.amberAccent, size: 16),
                onPressed: () {
                  ref.read(soundServiceProvider).playTap();
                  onChanged(value - 1);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '$value',
                  style: const TextStyle(color: GameTheme.textWhite, fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(Icons.add_rounded, color: GameTheme.amberAccent, size: 16),
                onPressed: () {
                  ref.read(soundServiceProvider).playTap();
                  onChanged(value + 1);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultBox({
    required String expression,
    required String stepExplanation,
    required String result,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: GameTheme.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: GameTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                expression,
                style: const TextStyle(color: GameTheme.amberAccent, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: GameTheme.amberGlow,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '= $result',
                  style: const TextStyle(color: GameTheme.amberAccent, fontSize: 13, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            stepExplanation,
            style: const TextStyle(color: GameTheme.textLight, fontSize: 11, height: 1.45),
          ),
        ],
      ),
    );
  }
}

