import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retail_dx/domain/weather/weather.dart';

import '../../domain/app_exception.dart';
import '../../domain/env.dart';

/// [WeatherRepository] のインスタンスを提供する [Provider]
final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => WeatherRepository(
    apiKey: ref.read(envProvider).googleMapsApiKey,
  ),
);

/// 天気データを提供する Repository
class WeatherRepository {
  WeatherRepository({
    required this.apiKey,
  });

  final String apiKey;
  final callable = FirebaseFunctions.instanceFor(region: 'asia-northeast1')
      .httpsCallable('sendPostRequest');

  Future<Weather> fetch() async {
    try {
      final HttpsCallableResult result = await callable.call(
        {
          'url':
              'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=Japan&aqi=yes',
        },
      );
      return Weather.fromJson(result.data);
    } catch (e) {
      throw AppException('Failed to load predictions: $e');
    }
  }
}
