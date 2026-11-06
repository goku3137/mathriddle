// ignore_for_file: avoid_print
import 'package:math/models/level_model.dart';
import 'package:math/repositories/level_repository.dart';

void main() {
  final repo = ScalableLevelRepository(totalLevels: 500);

  int encodingErrors = 0;
  int geometryIn150 = 0;
  int bracketErrors = 0;
  int debugTokenErrors = 0;
  int missingFieldErrors = 0;
  int placeholderErrors = 0;
  int invalidAnswerErrors = 0;
  int duplicateQuestions = 0;
  Map<String, int> seenQuestions = {};
  List<String> report = [];

  for (int i = 1; i <= 500; i++) {
    final level = repo.getLevelSync(i);
    final header = repo.getLevelHeader(i);

    // Level number continuity
    if (level.levelNumber != i || header.levelNumber != i) {
      report.add('CONTINUITY_ERROR: Expected level $i, got ${level.levelNumber}');
    }

    // QuestionType & Category sync between Header and Level
    if (level.questionType != header.questionType || level.category != header.category) {
      report.add('SYNC_ERROR: Level $i header mismatch (${level.category} vs ${header.category})');
    }

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
    if (allText.contains('Â') || allText.contains('â€') || allText.contains('Ã')) {
      encodingErrors++;
      report.add('ENCODING_ERROR: Level $i has corrupted character: "$allText"');
    }

    // 3. Bracketed [?] artifacts
    if (allText.contains('[?]')) {
      bracketErrors++;
      report.add('BRACKET_ERROR: Level $i contains [?]');
    }

    // 4. Debug tokens leaked
    final debugTokens = ['case #', 'maze #', 'pattern #', 'seed #', 'route #', 'Clock #', 'Clue #'];
    for (final token in debugTokens) {
      if (allText.contains(token)) {
        debugTokenErrors++;
        report.add('DEBUG_TOKEN_ERROR: Level $i contains "$token"');
      }
    }

    // 5. Unresolved placeholders
    if (allText.contains('null') || allText.contains('undefined') || allText.contains('NaN')) {
      placeholderErrors++;
      report.add('PLACEHOLDER_ERROR: Level $i contains null/undefined/NaN');
    }

    // 6. Missing fields
    if (level.displayContent.trim().isEmpty ||
        level.correctAnswer.trim().isEmpty ||
        level.hint.trim().isEmpty ||
        level.solution.trim().isEmpty) {
      missingFieldErrors++;
      report.add('MISSING_FIELD: Level $i has empty field');
    }

    // 7. Answer validation (must be non-negative integer for virtual keypad)
    final ansInt = int.tryParse(level.correctAnswer.trim());
    if (ansInt == null || ansInt < 0) {
      invalidAnswerErrors++;
      report.add('INVALID_ANSWER: Level $i has non-integer/negative answer "${level.correctAnswer}"');
    }

    // 8. Duplicate detection
    final qKey = '${level.category}::${level.displayContent}';
    if (seenQuestions.containsKey(qKey)) {
      duplicateQuestions++;
      report.add('DUPLICATE_QUESTION: Level $i duplicates level ${seenQuestions[qKey]} ("${level.displayContent}")');
    } else {
      seenQuestions[qKey] = i;
    }
  }

  print('=== COMPLETE 500 RIDDLE AUDIT RESULTS ===');
  print('Total levels: 500');
  print('Geometry in 1-150: $geometryIn150');
  print('Encoding errors: $encodingErrors');
  print('Bracket [?] errors: $bracketErrors');
  print('Debug token errors: $debugTokenErrors');
  print('Placeholder errors: $placeholderErrors');
  print('Missing field errors: $missingFieldErrors');
  print('Invalid answer errors: $invalidAnswerErrors');
  print('Duplicate questions: $duplicateQuestions');
  print('Total report items: ${report.length}');
  for (var r in report.take(30)) {
    print('  $r');
  }
}
