## 5. Ad Strategy & Monetization Architecture

### Ad Units, Frequency Caps & Lifecycle Triggers

```mermaid
flowchart TD
    PlayerAction[Player Requests Hint or Solution] --> CheckVIP{Is Player VIP?}
    CheckVIP -->|Yes| InstantUnlock[Instant Unlock Without Ads]
    CheckVIP -->|No| PromptRewarded[Show High-Contrast 'Need Help?' Modal]
    
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
1. **100% User-Initiated:** Rewarded videos never play automatically. They require explicit taps on either *"Watch Ad for Hint"* or *"Watch Ad for Solution"*.
2. **Reward Delivery Guarantee:**
   * Hint reward persists across app restarts for that specific level.
   * Solution reward reveals full workings and immediately unlocks Level $N+1$.
3. **No Penalty on Network Drop:** If an ad fails to load due to offline status, the app displays a graceful offline dialog encouraging the user to keep trying or subscribe to Premium.

### Interstitial Cadence & Suppression
* **Trigger Cadence:** Interstitial ads display strictly after completing every 3rd level ($N = 3, 6, 9, 12, 15, 18$).
* **Minimum Cooldown:** 60 seconds between interstitials to prevent fatigue.
* **Suppression Rule:** 100% suppressed for all players with `isPremium = true` or `removeAds = true`.

### GDPR / CCPA Privacy & Consent Protocols
* Integrated with Google User Messaging Platform (UMP).
* A dedicated **ADS SETTING** row in [SettingsScreen](file:///c:/Users/gokul/code/math/lib/screens/settings_screen.dart) allows players to revoke or adjust personalized advertising consent at any time.

---

## 6. In-App Purchases & Pricing Model

### Product Tiers & Multi-Currency Pricing

| Tier Identifier | SKU / Product ID | Billing Type | INR (â‚¹) | USD ($) | EUR (â‚¬) | GBP (Â£) |
|:---|:---|:---|:---:|:---:|:---:|:---:|
| **Remove Ads** | `math_remove_ads` | Non-Consumable | â‚¹49 | $0.99 | â‚¬0.99 | Â£0.89 |
| **Monthly Premium** | `math_sub_monthly` | Auto-Renewing Sub | â‚¹99/mo | $1.99/mo | â‚¬1.99/mo | Â£1.79/mo |
| **Lifetime Access** | `math_lifetime_vip`| Non-Consumable | â‚¹199 | $4.99 | â‚¬4.99 | Â£4.49 |

### Comprehensive Feature Matrix

| Capability / Benefit | Free Tier | Remove Ads Tier | Monthly Subscription | Lifetime VIP Access |
|:---|:---:|:---:|:---:|:---:|
| **All 20 Handcrafted Levels** | Yes | Yes | Yes | Yes |
| **5-Minute Continuous Countdown Timer** | Yes | Yes | Yes | Yes |
| **Inbuilt Virtual Keypad** | Yes | Yes | Yes | Yes |
| **Interstitial Ads (Every 3 Levels)** | Active | **Disabled** | **Disabled** | **Disabled** |
| **Cross-Promotion Banner** | Active | **Disabled** | **Disabled** | **Disabled** |
| **Hints Access** | Watch Ad | Watch Ad | **Instant / Ad-Free** | **Instant / Ad-Free** |
| **Step-by-Step Solutions** | Watch Ad | Watch Ad | **Instant / Ad-Free** | **Instant / Ad-Free** |
| **Offline Solution Unlocks** | No | No | Yes | **Yes (Permanent)** |
| **VIP Crown Badge on Home Screen** | No | No | Yes | **Yes (Permanent Gold)** |
| **Priority Access to Future Levels** | No | No | Yes | **Yes** |

### Billing State Machine & Purchase Restoration

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> InitiatingPurchase : Tap Product Card
    InitiatingPurchase --> PlayBillingFlow : Query Google Play / StoreKit
    PlayBillingFlow --> AwaitingReceipt : User Confirms Payment
    AwaitingReceipt --> Verification : Purchase Token Received
    Verification --> GrantVIP : Token Verified
    GrantVIP --> PersistentSave : Write isPremium=true to SharedPreferences
    PersistentSave --> Idle : Update UI State

    Idle --> RestoringPurchases : Tap 'Restore Purchase'
    RestoringPurchases --> QueryBillingTokens : Query Active Tokens
    QueryBillingTokens --> GrantVIP : Valid Token Found
    QueryBillingTokens --> Idle : No Valid Tokens Found
```

---

