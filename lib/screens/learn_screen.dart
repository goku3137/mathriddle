import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../data/learning_curriculum.dart';
import '../features/learning/widgets/lesson_category_card.dart';
import '../models/lesson_model.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/score_badge.dart';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({super.key});

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen> {
  String _selectedCategory = 'All';
  int _selectedChapter = 0; // 0: All Chapters, 1..5: Specific Chapters

  final List<String> _chapters = [
    'All Chapters',
    'Ch 1: Foundational Arithmetic',
    'Ch 2: Sequences & Patterns',
    'Ch 3: Equations & Logic',
    'Ch 4: Visual Geometry',
    'Ch 5: Advanced & Boss',
  ];

  final List<String> _categories = [
    'All',
    'Arithmetic & Precedence',
    'Patterns & Sequences',
    'Algebra & Equations',
    'Geometry',
    'Matrices & Grids',
    'Logic & Tricks',
    'Commercial & Word Problems',
    'Final Boss',
  ];

  bool _matchesFilter(Lesson lesson) {
    if (_selectedChapter > 0 && lesson.chapterIndex != _selectedChapter) {
      return false;
    }

    if (_selectedCategory == 'All') return true;
    switch (_selectedCategory) {
      case 'Arithmetic & Precedence':
        return lesson.category == 'Formula Precedence' || lesson.category == 'Lateral Operators';
      case 'Patterns & Sequences':
        return lesson.category == 'Number Patterns' || lesson.category == 'Sequences';
      case 'Algebra & Equations':
        return lesson.category == 'Equation Riddles' || lesson.category == 'Missing Numbers';
      case 'Geometry':
        return lesson.category == 'Geometry: Triangles' || lesson.category == 'Geometry: Intersecting Circles';
      case 'Matrices & Grids':
        return lesson.category == 'Matrices & Grids';
      case 'Logic & Tricks':
        return lesson.category == 'Logic Numbers' || lesson.category == 'Mathematical Tricks';
      case 'Commercial & Word Problems':
        return lesson.category == 'Money & Shopping' || lesson.category == 'Age Riddles' || lesson.category == 'Number Mazes';
      case 'Final Boss':
        return lesson.category == 'Final Boss';
      default:
        return true;
    }
  }

  String _getAcademyRank(int completedCount) {
    if (completedCount >= 15) return 'Grand Singularity Master';
    if (completedCount >= 10) return 'Mathematical Specialist';
    if (completedCount >= 5) return 'Pattern Adept';
    if (completedCount >= 1) return 'Logic Novice';
    return 'Academy Apprentice';
  }

  @override
  Widget build(BuildContext context) {
    // Watch game controller state so score and completion updates trigger reactive rebuild
    ref.watch(gameControllerProvider);
    final progress = ref.watch(progressServiceProvider);
    final completedTopics = progress.completedLearnTopics;

    final filteredLessons = learningCurriculum
        .where((lesson) => _matchesFilter(lesson))
        .toList();

    final totalCompleted = learningCurriculum
        .where((lesson) => completedTopics.contains(lesson.id))
        .length;
    final totalLessons = learningCurriculum.length;
    final progressFraction = totalLessons > 0 ? (totalCompleted / totalLessons) : 0.0;
    final pointsEarned = totalCompleted * 50;
    final academyRank = _getAcademyRank(totalCompleted);

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
            letterSpacing: 2.5,
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
            // 1. Learning Progress Summary Banner
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              academyRank.toUpperCase(),
                              style: const TextStyle(
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

            // 2. Chapter Path Filter Chips
            SizedBox(
              height: 40,
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
                      fontSize: 11,
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
            const SizedBox(height: 8),

            // 3. Category Filter Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black87 : GameTheme.textLight,
                      fontSize: 11,
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
                          _selectedCategory = cat;
                        });
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),

            // 4. Lessons List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                itemCount: filteredLessons.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final lesson = filteredLessons[index];
                  final isCompleted = completedTopics.contains(lesson.id);

                  return LessonCategoryCard(
                    lesson: lesson,
                    isCompleted: isCompleted,
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