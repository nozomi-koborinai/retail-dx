import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/geo_location.dart';

/// 日時コンバーター
class TimestampConverter implements JsonConverter<DateTime, Object> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object fieldValue) {
    return (fieldValue as Timestamp).toDate();
  }

  @override
  Object toJson(DateTime dateTime) {
    return FieldValue.serverTimestamp();
  }
}

/// 緯度経度コンバーター
class GeoPointConverter implements JsonConverter<GeoLocation, Object> {
  const GeoPointConverter();

  @override
  GeoLocation fromJson(Object fieldValue) {
    return (fieldValue as GeoPoint).toGeoLocation();
  }

  @override
  Object toJson(GeoLocation geoLocation) {
    return GeoPoint(geoLocation.latitude, geoLocation.longitude);
  }
}

extension _GeoPointEx on GeoPoint {
  /// GeoPoint => GeoLocation
  GeoLocation toGeoLocation() => GeoLocation(
        latitude: latitude,
        longitude: longitude,
      );
}
