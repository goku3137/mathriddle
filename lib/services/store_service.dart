import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service responsible for launching the Google Play Store page and review prompt.
class StoreService {
  StoreService._();

  /// Canonical Android package identifier for Math Riddles on Google Play Console.
  static const String applicationId = 'com.valcire.mathriddle';

  /// Primary market URI that opens directly inside the Google Play Store client.
  static final Uri _marketUri = Uri.parse('market://details?id=$applicationId');

  /// Fallback HTTPS URI that opens in any mobile browser if Play Store is absent.
  static final Uri _webUri = Uri.parse('https://play.google.com/store/apps/details?id=$applicationId');

  /// Opens the Google Play Store app listing for rating and reviews.
  /// Tries the direct `market://` deep link first, falling back to the web link.
  static Future<bool> openPlayStoreReview() async {
    try {
      if (await canLaunchUrl(_marketUri)) {
        return await launchUrl(_marketUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(_webUri)) {
        return await launchUrl(_webUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Failed to launch Play Store intent: $e');
      // Final attempt directly with web browser
      try {
        return await launchUrl(_webUri, mode: LaunchMode.externalApplication);
      } catch (inner) {
        debugPrint('Failed to launch Play Store web fallback: $inner');
        return false;
      }
    }
    return false;
  }
}

