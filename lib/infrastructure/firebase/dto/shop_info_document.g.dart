// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_info_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopInfoDocumentImpl _$$ShopInfoDocumentImplFromJson(
        Map<String, dynamic> json) =>
    _$ShopInfoDocumentImpl(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      address: json['address'] as String,
      location: _$JsonConverterFromJson<Object, GeoLocation>(
          json['location'], const GeoPointConverter().fromJson),
      createdAt: _$JsonConverterFromJson<Object, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Object, DateTime>(
          json['updatedAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$ShopInfoDocumentImplToJson(
        _$ShopInfoDocumentImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'address': instance.address,
      'location': _$JsonConverterToJson<Object, GeoLocation>(
          instance.location, const GeoPointConverter().toJson),
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
