class LegalSection {
  final String title;
  final String body;
  final List<String>? bulletPoints;

  const LegalSection({
    required this.title,
    required this.body,
    this.bulletPoints,
  });
}

class LegalDocument {
  final String title;
  final String subtitle;
  final String lastUpdated;
  final String appName;
  final List<LegalSection> sections;

  const LegalDocument({
    required this.title,
    required this.subtitle,
    required this.lastUpdated,
    required this.appName,
    required this.sections,
  });
}

class LegalData {
  const LegalData._();

  static const LegalDocument privacyPolicy = LegalDocument(
    title: 'PRIVACY POLICY',
    subtitle: 'OFFLINE-FIRST PRIVACY & ZERO TELEMETRY',
    lastUpdated: 'November 7, 2026',
    appName: 'Math Riddle',
    sections: [
      LegalSection(
        title: '1. Introduction & Overview',
        body: 'Welcome to Math Riddle ("Application", "Game", "We", "Us", or "Our"). We respect your privacy and are deeply committed to protecting personal data. This Privacy Policy details our offline-first architectural principles, minimal technical data interactions, and compliance with GDPR, CCPA, COPPA, and Google Play Family Policies.',
      ),
      LegalSection(
        title: '2. Offline-First Architecture & Zero Telemetry',
        body: 'Unlike typical mobile puzzle games that transmit keystrokes and session tracking to external servers, Math Riddle operates on an offline-first privacy standard:',
        bulletPoints: [
          'No Keystroke Telemetry: When you enter answers into the virtual numeric keypad, all validation occurs locally on your device. Guesses are never transmitted or logged.',
          'No Account Required: You can access all 500 levels, 36 learning academy topics, and endless challenges without signing up, entering an email, or linking social accounts.',
          'No Location Tracking: Math Riddle never requests or accesses coarse or fine GPS location coordinates.',
          'Zero Data Brokering: We never sell, rent, trade, or broker personal user information to any third parties.',
        ],
      ),
      LegalSection(
        title: '3. Data Stored Locally on Your Device',
        body: 'To persist your progress across game launches, Math Riddle saves necessary gameplay data inside your device\'s private sandbox storage (SharedPreferences / NSUserDefaults):',
        bulletPoints: [
          'Current highest unlocked level (1 to 500) and list of completed level numbers.',
          'Cumulative total score and unlocked Learning Academy lesson identifiers.',
          'Speedrun challenge statistics (attempts, correct answers, highest streak, unlocked tiers).',
          'Current heart balance (0 to 5) and timestamps for the 20-minute offline heart regeneration cooldown.',
          'Local cryptographic HMAC-SHA256 checksums to verify save-file integrity against tampering.',
          'User audio, vibration, and personalized ad preferences.',
        ],
      ),
      LegalSection(
        title: '4. Third-Party Advertisements (Google AdMob)',
        body: 'Math Riddle is free to play and supported by polite, non-intrusive advertisements served through Google Mobile Ads (AdMob):',
        bulletPoints: [
          'Banner Ads: Shown at the bottom of select menu screens.',
          'Polite Interstitials: Only displayed on milestone levels (every 9th solved riddle) or when exiting completed challenge sessions. Ads NEVER interrupt active 15-second timed rounds.',
          'Rewarded Videos: Optional videos initiated solely by player choice to unlock hints, view solutions, or refill hearts.',
          'Depending on your consent and device settings, Google AdMob may process anonymous mobile advertising IDs (AAID/IDFA) and crash diagnostics.',
        ],
      ),
      LegalSection(
        title: '5. In-App Purchases & Billing',
        body: 'Optional premium upgrades (such as PRO Unlock / Remove Ads) are processed exclusively through Google Play Billing or Apple StoreKit. We never see, store, or process your credit card numbers, banking information, or billing address. We receive only an anonymous cryptographic token confirming your license.',
      ),
      LegalSection(
        title: '6. Children\'s Privacy (COPPA Compliance)',
        body: 'Math Riddle is designed for general audiences and math enthusiasts of all ages. We do not knowingly collect personal identifiable information from children under 13 (or under 16 in the EEA). In accordance with COPPA and Google Play Family Policy, ads shown to younger audiences are non-personalized and family-safe.',
      ),
      LegalSection(
        title: '7. European Union (GDPR) & UK Rights',
        body: 'If you reside in the EEA or UK, you enjoy statutory rights under the GDPR:',
        bulletPoints: [
          'Right to Access: You can view all your stored progress directly within the game UI.',
          'Right to Erasure: Tap DELETE DATA in the in-app Settings menu at any time to irreversibly purge all local saves, scores, and preferences.',
          'Right to Withdraw Consent: Toggle personalized advertising preferences on or off anytime under Settings > ADS SETTING.',
        ],
      ),
      LegalSection(
        title: '8. California Consumer Privacy (CCPA / CPRA)',
        body: 'Under California law, California residents have the right to know what personal data is processed, request deletion, and opt out of the sale or sharing of personal data. We do not sell personal data. You may disable cross-context behavioral advertising via the in-app Settings toggle or operating system settings.',
      ),
      LegalSection(
        title: '9. Anti-Cheat & Client Integrity',
        body: 'Math Riddle employs local HMAC-SHA256 checksums and clock rollback detection. If clock rollback (>60s) or memory tampering is detected, heart regeneration is paused and impossible scores are clamped to the mathematical maximum (computeMaximumValidScore). These checks run strictly on-device without network transmission.',
      ),
      LegalSection(
        title: '10. Data Retention & Deletion',
        body: 'Because we maintain no remote user databases, you have complete control over data retention. Tapping DELETE DATA in Settings immediately deletes all local records. Uninstalling the app also permanently destroys all local storage.',
      ),
      LegalSection(
        title: '11. Contact Information',
        body: 'If you have questions regarding this Privacy Policy or wish to exercise your privacy rights, please contact our Data Protection Officer at privacy@valcire.com or support@valcire.com.',
      ),
    ],
  );

