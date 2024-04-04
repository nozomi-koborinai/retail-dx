import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/google_maps/route_detail.dart';
import '../../infrastructure/google_maps/routes_repository.dart';
import '../common/mixin/run_usecase_mixin.dart';

/// [SearchRouteUsecase] のインスタンスを提供する [Provider]
///
/// Presentation Layer にユースケースを注入するために使用される
final searchRouteUsecaseProvider = Provider<SearchRouteUsecase>(
  SearchRouteUsecase.new,
);

/// 指定された住所から最寄駅を検索し、経路情報を提供する Usecase クラス
class SearchRouteUsecase with RunUsecaseMixin {
  SearchRouteUsecase(this.ref);

  /// 指定された [Ref] を使用して [SearchRouteUsecase] を構築する
  ///
  /// [Ref] は必要な [Provider] を読み取るために使用される
  final Ref ref;

  /// 指定された場所の経路情報を取得する
  Future<RouteDetail> execute({
    required LatLng startLocation,
    required LatLng endLocation,
  }) async {
    return await run(
      ref,
      isLottieAnimation: true,
      () async {
        return await ref.read(routesRepositoryProvider).fetchRoute(
              startLatitude: startLocation.latitude,
              startLongitude: startLocation.longitude,
              endLatitude: endLocation.latitude,
              endLongitude: endLocation.longitude,
            );
      },
    );
  }
}
