// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_info_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShopInfoDocument _$ShopInfoDocumentFromJson(Map<String, dynamic> json) {
  return _ShopInfoDocument.fromJson(json);
}

/// @nodoc
mixin _$ShopInfoDocument {
  String get name => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoLocation? get location => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShopInfoDocumentCopyWith<ShopInfoDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopInfoDocumentCopyWith<$Res> {
  factory $ShopInfoDocumentCopyWith(
          ShopInfoDocument value, $Res Function(ShopInfoDocument) then) =
      _$ShopInfoDocumentCopyWithImpl<$Res, ShopInfoDocument>;
  @useResult
  $Res call(
      {String name,
      String imageUrl,
      String address,
      @GeoPointConverter() GeoLocation? location,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});

  $GeoLocationCopyWith<$Res>? get location;
}

/// @nodoc
class _$ShopInfoDocumentCopyWithImpl<$Res, $Val extends ShopInfoDocument>
    implements $ShopInfoDocumentCopyWith<$Res> {
  _$ShopInfoDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? imageUrl = null,
    Object? address = null,
    Object? location = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $GeoLocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShopInfoDocumentImplCopyWith<$Res>
    implements $ShopInfoDocumentCopyWith<$Res> {
  factory _$$ShopInfoDocumentImplCopyWith(_$ShopInfoDocumentImpl value,
          $Res Function(_$ShopInfoDocumentImpl) then) =
      __$$ShopInfoDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String imageUrl,
      String address,
      @GeoPointConverter() GeoLocation? location,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});

  @override
  $GeoLocationCopyWith<$Res>? get location;
}

/// @nodoc
class __$$ShopInfoDocumentImplCopyWithImpl<$Res>
    extends _$ShopInfoDocumentCopyWithImpl<$Res, _$ShopInfoDocumentImpl>
    implements _$$ShopInfoDocumentImplCopyWith<$Res> {
  __$$ShopInfoDocumentImplCopyWithImpl(_$ShopInfoDocumentImpl _value,
      $Res Function(_$ShopInfoDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? imageUrl = null,
    Object? address = null,
    Object? location = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ShopInfoDocumentImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopInfoDocumentImpl extends _ShopInfoDocument {
  const _$ShopInfoDocumentImpl(
      {required this.name,
      required this.imageUrl,
      required this.address,
      @GeoPointConverter() this.location,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : super._();

  factory _$ShopInfoDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopInfoDocumentImplFromJson(json);

  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final String address;
  @override
  @GeoPointConverter()
  final GeoLocation? location;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ShopInfoDocument(name: $name, imageUrl: $imageUrl, address: $address, location: $location, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopInfoDocumentImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, imageUrl, address, location, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopInfoDocumentImplCopyWith<_$ShopInfoDocumentImpl> get copyWith =>
      __$$ShopInfoDocumentImplCopyWithImpl<_$ShopInfoDocumentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopInfoDocumentImplToJson(
      this,
    );
  }
}

abstract class _ShopInfoDocument extends ShopInfoDocument {
  const factory _ShopInfoDocument(
          {required final String name,
          required final String imageUrl,
          required final String address,
          @GeoPointConverter() final GeoLocation? location,
          @TimestampConverter() final DateTime? createdAt,
          @TimestampConverter() final DateTime? updatedAt}) =
      _$ShopInfoDocumentImpl;
  const _ShopInfoDocument._() : super._();

  factory _ShopInfoDocument.fromJson(Map<String, dynamic> json) =
      _$ShopInfoDocumentImpl.fromJson;

  @override
  String get name;
  @override
  String get imageUrl;
  @override
  String get address;
  @override
  @GeoPointConverter()
  GeoLocation? get location;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ShopInfoDocumentImplCopyWith<_$ShopInfoDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
