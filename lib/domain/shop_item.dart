import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_item.freezed.dart';

@freezed
class ShopItem with _$ShopItem {
  const factory ShopItem({
    required String id,
    required String name,
    required String category,
    required String imageUrl,
    required String shopId,
    required int price,
    required int quantity,
  }) = _ShopItem;
}
