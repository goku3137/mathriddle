import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../data/learning_curriculum.dart';
import '../features/learning/widgets/lesson_category_card.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/score_badge.dart';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({super.key});

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen> {
  int _selectedChapter = 0; // 0: All Chapters, 1..5: Specific Chapters

  final List<String> _chapters = const [
    'All Lessons',
    'Ch 1: Basics',
    'Ch 2: Patterns',
    'Ch 3: Equations',
    'Ch 4: Geometry',
    'Ch 5: Mastery',
  ];

  @override
  Widget build(BuildContext context) {
    // Watch game controller state so score and completion updates trigger reactive rebuild
    ref.watch(gameControllerProvider);
    final progress = ref.watch(progressServiceProvider);
    final completedTopics = progress.completedLearnTopics;

    final totalCompleted = learningCurriculum
        .where((lesson) => completedTopics.contains(lesson.id))
        .length;
    final totalLessons = learningCurriculum.length;
    final progressFraction = totalLessons > 0 ? (totalCompleted / totalLessons) : 0.0;
    final pointsEarned = totalCompleted * 50;

    // Filter by selected chapter
    final filteredLessons = _selectedChapter == 0
        ? learningCurriculum
        : learningCurriculum.where((l) => l.chapterIndex == _selectedChapter).toList();

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () {
            ref.read(soundServiceProvider).playTap();
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'LEARNING CURRICULUM',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w800,
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
        child: Column(
          children: [
            // 1. Simplified Learning Progress Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: GameTheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: GameTheme.borderSubtle),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'LEARNING PATH',
                              style: TextStyle(
                                color: GameTheme.amberAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$totalCompleted of $totalLessons Concepts Mastered',
                              style: const TextStyle(
                                color: GameTheme.textWhite,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: GameTheme.amberGlow,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: GameTheme.amberAccent.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            '+$pointsEarned PTS',
                            style: const TextStyle(
                              color: GameTheme.amberAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progressFraction,
                        minHeight: 6,
                        backgroundColor: GameTheme.surfaceElevated,
                        valueColor: const AlwaysStoppedAnimation<Color>(GameTheme.amberAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Single Chapter Path Filter Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _chapters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final chName = _chapters[index];
                  final isSelected = _selectedChapter == index;
                  return ChoiceChip(
                    label: Text(chName),
                    selected: isSelected,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black87 : GameTheme.textLight,
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    backgroundColor: GameTheme.surfaceElevated,
                    selectedColor: GameTheme.amberAccent,
                    side: BorderSide(
                      color: isSelected ? GameTheme.amberAccent : GameTheme.borderSubtle,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        ref.read(soundServiceProvider).playTap();
                        setState(() {
                          _selectedChapter = index;
                        });
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // 3. Simplified Lessons List with Clear Progression
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: filteredLessons.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final lesson = filteredLessons[index];
                  final isCompleted = completedTopics.contains(lesson.id);

                  // Find global index in learningCurriculum for linear progression
                  final globalIndex = learningCurriculum.indexOf(lesson);
                  final isLocked = globalIndex > 0 &&
                      !completedTopics.contains(learningCurriculum[globalIndex - 1].id) &&
                      !isCompleted;

                  // Find if this is the next unlocked lesson
                  final isCurrent = !isCompleted && !isLocked;

                  return LessonCategoryCard(
                    lesson: lesson,
                    isCompleted: isCompleted,
                    isLocked: isLocked,
                    isCurrent: isCurrent,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
