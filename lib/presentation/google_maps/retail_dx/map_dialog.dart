// MapDialog.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:retail_dx/presentation/google_maps/retail_dx/store_list_tile.dart';

import '../../../application/google_maps/states/current_map_position.dart';
import '../../../domain/shop_info.dart';
import '../../../domain/shop_item.dart';

class MapDialog extends ConsumerWidget {
  const MapDialog(
      {super.key, required this.imageUrl, required this.shopItemFusions});
  final String imageUrl;
  final List<(ShopInfo, ShopItem)> shopItemFusions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.5,
        child: PointerInterceptor(
          child: SingleChildScrollView(
            child: Row(
              children: [
                Container(
                  width: 120.0,
                  height: 120.0,
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   'Pickup today',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 20,
                        //   ),
                        // ),
                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //     hintText: 'Enter your postcode',
                        //     suffixIcon: Icon(Icons.search),
                        //     border: OutlineInputBorder(),
                        //     contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        //   ),
                        // ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: shopItemFusions.length,
                          itemBuilder: (context, index) {
                            final shopItemFusion = shopItemFusions[index];
                            if (shopItemFusion.$2.quantity == 0)
                              return const SizedBox();
                            return StoreListTile(
                              shopItemFusion: shopItemFusion,
                              currentLocation: ref.read(
                                currentMapPositionProvider,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
