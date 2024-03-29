import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retail_dx/domain/shop_item.dart';

import '../converter.dart';

part 'shop_item_document.freezed.dart';
part 'shop_item_document.g.dart';

@freezed
class ShopItemDocument with _$ShopItemDocument {
  const factory ShopItemDocument({
    required String name,
    required String category,
    required String imageUrl,
    required int price,
    required int quantity,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _ShopItemDocument;

  const ShopItemDocument._();

  factory ShopItemDocument.fromJson(Map<String, dynamic> json) =>
      _$ShopItemDocumentFromJson(json);

  /// ShopItem -> ShopItem
  ShopItem toShopItem({required String id, required String shopId}) {
    return ShopItem(
      id: id,
      name: name,
      category: category,
      imageUrl: imageUrl,
      shopId: shopId,
      price: price,
      quantity: quantity,
    );
  }
}
