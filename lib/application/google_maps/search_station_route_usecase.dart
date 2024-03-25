import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:retail_dx/application/google_maps/states/current_map_position.dart';
import 'package:retail_dx/application/google_maps/states/selected_place.dart';

import '../../domain/google_maps/place_detail.dart';
import '../../domain/google_maps/route_detail.dart';
import '../../infrastructure/google_maps/places_repository.dart';
import '../../infrastructure/google_maps/routes_repository.dart';
import '../common/mixin/run_usecase_mixin.dart';

/// [SearchStationRouteUsecase] のインスタンスを提供する [Provider]
///
/// Presentation Layer にユースケースを注入するために使用される
final searchStationRouteUsecaseProvider = Provider<SearchStationRouteUsecase>(
  SearchStationRouteUsecase.new,
);

/// 指定された住所から最寄駅を検索し、経路情報を提供する Usecase クラス
class SearchStationRouteUsecase with RunUsecaseMixin {
  SearchStationRouteUsecase(this.ref);

  /// 指定された [Ref] を使用して [SearchStationRouteUsecase] を構築する
  ///
  /// [Ref] は必要な [Provider] を読み取るために使用される
  final Ref ref;

  /// 指定された住所から最寄駅を検索し、経路情報を提供する
  Future<(PlaceDetail, Map<String, RouteDetail>, PlaceDetail)> execute({
    required String placeId,
  }) async {
    return await run(
      ref,
      isLottieAnimation: true,
      () async {
        // 指定住所から緯度経度を取得する
        final placeDetail =
            await ref.read(placesRepositoryProvider).fetchDetail(
                  placeId: placeId,
                );
        ref.read(selectedPlaceProvider.notifier).update((_) => placeDetail);
        ref.read(currentMapPositionProvider.notifier).update((_) => LatLng(
              placeDetail.latitude,
              placeDetail.longitude,
            ));

        // 指定住所からの最寄駅を検索する
        final nearestStations =
            await ref.read(placesRepositoryProvider).fetchNearestStations(
                  latitude: placeDetail.latitude,
                  longitude: placeDetail.longitude,
                );

        // 最寄駅までの経路情報を取得する
        final routeDetails =
            await ref.read(routesRepositoryProvider).fetchAllRoutes(
                  startLatitude: placeDetail.latitude,
                  startLongitude: placeDetail.longitude,
                  endLatitude: nearestStations.first.latitude,
                  endLongitude: nearestStations.first.longitude,
                );

        return (placeDetail, routeDetails, nearestStations.first);
      },
    );
  }
}
