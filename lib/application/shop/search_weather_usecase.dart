import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retail_dx/domain/shop_info.dart';
import 'package:retail_dx/domain/weather/weather.dart';
import 'package:retail_dx/infrastructure/weather/weather_repository.dart';

import '../common/mixin/run_usecase_mixin.dart';

/// [SearchWeatherUsecase] のインスタンスを提供する [Provider]
///
/// Presentation Layer にユースケースを注入するために使用される
final searchWeatherRouteUsecaseProvider = Provider<SearchWeatherUsecase>(
  SearchWeatherUsecase.new,
);

/// 指定された住所の天気情報を検索するユースケース
class SearchWeatherUsecase with RunUsecaseMixin {
  SearchWeatherUsecase(this.ref);

  /// 指定された [Ref] を使用して [SearchWeatherUsecase] を構築する
  ///
  /// [Ref] は必要な [Provider] を読み取るために使用される
  final Ref ref;

  /// 指定された住所から天気情報を検索する
  Future<(ShopInfo, Weather)> execute({
    required ShopInfo shopInfo,
  }) async {
    return await run(
      ref,
      isLottieAnimation: true,
      () async {
        final weather = await ref.read(weatherRepositoryProvider).fetch(
              latitude: shopInfo.location.latitude,
              longitude: shopInfo.location.longitude,
            );

        return (shopInfo, weather);
      },
    );
  }
}
