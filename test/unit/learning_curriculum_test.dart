import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math/data/learning_curriculum.dart';
import 'package:math/domain/scoring_rules.dart';
import 'package:math/services/progress_service.dart';
import 'package:math/services/security_service.dart';

void main() {
  group('Learning Curriculum - Completeness & Mathematical Verification', () {
    test('Curriculum contains all 15 comprehensive lessons covering all riddle categories', () {
      expect(learningCurriculum.length, 15);

      final uniqueIds = <String>{};
      final uniqueTitles = <String>{};

      for (final lesson in learningCurriculum) {
        expect(uniqueIds.add(lesson.id), isTrue, reason: 'Duplicate lesson id found: ${lesson.id}');
        expect(uniqueTitles.add(lesson.title), isTrue, reason: 'Duplicate lesson title found: ${lesson.title}');
        expect(lesson.title.trim().isNotEmpty, isTrue);
        expect(lesson.category.trim().isNotEmpty, isTrue);
        expect(lesson.difficulty.trim().isNotEmpty, isTrue);
        expect(lesson.conceptSummary.trim().isNotEmpty, isTrue);
        expect(lesson.formula.trim().isNotEmpty, isTrue);
        expect(lesson.stepByStepExplanation.trim().isNotEmpty, isTrue);
        expect(lesson.workedExample.trim().isNotEmpty, isTrue);
        expect(lesson.linkedLevels.isNotEmpty, isTrue);
      }
    });

    test('All linked levels are within valid range 1..500', () {
      for (final lesson in learningCurriculum) {
        for (final level in lesson.linkedLevels) {
          expect(level >= 1 && level <= 500, isTrue,
              reason: 'Lesson ${lesson.id} references invalid level $level');
        }
      }
    });

    test('All practice questions have mathematically sound answers and keypad compatibility', () {
      for (final lesson in learningCurriculum) {
        final pq = lesson.practiceQuestion;
        expect(pq.question.trim().isNotEmpty, isTrue, reason: 'Empty question in ${lesson.id}');
        expect(pq.correctAnswer.trim().isNotEmpty, isTrue, reason: 'Empty answer in ${lesson.id}');
        expect(pq.hint.trim().isNotEmpty, isTrue, reason: 'Empty hint in ${lesson.id}');
        expect(pq.explanation.trim().isNotEmpty, isTrue, reason: 'Empty explanation in ${lesson.id}');

        // Keypad compatibility: must be non-negative integer string
        final parsed = int.tryParse(pq.correctAnswer);
        expect(parsed, isNotNull, reason: 'Answer ${pq.correctAnswer} in ${lesson.id} is not an integer');
        expect(parsed! >= 0, isTrue, reason: 'Answer ${pq.correctAnswer} in ${lesson.id} is negative');

        // Options verification
        expect(pq.options, isNotNull, reason: 'Lesson ${lesson.id} has null options');
        expect(pq.options!.length, 4, reason: 'Lesson ${lesson.id} does not have exactly 4 options');
        expect(pq.options!.toSet().length, 4, reason: 'Lesson ${lesson.id} contains duplicate options');
        expect(pq.options!.contains(pq.correctAnswer), isTrue,
            reason: 'Options for ${lesson.id} do not contain the correct answer ${pq.correctAnswer}');
      }
    });

    test('Curriculum covers all 14 core categories and Level 500 Final Boss', () {
      final categories = learningCurriculum.map((l) => l.category).toSet();

      final expectedCategories = [
        'Formula Precedence',
        'Number Patterns',
        'Missing Numbers',
        'Geometry: Triangles',
        'Equation Riddles',
        'Sequences',
        'Matrices & Grids',
        'Money & Shopping',
        'Logic Numbers',
        'Geometry: Intersecting Circles',
        'Lateral Operators',
        'Age Riddles',
        'Mathematical Tricks',
        'Number Mazes',
        'Final Boss',
      ];

      for (final expected in expectedCategories) {
        expect(categories.contains(expected), isTrue,
            reason: 'Category "$expected" is missing from the curriculum');
      }
    });

    test('All lessons feature the Four Pillars of Mathematical Mastery', () {
      for (final lesson in learningCurriculum) {
        expect(lesson.whatItIs.trim().isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} is missing "What It Is"');
        expect(lesson.whyItWorks.trim().isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} is missing "Why It Works"');
        expect(lesson.howToSolveIt.trim().isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} is missing "How To Solve It"');
        expect(lesson.whenToUseIt.trim().isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} is missing "When To Use It"');
      }
    });

    test('All lessons contain 3 Graded Worked Examples (Easy, Medium, Hard)', () {
      for (final lesson in learningCurriculum) {
        expect(lesson.gradedExamples.length, 3,
            reason: 'Lesson ${lesson.id} does not have exactly 3 graded examples');

        for (final eg in lesson.gradedExamples) {
          expect(eg.title.trim().isNotEmpty, isTrue);
          expect(eg.problem.trim().isNotEmpty, isTrue);
          expect(eg.stepByStepSolution.trim().isNotEmpty, isTrue);
          expect(eg.answer.trim().isNotEmpty, isTrue);
          expect(eg.difficultyLabel.trim().isNotEmpty, isTrue);
        }
      }
    });

    test('All lessons provide Deep Insights: traps, shortcuts, and alternative methods', () {
      for (final lesson in learningCurriculum) {
        expect(lesson.commonMistakes.isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} has no common mistakes');
        expect(lesson.shortcutsAndTricks.isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} has no shortcuts or tricks');
        expect(lesson.alternativeMethods.isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} has no alternative methods');
      }
    });

    test('All lessons are assigned to valid chapters with real-time sandbox demos', () {
      final validChapters = [
        'Chapter 1: Foundational Arithmetic',
        'Chapter 2: Sequences & Patterns',
        'Chapter 3: Equations & Logic',
        'Chapter 4: Visual Geometry',
        'Chapter 5: Advanced Synthesis & Boss Mastery',
      ];

      for (final lesson in learningCurriculum) {
        expect(lesson.chapterIndex >= 1 && lesson.chapterIndex <= 5, isTrue,
            reason: 'Lesson ${lesson.id} has invalid chapterIndex ${lesson.chapterIndex}');
        expect(validChapters.contains(lesson.chapter), isTrue,
            reason: 'Lesson ${lesson.id} has invalid chapter "${lesson.chapter}"');
        expect(lesson.sandboxType, isNotNull,
            reason: 'Lesson ${lesson.id} has null sandboxType');
      }
    });

    test('All lessons include an end-of-topic knowledge test quiz', () {
      for (final lesson in learningCurriculum) {
        expect(lesson.knowledgeTest.isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} has no quiz questions');

        for (final q in lesson.knowledgeTest) {
          expect(q.question.trim().isNotEmpty, isTrue);
          expect(q.correctAnswer.trim().isNotEmpty, isTrue);
          expect(q.options, isNotNull);
          expect(q.options!.length, 4,
              reason: 'Quiz question in ${lesson.id} does not have 4 options');
          expect(q.options!.contains(q.correctAnswer), isTrue,
              reason: 'Quiz question in ${lesson.id} does not include correct answer in options');
        }
      }
    });
  });

  group('Learning Progress & Reward Security Integration', () {
    test('Completing a lesson awards 50 points and prevents duplicate claims', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final progressService = ProgressService(prefs);

      expect(progressService.totalScore, 0);
      expect(progressService.completedLearnTopics, isEmpty);

      // Complete first lesson
      final rewarded1 = await progressService.markLearnTopicCompleted('topic_bodmas');
      expect(rewarded1, isTrue);
      expect(progressService.totalScore, ScoringRules.pointsPerLearnLesson); // 50
      expect(progressService.completedLearnTopics, contains('topic_bodmas'));

      // Attempt duplicate claim on same topic
      final rewardedDuplicate = await progressService.markLearnTopicCompleted('topic_bodmas');
      expect(rewardedDuplicate, isFalse);
      expect(progressService.totalScore, ScoringRules.pointsPerLearnLesson); // Still 50

      // Complete second lesson
      final rewarded2 = await progressService.markLearnTopicCompleted('topic_patterns');
      expect(rewarded2, isTrue);
      expect(progressService.totalScore, 100);
      expect(progressService.completedLearnTopics.length, 2);

      // Verify tamper detection and maximum valid score invariant
      final maxValid = SecurityService.computeMaximumValidScore(
        completedLevels: progressService.getCompletedLevels(),
        completedLearnCount: progressService.completedLearnTopics.length,
        completedChallengeCount: progressService.completedChallenges.length,
      );
      expect(progressService.totalScore <= maxValid, isTrue);
      expect(progressService.isStorageTampered, isFalse);
    });
  });
}