  static const LegalDocument termsAndConditions = LegalDocument(
    title: 'TERMS AND CONDITIONS',
    subtitle: 'END USER LICENSE AGREEMENT & TERMS OF SERVICE',
    lastUpdated: 'November 7, 2026',
    appName: 'Math Riddle',
    sections: [
      LegalSection(
        title: '1. Agreement to Terms',
        body: 'These Terms and Conditions constitute a legally binding agreement between you ("User" or "Player") and Valcire Gaming & Mathematical Software Studio ("Valcire", "We", "Us"). By downloading, installing, or playing Math Riddle, you agree to be bound by these Terms. If you do not agree, you must immediately uninstall and discontinue using the Application.',
      ),
      LegalSection(
        title: '2. Eligibility & Parental Guidance',
        body: 'Math Riddle is designed for educational and cognitive recreation. If you are under the legal age of majority in your jurisdiction, you represent that you have obtained permission from a parent or legal guardian to download the app and make any optional in-app purchases.',
      ),
      LegalSection(
        title: '3. Limited License & Intellectual Property',
        body: 'Valcire grants you a personal, revocable, non-exclusive, non-transferable, non-commercial limited license to use Math Riddle on your personal mobile devices.',
        bulletPoints: [
          '500 Puzzles & Solutions: Handcrafted levels 1–80, procedural generation formulas for levels 81–500, hints, and explanations are proprietary intellectual properties of Valcire.',
          '36 Academy Lessons: The structured 6-stage mathematics learning journey, pedagogy, and practice questions are protected by copyright laws.',
          'Vector Graphics & Audio: Custom vector puzzle canvases, adventure map curves, stage milestone badges, and sound effects may not be ripped, copied, or redistributed.',
          'Strict Prohibition: You may not decompile, reverse engineer, extract riddle dictionaries, or use automated bots/scripts to scrape solutions or simulate inputs.',
        ],
      ),
      LegalSection(
        title: '4. Virtual Hearts, Points, and Score Rules',
        body: 'The game features an energy pacing mechanism (Hearts) and a cumulative score system:',
        bulletPoints: [
          'Players have a maximum of 5 hearts. Wrong answers deduct 1 heart.',
          'Hearts refill automatically at 1 heart every 20 minutes of elapsed real time.',
          'No Cash Value: Hearts, score points, tier badges, and rankings are virtual gameplay metrics with no monetary value. They cannot be sold, traded, or redeemed for cash.',
          'Anti-Tamper Rights: We reserve the right to clamp or reset scores if local save data reflects memory hacking, clock tampering, or impossible progression.',
        ],
      ),
      LegalSection(
        title: '5. In-App Purchases, Restores & Refunds',
        body: 'Optional in-app purchases (such as PRO Unlock / Remove Ads) are governed by the store policies of Google Play or Apple App Store:',
        bulletPoints: [
          'Purchases can be restored on any device sharing the same store account using the RESTORE PURCHASE button in Settings.',
          'Refunds are processed according to Google Play and Apple App Store standard refund guidelines. Valcire does not directly store credit card details or issue merchant chargebacks.',
          'PRO Unlock permanently removes non-rewarded banner and interstitial advertisements.',
        ],
      ),
      LegalSection(
        title: '6. User Conduct & Fair Play',
        body: 'You agree to use Math Riddle in good faith. You shall not use emulators, memory modification tools (e.g. Cheat Engine, GameGuardian), proxy ad-blockers, or automated tap bots to fraudulently manipulate ad rewards, bypass heart cooldowns, or inflate scores.',
      ),
      LegalSection(
        title: '7. Cognitive & Educational Disclaimer',
        body: 'Math Riddle is developed for mental training, logical reasoning, and mathematical enjoyment. While the curriculum reinforces sound mathematics, the Application is provided for recreational education only and makes no medical claims to treat, diagnose, or rehabilitate neurological or cognitive disorders.',
      ),
      LegalSection(
        title: '8. Disclaimer of Warranties',
        body: 'MATH RIDDLE IS PROVIDED "AS IS" AND "AS AVAILABLE" WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED. TO THE MAXIMUM EXTENT PERMITTED BY LAW, VALCIRE DISCLAIMS ALL WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND UNINTERRUPTED ERROR-FREE OPERATION.',
      ),
      LegalSection(
        title: '9. Limitation of Liability',
        body: 'TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL VALCIRE OR ITS DEVELOPERS BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, OR CONSEQUENTIAL DAMAGES ARISING OUT OF YOUR USE OF THE APPLICATION. OUR TOTAL AGGREGATE LIABILITY SHALL NOT EXCEED THE AMOUNT ACTUALLY PAID BY YOU IN IN-APP PURCHASES WITHIN THE PRECEDING SIX MONTHS OR \$50.00 USD.',
      ),
      LegalSection(
        title: '10. Governing Law & Dispute Resolution',
        body: 'These Terms are governed by the laws of the State of California, USA, without regard to conflict of law principles. Any legal dispute shall be subject to the exclusive jurisdiction of the state and federal courts in San Francisco County, California.',
      ),
      LegalSection(
        title: '11. Termination & Data Reset',
        body: 'You may terminate this agreement at any time by wiping your local data via Settings > DELETE DATA and uninstalling the Application. Valcire reserves the right to modify or discontinue any part of the Application at any time.',
      ),
      LegalSection(
        title: '12. Contact Information',
        body: 'For legal questions, copyright inquiries, or terms notices, please contact us at legal@valcire.com or support@valcire.com.',
      ),
    ],
  );
}

