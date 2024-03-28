import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shop_item.dart';

final shopItemRepositoryProvider = Provider<ShopItemRepository>(
  (ref) => throw UnimplementedError(),
);

abstract interface class ShopItemRepository {
  Future<List<ShopItem>> fetchAll();
  Future<List<ShopItem>> fetchById(String id);
  Future<List<ShopItem>> fetchByShopId(String shopId);
  Future<void> add(ShopItem shopItem);
  Future<void> update(ShopItem shopItem);
  Future<void> delete(ShopItem shopItem);
}
