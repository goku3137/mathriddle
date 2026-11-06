import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/game_controller.dart';
import '../../../models/lesson_model.dart';
import '../../../services/sound_service.dart';
import '../../../theme/learning_theme.dart';

/// Readability-first interactive practice test widget for verifying mathematical mastery.
/// Conforms to WCAG AAA contrast guidelines with large touch targets (≥ 48px).
class LessonPracticeTestCard extends ConsumerStatefulWidget {
  final Lesson lesson;
  final bool useReadabilityTheme;

  const LessonPracticeTestCard({
    super.key,
    required this.lesson,
    this.useReadabilityTheme = true,
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
            backgroundColor: LearningTheme.textPrimary,
            duration: const Duration(seconds: 3),
            content: Row(
              children: [
                const Icon(Icons.stars_rounded, color: Color(0xFFF59E0B), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    granted
                        ? 'Concept Mastered! +50 PTS Added to Total Score!'
                        : 'Concept Mastered! (Points already claimed)',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
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
        color: LearningTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _isAnswerChecked
              ? (_isCorrect ? LearningTheme.correctGreen : LearningTheme.wrongRed)
              : LearningTheme.border,
          width: 1.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
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
                  color: LearningTheme.stageBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: LearningTheme.stageBlueBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '+50 PTS REWARD',
                  style: TextStyle(
                    color: LearningTheme.stageBlue,
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
              color: LearningTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Option Selector Chips (Touch target >= 48px)
          if (widget.lesson.practiceQuestion.options != null) ...[
            ...widget.lesson.practiceQuestion.options!.map((option) {
              final isSelected = _selectedOption == option;
              final isCorrectOption = option == widget.lesson.practiceQuestion.correctAnswer;

              Color borderColor = LearningTheme.border;
              Color bgColor = LearningTheme.surface;
              Color textColor = LearningTheme.textPrimary;

              if (_isAnswerChecked) {
                if (isCorrectOption) {
                  borderColor = LearningTheme.correctGreen;
                  bgColor = LearningTheme.correctBg;
                  textColor = LearningTheme.correctGreen;
                } else if (isSelected && !_isCorrect) {
                  borderColor = LearningTheme.wrongRed;
                  bgColor = LearningTheme.wrongBg;
                  textColor = LearningTheme.wrongRed;
                }
              } else if (isSelected) {
                borderColor = LearningTheme.stageBlue;
                bgColor = LearningTheme.stageBlueBg;
                textColor = LearningTheme.stageBlue;
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
                    constraints: const BoxConstraints(minHeight: 48),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: borderColor, width: isSelected ? 1.8 : 1.0),
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
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 15,
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
                    backgroundColor: LearningTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    disabledBackgroundColor: LearningTheme.border,
                  ),
                  onPressed: (_selectedOption != null && !_isAnswerChecked) ? _checkAnswer : null,
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
                  side: const BorderSide(color: LearningTheme.border),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  ref.read(soundServiceProvider).playTap();
                  setState(() {
                    _showHint = !_showHint;
                  });
                },
                icon: const Icon(Icons.lightbulb_outline_rounded, color: LearningTheme.stageBlue, size: 18),
                label: Text(
                  _showHint ? 'HIDE HINT' : 'HINT',
                  style: const TextStyle(color: LearningTheme.stageBlue, fontSize: 12, fontWeight: FontWeight.w700),
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
                color: LearningTheme.surfaceSubtle,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: LearningTheme.stageBlue.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded, color: LearningTheme.stageBlue, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.lesson.practiceQuestion.hint,
                      style: const TextStyle(color: LearningTheme.textSecondary, fontSize: 13, height: 1.4),
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
                color: _isCorrect ? LearningTheme.correctBg : LearningTheme.wrongBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _isCorrect ? LearningTheme.correctGreen : LearningTheme.wrongRed,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                        color: _isCorrect ? LearningTheme.correctGreen : LearningTheme.wrongRed,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isCorrect ? 'EXCELLENT! ANSWER CORRECT' : 'INCORRECT. TRY AGAIN!',
                        style: TextStyle(
                          color: _isCorrect ? LearningTheme.correctGreen : LearningTheme.wrongRed,
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
                    style: const TextStyle(color: LearningTheme.textPrimary, fontSize: 13, height: 1.45),
                  ),
                  if (!_isCorrect &&
                      widget.lesson.practiceQuestion.wrongOptionExplanations != null &&
                      _selectedOption != null &&
                      widget.lesson.practiceQuestion.wrongOptionExplanations!.containsKey(_selectedOption!)) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: LearningTheme.wrongRed.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        widget.lesson.practiceQuestion.wrongOptionExplanations![_selectedOption!]!,
                        style: const TextStyle(color: LearningTheme.wrongRed, fontSize: 12, height: 1.35),
                      ),
                    ),
                  ],
                  if (widget.lesson.practiceQuestion.stepByStepGuidance != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Guided Step: ${widget.lesson.practiceQuestion.stepByStepGuidance!}',
                      style: const TextStyle(color: LearningTheme.textMuted, fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ],
                  if (!_isCorrect) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LearningTheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          ref.read(soundServiceProvider).playTap();
                          setState(() {
                            _isAnswerChecked = false;
                            _selectedOption = null;
                          });
                        },
                        icon: const Icon(Icons.refresh_rounded, size: 16),
                        label: const Text(
                          'TRY AGAIN',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                        ),
                      ),
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
