import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/app_exception.dart';
import '../../domain/env.dart';
import '../../domain/google_maps/air_quality.dart';

/// [AirQualityRepository] のインスタンスを提供する [Provider]
final airQualityRepositoryProvider = Provider<AirQualityRepository>(
  (ref) => AirQualityRepository(
    apiKey: ref.read(envProvider).googleMapsApiKey,
  ),
);

/// 大気質データを提供する Repository
class AirQualityRepository {
  AirQualityRepository({
    required this.apiKey,
  });

  final String apiKey;
  final callable = FirebaseFunctions.instanceFor(region: 'asia-northeast1')
      .httpsCallable('sendPostRequest');

  Future<AirQuality> fetch({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final HttpsCallableResult result = await callable.call(
        {
          'url':
              'https://airquality.googleapis.com/v1/currentConditions:lookup?key=$apiKey',
          'postData': {
            'location': {
              'latitude': latitude,
              'longitude': longitude,
            },
            'languageCode': 'ja',
          },
        },
      );
      return AirQuality.fromJson(result.data);
    } catch (e) {
      throw AppException('Failed to load predictions: $e');
    }
  }
}
