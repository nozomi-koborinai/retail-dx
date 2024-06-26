// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_item_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShopItemDocument _$ShopItemDocumentFromJson(Map<String, dynamic> json) {
  return _ShopItemDocument.fromJson(json);
}

/// @nodoc
mixin _$ShopItemDocument {
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShopItemDocumentCopyWith<ShopItemDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopItemDocumentCopyWith<$Res> {
  factory $ShopItemDocumentCopyWith(
          ShopItemDocument value, $Res Function(ShopItemDocument) then) =
      _$ShopItemDocumentCopyWithImpl<$Res, ShopItemDocument>;
  @useResult
  $Res call(
      {String name,
      String category,
      String imageUrl,
      int price,
      int quantity,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$ShopItemDocumentCopyWithImpl<$Res, $Val extends ShopItemDocument>
    implements $ShopItemDocumentCopyWith<$Res> {
  _$ShopItemDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? imageUrl = null,
    Object? price = null,
    Object? quantity = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
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
}

/// @nodoc
abstract class _$$ShopItemDocumentImplCopyWith<$Res>
    implements $ShopItemDocumentCopyWith<$Res> {
  factory _$$ShopItemDocumentImplCopyWith(_$ShopItemDocumentImpl value,
          $Res Function(_$ShopItemDocumentImpl) then) =
      __$$ShopItemDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String category,
      String imageUrl,
      int price,
      int quantity,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$ShopItemDocumentImplCopyWithImpl<$Res>
    extends _$ShopItemDocumentCopyWithImpl<$Res, _$ShopItemDocumentImpl>
    implements _$$ShopItemDocumentImplCopyWith<$Res> {
  __$$ShopItemDocumentImplCopyWithImpl(_$ShopItemDocumentImpl _value,
      $Res Function(_$ShopItemDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? imageUrl = null,
    Object? price = null,
    Object? quantity = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ShopItemDocumentImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$ShopItemDocumentImpl extends _ShopItemDocument {
  const _$ShopItemDocumentImpl(
      {required this.name,
      required this.category,
      required this.imageUrl,
      required this.price,
      required this.quantity,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : super._();

  factory _$ShopItemDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopItemDocumentImplFromJson(json);

  @override
  final String name;
  @override
  final String category;
  @override
  final String imageUrl;
  @override
  final int price;
  @override
  final int quantity;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ShopItemDocument(name: $name, category: $category, imageUrl: $imageUrl, price: $price, quantity: $quantity, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopItemDocumentImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, category, imageUrl, price,
      quantity, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopItemDocumentImplCopyWith<_$ShopItemDocumentImpl> get copyWith =>
      __$$ShopItemDocumentImplCopyWithImpl<_$ShopItemDocumentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopItemDocumentImplToJson(
      this,
    );
  }
}

abstract class _ShopItemDocument extends ShopItemDocument {
  const factory _ShopItemDocument(
          {required final String name,
          required final String category,
          required final String imageUrl,
          required final int price,
          required final int quantity,
          @TimestampConverter() final DateTime? createdAt,
          @TimestampConverter() final DateTime? updatedAt}) =
      _$ShopItemDocumentImpl;
  const _ShopItemDocument._() : super._();

  factory _ShopItemDocument.fromJson(Map<String, dynamic> json) =
      _$ShopItemDocumentImpl.fromJson;

  @override
  String get name;
  @override
  String get category;
  @override
  String get imageUrl;
  @override
  int get price;
  @override
  int get quantity;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ShopItemDocumentImplCopyWith<_$ShopItemDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
