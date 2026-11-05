import 'package:flutter_test/flutter_test.dart';
import 'package:math/models/level_model.dart';
import 'package:math/repositories/level_repository.dart';

void main() {
  group('ScalableLevelRepository - 500 Riddles & Memory Efficiency', () {
    late ScalableLevelRepository repository;

    setUp(() {
      repository = ScalableLevelRepository(totalLevels: 500);
    });

    test('Repository contains 500 total levels', () {
      expect(repository.totalLevelsCount, equals(500));
    });

    test('Loads handcrafted levels (1 to 20) with valid geometry, categories and answers', () async {
      final level1 = await repository.getLevel(1);
      expect(level1.levelNumber, equals(1));
      expect(level1.correctAnswer, equals('6'));
      expect(level1.questionType, equals(QuestionType.Formula));
      expect(level1.difficulty, equals('Beginner'));
      expect(level1.category, equals('Formula Precedence'));

      final level2 = await repository.getLevel(2);
      expect(level2.levelNumber, equals(2));
      expect(level2.correctAnswer, equals('10'));
      expect(level2.questionType, equals(QuestionType.Formula));
      expect(level2.category, equals('Number Pattern Riddles'));

      final level3 = await repository.getLevel(3);
      expect(level3.questionType, equals(QuestionType.Formula));
      expect(level3.category, equals('Missing Number Puzzles'));
      expect(level3.correctAnswer, equals('7'));

      final level14 = await repository.getLevel(14);
      expect(level14.questionType, equals(QuestionType.Grid));
      expect(level14.nodes, isNotNull);
      expect(level14.nodes!.length, equals(9));
      expect(level14.correctAnswer, equals('2'));

      final level16 = await repository.getLevel(16);
      expect(level16.questionType, equals(QuestionType.Geometry));
      expect(level16.nodes, isNotNull);
      expect(level16.nodes!.length, equals(4));
      expect(level16.correctAnswer, equals('10'));
    });

    test('All 500 levels have strictly valid, non-negative integer answers matching 0-9 keypad', () {
      final digitRegex = RegExp(r'^[0-9]+$');

      for (int i = 1; i <= 500; i++) {
        final level = repository.getLevelSync(i);
        expect(level.levelNumber, equals(i));
        expect(
          digitRegex.hasMatch(level.correctAnswer.trim()),
          isTrue,
          reason: 'Level $i has invalid keypad answer: "${level.correctAnswer}"',
        );
        expect(level.hint.isNotEmpty, isTrue, reason: 'Level $i has empty hint');
        expect(level.solution.isNotEmpty, isTrue, reason: 'Level $i has empty solution');
      }
    });

    test('All 500 levels are unique with zero duplicates', () {
      final Set<String> seen = {};

      for (int i = 1; i <= 500; i++) {
        final level = repository.getLevelSync(i);
        final key = '${level.displayContent}|${level.category}';
        expect(
          seen.contains(key),
          isFalse,
          reason: 'Duplicate question detected at level $i: "${level.displayContent}" (${level.category})',
        );
        seen.add(key);
      }

      expect(seen.length, equals(500));
    });

    test('Strict difficulty tier restrictions are enforced across all 500 levels', () {
      for (int i = 1; i <= 500; i++) {
        final level = repository.getLevelSync(i);

        if (i <= 50) {
          expect(level.difficulty, equals('Beginner'), reason: 'Level $i must be Beginner');
        } else if (i <= 100) {
          expect(level.difficulty, equals('Easy–Intermediate'), reason: 'Level $i must be Easy–Intermediate');
        } else if (i <= 150) {
          expect(level.difficulty, equals('Intermediate'), reason: 'Level $i must be Intermediate');
        } else if (i <= 199) {
          expect(level.difficulty, equals('Advanced'), reason: 'Level $i must be Advanced');
        } else if (i <= 299) {
          // Never introduce Expert before level 200
          expect(level.difficulty, equals('Expert'), reason: 'Level $i must be Expert');
        } else if (i <= 399) {
          // Never introduce Very Expert before level 300
          expect(level.difficulty, equals('Very Expert'), reason: 'Level $i must be Very Expert');
        } else if (i <= 499) {
          // Never introduce Extreme before level 400
          expect(level.difficulty, equals('Extreme'), reason: 'Level $i must be Extreme');
        } else {
          expect(level.difficulty, equals('Final Boss'), reason: 'Level 500 must be Final Boss');
        }
      }
    });

    test('All 14 categories are represented with balanced distribution', () {
      final Map<String, int> categoryCounts = {};

      for (int i = 1; i <= 500; i++) {
        final level = repository.getLevelSync(i);
        categoryCounts[level.category] = (categoryCounts[level.category] ?? 0) + 1;
      }

      // Check all 14 core categories are present
      for (final cat in ScalableLevelRepository.categories) {
        expect(categoryCounts.containsKey(cat), isTrue, reason: 'Category "$cat" missing');
        expect(categoryCounts[cat]! >= 30, isTrue, reason: 'Category "$cat" underrepresented: ${categoryCounts[cat]}');
      }

      // Final Boss is its own special category
      expect(categoryCounts['Final Boss: Grand Singularity'], equals(1));
    });

    test('Level 500 Final Boss is correctly configured', () {
      final boss = repository.getLevelSync(500);
      expect(boss.levelNumber, equals(500));
      expect(boss.difficulty, equals('Final Boss'));
      expect(boss.category, equals('Final Boss: Grand Singularity'));
      expect(boss.correctAnswer, equals('575'));
      expect(boss.displayContent.contains('BOSS'), isTrue);
    });

    test('Geometry and Grid nodes are valid for corresponding question types', () {
      for (int i = 1; i <= 500; i++) {
        final level = repository.getLevelSync(i);
        if (level.questionType == QuestionType.Geometry) {
          expect(level.nodes != null && level.nodes!.isNotEmpty, isTrue, reason: 'Geometry level $i missing nodes');
          expect(level.nodes!.any((n) => n.isTarget), isTrue, reason: 'Geometry level $i missing target node');
        } else if (level.questionType == QuestionType.Grid) {
          expect(level.nodes != null && level.nodes!.length == 9, isTrue, reason: 'Grid level $i must have 9 nodes');
          expect(level.nodes!.any((n) => n.isTarget), isTrue, reason: 'Grid level $i missing target node');
        }
      }
    });

    test('LRU cache evicts oldest levels when exceeding capacity (25 max entries)', () async {
      // Clear cache first
      repository.clearCache();

      // Load levels 1 to 30 sequentially
      for (int i = 1; i <= 30; i++) {
        await repository.getLevel(i);
      }

      // First few levels (1 to 5) should have been evicted from memory
      expect(repository.getCachedLevel(1), isNull);
      expect(repository.getCachedLevel(2), isNull);
      expect(repository.getCachedLevel(5), isNull);

      // Recent levels (20 to 30) must be present in the LRU cache
      expect(repository.getCachedLevel(29), isNotNull);
      expect(repository.getCachedLevel(30), isNotNull);
    });

    test('Provides lightweight level headers without loading full node geometry', () {
      repository.clearCache();
      final header = repository.getLevelHeader(450);
      expect(header.levelNumber, equals(450));
      expect(header.title, equals('Level 450'));
      expect(header.difficulty, equals('Extreme'));
      expect(header.category.isNotEmpty, isTrue);
      expect(header.questionType, isNotNull);
      // Ensure level 450 was not prematurely loaded into the heavy cache
      expect(repository.getCachedLevel(450), isNull);
    });

    test('getLevelSync returns procedural level immediately on cold start', () {
      final freshRepo = ScalableLevelRepository(totalLevels: 500);
      final level42 = freshRepo.getLevelSync(42);
      expect(level42.levelNumber, equals(42));
      expect(level42.correctAnswer.isNotEmpty, isTrue);
      expect(freshRepo.getCachedLevel(42), isNotNull);
    });

    test('Level 9 math trick produces valid 20 answer solvable with keypad', () {
      final level9 = repository.getLevelSync(9);
      expect(level9.correctAnswer, equals('20'));
      expect(level9.category, equals('Mathematical Trick Riddles'));
      expect(int.tryParse(level9.correctAnswer), isNotNull);
      expect(int.parse(level9.correctAnswer) >= 0, isTrue);
    });
  });
}
