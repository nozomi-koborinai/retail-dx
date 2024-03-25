import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/destination.dart';
import '../../domain/google_maps/air_quality.dart';
import '../../domain/google_maps/place_detail.dart';
import '../../domain/google_maps/pollen.dart';
import '../../domain/postal_code_info.dart';
import '../../infrastructure/firebase/destination_repository.dart';
import '../../infrastructure/google_maps/air_quality_repository.dart';
import '../../infrastructure/google_maps/pollen_repository.dart';
import '../common/mixin/run_usecase_mixin.dart';

/// [GetDestinationInfoUsecase] のインスタンスを提供する [Provider]
///
/// Presentation Layer にユースケースを注入するために使用され、引越し先情報を登録したのちに詳細を LLM によって取得する
final getDestinationInfoUsecaseProvider = Provider<GetDestinationInfoUsecase>(
  GetDestinationInfoUsecase.new,
);

/// 引越し先のデータを取得する Usecase クラス
class GetDestinationInfoUsecase with RunUsecaseMixin {
  GetDestinationInfoUsecase(this.ref);

  /// 指定された [Ref] を使用して [GetDestinationInfoUsecase] を構築する
  ///
  /// [Ref] は必要な [Provider] を読み取るために使用される
  final Ref ref;

  /// 引越し先情報から詳細情報を取得し、合わせて地図情報を取得する
  Future<(Destination, AirQuality, Pollen)> execute({
    required PlaceDetail place,
  }) async {
    return await run(
      ref,
      () async {
        final destination = await _getDestinationInfo(place);
        final airQuality = await _getMapInfo(
          place.latitude,
          place.longitude,
        );
        final pollen = await _getPollenInfo(
          place.latitude,
          place.longitude,
        );
        return (destination, airQuality, pollen);
      },
      isLottieAnimation: true,
    );
  }

  /// 引越し先郵便番号からその詳細情報を取得する
  Future<Destination> _getDestinationInfo(PlaceDetail place) async {
    final repository = ref.read(destinationRepositoryProvider);
    return await repository.fetch(await repository.add(Destination(
      destinationId: '',
      placeInfo: place.toJson().toString(),
      postalCodeInfo: PostalCodeInfo(
        area: '',
        realEstate: RealEstate(medianPrice: '', range: ''),
        rentalPrices: RentalPrices(aptAverage: ''),
        crimeRate: '',
        atmosphere: '',
        demographics: Demographics(ageGroup: ''),
        naturalDisasters: '',
        disasterPrevention: DisasterPrevention(geotechnicalInfo: ''),
      ),
      createdAt: DateTime.now(),
    )));
  }

  /// 座標から地図情報（大気質レベル）を取得する
  Future<AirQuality> _getMapInfo(double latitude, double longitude) async {
    return await ref.read(airQualityRepositoryProvider).fetch(
          latitude: latitude,
          longitude: longitude,
        );
  }

  /// 座標から地図情報（花粉飛散レベル）を取得する
  Future<Pollen> _getPollenInfo(double latitude, double longitude) async {
    return await ref.read(pollenRepositoryProvider).fetch(
          latitude: latitude,
          longitude: longitude,
        );
  }
}
