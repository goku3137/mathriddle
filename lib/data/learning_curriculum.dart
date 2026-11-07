import '../features/learning/data/stage_1_absolute_beginner.dart';
import '../features/learning/data/stage_2_basic_mathematics.dart';
import '../features/learning/data/stage_3_intermediate_mathematics.dart';
import '../features/learning/data/stage_4_advanced_mathematics.dart';
import '../features/learning/data/stage_5_expert_mathematics.dart';
import '../features/learning/data/stage_6_extreme_mathematics.dart';
import '../models/lesson_model.dart';

export '../features/learning/data/stage_1_absolute_beginner.dart';
export '../features/learning/data/stage_2_basic_mathematics.dart';
export '../features/learning/data/stage_3_intermediate_mathematics.dart';
export '../features/learning/data/stage_4_advanced_mathematics.dart';
export '../features/learning/data/stage_5_expert_mathematics.dart';
export '../features/learning/data/stage_6_extreme_mathematics.dart';

/// The comprehensive 36-lesson progressive mathematics curriculum powering SMATH Academy.
/// Spans from Stage 1 (Absolute Beginner) through Stage 6 (Extreme Olympiad & Research Mathematics).
final List<Lesson> learningCurriculum = [
  ...stage1AbsoluteBeginner,
  ...stage2BasicMathematics,
  ...stage3IntermediateMathematics,
  ...stage4AdvancedMathematics,
  ...stage5ExpertMathematics,
  ...stage6ExtremeMathematics,
];
