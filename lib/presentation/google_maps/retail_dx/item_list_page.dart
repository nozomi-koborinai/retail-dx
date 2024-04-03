import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/shop/states/shop_items.dart';
import '../../components/async_value_handler.dart';
import '../../components/loading.dart';
import '../components/product_card.dart';

class ItemListPage extends ConsumerWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsyncValue = ref.watch(shopItemsProvider);
    return AsyncValueHandler(
      value: itemsAsyncValue,
      builder: (items) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Item List'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              )
            ],
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ProductCard(item: items[index]);
            },
          ),
        );
      },
      loading: () => const OverlayLoading(),
      error: (p0, p1) => Center(
        child: Text('error: ${p0.toString()}'),
      ),
    );
  }
}
