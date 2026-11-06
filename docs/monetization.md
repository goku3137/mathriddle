# SMATH – Monetization & In-App Purchases Specification

> **Document Type:** Monetization & Revenue Architecture  
> **Target Framework:** Flutter 3.27+ / Dart 3.6+  
> **Platforms:** Android (Google Play Billing) & iOS (Apple StoreKit)  
> **SKU Domain:** `com.valcire.mathriddle`  

---

## 1. Ad Strategy & Monetization Architecture

### Ad Units, Frequency Caps & Lifecycle Triggers

```mermaid
flowchart TD
    PlayerAction[Player Requests Hint or Solution] --> CheckVIP{Is Player Premium?}
    CheckVIP -->|Yes| InstantUnlock[Instant Unlock Without Ads]
    CheckVIP -->|No| PromptRewarded[Show 'Need Help?' Modal]
    
    PromptRewarded --> TapHint[Tap 'Watch Ad for Hint']
    PromptRewarded --> TapSolution[Tap 'Watch Ad for Solution']
    
    TapHint --> LoadRewarded1[Request Rewarded Video]
    TapSolution --> LoadRewarded2[Request Rewarded Video]
    
    LoadRewarded1 --> ShowRewarded1[Display Rewarded Ad]
    LoadRewarded2 --> ShowRewarded2[Display Rewarded Ad]
    
    ShowRewarded1 --> AdReward1{Ad Completed?}
    ShowRewarded2 --> AdReward2{Ad Completed?}
    
    AdReward1 -->|Yes| RevealHint[Show Hint Banner Permanently]
    AdReward1 -->|No| FailedAd[Notify Player: Ad Skipped]
    
    AdReward2 -->|Yes| RevealSolution[Reveal Solution & Advance Level]
    AdReward2 -->|No| FailedAd
```

### Rewarded Video Implementation Rules
1. **100% User-Initiated:** Rewarded videos never play automatically. They require explicit taps on *"Watch Ad for Hint"* or *"Watch Ad for Solution"*.
2. **Reward Delivery Guarantee:**
   * Hint reward persists across app restarts for that specific level.
   * Solution reward reveals full workings and immediately unlocks Level $N+1$.
3. **Graceful Offline Fallback:** If an ad fails to load due to offline status, the app displays a graceful message encouraging the user to continue solving or subscribe to Premium.

### Interstitial Cadence & Suppression
* **Trigger Cadence:** Interstitial ads display strictly after completing every 3rd level ($N = 3, 6, 9, 12, \dots$).
* **Minimum Cooldown:** 60 seconds between interstitials to prevent cognitive fatigue.
* **Suppression Rule:** 100% suppressed for all players with `isPremiumUser == true` or `isAdsRemoved == true`.

### GDPR / CCPA Privacy & Consent Protocols
* Compliant with Google User Messaging Platform (UMP).
* A dedicated **ADS SETTING** toggle row in [SettingsScreen](file:///c:/Users/gokul/code/math/lib/screens/settings_screen.dart) allows players to adjust personalized advertising consent at any time.

---

## 2. In-App Purchases & Pricing Model

### Product Tiers & Multi-Currency Pricing

| Tier Identifier | SKU / Product ID | Billing Type | INR (₹) | USD ($) | EUR (€) | GBP (£) |
|:---|:---|:---|:---:|:---:|:---:|:---:|
| **Remove Ads** | `math_remove_ads` | Non-Consumable | ₹49 | $0.99 | €0.99 | £0.89 |
| **Monthly Premium** | `math_premium_monthly` | Auto-Renewing Sub | ₹99/mo | $1.99/mo | €1.99/mo | £1.79/mo |
| **Lifetime Access** | `math_premium_lifetime`| Non-Consumable | ₹199 | $4.99 | €4.99 | £4.49 |

### Comprehensive Feature Matrix

| Capability / Benefit | Free Tier | Remove Ads Tier | Monthly Subscription | Lifetime VIP Access |
|:---|:---:|:---:|:---:|:---:|
| **All 500 Riddles Access** | Yes | Yes | Yes | Yes |
| **12 Progressive Challenges** | Yes | Yes | Yes | Yes |
| **14 Academy Lessons & Sandboxes** | Yes | Yes | Yes | Yes |
| **Unlimited Hearts (No 20m Wait)** | No | No | **Active** | **Active (Lifetime)** |
| **Interstitial Ads (Every 3 Levels)** | Active | **Disabled** | **Disabled** | **Disabled** |
| **Hint Access** | Watch Ad | Watch Ad | **Instant / Ad-Free** | **Instant / Ad-Free** |
| **Step-by-Step Solutions** | Watch Ad | Watch Ad | **Instant / Ad-Free** | **Instant / Ad-Free** |
| **Understated Home PRO Pill** | Discoverable | Discoverable | **Active Badge** | **Active Badge** |
| **Offline Solution Unlocks** | No | No | Yes | **Yes (Permanent)** |

### Billing State Machine & Purchase Restoration

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> InitiatingPurchase : Tap Product Card
    InitiatingPurchase --> PlayBillingFlow : Query Google Play / StoreKit
    PlayBillingFlow --> AwaitingReceipt : User Confirms Payment
    AwaitingReceipt --> Verification : Purchase Token Received
    Verification --> GrantVIP : Token Verified
    GrantVIP --> PersistentSave : Write math_premium_tier to SharedPreferences & HMAC Sign
    PersistentSave --> Idle : Update UI State

    Idle --> RestoringPurchases : Tap 'Restore Purchase' in Settings
    RestoringPurchases --> QueryBillingTokens : Query Active Purchases
    QueryBillingTokens --> GrantVIP : Valid Purchase Found
    QueryBillingTokens --> Idle : No Valid Purchases Found
```
