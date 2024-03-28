import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retail_dx/domain/shop_info.dart';
import 'package:retail_dx/domain/shop_item.dart';

import '../../../domain/repository/shop_info_repository.dart';
import '../../../domain/repository/shop_item_repository.dart';

final shopItemsProvider = FutureProvider<List<ShopItem>>(
  (ref) => ref.watch(shopItemRepositoryProvider).fetchAll(),
);

final shopItemFusionsProvider =
    FutureProvider.family<List<(ShopInfo, ShopItem)>, String>(
        (ref, itemId) async {
  final result = <(ShopInfo, ShopItem)>[];
  final shopItems =
      await ref.watch(shopItemRepositoryProvider).fetchById(itemId);
  for (final shopItem in shopItems) {
    final shopInfo =
        await ref.watch(shopInfoRepositoryProvider).fetchById(shopItem.shopId);
    result.add((shopInfo, shopItem));
  }
  return result;
});
