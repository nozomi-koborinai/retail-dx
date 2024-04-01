import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:retail_dx/application/shop/states/shop_items.dart';
import 'package:retail_dx/domain/shop_item.dart';
import 'package:retail_dx/presentation/components/async_value_handler.dart';
import 'package:retail_dx/presentation/components/loading.dart';

import '../../application/google_maps/states/current_map_position.dart';
import '../mixin/error_handler_mixin.dart';

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
              return _ProductCard(item: items[index]);
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

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.item,
  });
  final ShopItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ItemDetailPage(item: item);
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://picsum.photos/200/300'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '¥${item.price}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

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
                ? Dialog(
                    child: PointerInterceptor(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Image.network(
                                    widget.item
                                        .imageUrl, // Replace with your item's image URL
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 120,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Pickup today',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter your postcode',
                                      suffixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),
                            Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: shopItemFusions
                                  .length, // Replace with your actual store list count
                              itemBuilder: (BuildContext context, int index) {
                                // Replace with your actual data model
                                final shop = shopItemFusions[index];
                                return ListTile(
                                  title: Text(shop.$1.name),
                                  // subtitle: Text(
                                  //   '${shop.distance} mi - ${shop.time} min',
                                  // ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      // Handle your curbside pickup logic here
                                    },
                                    child: Text('Curbside pickup'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : PointerInterceptor(
                    child: Positioned(
                      top: 35,
                      bottom: 0,
                      left: 35,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Image.network(
                              widget.item.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.item.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () => ref
                                      .read(isShowListStateProvider.notifier)
                                      .update((_) => true),
                                  child: Text('Show list'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // Button color
                                    onPrimary: Colors.white, // Text color
                                  ),
                                ),
                                // Here you can add more UI elements as needed
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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
