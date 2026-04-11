/// To-Do Riverpod Providers
/// 參考: prd.md Section 3.2B, 4.1
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/database_provider.dart';
import 'package:uuid/uuid.dart';

final todoServiceProvider = Provider<TodoService>((ref) {
  final db = ref.watch(databaseProvider);
  return TodoService(db);
});

final todayTodosProvider = StreamProvider<List<TodoRow>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.todos)
        ..where((t) => t.isCompleted.equals(0))
        ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
      .watch();
});

final todosByDateProvider = StreamProvider.family<List<TodoRow>, DateTime>((
  ref,
  date,
) {
  final db = ref.watch(databaseProvider);
  final dateStr =
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
  return (db.select(db.todos)
        ..where((t) => t.dueDate.equals(dateStr))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();
});

final allUncompletedTodosProvider = StreamProvider<List<TodoRow>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.todos)
        ..where((t) => t.isCompleted.equals(0))
        ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
      .watch();
});

final todosByTypeProvider = StreamProvider.family<List<TodoRow>, String>((
  ref,
  type,
) {
  final db = ref.watch(databaseProvider);
  final query = db.select(db.todos)
    ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]);
  if (type != 'all') {
    query.where((t) => t.type.equals(type));
  }
  return query.watch();
});

class TodoService {
  final AppDatabase _db;
  static const _uuid = Uuid();

  TodoService(this._db);

  Future<void> addTodo({
    required String title,
    String? dueDate,
    String type = 'general',
    String? documentType,
    String? reminderDate,
  }) async {
    await _db
        .into(_db.todos)
        .insert(
          TodosCompanion(
            id: Value(_uuid.v4()),
            title: Value(title),
            dueDate: Value(dueDate),
            type: Value(type),
            documentType: Value(documentType),
            reminderDate: Value(reminderDate),
          ),
        );
  }

  Future<void> toggleComplete(String id, bool completed) async {
    await (_db.update(_db.todos)..where((t) => t.id.equals(id))).write(
      TodosCompanion(isCompleted: Value(completed ? 1 : 0)),
    );
  }

  Future<void> deleteTodo(String id) async {
    await (_db.delete(_db.todos)..where((t) => t.id.equals(id))).go();
  }

  Future<void> updateTodo({
    required String id,
    String? title,
    String? dueDate,
    String? type,
    String? documentType,
    String? reminderDate,
  }) async {
    await (_db.update(_db.todos)..where((t) => t.id.equals(id))).write(
      TodosCompanion(
        title: title != null ? Value(title) : const Value.absent(),
        dueDate: dueDate != null ? Value(dueDate) : const Value.absent(),
        type: type != null ? Value(type) : const Value.absent(),
        documentType: documentType != null
            ? Value(documentType)
            : const Value.absent(),
        reminderDate: reminderDate != null
            ? Value(reminderDate)
            : const Value.absent(),
      ),
    );
  }
}
