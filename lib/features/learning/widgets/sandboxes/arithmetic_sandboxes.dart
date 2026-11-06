import 'package:flutter/material.dart';
import '../../../../theme/game_theme.dart';
import 'sandbox_controls.dart';

/// 1. BODMAS Interactive Sandbox
class BodmasDemoWidget extends StatefulWidget {
  const BodmasDemoWidget({super.key});

  @override
  State<BodmasDemoWidget> createState() => _BodmasDemoWidgetState();
}

class _BodmasDemoWidgetState extends State<BodmasDemoWidget> {
  int _valA = 6;
  int _valB = 2;
  int _valC = 3;
  bool _toggleParentheses = false;

  @override
  Widget build(BuildContext context) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'A', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(1, 20))),
            SandboxStepper(label: 'B', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(1, 20))),
            SandboxStepper(label: 'C', value: _valC, onChanged: (v) => setState(() => _valC = v.clamp(1, 20))),
          ],
        ),
        const SizedBox(height: 14),
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
        SandboxResultBox(
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
}

/// 2. Missing Numbers Interactive Sandbox
class MissingNumbersDemoWidget extends StatefulWidget {
  const MissingNumbersDemoWidget({super.key});

  @override
  State<MissingNumbersDemoWidget> createState() => _MissingNumbersDemoWidgetState();
}

class _MissingNumbersDemoWidgetState extends State<MissingNumbersDemoWidget> {
  int _valA = 7;
  int _valB = 5;
  int _valC = 20; // target sum

  @override
  Widget build(BuildContext context) {
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
            SandboxStepper(label: 'A', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(1, 15))),
            SandboxStepper(label: 'B', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(1, 15))),
            SandboxStepper(
              label: 'Target Sum',
              value: _valC,
              onChanged: (v) => setState(() => _valC = v.clamp(_valA + _valB + 1, 50)),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: '$_valA + [?] + $_valB = $_valC',
          stepExplanation: 'Sum known terms: $_valA + $_valB = ${_valA + _valB}\nIsolate unknown: [?] = $_valC - ${_valA + _valB} = $missing',
          result: '$missing',
        ),
      ],
    );
  }
}

/// 3. Lateral Operators Interactive Sandbox
class OperatorsDemoWidget extends StatefulWidget {
  const OperatorsDemoWidget({super.key});

  @override
  State<OperatorsDemoWidget> createState() => _OperatorsDemoWidgetState();
}

class _OperatorsDemoWidgetState extends State<OperatorsDemoWidget> {
  int _valA = 4;
  int _valB = 5;
  int _selectedRuleIndex = 0;

  @override
  Widget build(BuildContext context) {
    final res1 = (2 * _valA) + _valB;
    final res2 = (_valA * _valB) + _valA + _valB;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'a', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(1, 15))),
            SandboxStepper(label: 'b', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(1, 15))),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          children: [
            SandboxChoiceChip(
              label: 'a ★ b = 2a + b',
              isSelected: _selectedRuleIndex == 0,
              onSelected: () => setState(() => _selectedRuleIndex = 0),
            ),
            SandboxChoiceChip(
              label: 'a ⊕ b = ab + a + b',
              isSelected: _selectedRuleIndex == 1,
              onSelected: () => setState(() => _selectedRuleIndex = 1),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: _selectedRuleIndex == 0 ? '$_valA ★ $_valB' : '$_valA ⊕ $_valB',
          stepExplanation: _selectedRuleIndex == 0
              ? '(2 × $_valA) + $_valB = ${2 * _valA} + $_valB = $res1'
              : '($_valA × $_valB) + $_valA + $_valB = ${_valA * _valB} + $_valA + $_valB = $res2',
          result: '${_selectedRuleIndex == 0 ? res1 : res2}',
        ),
      ],
    );
  }
}

/// 4. Mathematical Tricks Interactive Sandbox
class TricksDemoWidget extends StatefulWidget {
  const TricksDemoWidget({super.key});

  @override
  State<TricksDemoWidget> createState() => _TricksDemoWidgetState();
}

class _TricksDemoWidgetState extends State<TricksDemoWidget> {
  int _valA = 60; // v1
  int _valB = 40; // v2

  @override
  Widget build(BuildContext context) {
    // Round-trip harmonic speed: 2v1v2 / (v1 + v2)
    final harmonic = (2 * _valA * _valB) / (_valA + _valB);
    final naive = (_valA + _valB) / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'Speed 1 (km/h)', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(20, 100))),
            SandboxStepper(label: 'Speed 2 (km/h)', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(20, 100))),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: 'Round Trip Speed at $_valA and $_valB km/h',
          stepExplanation: 'Harmonic Formula: (2 × $_valA × $_valB) ÷ ($_valA + $_valB)\n= ${2 * _valA * _valB} ÷ ${_valA + _valB} = ${harmonic.toStringAsFixed(1)} km/h\n(Notice: Slower than naive average of ${naive.toStringAsFixed(1)} km/h!)',
          result: '${harmonic.toStringAsFixed(1)} km/h',
        ),
      ],
    );
  }
}

