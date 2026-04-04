/// Unit conversion utilities
/// 參考: prd.md Section 10.1

class UnitUtils {
  UnitUtils._();

  // Weight
  static double kgToLb(double kg) => kg * 2.20462;
  static double lbToKg(double lb) => lb / 2.20462;

  // Height
  static double cmToFt(double cm) => cm / 30.48;
  static double ftToCm(double ft) => ft * 30.48;
  static double cmToIn(double cm) => cm / 2.54;
  static double inToCm(double inches) => inches * 2.54;

  // Distance
  static double metersToKm(double meters) => meters / 1000;

  // Calories (Running)
  /// Calories = 0.75 × weightKg × distanceKm
  static double calculateRunningCalories(double distanceKm, double weightKg) {
    return 0.75 * weightKg * distanceKm;
  }

  // Calories (Other exercises)
  /// Calories = MET × weightKg × (durationMinutes / 60)
  static double calculateMetCalories(double met, double weightKg, int minutes) {
    return met * weightKg * (minutes / 60.0);
  }

  // Calories from steps
  /// Approximate calories burned from walking steps
  /// Formula: steps × 0.04 × (weightKg / 70) ≈ 0.04 kcal per step at 70kg
  static double calculateStepsCalories(int steps, double weightKg) {
    if (steps <= 0 || weightKg <= 0) return 0;
    const double caloriesPerStepAt70kg = 0.04;
    return steps * caloriesPerStepAt70kg * (weightKg / 70);
  }

  // Haversine distance between two GPS points (in meters)
  static double haversineDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371000;
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a =
        _haversin(dLat) +
        _haversin(dLon) * _cos(_toRadians(lat1)) * _cos(_toRadians(lat2));
    final c = 2 * _asin(_sqrt(a));
    return earthRadius * c;
  }

  static double _toRadians(double degree) => degree * 3.14159265358979 / 180;
  static double _haversin(double x) => _sin(x / 2) * _sin(x / 2);
  static double _sin(double x) {
    double result = 0;
    double term = x;
    for (int i = 1; i <= 15; i++) {
      result += term;
      term *= -x * x / ((2 * i) * (2 * i + 1));
    }
    return result;
  }

  static double _cos(double x) => _sin(x + 1.5707963267949);
  static double _asin(double x) {
    if (x.abs() > 1) return double.nan;
    return x + x * x * x / 6 + 3 * x * x * x * x * x / 40;
  }

  static double _sqrt(double x) {
    if (x < 0) return double.nan;
    double guess = x / 2;
    for (int i = 0; i < 20; i++) {
      guess = (guess + x / guess) / 2;
    }
    return guess;
  }
}
