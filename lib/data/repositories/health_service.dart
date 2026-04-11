/// Health Connect Service
/// 參考: prd.md Section 4.2, 7.1
/// https://pub.dev/packages/health
library;

import 'dart:io';
import 'package:health/health.dart';
import 'package:android_intent_plus/android_intent.dart';

class HealthService {
  final Health _health = Health();
  bool _configured = false;

  /// Health data types for Android (Health Connect)
  static const List<HealthDataType> _androidTypes = [
    HealthDataType.STEPS,
    HealthDataType.TOTAL_CALORIES_BURNED,
    HealthDataType.DISTANCE_DELTA,
    HealthDataType.WORKOUT,
    HealthDataType.WEIGHT,
  ];

  /// Health data types for iOS (HealthKit)
  static const List<HealthDataType> _iosTypes = [
    HealthDataType.STEPS,
    HealthDataType.TOTAL_CALORIES_BURNED,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.WORKOUT,
    HealthDataType.WEIGHT,
  ];

  List<HealthDataType> get _types =>
      Platform.isAndroid ? _androidTypes : _iosTypes;

  /// Configure health plugin (call once)
  void _ensureConfigured() {
    if (!_configured) {
      _health.configure();
      _configured = true;
    }
  }

  /// Check Health Connect SDK status (Android only)
  Future<HealthConnectSdkStatus?> getHealthConnectStatus() async {
    _ensureConfigured();
    if (!Platform.isAndroid) return null;
    try {
      return await _health.getHealthConnectSdkStatus();
    } catch (_) {
      return null;
    }
  }

  /// Install Health Connect if not available
  Future<void> installHealthConnect() async {
    _ensureConfigured();
    if (Platform.isAndroid) {
      try {
        await _health.installHealthConnect();
      } catch (_) {}
    }
  }

  /// Request permissions for health data
  Future<bool> requestPermissions() async {
    _ensureConfigured();
    final permissions = _types.map((_) => HealthDataAccess.READ_WRITE).toList();

    try {
      return await _health.requestAuthorization(
        _types,
        permissions: permissions,
      );
    } catch (_) {
      return false;
    }
  }

  /// Check if permissions are granted
  Future<bool> hasPermissions() async {
    _ensureConfigured();
    try {
      return await _health.hasPermissions(_types) ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Revoke permissions
  Future<void> revokePermissions() async {
    try {
      await _health.revokePermissions();
    } catch (_) {}
  }

  /// Open Health Connect permission settings for this app
  Future<void> openHealthConnectSettings() async {
    if (!Platform.isAndroid) return;
    try {
      const intent = AndroidIntent(
        action: 'android.health.connect.action.MANAGE_HEALTH_DATA',
        arguments: <String, dynamic>{'packageName': 'com.metrolife.metrolife'},
      );
      await intent.launch();
    } catch (_) {}
  }

  /// Get today's step count
  Future<int> getTodaySteps() async {
    _ensureConfigured();
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    try {
      final steps = await _health.getTotalStepsInInterval(startOfDay, now);
      return steps ?? 0;
    } catch (_) {
      return 0;
    }
  }

  /// Get today's calories burned
  Future<double> getTodayCalories() async {
    _ensureConfigured();
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    try {
      final data = await _health.getHealthDataFromTypes(
        startTime: startOfDay,
        endTime: now,
        types: [HealthDataType.TOTAL_CALORIES_BURNED],
      );

      double total = 0;
      for (final point in data) {
        if (point.value is NumericHealthValue) {
          total += (point.value as NumericHealthValue).numericValue.toDouble();
        }
      }
      return total;
    } catch (_) {
      return 0;
    }
  }

  /// Get past 7 days step counts
  Future<List<int>> getWeeklySteps() async {
    _ensureConfigured();
    final now = DateTime.now();
    final List<int> weeklySteps = [];

    for (int i = 6; i >= 0; i--) {
      final dayStart = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i));
      final dayEnd = dayStart.add(const Duration(days: 1));
      try {
        final steps = await _health.getTotalStepsInInterval(dayStart, dayEnd);
        weeklySteps.add(steps ?? 0);
      } catch (_) {
        weeklySteps.add(0);
      }
    }
    return weeklySteps;
  }

  /// Get latest weight from Health Connect
  Future<double?> getLatestWeight() async {
    _ensureConfigured();
    try {
      final now = DateTime.now();
      final data = await _health.getHealthDataFromTypes(
        startTime: now.subtract(const Duration(days: 365)),
        endTime: now,
        types: [HealthDataType.WEIGHT],
      );

      if (data.isEmpty) return null;
      data.sort((a, b) => b.dateFrom.compareTo(a.dateFrom));
      final latest = data.first;
      if (latest.value is NumericHealthValue) {
        return (latest.value as NumericHealthValue).numericValue.toDouble();
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Write a workout to Health Connect
  Future<bool> writeWorkout({
    required String exerciseType,
    required DateTime start,
    required DateTime end,
    double? totalDistanceKm,
    double? totalCaloriesBurned,
  }) async {
    _ensureConfigured();
    try {
      final activityType = _mapExerciseType(exerciseType);
      await _health.writeWorkoutData(
        activityType: activityType,
        start: start,
        end: end,
        totalDistance: totalDistanceKm != null
            ? (totalDistanceKm * 1000).toInt()
            : null,
        totalDistanceUnit: HealthDataUnit.METER,
        totalEnergyBurned: totalCaloriesBurned?.toInt(),
        totalEnergyBurnedUnit: HealthDataUnit.KILOCALORIE,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  HealthWorkoutActivityType _mapExerciseType(String type) {
    switch (type) {
      case 'running':
        return HealthWorkoutActivityType.RUNNING;
      case 'swimming':
        return HealthWorkoutActivityType.SWIMMING_POOL;
      case 'cycling':
        return HealthWorkoutActivityType.BIKING;
      case 'yoga':
        return HealthWorkoutActivityType.YOGA;
      case 'gym':
      case 'table_tennis':
        return HealthWorkoutActivityType.STRENGTH_TRAINING;
      default:
        return HealthWorkoutActivityType.OTHER;
    }
  }

  /// Delete workouts in a time range
  Future<bool> deleteWorkouts(DateTime start, DateTime end) async {
    _ensureConfigured();
    try {
      await _health.delete(
        type: HealthDataType.WORKOUT,
        startTime: start,
        endTime: end,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Delete workout by UUID
  Future<bool> deleteWorkoutByUuid(String uuid) async {
    _ensureConfigured();
    try {
      await _health.deleteByUUID(uuid: uuid, type: HealthDataType.WORKOUT);
      return true;
    } catch (_) {
      return false;
    }
  }
}
