import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:retail_dx/domain/geo_location.dart';
import 'package:retail_dx/domain/shop_info.dart';
import 'package:retail_dx/domain/shop_item.dart';
import 'package:retail_dx/presentation/google_maps/retail_dx/maps_view_dx_page.dart';

import '../../../application/google_maps/search_route_usecase.dart';

class StoreListTile extends ConsumerWidget {
  final (ShopInfo, ShopItem) shopItemFusion;
  final LatLng currentLocation;

  const StoreListTile({
    Key? key,
    required this.shopItemFusion,
    required this.currentLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopInfo = shopItemFusion.$1;
    final shopItem = shopItemFusion.$2;
    final distance = shopInfo.location.distance(GeoLocation(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    ));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 在庫情報アイコン
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: shopItem.quantity == 1 ? Colors.orange : Colors.green,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              shopItem.quantity == 1
                  ? 'only\n1 left'
                  : '${shopItem.quantity}+ in\n stock',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(shopInfo.name),
                Text(shopInfo.address, softWrap: true),
              ],
            ),
          ),
          Flexible(child: Text('$distance km away')),
          const Flexible(child: Icon(Icons.umbrella)),
          OutlinedButton(
            onPressed: () async {
              final routeDetails =
                  await ref.read(searchRouteUsecaseProvider).execute(
                        startLocation: currentLocation,
                        endLocation: LatLng(
                          shopInfo.location.latitude,
                          shopInfo.location.longitude,
                        ),
                      );
              ref
                  .read(polyLinePointsStateProvider.notifier)
                  .update((_) => routeDetails.routePoints);
              ref.read(isShowListStateProvider.notifier).update((_) => false);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.orange,
              side: const BorderSide(color: Colors.orange, width: 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text(
              'Curbside pickup',
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
