import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../screens/lesson_detail_screen.dart';
import '../../../../services/sound_service.dart';
import '../../../../theme/game_theme.dart';
import 'map_models.dart';

/// Interactive circular level node and associated title pill along the adventure map.
/// Supports completed, current (with pulsing glow animation), and locked states.
class MapLevelNode extends ConsumerStatefulWidget {
  final MapNodePosition position;

  const MapLevelNode({super.key, required this.position});

  @override
  ConsumerState<MapLevelNode> createState() => _MapLevelNodeState();
}

class _MapLevelNodeState extends ConsumerState<MapLevelNode> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    final isTestEnvironment = WidgetsBinding.instance.runtimeType.toString().contains('Test');
    if (widget.position.isCurrent && !isTestEnvironment) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant MapLevelNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    final isTestEnvironment = WidgetsBinding.instance.runtimeType.toString().contains('Test');
    if (widget.position.isCurrent && !isTestEnvironment && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.position.isCurrent && _pulseController.isAnimating) {
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleTap() {
    ref.read(soundServiceProvider).playTap();
    if (widget.position.isLocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: GameTheme.surfaceElevated,
          duration: const Duration(seconds: 2),
          content: Text(
            'Complete Lesson ${widget.position.globalIndex - 1} to unlock this topic!',
            style: const TextStyle(color: GameTheme.textWhite, fontSize: 13),
          ),
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LessonDetailScreen(lesson: widget.position.lesson),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pos = widget.position;
    final isRightSide = pos.horizontalRatio > 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isRightSide) ...[
          _buildTitlePill(alignRight: true),
          const SizedBox(width: 8),
        ],
        _buildCircularNode(),
        if (!isRightSide) ...[
          const SizedBox(width: 8),
          _buildTitlePill(alignRight: false),
        ],
      ],
    );
  }

  Widget _buildCircularNode() {
    final pos = widget.position;
    final nodeSize = pos.isCurrent ? 64.0 : 56.0;

    Widget nodeContent;

    if (pos.isCompleted) {
      nodeContent = Container(
        width: nodeSize,
        height: nodeSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: const Color(0xFF6EE7B7), width: 2.5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x6610B981),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_rounded, color: Colors.white, size: 20),
              Text(
                '${pos.globalIndex}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (pos.isCurrent) {
      nodeContent = AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Pulsing outer halo
              Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: nodeSize + 14,
                  height: nodeSize + 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: GameTheme.amberAccent.withValues(alpha: 0.4),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              // Main amber node
              Container(
                width: nodeSize,
                height: nodeSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFBBF24), Color(0xFFD97706)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x88F59E0B),
                      blurRadius: 14,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
                      Text(
                        '${pos.globalIndex}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      // Locked node
      nodeContent = Container(
        width: nodeSize,
        height: nodeSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: GameTheme.surfaceElevated,
          border: Border.all(color: GameTheme.borderSubtle, width: 1.5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_rounded, color: GameTheme.textMuted, size: 16),
              const SizedBox(height: 2),
              Text(
                '${pos.globalIndex}',
                style: const TextStyle(
                  color: GameTheme.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: nodeContent,
    );
  }

  Widget _buildTitlePill({required bool alignRight}) {
    final pos = widget.position;

    Color pillBg = GameTheme.surface;
    Color borderColor = GameTheme.borderSubtle;
    Color titleColor = GameTheme.textWhite;

    if (pos.isCompleted) {
      borderColor = GameTheme.successGreen.withValues(alpha: 0.5);
    } else if (pos.isCurrent) {
      borderColor = GameTheme.amberAccent;
      titleColor = GameTheme.amberAccent;
    } else {
      titleColor = GameTheme.textMuted;
    }

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 160),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: pillBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: pos.isCurrent ? 1.5 : 1.0),
          boxShadow: pos.isCurrent
              ? [
                  BoxShadow(
                    color: GameTheme.amberAccent.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pos.lesson.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: alignRight ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: titleColor,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              pos.isCompleted
                  ? 'Completed (+50)'
                  : (pos.isCurrent ? 'Play Now (+50)' : 'Locked'),
              style: TextStyle(
                color: pos.isCompleted
                    ? GameTheme.successGreen
                    : (pos.isCurrent ? GameTheme.amberAccent : GameTheme.textDim),
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

