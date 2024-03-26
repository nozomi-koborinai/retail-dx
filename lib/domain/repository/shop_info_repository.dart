import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shop_info.dart';

final shopInfoRepositoryProvider = Provider<ShopInfoRepository>(
  (ref) => throw UnimplementedError(),
);

abstract interface class ShopInfoRepository {
  Future<List<ShopInfo>> fetchAll();
  Future<ShopInfo> fetchById(String id);
  Future<void> add(ShopInfo shopInfo);
  Future<void> update(ShopInfo shopInfo);
  Future<void> delete(ShopInfo shopInfo);
}
