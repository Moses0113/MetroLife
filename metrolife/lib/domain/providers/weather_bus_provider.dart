/// Weather & Bus Riverpod Providers
/// 參考: prd.md Section 3.1, 5.1, 5.2

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/data/models/weather_models.dart';
import 'package:metrolife/data/models/bus_models.dart';
import 'package:metrolife/data/repositories/hko_weather_service.dart';
import 'package:metrolife/data/repositories/kmb_bus_service.dart';

final weatherServiceProvider = Provider<HkoWeatherService>((ref) {
  return HkoWeatherService();
});

final busServiceProvider = Provider<KmbBusService>((ref) {
  return KmbBusService();
});

final currentWeatherProvider = FutureProvider<CurrentWeather>((ref) async {
  final service = ref.watch(weatherServiceProvider);
  return service.getCurrentWeather(lang: 'tc');
});

final weatherWarningsProvider = FutureProvider<List<WeatherWarning>>((
  ref,
) async {
  final service = ref.watch(weatherServiceProvider);
  return service.getWarnings(lang: 'tc');
});

final nineDayForecastProvider = FutureProvider<NineDayForecast>((ref) async {
  final service = ref.watch(weatherServiceProvider);
  return service.getNineDayForecast(lang: 'tc');
});

final nearestBusStopProvider = FutureProvider<(BusStop, double)>((ref) async {
  final service = ref.watch(busServiceProvider);
  // Default to Tsim Sha Tsui area if no location available
  return service.findNearestStop(22.2976, 114.1722);
});

final busEtaProvider = FutureProvider.family<List<BusEta>, String>((
  ref,
  stopId,
) async {
  final service = ref.watch(busServiceProvider);
  return service.getStopEta(stopId);
});
