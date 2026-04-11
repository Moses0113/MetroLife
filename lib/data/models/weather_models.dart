/// HKO Weather Freezed Models (Freezed 3.x syntax)
/// 參考: prd.md Section 5.1
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_models.freezed.dart';
part 'weather_models.g.dart';

@freezed
abstract class CurrentWeather with _$CurrentWeather {
  const factory CurrentWeather({
    @Default('') String icon,
    @Default('') String iconNum,
    @Default('') String desc,
    @Default('') String descTc,
    @Default(0) int temp,
    @Default(0) int tempFeelsLike,
    @Default(0) int humi,
    @Default('') String rain,
    @Default('') String minTempFromPastMax,
    @Default('') String uvindex,
    @Default('') String updateTime,
    @Default('') String tip,
  }) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
}

@freezed
abstract class NineDayForecast with _$NineDayForecast {
  const factory NineDayForecast({
    @Default('') String generalSituation,
    @Default([]) List<ForecastDay> weatherForecast,
    @Default([]) List<SeaSoilTemp> seaTemp,
    @Default([]) List<SeaSoilTemp> soilTemp,
  }) = _NineDayForecast;

  factory NineDayForecast.fromJson(Map<String, dynamic> json) =>
      _$NineDayForecastFromJson(json);
}

@freezed
abstract class ForecastDay with _$ForecastDay {
  const factory ForecastDay({
    @Default('') String forecastDate,
    @Default('') String week,
    @Default('') String forecastWind,
    @Default('') String forecastWeather,
    @Default(0) int forecastMaxtemp,
    @Default(0) int forecastMintemp,
    @Default(0) int forecastMaxrh,
    @Default(0) int forecastMinrh,
    @Default('') String forecastIcon,
    @Default('') String PSR,
  }) = _ForecastDay;

  factory ForecastDay.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayFromJson(json);
}

@freezed
abstract class SeaSoilTemp with _$SeaSoilTemp {
  const factory SeaSoilTemp({
    @Default('') String place,
    @Default('') String value,
    @Default('') String unit,
    @Default('') String recordTime,
  }) = _SeaSoilTemp;

  factory SeaSoilTemp.fromJson(Map<String, dynamic> json) =>
      _$SeaSoilTempFromJson(json);
}

@freezed
abstract class WeatherWarning with _$WeatherWarning {
  const factory WeatherWarning({
    @Default('') String name,
    @Default('') String code,
    @Default('') String actionCode,
    @Default('') String issueTime,
    @Default('') String expireTime,
    @Default('') String updateTime,
    @Default('') String contents,
  }) = _WeatherWarning;

  factory WeatherWarning.fromJson(Map<String, dynamic> json) =>
      _$WeatherWarningFromJson(json);
}
