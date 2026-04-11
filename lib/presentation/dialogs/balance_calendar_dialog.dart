/// 結餘日曆 Dialog — 查閱上月結餘及總結餘
library;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/core/utils/currency_utils.dart';
import 'package:metrolife/core/utils/date_utils.dart';
import 'package:metrolife/domain/providers/balance_provider.dart';
import 'package:metrolife/domain/providers/user_profile_provider.dart';
import 'package:metrolife/domain/providers/transaction_provider.dart';

class BalanceCalendarDialog extends ConsumerStatefulWidget {
  const BalanceCalendarDialog({super.key});

  @override
  ConsumerState<BalanceCalendarDialog> createState() =>
      _BalanceCalendarDialogState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const BalanceCalendarDialog(),
    );
  }
}

class _BalanceCalendarDialogState extends ConsumerState<BalanceCalendarDialog> {
  DateTime _focusedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    final profile = ref.watch(userProfileProvider);
    final balanceAsync = ref.watch(
      monthlyBalanceProvider(profile.settlementDay),
    );
    final monthlySummaryAsync = ref.watch(
      monthlySummaryProvider(_focusedMonth),
    );

    return SizedBox(
      height: screenHeight * 0.85,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.bgPrimaryDark : AppTheme.bgPrimary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppTheme.radiusLarge),
            topRight: Radius.circular(AppTheme.radiusLarge),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textTertiary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: AppTheme.accentPrimary,
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  const Expanded(
                    child: Text(
                      '結餘日曆',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.accentPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '結算日: ${profile.settlementDay}日',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.accentPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Balance Summary Cards
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd,
              ),
              child: balanceAsync.when(
                loading: () => _buildBalanceCardsLoading(),
                error: (_, _) => _buildBalanceCardsLoading(),
                data: (balance) => _buildBalanceCards(balance),
              ),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            // Calendar
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                ),
                children: [
                  _buildCalendar(isDark, monthlySummaryAsync),
                  const SizedBox(height: AppTheme.spacingMd),
                  // Monthly detail
                  monthlySummaryAsync.when(
                    loading: () => const SizedBox(),
                    error: (_, _) => const SizedBox(),
                    data: (summary) => _buildMonthlyDetail(summary),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCardsLoading() {
    return Row(
      children: [
        Expanded(child: _buildBalanceCard('上月結餘', 0, isLoading: true)),
        const SizedBox(width: AppTheme.spacingSm),
        Expanded(child: _buildBalanceCard('總結餘', 0, isLoading: true)),
      ],
    );
  }

  Widget _buildBalanceCards(MonthlyPeriodBalance balance) {
    return Row(
      children: [
        Expanded(
          child: _buildBalanceCard(
            '上月結餘',
            balance.lastPeriod.balance,
            subtitle:
                '${AppDateUtils.formatDdMm(balance.lastPeriodStart)} — ${AppDateUtils.formatDdMm(balance.lastPeriodEnd)}',
          ),
        ),
        const SizedBox(width: AppTheme.spacingSm),
        Expanded(
          child: _buildBalanceCard('總結餘', balance.totalBalance, isTotal: true),
        ),
      ],
    );
  }

  Widget _buildBalanceCard(
    String title,
    double amount, {
    String? subtitle,
    bool isLoading = false,
    bool isTotal = false,
  }) {
    final isPositive = amount >= 0;
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingSm + 2),
      decoration: BoxDecoration(
        color: isTotal
            ? AppTheme.accentPrimary.withValues(alpha: 0.08)
            : (isPositive
                  ? AppTheme.success.withValues(alpha: 0.08)
                  : AppTheme.danger.withValues(alpha: 0.08)),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: isTotal
              ? AppTheme.accentPrimary.withValues(alpha: 0.2)
              : (isPositive
                    ? AppTheme.success.withValues(alpha: 0.2)
                    : AppTheme.danger.withValues(alpha: 0.2)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 10, color: AppTheme.textTertiary),
            ),
          ],
          const SizedBox(height: 4),
          isLoading
              ? const SizedBox(
                  height: 24,
                  child: Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              : Text(
                  CurrencyUtils.formatGbp(amount),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isTotal
                        ? AppTheme.accentPrimary
                        : (isPositive ? AppTheme.success : AppTheme.danger),
                    fontFamily: 'monospace',
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildCalendar(bool isDark, AsyncValue<MonthlySummary> summaryAsync) {
    final profile = ref.watch(userProfileProvider);
    final settlementDay = profile.settlementDay;
    final salaryDay = profile.salaryDay;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.bgSecondaryDark : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: AppTheme.shadowSm,
      ),
      child: TableCalendar(
        firstDay: DateTime(2020),
        lastDay: DateTime(2100),
        focusedDay: _focusedMonth,
        calendarFormat: CalendarFormat.month,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppTheme.accentPrimary.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppTheme.accentPrimary,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: TextStyle(
            color: isDark ? Colors.white : AppTheme.textPrimary,
          ),
          weekendTextStyle: TextStyle(
            color: isDark
                ? AppTheme.textTertiary
                : AppTheme.danger.withValues(alpha: 0.7),
          ),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            final isSettlementDay = date.day == settlementDay;
            final isSalaryDay = date.day == salaryDay;

            if (!isSettlementDay && !isSalaryDay) return null;

            return Positioned(
              bottom: 1,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSettlementDay)
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: const BoxDecoration(
                        color: AppTheme.accentPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  if (isSalaryDay)
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFCC00),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        onPageChanged: (focusedDay) {
          setState(() => _focusedMonth = focusedDay);
        },
      ),
    );
  }

  Widget _buildMonthlyDetail(MonthlySummary summary) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.accentPrimary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: AppTheme.accentPrimary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_focusedMonth.month}月結餘 (${AppDateUtils.formatYyMm(_focusedMonth)})',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem('收入', summary.income, AppTheme.success),
              ),
              Expanded(
                child: _buildDetailItem('支出', summary.expense, AppTheme.danger),
              ),
              Expanded(
                child: _buildDetailItem(
                  '結餘',
                  summary.balance,
                  summary.balance >= 0 ? AppTheme.success : AppTheme.danger,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 2),
        Text(
          CurrencyUtils.formatGbp(value),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}
