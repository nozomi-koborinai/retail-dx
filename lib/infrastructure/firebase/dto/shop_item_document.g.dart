// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_item_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopItemDocumentImpl _$$ShopItemDocumentImplFromJson(
        Map<String, dynamic> json) =>
    _$ShopItemDocumentImpl(
      name: json['name'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      shopIds:
          (json['shopIds'] as List<dynamic>).map((e) => e as String).toList(),
      price: json['price'] as int,
      createdAt: _$JsonConverterFromJson<Object, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Object, DateTime>(
          json['updatedAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$ShopItemDocumentImplToJson(
        _$ShopItemDocumentImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'shopIds': instance.shopIds,
      'price': instance.price,
      'createdAt': _$JsonConverterToJson<Object, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
      'updatedAt': _$JsonConverterToJson<Object, DateTime>(
          instance.updatedAt, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
