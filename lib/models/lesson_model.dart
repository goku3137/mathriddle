import 'package:flutter/material.dart';

/// Interactive demonstration engine type
enum SandboxDemoType {
  bodmas,
  patterns,
  missingNumbers,
  triangles,
  equations,
  sequences,
  matrices,
  money,
  logic,
  circles,
  operators,
  age,
  tricks,
  mazes,
  finalBoss,
}

/// A graded worked example illustrating progressive difficulty
class WorkedExampleItem {
  final String difficultyLabel; // 'Level 1: Beginner', 'Level 2: Standard', 'Level 3: Challenging'
  final String title;
  final String problem;
  final String stepByStepSolution;
  final String answer;

  const WorkedExampleItem({
    required this.difficultyLabel,
    required this.title,
    required this.problem,
    required this.stepByStepSolution,
    required this.answer,
  });
}

/// Interactive practice / knowledge-check question
class PracticeQuestion {
  final String question;
  final String correctAnswer;
  final String hint;
  final String explanation;
  final List<String>? options; // 4 multiple choice options
  final String? stepByStepGuidance;
  final Map<String, String>? wrongOptionExplanations; // Targeted feedback for why each choice is wrong

  const PracticeQuestion({
    required this.question,
    required this.correctAnswer,
    required this.hint,
    required this.explanation,
    this.options,
    this.stepByStepGuidance,
    this.wrongOptionExplanations,
  });
}

/// Comprehensive mathematical lesson model powering the SMATH Academy
class Lesson {
  final String id;
  final String title;
  final String category;
  final String chapter;
  final int chapterIndex;
  final String difficulty;
  final String conceptSummary;
  final String formula;

  // The Four Pillars of Mathematical Mastery
  final String whatItIs;
  final String whyItWorks;
  final String howToSolveIt;
  final String whenToUseIt;

  final String stepByStepExplanation;
  final String workedExample;

  // Progressive Walkthroughs & Deep Insights
  final List<WorkedExampleItem> gradedExamples;
  final List<String> commonMistakes;
  final List<String> shortcutsAndTricks;
  final List<String> alternativeMethods;

  // Real-Time Interactive Demonstration
  final SandboxDemoType sandboxType;

  // Game Integration & Testing
  final List<int> linkedLevels;
  final PracticeQuestion practiceQuestion;
  final List<PracticeQuestion> knowledgeTest;
  final IconData icon;

  const Lesson({
    required this.id,
    required this.title,
    required this.category,
    this.chapter = 'Foundational Academy',
    this.chapterIndex = 1,
    required this.difficulty,
    required this.conceptSummary,
    required this.formula,
    this.whatItIs = '',
    this.whyItWorks = '',
    this.howToSolveIt = '',
    this.whenToUseIt = '',
    required this.stepByStepExplanation,
    required this.workedExample,
    this.gradedExamples = const [],
    this.commonMistakes = const [],
    this.shortcutsAndTricks = const [],
    this.alternativeMethods = const [],
    this.sandboxType = SandboxDemoType.bodmas,
    required this.linkedLevels,
    required this.practiceQuestion,
    this.knowledgeTest = const [],
    required this.icon,
  });
}
