import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retail_dx/domain/shop_item.dart';

import '../../../domain/repository/shop_item_repository.dart';

final shopItemsProvider = FutureProvider<List<ShopItem>>(
  (ref) => ref.watch(shopItemRepositoryProvider).fetchAll(),
);
