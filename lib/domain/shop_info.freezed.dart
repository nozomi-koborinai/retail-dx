// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShopInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  GeoLocation get location => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShopInfoCopyWith<ShopInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopInfoCopyWith<$Res> {
  factory $ShopInfoCopyWith(ShopInfo value, $Res Function(ShopInfo) then) =
      _$ShopInfoCopyWithImpl<$Res, ShopInfo>;
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      String imageUrl,
      GeoLocation location});

  $GeoLocationCopyWith<$Res> get location;
}

/// @nodoc
class _$ShopInfoCopyWithImpl<$Res, $Val extends ShopInfo>
    implements $ShopInfoCopyWith<$Res> {
  _$ShopInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? imageUrl = null,
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res> get location {
    return $GeoLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShopInfoImplCopyWith<$Res>
    implements $ShopInfoCopyWith<$Res> {
  factory _$$ShopInfoImplCopyWith(
          _$ShopInfoImpl value, $Res Function(_$ShopInfoImpl) then) =
      __$$ShopInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      String imageUrl,
      GeoLocation location});

  @override
  $GeoLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$ShopInfoImplCopyWithImpl<$Res>
    extends _$ShopInfoCopyWithImpl<$Res, _$ShopInfoImpl>
    implements _$$ShopInfoImplCopyWith<$Res> {
  __$$ShopInfoImplCopyWithImpl(
      _$ShopInfoImpl _value, $Res Function(_$ShopInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? imageUrl = null,
    Object? location = null,
  }) {
    return _then(_$ShopInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
    ));
  }
}

/// @nodoc

class _$ShopInfoImpl implements _ShopInfo {
  const _$ShopInfoImpl(
      {required this.id,
      required this.name,
      required this.address,
      required this.imageUrl,
      required this.location});

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final String imageUrl;
  @override
  final GeoLocation location;

  @override
  String toString() {
    return 'ShopInfo(id: $id, name: $name, address: $address, imageUrl: $imageUrl, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, address, imageUrl, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopInfoImplCopyWith<_$ShopInfoImpl> get copyWith =>
      __$$ShopInfoImplCopyWithImpl<_$ShopInfoImpl>(this, _$identity);
}

abstract class _ShopInfo implements ShopInfo {
  const factory _ShopInfo(
      {required final String id,
      required final String name,
      required final String address,
      required final String imageUrl,
      required final GeoLocation location}) = _$ShopInfoImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  String get imageUrl;
  @override
  GeoLocation get location;
  @override
  @JsonKey(ignore: true)
  _$$ShopInfoImplCopyWith<_$ShopInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
