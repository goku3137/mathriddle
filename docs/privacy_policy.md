# Privacy Policy for Math Riddle

**Last Updated:** November 7, 2026  
**Effective Date:** November 7, 2026  
**Application Name:** Math Riddle (com.valcire.mathriddle)  
**Publisher / Developer:** Valcire Gaming & Mathematical Software Studio  
**Contact Email:** privacy@valcire.com  

---

## 1. Introduction and Scope

Welcome to **Math Riddle** ("Application", "Game", "We", "Us", or "Our"). We respect your privacy and are deeply committed to protecting personal data. This Privacy Policy details our offline-first data principles, what minimal technical data may be processed, how advertisements and in-app purchases are handled, and your rights under global data protection frameworks, including:
- General Data Protection Regulation (**GDPR** - Regulation (EU) 2016/679)
- California Consumer Privacy Act (**CCPA**) and California Privacy Rights Act (**CPRA**)
- Children's Online Privacy Protection Act (**COPPA**)
- Google Play Developer Distribution Agreement and Family Policy Requirements
- Apple App Store App Privacy Guidelines

By downloading, installing, accessing, or playing Math Riddle, you acknowledge that you have read, understood, and agreed to the practices outlined in this Privacy Policy.

---

## 2. Core Architectural Principle: Offline-First & Zero Telemetry

Unlike traditional mobile games that transmit user telemetry, keystrokes, and session analytics to remote cloud servers, **Math Riddle is architected as an offline-first cognitive puzzle platform**.

### 2.1 What We Never Collect or Transmit
- **No Keystroke or Input Telemetry:** When you type numbers into the virtual 12-key numeric keypad, your guesses are validated locally on your device hardware. Keystroke sequences are never transmitted, logged, or recorded.
- **No Account Registration:** You do not need to register an account, supply an email address, link a phone number, or log in with social media (e.g., Facebook, Google Sign-In, Apple ID) to enjoy all 500 levels, the 36-lesson academy, or the infinite challenge modes.
- **No Location Tracking:** We do not request, access, or track precise or coarse GPS coordinates.
- **No Contacts or Media Access:** Math Riddle does not request runtime permissions to read contacts, photo galleries, camera, microphone, or external storage.
- **No User Profiling or Data Selling:** We do not build personal profiles, sell personal data, or broker personal information to data aggregators.

---

## 3. Information Stored Locally on Your Device

To ensure your game state persists across application launches, Math Riddle saves the following parameters locally in device-sandboxed storage (`SharedPreferences` on Android, `NSUserDefaults` on iOS):

1. **Level Progression State:**
   - The current highest unlocked level index (ranging from 1 to 500).
   - Set of completed level indices.
   - Timestamps of completed levels.
2. **Scoring and Academy Records:**
   - Cumulative total score accumulated across solved riddles, challenges, and academy lessons.
   - Set of completed Learn Academy lesson identifiers.
   - Dynamic cryptographic HMAC-SHA256 checksums used to detect memory injection or save-file tampering.
3. **Challenge Category Statistics:**
   - Per-category statistics across all 12 challenge disciplines (total attempts, cumulative correct answers, highest streak, unlocked mastery tiers 0–2, earned badge indices).
4. **Energy (Hearts) System State:**
   - Remaining heart balance (0 to 5 hearts).
   - Local timestamp of heart consumption and interval countdown for offline heart replenishment (1 heart per 20 minutes).
   - Clock verification timestamps to detect system clock manipulation.
5. **User Preferences:**
   - Sound FX toggle status (enabled/disabled).
   - Master sound volume setting (0.0 to 1.0).
   - Haptic vibration feedback toggle (enabled/disabled).
   - Personalized ads consent preference toggle.

*All data listed above resides strictly within your local device sandbox. Uninstalling the application or using the in-app "DELETE DATA" option permanently purges this data from your device.*

---

## 4. Third-Party Services and SDKs

To support the ongoing maintenance and development of Math Riddle, the application integrates industry-standard third-party SDKs for non-intrusive monetization and in-app transactions.

### 4.1 Advertising via Google AdMob (Google Mobile Ads SDK)
Math Riddle uses Google AdMob to serve polite, non-intrusive advertisements:
- **Banner Ads:** Displayed unobtrusively at the bottom of select screens.
- **Interstitial Ads:** Displayed at polite intervals (e.g., every 9 solved riddles or upon exiting an active challenge session). Interstitial ads never interrupt active 15-second timed rounds.
- **Rewarded Video Ads:** Optional videos initiated strictly by the player to receive hints, reveal mathematical solutions, or replenish depleted hearts.

#### Data Processed by Google AdMob:
Depending on your regional consent and privacy preferences, Google AdMob may process:
- IP address (used for geographic fraud prevention and regional ad compliance).
- Mobile Advertising Identifiers (Google Advertising ID / AAID on Android, Identifier for Advertisers / IDFA on iOS).
- Device hardware specifications (device model, operating system version, carrier, screen dimensions).
- Diagnostic and performance crash logs related to ad delivery.

