import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter.dart';

part 'shop_item_document.freezed.dart';
part 'shop_item_document.g.dart';

@freezed
class ShopItemDocument with _$ShopItemDocument {
  const factory ShopItemDocument({
    required String name,
    required String category,
    required String imageUrl,
    required List<String> shopIds,
    required int price,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _ShopItemDocument;

  factory ShopItemDocument.fromJson(Map<String, dynamic> json) =>
      _$ShopItemDocumentFromJson(json);
}
