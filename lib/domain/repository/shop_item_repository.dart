import '../shop_item.dart';

abstract interface class ShopItemRepository {
  Future<List<ShopItem>> fetchAll();
  Future<ShopItem> fetchById(String id);
  Future<void> add(ShopItem shopItem);
  Future<void> update(ShopItem shopItem);
  Future<void> delete(ShopItem shopItem);
}
