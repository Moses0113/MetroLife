/// KMB Bus Freezed Models (Freezed 3.x syntax)
/// 參考: prd.md Section 5.2

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_models.freezed.dart';
part 'bus_models.g.dart';

@freezed
abstract class BusStop with _$BusStop {
  const factory BusStop({
    @Default('') String stop,
    @Default('') String nameEn,
    @Default('') String nameTc,
    @Default(0.0) double lat,
    @Default(0.0) double long,
  }) = _BusStop;

  factory BusStop.fromJson(Map<String, dynamic> json) =>
      _$BusStopFromJson(json);
}

@freezed
abstract class BusEta with _$BusEta {
  const factory BusEta({
    @Default('') String stop,
    @Default('') String route,
    @Default('') String dir,
    @Default(1) int serviceType,
    @Default(1) int etaSeq,
    @Default('') String eta,
    @Default('') String rmkTc,
    @Default('') String rmkEn,
  }) = _BusEta;

  factory BusEta.fromJson(Map<String, dynamic> json) => _$BusEtaFromJson(json);
}
