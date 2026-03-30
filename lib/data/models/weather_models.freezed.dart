// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentWeather {

 String get icon; String get iconNum; String get desc; String get descTc; int get temp; int get tempFeelsLike; int get humi; String get rain; String get minTempFromPastMax; String get uvindex; String get updateTime; String get tip;
/// Create a copy of CurrentWeather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentWeatherCopyWith<CurrentWeather> get copyWith => _$CurrentWeatherCopyWithImpl<CurrentWeather>(this as CurrentWeather, _$identity);

  /// Serializes this CurrentWeather to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentWeather&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconNum, iconNum) || other.iconNum == iconNum)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.descTc, descTc) || other.descTc == descTc)&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.tempFeelsLike, tempFeelsLike) || other.tempFeelsLike == tempFeelsLike)&&(identical(other.humi, humi) || other.humi == humi)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.minTempFromPastMax, minTempFromPastMax) || other.minTempFromPastMax == minTempFromPastMax)&&(identical(other.uvindex, uvindex) || other.uvindex == uvindex)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime)&&(identical(other.tip, tip) || other.tip == tip));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,icon,iconNum,desc,descTc,temp,tempFeelsLike,humi,rain,minTempFromPastMax,uvindex,updateTime,tip);

@override
String toString() {
  return 'CurrentWeather(icon: $icon, iconNum: $iconNum, desc: $desc, descTc: $descTc, temp: $temp, tempFeelsLike: $tempFeelsLike, humi: $humi, rain: $rain, minTempFromPastMax: $minTempFromPastMax, uvindex: $uvindex, updateTime: $updateTime, tip: $tip)';
}


}

