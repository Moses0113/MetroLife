/// KMB Bus Service
/// 參考: prd.md Section 5.2

import 'package:dio/dio.dart';
import 'package:metrolife/core/constants/api_constants.dart';
import 'package:metrolife/data/models/bus_models.dart';

class KmbBusService {
  final Dio _dio;
  List<BusStop>? _cachedStops;

  KmbBusService({Dio? dio}) : _dio = dio ?? Dio();

  /// 獲取所有巴士站 (帶緩存)
  Future<List<BusStop>> getAllStops() async {
    if (_cachedStops != null) return _cachedStops!;

    final response = await _dio.get(ApiConstants.kmbAllStops);
    final data = response.data as Map<String, dynamic>;
    final stopsList = (data['data'] as List?) ?? [];

    _cachedStops = stopsList.map((e) {
      final s = e as Map<String, dynamic>;
      return BusStop(
        stop: s['stop'] ?? '',
        nameEn: s['name_en'] ?? '',
        nameTc: s['name_tc'] ?? '',
        lat: double.tryParse(s['lat']?.toString() ?? '') ?? 0,
        long: double.tryParse(s['long']?.toString() ?? '') ?? 0,
      );
    }).toList();

    return _cachedStops!;
  }

  /// 獲取指定站點到站時間
  Future<List<BusEta>> getStopEta(String stopId) async {
    final response = await _dio.get('${ApiConstants.kmbStopEta}/$stopId');
    final data = response.data as Map<String, dynamic>;
    final etaList = (data['data'] as List?) ?? [];

    final now = DateTime.now();
    return etaList
        .map((e) {
          final m = e as Map<String, dynamic>;
          return BusEta(
            stop: m['stop'] ?? '',
            route: m['route'] ?? '',
            dir: m['dir'] ?? '',
            serviceType: m['service_type'] ?? 1,
            etaSeq: m['eta_seq'] ?? 1,
            eta: m['eta'] ?? '',
            rmkTc: m['rmk_tc'] ?? '',
            rmkEn: m['rmk_en'] ?? '',
          );
        })
        .where((eta) {
          if (eta.eta.isEmpty) return false;
          try {
            final etaTime = DateTime.parse(eta.eta);
            return etaTime.isAfter(now);
          } catch (_) {
            return true;
          }
        })
        .toList()
      ..sort((a, b) {
        try {
          return DateTime.parse(a.eta).compareTo(DateTime.parse(b.eta));
        } catch (_) {
          return 0;
        }
      });
  }

  /// 查找最近巴士站
  Future<(BusStop, double)> findNearestStop(
    double userLat,
    double userLon,
  ) async {
    final stops = await getAllStops();
    double minDist = double.infinity;
    BusStop nearest = stops.first;

    for (final stop in stops) {
      final dist = _haversine(userLat, userLon, stop.lat, stop.long);
      if (dist < minDist) {
        minDist = dist;
        nearest = stop;
      }
    }

    return (nearest, minDist);
  }

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
}
