/// 運動頁 - 完整實現 (prd.md §3.4, UI.md §3.4)
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/core/theme/app_theme.dart';
import 'package:metrolife/l10n/app_localizations.dart';
import 'package:metrolife/domain/providers/exercise_provider.dart';
import 'package:metrolife/domain/providers/user_profile_provider.dart';
import 'package:metrolife/domain/providers/health_provider.dart';
import 'package:metrolife/presentation/dialogs/exercise_dialog.dart';

class ExercisePage extends ConsumerStatefulWidget {
  const ExercisePage({super.key});

  @override
  ConsumerState<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends ConsumerState<ExercisePage> {
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  double? _bmi;
  String _bmiCategory = '';
  bool _useMetric = true;

  @override
  void dispose() {
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  void _calculateBmi() {
    final height = double.tryParse(_heightCtrl.text);
    final weight = double.tryParse(_weightCtrl.text);
    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _bmi = null;
        _bmiCategory = '';
      });
      return;
    }

    double heightCm = height;
    double weightKg = weight;
    if (!_useMetric) {
      heightCm = height * 30.48; // ft to cm
      weightKg = weight / 2.20462; // lb to kg
    }

    // Sync to user profile
    ref.read(userProfileProvider.notifier).updateHeight(heightCm);
    ref.read(userProfileProvider.notifier).updateWeight(weightKg);

