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

  // Reusable static Paint instances to eliminate per-frame heap allocations at 60 FPS
  static final Paint _strokePaint = Paint()..style = PaintingStyle.stroke;
  static final Paint _fillPaint = Paint()..style = PaintingStyle.fill;
  static final TextPainter _cachedTextPainter = TextPainter(textDirection: TextDirection.ltr);

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

    final displayEquation = currentInput.isEmpty
        ? level.displayContent
        : level.displayContent.replaceAll('?', currentInput);

    // Responsive typography based on equation / word problem length
    final double fontSize;
    final double letterSpacing;
    if (displayEquation.length > 55) {
      fontSize = 15;
      letterSpacing = 0.8;
    } else if (displayEquation.length > 35) {
      fontSize = 17;
      letterSpacing = 1.2;
    } else if (displayEquation.length > 20) {
      fontSize = 21;
      letterSpacing = 1.8;
    } else {
      fontSize = 28;
      letterSpacing = 2.5;
    }

    final double frameHeight = math.min(
      size.height * 0.78,
      math.max(110.0, 100.0 + (displayEquation.length > 45 ? 30.0 : 0.0)),
    );

    final frameRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: size.width * 0.92, height: frameHeight),
      const Radius.circular(16),
    );

    // Frame Fill
    _fillPaint.color = GameTheme.surface;
    canvas.drawRRect(frameRect, _fillPaint);

    // Frame Border
    _strokePaint
      ..color = isError ? GameTheme.errorRed : GameTheme.borderSubtle
      ..strokeWidth = 1.5;
    canvas.drawRRect(frameRect, _strokePaint);

    final textSpan = TextSpan(
      text: displayEquation,
      style: TextStyle(
        color: isError
            ? GameTheme.errorRed
            : (currentInput.isNotEmpty ? GameTheme.amberAccent : GameTheme.textWhite),
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        letterSpacing: letterSpacing,
        height: 1.35,
      ),
    );

    _paintCenteredText(canvas, center, textSpan, maxWidth: size.width * 0.84);
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

    _strokePaint
      ..color = GameTheme.borderSubtle
      ..strokeWidth = 2.0;

    final path = Path()
      ..moveTo(topVertex.dx, topVertex.dy)
      ..lineTo(leftVertex.dx, leftVertex.dy)
      ..lineTo(rightVertex.dx, rightVertex.dy)
      ..close();

    canvas.drawPath(path, _strokePaint);
    canvas.drawLine(topVertex, center, _strokePaint);
    canvas.drawLine(leftVertex, center, _strokePaint);
    canvas.drawLine(rightVertex, center, _strokePaint);

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

    _fillPaint.color = const Color(0x0AFFFFFF);
    canvas.drawCircle(leftCenter, circleRadius, _fillPaint);
    canvas.drawCircle(rightCenter, circleRadius, _fillPaint);

    _strokePaint
      ..color = GameTheme.borderActive
      ..strokeWidth = 2.0;
    canvas.drawCircle(leftCenter, circleRadius, _strokePaint);
    canvas.drawCircle(rightCenter, circleRadius, _strokePaint);

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

    _strokePaint
      ..color = GameTheme.borderSubtle
      ..strokeWidth = 1.5;
    canvas.drawRRect(outerRect, _strokePaint);

    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(startX + i * cellSize, startY),
        Offset(startX + i * cellSize, startY + gridSize),
        _strokePaint,
      );
      canvas.drawLine(
        Offset(startX, startY + i * cellSize),
        Offset(startX + gridSize, startY + i * cellSize),
        _strokePaint,
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
    _fillPaint.color = GameTheme.surfaceElevated;
    canvas.drawCircle(center, radius, _fillPaint);

    _strokePaint
      ..color = GameTheme.borderSubtle
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius, _strokePaint);

    const textSpan = TextSpan(
      style: TextStyle(
        color: GameTheme.textWhite,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );

    _paintCenteredText(
      canvas,
      center,
      TextSpan(text: value, style: textSpan.style),
    );
  }

  void _drawTargetNode(Canvas canvas, Offset center, double radius) {
    final borderColor = isError ? GameTheme.errorRed : GameTheme.amberAccent;

    // Outer Glow
    _fillPaint.color = borderColor.withValues(alpha: 0.15);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: radius * 2.2, height: radius * 2.2),
        const Radius.circular(10),
      ),
      _fillPaint,
    );

    // Inner Tile Background
    _fillPaint.color = GameTheme.surface;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: radius * 2.0, height: radius * 2.0),
        const Radius.circular(8),
      ),
      _fillPaint,
    );

    // Inner Border
    _strokePaint
      ..color = borderColor
      ..strokeWidth = 2.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: radius * 2.0, height: radius * 2.0),
        const Radius.circular(8),
      ),
      _strokePaint,
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

    _paintCenteredText(canvas, center, textSpan);
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
    _paintCenteredText(canvas, center, textSpan);
  }

  void _paintCenteredText(Canvas canvas, Offset center, TextSpan textSpan, {double? maxWidth}) {
    _cachedTextPainter.text = textSpan;
    _cachedTextPainter.textAlign = TextAlign.center;
    if (maxWidth != null) {
      _cachedTextPainter.layout(maxWidth: maxWidth);
    } else {
      _cachedTextPainter.layout();
    }

    _cachedTextPainter.paint(
      canvas,
      Offset(center.dx - _cachedTextPainter.width / 2, center.dy - _cachedTextPainter.height / 2),
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
