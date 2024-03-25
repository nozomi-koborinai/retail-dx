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
    );

Map<String, dynamic> _$$ShopItemDocumentImplToJson(
        _$ShopItemDocumentImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'shopIds': instance.shopIds,
      'price': instance.price,
    };
