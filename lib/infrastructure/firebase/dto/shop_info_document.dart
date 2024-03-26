import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/geo_location.dart';
import '../../../domain/shop_info.dart';
import '../converter.dart';

part 'shop_info_document.freezed.dart';
part 'shop_info_document.g.dart';

@freezed
class ShopInfoDocument with _$ShopInfoDocument {
  const factory ShopInfoDocument({
    required String name,
    required String imageUrl,
    required String address,
    @GeoPointConverter() GeoLocation? location,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _ShopInfoDocument;

  const ShopInfoDocument._();

  factory ShopInfoDocument.fromJson(Map<String, dynamic> json) =>
      _$ShopInfoDocumentFromJson(json);

  /// ShopInfoDocument -> ShopInfo
  ShopInfo toShopInfo({required String id}) {
    return ShopInfo(
      id: id,
      name: name,
      address: address,
      imageUrl: imageUrl,
      location: location ?? const GeoLocation(),
    );
  }
}
