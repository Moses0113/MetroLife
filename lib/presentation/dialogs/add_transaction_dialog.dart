/// 新增收支 Dialog
/// 參考: prd.md Section 3.3, UI.md Section 3.3

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/domain/providers/transaction_provider.dart';
import 'package:metrolife/domain/providers/category_provider.dart';
import 'package:metrolife/presentation/widgets/diligent_rabbit_overlay.dart';

class AddTransactionDialog extends ConsumerStatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  ConsumerState<AddTransactionDialog> createState() =>
      _AddTransactionDialogState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const AddTransactionDialog(),
    );
  }
}

class _AddTransactionDialogState extends ConsumerState<AddTransactionDialog> {
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String _type = 'expense';
  String? _categoryId;
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categoriesAsync = _type == 'expense'
        ? ref.watch(expenseCategoriesProvider)
        : ref.watch(incomeCategoriesProvider);
    final dateStr =
        '${_date.day.toString().padLeft(2, '0')}/${_date.month.toString().padLeft(2, '0')}/${_date.year}';
    final insets = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: insets),
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(AppTheme.spacingMd),
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.bgSecondaryDark : Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '新增收支',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppTheme.spacingMd),
              Row(
                children: [
                  _buildTypeToggle('支出', 'expense'),
                  const SizedBox(width: AppTheme.spacingSm),
                  _buildTypeToggle('收入', 'income'),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMd),
              TextField(
                controller: _amountCtrl,
                decoration: const InputDecoration(
                  labelText: '金額',
                  prefixText: '\$ ',
                  hintText: '0.00',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                autofocus: true,
              ),
              const SizedBox(height: AppTheme.spacingMd),
              categoriesAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('無法載入分類: $e'),
                data: (cats) {
                  if (_categoryId == null && cats.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) setState(() => _categoryId = cats.first.id);
                    });
                  }
                  if (cats.isEmpty) return const Text('暫無分類，請先在設定中添加');
                  return DropdownButtonFormField<String>(
                    value: cats.any((c) => c.id == _categoryId)
                        ? _categoryId
                        : null,
                    decoration: const InputDecoration(labelText: '分類'),
                    items: cats
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _categoryId = v),
                  );
                },
              ),
              const SizedBox(height: AppTheme.spacingMd),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.calendar_today,
                  color: AppTheme.accentPrimary,
                ),
                title: Text(dateStr),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) setState(() => _date = picked);
                },
              ),
              const SizedBox(height: AppTheme.spacingSm),
              TextField(
                controller: _noteCtrl,
                decoration: const InputDecoration(
                  labelText: '備註 (選填)',
                  hintText: '輸入備註...',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: AppTheme.spacingMd),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('取消'),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('儲存'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeToggle(String label, String type) {
    final selected = _type == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _type = type;
          _categoryId = null;
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? (type == 'income' ? AppTheme.success : AppTheme.danger)
                : (type == 'income'
                      ? AppTheme.success.withValues(alpha: 0.1)
                      : AppTheme.danger.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : null,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    final amountText = _amountCtrl.text.trim();
    if (amountText.isEmpty || _categoryId == null) return;
    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) return;
    final signedAmount = _type == 'expense' ? -amount : amount;
    ref
        .read(transactionServiceProvider)
        .addTransaction(
          date: _date,
          amount: signedAmount,
          categoryId: _categoryId!,
          note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
          transactionType: _type,
        );
    Navigator.pop(context);
    if (_type == 'income') {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted)
          DiligentRabbitOverlay.show(context, scene: RabbitScene.incomeAdded);
      });
    }
  }
}
