/// Category Riverpod Providers
/// 參考: prd.md Section 3.3

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/database_provider.dart';
import 'package:uuid/uuid.dart';

/// Watch all categories
final allCategoriesProvider = StreamProvider<List<Category>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(
    db.categories,
  )..orderBy([(c) => OrderingTerm.asc(c.sortOrder)])).watch();
});

/// Watch expense categories only
final expenseCategoriesProvider = StreamProvider<List<Category>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.categories)
        ..where((c) => c.type.equals('expense'))
        ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
      .watch();
});

/// Watch income categories only
final incomeCategoriesProvider = StreamProvider<List<Category>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.categories)
        ..where((c) => c.type.equals('income'))
        ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
      .watch();
});

/// Get category by ID
final categoryByIdProvider = FutureProvider.family<Category?, String>((
  ref,
  id,
) async {
  final db = ref.watch(databaseProvider);
  return (db.select(
    db.categories,
  )..where((c) => c.id.equals(id))).getSingleOrNull();
});

final categoryServiceProvider = Provider<CategoryService>((ref) {
  final db = ref.watch(databaseProvider);
  return CategoryService(db);
});

class CategoryService {
  final AppDatabase _db;
  static const _uuid = Uuid();

  CategoryService(this._db);

  Future<void> addCategory({
    required String name,
    required String type,
    String? iconName,
    String? colour,
  }) async {
    await _db
        .into(_db.categories)
        .insert(
          CategoriesCompanion(
            id: Value(_uuid.v4()),
            name: Value(name),
            type: Value(type),
            iconName: Value(iconName),
            colour: Value(colour),
          ),
        );
  }

  Future<void> deleteCategory(String id) async {
    await (_db.delete(_db.categories)..where((c) => c.id.equals(id))).go();
  }

  /// Get a category by ID synchronously
  Future<Category?> getCategory(String id) async {
    return (_db.select(
      _db.categories,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
  }
}
