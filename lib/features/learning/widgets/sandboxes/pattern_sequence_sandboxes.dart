import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../theme/game_theme.dart';
import 'sandbox_controls.dart';

/// 1. Number Patterns Interactive Sandbox
class PatternsDemoWidget extends StatefulWidget {
  const PatternsDemoWidget({super.key});

  @override
  State<PatternsDemoWidget> createState() => _PatternsDemoWidgetState();
}

class _PatternsDemoWidgetState extends State<PatternsDemoWidget> {
  int _valA = 3; // start
  int _valB = 4; // step
  int _selectedRuleIndex = 0; // 0: +d, 1: ×r, 2: +n²

  @override
  Widget build(BuildContext context) {
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
        Wrap(
          spacing: 8,
          children: [
            SandboxChoiceChip(
              label: 'Arithmetic (+d)',
              isSelected: _selectedRuleIndex == 0,
              onSelected: () => setState(() => _selectedRuleIndex = 0),
            ),
            SandboxChoiceChip(
              label: 'Geometric (×r)',
              isSelected: _selectedRuleIndex == 1,
              onSelected: () => setState(() => _selectedRuleIndex = 1),
            ),
            SandboxChoiceChip(
              label: 'Quadratic (+n²·d)',
              isSelected: _selectedRuleIndex == 2,
              onSelected: () => setState(() => _selectedRuleIndex = 2),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'Start (a)', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(1, 20))),
            SandboxStepper(
              label: _selectedRuleIndex == 1 ? 'Ratio (r)' : 'Step (d)',
              value: _valB,
              onChanged: (v) => setState(() => _valB = v.clamp(1, _selectedRuleIndex == 1 ? 4 : 10)),
            ),
          ],
        ),
        const SizedBox(height: 14),
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
}

/// 2. Sequences & Series Interactive Sandbox
class SequencesDemoWidget extends StatefulWidget {
  const SequencesDemoWidget({super.key});

  @override
  State<SequencesDemoWidget> createState() => _SequencesDemoWidgetState();
}

class _SequencesDemoWidgetState extends State<SequencesDemoWidget> {
  int _selectedRuleIndex = 0;

  @override
  Widget build(BuildContext context) {
    const fib = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55];
    const squares = [1, 4, 9, 16, 25, 36, 49, 64];

    final isFib = _selectedRuleIndex == 0;
    final series = isFib ? fib.sublist(0, 6) : squares.sublist(0, 6);
    final target = isFib ? fib[6] : squares[6];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: [
            SandboxChoiceChip(
              label: 'Fibonacci Recurrence F(n)',
              isSelected: _selectedRuleIndex == 0,
              onSelected: () => setState(() => _selectedRuleIndex = 0),
            ),
            SandboxChoiceChip(
              label: 'Square Sequence n²',
              isSelected: _selectedRuleIndex == 1,
              onSelected: () => setState(() => _selectedRuleIndex = 1),
            ),
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
}

/// 3. Matrix & Numeric Grids Interactive Sandbox
class MatricesDemoWidget extends StatefulWidget {
  const MatricesDemoWidget({super.key});

  @override
  State<MatricesDemoWidget> createState() => _MatricesDemoWidgetState();
}

class _MatricesDemoWidgetState extends State<MatricesDemoWidget> {
  int _valA = 4;
  int _valB = 6;

  @override
  Widget build(BuildContext context) {
    final product = _valA * _valB;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'Row Col 1', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(1, 10))),
            SandboxStepper(label: 'Row Col 2', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(1, 10))),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: '[$_valA, $_valB, ?]',
          stepExplanation: 'Row Product Rule: Col 1 × Col 2 = Col 3\n$_valA × $_valB = $product',
          result: '$product',
        ),
      ],
    );
  }
}

/// 4. Number Mazes Interactive Sandbox
class MazesDemoWidget extends StatefulWidget {
  const MazesDemoWidget({super.key});

  @override
  State<MazesDemoWidget> createState() => _MazesDemoWidgetState();
}

class _MazesDemoWidgetState extends State<MazesDemoWidget> {
  int _valA = 5; // Start
  int _valB = 3; // op1 add
  int _valC = 2; // op2 mult

  @override
  Widget build(BuildContext context) {
    final step1 = _valA + _valB;
    final step2 = step1 * _valC;
    final finalExit = step2 - 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'Start', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(1, 20))),
            SandboxStepper(label: 'Add (+)', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(1, 10))),
            SandboxStepper(label: 'Mult (×)', value: _valC, onChanged: (v) => setState(() => _valC = v.clamp(2, 5))),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: '$_valA → (+$_valB) → (×$_valC) → (-4)',
          stepExplanation: 'Forward: $_valA + $_valB = $step1 → $step1 × $_valC = $step2 → $step2 - 4 = $finalExit\nReverse: $finalExit + 4 = $step2 → $step2 ÷ $_valC = $step1 → $step1 - $_valB = $_valA',
          result: '$finalExit',
        ),
      ],
    );
  }
}
