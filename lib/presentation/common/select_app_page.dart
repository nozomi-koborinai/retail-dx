import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retail_dx/domain/repository/shop_item_repository.dart';
import 'package:retail_dx/infrastructure/firebase/mock/mock_shop_item_repository.dart';
import 'package:retail_dx/presentation/google_maps/maps_view_page.dart';

import '../google_maps/maps_view_dx_page.dart';

class SelectAppPage extends ConsumerWidget {
  const SelectAppPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const MapsViewPage();
                  },
                ),
              );
            },
            child: const Text('リテールテック JAPAN 2024'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ItemMapPage(
                        // todo:現在はデモ用に仮で id を指定している
                        // また、デモ用なので Interface の実態が Mock であることは確定している
                        item: (ref.read(shopItemRepositoryProvider)
                                as MockShopItemRepository)
                            .shopItems
                            .firstWhere((element) => element.id == '5'),
                      );
                    },
                  ),
                );
              },
              child: const Text('リテール DX'),
            ),
          ),
        ],
      ),
    );
  }
}
