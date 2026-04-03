/// 首頁 - 中央樞紐 (prd.md §3.1, UI.md §3.1)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/core/utils/date_utils.dart';
import 'package:metrolife/l10n/app_localizations.dart';
import 'package:metrolife/domain/providers/user_profile_provider.dart';
import 'package:metrolife/domain/providers/todo_provider.dart';
import 'package:metrolife/presentation/widgets/weather_card.dart';
import 'package:metrolife/presentation/widgets/bus_card.dart';
import 'package:metrolife/presentation/dialogs/nine_day_forecast_sheet.dart';
import 'package:metrolife/presentation/pages/focus_timer_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MetroLife'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        children: [
          // Greeting (prd.md §3.1)
          Text(
            '${AppDateUtils.greeting()} ${profile.username}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            '${AppDateUtils.formatTime(DateTime.now())}, ${AppDateUtils.dayOfWeek(DateTime.now())}',
            style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: AppTheme.spacingLg),

          // Weather Card (prd.md §3.1 + UI.md §3.1)
          WeatherCard(onForecastTap: () => NineDayForecastSheet.show(context)),
          const SizedBox(height: AppTheme.spacingMd),

          // Bus Card (prd.md §3.1 + UI.md §3.1)
          BusCard(),
          const SizedBox(height: AppTheme.spacingMd),

          // Tasks Preview (prd.md §3.1)
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
                        l10n.todaysTasks,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  _buildTodayTasks(context, ref, l10n),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingLg),

          // Focus Timer CTA (prd.md §3.1)
          GestureDetector(
            onTap: () => FocusTimerPage.show(context),
            child: Center(
              child: Column(
                children: [
                  const Text('🍅', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: AppTheme.spacingSm),
                  Text(
                    l10n.startFocusTimer,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accentPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXxl),
        ],
      ),
    );
  }

  Widget _buildTodayTasks(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final todosAsync = ref.watch(todayTodosProvider);

    return todosAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: LinearProgressIndicator(),
      ),
      error: (_, __) => Text(
        l10n.error,
        style: const TextStyle(color: AppTheme.textSecondary),
      ),
      data: (todos) {
        if (todos.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              l10n.noData,
              style: const TextStyle(color: AppTheme.textSecondary),
            ),
          );
        }

        return Column(
          children: todos.take(5).map((todo) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(todoServiceProvider)
                          .toggleComplete(todo.id, true);
                    },
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 20,
                      color: AppTheme.accentPrimary,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Expanded(
                    child: Text(
                      todo.title,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
