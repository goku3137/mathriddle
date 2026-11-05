import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/game_controller.dart';
import '../services/sound_service.dart';
import '../theme/game_theme.dart';
import '../widgets/score_badge.dart';
import 'riddle_screen.dart';

class LevelsScreen extends ConsumerStatefulWidget {
  const LevelsScreen({super.key});

  @override
  ConsumerState<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends ConsumerState<LevelsScreen> {
  static const int _levelsPerPack = 100;
  late int _currentPack;

  @override
  void initState() {
    super.initState();
    // Default to the pack containing the highest unlocked level, clamped to valid pack range
    final progress = ref.read(progressServiceProvider);
    final totalLevels = ref.read(levelRepositoryProvider).totalLevelsCount;
    final totalPacks = (totalLevels / _levelsPerPack).ceil();
    final unlocked = progress.unlockedLevelIndex;
    final maxPack = totalPacks > 0 ? totalPacks - 1 : 0;
    _currentPack = ((unlocked - 1) ~/ _levelsPerPack).clamp(0, maxPack);
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(progressServiceProvider);
    final activeLevelNumber = ref.watch(gameControllerProvider.select((s) => s.activeLevelNumber));
    final levelRepo = ref.watch(levelRepositoryProvider);

    final totalLevels = levelRepo.totalLevelsCount;
    final totalPacks = (totalLevels / _levelsPerPack).ceil();
    final unlockedIndex = progress.unlockedLevelIndex;
    final completedLevels = progress.completedLevelsList;

    final startLevel = (_currentPack * _levelsPerPack) + 1;
    final endLevel = (startLevel + _levelsPerPack - 1).clamp(1, totalLevels);

    return Scaffold(
      backgroundColor: GameTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GameTheme.textWhite, size: 20),
          onPressed: () {
            ref.read(soundServiceProvider).playTap();
            Navigator.of(context).pop();
          },
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            children: [
              // Pack Navigation Header (Supporting all 500 levels in clean 20-box packs)
              if (totalPacks > 1) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: GameTheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: GameTheme.borderSubtle),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left_rounded, color: GameTheme.textWhite),
                          onPressed: _currentPack > 0
                              ? () => setState(() => _currentPack--)
                              : null,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'PACK ${_currentPack + 1} ($startLevel–$endLevel)',
                              style: const TextStyle(
                                color: GameTheme.amberAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _getDifficultyName(_currentPack),
                              style: const TextStyle(
                                color: GameTheme.textMuted,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right_rounded, color: GameTheme.textWhite),
                          onPressed: _currentPack < totalPacks - 1
                              ? () => setState(() => _currentPack++)
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Exactly 20 Uniform Responsive Containers
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: _levelsPerPack,
                  itemBuilder: (context, index) {
                    final levelNum = startLevel + index;
                    if (levelNum > totalLevels) {
                      return const SizedBox.shrink();
                    }

                    // Strict sequential unlock progression: Level N unlocks when Level N - 1 is completed
                    final isUnlocked = levelNum <= unlockedIndex;
                    final isCompleted = completedLevels.contains(levelNum);
                    final isCurrent = activeLevelNumber == levelNum;

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
      tileColor = GameTheme.surfaceElevated;
      textColor = GameTheme.textWhite;
    } else if (isUnlocked) {
      borderColor = GameTheme.borderSubtle;
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
            ? () async {
                ref.read(soundServiceProvider).playTap();
                await ref.read(gameControllerProvider.notifier).selectLevel(levelNum);
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const RiddleScreen()),
                  );
                }
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
              ? Text(
                  '$levelNum',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
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

  String _getDifficultyName(int packIndex) {
    switch (packIndex) {
      case 0:
        return 'DIFFICULTY: EASY';
      case 1:
        return 'DIFFICULTY: EASY–INTERMEDIATE';
      case 2:
        return 'DIFFICULTY: INTERMEDIATE';
      case 3:
        return 'DIFFICULTY: ADVANCED';
      case 4:
      default:
        return 'DIFFICULTY: INSANE';
    }
  }
}
