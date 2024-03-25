import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _ShopItemDocument;

  factory ShopItemDocument.fromJson(Map<String, dynamic> json) =>
      _$ShopItemDocumentFromJson(json);
}
