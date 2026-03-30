// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    _CurrentWeather(
      icon: json['icon'] as String? ?? '',
      iconNum: json['iconNum'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      descTc: json['descTc'] as String? ?? '',
      temp: (json['temp'] as num?)?.toInt() ?? 0,
      tempFeelsLike: (json['tempFeelsLike'] as num?)?.toInt() ?? 0,
      humi: (json['humi'] as num?)?.toInt() ?? 0,
      rain: json['rain'] as String? ?? '',
      minTempFromPastMax: json['minTempFromPastMax'] as String? ?? '',
      uvindex: json['uvindex'] as String? ?? '',
      updateTime: json['updateTime'] as String? ?? '',
      tip: json['tip'] as String? ?? '',
    );

Map<String, dynamic> _$CurrentWeatherToJson(_CurrentWeather instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'iconNum': instance.iconNum,
      'desc': instance.desc,
      'descTc': instance.descTc,
      'temp': instance.temp,
      'tempFeelsLike': instance.tempFeelsLike,
      'humi': instance.humi,
      'rain': instance.rain,
      'minTempFromPastMax': instance.minTempFromPastMax,
      'uvindex': instance.uvindex,
      'updateTime': instance.updateTime,
      'tip': instance.tip,
    };

_NineDayForecast _$NineDayForecastFromJson(Map<String, dynamic> json) =>
    _NineDayForecast(
      generalSituation: json['generalSituation'] as String? ?? '',
      weatherForecast:
          (json['weatherForecast'] as List<dynamic>?)
              ?.map((e) => ForecastDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      seaTemp:
          (json['seaTemp'] as List<dynamic>?)
              ?.map((e) => SeaSoilTemp.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      soilTemp:
          (json['soilTemp'] as List<dynamic>?)
              ?.map((e) => SeaSoilTemp.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NineDayForecastToJson(_NineDayForecast instance) =>
    <String, dynamic>{
      'generalSituation': instance.generalSituation,
      'weatherForecast': instance.weatherForecast,
      'seaTemp': instance.seaTemp,
      'soilTemp': instance.soilTemp,
    };

_ForecastDay _$ForecastDayFromJson(Map<String, dynamic> json) => _ForecastDay(
  forecastDate: json['forecastDate'] as String? ?? '',
  week: json['week'] as String? ?? '',
  forecastWind: json['forecastWind'] as String? ?? '',
  forecastWeather: json['forecastWeather'] as String? ?? '',
  forecastMaxtemp: (json['forecastMaxtemp'] as num?)?.toInt() ?? 0,
  forecastMintemp: (json['forecastMintemp'] as num?)?.toInt() ?? 0,
  forecastMaxrh: (json['forecastMaxrh'] as num?)?.toInt() ?? 0,
  forecastMinrh: (json['forecastMinrh'] as num?)?.toInt() ?? 0,
  forecastIcon: json['forecastIcon'] as String? ?? '',
  PSR: json['PSR'] as String? ?? '',
);

Map<String, dynamic> _$ForecastDayToJson(_ForecastDay instance) =>
    <String, dynamic>{
      'forecastDate': instance.forecastDate,
      'week': instance.week,
      'forecastWind': instance.forecastWind,
      'forecastWeather': instance.forecastWeather,
      'forecastMaxtemp': instance.forecastMaxtemp,
      'forecastMintemp': instance.forecastMintemp,
      'forecastMaxrh': instance.forecastMaxrh,
      'forecastMinrh': instance.forecastMinrh,
      'forecastIcon': instance.forecastIcon,
      'PSR': instance.PSR,
    };

_SeaSoilTemp _$SeaSoilTempFromJson(Map<String, dynamic> json) => _SeaSoilTemp(
  place: json['place'] as String? ?? '',
  value: json['value'] as String? ?? '',
  unit: json['unit'] as String? ?? '',
  recordTime: json['recordTime'] as String? ?? '',
);

Map<String, dynamic> _$SeaSoilTempToJson(_SeaSoilTemp instance) =>
    <String, dynamic>{
      'place': instance.place,
      'value': instance.value,
      'unit': instance.unit,
      'recordTime': instance.recordTime,
    };

_WeatherWarning _$WeatherWarningFromJson(Map<String, dynamic> json) =>
    _WeatherWarning(
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      actionCode: json['actionCode'] as String? ?? '',
      issueTime: json['issueTime'] as String? ?? '',
      expireTime: json['expireTime'] as String? ?? '',
      updateTime: json['updateTime'] as String? ?? '',
      contents: json['contents'] as String? ?? '',
    );

Map<String, dynamic> _$WeatherWarningToJson(_WeatherWarning instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'actionCode': instance.actionCode,
      'issueTime': instance.issueTime,
      'expireTime': instance.expireTime,
      'updateTime': instance.updateTime,
      'contents': instance.contents,
    };
