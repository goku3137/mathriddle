import 'package:flutter/material.dart';
import '../../../theme/game_theme.dart';
import '../data/legal_data.dart';

/// Full-screen or large modal viewer for Privacy Policy and Terms and Conditions.
/// Features high-contrast dark theme typography, gold accents, structured sections,
/// and smooth scrolling in full alignment with the Math Riddle design system.
class LegalDocumentDialog extends StatelessWidget {
  final LegalDocument document;
  final IconData icon;

  const LegalDocumentDialog({
    super.key,
    required this.document,
    required this.icon,
  });

  static Future<void> showPrivacyPolicy(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const LegalDocumentDialog(
        document: LegalData.privacyPolicy,
        icon: Icons.shield_outlined,
      ),
    );
  }

  static Future<void> showTermsAndConditions(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const LegalDocumentDialog(
        document: LegalData.termsAndConditions,
        icon: Icons.gavel_rounded,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final maxHeight = media.size.height * 0.82;
    final maxWidth = (media.size.width * 0.92).clamp(320.0, 560.0);

    return Dialog(
      backgroundColor: GameTheme.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: GameTheme.borderSubtle, width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: const BoxDecoration(
                color: GameTheme.surfaceElevated,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(
                  bottom: BorderSide(color: GameTheme.borderSubtle),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: GameTheme.amberGlow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: GameTheme.amberAccent, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.title,
                          style: const TextStyle(
                            color: GameTheme.textWhite,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${document.appName} • ${document.lastUpdated}',
                          style: const TextStyle(
                            color: GameTheme.textMuted,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: GameTheme.textMuted, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Flexible(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subtitle Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: GameTheme.amberGlow,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: GameTheme.amberAccent.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          document.subtitle,
                          style: const TextStyle(
                            color: GameTheme.amberAccent,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Document Sections
                      ...document.sections.map((section) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                section.title,
                                style: const TextStyle(
                                  color: GameTheme.textWhite,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                section.body,
                                style: const TextStyle(
                                  color: GameTheme.textLight,
                                  fontSize: 12.5,
                                  height: 1.5,
                                ),
                              ),
                              if (section.bulletPoints != null) ...[
                                const SizedBox(height: 6),
                                ...section.bulletPoints!.map((bullet) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 4, left: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 5, right: 8),
                                          child: Icon(
                                            Icons.circle,
                                            size: 5,
                                            color: GameTheme.amberAccent,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            bullet,
                                            style: const TextStyle(
                                              color: GameTheme.textMuted,
                                              fontSize: 12.0,
                                              height: 1.45,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Confirmation Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: const BoxDecoration(
                color: GameTheme.surfaceElevated,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                border: Border(
                  top: BorderSide(color: GameTheme.borderSubtle),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GameTheme.amberAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'CLOSE',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

