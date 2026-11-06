import 'package:flutter/material.dart';
import 'sandbox_controls.dart';

/// 1. Linear Equations Interactive Sandbox
class EquationsDemoWidget extends StatefulWidget {
  const EquationsDemoWidget({super.key});

  @override
  State<EquationsDemoWidget> createState() => _EquationsDemoWidgetState();
}

class _EquationsDemoWidgetState extends State<EquationsDemoWidget> {
  int _valA = 3; // a
  int _valB = 5; // b
  int _valC = 26; // c (3x + 5 = 26 -> x = 7)

  @override
  Widget build(BuildContext context) {
    final numerator = _valC - _valB;
    final isDivisible = numerator % _valA == 0;
    final root = numerator ~/ _valA;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'a', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(1, 8))),
            SandboxStepper(label: 'b', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(1, 15))),
            SandboxStepper(label: 'c', value: _valC, onChanged: (v) => setState(() => _valC = v.clamp(_valB + 1, 60))),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: '${_valA}x + $_valB = $_valC',
          stepExplanation: 'Subtract $_valB from both sides: ${_valA}x = $_valC - $_valB = $numerator\nDivide by $_valA: x = $numerator ÷ $_valA${isDivisible ? ' = $root' : ' = ${(numerator / _valA).toStringAsFixed(2)}'}',
          result: isDivisible ? '$root' : (numerator / _valA).toStringAsFixed(2),
        ),
      ],
    );
  }
}

/// 2. Money & Shopping Interactive Sandbox
class MoneyDemoWidget extends StatefulWidget {
  const MoneyDemoWidget({super.key});

  @override
  State<MoneyDemoWidget> createState() => _MoneyDemoWidgetState();
}

class _MoneyDemoWidgetState extends State<MoneyDemoWidget> {
  int _valA = 80; // Price
  int _valB = 25; // Discount %

  @override
  Widget build(BuildContext context) {
    final discountAmount = (_valA * _valB) / 100;
    final finalPrice = _valA - discountAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'Price (\$)', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(10, 200))),
            SandboxStepper(label: 'Discount (%)', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(5, 75))),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: '\$$_valA with $_valB% OFF',
          stepExplanation: 'Discount = \$$_valA × 0.${_valB.toString().padLeft(2, '0')} = \$${discountAmount.toStringAsFixed(1)}\nFinal Price = \$$_valA - \$${discountAmount.toStringAsFixed(1)} = \$${finalPrice.toStringAsFixed(1)}',
          result: '\$${finalPrice.toStringAsFixed(0)}',
        ),
      ],
    );
  }
}

/// 3. Logic & Number Deduction Interactive Sandbox
class LogicDemoWidget extends StatefulWidget {
  const LogicDemoWidget({super.key});

  @override
  State<LogicDemoWidget> createState() => _LogicDemoWidgetState();
}

class _LogicDemoWidgetState extends State<LogicDemoWidget> {
  int _valA = 3; // tens digit
  int _valB = 6; // units digit -> 36

  @override
  Widget build(BuildContext context) {
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
            SandboxStepper(label: 'Tens (t)', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(1, 9))),
            SandboxStepper(label: 'Units (u)', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(0, 9))),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: 'Number = $numVal',
          stepExplanation: 'Digit Sum (t + u) = $_valA + $_valB = $digitSum\nDivisible by 3: ${isDiv3 ? "YES (digit sum $digitSum is multiple of 3)" : "NO"}\nDivisible by 4: ${isDiv4 ? "YES (last two digits divisible)" : "NO"}',
          result: '$numVal',
        ),
      ],
    );
  }
}

/// 4. Age Shift & Invariants Interactive Sandbox
class AgeDemoWidget extends StatefulWidget {
  const AgeDemoWidget({super.key});

  @override
  State<AgeDemoWidget> createState() => _AgeDemoWidgetState();
}

class _AgeDemoWidgetState extends State<AgeDemoWidget> {
  int _valA = 30; // Dad now
  int _valB = 10; // Son now
  int _valC = 5; // Year shift

  @override
  Widget build(BuildContext context) {
    final diff = _valA - _valB;
    final futureA = _valA + _valC;
    final futureB = _valB + _valC;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'Dad Now', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(20, 60))),
            SandboxStepper(label: 'Son Now', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(2, 30))),
            SandboxStepper(label: 'Years (+y)', value: _valC, onChanged: (v) => setState(() => _valC = v.clamp(1, 20))),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: 'Age Invariant Difference = $diff years',
          stepExplanation: 'Current Difference: $_valA - $_valB = $diff yrs\nIn $_valC Years: Dad is $futureA, Son is $futureB\nDifference remains exactly: $futureA - $futureB = $diff yrs (Invariant!)',
          result: '$diff yrs',
        ),
      ],
    );
  }
}
