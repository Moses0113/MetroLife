/// 記帳頁 - 完整實現 (prd.md §3.3, UI.md §3.3)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/core/utils/currency_utils.dart';
import 'package:metrolife/core/utils/date_utils.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/l10n/app_localizations.dart';
import 'package:metrolife/domain/providers/transaction_provider.dart';
import 'package:metrolife/domain/providers/category_provider.dart';
import 'package:metrolife/presentation/dialogs/add_transaction_dialog.dart';

class FinancePage extends ConsumerStatefulWidget {
  const FinancePage({super.key});

  @override
  ConsumerState<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends ConsumerState<FinancePage> {
  DateTime _selectedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final summaryAsync = ref.watch(monthlySummaryProvider(_selectedMonth));
    final transactionsAsync = ref.watch(
      monthlyTransactionsProvider(_selectedMonth),
    );
    final breakdownAsync = ref.watch(spendingBreakdownProvider(_selectedMonth));
    final categoriesAsync = ref.watch(allCategoriesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.finance),
        actions: [
          IconButton(icon: const Icon(Icons.bar_chart), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        children: [
          // Balance Card
          summaryAsync.when(
            loading: () => _buildBalanceCard(0, 0, 0, isDark),
            error: (_, __) => _buildBalanceCard(0, 0, 0, isDark),
            data: (summary) => _buildBalanceCard(
              summary.balance,
              summary.income,
              summary.expense,
              isDark,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Spending Breakdown Pie Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Column(
                children: [
                  Text(
                    l10n.spendingBreakdown,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  breakdownAsync.when(
                    loading: () => const SizedBox(
                      height: 150,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (_, __) => const SizedBox(
                      height: 150,
                      child: Center(child: Text('無法載入圖表')),
                    ),
                    data: (breakdown) =>
                        _buildPieChart(breakdown, categoriesAsync),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Recent Transactions
          Text(
            l10n.recentTransactions,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingSm),

          transactionsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => Text(l10n.error),
            data: (transactions) {
              if (transactions.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingLg),
                    child: Row(
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 24,
                          color: AppTheme.textTertiary,
                        ),
                        const SizedBox(width: AppTheme.spacingMd),
                        Text(
                          l10n.noData,
                          style: const TextStyle(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                children: transactions
                    .map((t) => _buildTransactionItem(context, ref, t))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddTransactionDialog.show(context),
        backgroundColor: AppTheme.accentPrimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('記帳', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildBalanceCard(
    double balance,
    double income,
    double expense,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [AppTheme.bgSecondaryDark, AppTheme.bgTertiaryDark]
              : [Colors.white, AppTheme.bgTertiary],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '本月結餘',
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            CurrencyUtils.formatGbp(balance),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: balance >= 0 ? AppTheme.success : AppTheme.danger,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_downward,
                      color: AppTheme.success,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '收入 ${CurrencyUtils.formatGbp(income)}',
                      style: const TextStyle(
                        color: AppTheme.success,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_upward,
                      color: AppTheme.danger,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '支出 ${CurrencyUtils.formatGbp(expense)}',
                      style: const TextStyle(
                        color: AppTheme.danger,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(
    List<CategorySpending> breakdown,
    AsyncValue<List<Category>> categoriesAsync,
  ) {
    if (breakdown.isEmpty) {
      return SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pie_chart_outline,
              size: 60,
              color: AppTheme.textTertiary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            const Text(
              '暫無支出數據',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            ),
          ],
        ),
      );
    }

    final colors = [
      const Color(0xFFFF9500),
      const Color(0xFF007AFF),
      const Color(0xFFAF52DE),
      const Color(0xFF34C759),
      const Color(0xFF8B6914),
      const Color(0xFFFF3B30),
      const Color(0xFFFFCC00),
      const Color(0xFF9E9E9E),
    ];

    return categoriesAsync.when(
      loading: () => const SizedBox(height: 150),
      error: (_, __) => const SizedBox(height: 150),
      data: (categories) {
        final catMap = {for (var c in categories) c.id: c};

        return Column(
          children: [
            SizedBox(
              height: 150,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: breakdown.take(6).toList().asMap().entries.map((e) {
                    final spending = e.value;
                    final color = colors[e.key % colors.length];
                    return PieChartSectionData(
                      color: color,
                      value: spending.amount,
                      title: '${spending.percentage.toStringAsFixed(0)}%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Wrap(
              spacing: AppTheme.spacingSm,
              runSpacing: 4,
              children: breakdown.take(6).toList().asMap().entries.map((e) {
                final spending = e.value;
                final color = colors[e.key % colors.length];
                final cat = catMap[spending.categoryId];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      cat?.name ?? spending.categoryId,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      ' ${spending.percentage.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingSm),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    WidgetRef ref,
    TransactionRow t,
  ) {
    final isIncome = t.amount > 0;
    final amount = t.amount.abs();
    final categoriesAsync = ref.watch(allCategoriesProvider);

    return Dismissible(
      key: ValueKey(t.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppTheme.spacingMd),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.danger,
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) =>
          ref.read(transactionServiceProvider).deleteTransaction(t.id),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: (isIncome ? AppTheme.success : AppTheme.danger)
                .withValues(alpha: 0.1),
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: isIncome ? AppTheme.success : AppTheme.danger,
              size: 20,
            ),
          ),
          title: categoriesAsync.when(
            loading: () => Text(t.categoryId),
            error: (_, __) => Text(t.categoryId),
            data: (cats) {
              final cat = cats.where((c) => c.id == t.categoryId).firstOrNull;
              return Text(cat?.name ?? t.categoryId);
            },
          ),
          subtitle: Row(
            children: [
              Text(
                AppDateUtils.formatDdMm(
                  DateTime.fromMillisecondsSinceEpoch(t.date * 1000),
                ),
                style: const TextStyle(fontSize: 12),
              ),
              if (t.isRecurring == 1) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.accentSecondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '自動',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.accentSecondary,
                    ),
                  ),
                ),
              ],
              if (t.note != null && t.note!.isNotEmpty) ...[
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    t.note!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
          trailing: Text(
            CurrencyUtils.formatGbpSigned(t.amount),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isIncome ? AppTheme.success : AppTheme.danger,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }
}
