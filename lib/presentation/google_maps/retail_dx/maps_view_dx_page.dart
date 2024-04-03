import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:retail_dx/application/shop/states/shop_items.dart';
import 'package:retail_dx/domain/shop_item.dart';
import 'package:retail_dx/presentation/components/async_value_handler.dart';
import 'package:retail_dx/presentation/components/loading.dart';
import 'package:retail_dx/presentation/google_maps/retail_dx/map_dialog.dart';
import 'package:retail_dx/presentation/google_maps/retail_dx/side_panel.dart';

import '../../../application/google_maps/states/current_map_position.dart';
import '../../mixin/error_handler_mixin.dart';

final isShowListStateProvider = StateProvider<bool>((_) => false);

class ItemMapPage extends ConsumerStatefulWidget {
  const ItemMapPage({super.key, required this.item});
  final ShopItem item;

  @override
  ConsumerState<ItemMapPage> createState() => _ItemMapPageState();
}

class _ItemMapPageState extends ConsumerState<ItemMapPage>
    with ErrorHandlerMixin {
  final Completer<GoogleMapController> mapController = Completer();

  @override
  Widget build(BuildContext context) {
    final shopItemFusionsAsyncValue = ref.watch(
      shopItemFusionsProvider(widget.item.id),
    );

    ref.listen(currentMapPositionProvider, (_, next) async {
      final controller = await mapController.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(next.latitude, next.longitude),
            zoom: 13.0,
          ),
        ),
      );
    });

    return AsyncValueHandler(
      value: shopItemFusionsAsyncValue,
      builder: (shopItemFusions) {
        return Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: true,
              body: GoogleMap(
                onTap: (_) => ref.read(isShowListStateProvider.notifier).update(
                      (value) => false,
                    ),
                markers: shopItemFusions.map(
                  (shopItemFusion) {
                    final shopInfo = shopItemFusion.$1;
                    final shopItem = shopItemFusion.$2;
                    return Marker(
                      markerId: MarkerId(shopInfo.id),
                      position: LatLng(
                        shopInfo.location.latitude,
                        shopInfo.location.longitude,
                      ),
                      infoWindow: InfoWindow(
                        title: '在庫： ${shopItem.quantity.toString()}',
                      ),
                    );
                  },
                ).toSet(),
                // polylines: shopItemFusions.map(
                //   (shopItemFusion) {
                //     final shopInfo = shopItemFusion.$1;
                //     return Polyline(
                //       polylineId: PolylineId(shopInfo.id),
                //       color: Colors.orange,
                //       width: 4,
                //       points: [
                //         ref.read(currentMapPositionProvider),
                //         LatLng(
                //           shopInfo.location.latitude,
                //           shopInfo.location.longitude,
                //         ),
                //       ],
                //     );
                //   },
                // ).toSet(),
                minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                onMapCreated: (controller) async {
                  mapController.complete(controller);
                  final value = await rootBundle
                      .loadString('assets/maps/maps_style.json');
                  final futureController = await mapController.future;
                  await futureController.setMapStyle(value);
                },
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: ref.read(currentMapPositionProvider),
                  zoom: 13.0,
                ),
              ),
            ),
            ref.watch(isShowListStateProvider)
                ? MapDialog(
                    imageUrl: widget.item.imageUrl,
                    shopItemFusions: shopItemFusions,
                  )
                : SidePanel(item: widget.item)
          ],
        );
      },
      loading: () => const OverlayLoading(),
      error: (p0, p1) => Text(p0.toString()),
    );
  }

  void _showPickupDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                'アイテムの画像URL', // アイテムの画像URLを指定
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Pickup today',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 16),
                    // ここに店舗リストを表示するためのウィジェットを作成してください。
                    // 例えば、ListView.builderを使用してリストを作成します。
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: storeList.length, // 店舗情報のリストの長さ
                    //   itemBuilder: (context, index) {
                    //     final store = storeList[index];
                    //     return ListTile(
                    //       title: Text(store.name),
                    //       subtitle: Text('${store.distance} km - ${store.time} min'),
                    //       trailing: ElevatedButton(
                    //         onPressed: () {
                    //           // ピックアップ処理など
                    //         },
                    //         child: Text('Curbside pickup'),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
