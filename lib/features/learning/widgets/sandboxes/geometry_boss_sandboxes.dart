import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'sandbox_controls.dart';

/// 1. Triangles Interactive Sandbox
class TrianglesDemoWidget extends StatefulWidget {
  const TrianglesDemoWidget({super.key});

  @override
  State<TrianglesDemoWidget> createState() => _TrianglesDemoWidgetState();
}

class _TrianglesDemoWidgetState extends State<TrianglesDemoWidget> {
  int _valA = 4; // Top
  int _valB = 6; // Left
  int _valC = 3; // Right
  int _selectedRuleIndex = 0;

  @override
  Widget build(BuildContext context) {
    final centerMultAdd = (_valA * _valB) + _valC;
    final centerPythagorean = (_valA * _valA) + (_valB * _valB) - (_valC * _valC);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'Top', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(1, 12))),
            SandboxStepper(label: 'Left', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(1, 12))),
            SandboxStepper(label: 'Right', value: _valC, onChanged: (v) => setState(() => _valC = v.clamp(1, 12))),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          children: [
            SandboxChoiceChip(
              label: '(Top × Left) + Right',
              isSelected: _selectedRuleIndex == 0,
              onSelected: () => setState(() => _selectedRuleIndex = 0),
            ),
            SandboxChoiceChip(
              label: 'Top² + Left² - Right²',
              isSelected: _selectedRuleIndex == 1,
              onSelected: () => setState(() => _selectedRuleIndex = 1),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
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
}

/// 2. Intersecting Circles Interactive Sandbox
class CirclesDemoWidget extends StatefulWidget {
  const CirclesDemoWidget({super.key});

  @override
  State<CirclesDemoWidget> createState() => _CirclesDemoWidgetState();
}

class _CirclesDemoWidgetState extends State<CirclesDemoWidget> {
  int _valA = 12; // Left
  int _valB = 18; // Right
  int _selectedRuleIndex = 0; // 0: Mean, 1: Geo-Mean, 2: Diff-Sq

  @override
  Widget build(BuildContext context) {
    final mean = (_valA + _valB) / 2;
    final geoMean = math.sqrt(_valA * _valB);
    final diffSq = (_valA - _valB) * (_valA - _valB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'Left (A)', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(2, 30))),
            SandboxStepper(label: 'Right (B)', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(2, 30))),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          children: [
            SandboxChoiceChip(
              label: 'Arithmetic Mean (A+B)/2',
              isSelected: _selectedRuleIndex == 0,
              onSelected: () => setState(() => _selectedRuleIndex = 0),
            ),
            SandboxChoiceChip(
              label: 'Geometric √(A·B)',
              isSelected: _selectedRuleIndex == 1,
              onSelected: () => setState(() => _selectedRuleIndex = 1),
            ),
            SandboxChoiceChip(
              label: 'Difference-Sq (A-B)²',
              isSelected: _selectedRuleIndex == 2,
              onSelected: () => setState(() => _selectedRuleIndex = 2),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
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
}

/// 3. Grand Singularity Boss Interactive Sandbox
class FinalBossDemoWidget extends StatefulWidget {
  const FinalBossDemoWidget({super.key});

  @override
  State<FinalBossDemoWidget> createState() => _FinalBossDemoWidgetState();
}

class _FinalBossDemoWidgetState extends State<FinalBossDemoWidget> {
  int _valA = 14; // Stage 1
  int _valB = 45; // Stage 2
  int _valC = 55; // F(10)

  @override
  Widget build(BuildContext context) {
    final res = (_valA * _valB) - _valC;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SandboxStepper(label: 'Stage 1 (Δ)', value: _valA, onChanged: (v) => setState(() => _valA = v.clamp(10, 20))),
            SandboxStepper(label: 'Stage 2 (⊞)', value: _valB, onChanged: (v) => setState(() => _valB = v.clamp(30, 60))),
            SandboxStepper(label: 'Stage 3 (F)', value: _valC, onChanged: (v) => setState(() => _valC = v.clamp(40, 60))),
          ],
        ),
        const SizedBox(height: 14),
        SandboxResultBox(
          expression: '($_valA × $_valB) - $_valC',
          stepExplanation: 'Multiply geometry & matrix terms: $_valA × $_valB = ${_valA * _valB}\nSubtract Fibonacci harmonic: ${_valA * _valB} - $_valC = $res',
          result: '$res',
        ),
      ],
    );
  }
}

