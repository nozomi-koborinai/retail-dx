import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/app_exception.dart';
import '../../domain/env.dart';
import '../../domain/google_maps/pollen.dart';

/// [PollenRepository] のインスタンスを提供する [Provider]
final pollenRepositoryProvider = Provider<PollenRepository>(
  (ref) => PollenRepository(
    apiKey: ref.read(envProvider).googleMapsApiKey,
  ),
);

/// 花粉飛散情報を提供する Repository
class PollenRepository {
  PollenRepository({
    required this.apiKey,
  });

  final String apiKey;
  final callable = FirebaseFunctions.instanceFor(region: 'asia-northeast1')
      .httpsCallable('sendGetRequest');

  Future<Pollen> fetch({
    required double latitude,
    required double longitude,
    int days = 1,
    String languageCode = 'ja',
    bool plantsDescription = true,
  }) async {
    final queryParams = {
      'location.latitude': latitude.toString(),
      'location.longitude': longitude.toString(),
      'days': days.toString(),
      'languageCode': languageCode,
      'plantsDescription': plantsDescription.toString(),
    };
    try {
      final HttpsCallableResult result = await callable.call(
        {
          'url':
              'https://pollen.googleapis.com/v1/forecast:lookup?key=$apiKey&${Uri(queryParameters: queryParams).query}',
        },
      );
      return Pollen.fromJson(result.data);
    } catch (e) {
      throw AppException('Failed to load predictions: $e');
    }
  }
}
