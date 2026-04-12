/// Balance Calculator Provider
/// 根據結算日計算上月結餘及總結餘
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/database_provider.dart';

class PeriodBalance {
  final double income;
  final double expense;
  final double balance;
  const PeriodBalance({
    required this.income,
    required this.expense,
    required this.balance,
  });
}

class MonthlyPeriodBalance {
  final PeriodBalance currentPeriod;
  final PeriodBalance lastPeriod;
  final double totalBalance;
  final DateTime periodStart;
  final DateTime periodEnd;
  final DateTime lastPeriodStart;
  final DateTime lastPeriodEnd;

  const MonthlyPeriodBalance({
    required this.currentPeriod,
    required this.lastPeriod,
    required this.totalBalance,
    required this.periodStart,
    required this.periodEnd,
    required this.lastPeriodStart,
    required this.lastPeriodEnd,
  });
}

int _lastDayOfMonth(int year, int month) {
  return DateTime(year, month + 1, 0).day;
}

int _clampDayToMonth(int day, int year, int month) {
  final lastDay = _lastDayOfMonth(year, month);
  return day > lastDay ? lastDay : day;
}

/// 計算結算週期的起止日期
DateTime _periodStart(int settlementDay, DateTime referenceDate) {
  final day = _clampDayToMonth(
    settlementDay,
    referenceDate.year,
    referenceDate.month,
  );
  if (referenceDate.day >= day) {
    return DateTime(referenceDate.year, referenceDate.month, day);
  } else {
    return DateTime(referenceDate.year, referenceDate.month - 1, day);
  }
}

DateTime _periodEnd(int settlementDay, DateTime referenceDate) {
  final start = _periodStart(settlementDay, referenceDate);
  return DateTime(
    start.year,
    start.month + 1,
    start.day,
  ).subtract(const Duration(seconds: 1));
}

DateTime _lastPeriodStart(int settlementDay, DateTime referenceDate) {
  final currentStart = _periodStart(settlementDay, referenceDate);
  return DateTime(currentStart.year, currentStart.month - 1, currentStart.day);
}

DateTime _lastPeriodEnd(int settlementDay, DateTime referenceDate) {
  final currentStart = _periodStart(settlementDay, referenceDate);
  return DateTime(
    currentStart.year,
    currentStart.month,
    currentStart.day,
  ).subtract(const Duration(seconds: 1));
}

/// 計算某段時間的收支
PeriodBalance _calculatePeriodBalance(List<TransactionRow> transactions) {
  double income = 0;
  double expense = 0;
  for (final t in transactions) {
    if (t.transactionType == 'income') {
      income += t.amount;
    } else {
      expense += t.amount.abs();
    }
  }
  return PeriodBalance(
    income: income,
    expense: expense,
    balance: income - expense,
  );
}

/// 主 Provider：基於結算日的月結餘
final monthlyBalanceProvider = StreamProvider.family<MonthlyPeriodBalance, int>(
  (ref, settlementDay) {
    final db = ref.watch(databaseProvider);

    // 監聽所有交易
    return db.select(db.transactions).watch().map((allTransactions) {
      final now = DateTime.now();

      // 當前結算週期
      final pStart = _periodStart(settlementDay, now);
      final pEnd = _periodEnd(settlementDay, now);
      final pStartUnix = pStart.millisecondsSinceEpoch ~/ 1000;
      final pEndUnix = pEnd.millisecondsSinceEpoch ~/ 1000;

      // 上月結算週期
      final lpStart = _lastPeriodStart(settlementDay, now);
      final lpEnd = _lastPeriodEnd(settlementDay, now);
      final lpStartUnix = lpStart.millisecondsSinceEpoch ~/ 1000;
      final lpEndUnix = lpEnd.millisecondsSinceEpoch ~/ 1000;

      final currentPeriodTx = allTransactions
          .where((t) => t.date >= pStartUnix && t.date <= pEndUnix)
          .toList();
      final lastPeriodTx = allTransactions
          .where((t) => t.date >= lpStartUnix && t.date <= lpEndUnix)
          .toList();

      final currentPeriod = _calculatePeriodBalance(currentPeriodTx);
      final lastPeriod = _calculatePeriodBalance(lastPeriodTx);
      final totalBalance = _calculatePeriodBalance(allTransactions);

      return MonthlyPeriodBalance(
        currentPeriod: currentPeriod,
        lastPeriod: lastPeriod,
        totalBalance: totalBalance.balance,
        periodStart: pStart,
        periodEnd: pEnd,
        lastPeriodStart: lpStart,
        lastPeriodEnd: lpEnd,
      );
    });
  },
);
