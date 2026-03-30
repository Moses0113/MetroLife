/// Weather & Bus Riverpod Providers
/// 參考: prd.md Section 3.1, 5.1, 5.2

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
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

/// Get current GPS position
Future<Position?> _getCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return null;

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return null;
  }
  if (permission == LocationPermission.deniedForever) return null;

  return Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 10),
    ),
  );
}

/// Find nearest bus stop using GPS
final nearestBusStopProvider = FutureProvider<(BusStop, double)>((ref) async {
  final service = ref.watch(busServiceProvider);

  // Try GPS first
  try {
    final position = await _getCurrentPosition();
    if (position != null) {
      return service.findNearestStop(position.latitude, position.longitude);
    }
  } catch (_) {}

  // Fallback: Tsim Sha Tsui
  return service.findNearestStop(22.2976, 114.1722);
});

final busEtaProvider = FutureProvider.family<List<BusEta>, String>((
  ref,
  stopId,
) async {
  final service = ref.watch(busServiceProvider);
  return service.getStopEta(stopId);
});

/// All KMB routes (cached)
final allRoutesProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final service = ref.watch(busServiceProvider);
  print('[Provider] allRoutesProvider: starting fetch');
  try {
    final routes = await service.getAllRoutes();
    print('[Provider] allRoutesProvider: got ${routes.length} routes');
    return routes;
  } catch (e, st) {
    print('[Provider] allRoutesProvider ERROR: $e\n$st');
    rethrow;
  }
});
