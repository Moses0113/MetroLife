import 'dart:convert';
import 'package:metrolife/data/local/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:drift/drift.dart';

class ExportService {
  final AppDatabase _db;

  ExportService(this._db);

  Future<Map<String, dynamic>> exportAllData() async {
    final exportData = <String, dynamic>{
      'version': '1.0.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'data': <String, dynamic>{},
    };

    final data = exportData['data'] as Map<String, dynamic>;

    data['categories'] = await _exportCategories();
    data['transactions'] = await _exportTransactions();
    data['todos'] = await _exportTodos();
    data['diaryEntries'] = await _exportDiaryEntries();
    data['exerciseRecords'] = await _exportExerciseRecords();
    data['rabbitAchievements'] = await _exportRabbitAchievements();
    data['healthSyncLogs'] = await _exportHealthSyncLogs();

    return exportData;
  }

  Future<List<Map<String, dynamic>>> _exportCategories() async {
    final results = await _db.select(_db.categories).get();
    return results
        .map(
          (c) => {
            'id': c.id,
            'name': c.name,
            'type': c.type,
            'iconName': c.iconName,
            'colour': c.colour,
            'isDefault': c.isDefault,
            'sortOrder': c.sortOrder,
          },
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> _exportTransactions() async {
    final results = await _db.select(_db.transactions).get();
    return results
        .map(
          (t) => {
            'id': t.id,
            'date': t.date,
            'amount': t.amount,
            'categoryId': t.categoryId,
            'note': t.note,
            'transactionType': t.transactionType,
            'createdAt': t.createdAt,
          },
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> _exportTodos() async {
    final results = await _db.select(_db.todos).get();
    return results
        .map(
          (t) => {
            'id': t.id,
            'title': t.title,
            'dueDate': t.dueDate,
            'isCompleted': t.isCompleted,
            'type': t.type,
            'reminderDate': t.reminderDate,
            'createdAt': t.createdAt,
          },
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> _exportDiaryEntries() async {
    final results = await _db.select(_db.diaryEntries).get();
    return results
        .map(
          (d) => {
            'id': d.id,
            'date': d.date,
            'content': d.content,
            'mood': d.mood,
            'imagePaths': d.imagePaths,
            'linkedEventId': d.linkedEventId,
          },
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> _exportExerciseRecords() async {
    final results = await _db.select(_db.exerciseRecords).get();
    return results
        .map(
          (e) => {
            'id': e.id,
            'type': e.type,
            'startTime': e.startTime,
            'durationSeconds': e.durationSeconds,
            'distanceKm': e.distanceKm,
            'routeJson': e.routeJson,
            'encodedPolyline': e.encodedPolyline,
            'steps': e.steps,
            'caloriesBurned': e.caloriesBurned,
            'weightAtTimeKg': e.weightAtTimeKg,
            'syncedToHealth': e.syncedToHealth,
            'healthPlatformId': e.healthPlatformId,
          },
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> _exportRabbitAchievements() async {
    final results = await _db.select(_db.rabbitAchievements).get();
    return results
        .map(
          (r) => {
            'id': r.id,
            'type': r.type,
            'achievedAt': r.achievedAt,
            'shownToUser': r.shownToUser,
          },
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> _exportHealthSyncLogs() async {
    final results = await _db.select(_db.healthSyncLogs).get();
    return results
        .map(
          (h) => {
            'id': h.id,
            'syncTime': h.syncTime,
            'platform': h.platform,
            'syncType': h.syncType,
            'status': h.status,
            'recordsCount': h.recordsCount,
            'errorMessage': h.errorMessage,
          },
        )
        .toList();
  }

  Future<void> shareExport() async {
    final data = await exportAllData();
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);

    final dir = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final file = File('${dir.path}/metrolife_export_$timestamp.json');
    await file.writeAsString(jsonString);

    await Share.shareXFiles([XFile(file.path)], subject: 'MetroLife 數據匯出');
  }

  /// 從 JSON 檔案匯入所有資料
  /// 返回匯入的記錄數量
  Future<int> importAllData() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null || result.files.isEmpty) return 0;

    final file = File(result.files.first.path!);
    final jsonString = await file.readAsString();
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

    final data = jsonData['data'] as Map<String, dynamic>? ?? {};
    int totalImported = 0;

    if (data.containsKey('categories')) {
      totalImported += await _importCategories(data['categories'] as List);
    }
    if (data.containsKey('transactions')) {
      totalImported += await _importTransactions(data['transactions'] as List);
    }
    if (data.containsKey('todos')) {
      totalImported += await _importTodos(data['todos'] as List);
    }
    if (data.containsKey('diaryEntries')) {
      totalImported += await _importDiaryEntries(data['diaryEntries'] as List);
    }
    if (data.containsKey('exerciseRecords')) {
      totalImported += await _importExerciseRecords(
        data['exerciseRecords'] as List,
      );
    }
    if (data.containsKey('rabbitAchievements')) {
      totalImported += await _importRabbitAchievements(
        data['rabbitAchievements'] as List,
      );
    }
    if (data.containsKey('healthSyncLogs')) {
      totalImported += await _importHealthSyncLogs(
        data['healthSyncLogs'] as List,
      );
    }

    return totalImported;
  }

  Future<int> _importCategories(List items) async {
    int count = 0;
    for (final item in items) {
      final m = item as Map<String, dynamic>;
      await _db
          .into(_db.categories)
          .insertOnConflictUpdate(
            CategoriesCompanion(
              id: Value(m['id'] as String),
              name: Value(m['name'] as String),
              type: Value(m['type'] as String),
              iconName: Value(m['iconName'] as String?),
              colour: Value(m['colour'] as String?),
              isDefault: Value(m['isDefault'] as int? ?? 0),
              sortOrder: Value(m['sortOrder'] as int?),
            ),
          );
      count++;
    }
    return count;
  }

  Future<int> _importTransactions(List items) async {
    int count = 0;
    for (final item in items) {
      final m = item as Map<String, dynamic>;
      await _db
          .into(_db.transactions)
          .insertOnConflictUpdate(
            TransactionsCompanion(
              id: Value(m['id'] as String),
              date: Value(m['date'] as int),
              amount: Value((m['amount'] as num).toDouble()),
              categoryId: Value(m['categoryId'] as String),
              note: Value(m['note'] as String?),
              transactionType: Value(m['transactionType'] as String),
              createdAt: Value(m['createdAt'] as int),
            ),
          );
      count++;
    }
    return count;
  }

  Future<int> _importTodos(List items) async {
    int count = 0;
    for (final item in items) {
      final m = item as Map<String, dynamic>;
      await _db
          .into(_db.todos)
          .insertOnConflictUpdate(
            TodosCompanion(
              id: Value(m['id'] as String),
              title: Value(m['title'] as String),
              dueDate: Value(m['dueDate'] as String?),
              isCompleted: Value(m['isCompleted'] as int? ?? 0),
              type: Value(m['type'] as String? ?? 'general'),
              reminderDate: Value(m['reminderDate'] as String?),
              createdAt: Value(m['createdAt'] as int),
            ),
          );
      count++;
    }
    return count;
  }

  Future<int> _importDiaryEntries(List items) async {
    int count = 0;
    for (final item in items) {
      final m = item as Map<String, dynamic>;
      await _db
          .into(_db.diaryEntries)
          .insertOnConflictUpdate(
            DiaryEntriesCompanion(
              id: Value(m['id'] as String),
              date: Value(m['date'] as String),
              content: Value(m['content'] as String?),
              mood: Value(m['mood'] as int?),
              imagePaths: Value(m['imagePaths'] as String?),
              linkedEventId: Value(m['linkedEventId'] as String?),
            ),
          );
      count++;
    }
    return count;
  }

  Future<int> _importExerciseRecords(List items) async {
    int count = 0;
    for (final item in items) {
      final m = item as Map<String, dynamic>;
      await _db
          .into(_db.exerciseRecords)
          .insertOnConflictUpdate(
            ExerciseRecordsCompanion(
              id: Value(m['id'] as String),
              type: Value(m['type'] as String),
              startTime: Value(m['startTime'] as int?),
              durationSeconds: Value(m['durationSeconds'] as int?),
              distanceKm: Value((m['distanceKm'] as num?)?.toDouble()),
              routeJson: Value(m['routeJson'] as String?),
              encodedPolyline: Value(m['encodedPolyline'] as String?),
              steps: Value(m['steps'] as int?),
              caloriesBurned: Value((m['caloriesBurned'] as num?)?.toDouble()),
              weightAtTimeKg: Value((m['weightAtTimeKg'] as num?)?.toDouble()),
              syncedToHealth: Value(m['syncedToHealth'] as int? ?? 0),
              healthPlatformId: Value(m['healthPlatformId'] as String?),
            ),
          );
      count++;
    }
    return count;
  }

  Future<int> _importRabbitAchievements(List items) async {
    int count = 0;
    for (final item in items) {
      final m = item as Map<String, dynamic>;
      await _db
          .into(_db.rabbitAchievements)
          .insertOnConflictUpdate(
            RabbitAchievementsCompanion(
              id: Value(m['id'] as String),
              type: Value(m['type'] as String),
              achievedAt: Value(m['achievedAt'] as int),
              shownToUser: Value(m['shownToUser'] as int? ?? 0),
            ),
          );
      count++;
    }
    return count;
  }

  Future<int> _importHealthSyncLogs(List items) async {
    int count = 0;
    for (final item in items) {
      final m = item as Map<String, dynamic>;
      await _db
          .into(_db.healthSyncLogs)
          .insertOnConflictUpdate(
            HealthSyncLogsCompanion(
              id: Value(m['id'] as int),
              syncTime: Value(m['syncTime'] as int),
              platform: Value(m['platform'] as String),
              syncType: Value(m['syncType'] as String),
              status: Value(m['status'] as String),
              recordsCount: Value(m['recordsCount'] as int?),
              errorMessage: Value(m['errorMessage'] as String?),
            ),
          );
      count++;
    }
    return count;
  }
}
