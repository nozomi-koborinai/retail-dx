import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 移動モードを示す列挙型
enum DirectionMode {
  walking,
  transit,
  driving,
}

class RouteDetail {
  final String? distance;
  final String? duration;
  final String? startAddress;
  final String? endAddress;
  final List<LatLng> routePoints;

  RouteDetail({
    this.distance,
    this.duration,
    this.startAddress,
    this.endAddress,
    required this.routePoints,
  });

  factory RouteDetail.fromJson(Map<String, dynamic> json) {
    var routePoints = <LatLng>[];
    if (json['routes'] != null && json['routes'].isNotEmpty) {
      final legs = json['routes'][0]['legs'][0];
      final steps = legs['steps'] as List;
      routePoints = steps
          .map((step) => LatLng(
                step['start_location']['lat'] ?? 0.0,
                step['start_location']['lng'] ?? 0.0,
              ))
          .toList();
    } else {
      return RouteDetail(routePoints: routePoints);
    }

    return RouteDetail(
      distance: json['routes']?[0]['legs'][0]['distance']['text'],
      duration: json['routes']?[0]['legs'][0]['duration']['text'],
      startAddress: json['routes']?[0]['legs'][0]['start_address'],
      endAddress: json['routes']?[0]['legs'][0]['end_address'],
      routePoints: routePoints,
    );
  }
}
