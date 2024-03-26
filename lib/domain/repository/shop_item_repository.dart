import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shop_item.dart';

final shopItemRepositoryProvider = Provider<ShopItemRepository>(
  (ref) => throw UnimplementedError(),
);

abstract interface class ShopItemRepository {
  Future<List<ShopItem>> fetchAll();
  Future<ShopItem> fetchById(String id);
  Future<void> add(ShopItem shopItem);
  Future<void> update(ShopItem shopItem);
  Future<void> delete(ShopItem shopItem);
}