You can learn more about how Google handles advertising data by reviewing the [Google Privacy Policy](https://policies.google.com/privacy) and [Google Ads Technologies](https://policies.google.com/technologies/ads).

### 4.2 In-App Purchases & Billing (Google Play Billing / Apple In-App Purchase)
Math Riddle offers optional premium purchases (such as "PRO Unlock / Remove Ads").
- **Financial Details:** All financial transactions, credit card handling, and payment processing are managed exclusively by Google Play (Alphabet Inc.) or Apple Inc.
- **Developer Access:** We never receive, process, or store your credit card numbers, bank account details, or billing addresses.
- **Transaction Receipts:** The game receives an anonymous cryptographic purchase token indicating whether the premium license is active, which is verified locally and stored in encrypted preferences.

---

## 5. European Union (GDPR) and UK Compliance

If you reside in the European Economic Area (EEA), United Kingdom, or Switzerland, you are entitled to statutory rights under the General Data Protection Regulation (GDPR):

### 5.1 Legal Basis for Processing
- **Legitimate Interest:** Delivering essential game functionality, preventing anti-cheat violations, securing offline local saves, and serving contextual ads.
- **User Consent:** Serving personalized advertisements through the Google User Messaging Platform (UMP) consent dialog.

### 5.2 Your Rights Under GDPR
- **Right to Access:** You may review all data held by the application directly on your device via the Settings screen.
- **Right to Erasure ("Right to be Forgotten"):** You can immediately delete all game progress, scores, and locally stored data by tapping **DELETE DATA** in the in-app Settings menu, or by clearing app storage in your operating system settings.
- **Right to Withdraw Consent:** You can toggle personalized ads on or off at any time under **Settings > ADS SETTING**.

---

## 6. California Privacy Rights (CCPA / CPRA)

Under the California Consumer Privacy Act (CCPA) and California Privacy Rights Act (CPRA):
- **No Sale of Personal Information:** We do not sell, rent, or trade your personal information to third parties.
- **No Sharing for Cross-Context Behavioral Advertising Without Consent:** You have the absolute right to direct us not to share your data for behavioral ads by toggling off "ADS SETTING" or configuring your device's global "Limit Ad Tracking" preference.
- **Right to Non-Discrimination:** We do not discriminate against any user who exercises their statutory privacy rights. All core puzzle levels remain accessible.

---

## 7. Children's Privacy (COPPA & Google Play Family Policy)

Math Riddle is a family-friendly educational mathematics puzzle application suitable for general audiences.
- We do not knowingly collect personal identifiable information from children under the age of 13 (or under 16 in certain European jurisdictions).
- In compliance with COPPA and Google Play Family Policy, advertisements served to users identified as children are strictly non-personalized and family-appropriate, adhering to the Families Ads Program requirements.
- If a parent or guardian becomes aware that their child has provided personal information via a third-party ad network, please contact us at **privacy@valcire.com**, and we will promptly take steps to address the inquiry.

---

## 8. Anti-Cheat & Save-File Security

To protect the mathematical integrity of the leaderboard scoring system, Math Riddle uses automated client-side integrity checks:
- **HMAC-SHA256 Signatures:** Progression variables (highest unlocked level, total score, hearts, completed topics) are signed locally with an HMAC signature.
- **Clock Rollback Verification:** The application compares elapsed device uptime and timestamps to prevent artificial heart regeneration via device clock tampering.
- **Sanitization Ceilings:** If local save values exceed the mathematical maximum achievable through genuine gameplay, the score is automatically clamped to the verified upper bound.

*These integrity checks operate strictly in local memory and are never transmitted to external servers.*

---

## 9. Data Retention and Deletion Procedures

Because Math Riddle does not maintain remote user databases or cloud accounts, **you maintain 100% control over your data retention**:
1. **In-App Reset:** Navigating to **Settings > DELETE DATA** triggers an atomic purge of all SharedPreferences keys, resetting all levels, hearts, scores, and statistics.
2. **OS Application Clear:** Navigating to `Settings > Apps > Math Riddle > Storage > Clear Data` on Android, or deleting and reinstalling the app on iOS, immediately and irreversibly destroys all local game data.

---

## 10. Security Measures

We implement robust defensive security standards to safeguard your application environment:
- Protection against timing side-channel attacks via constant-time signature verification.
- Input sanitization on all keypad inputs to reject malformed numeric strings and prevent memory injection.
- Execution within the isolated application sandbox provided by Android and iOS operating systems.

---

## 11. Changes to This Privacy Policy

We may periodically update this Privacy Policy to reflect modifications in regulatory requirements, app capabilities, or third-party SDK revisions. Any updates will be reflected by the "Last Updated" date at the top of this document. We encourage users to review this page periodically. Continued use of Math Riddle following the posting of changes constitutes acceptance of those revisions.

---

## 12. Contact Information

For any questions, privacy inquiries, compliance requests, or data deletion support, please contact our Data Protection Officer:

**Valcire Gaming & Mathematical Software Studio**  
- **Email:** privacy@valcire.com  
- **Support Portal:** support@valcire.com  
- **Postal Address:** Valcire Studio, Legal & Compliance Division, San Francisco, CA, USA  

