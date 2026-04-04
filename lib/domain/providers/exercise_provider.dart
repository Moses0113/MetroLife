/// Exercise Riverpod Providers
/// 參考: prd.md Section 3.4, 4.1

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/database_provider.dart';
import 'package:metrolife/core/utils/unit_utils.dart';
import 'package:uuid/uuid.dart';

final exerciseServiceProvider = Provider<ExerciseService>((ref) {
  final db = ref.watch(databaseProvider);
  return ExerciseService(db);
});

/// Today's step count (from DB records)
final todayStepsProvider = StreamProvider<int>((ref) {
  final db = ref.watch(databaseProvider);
  final today = DateTime.now();
  final startOfDay = DateTime(today.year, today.month, today.day);
  final startUnix = startOfDay.millisecondsSinceEpoch ~/ 1000;

  return (db.select(db.exerciseRecords)..where(
        (e) =>
            e.type.equals('steps') &
            e.startTime.isBiggerOrEqualValue(startUnix),
      ))
      .watch()
      .map((rows) => rows.fold<int>(0, (sum, r) => sum + (r.steps ?? 0)));
});

/// Today's calories
final todayCaloriesProvider = StreamProvider<double>((ref) {
  final db = ref.watch(databaseProvider);
  final today = DateTime.now();
  final startOfDay = DateTime(today.year, today.month, today.day);
  final startUnix = startOfDay.millisecondsSinceEpoch ~/ 1000;

  return (db.select(
    db.exerciseRecords,
  )..where((e) => e.startTime.isBiggerOrEqualValue(startUnix))).watch().map(
    (rows) => rows.fold<double>(0, (sum, r) => sum + (r.caloriesBurned ?? 0)),
  );
});

/// Recent exercises
final recentExercisesProvider = StreamProvider<List<ExerciseRecord>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.exerciseRecords)
        ..where((e) => e.type.isNotIn(['steps']))
        ..orderBy([(e) => OrderingTerm.desc(e.startTime)])
        ..limit(10))
      .watch();
});

/// Streak days (consecutive days with exercise)
final streakDaysProvider = FutureProvider<int>((ref) async {
  final db = ref.watch(databaseProvider);
  final now = DateTime.now();

  int streak = 0;
  DateTime checkDay = DateTime(now.year, now.month, now.day);

  // Check if today has exercise, if not start from yesterday
  final todayStart = checkDay.millisecondsSinceEpoch ~/ 1000;
  final todayRecords =
      await (db.select(db.exerciseRecords)..where(
            (e) =>
                e.type.isNotIn(['steps']) &
                e.startTime.isBiggerOrEqualValue(todayStart),
          ))
          .get();
  if (todayRecords.isEmpty) {
    checkDay = checkDay.subtract(const Duration(days: 1));
  }

  while (true) {
    final dayStart = checkDay.millisecondsSinceEpoch ~/ 1000;
    final dayEnd =
        checkDay.add(const Duration(days: 1)).millisecondsSinceEpoch ~/ 1000;
    final records =
        await (db.select(db.exerciseRecords)..where(
              (e) =>
                  e.type.isNotIn(['steps']) &
                  e.startTime.isBiggerOrEqualValue(dayStart) &
                  e.startTime.isSmallerThanValue(dayEnd),
            ))
            .get();
    if (records.isEmpty) break;
    streak++;
    checkDay = checkDay.subtract(const Duration(days: 1));
    if (streak > 365) break; // Safety limit
  }

  return streak;
});

class ExerciseService {
  final AppDatabase _db;
  static const _uuid = Uuid();

  ExerciseService(this._db);

  /// Record an exercise (running, swimming, cycling, etc.)
  Future<void> recordExercise({
    required String type,
    required DateTime startTime,
    int? durationSeconds,
    double? distanceKm,
    int? steps,
    double? caloriesBurned,
    String? routeJson,
    String? encodedPolyline,
    double? weightAtTimeKg,
  }) async {
    final unix = startTime.millisecondsSinceEpoch ~/ 1000;
    await _db
        .into(_db.exerciseRecords)
        .insert(
          ExerciseRecordsCompanion(
            id: Value(_uuid.v4()),
            type: Value(type),
            startTime: Value(unix),
            durationSeconds: Value(durationSeconds),
            distanceKm: Value(distanceKm),
            steps: Value(steps),
            caloriesBurned: Value(caloriesBurned),
            routeJson: Value(routeJson),
            encodedPolyline: Value(encodedPolyline),
            weightAtTimeKg: Value(weightAtTimeKg),
          ),
        );
  }

  /// Record step count
  Future<void> recordSteps(int steps, double weightKg) async {
    final calories = UnitUtils.calculateStepsCalories(steps, weightKg);
    await recordExercise(
      type: 'steps',
      startTime: DateTime.now(),
      steps: steps,
      caloriesBurned: calories,
    );
  }

  /// Calculate BMI
  static double calculateBmi(double heightCm, double weightKg) {
    if (heightCm <= 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// Get BMI category
  static String getBmiCategory(double bmi) {
    if (bmi <= 0) return '';
    if (bmi < 18.5) return '過輕';
    if (bmi < 25) return '正常';
    if (bmi < 30) return '超重';
    return '肥胖';
  }

  /// MET values for exercises
  static double getMetValue(String type) {
    switch (type) {
      case 'swimming':
        return 8.0;
      case 'table_tennis':
        return 4.0;
      case 'cycling':
        return 7.5;
      case 'yoga':
        return 2.5;
      case 'gym':
        return 6.0;
      default:
        return 5.0;
    }
  }

  /// Calculate calories for exercise type
  static double calculateExerciseCalories(
    String type,
    double weightKg,
    int minutes,
  ) {
    final met = getMetValue(type);
    return UnitUtils.calculateMetCalories(met, weightKg, minutes);
  }
}
