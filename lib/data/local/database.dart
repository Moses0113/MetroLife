import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

@DriftDatabase(
  include: {
    'tables/user_profile.drift',
    'tables/categories.drift',
    'tables/transactions.drift',
    'tables/todos.drift',
    'tables/diary_entries.drift',
    'tables/exercise_records.drift',
    'tables/rabbit_achievements.drift',
    'tables/health_sync_logs.drift',
  },
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'metrolife_db');
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _seedDefaultCategories();
    },
  );

  Future<void> _seedDefaultCategories() async {
    final defaultCategories = [
      const Category(
        id: 'food',
        name: '餐飲',
        type: 'expense',
        iconName: 'restaurant',
        colour: '#FF9500',
        isDefault: 1,
        sortOrder: 1,
      ),
      const Category(
        id: 'transport',
        name: '交通',
        type: 'expense',
        iconName: 'directions_bus',
        colour: '#007AFF',
        isDefault: 1,
        sortOrder: 2,
      ),
      const Category(
        id: 'entertainment',
        name: '娛樂',
        type: 'expense',
        iconName: 'sports_esports',
        colour: '#AF52DE',
        isDefault: 1,
        sortOrder: 3,
      ),
      const Category(
        id: 'shopping',
        name: '購物',
        type: 'expense',
        iconName: 'shopping_cart',
        colour: '#34C759',
        isDefault: 1,
        sortOrder: 4,
      ),
      const Category(
        id: 'housing',
        name: '住屋',
        type: 'expense',
        iconName: 'home',
        colour: '#8B6914',
        isDefault: 1,
        sortOrder: 5,
      ),
      const Category(
        id: 'medical',
        name: '醫療',
        type: 'expense',
        iconName: 'local_hospital',
        colour: '#FF3B30',
        isDefault: 1,
        sortOrder: 6,
      ),
      const Category(
        id: 'utilities',
        name: '水電煤',
        type: 'expense',
        iconName: 'electrical_services',
        colour: '#FFCC00',
        isDefault: 1,
        sortOrder: 7,
      ),
      const Category(
        id: 'others',
        name: '其他',
        type: 'expense',
        iconName: 'more_horiz',
        colour: '#9E9E9E',
        isDefault: 1,
        sortOrder: 8,
      ),
      const Category(
        id: 'salary',
        name: '薪金',
        type: 'income',
        iconName: 'account_balance_wallet',
        colour: '#34C759',
        isDefault: 1,
        sortOrder: 1,
      ),
      const Category(
        id: 'other_income',
        name: '其他收入',
        type: 'income',
        iconName: 'attach_money',
        colour: '#007AFF',
        isDefault: 1,
        sortOrder: 2,
      ),
    ];

    for (final cat in defaultCategories) {
      await into(categories).insert(cat);
    }
  }
}
