/// Encapsulates all energy and heart economy rules.
class EnergyRules {
  const EnergyRules._();

  /// Maximum standard heart capacity.
  static const int maxHearts = 5;

  /// Refill interval: 1 heart every 20 minutes (1200 seconds).
  static const int refillIntervalSeconds = 20 * 60;

  /// Calculates refilled hearts based on elapsed seconds.
  static int calculateRefilledHearts(int currentHearts, int elapsedSeconds) {
    if (currentHearts >= maxHearts || elapsedSeconds <= 0) return 0;
    final heartsToAdd = elapsedSeconds ~/ refillIntervalSeconds;
    return (currentHearts + heartsToAdd).clamp(0, maxHearts) - currentHearts;
  }

  /// Calculates remaining seconds until the next heart refill.
  static int calculateSecondsUntilNextHeart(int currentHearts, int elapsedSeconds) {
    if (currentHearts >= maxHearts) return 0;
    if (elapsedSeconds < 0) return refillIntervalSeconds;
    final remaining = refillIntervalSeconds - (elapsedSeconds % refillIntervalSeconds);
    return remaining.clamp(0, refillIntervalSeconds);
  }
}
