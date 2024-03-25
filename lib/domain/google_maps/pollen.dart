/// Pollen API のレスポンス
/// https://developers.google.com/maps/documentation/pollen/forecast?hl=ja&_gl=1*1nxehbd*_up*MQ..*_ga*MTY0MTgyNDYwMi4xNzA4OTM2NzU0*_ga_NRWSTWS78N*MTcwODkzNjc1My4xLjAuMTcwODkzNjc1My4wLjAuMA..
class Pollen {
  final String regionCode;
  final List<DailyInfo> dailyInfo;

  Pollen({
    required this.regionCode,
    required this.dailyInfo,
  });

  factory Pollen.fromJson(Map<String, dynamic> json) {
    return Pollen(
      regionCode: json['regionCode'] ?? '',
      dailyInfo: json['dailyInfo'] != null
          ? List<DailyInfo>.from(
              json['dailyInfo'].map((x) => DailyInfo.fromJson(x)))
          : [],
    );
  }
}

class DailyInfo {
  final Date date;
  final List<PollenTypeInfo> pollenTypeInfo;
  final List<PlantInfo> plantInfo;

  DailyInfo({
    required this.date,
    required this.pollenTypeInfo,
    required this.plantInfo,
  });

  factory DailyInfo.fromJson(Map<String, dynamic> json) {
    return DailyInfo(
      date: Date.fromJson(json['date'] ?? {}),
      pollenTypeInfo: json['pollenTypeInfo'] != null
          ? List<PollenTypeInfo>.from(
              json['pollenTypeInfo'].map((x) => PollenTypeInfo.fromJson(x)))
          : [],
      plantInfo: json['plantInfo'] != null
          ? List<PlantInfo>.from(
              json['plantInfo'].map((x) => PlantInfo.fromJson(x)))
          : [],
    );
  }
}

class Date {
  final int year;
  final int month;
  final int day;

  Date({
    required this.year,
    required this.month,
    required this.day,
  });

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      day: json['day'] ?? 0,
    );
  }
}

class PollenTypeInfo {
  final String code;
  final String displayName;
  final bool inSeason;
  final IndexInfo indexInfo;
  final List<String> healthRecommendations;

  PollenTypeInfo({
    required this.code,
    required this.displayName,
    required this.inSeason,
    required this.indexInfo,
    required this.healthRecommendations,
  });

  factory PollenTypeInfo.fromJson(Map<String, dynamic> json) {
    return PollenTypeInfo(
      code: json['code'] ?? '',
      displayName: json['displayName'] ?? '',
      inSeason: json['inSeason'] ?? false,
      indexInfo: IndexInfo.fromJson(json['indexInfo'] ?? {}),
      healthRecommendations: json['healthRecommendations'] != null
          ? List<String>.from(json['healthRecommendations'])
          : [],
    );
  }
}

class IndexInfo {
  final String code;
  final String displayName;
  final int value;
  final String category;
  final String indexDescription;
  final Color color;

  IndexInfo({
    required this.code,
    required this.displayName,
    required this.value,
    required this.category,
    required this.indexDescription,
    required this.color,
  });

  factory IndexInfo.fromJson(Map<String, dynamic> json) {
    return IndexInfo(
      code: json['code'] ?? '',
      displayName: json['displayName'] ?? '',
      value: json['value'] ?? 0,
      category: json['category'] ?? '',
      indexDescription: json['indexDescription'] ?? '',
      color: Color.fromJson(json['color'] ?? {}),
    );
  }
}

class Color {
  final double red;
  final double green;
  final double blue;

  Color({
    required this.red,
    required this.green,
    required this.blue,
  });

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      red: json['red'] ?? 0.0,
      green: json['green'] ?? 0.0,
      blue: json['blue'] ?? 0.0,
    );
  }
}

class PlantInfo {
  final String code;
  final String displayName;
  final bool inSeason;
  final IndexInfo indexInfo;
  final PlantDescription plantDescription;

  PlantInfo({
    required this.code,
    required this.displayName,
    required this.inSeason,
    required this.indexInfo,
    required this.plantDescription,
  });

  factory PlantInfo.fromJson(Map<String, dynamic> json) {
    return PlantInfo(
      code: json['code'] ?? '',
      displayName: json['displayName'] ?? '',
      inSeason: json['inSeason'] ?? false,
      indexInfo: IndexInfo.fromJson(json['indexInfo'] ?? {}),
      plantDescription:
          PlantDescription.fromJson(json['plantDescription'] ?? {}),
    );
  }
}

class PlantDescription {
  final String type;
  final String family;
  final String season;
  final String specialColors;
  final String specialShapes;
  final String crossReaction;
  final String picture;
  final String pictureCloseup;

  PlantDescription({
    required this.type,
    required this.family,
    required this.season,
    required this.specialColors,
    required this.specialShapes,
    required this.crossReaction,
    required this.picture,
    required this.pictureCloseup,
  });

  factory PlantDescription.fromJson(Map<String, dynamic> json) {
    return PlantDescription(
      type: json['type'] ?? '',
      family: json['family'] ?? '',
      season: json['season'] ?? '',
      specialColors: json['specialColors'] ?? '',
      specialShapes: json['specialShapes'] ?? '',
      crossReaction: json['crossReaction'] ?? '',
      picture: json['picture'] ?? '',
      pictureCloseup: json['pictureCloseup'] ?? '',
    );
  }
}
