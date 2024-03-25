import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/app_exception.dart';
import '../../domain/env.dart';
import '../../domain/google_maps/route_detail.dart';

/// [RoutesRepository] のインスタンスを提供する [Provider]
final routesRepositoryProvider = Provider<RoutesRepository>(
  (ref) => RoutesRepository(
    apiKey: ref.read(envProvider).googleMapsApiKey,
  ),
);

// Directions APIとのやりとりを行うRepository
class RoutesRepository {
  RoutesRepository({
    required this.apiKey,
  });

  final String apiKey;
  final callable = FirebaseFunctions.instanceFor(region: 'asia-northeast1')
      .httpsCallable('sendGetRequest');

  // 経路情報を取得するメソッド
  Future<RouteDetail> fetchRoute({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
    DirectionMode mode = DirectionMode.walking,
  }) async {
    try {
      final HttpsCallableResult result = await callable.call(
        {
          'url': 'https://maps.googleapis.com/maps/api/directions/json'
              '?origin=$startLatitude,$startLongitude'
              '&destination=$endLatitude,$endLongitude'
              '&mode=${mode.name}'
              '&language=ja'
              '&key=$apiKey',
        },
      );
      return RouteDetail.fromJson(result.data);
    } catch (e) {
      throw AppException('Failed to load route: $e');
    }
  }

  // 移動モードごとに経路情報を取得するメソッド
  Future<Map<String, RouteDetail>> fetchAllRoutes({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    final Map<String, RouteDetail> routeDetails = {};

    for (final mode in DirectionMode.values) {
      final routeDetail = await fetchRoute(
        startLatitude: startLatitude,
        startLongitude: startLongitude,
        endLatitude: endLatitude,
        endLongitude: endLongitude,
        mode: mode,
      );
      routeDetails[mode.name] = routeDetail;
    }

    return routeDetails;
  }
}
