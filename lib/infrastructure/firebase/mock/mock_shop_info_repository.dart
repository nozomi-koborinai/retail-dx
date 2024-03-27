import 'package:retail_dx/domain/geo_location.dart';
import 'package:retail_dx/domain/shop_info.dart';
import 'package:retail_dx/infrastructure/firebase/mock/mock_shop_item_repository.dart';

import '../../../domain/repository/shop_info_repository.dart';

class MockShopInfoRepository implements ShopInfoRepository {
  // mock data
  final List<ShopInfo> shopInfos = [
    ShopInfo(
      id: '1',
      name: 'ショップ A',
      address: '東京都新宿区x-x-x',
      imageUrl: 'https://via.placeholder.com/150',
      location: const GeoLocation(
        latitude: 35.689487,
        longitude: 139.691706,
      ),
      items: MockShopItemRepository()
          .shopItems
          .where((item) => item.shopId == '1')
          .toList(),
    ),
    ShopInfo(
      id: '2',
      name: 'ショップ B',
      address: '東京都品川区y-y-y',
      imageUrl: 'https://via.placeholder.com/150',
      location: const GeoLocation(
        latitude: 35.628471,
        longitude: 139.73876,
      ),
      items: MockShopItemRepository()
          .shopItems
          .where((item) => item.shopId == '2')
          .toList(),
    ),
    ShopInfo(
      id: '3',
      name: 'ショップ C',
      address: '東京都港区z-z-z',
      imageUrl: 'https://via.placeholder.com/150',
      location: const GeoLocation(
        latitude: 35.658034,
        longitude: 139.751599,
      ),
      items: MockShopItemRepository()
          .shopItems
          .where((item) => item.shopId == '3')
          .toList(),
    ),
    ShopInfo(
      id: '4',
      name: 'ショップ D',
      address: '東京都世田谷区a-a-a',
      imageUrl: 'https://via.placeholder.com/150',
      location: const GeoLocation(
        latitude: 35.646096,
        longitude: 139.65627,
      ),
      items: MockShopItemRepository()
          .shopItems
          .where((item) => item.shopId == '4')
          .toList(),
    ),
    ShopInfo(
      id: '5',
      name: 'ショップ E',
      address: '東京都台東区b-b-b',
      imageUrl: 'https://via.placeholder.com/150',
      location: const GeoLocation(
        latitude: 35.712608,
        longitude: 139.780162,
      ),
      items: MockShopItemRepository()
          .shopItems
          .where((item) => item.shopId == '5')
          .toList(),
    ),
    ShopInfo(
      id: '6',
      name: 'ショップ F',
      address: '東京都文京区c-c-c',
      imageUrl: 'https://via.placeholder.com/150',
      location: const GeoLocation(
        latitude: 35.707398,
        longitude: 139.752733,
      ),
      items: MockShopItemRepository()
          .shopItems
          .where((item) => item.shopId == '6')
          .toList(),
    ),
  ];

  @override
  Future<void> add(ShopInfo shopInfo) {
    return Future.delayed(const Duration(seconds: 1), () {
      shopInfos.add(shopInfo);
    });
  }

  @override
  Future<void> delete(ShopInfo shopInfo) {
    return Future.delayed(const Duration(seconds: 1), () {
      shopInfos.removeWhere((item) => item.id == shopInfo.id);
    });
  }

  @override
  Future<List<ShopInfo>> fetchAll() {
    return Future.delayed(const Duration(seconds: 1), () => shopInfos);
  }

  @override
  Future<ShopInfo> fetchById(String id) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => shopInfos.firstWhere((shopInfo) => shopInfo.id == id),
    );
  }

  @override
  Future<void> update(ShopInfo shopInfo) {
    return Future.delayed(const Duration(seconds: 1), () {
      final index = shopInfos.indexWhere((item) => item.id == shopInfo.id);
      shopInfos[index] = shopInfo;
    });
  }
}
