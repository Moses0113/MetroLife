/// 日常頁 - 完整實現 (prd.md §3.2, UI.md §3.2)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/l10n/app_localizations.dart';
import 'package:metrolife/domain/providers/todo_provider.dart';
import 'package:metrolife/domain/providers/diary_provider.dart';
import 'package:metrolife/presentation/dialogs/add_todo_dialog.dart';
import 'package:metrolife/presentation/dialogs/add_diary_dialog.dart';
import 'package:metrolife/presentation/widgets/diligent_rabbit_overlay.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyPage extends ConsumerStatefulWidget {
  const DailyPage({super.key});

  @override
  ConsumerState<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends ConsumerState<DailyPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.daily),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: l10n.addTask,
            onPressed: () =>
                AddTodoDialog.show(context, initialDate: _selectedDay),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.bgTertiaryDark : AppTheme.bgTertiary,
                borderRadius: BorderRadius.circular(AppTheme.radiusPill),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: isDark ? AppTheme.bgSecondaryDark : Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                  boxShadow: AppTheme.shadowSm,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppTheme.accentPrimary,
                unselectedLabelColor: AppTheme.textSecondary,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: l10n.calendar),
                  Tab(text: l10n.todo),
                  Tab(text: l10n.diary),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _CalendarTab(
            selectedDay: _selectedDay,
            focusedDay: _focusedDay,
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
          ),
          _TodoTab(selectedDay: _selectedDay),
          _DiaryTab(selectedDay: _selectedDay),
        ],
      ),
    );
  }
}

// ==================== CALENDAR TAB ====================

class _CalendarTab extends ConsumerWidget {
  const _CalendarTab({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
  });

  final DateTime selectedDay;
  final DateTime focusedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final todosAsync = ref.watch(todosByDateProvider(selectedDay));
    final diaryAsync = ref.watch(diaryByDateProvider(selectedDay));

    return ListView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      children: [
        // Calendar
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) => isSameDay(day, selectedDay),
              onDaySelected: onDaySelected,
              locale: 'zh_HK',
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  color: AppTheme.accentPrimary,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: AppTheme.accentPrimary,
                ),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.accentPrimary, width: 2),
                ),
                todayTextStyle: TextStyle(
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                selectedDecoration: const BoxDecoration(
                  color: AppTheme.accentPrimary,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                defaultTextStyle: TextStyle(
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
                weekendTextStyle: TextStyle(
                  color: isDark ? Colors.white70 : AppTheme.textSecondary,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  return _buildMarkers(context, ref, date);
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingMd),

        // Selected date info
        Text(
          '${selectedDay.day.toString().padLeft(2, '0')}/${selectedDay.month.toString().padLeft(2, '0')}/${selectedDay.year}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppTheme.spacingSm),

        // Tasks for selected day
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.checklist,
                      color: AppTheme.accentPrimary,
                      size: 20,
                    ),
                    const SizedBox(width: AppTheme.spacingSm),
                    Text(
                      '${l10n.todaysTasks} (${selectedDay.day.toString().padLeft(2, '0')}/${selectedDay.month.toString().padLeft(2, '0')})',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                todosAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => Text(l10n.error),
                  data: (todos) {
                    if (todos.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(AppTheme.spacingSm),
                        child: Text(
                          l10n.noData,
                          style: const TextStyle(color: AppTheme.textSecondary),
                        ),
                      );
                    }
                    return Column(
                      children: todos
                          .map((todo) => _buildTodoItem(context, ref, todo))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: AppTheme.spacingSm),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        AddTodoDialog.show(context, initialDate: selectedDay),
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(l10n.addTask),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingSm),

        // Diary for selected day
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.book,
                      color: AppTheme.accentPrimary,
                      size: 20,
                    ),
                    const SizedBox(width: AppTheme.spacingSm),
                    Text(
                      l10n.diary,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                diaryAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => Text(l10n.error),
                  data: (diary) {
                    if (diary == null) {
                      return Padding(
                        padding: const EdgeInsets.all(AppTheme.spacingSm),
                        child: Row(
                          children: [
                            Text(
                              l10n.noData,
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () => DiaryEditDialog.show(
                                context,
                                date: selectedDay,
                              ),
                              child: const Text('寫日記'),
                            ),
                          ],
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (diary.mood != null)
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < (diary.mood ?? 0)
                                    ? Icons.star
                                    : Icons.star_border,
                                color: i < (diary.mood ?? 0)
                                    ? AppTheme.accentSecondary
                                    : AppTheme.textTertiary,
                                size: 18,
                              ),
                            ),
                          ),
                        if (diary.content != null &&
                            diary.content!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            diary.content!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => DiaryEditDialog.show(
                              context,
                              date: selectedDay,
                              existing: diary,
                            ),
                            child: Text(l10n.edit),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingXl),
      ],
    );
  }

  Widget _buildMarkers(BuildContext context, WidgetRef ref, DateTime date) {
    // We can't call async providers synchronously here
    // Return empty for now, markers are visual-only
    return const SizedBox();
  }

  Widget _buildTodoItem(BuildContext context, WidgetRef ref, TodoRow todo) {
    final isCompleted = todo.isCompleted == 1;
    final typeLabel = _getTypeLabel(todo.type);
    final typeColor = _getTypeColor(todo.type);

    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppTheme.spacingMd),
        color: AppTheme.danger,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => ref.read(todoServiceProvider).deleteTodo(todo.id),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Checkbox(
          value: isCompleted,
          activeColor: AppTheme.accentPrimary,
          onChanged: (v) {
            ref.read(todoServiceProvider).toggleComplete(todo.id, v ?? false);
            if (v == true) {
              DiligentRabbitOverlay.show(
                context,
                scene: RabbitScene.todoComplete,
              );
            }
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? AppTheme.textTertiary : null,
          ),
        ),
        subtitle: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                typeLabel,
                style: TextStyle(fontSize: 11, color: typeColor),
              ),
            ),
            if (todo.dueDate != null && todo.dueDate!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Due: ${_formatDueDate(todo.dueDate!)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 18),
              onPressed: () => AddTodoDialog.show(context, existing: todo),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                size: 18,
                color: AppTheme.danger,
              ),
              onPressed: () =>
                  ref.read(todoServiceProvider).deleteTodo(todo.id),
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'document':
        return '證件續期';
      case 'bill':
        return '賬單提醒';
      default:
        return '一般';
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'document':
        return AppTheme.warning;
      case 'bill':
        return Colors.blue;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _formatDueDate(String dateStr) {
    try {
      final d = DateTime.parse(dateStr);
      return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
    } catch (_) {
      return dateStr;
    }
  }
}

