// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusStop _$BusStopFromJson(Map<String, dynamic> json) => _BusStop(
  stop: json['stop'] as String? ?? '',
  nameEn: json['nameEn'] as String? ?? '',
  nameTc: json['nameTc'] as String? ?? '',
  lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
  long: (json['long'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$BusStopToJson(_BusStop instance) => <String, dynamic>{
  'stop': instance.stop,
  'nameEn': instance.nameEn,
  'nameTc': instance.nameTc,
  'lat': instance.lat,
  'long': instance.long,
};

_BusEta _$BusEtaFromJson(Map<String, dynamic> json) => _BusEta(
  stop: json['stop'] as String? ?? '',
  route: json['route'] as String? ?? '',
  dir: json['dir'] as String? ?? '',
  serviceType: (json['serviceType'] as num?)?.toInt() ?? 1,
  etaSeq: (json['etaSeq'] as num?)?.toInt() ?? 1,
  eta: json['eta'] as String? ?? '',
  rmkTc: json['rmkTc'] as String? ?? '',
  rmkEn: json['rmkEn'] as String? ?? '',
);

Map<String, dynamic> _$BusEtaToJson(_BusEta instance) => <String, dynamic>{
  'stop': instance.stop,
  'route': instance.route,
  'dir': instance.dir,
  'serviceType': instance.serviceType,
  'etaSeq': instance.etaSeq,
  'eta': instance.eta,
  'rmkTc': instance.rmkTc,
  'rmkEn': instance.rmkEn,
};
