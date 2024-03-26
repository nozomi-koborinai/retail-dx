import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ItemMapPage(item: item);
                    },
                  ),
                );
              },
              child: const Text('取り扱い店舗'),
            )
          ],
        ),
      ),
    );
  }
}

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _createGoogleMaps(),
    );
  }

  // Widget _createWideScreenBody() {
  //   return Stack(
  //     children: [
  //       _createGoogleMaps(isWideScreen: true),
  //       Positioned(
  //         top: 0,
  //         bottom: 0,
  //         left: 0,
  //         width: 800,
  //         child: Column(
  //           children: [
  //             _createSidePanel(),
  //             const SideDetailPanel(),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _createGoogleMaps() {
    return GoogleMap(
      // markers: {
      //   Marker(
      //     infoWindow: InfoWindow(
      //       title: ref.watch(selectedPlaceProvider)?.name,
      //     ),
      //     markerId: const MarkerId('selectedPlace'),
      //     position: LatLng(
      //       selectedPlace?.latitude ?? -1,
      //       selectedPlace?.longitude ?? -1,
      //     ),
      //     icon: BitmapDescriptor.defaultMarkerWithHue(
      //       BitmapDescriptor.hueAzure,
      //     ),
      //   ),
      // },
      // polylines: {
      //   Polyline(
      //     polylineId: const PolylineId('route'),
      //     color: Colors.pinkAccent,
      //     width: 4,
      //     points: ref.watch(_routesProvider),
      //   ),
      // },
      minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: (controller) async {
        mapController.complete(controller);
        // final value =
        //     await rootBundle.loadString('assets/maps/maps_style.json');
        // final futureController = await mapController.future;
        // await futureController.setMapStyle(value);
      },
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: ref.read(currentMapPositionProvider),
        zoom: 13.0,
      ),
    );
  }
}
