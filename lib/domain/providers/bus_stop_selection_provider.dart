/// Bus Stop Selection Provider — user-selected stop + search history
/// 參考: prd.md Section 5.2
library;

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metrolife/data/models/bus_models.dart';
import 'package:metrolife/domain/providers/weather_bus_provider.dart';

/// Selected bus stop (user can change this)
final selectedBusStopProvider =
    NotifierProvider<SelectedBusStopNotifier, SelectedBusStop?>(
      SelectedBusStopNotifier.new,
    );

class SelectedBusStop {
  final String stopId;
  final String nameTc;
  final String nameEn;
  final double lat;
  final double long;
  final double distanceMeters;

  const SelectedBusStop({
    required this.stopId,
    required this.nameTc,
    required this.nameEn,
    required this.lat,
    required this.long,
    this.distanceMeters = 0,
  });
}

class SelectedBusStopNotifier extends Notifier<SelectedBusStop?> {
  @override
  SelectedBusStop? build() => null;

  void select(SelectedBusStop stop) {
    state = stop;
    _saveToHistory(stop);
  }

  Future<void> _saveToHistory(SelectedBusStop stop) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('bus_stop_history') ?? [];

    // Remove duplicate if exists
    historyJson.removeWhere((jsonStr) {
      final m = jsonDecode(jsonStr) as Map<String, dynamic>;
      return m['stopId'] == stop.stopId;
    });

    // Add to front
    historyJson.insert(
      0,
      jsonEncode({
        'stopId': stop.stopId,
        'nameTc': stop.nameTc,
        'nameEn': stop.nameEn,
        'lat': stop.lat,
        'long': stop.long,
      }),
    );

    // Keep only last 8
    if (historyJson.length > 8) {
      historyJson.removeRange(8, historyJson.length);
    }

    await prefs.setStringList('bus_stop_history', historyJson);
  }
}

/// Search history (last 8 searched stops)
final busStopHistoryProvider =
    NotifierProvider<BusStopHistoryNotifier, List<SelectedBusStop>>(
      BusStopHistoryNotifier.new,
    );

class BusStopHistoryNotifier extends Notifier<List<SelectedBusStop>> {
  @override
  List<SelectedBusStop> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('bus_stop_history') ?? [];
    state = historyJson.map((jsonStr) {
      final m = jsonDecode(jsonStr) as Map<String, dynamic>;
      return SelectedBusStop(
        stopId: m['stopId'] ?? '',
        nameTc: m['nameTc'] ?? '',
        nameEn: m['nameEn'] ?? '',
        lat: (m['lat'] ?? 0).toDouble(),
        long: (m['long'] ?? 0).toDouble(),
      );
    }).toList();
  }
}

/// Get 3 nearest stops from current GPS
final nearest3StopsProvider = FutureProvider<List<(BusStop, double)>>((
  ref,
) async {
  final busService = ref.read(busServiceProvider);
  final allStops = await busService.getAllStops();

  // Try GPS
  double userLat = 22.2976;
  double userLong = 114.1722;
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission != LocationPermission.denied &&
          permission != LocationPermission.deniedForever) {
        final pos = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 10),
          ),
        );
        userLat = pos.latitude;
        userLong = pos.longitude;
      }
    }
  } catch (_) {}

  // Calculate distances and sort
  final stopsWithDist = allStops.map((stop) {
    final dist = _haversine(userLat, userLong, stop.lat, stop.long);
    return (stop, dist);
  }).toList();

  stopsWithDist.sort((a, b) => a.$2.compareTo(b.$2));
  return stopsWithDist.take(3).toList();
});

double _haversine(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371000.0;
  final dLat = _degToRad(lat2 - lat1);
  final dLon = _degToRad(lon2 - lon1);
  final a =
      _sin(dLat / 2) * _sin(dLat / 2) +
      _cos(_degToRad(lat1)) *
          _cos(_degToRad(lat2)) *
          _sin(dLon / 2) *
          _sin(dLon / 2);
  return r * 2 * _asin(_sqrt(a));
}

double _degToRad(double d) => d * 3.14159265358979 / 180;
double _sin(double x) {
  double r = 0, t = x;
  for (var i = 1; i <= 15; i++) {
    r += t;
    t *= -x * x / ((2 * i) * (2 * i + 1));
  }
  return r;
}

double _cos(double x) => _sin(x + 1.5707963267949);
double _asin(double x) => x + x * x * x / 6 + 3 * x * x * x * x * x / 40;
double _sqrt(double x) {
  double g = x / 2;
  for (var i = 0; i < 20; i++) {
    g = (g + x / g) / 2;
  }
  return g;
}
