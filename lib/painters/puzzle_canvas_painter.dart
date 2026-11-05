import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/level_model.dart';
import '../theme/game_theme.dart';

class PuzzleCanvasPainter extends CustomPainter {
  final LevelData level;
  final String currentInput;
  final double shakeOffset;
  final bool isError;
  final double pulseScale;

  PuzzleCanvasPainter({
    required this.level,
    required this.currentInput,
    this.shakeOffset = 0.0,
    this.isError = false,
    this.pulseScale = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (level.questionType) {
      case QuestionType.Formula:
        _paintFormula(canvas, size);
        break;
      case QuestionType.Grid:
        _paintGrid(canvas, size);
        break;
      case QuestionType.Geometry:
        if (level.displayContent.contains('Circles')) {
          _paintCircles(canvas, size);
        } else {
          _paintTriangle(canvas, size);
        }
        break;
    }
  }

  // ==========================================
  // 1. FORMULA STAGE
  // ==========================================
  void _paintFormula(Canvas canvas, Size size) {
    final center = Offset(size.width / 2 + shakeOffset, size.height / 2);

    final frameRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: size.width * 0.9, height: 110),
      const Radius.circular(16),
    );
    final borderPaint = Paint()
      ..color = isError ? GameTheme.errorRed : GameTheme.borderSubtle
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(frameRect, borderPaint);

    final bgPaint = Paint()
      ..color = GameTheme.surface
      ..style = PaintingStyle.fill;
    canvas.drawRRect(frameRect, bgPaint);

    final displayEquation = currentInput.isEmpty
        ? level.displayContent
        : level.displayContent.replaceAll('?', currentInput);

    final textSpan = TextSpan(
      text: displayEquation,
      style: TextStyle(
        color: isError
            ? GameTheme.errorRed
            : (currentInput.isNotEmpty ? GameTheme.amberAccent : GameTheme.textWhite),
        fontSize: displayEquation.length > 18 ? 22 : 28,
        fontWeight: FontWeight.w300,
        letterSpacing: 2.5,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width * 0.85);

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }

  // ==========================================
  // 2. GEOMETRY: TRIANGLE
  // ==========================================
  void _paintTriangle(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.42;

    final topVertex = Offset(center.dx, center.dy - radius);
    final leftVertex = Offset(
      center.dx - radius * math.cos(math.pi / 6),
      center.dy + radius * math.sin(math.pi / 6),
    );
    final rightVertex = Offset(
      center.dx + radius * math.cos(math.pi / 6),
      center.dy + radius * math.sin(math.pi / 6),
    );

    final linePaint = Paint()
      ..color = GameTheme.borderSubtle
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(topVertex.dx, topVertex.dy)
      ..lineTo(leftVertex.dx, leftVertex.dy)
      ..lineTo(rightVertex.dx, rightVertex.dy)
      ..close();

    canvas.drawPath(path, linePaint);
    canvas.drawLine(topVertex, center, linePaint);
    canvas.drawLine(leftVertex, center, linePaint);
    canvas.drawLine(rightVertex, center, linePaint);

    final nodes = level.nodes ?? [];
    for (final node in nodes) {
      final pos = node.id == 'top'
          ? topVertex
          : node.id == 'left'
              ? leftVertex
              : node.id == 'right'
                  ? rightVertex
                  : center;

      if (node.isTarget) {
        final targetPos = Offset(pos.dx + shakeOffset, pos.dy);
        _drawTargetNode(canvas, targetPos, 34.0 * pulseScale);
      } else {
        _drawStandardNode(canvas, pos, 26.0, node.displayValue);
      }
    }
  }

  // ==========================================
  // 3. GEOMETRY: CIRCLES
  // ==========================================
  void _paintCircles(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final circleRadius = math.min(size.width, size.height) * 0.32;
    final offset = circleRadius * 0.65;

    final leftCenter = Offset(center.dx - offset, center.dy);
    final rightCenter = Offset(center.dx + offset, center.dy);

    final circlePaint = Paint()
      ..color = GameTheme.borderActive
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0x0AFFFFFF)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(leftCenter, circleRadius, fillPaint);
    canvas.drawCircle(leftCenter, circleRadius, circlePaint);
    canvas.drawCircle(rightCenter, circleRadius, fillPaint);
    canvas.drawCircle(rightCenter, circleRadius, circlePaint);