// ==================== TODO TAB ====================

class _TodoTab extends ConsumerStatefulWidget {
  const _TodoTab({required this.selectedDay});

  final DateTime selectedDay;

  @override
  ConsumerState<_TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends ConsumerState<_TodoTab> {
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final todosAsync = ref.watch(todosByTypeProvider(_filter));

    return Column(
      children: [
        // Filter chips
        Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('全部', 'all'),
                const SizedBox(width: AppTheme.spacingSm),
                _buildFilterChip('證件', 'document'),
                const SizedBox(width: AppTheme.spacingSm),
                _buildFilterChip('賬單', 'bill'),
                const SizedBox(width: AppTheme.spacingSm),
                _buildFilterChip('一般', 'general'),
              ],
            ),
          ),
        ),

        // Todo list
        Expanded(
          child: todosAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('${l10n.error}: $err')),
            data: (todos) {
              if (todos.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.checklist,
                        size: 64,
                        color: AppTheme.textTertiary,
                      ),
                      const SizedBox(height: AppTheme.spacingMd),
                      Text(
                        l10n.noData,
                        style: const TextStyle(color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                );
              }

              final incomplete = todos
                  .where((t) => t.isCompleted == 0)
                  .toList();
              final completed = todos.where((t) => t.isCompleted == 1).toList();

              return ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                ),
                children: [
                  ...incomplete.map(
                    (todo) => _buildTodoCard(context, ref, todo),
                  ),
                  if (completed.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: AppTheme.spacingMd),
                      child: Text(
                        '${l10n.completedTasks} (${completed.length})',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ...completed.map(
                      (todo) =>
                          _buildTodoCard(context, ref, todo, completed: true),
                    ),
                  ],
                  const SizedBox(height: 80),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String type) {
    final selected = _filter == type;
    return GestureDetector(
      onTap: () => setState(() => _filter = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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

  Widget _buildTodoCard(
    BuildContext context,
    WidgetRef ref,
    TodoRow todo, {
    bool completed = false,
  }) {
    final typeLabel = _CalendarTabState_getTypeLabel(todo.type);
    final typeColor = _CalendarTabState_getTypeColor(todo.type);

    return Dismissible(
      key: ValueKey(todo.id),
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
      onDismissed: (_) => ref.read(todoServiceProvider).deleteTodo(todo.id),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: completed,
            activeColor: AppTheme.accentPrimary,
            onChanged: (v) {
              ref.read(todoServiceProvider).toggleComplete(todo.id, v ?? false);
              if (v == true) {
                DiligentRabbitOverlay.show(
                  context,
                  scene: RabbitScene.todoComplete,
                );
              }
            },
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: completed ? TextDecoration.lineThrough : null,
              color: completed ? AppTheme.textTertiary : null,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: typeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    typeLabel,
                    style: TextStyle(fontSize: 11, color: typeColor),
                  ),
                ),
                if (todo.dueDate != null && todo.dueDate!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Due: ${_CalendarTabState_formatDate(todo.dueDate!)}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () => AddTodoDialog.show(context, existing: todo),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: AppTheme.danger,
                ),
                onPressed: () =>
                    ref.read(todoServiceProvider).deleteTodo(todo.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== DIARY TAB ====================

class _DiaryTab extends ConsumerStatefulWidget {
  const _DiaryTab({required this.selectedDay});

  final DateTime selectedDay;

  @override
  ConsumerState<_DiaryTab> createState() => _DiaryTabState();
}

class _DiaryTabState extends ConsumerState<_DiaryTab> {
  late DateTime _diaryDate;

  @override
  void initState() {
    super.initState();
    _diaryDate = widget.selectedDay;
  }

  @override
  void didUpdateWidget(_DiaryTab old) {
    super.didUpdateWidget(old);
    if (widget.selectedDay != old.selectedDay) {
      _diaryDate = widget.selectedDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final diaryAsync = ref.watch(diaryByDateProvider(_diaryDate));
    final dateStr =
        '${_diaryDate.day.toString().padLeft(2, '0')}/'
        '${_diaryDate.month.toString().padLeft(2, '0')}/'
        '${_diaryDate.year}';

    return ListView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      children: [
        // Date picker
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.calendar_today,
              color: AppTheme.accentPrimary,
            ),
            title: Text(dateStr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _diaryDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) setState(() => _diaryDate = picked);
            },
          ),
        ),
        const SizedBox(height: AppTheme.spacingMd),

        diaryAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('${l10n.error}: $err')),
          data: (diary) {
            if (diary == null) {
              return _buildEmptyDiary(context);
            }
            return _buildDiaryEntry(context, diary);
          },
        ),
      ],
    );
  }

  Widget _buildEmptyDiary(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXl),
        child: Column(
          children: [
            Icon(
              Icons.book_outlined,
              size: 64,
              color: AppTheme.textTertiary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            const Text(
              '今天還沒有日記',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            ElevatedButton.icon(
              onPressed: () => DiaryEditDialog.show(context, date: _diaryDate),
              icon: const Icon(Icons.edit),
              label: const Text('寫日記'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiaryEntry(BuildContext context, DiaryEntry diary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Mood
        if (diary.mood != null)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Row(
                children: [
                  const Text(
                    '心情: ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  ...List.generate(
                    5,
                    (i) => Icon(
                      i < (diary.mood ?? 0) ? Icons.star : Icons.star_border,
                      color: i < (diary.mood ?? 0)
                          ? AppTheme.accentSecondary
                          : AppTheme.textTertiary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: AppTheme.spacingSm),

        // Content
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: diary.content != null && diary.content!.isNotEmpty
                ? Text(
                    diary.content!,
                    style: const TextStyle(fontSize: 15, height: 1.6),
                  )
                : const Text(
                    '空日記',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingMd),

        // Actions
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => DiaryEditDialog.show(
                  context,
                  date: _diaryDate,
                  existing: diary,
                ),
                icon: const Icon(Icons.edit),
                label: const Text('編輯'),
              ),
            ),
            const SizedBox(width: AppTheme.spacingSm),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ref.read(diaryServiceProvider).deleteDiary(diary.id);
                },
                icon: const Icon(Icons.delete, color: AppTheme.danger),
                label: const Text(
                  '刪除',
                  style: TextStyle(color: AppTheme.danger),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ==================== Helper functions ====================

String _CalendarTabState_getTypeLabel(String type) {
  switch (type) {
    case 'document':
      return '證件續期';
    case 'bill':
      return '賬單提醒';
    default:
      return '一般';
  }
}

Color _CalendarTabState_getTypeColor(String type) {
  switch (type) {
    case 'document':
      return AppTheme.warning;
    case 'bill':
      return Colors.blue;
    default:
      return AppTheme.textSecondary;
  }
}

String _CalendarTabState_formatDate(String dateStr) {
  try {
    final d = DateTime.parse(dateStr);
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
  } catch (_) {
    return dateStr;
  }
}