    final bmi = ExerciseService.calculateBmi(heightCm, weightKg);
    setState(() {
      _bmi = bmi;
      _bmiCategory = ExerciseService.getBmiCategory(bmi);
    });
  }

  Future<void> _handleHealthSync(WidgetRef ref) async {
    final healthService = ref.read(healthServiceProvider);

    // Request permissions (configure is called internally)
    final granted = await healthService.requestPermissions();

    if (granted) {
      ref.read(healthConnectedProvider.notifier).setConnected(true);

      // Refresh health data
      ref.invalidate(healthStepsProvider);
      ref.invalidate(healthCaloriesProvider);
      ref.invalidate(weeklyStepsProvider);

      // Try to read weight from health
      final weight = await healthService.getLatestWeight();
      if (weight != null && weight > 0) {
        _weightCtrl.text = weight.toStringAsFixed(1);
        ref.read(userProfileProvider.notifier).updateWeight(weight);
        _calculateBmi();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('未能獲得 Health Connect 權限')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final healthConnected = ref.watch(healthConnectedProvider);
    // Use health data when connected, fall back to local DB
    final stepsAsync = healthConnected
        ? ref.watch(healthStepsProvider)
        : ref.watch(todayStepsProvider);
    final caloriesAsync = healthConnected
        ? ref.watch(healthCaloriesProvider)
        : ref.watch(todayCaloriesProvider);
    final streakAsync = ref.watch(streakDaysProvider);
    final profile = ref.watch(userProfileProvider);

    // Sync height/weight controllers with profile
    if (!_heightCtrl.selection.isValid && profile.heightCm > 0) {
      _heightCtrl.text = profile.heightCm.toStringAsFixed(0);
    }
    if (!_weightCtrl.selection.isValid && profile.weightKg > 0) {
      _weightCtrl.text = profile.weightKg.toStringAsFixed(0);
    }
    // Auto-calculate BMI if values are loaded and BMI not yet calculated
    if (_bmi == null &&
        _heightCtrl.text.isNotEmpty &&
        _weightCtrl.text.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _calculateBmi());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.exercise),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        children: [
          // Health sync status
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: ref.watch(healthConnectedProvider)
                    ? AppTheme.success
                    : AppTheme.textTertiary.withValues(alpha: 0.2),
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: ref.watch(healthConnectedProvider)
                    ? AppTheme.success
                    : const Color(0xFF9E9E9E),
                radius: 16,
                child: Icon(
                  ref.watch(healthConnectedProvider)
                      ? Icons.check
                      : Icons.health_and_safety,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              title: Text(
                ref.watch(healthConnectedProvider)
                    ? l10n.healthConnected
                    : l10n.healthNotConnected,
              ),
              subtitle: Text(
                Platform.isAndroid ? 'Health Connect' : 'Apple Health',
              ),
              trailing: OutlinedButton(
                onPressed: () => _handleHealthSync(ref),
                child: Text(l10n.syncNow),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // BMI Calculator
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.monitor_weight,
                        color: AppTheme.accentPrimary,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacingSm),
                      Text(
                        l10n.bmiCalculator,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      _buildUnitToggle(),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: AppTheme.spacingSm),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _heightCtrl,
                          decoration: InputDecoration(
                            labelText: l10n.height,
                            suffixText: _useMetric ? l10n.cm : l10n.unitInch,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _calculateBmi(),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingMd),
                      Expanded(
                        child: TextField(
                          controller: _weightCtrl,
                          decoration: InputDecoration(
                            labelText: l10n.weight,
                            suffixText: _useMetric ? l10n.kg : l10n.lb,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _calculateBmi(),
                        ),
                      ),
                    ],
                  ),
                  if (_bmi != null) ...[
                    const SizedBox(height: AppTheme.spacingMd),
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingMd),
                      decoration: BoxDecoration(
                        color: _getBmiColor(_bmi!).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusSmall,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${l10n.yourBmi}: ${_bmi!.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _getBmiColor(_bmi!),
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingSm),
                          Text(
                            '($_bmiCategory)',
                            style: TextStyle(
                              fontSize: 14,
                              color: _getBmiColor(_bmi!),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Today's Activity
          Text(
            l10n.todaysSteps,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.directions_walk,
                          color: AppTheme.accentPrimary,
                        ),
                        const SizedBox(height: AppTheme.spacingSm),
                        stepsAsync.when(
                          loading: () => const Text(
                            '--',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          error: (_, __) => const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          data: (steps) => Text(
                            '$steps',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          l10n.todaysSteps,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: AppTheme.warning,
                        ),
                        const SizedBox(height: AppTheme.spacingSm),
                        caloriesAsync.when(
                          loading: () => const Text(
                            '--',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          error: (_, __) => const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          data: (cal) => Text(
                            cal.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          l10n.calories,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Quick Actions
          Text(
            l10n.quickActions,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Row(
            children: [
              _buildQuickAction(Icons.directions_run, l10n.running, 'running'),
              const SizedBox(width: AppTheme.spacingSm),
              _buildQuickAction(Icons.pool, l10n.swimming, 'swimming'),
              const SizedBox(width: AppTheme.spacingSm),
              _buildQuickAction(Icons.directions_bike, l10n.cycling, 'cycling'),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Row(
            children: [
              _buildQuickAction(
                Icons.sports_tennis,
                l10n.tableTennis,
                'table_tennis',
              ),
              const SizedBox(width: AppTheme.spacingSm),
              _buildQuickAction(Icons.self_improvement, l10n.yoga, 'yoga'),
              const SizedBox(width: AppTheme.spacingSm),
              _buildQuickAction(Icons.fitness_center, l10n.gym, 'gym'),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Medals
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: AppTheme.accentSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacingSm),
                      Text(
                        l10n.medals,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: AppTheme.spacingSm),
                  streakAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const SizedBox(),
                    data: (streak) => _buildMedals(context, streak, l10n),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ExerciseDialog.show(context),
        backgroundColor: AppTheme.accentPrimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(l10n.exercise, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildUnitToggle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _useMetric = !_useMetric;
          _heightCtrl.clear();
          _weightCtrl.clear();
          _bmi = null;
          _bmiCategory = '';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.accentPrimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
        ),
        child: Text(
          _useMetric ? '公制' : '英制',
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.accentPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, String type) {
    return Expanded(
      child: Card(
        child: InkWell(
          onTap: () => ExerciseDialog.show(context),
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
            child: Column(
              children: [
                Icon(icon, size: 32, color: AppTheme.accentPrimary),
                const SizedBox(height: AppTheme.spacingSm),
                Text(label, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedals(BuildContext context, int streak, AppLocalizations l10n) {
    final bronzeUnlocked = streak >= 3;
    final silverUnlocked = streak >= 7;
    final goldUnlocked = streak >= 30;

    int daysToNext = 0;
    String nextMedal = '';
    if (!bronzeUnlocked) {
      daysToNext = 3 - streak;
      nextMedal = '銅牌';
    } else if (!silverUnlocked) {
      daysToNext = 7 - streak;
      nextMedal = '銀牌';
    } else if (!goldUnlocked) {
      daysToNext = 30 - streak;
      nextMedal = '金牌';
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMedalBadge('🥉', l10n.bronze3Days, bronzeUnlocked),
            _buildMedalBadge('🥈', l10n.silver7Days, silverUnlocked),
            _buildMedalBadge('🏆', l10n.gold30Days, goldUnlocked),
          ],
        ),
        if (daysToNext > 0) ...[
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            '再努力 $daysToNext 天即可獲得 $nextMedal！',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMedalBadge(String emoji, String title, bool unlocked) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: unlocked
                ? AppTheme.accentSecondary.withValues(alpha: 0.2)
                : AppTheme.textTertiary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              emoji,
              style: TextStyle(
                fontSize: 24,
                color: unlocked ? null : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: unlocked ? null : AppTheme.textTertiary,
          ),
        ),
        Text(
          unlocked ? '已解鎖' : '未解鎖',
          style: TextStyle(
            fontSize: 10,
            color: unlocked ? AppTheme.success : AppTheme.textTertiary,
          ),
        ),
      ],
    );
  }

  Color _getBmiColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return AppTheme.success;
    if (bmi < 30) return AppTheme.warning;
    return AppTheme.danger;
  }
}
