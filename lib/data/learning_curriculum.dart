import '../features/learning/data/chapter_1_foundations.dart';
import '../features/learning/data/chapter_2_sequences.dart';
import '../features/learning/data/chapter_3_logic_equations.dart';
import '../features/learning/data/chapter_4_geometry.dart';
import '../features/learning/data/chapter_5_advanced_boss.dart';
import '../models/lesson_model.dart';

export '../features/learning/data/chapter_1_foundations.dart';
export '../features/learning/data/chapter_2_sequences.dart';
export '../features/learning/data/chapter_3_logic_equations.dart';
export '../features/learning/data/chapter_4_geometry.dart';
export '../features/learning/data/chapter_5_advanced_boss.dart';

final List<Lesson> learningCurriculum = [
  ...chapter1Foundations,
  ...chapter2Sequences,
  ...chapter3LogicEquations,
  ...chapter4Geometry,
  ...chapter5AdvancedBoss,
];
