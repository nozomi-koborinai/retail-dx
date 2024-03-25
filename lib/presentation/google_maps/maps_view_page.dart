// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
// import 'package:flutter/services.dart' show rootBundle;

import '../../application/google_maps/get_destination_info_usecase.dart';
import '../../application/google_maps/input_place_usecase.dart';
import '../../application/google_maps/search_station_route_usecase.dart';
import '../../application/google_maps/states/current_map_position.dart';
import '../../application/google_maps/states/selected_place.dart';
import '../../domain/destination.dart';
import '../../domain/google_maps/air_quality.dart';
import '../../domain/google_maps/place_detail.dart';
import '../../domain/google_maps/pollen.dart';
import '../../domain/google_maps/predictions.dart';
import '../../domain/google_maps/route_detail.dart';
import '../mixin/error_handler_mixin.dart';
import 'components/destination_info_panel.dart';
import 'components/prediction_list.dart';
import 'components/side_detail_panel.dart';

/// 経路情報を提供する [StateProvider]
final _routesProvider = StateProvider<List<LatLng>>((_) => []);

/// 住所検索欄に入力した内容から住所を予測した結果を管理する [StateProvider]
final predictionListProvider = StateProvider<List<Prediction>>((_) => []);

/// [MapsViewPage] のウィジェット
class MapsViewPage extends ConsumerStatefulWidget {
  const MapsViewPage({super.key});

  @override
  ConsumerState<MapsViewPage> createState() => _MapsViewPageState();
}

class _MapsViewPageState extends ConsumerState<MapsViewPage>
    with ErrorHandlerMixin {
  final Completer<GoogleMapController> mapController = Completer();
  Timer? _debounce;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    ref.listen(currentMapPositionProvider, (_, next) async {
      final controller = await mapController.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(next.latitude, next.longitude),
            zoom: 18.0,
          ),
        ),
      );
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isWideScreen
          ? null
          : AppBar(
              title: PointerInterceptor(
                child: _createSearchField(isWideScreen: isWideScreen),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
      body: isWideScreen ? _createWideScreenBody() : _createMobileBody(),
    );
  }

  Widget _createSearchField({required bool isWideScreen}) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white.withOpacity(0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Google マップを検索する',
          fillColor: Colors.white.withOpacity(0.9),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 20, right: 12),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        controller: _textController,
        onTap: () {
          _textController.clear();
          if (!isWideScreen) return;
          ref.read(sideDetailPanelProvider.notifier).update((_) => null);
        },
        onChanged: (value) {
          if (_debounce?.isActive ?? false) _debounce!.cancel();
          _debounce = Timer(const Duration(milliseconds: 300), () async {
            if (value.isEmpty) {
              ref.read(predictionListProvider.notifier).update((_) => []);
              return;
            }
            final places = await ref.read(inputPlaceUsecaseProvider).execute(
                  place: value,
                );
            ref.read(predictionListProvider.notifier).update((_) => places);
          });
        },
      ),
    );
  }

  Widget _createWideScreenBody() {
    return Stack(
      children: [
        _createGoogleMaps(isWideScreen: true),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width: 800,
          child: PointerInterceptor(
            child: Column(
              children: [
                _createSidePanel(),
                const SideDetailPanel(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _createMobileBody() {
    return Stack(
      children: [
        _createGoogleMaps(isWideScreen: false),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
          child: PointerInterceptor(
            child: PredictionList(
              predictions: ref.watch(predictionListProvider),
              onPredictionSelected: (prediction) async {
                run(context, action: () async {
                  // ① 選択した住所から最寄りの駅までの経路情報及び住所の詳細情報を取得する
                  final result = await onPredictionSelected(
                    prediction: prediction,
                  );
                  // ② LLM によって取得した情報をハーフモーダルで表示する
                  _showModalBottomSheet(context, result);
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  // ハーフモーダルを表示する関数
  void _showModalBottomSheet(
    BuildContext context,
    (
      Destination,
      AirQuality,
      Pollen,
      RouteDetail,
      RouteDetail,
      RouteDetail,
      PlaceDetail,
    ) info,
  ) {
    final destination = info.$1;
    final airQuality = info.$2;
    final pollen = info.$3;
    final walkingRoute = info.$4;
    final transitRoute = info.$5;
    final drivingRoute = info.$6;
    final nearLineStation = info.$7;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: PointerInterceptor(
            child: DestinationInfoPanel(
              destination: destination,
              airQuality: airQuality,
              pollen: pollen,
              walkingRoute: walkingRoute,
              transitRoute: transitRoute,
              drivingRoute: drivingRoute,
              nearLineStation: nearLineStation,
            ),
          ),
        );
      },
    );
  }

  Widget _createGoogleMaps({required bool isWideScreen}) {
    final selectedPlace = ref.watch(selectedPlaceProvider);
    return AbsorbPointer(
      child: GoogleMap(
        markers: {
          Marker(
            infoWindow: InfoWindow(
              title: ref.watch(selectedPlaceProvider)?.name,
            ),
            markerId: const MarkerId('selectedPlace'),
            position: LatLng(
              selectedPlace?.latitude ?? -1,
              selectedPlace?.longitude ?? -1,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
          ),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.pinkAccent,
            width: 4,
            points: ref.watch(_routesProvider),
          ),
        },
        minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
        myLocationEnabled: true,
        zoomControlsEnabled: isWideScreen,
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
          zoom: 16.0,
        ),
      ),
    );
  }

  Widget _createSidePanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.transparent,
      child: Column(
        children: [
          _createSearchField(isWideScreen: true),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: PredictionList(
              predictions: ref.watch(predictionListProvider),
              onPredictionSelected: (prediction) async {
                run(context, action: () async {
                  // ① 選択した住所から最寄りの駅までの経路情報及び住所の詳細情報を取得する
                  final result = await onPredictionSelected(
                    prediction: prediction,
                  );
                  // ② 詳細情報をサイドパネルに表示するために StateProvider を更新する
                  ref
                      .read(sideDetailPanelProvider.notifier)
                      .update((_) => result);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<
      (
        Destination,
        AirQuality,
        Pollen,
        RouteDetail,
        RouteDetail,
        RouteDetail,
        PlaceDetail,
      )> onPredictionSelected({
    required Prediction prediction,
  }) async {
    // 選択した住所から最寄りの駅までの経路情報を取得する
    ref.read(predictionListProvider.notifier).update((_) => []);
    _textController.text = prediction.description;
    final details = await ref
        .read(searchStationRouteUsecaseProvider)
        .execute(placeId: prediction.placeId);
    final nearLineStation = details.$3;
    final routeDetails = details.$2;
    final walkingRoute = routeDetails[DirectionMode.walking.name]!;
    final transitRoute = routeDetails[DirectionMode.transit.name]!;
    final drivingRoute = routeDetails[DirectionMode.driving.name]!;
    ref.read(_routesProvider.notifier).update((_) => walkingRoute.routePoints);

    // 選択した住所の詳細情報を LLM によって取得する
    final detailResult =
        await ref.read(getDestinationInfoUsecaseProvider).execute(
              place: details.$1,
            );
    return (
      detailResult.$1,
      detailResult.$2,
      detailResult.$3,
      walkingRoute,
      transitRoute,
      drivingRoute,
      nearLineStation,
    );
  }
}
