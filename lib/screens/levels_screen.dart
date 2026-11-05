import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../theme/game_theme.dart';
import '../widgets/score_badge.dart';
import 'riddle_screen.dart';

class LevelsScreen extends ConsumerWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressServiceProvider);
    final gameState = ref.watch(gameControllerProvider);
    final unlockedIndex = progress.unlockedLevelIndex;
    final completedLevels = progress.completedLevelsList;

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'LEVEL SELECT',
          style: TextStyle(
            color: GameTheme.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.0,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: ScoreBadge(compact: true),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // 20-Box Uniform Responsive Grid (4 columns × 5 rows or 5 columns × 4 rows)
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 20, // Exactly 20 uniform containers
                  itemBuilder: (context, index) {
                    final levelNum = index + 1;
                    // Box 1 unlocked by default; Level N unlocks strictly when Level N-1 solved
                    final isUnlocked = levelNum <= unlockedIndex;
                    final isCompleted = completedLevels.contains(levelNum);
                    final isCurrent = gameState.activeLevelNumber == levelNum;

                    return _buildLevelContainer(
                      context: context,
                      ref: ref,
                      levelNum: levelNum,
                      isUnlocked: isUnlocked,
                      isCompleted: isCompleted,
                      isCurrent: isCurrent,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelContainer({
    required BuildContext context,
    required WidgetRef ref,
    required int levelNum,
    required bool isUnlocked,
    required bool isCompleted,
    required bool isCurrent,
  }) {
    Color borderColor = GameTheme.borderSubtle;
    Color tileColor = GameTheme.surface;
    Color textColor = GameTheme.textMuted;

    if (isCurrent) {
      borderColor = GameTheme.amberAccent;
      tileColor = GameTheme.surfaceElevated;
      textColor = GameTheme.amberAccent;
    } else if (isCompleted) {
      borderColor = GameTheme.borderActive;
      tileColor = GameTheme.surface;
      textColor = GameTheme.textWhite;
    } else if (isUnlocked) {
      borderColor = GameTheme.borderActive;
      tileColor = GameTheme.surface;
      textColor = GameTheme.textLight;
    } else {
      // Locked state: Dim background, muted outline
      tileColor = GameTheme.background;
      borderColor = GameTheme.borderSubtle;
      textColor = GameTheme.textDim;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: isUnlocked
            ? () {
                ref.read(gameControllerProvider.notifier).selectLevel(levelNum);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const RiddleScreen()),
                );
              }
            : null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: isCurrent ? 2.0 : 1.0,
            ),
          ),
          child: isUnlocked
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      '$levelNum',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    if (isCompleted)
                      const Positioned(
                        bottom: 6,
                        child: Icon(
                          Icons.check_rounded,
                          color: GameTheme.amberAccent,
                          size: 14,
                        ),
                      ),
                  ],
                )
              : const Icon(
                  Icons.lock_outline_rounded,
                  color: GameTheme.textDim,
                  size: 20,
                ),
        ),
      ),
    );
  }
}
