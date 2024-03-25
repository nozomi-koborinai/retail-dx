import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 現在の地図の位置情報を提供する [StateProvider]
final currentMapPositionProvider = StateProvider<LatLng>(
  (_) => throw UnimplementedError('Provider was not initialized'),
);
