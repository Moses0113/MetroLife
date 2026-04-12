/// Transaction Riverpod Providers
/// 參考: prd.md Section 3.3, 4.1
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/database_provider.dart';
import 'package:uuid/uuid.dart';

final transactionServiceProvider = Provider<TransactionService>((ref) {
  final db = ref.watch(databaseProvider);
  return TransactionService(db);
});

/// Watch all transactions for a given month
final monthlyTransactionsProvider =
    StreamProvider.family<List<TransactionRow>, DateTime>((ref, month) {
      final db = ref.watch(databaseProvider);
      final startOfMonth = DateTime(month.year, month.month, 1);
      final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
      final startUnix = startOfMonth.millisecondsSinceEpoch ~/ 1000;
      final endUnix = endOfMonth.millisecondsSinceEpoch ~/ 1000;

      return (db.select(db.transactions)
            ..where(
              (t) =>
                  t.date.isBiggerOrEqualValue(startUnix) &
                  t.date.isSmallerOrEqualValue(endUnix),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();
    });

/// Monthly summary (income, expense, balance)
final monthlySummaryProvider = StreamProvider.family<MonthlySummary, DateTime>((
  ref,
  month,
) {
  final db = ref.watch(databaseProvider);
  final startOfMonth = DateTime(month.year, month.month, 1);
  final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
  final startUnix = startOfMonth.millisecondsSinceEpoch ~/ 1000;
  final endUnix = endOfMonth.millisecondsSinceEpoch ~/ 1000;

  return (db.select(db.transactions)..where(
        (t) =>
            t.date.isBiggerOrEqualValue(startUnix) &
            t.date.isSmallerOrEqualValue(endUnix),
      ))
      .watch()
      .map((rows) {
        double income = 0;
        double expense = 0;
        for (final row in rows) {
          if (row.amount > 0) {
            income += row.amount;
          } else {
            expense += row.amount.abs();
          }
        }
        return MonthlySummary(
          income: income,
          expense: expense,
          balance: income - expense,
        );
      });
});

/// Spending breakdown by category for pie chart
final spendingBreakdownProvider =
    StreamProvider.family<List<CategorySpending>, DateTime>((ref, month) {
      final db = ref.watch(databaseProvider);
      final startOfMonth = DateTime(month.year, month.month, 1);
      final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
      final startUnix = startOfMonth.millisecondsSinceEpoch ~/ 1000;
      final endUnix = endOfMonth.millisecondsSinceEpoch ~/ 1000;

      return (db.select(db.transactions)..where(
            (t) =>
                t.date.isBiggerOrEqualValue(startUnix) &
                t.date.isSmallerOrEqualValue(endUnix) &
                t.transactionType.equals('expense'),
          ))
          .watch()
          .map((rows) {
            final map = <String, double>{};
            for (final row in rows) {
              map[row.categoryId] =
                  (map[row.categoryId] ?? 0) + row.amount.abs();
            }
            final total = map.values.fold(0.0, (a, b) => a + b);
            return map.entries
                .map(
                  (e) => CategorySpending(
                    categoryId: e.key,
                    amount: e.value,
                    percentage: total > 0 ? e.value / total * 100 : 0,
                  ),
                )
                .toList()
              ..sort((a, b) => b.amount.compareTo(a.amount));
          });
    });

class MonthlySummary {
  final double income;
  final double expense;
  final double balance;
  const MonthlySummary({
    required this.income,
    required this.expense,
    required this.balance,
  });
}

class CategorySpending {
  final String categoryId;
  final double amount;
  final double percentage;
  const CategorySpending({
    required this.categoryId,
    required this.amount,
    required this.percentage,
  });
}

class TransactionService {
  final AppDatabase _db;
  static const _uuid = Uuid();

  TransactionService(this._db);

  Future<void> addTransaction({
    required DateTime date,
    required double amount,
    required String categoryId,
    String? note,
    bool isRecurring = false,
    required String transactionType,
  }) async {
    final unix = date.millisecondsSinceEpoch ~/ 1000;
    await _db
        .into(_db.transactions)
        .insert(
          TransactionsCompanion(
            id: Value(_uuid.v4()),
            date: Value(unix),
            amount: Value(amount),
            categoryId: Value(categoryId),
            note: Value(note),
            isRecurring: Value(isRecurring ? 1 : 0),
            transactionType: Value(transactionType),
          ),
        );
  }

  Future<void> deleteTransaction(String id) async {
    await (_db.delete(_db.transactions)..where((t) => t.id.equals(id))).go();
  }

  int _lastDayOfMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  int _clampDayToMonth(int day, int year, int month) {
    final lastDay = _lastDayOfMonth(year, month);
    return day > lastDay ? lastDay : day;
  }

  /// Check and create auto-salary if salary day has passed
  Future<void> checkAutoSalary({
    required int salaryDay,
    required double monthlySalary,
  }) async {
    if (monthlySalary <= 0 || salaryDay < 1) return;

    final now = DateTime.now();
    final validSalaryDay = _clampDayToMonth(salaryDay, now.year, now.month);
    final thisMonthSalaryDate = DateTime(now.year, now.month, validSalaryDay);

    // Only create if today is on or after salary day
    if (now.isBefore(thisMonthSalaryDate)) return;

    // Check if already created this month
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startUnix = startOfMonth.millisecondsSinceEpoch ~/ 1000;
    final existing =
        await (_db.select(_db.transactions)..where(
              (t) =>
                  t.transactionType.equals('income') &
                  t.isRecurring.equals(1) &
                  t.date.isBiggerOrEqualValue(startUnix),
            ))
            .get();
    if (existing.isNotEmpty) return;

    // Create salary record
    await addTransaction(
      date: thisMonthSalaryDate,
      amount: monthlySalary,
      categoryId: 'salary',
      note: '自動薪金',
      isRecurring: true,
      transactionType: 'income',
    );
  }
}
