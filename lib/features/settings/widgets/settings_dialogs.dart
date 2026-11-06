import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/game_controller.dart';
import '../../../services/progress_service.dart';
import '../../../theme/game_theme.dart';
import 'legal_document_dialog.dart';

/// Centralized confirmation and legal dialogs for the settings screen.
class SettingsDialogs {
  SettingsDialogs._();

  static void showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    ProgressService progress,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: GameTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text(
          'RESET PROGRESS?',
          style: TextStyle(
            color: GameTheme.errorRed,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        content: const Text(
          'This will permanently reset your solved levels, timer records, and unlocked stages. You will return to Level 1.',
          style: TextStyle(color: GameTheme.textMuted, fontSize: 13, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('CANCEL', style: TextStyle(color: GameTheme.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: GameTheme.errorRed,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await progress.resetAllData();
              ref.invalidate(gameControllerProvider);
              if (ctx.mounted) Navigator.of(ctx).pop();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All local data and level progress reset.')),
                );
              }
            },
            child: const Text('CONFIRM RESET'),
          ),
        ],
      ),
    );
  }

  static void showPrivacyPolicy(BuildContext context) {
    LegalDocumentDialog.showPrivacyPolicy(context);
  }

  static void showTermsAndConditions(BuildContext context) {
    LegalDocumentDialog.showTermsAndConditions(context);
  }

  static void showLegalDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('privacy')) {
      LegalDocumentDialog.showPrivacyPolicy(context);
    } else if (lowerTitle.contains('term')) {
      LegalDocumentDialog.showTermsAndConditions(context);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: GameTheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Text(
            title,
            style: const TextStyle(
              color: GameTheme.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(
              color: GameTheme.textMuted,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('CLOSE', style: TextStyle(color: GameTheme.amberAccent)),
            ),
          ],
        ),
      );
    }
  }
}
