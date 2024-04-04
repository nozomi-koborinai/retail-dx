import 'package:flutter/material.dart';

import '../../../domain/shop_item.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({super.key, required this.item});
  final ShopItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) {
                //       // todo: デモでは使わない
                //       return const ItemMapPage(items: []);
                //     },
                //   ),
                // );
              },
              child: const Text('取り扱い店舗'),
            )
          ],
        ),
      ),
    );
  }
}
