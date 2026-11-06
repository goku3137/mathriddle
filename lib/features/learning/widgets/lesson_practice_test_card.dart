import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/game_controller.dart';
import '../../../models/lesson_model.dart';
import '../../../services/sound_service.dart';
import '../../../theme/game_theme.dart';

/// Self-contained Interactive Practice Test card for testing mathematical mastery.
class LessonPracticeTestCard extends ConsumerStatefulWidget {
  final Lesson lesson;

  const LessonPracticeTestCard({
    super.key,
    required this.lesson,
  });

  @override
  ConsumerState<LessonPracticeTestCard> createState() => _LessonPracticeTestCardState();
}

class _LessonPracticeTestCardState extends ConsumerState<LessonPracticeTestCard> {
  String? _selectedOption;
  bool _isAnswerChecked = false;
  bool _isCorrect = false;
  bool _showHint = false;

  void _checkAnswer() async {
    if (_selectedOption == null) return;

    final isCorrect = _selectedOption == widget.lesson.practiceQuestion.correctAnswer;
    setState(() {
      _isAnswerChecked = true;
      _isCorrect = isCorrect;
    });

    if (isCorrect) {
      ref.read(soundServiceProvider).playCorrect();
      final granted = await ref
          .read(gameControllerProvider.notifier)
          .completeLearnTopic(widget.lesson.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: GameTheme.surfaceElevated,
            duration: const Duration(seconds: 3),
            content: Row(
              children: [
                const Icon(Icons.stars_rounded, color: GameTheme.amberAccent, size: 20),
                const SizedBox(width: 8),
                Text(
                  granted
                      ? 'Concept Mastered! +50 PTS Added to Total Score!'
                      : 'Concept Mastered! (Points already claimed)',
                  style: const TextStyle(color: GameTheme.textWhite, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      ref.read(soundServiceProvider).playIncorrect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _isAnswerChecked
              ? (_isCorrect ? GameTheme.successGreen : GameTheme.errorRed)
              : GameTheme.borderActive,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PRACTICE QUESTION',
                style: TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: GameTheme.amberGlow,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '+50 PTS REWARD',
                  style: TextStyle(
                    color: GameTheme.amberAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.lesson.practiceQuestion.question,
            style: const TextStyle(
              color: GameTheme.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Option Selector Chips
          if (widget.lesson.practiceQuestion.options != null) ...[
            ...widget.lesson.practiceQuestion.options!.map((option) {
              final isSelected = _selectedOption == option;
              final isCorrectOption = option == widget.lesson.practiceQuestion.correctAnswer;

              Color borderColor = GameTheme.borderSubtle;
              Color bgColor = GameTheme.surfaceElevated;
              Color textColor = GameTheme.textLight;

              if (_isAnswerChecked) {
                if (isCorrectOption) {
                  borderColor = GameTheme.successGreen;
                  bgColor = GameTheme.successGreen.withValues(alpha: 0.15);
                  textColor = GameTheme.successGreen;
                } else if (isSelected && !_isCorrect) {
                  borderColor = GameTheme.errorRed;
                  bgColor = GameTheme.errorRed.withValues(alpha: 0.15);
                  textColor = GameTheme.errorRed;
                }
              } else if (isSelected) {
                borderColor = GameTheme.amberAccent;
                bgColor = GameTheme.amberGlow;
                textColor = GameTheme.amberAccent;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: _isAnswerChecked
                      ? null
                      : () {
                          ref.read(soundServiceProvider).playTap();
                          setState(() => _selectedOption = option);
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? (_isAnswerChecked
                                  ? (_isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded)
                                  : Icons.radio_button_checked_rounded)
                              : Icons.radio_button_off_rounded,
                          color: textColor,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
          const SizedBox(height: 8),

          // Action Buttons: Submit & Hint
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GameTheme.amberAccent,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    disabledBackgroundColor: GameTheme.surfaceElevated,
                  ),
                  onPressed: _selectedOption != null ? _checkAnswer : null,
                  child: const Text(
                    'SUBMIT ANSWER',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: GameTheme.borderSubtle),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  ref.read(soundServiceProvider).playTap();
                  setState(() {
                    _showHint = !_showHint;
                  });
                },
                icon: const Icon(Icons.lightbulb_outline_rounded, color: GameTheme.amberAccent, size: 18),
                label: Text(
                  _showHint ? 'HIDE HINT' : 'HINT',
                  style: const TextStyle(color: GameTheme.amberAccent, fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),

          // Hint Box
          if (_showHint) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: GameTheme.surfaceElevated,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded, color: GameTheme.amberAccent, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.lesson.practiceQuestion.hint,
                      style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Solution Explanation Box
          if (_isAnswerChecked) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _isCorrect
                    ? GameTheme.successGreen.withValues(alpha: 0.1)
                    : GameTheme.errorRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _isCorrect
                      ? GameTheme.successGreen.withValues(alpha: 0.5)
                      : GameTheme.errorRed.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                        color: _isCorrect ? GameTheme.successGreen : GameTheme.errorRed,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isCorrect ? 'EXCELLENT! ANSWER CORRECT' : 'INCORRECT. TRY AGAIN!',
                        style: TextStyle(
                          color: _isCorrect ? GameTheme.successGreen : GameTheme.errorRed,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.lesson.practiceQuestion.explanation,
                    style: const TextStyle(color: GameTheme.textWhite, fontSize: 12, height: 1.4),
                  ),
                  if (!_isCorrect &&
                      widget.lesson.practiceQuestion.wrongOptionExplanations != null &&
                      _selectedOption != null &&
                      widget.lesson.practiceQuestion.wrongOptionExplanations!.containsKey(_selectedOption!)) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: GameTheme.surface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.lesson.practiceQuestion.wrongOptionExplanations![_selectedOption!]!,
                        style: const TextStyle(color: GameTheme.amberAccent, fontSize: 11, height: 1.35),
                      ),
                    ),
                  ],
                  if (widget.lesson.practiceQuestion.stepByStepGuidance != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Guided Step: ${widget.lesson.practiceQuestion.stepByStepGuidance!}',
                      style: const TextStyle(color: GameTheme.textMuted, fontSize: 11, fontStyle: FontStyle.italic),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

