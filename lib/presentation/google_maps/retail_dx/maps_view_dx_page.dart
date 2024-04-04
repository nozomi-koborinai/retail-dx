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

final polyLinePointsStateProvider = StateProvider<List<LatLng>>((_) => []);

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
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('route'),
                    points: ref.watch(polyLinePointsStateProvider),
                    width: 3,
                    color: Colors.orange,
                    patterns: [PatternItem.dash(20), PatternItem.gap(10)],
                  )
                },
                minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                onMapCreated: (controller) async {
                  mapController.complete(controller);
                  // controller.showMarkerInfoWindow(markerId)
                  final value = await rootBundle
                      .loadString('assets/maps/maps_style.json');
                  final futureController = await mapController.future;
                  await futureController.setMapStyle(value);
                },
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: ref.read(currentMapPositionProvider),
                  zoom: 12.5,
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
}
