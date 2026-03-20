/// 新增/編輯待辦 Dialog
/// 參考: prd.md Section 3.2B, UI.md Section 3.2B

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/todo_provider.dart';

class AddTodoDialog extends ConsumerStatefulWidget {
  const AddTodoDialog({super.key, this.existing, this.initialDate});

  final TodoRow? existing;
  final DateTime? initialDate;

  @override
  ConsumerState<AddTodoDialog> createState() => _AddTodoDialogState();

  static void show(
    BuildContext context, {
    TodoRow? existing,
    DateTime? initialDate,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddTodoDialog(existing: existing, initialDate: initialDate),
      ),
    );
  }
}

class _AddTodoDialogState extends ConsumerState<AddTodoDialog> {
  late final TextEditingController _titleCtrl;
  String _type = 'general';
  String? _documentType;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.existing?.title ?? '');
    _type = widget.existing?.type ?? 'general';
    _documentType = widget.existing?.documentType;
    final due = widget.existing?.dueDate;
    if (due != null && due.isNotEmpty) {
      try {
        _dueDate = DateTime.parse(due);
      } catch (_) {}
    }
    _dueDate ??= widget.initialDate;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEdit = widget.existing != null;

    return Container(
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
          Text(
            isEdit ? '編輯待辦' : '新增待辦',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          TextField(
            controller: _titleCtrl,
            decoration: const InputDecoration(
              labelText: '標題',
              hintText: '輸入待辦事項...',
            ),
            autofocus: true,
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Type selector
          Row(
            children: [
              _buildTypeChip('一般', 'general'),
              const SizedBox(width: AppTheme.spacingSm),
              _buildTypeChip('證件續期', 'document'),
              const SizedBox(width: AppTheme.spacingSm),
              _buildTypeChip('賬單提醒', 'bill'),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Document type (if document)
          if (_type == 'document') ...[
            DropdownButtonFormField<String>(
              value: _documentType,
              decoration: const InputDecoration(labelText: '證件類型'),
              items: const [
                DropdownMenuItem(value: 'hkid', child: Text('身份證')),
                DropdownMenuItem(
                  value: 'home_return_permit',
                  child: Text('回鄉證'),
                ),
                DropdownMenuItem(value: 'passport', child: Text('護照')),
                DropdownMenuItem(value: 'membership', child: Text('會員卡')),
              ],
              onChanged: (v) => setState(() => _documentType = v),
            ),
            const SizedBox(height: AppTheme.spacingMd),
          ],

          // Due date picker
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.calendar_today,
              color: AppTheme.accentPrimary,
            ),
            title: Text(
              _dueDate != null
                  ? '${_dueDate!.day.toString().padLeft(2, '0')}/${_dueDate!.month.toString().padLeft(2, '0')}/${_dueDate!.year}'
                  : '選擇日期',
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _dueDate ?? DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
              );
              if (picked != null) setState(() => _dueDate = picked);
            },
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Actions
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
                  child: Text(isEdit ? '儲存' : '新增'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String label, String type) {
    final selected = _type == type;
    return GestureDetector(
      onTap: () => setState(() {
        _type = type;
        if (type != 'document') _documentType = null;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.accentPrimary
              : AppTheme.accentPrimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: selected ? Colors.white : AppTheme.accentPrimary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _save() {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) return;

    final dueStr = _dueDate != null
        ? '${_dueDate!.year.toString().padLeft(4, '0')}-'
              '${_dueDate!.month.toString().padLeft(2, '0')}-'
              '${_dueDate!.day.toString().padLeft(2, '0')}'
        : null;

    final service = ref.read(todoServiceProvider);

    if (widget.existing != null) {
      service.updateTodo(
        id: widget.existing!.id,
        title: title,
        dueDate: dueStr,
        type: _type,
        documentType: _documentType,
      );
    } else {
      service.addTodo(
        title: title,
        dueDate: dueStr,
        type: _type,
        documentType: _documentType,
      );
    }

    Navigator.pop(context);
  }
}
