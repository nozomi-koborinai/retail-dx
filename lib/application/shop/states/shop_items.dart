import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retail_dx/domain/shop_info.dart';
import 'package:retail_dx/domain/shop_item.dart';
import 'package:retail_dx/domain/weather/weather.dart';
import 'package:retail_dx/infrastructure/weather/weather_repository.dart';

import '../../../domain/repository/shop_info_repository.dart';
import '../../../domain/repository/shop_item_repository.dart';

final shopItemsProvider = FutureProvider<List<ShopItem>>(
  (ref) => ref.watch(shopItemRepositoryProvider).fetchAll(),
);

final shopItemFusionsProvider =
    FutureProvider.family<List<(ShopInfo, ShopItem, Weather)>, String>(
        (ref, itemId) async {
  final result = <(ShopInfo, ShopItem, Weather)>[];
  final shopItems =
      await ref.watch(shopItemRepositoryProvider).fetchById(itemId);
  for (final shopItem in shopItems) {
    if (shopItem.quantity == 0) continue;
    final shopInfo =
        await ref.watch(shopInfoRepositoryProvider).fetchById(shopItem.shopId);
    final weather = await ref.watch(weatherRepositoryProvider).fetch(
          latitude: shopInfo.location.latitude,
          longitude: shopInfo.location.longitude,
        );
    result.add((shopInfo, shopItem, weather));
  }
  return result;
});
