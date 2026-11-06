import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math/data/learning_curriculum.dart';
import 'package:math/domain/scoring_rules.dart';
import 'package:math/services/progress_service.dart';
import 'package:math/services/security_service.dart';

void main() {
  group('Learning Curriculum - Completeness & Mathematical Verification', () {
    test('Curriculum contains all 36 progressive lessons spanning Stages 1 through 6', () {
      expect(learningCurriculum.length, 36);

      final uniqueIds = <String>{};
      final uniqueTitles = <String>{};

      for (final lesson in learningCurriculum) {
        expect(uniqueIds.add(lesson.id), isTrue, reason: 'Duplicate lesson id found: ${lesson.id}');
        expect(uniqueTitles.add(lesson.title), isTrue, reason: 'Duplicate lesson title found: ${lesson.title}');
        expect(lesson.title.trim().isNotEmpty, isTrue);
        expect(lesson.category.trim().isNotEmpty, isTrue);
        expect(lesson.stage.trim().isNotEmpty, isTrue);
        expect(lesson.stageIndex >= 1 && lesson.stageIndex <= 6, isTrue);
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

    test('Curriculum is partitioned equally across all 6 progressive stages (6 lessons each)', () {
      final stageCounts = <int, int>{};
      for (final lesson in learningCurriculum) {
        stageCounts[lesson.stageIndex] = (stageCounts[lesson.stageIndex] ?? 0) + 1;
      }

      for (int stage = 1; stage <= 6; stage++) {
        expect(stageCounts[stage], 6, reason: 'Stage $stage does not contain exactly 6 lessons');
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

    test('All lessons provide traps and pro shortcuts', () {
      for (final lesson in learningCurriculum) {
        expect(lesson.commonMistakes.isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} has no common mistakes');
        expect(lesson.shortcutsAndTricks.isNotEmpty, isTrue,
            reason: 'Lesson ${lesson.id} has no shortcuts or tricks');
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
      final rewarded1 = await progressService.markLearnTopicCompleted('stage1_lesson1_place_values');
      expect(rewarded1, isTrue);
      expect(progressService.totalScore, ScoringRules.pointsPerLearnLesson); // 50
      expect(progressService.completedLearnTopics, contains('stage1_lesson1_place_values'));

      // Attempt duplicate claim on same topic
      final rewardedDuplicate = await progressService.markLearnTopicCompleted('stage1_lesson1_place_values');
      expect(rewardedDuplicate, isFalse);
      expect(progressService.totalScore, ScoringRules.pointsPerLearnLesson); // Still 50

      // Complete second lesson
      final rewarded2 = await progressService.markLearnTopicCompleted('stage1_lesson2_addition_subtraction');
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
