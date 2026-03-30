/// HKO Weather Service
/// 參考: prd.md Section 5.1

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:metrolife/core/constants/api_constants.dart';
import 'package:metrolife/data/models/weather_models.dart';

class HkoWeatherService {
  final Dio _dio;

  HkoWeatherService({Dio? dio}) : _dio = dio ?? Dio();

  /// 獲取實時天氣 (FLW + rhrread for temp/humidity)
  Future<CurrentWeather> getCurrentWeather({String lang = 'tc'}) async {
    // Fetch both FLW (forecast) and rhrread (real-time temp/humidity)
    final responses = await Future.wait([
      _dio.get(
        ApiConstants.hkoWeatherUrl,
        queryParameters: {'dataType': 'flw', 'lang': lang},
      ),
      _dio.get(
        ApiConstants.hkoWeatherUrl,
        queryParameters: {'dataType': 'rhrread', 'lang': lang},
      ),
    ]);

    final flwData = responses[0].data as Map<String, dynamic>;
    final rhrData = responses[1].data as Map<String, dynamic>;

    // Extract description from FLW
    String desc = '';
    if (lang == 'tc') {
      desc = flwData['forecastDesc'] ?? '';
      // Get first sentence for short display
      if (desc.contains('。')) {
        desc = desc.split('。').first;
      }
    } else {
      desc = flwData['forecastDesc'] ?? '';
      if (desc.contains('.')) {
        desc = desc.split('.').first;
      }
    }

    // Extract icon from rhrread
    final iconList = rhrData['icon'] as List?;
    final icon = iconList != null && iconList.isNotEmpty
        ? iconList.first.toString()
        : '';

    // Extract temperature from rhrread (Hong Kong Observatory station)
    int temp = 0;
    final tempData = rhrData['temperature'] as Map<String, dynamic>?;
    if (tempData != null && tempData['data'] is List) {
      final tempList = tempData['data'] as List;
      // Find "香港天文台" or use first available
      final obsStation = tempList.firstWhere(
        (t) => t['place'] == '香港天文台' || t['place'] == 'Hong Kong Observatory',
        orElse: () => tempList.first,
      );
      temp = obsStation['value'] ?? 0;
    }

    // Extract humidity from rhrread
    int humi = 0;
    final humiData = rhrData['humidity'] as Map<String, dynamic>?;
    if (humiData != null && humiData['data'] is List) {
      final humiList = humiData['data'] as List;
      if (humiList.isNotEmpty) {
        humi = humiList.first['value'] ?? 0;
      }
    }

    return CurrentWeather(
      icon: icon,
      iconNum: icon,
      desc: desc,
      descTc: desc,
      temp: temp,
      tempFeelsLike: 0,
      humi: humi,
      rain: '0',
      updateTime: flwData['updateTime'] ?? '',
    );
  }

  /// 獲取9天天氣預報 (FND)
  Future<NineDayForecast> getNineDayForecast({String lang = 'tc'}) async {
    final response = await _dio.get(
      ApiConstants.hkoWeatherUrl,
      queryParameters: {'dataType': 'fnd', 'lang': lang},
    );
    final data = response.data as Map<String, dynamic>;
    final forecastList = (data['weatherForecast'] as List?) ?? [];

    return NineDayForecast(
      generalSituation: data['generalSituation'] ?? '',
      weatherForecast: forecastList.map((e) {
        final day = e as Map<String, dynamic>;
        return ForecastDay(
          forecastDate: day['forecastDate'] ?? '',
          week: day['week'] ?? '',
          forecastWind: day['forecastWind'] ?? '',
          forecastWeather: day['forecastWeather'] ?? '',
          forecastMaxtemp: _parseTemp(day, 'forecastMaxtemp'),
          forecastMintemp: _parseTemp(day, 'forecastMintemp'),
          forecastMaxrh: _parseRh(day, 'forecastMaxrh'),
          forecastMinrh: _parseRh(day, 'forecastMinrh'),
          forecastIcon: day['ForecastIcon']?.toString() ?? '',
          PSR: day['PSR'] ?? '',
        );
      }).toList(),
      seaTemp: _parseSeaSoilTemp(data['seaTemp']),
      soilTemp: _parseSeaSoilTemp(data['soilTemp']),
    );
  }

  /// 獲取天氣警告
  Future<List<WeatherWarning>> getWarnings({String lang = 'tc'}) async {
    final response = await _dio.get(
      ApiConstants.hkoWeatherUrl,
      queryParameters: {'dataType': 'warningInfo', 'lang': lang},
    );
    final data = response.data as Map<String, dynamic>;
    final details = data['details'] as List?;
    if (details == null || details.isEmpty) return [];

    return details.map((e) {
      final w = e as Map<String, dynamic>;
      return WeatherWarning(
        name: w['name'] ?? '',
        code: w['code'] ?? '',
        actionCode: w['actionCode'] ?? '',
        issueTime: w['issueTime'] ?? '',
        expireTime: w['expireTime'] ?? '',
        updateTime: w['updateTime'] ?? '',
        contents: (w['contents'] as List?)?.isNotEmpty == true
            ? (w['contents'][0] as Map<String, dynamic>)['text'] ?? ''
            : '',
      );
    }).toList();
  }

  int _parseTemp(Map<String, dynamic> json, String key) {
    final val = json[key];
    if (val is Map) return (val['value'] ?? 0) as int;
    if (val is int) return val;
    if (val is num) return val.toInt();
    return 0;
  }

  int _parseRh(Map<String, dynamic> json, String key) {
    final val = json[key];
    if (val is Map) return (val['value'] ?? 0) as int;
    if (val is int) return val;
    if (val is num) return val.toInt();
    return 0;
  }

  List<SeaSoilTemp> _parseSeaSoilTemp(dynamic data) {
    if (data == null) return [];
    if (data is List) {
      return data.map((e) {
        final m = e as Map<String, dynamic>;
        return SeaSoilTemp(
          place: m['place'] ?? '',
          value: m['value']?.toString() ?? '',
          unit: m['unit'] ?? '',
          recordTime: m['recordTime'] ?? '',
        );
      }).toList();
    }
    if (data is Map) {
      return [
        SeaSoilTemp(
          place: data['place'] ?? '',
          value: data['value']?.toString() ?? '',
          unit: data['unit'] ?? '',
          recordTime: data['recordTime'] ?? '',
        ),
      ];
    }
    return [];
  }
}
