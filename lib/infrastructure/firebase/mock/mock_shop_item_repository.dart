import 'package:retail_dx/domain/repository/shop_item_repository.dart';
import 'package:retail_dx/domain/shop_item.dart';

class MockShopItemRepository implements ShopItemRepository {
  // mock data
  final List<ShopItem> shopItems = [
    const ShopItem(
      id: 'bag_1',
      name: 'bag_1',
      price: 30000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      quantity: 4,
      shopId: '1',
    ),
    const ShopItem(
      id: 'bag_1',
      name: 'bag_1',
      price: 30000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      quantity: 2,
      shopId: '2',
    ),
    const ShopItem(
      id: 'bag_1',
      name: 'bag_1',
      price: 30000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      quantity: 0,
      shopId: '3',
    ),
    const ShopItem(
      id: 'bag_2',
      name: 'bag_2',
      price: 25000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-Ks5eq4QpSj0usZ7iQwdh9txuKp4z44m2bYn24sp7BlXaOkymF0Q0dZzXrO7rQPqI-9hRPb9Q2i0o6H3z0CIFm953foDgfq9O27TwMhWwusWN4ewsxrAcUqHAXHD_wz9tRpSxvFDa05k/s400/waist_bag.png',
      category: 'BAG',
      quantity: 3,
      shopId: '3',
    ),
    const ShopItem(
      id: 'bag_3',
      name: 'bag_3',
      price: 20000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      quantity: 2,
      shopId: '1',
    ),
    const ShopItem(
      id: 'bag_3',
      name: 'bag_3',
      price: 20000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      quantity: 2,
      shopId: '2',
    ),
    const ShopItem(
      id: 'bag_4',
      name: 'bag_4',
      price: 15000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-Ks5eq4QpSj0usZ7iQwdh9txuKp4z44m2bYn24sp7BlXaOkymF0Q0dZzXrO7rQPqI-9hRPb9Q2i0o6H3z0CIFm953foDgfq9O27TwMhWwusWN4ewsxrAcUqHAXHD_wz9tRpSxvFDa05k/s400/waist_bag.png',
      category: 'BAG',
      quantity: 2,
      shopId: '1',
    ),
    const ShopItem(
      id: 'bag_4',
      name: 'bag_4',
      price: 15000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-Ks5eq4QpSj0usZ7iQwdh9txuKp4z44m2bYn24sp7BlXaOkymF0Q0dZzXrO7rQPqI-9hRPb9Q2i0o6H3z0CIFm953foDgfq9O27TwMhWwusWN4ewsxrAcUqHAXHD_wz9tRpSxvFDa05k/s400/waist_bag.png',
      category: 'BAG',
      quantity: 2,
      shopId: '3',
    ),
    const ShopItem(
      id: 'bag_5',
      name: 'bag_5',
      quantity: 0,
      price: 10000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      shopId: '2',
    ),
    const ShopItem(
      id: 'bag_5',
      name: 'bag_5',
      quantity: 3,
      price: 10000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      shopId: '3',
    ),
    const ShopItem(
      id: 'bag_5',
      name: 'bag_5',
      quantity: 1,
      price: 10000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      shopId: '4',
    ),
    const ShopItem(
      id: 'bag_5',
      name: 'bag_5',
      quantity: 0,
      price: 10000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYAy3p6oNydqf_7d7fzgwuFGRG2ICXlW0gktqvjEALbl0I0UqFGNUPjPevLZRXTOqzVEQC2E_pWF3HqGAHP225fccnwIJEhGItYqj14h1Pvu8BsG-chGjJgt5fcWflLO2tEbf1lRvXn2g/s400/fashion_clutch_bag.png',
      category: 'BAG',
      shopId: '5',
    ),
    const ShopItem(
      id: 'bag_6',
      quantity: 12,
      name: 'bag_6',
      price: 5000,
      imageUrl:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-Ks5eq4QpSj0usZ7iQwdh9txuKp4z44m2bYn24sp7BlXaOkymF0Q0dZzXrO7rQPqI-9hRPb9Q2i0o6H3z0CIFm953foDgfq9O27TwMhWwusWN4ewsxrAcUqHAXHD_wz9tRpSxvFDa05k/s400/waist_bag.png',
      category: 'BAG',
      shopId: '1',
    ),
  ];

  @override
  Future<void> add(ShopItem shopItem) {
    return Future.delayed(const Duration(seconds: 1), () {
      shopItems.add(shopItem);
    });
  }

  @override
  Future<void> delete(ShopItem shopItem) {
    return Future.delayed(const Duration(seconds: 1), () {
      shopItems.removeWhere((item) => item.id == shopItem.id);
    });
  }

  @override
  Future<List<ShopItem>> fetchAll() {
    return Future.delayed(const Duration(seconds: 1), () => shopItems);
  }

  @override
  Future<List<ShopItem>> fetchById(String id) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => shopItems.where((shopItem) => shopItem.id == id).toList(),
    );
  }

  @override
  Future<List<ShopItem>> fetchByShopId(String shopId) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => shopItems.where((shopItem) => shopItem.shopId == shopId).toList(),
    );
  }

  @override
  Future<void> update(ShopItem shopItem) {
    return Future.delayed(const Duration(seconds: 1), () {
      final index = shopItems.indexWhere((item) => item.id == shopItem.id);
      shopItems[index] = shopItem;
    });
  }
}
