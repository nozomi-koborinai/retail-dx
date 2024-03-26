import 'package:retail_dx/domain/repository/shop_item_repository.dart';
import 'package:retail_dx/domain/shop_item.dart';

class MockShopItemRepository implements ShopItemRepository {
  // mock data
  final List<ShopItem> _shopItems = [
    const ShopItem(
      id: '1',
      name: 'bag_1',
      price: 30000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      shopIds: ['1', '2', '3'],
    ),
    const ShopItem(
      id: '2',
      name: 'bag_2',
      price: 25000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-Ks5eq4QpSj0usZ7iQwdh9txuKp4z44m2bYn24sp7BlXaOkymF0Q0dZzXrO7rQPqI-9hRPb9Q2i0o6H3z0CIFm953foDgfq9O27TwMhWwusWN4ewsxrAcUqHAXHD_wz9tRpSxvFDa05k/s400/waist_bag.png',
      category: 'BAG',
      shopIds: ['3'],
    ),
    const ShopItem(
      id: '3',
      name: 'bag_3',
      price: 20000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      shopIds: ['1', '2'],
    ),
    const ShopItem(
      id: '4',
      name: 'bag_4',
      price: 15000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-Ks5eq4QpSj0usZ7iQwdh9txuKp4z44m2bYn24sp7BlXaOkymF0Q0dZzXrO7rQPqI-9hRPb9Q2i0o6H3z0CIFm953foDgfq9O27TwMhWwusWN4ewsxrAcUqHAXHD_wz9tRpSxvFDa05k/s400/waist_bag.png',
      category: 'BAG',
      shopIds: ['1', '3'],
    ),
    const ShopItem(
      id: '5',
      name: 'bag_5',
      price: 10000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      shopIds: ['2', '3'],
    ),
    const ShopItem(
      id: '6',
      name: 'bag_6',
      price: 5000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-Ks5eq4QpSj0usZ7iQwdh9txuKp4z44m2bYn24sp7BlXaOkymF0Q0dZzXrO7rQPqI-9hRPb9Q2i0o6H3z0CIFm953foDgfq9O27TwMhWwusWN4ewsxrAcUqHAXHD_wz9tRpSxvFDa05k/s400/waist_bag.png',
      category: 'BAG',
      shopIds: ['1'],
    ),
  ];

  @override
  Future<void> add(ShopItem shopItem) {
    return Future.delayed(const Duration(seconds: 1), () {
      _shopItems.add(shopItem);
    });
  }

  @override
  Future<void> delete(ShopItem shopItem) {
    return Future.delayed(const Duration(seconds: 1), () {
      _shopItems.removeWhere((item) => item.id == shopItem.id);
    });
  }

  @override
  Future<List<ShopItem>> fetchAll() {
    return Future.delayed(const Duration(seconds: 1), () => _shopItems);
  }

  @override
  Future<ShopItem> fetchById(String id) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _shopItems.firstWhere((shopItem) => shopItem.id == id),
    );
  }

  @override
  Future<void> update(ShopItem shopItem) {
    return Future.delayed(const Duration(seconds: 1), () {
      final index = _shopItems.indexWhere((item) => item.id == shopItem.id);
      _shopItems[index] = shopItem;
    });
  }
}
