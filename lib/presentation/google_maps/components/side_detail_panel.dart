import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/destination.dart';
import '../../../domain/google_maps/air_quality.dart';
import '../../../domain/google_maps/place_detail.dart';
import '../../../domain/google_maps/pollen.dart';
import '../../../domain/google_maps/route_detail.dart';
import 'destination_info_panel.dart';

final sideDetailPanelProvider = StateProvider<
    (
      Destination,
      AirQuality,
      Pollen,
      RouteDetail,
      RouteDetail,
      RouteDetail,
      PlaceDetail,
    )?>(
  (_) => null,
);

class SideDetailPanel extends ConsumerWidget {
  const SideDetailPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(sideDetailPanelProvider);
    final destination = info?.$1;
    final airQuality = info?.$2;
    final pollen = info?.$3;
    final walkingRoute = info?.$4;
    final transitRoute = info?.$5;
    final drivingRoute = info?.$6;
    final nearLineStation = info?.$7;
    return info == null ||
            destination == null ||
            airQuality == null ||
            pollen == null ||
            walkingRoute == null ||
            transitRoute == null ||
            drivingRoute == null ||
            nearLineStation == null
        ? const SizedBox()
        : Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
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
            ),
          );
  }
}
