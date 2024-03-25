import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/app_exception.dart';
import '../../domain/env.dart';
import '../../domain/google_maps/place_detail.dart';
import '../../domain/google_maps/predictions.dart';

/// [PlacesRepository] のインスタンスを提供する [Provider]
final placesRepositoryProvider = Provider<PlacesRepository>(
  (ref) => PlacesRepository(
    apiKey: ref.read(envProvider).googleMapsApiKey,
  ),
);

/// Places API とのやりとりを直接行う Repository
class PlacesRepository {
  PlacesRepository({
    required this.apiKey,
  });

  final String apiKey;
  final callable = FirebaseFunctions.instanceFor(region: 'asia-northeast1')
      .httpsCallable('sendGetRequest');

  Future<List<Prediction>> fetch({
    required String input,
  }) async {
    try {
      final HttpsCallableResult result = await callable.call(
        {
          'url':
              'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=ja&key=$apiKey',
        },
      );
      final jsonResponse = result.data;
      return (jsonResponse['predictions'] as List)
          .map((json) => Prediction.fromJson(json))
          .toList();
    } catch (e) {
      throw AppException('Failed to load predictions: $e');
    }
  }

  /// 指定された placeId から場所の詳細情報を取得する
  Future<PlaceDetail> fetchDetail({
    required String placeId,
  }) async {
    try {
      final HttpsCallableResult result = await callable.call(
        {
          'url':
              'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&language=ja&key=$apiKey',
        },
      );
      return PlaceDetail.fromJson(result.data['result']);
    } catch (e) {
      throw AppException('Failed to load predictions: $e');
    }
  }

  /// 指定された緯度と経度から最寄りの駅を検索する
  Future<List<PlaceDetail>> fetchNearestStations({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final HttpsCallableResult result = await callable.call(
        {
          'url':
              'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&type=train_station&rankby=distance&language=ja&key=$apiKey',
        },
      );
      final jsonResponse = result.data;
      final results = jsonResponse['results'] as List;
      return results.map((result) => PlaceDetail.fromJson(result)).toList();
    } catch (e) {
      throw AppException('Failed to load predictions: $e');
    }
  }
}
