import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../models/lesson_model.dart';
import '../theme/game_theme.dart';
import '../widgets/interactive_lesson_sandbox.dart';
import '../widgets/score_badge.dart';
import 'riddle_screen.dart';

class LessonDetailScreen extends ConsumerStatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({
    super.key,
    required this.lesson,
  });

  @override
  ConsumerState<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends ConsumerState<LessonDetailScreen> {
  int _activeExampleIndex = 0;
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
    }
  }

  void _navigateToLevel(int levelNumber) async {
    await ref.read(gameControllerProvider.notifier).selectLevel(levelNumber);
    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const RiddleScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch game controller state to reactively reflect score and mastery status
    ref.watch(gameControllerProvider);
    final progress = ref.watch(progressServiceProvider);
    final isAlreadyCompleted = progress.isLearnTopicCompleted(widget.lesson.id);

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.lesson.category.toUpperCase(),
          style: const TextStyle(
            color: GameTheme.textWhite,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: ScoreBadge(compact: true),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // 1. Header Banner
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isAlreadyCompleted
                        ? GameTheme.successGreen.withValues(alpha: 0.15)
                        : GameTheme.amberGlow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isAlreadyCompleted
                          ? GameTheme.successGreen.withValues(alpha: 0.4)
                          : GameTheme.amberAccent.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Icon(
                    isAlreadyCompleted ? Icons.check_circle_rounded : widget.lesson.icon,
                    color: isAlreadyCompleted ? GameTheme.successGreen : GameTheme.amberAccent,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.lesson.chapter.toUpperCase(),
                        style: const TextStyle(
                          color: GameTheme.amberAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.lesson.title,
                        style: const TextStyle(
                          color: GameTheme.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: GameTheme.surfaceElevated,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: GameTheme.borderSubtle),
                            ),
                            child: Text(
                              widget.lesson.difficulty,
                              style: const TextStyle(
                                color: GameTheme.amberAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (isAlreadyCompleted)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: GameTheme.successGreen.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: GameTheme.successGreen.withValues(alpha: 0.4)),
                              ),
                              child: const Text(
                                'MASTERED (+50 PTS)',
                                style: TextStyle(
                                  color: GameTheme.successGreen,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // 2. Concept Summary
            Text(
              widget.lesson.conceptSummary,
              style: const TextStyle(
                color: GameTheme.textLight,
                fontSize: 14,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18),

            // 3. Formula Highlight Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: GameTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.5), width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.functions_rounded, color: GameTheme.amberAccent, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'CORE FORMULA & SHORTCUT',
                        style: TextStyle(
                          color: GameTheme.amberAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.lesson.formula,
                    style: const TextStyle(
                      color: GameTheme.textWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // 4. The Four Pillars of Mathematical Mastery
            _buildSectionHeader('THE FOUR PILLARS OF MASTERY', Icons.account_balance_rounded),
            const SizedBox(height: 10),
            _buildFourPillarsCard(),
            const SizedBox(height: 22),

            // 5. Real-Time Interactive Demonstration Sandbox
            InteractiveLessonSandbox(demoType: widget.lesson.sandboxType),
            const SizedBox(height: 22),

            // 6. Step-by-Step Educational Explanation
            _buildSectionHeader('STEP-BY-STEP REASONING', Icons.menu_book_rounded),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: GameTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: GameTheme.borderSubtle),
              ),
              child: Text(
                widget.lesson.stepByStepExplanation,
                style: const TextStyle(
                  color: GameTheme.textWhite,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 22),

            // 7. Worked Walkthrough (Multiple Graded Examples: Easy to Challenging)
            _buildSectionHeader('WORKED WALKTHROUGH', Icons.psychology_alt_rounded),
            const SizedBox(height: 10),
            _buildGradedWorkedExamples(),
            const SizedBox(height: 22),

            // 8. Deep Insights: Common Mistakes, Shortcuts & Alternative Methods
            _buildSectionHeader('COMMON TRAPS & PRO SHORTCUTS', Icons.tips_and_updates_rounded),
            const SizedBox(height: 10),
            _buildDeepInsightsCard(),
            const SizedBox(height: 24),

            // 9. Linked Game Levels Section
            _buildSectionHeader('APPLIED IN GAME LEVELS', Icons.play_arrow_rounded),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.lesson.linkedLevels.map((lvl) {
                final isUnlocked = lvl <= progress.unlockedLevelIndex;
                return ActionChip(
                  backgroundColor: isUnlocked ? GameTheme.surface : GameTheme.surfaceElevated,
                  side: BorderSide(
                    color: isUnlocked ? GameTheme.amberAccent.withValues(alpha: 0.5) : GameTheme.borderSubtle,
                  ),
                  avatar: Icon(
                    isUnlocked ? Icons.lock_open_rounded : Icons.lock_rounded,
                    color: isUnlocked ? GameTheme.amberAccent : GameTheme.textMuted,
                    size: 14,
                  ),
                  label: Text(
                    'Level $lvl',
                    style: TextStyle(
                      color: isUnlocked ? GameTheme.textWhite : GameTheme.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: isUnlocked ? () => _navigateToLevel(lvl) : null,
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // 10. Interactive Practice Test
            _buildSectionHeader('INTERACTIVE PRACTICE TEST', Icons.quiz_rounded),
            const SizedBox(height: 10),
            Container(
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

                  // Option Selector Chips / Radio Tiles
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
                          onTap: _isAnswerChecked ? null : () => setState(() => _selectedOption = option),
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

                  // Action Buttons
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
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 4 Pillars of Mastery Component
  Widget _buildFourPillarsCard() {
    return Material(
      color: GameTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: GameTheme.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildPillarTile(
            title: '1. WHAT IT IS',
            icon: Icons.lightbulb_outline_rounded,
            content: widget.lesson.whatItIs.isNotEmpty ? widget.lesson.whatItIs : widget.lesson.conceptSummary,
          ),
          const Divider(color: GameTheme.borderSubtle, height: 1),
          _buildPillarTile(
            title: '2. WHY IT WORKS',
            icon: Icons.psychology_rounded,
            content: widget.lesson.whyItWorks.isNotEmpty ? widget.lesson.whyItWorks : 'Governed by formal algebraic axioms and mathematical structural invariances.',
          ),
          const Divider(color: GameTheme.borderSubtle, height: 1),
          _buildPillarTile(
            title: '3. HOW TO SOLVE IT',
            icon: Icons.checklist_rounded,
            content: widget.lesson.howToSolveIt.isNotEmpty ? widget.lesson.howToSolveIt : widget.lesson.stepByStepExplanation,
          ),
          const Divider(color: GameTheme.borderSubtle, height: 1),
          _buildPillarTile(
            title: '4. WHEN TO USE IT',
            icon: Icons.visibility_rounded,
            content: widget.lesson.whenToUseIt.isNotEmpty ? widget.lesson.whenToUseIt : 'Recognize visual puzzle patterns and operator clues in SMATH riddles.',
          ),
        ],
      ),
    );
  }

  Widget _buildPillarTile({required String title, required IconData icon, required String content}) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Material(
        type: MaterialType.transparency,
        child: ExpansionTile(
          initiallyExpanded: title.startsWith('1.'),
          leading: Icon(icon, color: GameTheme.amberAccent, size: 18),
          title: Text(
            title,
            style: const TextStyle(
              color: GameTheme.textWhite,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                content,
                style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Graded Worked Examples Component
  Widget _buildGradedWorkedExamples() {
    final examples = widget.lesson.gradedExamples;

    if (examples.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: GameTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: GameTheme.borderSubtle),
        ),
        child: Text(
          widget.lesson.workedExample,
          style: const TextStyle(
            color: GameTheme.amberAccent,
            fontSize: 13,
            height: 1.5,
            fontFamily: 'monospace',
          ),
        ),
      );
    }

    return Column(
      children: [
        // Tabs for Level 1, Level 2, Level 3
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(examples.length, (idx) {
              final isSelected = _activeExampleIndex == idx;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  selected: isSelected,
                  label: Text(examples[idx].difficultyLabel),
                  selectedColor: GameTheme.amberAccent.withValues(alpha: 0.25),
                  backgroundColor: GameTheme.surfaceElevated,
                  side: BorderSide(color: isSelected ? GameTheme.amberAccent : GameTheme.borderSubtle),
                  labelStyle: TextStyle(
                    color: isSelected ? GameTheme.amberAccent : GameTheme.textMuted,
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  onSelected: (val) {
                    if (val) setState(() => _activeExampleIndex = idx);
                  },
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 10),

        // Active Example Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: GameTheme.surfaceElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: GameTheme.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                examples[_activeExampleIndex].title.toUpperCase(),
                style: const TextStyle(
                  color: GameTheme.amberAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Problem: ${examples[_activeExampleIndex].problem}',
                style: const TextStyle(color: GameTheme.textWhite, fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                examples[_activeExampleIndex].stepByStepSolution,
                style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.45, fontFamily: 'monospace'),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: GameTheme.amberGlow,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Final Answer: ${examples[_activeExampleIndex].answer}',
                  style: const TextStyle(color: GameTheme.amberAccent, fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Deep Insights Component
  Widget _buildDeepInsightsCard() {
    final mistakes = widget.lesson.commonMistakes;
    final shortcuts = widget.lesson.shortcutsAndTricks;
    final alternatives = widget.lesson.alternativeMethods;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: GameTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GameTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Common Mistakes
          if (mistakes.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: GameTheme.errorRed, size: 16),
                SizedBox(width: 6),
                Text('COMMON TRAPS TO AVOID', style: TextStyle(color: GameTheme.errorRed, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
              ],
            ),
            const SizedBox(height: 6),
            for (final m in mistakes) ...[
              Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: GameTheme.errorRed, fontSize: 12)),
                    Expanded(child: Text(m, style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.4))),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
          ],

          // Shortcuts & Tricks
          if (shortcuts.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.flash_on_rounded, color: GameTheme.amberAccent, size: 16),
                SizedBox(width: 6),
                Text('MENTAL SHORTCUTS & SPEED TRICKS', style: TextStyle(color: GameTheme.amberAccent, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
              ],
            ),
            const SizedBox(height: 6),
            for (final s in shortcuts) ...[
              Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: GameTheme.amberAccent, fontSize: 12)),
                    Expanded(child: Text(s, style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.4))),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
          ],

          // Alternative Methods
          if (alternatives.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.alt_route_rounded, color: GameTheme.textWhite, size: 16),
                SizedBox(width: 6),
                Text('ALTERNATIVE SOLVING METHODS', style: TextStyle(color: GameTheme.textWhite, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
              ],
            ),
            const SizedBox(height: 6),
            for (final a in alternatives) ...[
              Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: GameTheme.textLight, fontSize: 12)),
                    Expanded(child: Text(a, style: const TextStyle(color: GameTheme.textLight, fontSize: 12, height: 1.4))),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: GameTheme.amberAccent, size: 16),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: GameTheme.amberAccent,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
