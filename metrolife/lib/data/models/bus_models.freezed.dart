// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusStop {

 String get stop; String get nameEn; String get nameTc; double get lat; double get long;
/// Create a copy of BusStop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusStopCopyWith<BusStop> get copyWith => _$BusStopCopyWithImpl<BusStop>(this as BusStop, _$identity);

  /// Serializes this BusStop to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusStop&&(identical(other.stop, stop) || other.stop == stop)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameTc, nameTc) || other.nameTc == nameTc)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.long, long) || other.long == long));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stop,nameEn,nameTc,lat,long);

@override
String toString() {
  return 'BusStop(stop: $stop, nameEn: $nameEn, nameTc: $nameTc, lat: $lat, long: $long)';
}


}

/// @nodoc
abstract mixin class $BusStopCopyWith<$Res>  {
  factory $BusStopCopyWith(BusStop value, $Res Function(BusStop) _then) = _$BusStopCopyWithImpl;
@useResult
$Res call({
 String stop, String nameEn, String nameTc, double lat, double long
});




}
/// @nodoc
class _$BusStopCopyWithImpl<$Res>
    implements $BusStopCopyWith<$Res> {
  _$BusStopCopyWithImpl(this._self, this._then);

  final BusStop _self;
  final $Res Function(BusStop) _then;

/// Create a copy of BusStop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stop = null,Object? nameEn = null,Object? nameTc = null,Object? lat = null,Object? long = null,}) {
  return _then(_self.copyWith(
stop: null == stop ? _self.stop : stop // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameTc: null == nameTc ? _self.nameTc : nameTc // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,long: null == long ? _self.long : long // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BusStop].
extension BusStopPatterns on BusStop {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusStop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusStop() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusStop value)  $default,){
final _that = this;
switch (_that) {
case _BusStop():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusStop value)?  $default,){
final _that = this;
switch (_that) {
case _BusStop() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stop,  String nameEn,  String nameTc,  double lat,  double long)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusStop() when $default != null:
return $default(_that.stop,_that.nameEn,_that.nameTc,_that.lat,_that.long);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stop,  String nameEn,  String nameTc,  double lat,  double long)  $default,) {final _that = this;
switch (_that) {
case _BusStop():
return $default(_that.stop,_that.nameEn,_that.nameTc,_that.lat,_that.long);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stop,  String nameEn,  String nameTc,  double lat,  double long)?  $default,) {final _that = this;
switch (_that) {
case _BusStop() when $default != null:
return $default(_that.stop,_that.nameEn,_that.nameTc,_that.lat,_that.long);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusStop implements BusStop {
  const _BusStop({this.stop = '', this.nameEn = '', this.nameTc = '', this.lat = 0.0, this.long = 0.0});
  factory _BusStop.fromJson(Map<String, dynamic> json) => _$BusStopFromJson(json);

@override@JsonKey() final  String stop;
@override@JsonKey() final  String nameEn;
@override@JsonKey() final  String nameTc;
@override@JsonKey() final  double lat;
@override@JsonKey() final  double long;

/// Create a copy of BusStop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusStopCopyWith<_BusStop> get copyWith => __$BusStopCopyWithImpl<_BusStop>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusStopToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusStop&&(identical(other.stop, stop) || other.stop == stop)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameTc, nameTc) || other.nameTc == nameTc)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.long, long) || other.long == long));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stop,nameEn,nameTc,lat,long);

@override
String toString() {
  return 'BusStop(stop: $stop, nameEn: $nameEn, nameTc: $nameTc, lat: $lat, long: $long)';
}


}

/// @nodoc
abstract mixin class _$BusStopCopyWith<$Res> implements $BusStopCopyWith<$Res> {
  factory _$BusStopCopyWith(_BusStop value, $Res Function(_BusStop) _then) = __$BusStopCopyWithImpl;
@override @useResult
$Res call({
 String stop, String nameEn, String nameTc, double lat, double long
});




}
/// @nodoc
class __$BusStopCopyWithImpl<$Res>
    implements _$BusStopCopyWith<$Res> {
  __$BusStopCopyWithImpl(this._self, this._then);

  final _BusStop _self;
  final $Res Function(_BusStop) _then;

/// Create a copy of BusStop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stop = null,Object? nameEn = null,Object? nameTc = null,Object? lat = null,Object? long = null,}) {
  return _then(_BusStop(
stop: null == stop ? _self.stop : stop // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameTc: null == nameTc ? _self.nameTc : nameTc // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,long: null == long ? _self.long : long // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$BusEta {

 String get stop; String get route; String get dir; int get serviceType; int get etaSeq; String get eta; String get rmkTc; String get rmkEn;
/// Create a copy of BusEta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusEtaCopyWith<BusEta> get copyWith => _$BusEtaCopyWithImpl<BusEta>(this as BusEta, _$identity);

  /// Serializes this BusEta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusEta&&(identical(other.stop, stop) || other.stop == stop)&&(identical(other.route, route) || other.route == route)&&(identical(other.dir, dir) || other.dir == dir)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.etaSeq, etaSeq) || other.etaSeq == etaSeq)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.rmkTc, rmkTc) || other.rmkTc == rmkTc)&&(identical(other.rmkEn, rmkEn) || other.rmkEn == rmkEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stop,route,dir,serviceType,etaSeq,eta,rmkTc,rmkEn);

@override
String toString() {
  return 'BusEta(stop: $stop, route: $route, dir: $dir, serviceType: $serviceType, etaSeq: $etaSeq, eta: $eta, rmkTc: $rmkTc, rmkEn: $rmkEn)';
}


}

/// @nodoc
abstract mixin class $BusEtaCopyWith<$Res>  {
  factory $BusEtaCopyWith(BusEta value, $Res Function(BusEta) _then) = _$BusEtaCopyWithImpl;
@useResult
$Res call({
 String stop, String route, String dir, int serviceType, int etaSeq, String eta, String rmkTc, String rmkEn
});




}
/// @nodoc
class _$BusEtaCopyWithImpl<$Res>
    implements $BusEtaCopyWith<$Res> {
  _$BusEtaCopyWithImpl(this._self, this._then);

  final BusEta _self;
  final $Res Function(BusEta) _then;

/// Create a copy of BusEta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stop = null,Object? route = null,Object? dir = null,Object? serviceType = null,Object? etaSeq = null,Object? eta = null,Object? rmkTc = null,Object? rmkEn = null,}) {
  return _then(_self.copyWith(
stop: null == stop ? _self.stop : stop // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,dir: null == dir ? _self.dir : dir // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as int,etaSeq: null == etaSeq ? _self.etaSeq : etaSeq // ignore: cast_nullable_to_non_nullable
as int,eta: null == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as String,rmkTc: null == rmkTc ? _self.rmkTc : rmkTc // ignore: cast_nullable_to_non_nullable
as String,rmkEn: null == rmkEn ? _self.rmkEn : rmkEn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BusEta].
extension BusEtaPatterns on BusEta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusEta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusEta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusEta value)  $default,){
final _that = this;
switch (_that) {
case _BusEta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusEta value)?  $default,){
final _that = this;
switch (_that) {
case _BusEta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stop,  String route,  String dir,  int serviceType,  int etaSeq,  String eta,  String rmkTc,  String rmkEn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusEta() when $default != null:
return $default(_that.stop,_that.route,_that.dir,_that.serviceType,_that.etaSeq,_that.eta,_that.rmkTc,_that.rmkEn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stop,  String route,  String dir,  int serviceType,  int etaSeq,  String eta,  String rmkTc,  String rmkEn)  $default,) {final _that = this;
switch (_that) {
case _BusEta():
return $default(_that.stop,_that.route,_that.dir,_that.serviceType,_that.etaSeq,_that.eta,_that.rmkTc,_that.rmkEn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stop,  String route,  String dir,  int serviceType,  int etaSeq,  String eta,  String rmkTc,  String rmkEn)?  $default,) {final _that = this;
switch (_that) {
case _BusEta() when $default != null:
return $default(_that.stop,_that.route,_that.dir,_that.serviceType,_that.etaSeq,_that.eta,_that.rmkTc,_that.rmkEn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusEta implements BusEta {
  const _BusEta({this.stop = '', this.route = '', this.dir = '', this.serviceType = 1, this.etaSeq = 1, this.eta = '', this.rmkTc = '', this.rmkEn = ''});
  factory _BusEta.fromJson(Map<String, dynamic> json) => _$BusEtaFromJson(json);

@override@JsonKey() final  String stop;
@override@JsonKey() final  String route;
@override@JsonKey() final  String dir;
@override@JsonKey() final  int serviceType;
@override@JsonKey() final  int etaSeq;
@override@JsonKey() final  String eta;
@override@JsonKey() final  String rmkTc;
@override@JsonKey() final  String rmkEn;

/// Create a copy of BusEta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusEtaCopyWith<_BusEta> get copyWith => __$BusEtaCopyWithImpl<_BusEta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusEtaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusEta&&(identical(other.stop, stop) || other.stop == stop)&&(identical(other.route, route) || other.route == route)&&(identical(other.dir, dir) || other.dir == dir)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.etaSeq, etaSeq) || other.etaSeq == etaSeq)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.rmkTc, rmkTc) || other.rmkTc == rmkTc)&&(identical(other.rmkEn, rmkEn) || other.rmkEn == rmkEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stop,route,dir,serviceType,etaSeq,eta,rmkTc,rmkEn);

@override
String toString() {
  return 'BusEta(stop: $stop, route: $route, dir: $dir, serviceType: $serviceType, etaSeq: $etaSeq, eta: $eta, rmkTc: $rmkTc, rmkEn: $rmkEn)';
}


}

/// @nodoc
abstract mixin class _$BusEtaCopyWith<$Res> implements $BusEtaCopyWith<$Res> {
  factory _$BusEtaCopyWith(_BusEta value, $Res Function(_BusEta) _then) = __$BusEtaCopyWithImpl;
@override @useResult
$Res call({
 String stop, String route, String dir, int serviceType, int etaSeq, String eta, String rmkTc, String rmkEn
});




}
/// @nodoc
class __$BusEtaCopyWithImpl<$Res>
    implements _$BusEtaCopyWith<$Res> {
  __$BusEtaCopyWithImpl(this._self, this._then);

  final _BusEta _self;
  final $Res Function(_BusEta) _then;

/// Create a copy of BusEta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stop = null,Object? route = null,Object? dir = null,Object? serviceType = null,Object? etaSeq = null,Object? eta = null,Object? rmkTc = null,Object? rmkEn = null,}) {
  return _then(_BusEta(
stop: null == stop ? _self.stop : stop // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,dir: null == dir ? _self.dir : dir // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as int,etaSeq: null == etaSeq ? _self.etaSeq : etaSeq // ignore: cast_nullable_to_non_nullable
as int,eta: null == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as String,rmkTc: null == rmkTc ? _self.rmkTc : rmkTc // ignore: cast_nullable_to_non_nullable
as String,rmkEn: null == rmkEn ? _self.rmkEn : rmkEn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