    final nodes = level.nodes ?? [];
    for (final node in nodes) {
      Offset pos;
      if (node.id.contains('left')) {
        pos = Offset(leftCenter.dx - circleRadius * 0.35, leftCenter.dy);
      } else if (node.id.contains('right')) {
        pos = Offset(rightCenter.dx + circleRadius * 0.35, rightCenter.dy);
      } else {
        pos = center;
      }

      if (node.isTarget) {
        final targetPos = Offset(pos.dx + shakeOffset, pos.dy);
        _drawTargetNode(canvas, targetPos, 32.0 * pulseScale);
      } else {
        _drawStandardNode(canvas, pos, 26.0, node.displayValue);
      }
    }
  }

  // ==========================================
  // 4. GRID SEQUENCE
  // ==========================================
  void _paintGrid(Canvas canvas, Size size) {
    final gridSize = math.min(size.width, size.height) * 0.85;
    final startX = (size.width - gridSize) / 2;
    final startY = (size.height - gridSize) / 2;
    final cellSize = gridSize / 3;

    final outerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(startX, startY, gridSize, gridSize),
      const Radius.circular(16),
    );
    final borderPaint = Paint()
      ..color = GameTheme.borderSubtle
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(outerRect, borderPaint);

    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(startX + i * cellSize, startY),
        Offset(startX + i * cellSize, startY + gridSize),
        borderPaint,
      );
      canvas.drawLine(
        Offset(startX, startY + i * cellSize),
        Offset(startX + gridSize, startY + i * cellSize),
        borderPaint,
      );
    }

    final nodes = level.nodes ?? [];
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        final index = row * 3 + col;
        if (index >= nodes.length) continue;
        final node = nodes[index];
        final cellCenter = Offset(
          startX + col * cellSize + cellSize / 2,
          startY + row * cellSize + cellSize / 2,
        );

        if (node.isTarget) {
          final targetPos = Offset(cellCenter.dx + shakeOffset, cellCenter.dy);
          _drawTargetNode(canvas, targetPos, 28.0 * pulseScale);
        } else {
          _drawCellText(canvas, cellCenter, node.displayValue);
        }
      }
    }
  }

  // ==========================================
  // HELPERS
  // ==========================================
  void _drawStandardNode(Canvas canvas, Offset center, double radius, String value) {
    final fillPaint = Paint()
      ..color = GameTheme.surfaceElevated
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, fillPaint);

    final borderPaint = Paint()
      ..color = GameTheme.borderSubtle
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, borderPaint);

    final textSpan = TextSpan(
      text: value,
      style: const TextStyle(
        color: GameTheme.textWhite,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }

  void _drawTargetNode(Canvas canvas, Offset center, double radius) {
    final borderColor = isError
        ? GameTheme.errorRed
        : GameTheme.amberAccent;

    final glowPaint = Paint()
      ..color = borderColor.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: radius * 2.2, height: radius * 2.2),
        const Radius.circular(10),
      ),
      glowPaint,
    );

    final tilePaint = Paint()
      ..color = GameTheme.surface
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: radius * 2.0, height: radius * 2.0),
        const Radius.circular(8),
      ),
      tilePaint,
    );

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: radius * 2.0, height: radius * 2.0),
        const Radius.circular(8),
      ),
      borderPaint,
    );

    final displayText = currentInput.isEmpty ? '?' : currentInput;
    final textSpan = TextSpan(
      text: displayText,
      style: TextStyle(
        color: isError ? GameTheme.errorRed : GameTheme.amberAccent,
        fontSize: currentInput.length > 2 ? 18 : 22,
        fontWeight: FontWeight.w600,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }

  void _drawCellText(Canvas canvas, Offset center, String text) {
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(
        color: GameTheme.textWhite,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant PuzzleCanvasPainter oldDelegate) {
    return oldDelegate.currentInput != currentInput ||
        oldDelegate.shakeOffset != shakeOffset ||
        oldDelegate.isError != isError ||
        oldDelegate.pulseScale != pulseScale ||
        oldDelegate.level.levelNumber != level.levelNumber;
  }
}
