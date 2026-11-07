import 'package:flutter/material.dart';
import 'map_models.dart';

/// Renders the continuous, organic winding road connecting lesson nodes on the adventure map.
/// Employs cubic Bézier curves and dual-layer rendering (underlay track + glowing active stepping trail).
class MapPathPainter extends CustomPainter {
  final List<MapNodePosition> nodes;

  const MapPathPainter({required this.nodes});

  @override
  void paint(Canvas canvas, Size size) {
    if (nodes.length < 2) return;

    // Paint specifications
    final underlayPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final activeTrackPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final lockedTrackPaint = Paint()
      ..color = const Color(0xFF334155)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final activeSteppingPaint = Paint()
      ..color = const Color(0xFFFEF3C7)
      ..style = PaintingStyle.fill;

    final lockedSteppingPaint = Paint()
      ..color = const Color(0xFF475569)
      ..style = PaintingStyle.fill;

    // Iterate through adjacent node pairs to construct smooth cubic S-curves
    for (int i = 0; i < nodes.length - 1; i++) {
      final p0 = nodes[i].center;
      final p1 = nodes[i + 1].center;
      final dy = p1.dy - p0.dy;

      // Cubic Bézier control points leaving vertically from p0 and arriving vertically into p1
      final c1 = Offset(p0.dx, p0.dy + dy * 0.5);
      final c2 = Offset(p1.dx, p1.dy - dy * 0.5);

      final segmentPath = Path()
        ..moveTo(p0.dx, p0.dy)
        ..cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, p1.dx, p1.dy);

      // Layer 1: Road underlay base
      canvas.drawPath(segmentPath, underlayPaint);

      // Layer 2: Segment track (Gold if unlocked/completed; Slate if locked)
      final isSegmentActive = nodes[i].isCompleted || nodes[i].isCurrent;
      canvas.drawPath(segmentPath, isSegmentActive ? activeTrackPaint : lockedTrackPaint);

      // Layer 3: Stepping dots along the road for authentic game-trail texture
      for (final metric in segmentPath.computeMetrics()) {
        const double stepDistance = 22.0;
        final double length = metric.length;
        for (double d = stepDistance; d < length - 15; d += stepDistance) {
          final tangent = metric.getTangentForOffset(d);
          if (tangent != null) {
            canvas.drawCircle(
              tangent.position,
              isSegmentActive ? 2.5 : 1.8,
              isSegmentActive ? activeSteppingPaint : lockedSteppingPaint,
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant MapPathPainter oldDelegate) {
    if (oldDelegate.nodes.length != nodes.length) return true;
    for (int i = 0; i < nodes.length; i++) {
      if (oldDelegate.nodes[i].center != nodes[i].center ||
          oldDelegate.nodes[i].isCompleted != nodes[i].isCompleted ||
          oldDelegate.nodes[i].isCurrent != nodes[i].isCurrent ||
          oldDelegate.nodes[i].isLocked != nodes[i].isLocked) {
        return true;
      }
    }
    return false;
  }
}

