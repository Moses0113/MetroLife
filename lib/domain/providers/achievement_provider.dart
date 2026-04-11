/// Achievement Provider - Medal unlocking logic
/// 參考: prd.md Section 3.4E, 6.3
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/database_provider.dart';
import 'package:uuid/uuid.dart';

/// Check and award medals based on streak
final achievementServiceProvider = Provider<AchievementService>((ref) {
  final db = ref.watch(databaseProvider);
  return AchievementService(db);
});

/// Get all achievements
final achievementsProvider = StreamProvider<List<RabbitAchievement>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(
    db.rabbitAchievements,
  )..orderBy([(a) => OrderingTerm.desc(a.achievedAt)])).watch();
});

/// Check if a specific achievement has been shown
final achievementShownProvider = FutureProvider.family<bool, String>((
  ref,
  type,
) async {
  final db = ref.watch(databaseProvider);
  final achievement = await (db.select(
    db.rabbitAchievements,
  )..where((a) => a.type.equals(type))).getSingleOrNull();
  return achievement != null;
});

class AchievementService {
  final AppDatabase _db;
  static const _uuid = Uuid();

  AchievementService(this._db);

  /// Check streak and award medals
  /// Returns the newly unlocked achievement type, or null
  Future<String?> checkAndAwardMedals(int streakDays) async {
    // Bronze (3 days)
    if (streakDays >= 3) {
      final exists = await _hasAchievement('bronze_3days');
      if (!exists) {
        await _awardMedal('bronze_3days');
        return 'bronze_3days';
      }
    }

    // Silver (7 days)
    if (streakDays >= 7) {
      final exists = await _hasAchievement('silver_7days');
      if (!exists) {
        await _awardMedal('silver_7days');
        return 'silver_7days';
      }
    }

    // Gold (30 days)
    if (streakDays >= 30) {
      final exists = await _hasAchievement('gold_30days');
      if (!exists) {
        await _awardMedal('gold_30days');
        return 'gold_30days';
      }
    }

    return null;
  }

  Future<bool> _hasAchievement(String type) async {
    final existing = await (_db.select(
      _db.rabbitAchievements,
    )..where((a) => a.type.equals(type))).getSingleOrNull();
    return existing != null;
  }

  Future<void> _awardMedal(String type) async {
    final unix = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await _db
        .into(_db.rabbitAchievements)
        .insert(
          RabbitAchievementsCompanion(
            id: Value(_uuid.v4()),
            type: Value(type),
            achievedAt: Value(unix),
            shownToUser: const Value(0),
          ),
        );
  }

  /// Mark achievement as shown to user
  Future<void> markShown(String type) async {
    await (_db.update(_db.rabbitAchievements)
          ..where((a) => a.type.equals(type)))
        .write(const RabbitAchievementsCompanion(shownToUser: Value(1)));
  }

  /// Get next achievement goal
  Future<(String, int)?> getNextGoal(int currentStreak) async {
    if (currentStreak < 3) return ('bronze_3days', 3 - currentStreak);
    if (currentStreak < 7) return ('silver_7days', 7 - currentStreak);
    if (currentStreak < 30) return ('gold_30days', 30 - currentStreak);
    return null;
  }
}
