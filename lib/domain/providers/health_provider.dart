/// Health Connect Riverpod Providers
/// 參考: prd.md Section 3.4, 4.2

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/data/repositories/health_service.dart';

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

/// Today's calories from Health Connect
final healthCaloriesProvider = FutureProvider<double>((ref) async {
  final service = ref.watch(healthServiceProvider);
  final connected = ref.watch(healthConnectedProvider);
  if (!connected) return 0;
  return service.getTodayCalories();
});

/// Weekly steps from Health Connect
final weeklyStepsProvider = FutureProvider<List<int>>((ref) async {
  final service = ref.watch(healthServiceProvider);
  final connected = ref.watch(healthConnectedProvider);
  if (!connected) return List.filled(7, 0);
  return service.getWeeklySteps();
});