/// @nodoc
abstract mixin class $CurrentWeatherCopyWith<$Res>  {
  factory $CurrentWeatherCopyWith(CurrentWeather value, $Res Function(CurrentWeather) _then) = _$CurrentWeatherCopyWithImpl;
@useResult
$Res call({
 String icon, String iconNum, String desc, String descTc, int temp, int tempFeelsLike, int humi, String rain, String minTempFromPastMax, String uvindex, String updateTime, String tip
});




}
/// @nodoc
class _$CurrentWeatherCopyWithImpl<$Res>
    implements $CurrentWeatherCopyWith<$Res> {
  _$CurrentWeatherCopyWithImpl(this._self, this._then);

  final CurrentWeather _self;
  final $Res Function(CurrentWeather) _then;

/// Create a copy of CurrentWeather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? icon = null,Object? iconNum = null,Object? desc = null,Object? descTc = null,Object? temp = null,Object? tempFeelsLike = null,Object? humi = null,Object? rain = null,Object? minTempFromPastMax = null,Object? uvindex = null,Object? updateTime = null,Object? tip = null,}) {
  return _then(_self.copyWith(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,iconNum: null == iconNum ? _self.iconNum : iconNum // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,descTc: null == descTc ? _self.descTc : descTc // ignore: cast_nullable_to_non_nullable
as String,temp: null == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as int,tempFeelsLike: null == tempFeelsLike ? _self.tempFeelsLike : tempFeelsLike // ignore: cast_nullable_to_non_nullable
as int,humi: null == humi ? _self.humi : humi // ignore: cast_nullable_to_non_nullable
as int,rain: null == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as String,minTempFromPastMax: null == minTempFromPastMax ? _self.minTempFromPastMax : minTempFromPastMax // ignore: cast_nullable_to_non_nullable
as String,uvindex: null == uvindex ? _self.uvindex : uvindex // ignore: cast_nullable_to_non_nullable
as String,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as String,tip: null == tip ? _self.tip : tip // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentWeather].
extension CurrentWeatherPatterns on CurrentWeather {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentWeather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentWeather() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentWeather value)  $default,){
final _that = this;
switch (_that) {
case _CurrentWeather():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentWeather value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentWeather() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String icon,  String iconNum,  String desc,  String descTc,  int temp,  int tempFeelsLike,  int humi,  String rain,  String minTempFromPastMax,  String uvindex,  String updateTime,  String tip)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentWeather() when $default != null:
return $default(_that.icon,_that.iconNum,_that.desc,_that.descTc,_that.temp,_that.tempFeelsLike,_that.humi,_that.rain,_that.minTempFromPastMax,_that.uvindex,_that.updateTime,_that.tip);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String icon,  String iconNum,  String desc,  String descTc,  int temp,  int tempFeelsLike,  int humi,  String rain,  String minTempFromPastMax,  String uvindex,  String updateTime,  String tip)  $default,) {final _that = this;
switch (_that) {
case _CurrentWeather():
return $default(_that.icon,_that.iconNum,_that.desc,_that.descTc,_that.temp,_that.tempFeelsLike,_that.humi,_that.rain,_that.minTempFromPastMax,_that.uvindex,_that.updateTime,_that.tip);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String icon,  String iconNum,  String desc,  String descTc,  int temp,  int tempFeelsLike,  int humi,  String rain,  String minTempFromPastMax,  String uvindex,  String updateTime,  String tip)?  $default,) {final _that = this;
switch (_that) {
case _CurrentWeather() when $default != null:
return $default(_that.icon,_that.iconNum,_that.desc,_that.descTc,_that.temp,_that.tempFeelsLike,_that.humi,_that.rain,_that.minTempFromPastMax,_that.uvindex,_that.updateTime,_that.tip);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentWeather implements CurrentWeather {
  const _CurrentWeather({this.icon = '', this.iconNum = '', this.desc = '', this.descTc = '', this.temp = 0, this.tempFeelsLike = 0, this.humi = 0, this.rain = '', this.minTempFromPastMax = '', this.uvindex = '', this.updateTime = '', this.tip = ''});
  factory _CurrentWeather.fromJson(Map<String, dynamic> json) => _$CurrentWeatherFromJson(json);

@override@JsonKey() final  String icon;
@override@JsonKey() final  String iconNum;
@override@JsonKey() final  String desc;
@override@JsonKey() final  String descTc;
@override@JsonKey() final  int temp;
@override@JsonKey() final  int tempFeelsLike;
@override@JsonKey() final  int humi;
@override@JsonKey() final  String rain;
@override@JsonKey() final  String minTempFromPastMax;
@override@JsonKey() final  String uvindex;
@override@JsonKey() final  String updateTime;
@override@JsonKey() final  String tip;

/// Create a copy of CurrentWeather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentWeatherCopyWith<_CurrentWeather> get copyWith => __$CurrentWeatherCopyWithImpl<_CurrentWeather>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentWeatherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentWeather&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconNum, iconNum) || other.iconNum == iconNum)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.descTc, descTc) || other.descTc == descTc)&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.tempFeelsLike, tempFeelsLike) || other.tempFeelsLike == tempFeelsLike)&&(identical(other.humi, humi) || other.humi == humi)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.minTempFromPastMax, minTempFromPastMax) || other.minTempFromPastMax == minTempFromPastMax)&&(identical(other.uvindex, uvindex) || other.uvindex == uvindex)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime)&&(identical(other.tip, tip) || other.tip == tip));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,icon,iconNum,desc,descTc,temp,tempFeelsLike,humi,rain,minTempFromPastMax,uvindex,updateTime,tip);

@override
String toString() {
  return 'CurrentWeather(icon: $icon, iconNum: $iconNum, desc: $desc, descTc: $descTc, temp: $temp, tempFeelsLike: $tempFeelsLike, humi: $humi, rain: $rain, minTempFromPastMax: $minTempFromPastMax, uvindex: $uvindex, updateTime: $updateTime, tip: $tip)';
}


}

/// @nodoc
abstract mixin class _$CurrentWeatherCopyWith<$Res> implements $CurrentWeatherCopyWith<$Res> {
  factory _$CurrentWeatherCopyWith(_CurrentWeather value, $Res Function(_CurrentWeather) _then) = __$CurrentWeatherCopyWithImpl;
@override @useResult
$Res call({
 String icon, String iconNum, String desc, String descTc, int temp, int tempFeelsLike, int humi, String rain, String minTempFromPastMax, String uvindex, String updateTime, String tip
});




}
/// @nodoc
class __$CurrentWeatherCopyWithImpl<$Res>
    implements _$CurrentWeatherCopyWith<$Res> {
  __$CurrentWeatherCopyWithImpl(this._self, this._then);

  final _CurrentWeather _self;
  final $Res Function(_CurrentWeather) _then;

/// Create a copy of CurrentWeather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? icon = null,Object? iconNum = null,Object? desc = null,Object? descTc = null,Object? temp = null,Object? tempFeelsLike = null,Object? humi = null,Object? rain = null,Object? minTempFromPastMax = null,Object? uvindex = null,Object? updateTime = null,Object? tip = null,}) {
  return _then(_CurrentWeather(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,iconNum: null == iconNum ? _self.iconNum : iconNum // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,descTc: null == descTc ? _self.descTc : descTc // ignore: cast_nullable_to_non_nullable
as String,temp: null == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as int,tempFeelsLike: null == tempFeelsLike ? _self.tempFeelsLike : tempFeelsLike // ignore: cast_nullable_to_non_nullable
as int,humi: null == humi ? _self.humi : humi // ignore: cast_nullable_to_non_nullable
as int,rain: null == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as String,minTempFromPastMax: null == minTempFromPastMax ? _self.minTempFromPastMax : minTempFromPastMax // ignore: cast_nullable_to_non_nullable
as String,uvindex: null == uvindex ? _self.uvindex : uvindex // ignore: cast_nullable_to_non_nullable
as String,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as String,tip: null == tip ? _self.tip : tip // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NineDayForecast {

 String get generalSituation; List<ForecastDay> get weatherForecast; List<SeaSoilTemp> get seaTemp; List<SeaSoilTemp> get soilTemp;
/// Create a copy of NineDayForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NineDayForecastCopyWith<NineDayForecast> get copyWith => _$NineDayForecastCopyWithImpl<NineDayForecast>(this as NineDayForecast, _$identity);

  /// Serializes this NineDayForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NineDayForecast&&(identical(other.generalSituation, generalSituation) || other.generalSituation == generalSituation)&&const DeepCollectionEquality().equals(other.weatherForecast, weatherForecast)&&const DeepCollectionEquality().equals(other.seaTemp, seaTemp)&&const DeepCollectionEquality().equals(other.soilTemp, soilTemp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,generalSituation,const DeepCollectionEquality().hash(weatherForecast),const DeepCollectionEquality().hash(seaTemp),const DeepCollectionEquality().hash(soilTemp));

@override
String toString() {
  return 'NineDayForecast(generalSituation: $generalSituation, weatherForecast: $weatherForecast, seaTemp: $seaTemp, soilTemp: $soilTemp)';
}


}

/// @nodoc
abstract mixin class $NineDayForecastCopyWith<$Res>  {
  factory $NineDayForecastCopyWith(NineDayForecast value, $Res Function(NineDayForecast) _then) = _$NineDayForecastCopyWithImpl;
@useResult
$Res call({
 String generalSituation, List<ForecastDay> weatherForecast, List<SeaSoilTemp> seaTemp, List<SeaSoilTemp> soilTemp
});




}
/// @nodoc
class _$NineDayForecastCopyWithImpl<$Res>
    implements $NineDayForecastCopyWith<$Res> {
  _$NineDayForecastCopyWithImpl(this._self, this._then);

  final NineDayForecast _self;
  final $Res Function(NineDayForecast) _then;

/// Create a copy of NineDayForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? generalSituation = null,Object? weatherForecast = null,Object? seaTemp = null,Object? soilTemp = null,}) {
  return _then(_self.copyWith(
generalSituation: null == generalSituation ? _self.generalSituation : generalSituation // ignore: cast_nullable_to_non_nullable
as String,weatherForecast: null == weatherForecast ? _self.weatherForecast : weatherForecast // ignore: cast_nullable_to_non_nullable
as List<ForecastDay>,seaTemp: null == seaTemp ? _self.seaTemp : seaTemp // ignore: cast_nullable_to_non_nullable
as List<SeaSoilTemp>,soilTemp: null == soilTemp ? _self.soilTemp : soilTemp // ignore: cast_nullable_to_non_nullable
as List<SeaSoilTemp>,
  ));
}

}


/// Adds pattern-matching-related methods to [NineDayForecast].
extension NineDayForecastPatterns on NineDayForecast {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NineDayForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NineDayForecast() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NineDayForecast value)  $default,){
final _that = this;
switch (_that) {
case _NineDayForecast():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NineDayForecast value)?  $default,){
final _that = this;
switch (_that) {
case _NineDayForecast() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String generalSituation,  List<ForecastDay> weatherForecast,  List<SeaSoilTemp> seaTemp,  List<SeaSoilTemp> soilTemp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NineDayForecast() when $default != null:
return $default(_that.generalSituation,_that.weatherForecast,_that.seaTemp,_that.soilTemp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String generalSituation,  List<ForecastDay> weatherForecast,  List<SeaSoilTemp> seaTemp,  List<SeaSoilTemp> soilTemp)  $default,) {final _that = this;
switch (_that) {
case _NineDayForecast():
return $default(_that.generalSituation,_that.weatherForecast,_that.seaTemp,_that.soilTemp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String generalSituation,  List<ForecastDay> weatherForecast,  List<SeaSoilTemp> seaTemp,  List<SeaSoilTemp> soilTemp)?  $default,) {final _that = this;
switch (_that) {
case _NineDayForecast() when $default != null:
return $default(_that.generalSituation,_that.weatherForecast,_that.seaTemp,_that.soilTemp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NineDayForecast implements NineDayForecast {
  const _NineDayForecast({this.generalSituation = '', final  List<ForecastDay> weatherForecast = const [], final  List<SeaSoilTemp> seaTemp = const [], final  List<SeaSoilTemp> soilTemp = const []}): _weatherForecast = weatherForecast,_seaTemp = seaTemp,_soilTemp = soilTemp;
  factory _NineDayForecast.fromJson(Map<String, dynamic> json) => _$NineDayForecastFromJson(json);

@override@JsonKey() final  String generalSituation;
 final  List<ForecastDay> _weatherForecast;
@override@JsonKey() List<ForecastDay> get weatherForecast {
  if (_weatherForecast is EqualUnmodifiableListView) return _weatherForecast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherForecast);
}

 final  List<SeaSoilTemp> _seaTemp;
@override@JsonKey() List<SeaSoilTemp> get seaTemp {
  if (_seaTemp is EqualUnmodifiableListView) return _seaTemp;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seaTemp);
}

 final  List<SeaSoilTemp> _soilTemp;
@override@JsonKey() List<SeaSoilTemp> get soilTemp {
  if (_soilTemp is EqualUnmodifiableListView) return _soilTemp;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_soilTemp);
}


/// Create a copy of NineDayForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NineDayForecastCopyWith<_NineDayForecast> get copyWith => __$NineDayForecastCopyWithImpl<_NineDayForecast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NineDayForecastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NineDayForecast&&(identical(other.generalSituation, generalSituation) || other.generalSituation == generalSituation)&&const DeepCollectionEquality().equals(other._weatherForecast, _weatherForecast)&&const DeepCollectionEquality().equals(other._seaTemp, _seaTemp)&&const DeepCollectionEquality().equals(other._soilTemp, _soilTemp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,generalSituation,const DeepCollectionEquality().hash(_weatherForecast),const DeepCollectionEquality().hash(_seaTemp),const DeepCollectionEquality().hash(_soilTemp));

@override
String toString() {
  return 'NineDayForecast(generalSituation: $generalSituation, weatherForecast: $weatherForecast, seaTemp: $seaTemp, soilTemp: $soilTemp)';
}


}

/// @nodoc
abstract mixin class _$NineDayForecastCopyWith<$Res> implements $NineDayForecastCopyWith<$Res> {
  factory _$NineDayForecastCopyWith(_NineDayForecast value, $Res Function(_NineDayForecast) _then) = __$NineDayForecastCopyWithImpl;
@override @useResult
$Res call({
 String generalSituation, List<ForecastDay> weatherForecast, List<SeaSoilTemp> seaTemp, List<SeaSoilTemp> soilTemp
});




}
/// @nodoc
class __$NineDayForecastCopyWithImpl<$Res>
    implements _$NineDayForecastCopyWith<$Res> {
  __$NineDayForecastCopyWithImpl(this._self, this._then);

  final _NineDayForecast _self;
  final $Res Function(_NineDayForecast) _then;

/// Create a copy of NineDayForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? generalSituation = null,Object? weatherForecast = null,Object? seaTemp = null,Object? soilTemp = null,}) {
  return _then(_NineDayForecast(
generalSituation: null == generalSituation ? _self.generalSituation : generalSituation // ignore: cast_nullable_to_non_nullable
as String,weatherForecast: null == weatherForecast ? _self._weatherForecast : weatherForecast // ignore: cast_nullable_to_non_nullable
as List<ForecastDay>,seaTemp: null == seaTemp ? _self._seaTemp : seaTemp // ignore: cast_nullable_to_non_nullable
as List<SeaSoilTemp>,soilTemp: null == soilTemp ? _self._soilTemp : soilTemp // ignore: cast_nullable_to_non_nullable
as List<SeaSoilTemp>,
  ));
}


}


/// @nodoc
mixin _$ForecastDay {

 String get forecastDate; String get week; String get forecastWind; String get forecastWeather; int get forecastMaxtemp; int get forecastMintemp; int get forecastMaxrh; int get forecastMinrh; String get forecastIcon; String get PSR;
/// Create a copy of ForecastDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForecastDayCopyWith<ForecastDay> get copyWith => _$ForecastDayCopyWithImpl<ForecastDay>(this as ForecastDay, _$identity);

  /// Serializes this ForecastDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForecastDay&&(identical(other.forecastDate, forecastDate) || other.forecastDate == forecastDate)&&(identical(other.week, week) || other.week == week)&&(identical(other.forecastWind, forecastWind) || other.forecastWind == forecastWind)&&(identical(other.forecastWeather, forecastWeather) || other.forecastWeather == forecastWeather)&&(identical(other.forecastMaxtemp, forecastMaxtemp) || other.forecastMaxtemp == forecastMaxtemp)&&(identical(other.forecastMintemp, forecastMintemp) || other.forecastMintemp == forecastMintemp)&&(identical(other.forecastMaxrh, forecastMaxrh) || other.forecastMaxrh == forecastMaxrh)&&(identical(other.forecastMinrh, forecastMinrh) || other.forecastMinrh == forecastMinrh)&&(identical(other.forecastIcon, forecastIcon) || other.forecastIcon == forecastIcon)&&(identical(other.PSR, PSR) || other.PSR == PSR));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forecastDate,week,forecastWind,forecastWeather,forecastMaxtemp,forecastMintemp,forecastMaxrh,forecastMinrh,forecastIcon,PSR);

@override
String toString() {
  return 'ForecastDay(forecastDate: $forecastDate, week: $week, forecastWind: $forecastWind, forecastWeather: $forecastWeather, forecastMaxtemp: $forecastMaxtemp, forecastMintemp: $forecastMintemp, forecastMaxrh: $forecastMaxrh, forecastMinrh: $forecastMinrh, forecastIcon: $forecastIcon, PSR: $PSR)';
}


}

/// @nodoc
abstract mixin class $ForecastDayCopyWith<$Res>  {
  factory $ForecastDayCopyWith(ForecastDay value, $Res Function(ForecastDay) _then) = _$ForecastDayCopyWithImpl;
@useResult
$Res call({
 String forecastDate, String week, String forecastWind, String forecastWeather, int forecastMaxtemp, int forecastMintemp, int forecastMaxrh, int forecastMinrh, String forecastIcon, String PSR
});




}
/// @nodoc
class _$ForecastDayCopyWithImpl<$Res>
    implements $ForecastDayCopyWith<$Res> {
  _$ForecastDayCopyWithImpl(this._self, this._then);

  final ForecastDay _self;
  final $Res Function(ForecastDay) _then;

/// Create a copy of ForecastDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forecastDate = null,Object? week = null,Object? forecastWind = null,Object? forecastWeather = null,Object? forecastMaxtemp = null,Object? forecastMintemp = null,Object? forecastMaxrh = null,Object? forecastMinrh = null,Object? forecastIcon = null,Object? PSR = null,}) {
  return _then(_self.copyWith(
forecastDate: null == forecastDate ? _self.forecastDate : forecastDate // ignore: cast_nullable_to_non_nullable
as String,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as String,forecastWind: null == forecastWind ? _self.forecastWind : forecastWind // ignore: cast_nullable_to_non_nullable
as String,forecastWeather: null == forecastWeather ? _self.forecastWeather : forecastWeather // ignore: cast_nullable_to_non_nullable
as String,forecastMaxtemp: null == forecastMaxtemp ? _self.forecastMaxtemp : forecastMaxtemp // ignore: cast_nullable_to_non_nullable
as int,forecastMintemp: null == forecastMintemp ? _self.forecastMintemp : forecastMintemp // ignore: cast_nullable_to_non_nullable
as int,forecastMaxrh: null == forecastMaxrh ? _self.forecastMaxrh : forecastMaxrh // ignore: cast_nullable_to_non_nullable
as int,forecastMinrh: null == forecastMinrh ? _self.forecastMinrh : forecastMinrh // ignore: cast_nullable_to_non_nullable
as int,forecastIcon: null == forecastIcon ? _self.forecastIcon : forecastIcon // ignore: cast_nullable_to_non_nullable
as String,PSR: null == PSR ? _self.PSR : PSR // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ForecastDay].
extension ForecastDayPatterns on ForecastDay {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForecastDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForecastDay() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForecastDay value)  $default,){
final _that = this;
switch (_that) {
case _ForecastDay():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForecastDay value)?  $default,){
final _that = this;
switch (_that) {
case _ForecastDay() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String forecastDate,  String week,  String forecastWind,  String forecastWeather,  int forecastMaxtemp,  int forecastMintemp,  int forecastMaxrh,  int forecastMinrh,  String forecastIcon,  String PSR)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForecastDay() when $default != null:
return $default(_that.forecastDate,_that.week,_that.forecastWind,_that.forecastWeather,_that.forecastMaxtemp,_that.forecastMintemp,_that.forecastMaxrh,_that.forecastMinrh,_that.forecastIcon,_that.PSR);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String forecastDate,  String week,  String forecastWind,  String forecastWeather,  int forecastMaxtemp,  int forecastMintemp,  int forecastMaxrh,  int forecastMinrh,  String forecastIcon,  String PSR)  $default,) {final _that = this;
switch (_that) {
case _ForecastDay():
return $default(_that.forecastDate,_that.week,_that.forecastWind,_that.forecastWeather,_that.forecastMaxtemp,_that.forecastMintemp,_that.forecastMaxrh,_that.forecastMinrh,_that.forecastIcon,_that.PSR);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String forecastDate,  String week,  String forecastWind,  String forecastWeather,  int forecastMaxtemp,  int forecastMintemp,  int forecastMaxrh,  int forecastMinrh,  String forecastIcon,  String PSR)?  $default,) {final _that = this;
switch (_that) {
case _ForecastDay() when $default != null:
return $default(_that.forecastDate,_that.week,_that.forecastWind,_that.forecastWeather,_that.forecastMaxtemp,_that.forecastMintemp,_that.forecastMaxrh,_that.forecastMinrh,_that.forecastIcon,_that.PSR);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForecastDay implements ForecastDay {
  const _ForecastDay({this.forecastDate = '', this.week = '', this.forecastWind = '', this.forecastWeather = '', this.forecastMaxtemp = 0, this.forecastMintemp = 0, this.forecastMaxrh = 0, this.forecastMinrh = 0, this.forecastIcon = '', this.PSR = ''});
  factory _ForecastDay.fromJson(Map<String, dynamic> json) => _$ForecastDayFromJson(json);

@override@JsonKey() final  String forecastDate;
@override@JsonKey() final  String week;
@override@JsonKey() final  String forecastWind;
@override@JsonKey() final  String forecastWeather;
@override@JsonKey() final  int forecastMaxtemp;
@override@JsonKey() final  int forecastMintemp;
@override@JsonKey() final  int forecastMaxrh;
@override@JsonKey() final  int forecastMinrh;
@override@JsonKey() final  String forecastIcon;
@override@JsonKey() final  String PSR;

/// Create a copy of ForecastDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForecastDayCopyWith<_ForecastDay> get copyWith => __$ForecastDayCopyWithImpl<_ForecastDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForecastDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForecastDay&&(identical(other.forecastDate, forecastDate) || other.forecastDate == forecastDate)&&(identical(other.week, week) || other.week == week)&&(identical(other.forecastWind, forecastWind) || other.forecastWind == forecastWind)&&(identical(other.forecastWeather, forecastWeather) || other.forecastWeather == forecastWeather)&&(identical(other.forecastMaxtemp, forecastMaxtemp) || other.forecastMaxtemp == forecastMaxtemp)&&(identical(other.forecastMintemp, forecastMintemp) || other.forecastMintemp == forecastMintemp)&&(identical(other.forecastMaxrh, forecastMaxrh) || other.forecastMaxrh == forecastMaxrh)&&(identical(other.forecastMinrh, forecastMinrh) || other.forecastMinrh == forecastMinrh)&&(identical(other.forecastIcon, forecastIcon) || other.forecastIcon == forecastIcon)&&(identical(other.PSR, PSR) || other.PSR == PSR));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forecastDate,week,forecastWind,forecastWeather,forecastMaxtemp,forecastMintemp,forecastMaxrh,forecastMinrh,forecastIcon,PSR);

@override
String toString() {
  return 'ForecastDay(forecastDate: $forecastDate, week: $week, forecastWind: $forecastWind, forecastWeather: $forecastWeather, forecastMaxtemp: $forecastMaxtemp, forecastMintemp: $forecastMintemp, forecastMaxrh: $forecastMaxrh, forecastMinrh: $forecastMinrh, forecastIcon: $forecastIcon, PSR: $PSR)';
}


}

/// @nodoc
abstract mixin class _$ForecastDayCopyWith<$Res> implements $ForecastDayCopyWith<$Res> {
  factory _$ForecastDayCopyWith(_ForecastDay value, $Res Function(_ForecastDay) _then) = __$ForecastDayCopyWithImpl;
@override @useResult
$Res call({
 String forecastDate, String week, String forecastWind, String forecastWeather, int forecastMaxtemp, int forecastMintemp, int forecastMaxrh, int forecastMinrh, String forecastIcon, String PSR
});




}
/// @nodoc
class __$ForecastDayCopyWithImpl<$Res>
    implements _$ForecastDayCopyWith<$Res> {
  __$ForecastDayCopyWithImpl(this._self, this._then);

  final _ForecastDay _self;
  final $Res Function(_ForecastDay) _then;

/// Create a copy of ForecastDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forecastDate = null,Object? week = null,Object? forecastWind = null,Object? forecastWeather = null,Object? forecastMaxtemp = null,Object? forecastMintemp = null,Object? forecastMaxrh = null,Object? forecastMinrh = null,Object? forecastIcon = null,Object? PSR = null,}) {
  return _then(_ForecastDay(
forecastDate: null == forecastDate ? _self.forecastDate : forecastDate // ignore: cast_nullable_to_non_nullable
as String,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as String,forecastWind: null == forecastWind ? _self.forecastWind : forecastWind // ignore: cast_nullable_to_non_nullable
as String,forecastWeather: null == forecastWeather ? _self.forecastWeather : forecastWeather // ignore: cast_nullable_to_non_nullable
as String,forecastMaxtemp: null == forecastMaxtemp ? _self.forecastMaxtemp : forecastMaxtemp // ignore: cast_nullable_to_non_nullable
as int,forecastMintemp: null == forecastMintemp ? _self.forecastMintemp : forecastMintemp // ignore: cast_nullable_to_non_nullable
as int,forecastMaxrh: null == forecastMaxrh ? _self.forecastMaxrh : forecastMaxrh // ignore: cast_nullable_to_non_nullable
as int,forecastMinrh: null == forecastMinrh ? _self.forecastMinrh : forecastMinrh // ignore: cast_nullable_to_non_nullable
as int,forecastIcon: null == forecastIcon ? _self.forecastIcon : forecastIcon // ignore: cast_nullable_to_non_nullable
as String,PSR: null == PSR ? _self.PSR : PSR // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SeaSoilTemp {

 String get place; String get value; String get unit; String get recordTime;
/// Create a copy of SeaSoilTemp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeaSoilTempCopyWith<SeaSoilTemp> get copyWith => _$SeaSoilTempCopyWithImpl<SeaSoilTemp>(this as SeaSoilTemp, _$identity);

  /// Serializes this SeaSoilTemp to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeaSoilTemp&&(identical(other.place, place) || other.place == place)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.recordTime, recordTime) || other.recordTime == recordTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,place,value,unit,recordTime);

@override
String toString() {
  return 'SeaSoilTemp(place: $place, value: $value, unit: $unit, recordTime: $recordTime)';
}


}

/// @nodoc
abstract mixin class $SeaSoilTempCopyWith<$Res>  {
  factory $SeaSoilTempCopyWith(SeaSoilTemp value, $Res Function(SeaSoilTemp) _then) = _$SeaSoilTempCopyWithImpl;
@useResult
$Res call({
 String place, String value, String unit, String recordTime
});




}
/// @nodoc
class _$SeaSoilTempCopyWithImpl<$Res>
    implements $SeaSoilTempCopyWith<$Res> {
  _$SeaSoilTempCopyWithImpl(this._self, this._then);

  final SeaSoilTemp _self;
  final $Res Function(SeaSoilTemp) _then;

/// Create a copy of SeaSoilTemp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? place = null,Object? value = null,Object? unit = null,Object? recordTime = null,}) {
  return _then(_self.copyWith(
place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,recordTime: null == recordTime ? _self.recordTime : recordTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SeaSoilTemp].
extension SeaSoilTempPatterns on SeaSoilTemp {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeaSoilTemp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeaSoilTemp() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeaSoilTemp value)  $default,){
final _that = this;
switch (_that) {
case _SeaSoilTemp():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeaSoilTemp value)?  $default,){
final _that = this;
switch (_that) {
case _SeaSoilTemp() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String place,  String value,  String unit,  String recordTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeaSoilTemp() when $default != null:
return $default(_that.place,_that.value,_that.unit,_that.recordTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String place,  String value,  String unit,  String recordTime)  $default,) {final _that = this;
switch (_that) {
case _SeaSoilTemp():
return $default(_that.place,_that.value,_that.unit,_that.recordTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String place,  String value,  String unit,  String recordTime)?  $default,) {final _that = this;
switch (_that) {
case _SeaSoilTemp() when $default != null:
return $default(_that.place,_that.value,_that.unit,_that.recordTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeaSoilTemp implements SeaSoilTemp {
  const _SeaSoilTemp({this.place = '', this.value = '', this.unit = '', this.recordTime = ''});
  factory _SeaSoilTemp.fromJson(Map<String, dynamic> json) => _$SeaSoilTempFromJson(json);

@override@JsonKey() final  String place;
@override@JsonKey() final  String value;
@override@JsonKey() final  String unit;
@override@JsonKey() final  String recordTime;

/// Create a copy of SeaSoilTemp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeaSoilTempCopyWith<_SeaSoilTemp> get copyWith => __$SeaSoilTempCopyWithImpl<_SeaSoilTemp>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeaSoilTempToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeaSoilTemp&&(identical(other.place, place) || other.place == place)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.recordTime, recordTime) || other.recordTime == recordTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,place,value,unit,recordTime);

@override
String toString() {
  return 'SeaSoilTemp(place: $place, value: $value, unit: $unit, recordTime: $recordTime)';
}


}

/// @nodoc
abstract mixin class _$SeaSoilTempCopyWith<$Res> implements $SeaSoilTempCopyWith<$Res> {
  factory _$SeaSoilTempCopyWith(_SeaSoilTemp value, $Res Function(_SeaSoilTemp) _then) = __$SeaSoilTempCopyWithImpl;
@override @useResult
$Res call({
 String place, String value, String unit, String recordTime
});




}
/// @nodoc
class __$SeaSoilTempCopyWithImpl<$Res>
    implements _$SeaSoilTempCopyWith<$Res> {
  __$SeaSoilTempCopyWithImpl(this._self, this._then);

  final _SeaSoilTemp _self;
  final $Res Function(_SeaSoilTemp) _then;

/// Create a copy of SeaSoilTemp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? place = null,Object? value = null,Object? unit = null,Object? recordTime = null,}) {
  return _then(_SeaSoilTemp(
place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,recordTime: null == recordTime ? _self.recordTime : recordTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WeatherWarning {

 String get name; String get code; String get actionCode; String get issueTime; String get expireTime; String get updateTime; String get contents;
/// Create a copy of WeatherWarning
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherWarningCopyWith<WeatherWarning> get copyWith => _$WeatherWarningCopyWithImpl<WeatherWarning>(this as WeatherWarning, _$identity);

  /// Serializes this WeatherWarning to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherWarning&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.actionCode, actionCode) || other.actionCode == actionCode)&&(identical(other.issueTime, issueTime) || other.issueTime == issueTime)&&(identical(other.expireTime, expireTime) || other.expireTime == expireTime)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime)&&(identical(other.contents, contents) || other.contents == contents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,actionCode,issueTime,expireTime,updateTime,contents);

@override
String toString() {
  return 'WeatherWarning(name: $name, code: $code, actionCode: $actionCode, issueTime: $issueTime, expireTime: $expireTime, updateTime: $updateTime, contents: $contents)';
}


}

/// @nodoc
abstract mixin class $WeatherWarningCopyWith<$Res>  {
  factory $WeatherWarningCopyWith(WeatherWarning value, $Res Function(WeatherWarning) _then) = _$WeatherWarningCopyWithImpl;
@useResult
$Res call({
 String name, String code, String actionCode, String issueTime, String expireTime, String updateTime, String contents
});




}
/// @nodoc
class _$WeatherWarningCopyWithImpl<$Res>
    implements $WeatherWarningCopyWith<$Res> {
  _$WeatherWarningCopyWithImpl(this._self, this._then);

  final WeatherWarning _self;
  final $Res Function(WeatherWarning) _then;

/// Create a copy of WeatherWarning
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? code = null,Object? actionCode = null,Object? issueTime = null,Object? expireTime = null,Object? updateTime = null,Object? contents = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,actionCode: null == actionCode ? _self.actionCode : actionCode // ignore: cast_nullable_to_non_nullable
as String,issueTime: null == issueTime ? _self.issueTime : issueTime // ignore: cast_nullable_to_non_nullable
as String,expireTime: null == expireTime ? _self.expireTime : expireTime // ignore: cast_nullable_to_non_nullable
as String,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as String,contents: null == contents ? _self.contents : contents // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherWarning].
extension WeatherWarningPatterns on WeatherWarning {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherWarning value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherWarning() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherWarning value)  $default,){
final _that = this;
switch (_that) {
case _WeatherWarning():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherWarning value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherWarning() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String code,  String actionCode,  String issueTime,  String expireTime,  String updateTime,  String contents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherWarning() when $default != null:
return $default(_that.name,_that.code,_that.actionCode,_that.issueTime,_that.expireTime,_that.updateTime,_that.contents);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String code,  String actionCode,  String issueTime,  String expireTime,  String updateTime,  String contents)  $default,) {final _that = this;
switch (_that) {
case _WeatherWarning():
return $default(_that.name,_that.code,_that.actionCode,_that.issueTime,_that.expireTime,_that.updateTime,_that.contents);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String code,  String actionCode,  String issueTime,  String expireTime,  String updateTime,  String contents)?  $default,) {final _that = this;
switch (_that) {
case _WeatherWarning() when $default != null:
return $default(_that.name,_that.code,_that.actionCode,_that.issueTime,_that.expireTime,_that.updateTime,_that.contents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherWarning implements WeatherWarning {
  const _WeatherWarning({this.name = '', this.code = '', this.actionCode = '', this.issueTime = '', this.expireTime = '', this.updateTime = '', this.contents = ''});
  factory _WeatherWarning.fromJson(Map<String, dynamic> json) => _$WeatherWarningFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String code;
@override@JsonKey() final  String actionCode;
@override@JsonKey() final  String issueTime;
@override@JsonKey() final  String expireTime;
@override@JsonKey() final  String updateTime;
@override@JsonKey() final  String contents;

/// Create a copy of WeatherWarning
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherWarningCopyWith<_WeatherWarning> get copyWith => __$WeatherWarningCopyWithImpl<_WeatherWarning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherWarningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherWarning&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.actionCode, actionCode) || other.actionCode == actionCode)&&(identical(other.issueTime, issueTime) || other.issueTime == issueTime)&&(identical(other.expireTime, expireTime) || other.expireTime == expireTime)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime)&&(identical(other.contents, contents) || other.contents == contents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,actionCode,issueTime,expireTime,updateTime,contents);

@override
String toString() {
  return 'WeatherWarning(name: $name, code: $code, actionCode: $actionCode, issueTime: $issueTime, expireTime: $expireTime, updateTime: $updateTime, contents: $contents)';
}


}

/// @nodoc
abstract mixin class _$WeatherWarningCopyWith<$Res> implements $WeatherWarningCopyWith<$Res> {
  factory _$WeatherWarningCopyWith(_WeatherWarning value, $Res Function(_WeatherWarning) _then) = __$WeatherWarningCopyWithImpl;
@override @useResult
$Res call({
 String name, String code, String actionCode, String issueTime, String expireTime, String updateTime, String contents
});




}
/// @nodoc
class __$WeatherWarningCopyWithImpl<$Res>
    implements _$WeatherWarningCopyWith<$Res> {
  __$WeatherWarningCopyWithImpl(this._self, this._then);

  final _WeatherWarning _self;
  final $Res Function(_WeatherWarning) _then;

/// Create a copy of WeatherWarning
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? code = null,Object? actionCode = null,Object? issueTime = null,Object? expireTime = null,Object? updateTime = null,Object? contents = null,}) {
  return _then(_WeatherWarning(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,actionCode: null == actionCode ? _self.actionCode : actionCode // ignore: cast_nullable_to_non_nullable
as String,issueTime: null == issueTime ? _self.issueTime : issueTime // ignore: cast_nullable_to_non_nullable
as String,expireTime: null == expireTime ? _self.expireTime : expireTime // ignore: cast_nullable_to_non_nullable
as String,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as String,contents: null == contents ? _self.contents : contents // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
