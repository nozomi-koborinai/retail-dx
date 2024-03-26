import 'package:freezed_annotation/freezed_annotation.dart';
import 'geo_location.dart';

part 'shop_info.freezed.dart';

@freezed
class ShopInfo with _$ShopInfo {
  const factory ShopInfo({
    required String id,
    required String name,
    required String address,
    required String imageUrl,
    required GeoLocation location,
  }) = _ShopInfo;
}
