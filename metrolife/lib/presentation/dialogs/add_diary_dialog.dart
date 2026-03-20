/// 編輯日記 Dialog
/// 參考: prd.md Section 3.2C

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/diary_provider.dart';

class DiaryEditDialog extends ConsumerStatefulWidget {
  const DiaryEditDialog({super.key, required this.date, this.existing});

  final DateTime date;
  final DiaryEntry? existing;

  @override
  ConsumerState<DiaryEditDialog> createState() => _DiaryEditDialogState();

  static void show(
    BuildContext context, {
    required DateTime date,
    DiaryEntry? existing,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DiaryEditDialog(date: date, existing: existing),
    );
  }
}

class _DiaryEditDialogState extends ConsumerState<DiaryEditDialog> {
  late final TextEditingController _contentCtrl;
  int? _mood;

  @override
  void initState() {
    super.initState();
    _contentCtrl = TextEditingController(text: widget.existing?.content ?? '');
    _mood = widget.existing?.mood;
  }

  @override
  void dispose() {
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateStr =
        '${widget.date.day.toString().padLeft(2, '0')}/${widget.date.month.toString().padLeft(2, '0')}/${widget.date.year}';
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
              Row(
                children: [
                  const Icon(Icons.book, color: AppTheme.accentPrimary),
                  const SizedBox(width: AppTheme.spacingSm),
                  Text(
                    '$dateStr 日記',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMd),
              Row(
                children: [
                  const Text('心情: ', style: TextStyle(fontSize: 14)),
                  ...List.generate(5, (i) {
                    final star = i + 1;
                    final filled = (_mood ?? 0) >= star;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _mood = (_mood == star) ? null : star),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          filled ? Icons.star : Icons.star_border,
                          color: filled
                              ? AppTheme.accentSecondary
                              : AppTheme.textTertiary,
                          size: 28,
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMd),
              TextField(
                controller: _contentCtrl,
                decoration: const InputDecoration(
                  labelText: '內容',
                  hintText: '記錄今天的心情...',
                  alignLabelWithHint: true,
                ),
                maxLines: 6,
                minLines: 3,
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

  void _save() {
    ref
        .read(diaryServiceProvider)
        .saveDiary(
          date: widget.date,
          content: _contentCtrl.text.trim(),
          mood: _mood,
        );
    Navigator.pop(context);
  }
}
