import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retail_dx/domain/postal_code_info.dart';

part 'destination.freezed.dart';

/// 引越し先のクライアントモデル
@freezed
class Destination with _$Destination {
  const factory Destination({
    /// 引越し先ドキュメント ID
    required String destinationId,

    /// 住所情報
    required String placeInfo,

    /// 住所詳細情報
    required PostalCodeInfo postalCodeInfo,

    /// 生成日時
    required DateTime createdAt,
  }) = _Destination;
}
