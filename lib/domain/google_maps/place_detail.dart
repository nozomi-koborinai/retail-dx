class PlaceDetail {
  final String name;
  final String formattedAddress;
  final String phoneNumber;
  final String internationalPhoneNumber;
  final String website;
  final double latitude;
  final double longitude;
  final String icon;
  final List<String> types;
  final double? rating;
  final int? userRatingsTotal;

  PlaceDetail({
    required this.name,
    required this.formattedAddress,
    required this.phoneNumber,
    required this.internationalPhoneNumber,
    required this.website,
    required this.latitude,
    required this.longitude,
    required this.icon,
    required this.types,
    this.rating,
    this.userRatingsTotal,
  });

  factory PlaceDetail.fromJson(Map<String, dynamic> json) {
    final geometry = json['geometry'];
    final location = geometry['location'];
    return PlaceDetail(
      name: json['name'] ?? '',
      formattedAddress: json['formatted_address'] ?? '',
      phoneNumber: json['formatted_phone_number'] ?? '',
      internationalPhoneNumber: json['international_phone_number'] ?? '',
      website: json['website'] ?? '',
      latitude: location['lat'] ?? 0.0,
      longitude: location['lng'] ?? 0.0,
      icon: json['icon'] ?? '',
      types: List<String>.from(json['types']),
      rating: json['rating']?.toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'formattedAddress': formattedAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
