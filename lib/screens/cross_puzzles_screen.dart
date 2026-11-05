import 'package:flutter/material.dart';
import '../theme/game_theme.dart';
import '../widgets/custom_keypad.dart';

class CrossPuzzlesScreen extends StatefulWidget {
  const CrossPuzzlesScreen({super.key});

  @override
  State<CrossPuzzlesScreen> createState() => _CrossPuzzlesScreenState();
}

class _CrossPuzzlesScreenState extends State<CrossPuzzlesScreen> {
  String _input = '';
  int _score = 0;
  int _puzzleIndex = 0;

  final List<Map<String, dynamic>> _crossPuzzles = [
    {
      'rows': ['3', '+', '5', '=', '8'],
      'cols': ['3', '×', '2', '=', '6'],
      'target': '8',
    },
    {
      'rows': ['9', '-', '4', '=', '5'],
      'cols': ['9', '÷', '3', '=', '3'],
      'target': '5',
    },
    {
      'rows': ['6', '×', '4', '=', '24'],
      'cols': ['6', '+', '7', '=', '13'],
      'target': '24',
    },
  ];

  void _submit() {
    final current = _crossPuzzles[_puzzleIndex % _crossPuzzles.length];
    if (_input == current['target']) {
      setState(() {
        _score += 10;
        _puzzleIndex++;
        _input = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: GameTheme.surface,
          content: Text('Cross Puzzle Solved! +10 Points', style: TextStyle(color: GameTheme.primaryOrange)),
        ),
      );
    } else {
      setState(() => _input = '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = _crossPuzzles[_puzzleIndex % _crossPuzzles.length];

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'CROSS PUZZLES',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w300,
            letterSpacing: 3.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Score Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PUZZLE ${_puzzleIndex + 1}',
                    style: const TextStyle(color: GameTheme.textLightGrey, fontWeight: FontWeight.w400, letterSpacing: 1.5),
                  ),
                  Text(
                    'SCORE: $_score',
                    style: const TextStyle(color: GameTheme.primaryOrange, fontWeight: FontWeight.w700, letterSpacing: 1.0),
                  ),
                ],
              ),
            ),

            // Cross Stage
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: GameTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: GameTheme.borderDivider),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Horizontal Equation:',
                        style: TextStyle(color: GameTheme.textMuted, fontSize: 12, letterSpacing: 1.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${current['rows'][0]} ${current['rows'][1]} ${current['rows'][2]} = ${_input.isEmpty ? '?' : _input}',
                        style: const TextStyle(
                          color: GameTheme.textWhite,
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const Divider(color: GameTheme.borderDivider, height: 32),
                      const Text(
                        'Intersecting Column Equation:',
                        style: TextStyle(color: GameTheme.textMuted, fontSize: 12, letterSpacing: 1.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${current['cols'][0]} ${current['cols'][1]} ${current['cols'][2]} = ${current['cols'][4]}',
                        style: const TextStyle(
                          color: GameTheme.primaryOrange,
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Inbuilt Keypad
            CustomKeypad(
              inputString: _input,
              onDigitPressed: (digit) {
                if (_input.length < 5) setState(() => _input += digit);
              },
              onClear: () => setState(() => _input = ''),
              onHintPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Calculate the horizontal result matching the intersecting column.')),
                );
              },
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

