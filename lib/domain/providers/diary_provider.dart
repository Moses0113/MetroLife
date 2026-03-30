/// Diary Riverpod Providers
/// 參考: prd.md Section 3.2C, 4.1

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/database_provider.dart';
import 'package:uuid/uuid.dart';

final diaryServiceProvider = Provider<DiaryService>((ref) {
  final db = ref.watch(databaseProvider);
  return DiaryService(db);
});

final diaryByDateProvider = StreamProvider.family<DiaryEntry?, DateTime>((
  ref,
  date,
) {
  final db = ref.watch(databaseProvider);
  final dateStr =
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
  return (db.select(
    db.diaryEntries,
  )..where((d) => d.date.equals(dateStr))).watchSingleOrNull();
});

class DiaryService {
  final AppDatabase _db;
  static const _uuid = Uuid();

  DiaryService(this._db);

  Future<DiaryEntry> saveDiary({
    required DateTime date,
    String? content,
    int? mood,
    String? imagePaths,
  }) async {
    final dateStr =
        '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';

    // Try to update existing, otherwise insert
    final existing = await (_db.select(
      _db.diaryEntries,
    )..where((d) => d.date.equals(dateStr))).getSingleOrNull();

    if (existing != null) {
      await (_db.update(
        _db.diaryEntries,
      )..where((d) => d.date.equals(dateStr))).write(
        DiaryEntriesCompanion(
          content: Value(content),
          mood: Value(mood),
          imagePaths: Value(imagePaths),
        ),
      );
      return existing.copyWith(
        content: Value(content),
        mood: Value(mood),
        imagePaths: Value(imagePaths),
      );
    } else {
      final id = _uuid.v4();
      final entry = DiaryEntriesCompanion(
        id: Value(id),
        date: Value(dateStr),
        content: Value(content),
        mood: Value(mood),
        imagePaths: Value(imagePaths),
      );
      await _db.into(_db.diaryEntries).insert(entry);
      return DiaryEntry(
        id: id,
        date: dateStr,
        content: content,
        mood: mood,
        imagePaths: imagePaths,
      );
    }
  }

  Future<void> deleteDiary(String id) async {
    await (_db.delete(_db.diaryEntries)..where((d) => d.id.equals(id))).go();
  }
}
