import 'package:math/models/level_model.dart';
import 'package:math/repositories/level_repository.dart';

void main() {
  final repo = ScalableLevelRepository(totalLevels: 500);

  int encodingErrors = 0;
  int geometryIn150 = 0;
  int missingFieldErrors = 0;
  int placeholderErrors = 0;
  List<String> report = [];

  for (int i = 1; i <= 500; i++) {
    final level = repo.getLevelSync(i);

    // 1. Geometry in 1-150
    if (i <= 150) {
      if (level.questionType == QuestionType.Geometry ||
          level.category.toLowerCase().contains('geometry') ||
          level.category.toLowerCase().contains('triangle') ||
          level.category.toLowerCase().contains('circle')) {
        geometryIn150++;
        report.add('GEOMETRY_IN_150: Level $i (${level.category}): "${level.displayContent}"');
      }
    }

    // 2. Encoding / Corrupted characters (mojibake)
    final allText = '${level.displayContent} ${level.hint} ${level.solution}';
    if (allText.contains('Â') || allText.contains('â€')) {
      encodingErrors++;
      report.add('ENCODING_ERROR: Level $i has corrupted character: "$allText"');
    }

    // 3. Unresolved placeholders
    if (allText.contains('null') || allText.contains('undefined') || allText.contains('[object')) {
      placeholderErrors++;
      report.add('PLACEHOLDER_ERROR: Level $i contains null/undefined');
    }

    // 4. Missing fields
    if (level.displayContent.trim().isEmpty ||
        level.correctAnswer.trim().isEmpty ||
        level.hint.trim().isEmpty ||
        level.solution.trim().isEmpty) {
      missingFieldErrors++;
      report.add('MISSING_FIELD: Level $i has empty field');
    }

    // 5. Answer validation (must be non-negative integer for virtual keypad)
    final ansInt = int.tryParse(level.correctAnswer.trim());
    if (ansInt == null || ansInt < 0) {
      report.add('INVALID_ANSWER: Level $i has non-integer/negative answer "${level.correctAnswer}"');
    }
  }

  print('=== DETAILED AUDIT RESULTS ===');
  print('Total levels: 500');
  print('Geometry in 1-150: $geometryIn150');
  print('Encoding errors: $encodingErrors');
  print('Placeholder errors: $placeholderErrors');
  print('Missing field errors: $missingFieldErrors');
  print('Total report items: ${report.length}');
  for (var r in report.take(30)) {
    print('  $r');
  }
  if (report.length > 30) {
    print('  ... and ${report.length - 30} more');
  }
}
