/// 運動記錄 Dialog
/// 參考: prd.md Section 3.4D

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/domain/providers/exercise_provider.dart';
import 'package:metrolife/domain/providers/health_provider.dart';
import 'package:metrolife/domain/providers/achievement_provider.dart';
import 'package:metrolife/presentation/widgets/diligent_rabbit_overlay.dart';

class ExerciseDialog extends ConsumerStatefulWidget {
  const ExerciseDialog({super.key, this.initialType});

  final String? initialType;

  @override
  ConsumerState<ExerciseDialog> createState() => _ExerciseDialogState();

  static void show(BuildContext context, {String? initialType}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ExerciseDialog(initialType: initialType),
    );
  }
}

class _ExerciseDialogState extends ConsumerState<ExerciseDialog> {
  late String _type = widget.initialType ?? 'running';
  final _minutesCtrl = TextEditingController();
  final double _weightKg = 70.0;

  @override
  void dispose() {
    _minutesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                '記錄運動',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppTheme.spacingMd),
              Wrap(
                spacing: AppTheme.spacingSm,
                runSpacing: AppTheme.spacingSm,
                children: [
                  _buildTypeChip('跑步', 'running', Icons.directions_run),
                  _buildTypeChip('游泳', 'swimming', Icons.pool),
                  _buildTypeChip('乒乓球', 'table_tennis', Icons.sports_tennis),
                  _buildTypeChip('單車', 'cycling', Icons.directions_bike),
                  _buildTypeChip('瑜伽', 'yoga', Icons.self_improvement),
                  _buildTypeChip('健身', 'gym', Icons.fitness_center),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMd),
              TextField(
                controller: _minutesCtrl,
                decoration: const InputDecoration(
                  labelText: '時長 (分鐘)',
                  hintText: '30',
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: AppTheme.spacingMd),
              _buildCaloriesPreview(),
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

  Widget _buildTypeChip(String label, String type, IconData icon) {
    final selected = _type == type;
    return GestureDetector(
      onTap: () => setState(() => _type = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.accentPrimary
              : AppTheme.accentPrimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? Colors.white : AppTheme.accentPrimary,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : AppTheme.accentPrimary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaloriesPreview() {
    final minutes = int.tryParse(_minutesCtrl.text) ?? 0;
    if (minutes <= 0) return const SizedBox();
    final calories = ExerciseService.calculateExerciseCalories(
      _type,
      _weightKg,
      minutes,
    );
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department,
            color: AppTheme.warning,
            size: 20,
          ),
          const SizedBox(width: AppTheme.spacingSm),
          Text(
            '預計消耗 ${calories.toStringAsFixed(0)} 卡路里',
            style: const TextStyle(
              color: AppTheme.warning,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final minutes = int.tryParse(_minutesCtrl.text);
    if (minutes == null || minutes <= 0) return;
    final calories = ExerciseService.calculateExerciseCalories(
      _type,
      _weightKg,
      minutes,
    );
    final now = DateTime.now();

    String? healthPlatformId;

    // Sync to Health Connect if connected and has permissions
    final healthConnected = ref.read(healthConnectedProvider);
    if (healthConnected) {
      final hasPerms = await ref.read(healthServiceProvider).hasPermissions();
      if (hasPerms) {
        await ref
            .read(healthServiceProvider)
            .writeWorkout(
              exerciseType: _type,
              start: now,
              end: now.add(Duration(minutes: minutes)),
              totalCaloriesBurned: calories,
            );
        healthPlatformId = now.millisecondsSinceEpoch.toString();
      }
    }

    ref
        .read(exerciseServiceProvider)
        .recordExercise(
          type: _type,
          startTime: now,
          durationSeconds: minutes * 60,
          caloriesBurned: calories,
          weightAtTimeKg: _weightKg,
          healthPlatformId: healthPlatformId,
        );

    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 500), () async {
      final streak = await ref.read(streakDaysProvider.future);
      final newMedal = await ref
          .read(achievementServiceProvider)
          .checkAndAwardMedals(streak);
      if (newMedal != null && context.mounted) {
        final scene = switch (newMedal) {
          'bronze_3days' => RabbitScene.achievementBronze,
          'silver_7days' => RabbitScene.achievementSilver,
          'gold_30days' => RabbitScene.achievementGold,
          _ => RabbitScene.achievementBronze,
        };
        DiligentRabbitOverlay.show(context, scene: scene);
        ref.read(achievementServiceProvider).markShown(newMedal);
      }
    });
  }
}
