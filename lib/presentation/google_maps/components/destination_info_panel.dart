import 'package:flutter/material.dart';

import '../../../domain/destination.dart';
import '../../../domain/google_maps/air_quality.dart';
import '../../../domain/google_maps/place_detail.dart';
import '../../../domain/google_maps/pollen.dart';
import '../../../domain/google_maps/route_detail.dart';

class DestinationInfoPanel extends StatelessWidget {
  const DestinationInfoPanel({
    super.key,
    required this.destination,
    required this.airQuality,
    required this.pollen,
    required this.walkingRoute,
    required this.transitRoute,
    required this.drivingRoute,
    required this.nearLineStation,
  });

  final Destination destination;
  final AirQuality airQuality;
  final Pollen pollen;
  final RouteDetail walkingRoute;
  final RouteDetail transitRoute;
  final RouteDetail drivingRoute;
  final PlaceDetail nearLineStation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.air_sharp),
          title: Text('大気質レベル: ${airQuality.indexes[0].aqi}'),
          subtitle: Text('カテゴリ: ${airQuality.indexes[0].category}'),
        ),
        ListTile(
          leading: const Icon(Icons.grass),
          title: Text(
            '花粉飛散レベル: ${pollen.dailyInfo[0].plantInfo[0].indexInfo.category.isEmpty ? '指定の地域では花粉飛散量を取得することができません' : pollen.dailyInfo[0].plantInfo[0].indexInfo.category}',
          ),
          subtitle:
              Text('植物の種類: ${pollen.dailyInfo[0].plantInfo[0].displayName}'),
        ),
        ListTile(
          leading: const Icon(Icons.directions),
          title: Text(
              '最寄り駅 (${nearLineStation.name}) までの距離: ${walkingRoute.distance}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('徒歩での所要時間: ${walkingRoute.duration}'),
              if (transitRoute.duration != null)
                Text('電車での所要時間: ${transitRoute.duration}'),
              Text('車での所要時間: ${drivingRoute.duration}'),
            ],
          ),
        ),
        // ListTile(
        //   leading: const Icon(Icons.directions),
        //   title: const Text('最寄り駅までの距離'),
        //   subtitle: Text('徒歩での所要時間: 10分'),
        // ),
        // ListTile(
        //   leading: const Icon(Icons.directions_transit),
        //   title: const Text('最寄り駅までの距離'),
        //   subtitle: Text('電車での所要時間: 5分'),
        // ),
        // ListTile(
        //   leading: const Icon(Icons.directions_car),
        //   title: const Text('最寄り駅までの距離'),
        //   subtitle: Text('車での所要時間: 3分'),
        // ),
        ListTile(
          leading: const Icon(Icons.location_city),
          title: Text('エリア: ${destination.postalCodeInfo.area}'),
        ),
        ListTile(
          leading: const Icon(Icons.monetization_on),
          title: Text(
              '不動産中央価格: ${destination.postalCodeInfo.realEstate.medianPrice}'),
          subtitle:
              Text('価格範囲: ${destination.postalCodeInfo.realEstate.range}'),
        ),
        ListTile(
          leading: const Icon(Icons.local_offer),
          title: Text(
              '1Kアパート平均賃貸価格: ${destination.postalCodeInfo.rentalPrices.aptAverage}'),
        ),
        ListTile(
          leading: const Icon(Icons.policy_sharp),
          title: Text('犯罪発生率: ${destination.postalCodeInfo.crimeRate}'),
        ),
        ListTile(
          leading: const Icon(Icons.family_restroom),
          title: Text('街の雰囲気: ${destination.postalCodeInfo.atmosphere}'),
          subtitle:
              Text('年齢層:  ${destination.postalCodeInfo.demographics.ageGroup}'),
        ),
        ListTile(
          leading: const Icon(Icons.nature_sharp),
          title: Text(
              '天災の歴史: ${destination.postalCodeInfo.disasterPrevention.geotechnicalInfo}'),
          subtitle:
              Text('防災・地盤情報: ${destination.postalCodeInfo.naturalDisasters}'),
        ),
      ],
    );
  }
}
