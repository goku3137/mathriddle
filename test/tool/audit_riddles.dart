// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls
import 'package:math/models/level_model.dart';
import 'package:math/repositories/level_repository.dart';

void main() {
  final repo = ScalableLevelRepository(totalLevels: 500);

  int geometryCountInFirst150 = 0;
  List<int> geometryLevelsInFirst150 = [];
  Map<String, int> categories = {};
  Map<String, int> duplicateContent = {};
  List<String> issues = [];

  for (int i = 1; i <= 500; i++) {
    final level = repo.getLevelSync(i);
    categories[level.category] = (categories[level.category] ?? 0) + 1;

    if (i <= 150) {
      if (level.questionType == QuestionType.Geometry ||
          level.category.toLowerCase().contains('geometry') ||
          level.category.toLowerCase().contains('triangle') ||
          level.category.toLowerCase().contains('circle')) {
        geometryCountInFirst150++;
        geometryLevelsInFirst150.add(i);
      }
    }

    if (level.displayContent.isEmpty) {
      issues.add('Level $i has empty displayContent');
    }
    if (level.correctAnswer.isEmpty) {
      issues.add('Level $i has empty correctAnswer');
    }
    if (level.hint.isEmpty) {
      issues.add('Level $i has empty hint');
    }
    if (level.solution.isEmpty) {
      issues.add('Level $i has empty solution');
    }

    duplicateContent[level.displayContent] = (duplicateContent[level.displayContent] ?? 0) + 1;
  }

  print('=== AUDIT OVERVIEW ===');
  print('Total levels: 500');
  print('Geometry levels in first 150: $geometryCountInFirst150');
  print('Geometry level numbers in first 150: $geometryLevelsInFirst150');
  print('Categories distribution:');
  categories.forEach((k, v) => print('  $k: $v'));
  print('Issues found: ${issues.length}');
  issues.forEach((iss) => print('  $iss'));

  int dups = 0;
  duplicateContent.forEach((content, count) {
    if (count > 1) {
      dups++;
      print('Duplicate ($count times): $content');
    }
  });
  print('Total duplicate displayContent: $dups');
}
