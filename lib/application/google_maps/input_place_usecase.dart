import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/google_maps/predictions.dart';
import '../../infrastructure/google_maps/places_repository.dart';
import '../common/mixin/run_usecase_mixin.dart';

/// [InputPlaceUsecase] のインスタンスを提供する [Provider]
///
/// Presentation Layer にユースケースを注入するために使用される
final inputPlaceUsecaseProvider = Provider<InputPlaceUsecase>(
  InputPlaceUsecase.new,
);

/// 住所検索欄に入力した内容から住所を予測する Usecase クラス
class InputPlaceUsecase with RunUsecaseMixin {
  InputPlaceUsecase(this.ref);

  /// 指定された [Ref] を使用して [InputPlaceUsecase] を構築する
  ///
  /// [Ref] は必要な [Provider] を読み取るために使用される
  final Ref ref;

  /// 住所検索欄に入力した内容から住所を予測する
  Future<List<Prediction>> execute({
    required String place,
  }) async {
    return await run(
      ref,
      isExecuteLoading: false,
      () async {
        return await ref.read(placesRepositoryProvider).fetch(input: place);
      },
    );
  }
}
