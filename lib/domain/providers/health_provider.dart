/// Health Connect Riverpod Providers
/// 參考: prd.md Section 3.4, 4.2

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/data/repositories/health_service.dart';
import 'package:metrolife/domain/providers/user_profile_provider.dart';
import 'package:metrolife/core/utils/unit_utils.dart';

final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthService();
});

/// Health connection status
final healthConnectedProvider = NotifierProvider<HealthConnectedNotifier, bool>(
  HealthConnectedNotifier.new,
);

class HealthConnectedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setConnected(bool value) => state = value;
}

/// Today's steps from Health Connect
final healthStepsProvider = FutureProvider<int>((ref) async {
  final service = ref.watch(healthServiceProvider);
  final connected = ref.watch(healthConnectedProvider);
  if (!connected) return 0;
  return service.getTodaySteps();
});

/// Today's calories calculated from steps
final healthCaloriesFromStepsProvider = FutureProvider<double>((ref) async {
  final service = ref.watch(healthServiceProvider);
  final connected = ref.watch(healthConnectedProvider);
  if (!connected) return 0;

  final profile = ref.watch(userProfileProvider);
  if (profile.weightKg <= 0) return 0;

  final steps = await service.getTodaySteps();
  return UnitUtils.calculateStepsCalories(steps, profile.weightKg);
});

/// Today's calories from Health Connect (uses step-based calculation)
final healthCaloriesProvider = FutureProvider<double>((ref) async {
  final connected = ref.watch(healthConnectedProvider);
  if (!connected) return 0;

  final profile = ref.watch(userProfileProvider);
  if (profile.weightKg > 0) {
    final service = ref.watch(healthServiceProvider);
    final steps = await service.getTodaySteps();
    if (steps > 0) {
      return UnitUtils.calculateStepsCalories(steps, profile.weightKg);
    }
  }

  // Fall back to Health Connect's total calories if no weight or no steps
  final service = ref.watch(healthServiceProvider);
  return service.getTodayCalories();
});

/// Weekly steps from Health Connect
final weeklyStepsProvider = FutureProvider<List<int>>((ref) async {
  final service = ref.watch(healthServiceProvider);
  final connected = ref.watch(healthConnectedProvider);
  if (!connected) return List.filled(7, 0);
  return service.getWeeklySteps();
});
