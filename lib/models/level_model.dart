// ignore_for_file: constant_identifier_names

import 'dart:convert';

/// Question types defined by the game architecture
enum QuestionType {
  Formula,
  Grid,
  Geometry,
}

/// Represents individual coordinate nodes for vector-rendered geometric riddles
class PuzzleNode {
  final String id;
  final String displayValue;
  final bool isTarget;
  final double relX;
  final double relY;

  const PuzzleNode({
    required this.id,
    required this.displayValue,
    this.isTarget = false,
    this.relX = 0.5,
    this.relY = 0.5,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'displayValue': displayValue,
    'isTarget': isTarget,
    'relX': relX,
    'relY': relY,
  };

  factory PuzzleNode.fromJson(Map<String, dynamic> json) => PuzzleNode(
    id: json['id'] as String,
    displayValue: json['displayValue'] as String,
    isTarget: json['isTarget'] as bool? ?? false,
    relX: (json['relX'] as num?)?.toDouble() ?? 0.5,
    relY: (json['relY'] as num?)?.toDouble() ?? 0.5,
  );
}

/// Level Data Model Schema strictly following specifications
class LevelData {
  final int levelNumber;
  final QuestionType questionType;
  final String displayContent;
  final List<PuzzleNode>? nodes;
  final String correctAnswer;
  final String hint;
  final String solution;

  const LevelData({
    required this.levelNumber,
    required this.questionType,
    required this.displayContent,
    this.nodes,
    required this.correctAnswer,
    required this.hint,
    required this.solution,
  });

  Map<String, dynamic> toJson() => {
    'levelNumber': levelNumber,
    'questionType': questionType.name,
    'displayContent': displayContent,
    if (nodes != null) 'nodes': nodes!.map((n) => n.toJson()).toList(),
    'correctAnswer': correctAnswer,
    'hint': hint,
    'solution': solution,
  };

  factory LevelData.fromJson(Map<String, dynamic> json) => LevelData(
    levelNumber: json['levelNumber'] as int,
    questionType: QuestionType.values.byName(json['questionType'] as String),
    displayContent: json['displayContent'] as String,
    nodes: json['nodes'] != null
        ? (json['nodes'] as List<dynamic>)
            .map((e) => PuzzleNode.fromJson(e as Map<String, dynamic>))
            .toList()
        : null,
    correctAnswer: json['correctAnswer'] as String,
    hint: json['hint'] as String,
    solution: json['solution'] as String,
  );

  static String encodeList(List<LevelData> levels) =>
      jsonEncode(levels.map((l) => l.toJson()).toList());

  static List<LevelData> decodeList(String jsonStr) =>
      (jsonDecode(jsonStr) as List<dynamic>)
          .map((item) => LevelData.fromJson(item as Map<String, dynamic>))
          .toList();
}
