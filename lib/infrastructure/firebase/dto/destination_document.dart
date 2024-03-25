import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import '../../../domain/destination.dart';
import '../../../domain/postal_code_info.dart';

/// Firebase Firestore に保存される引越し先のドキュメントモデル
class DestinationDocument {
  DestinationDocument({
    required this.destinationId,
    required this.placeInfo,
    required this.output,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String destinationId;
  final String placeInfo;
  final String output;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory DestinationDocument.fromJson(
          String destinationId, Map<String, dynamic> json) =>
      DestinationDocument(
        destinationId: destinationId,
        placeInfo: json['placeInfo'] as String,
        output: json['output'] as String,
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        'placeInfo': placeInfo,
        'output': '',
        'safetyMetadata': {},
        'status': {},
        'createdAt': createdAt,
        'updatedAt': FieldValue.serverTimestamp(),
      };
}

/// [DestinationDocument] の拡張
extension DestinationDocumentEx on DestinationDocument {
  /// [DestinationDocument] -> [Destination]
  Destination toDestination() {
    // ここから HACK: Firestore から取得した JSON 文字列を加工しないように LLM のプロンプトを修正する必要がありそう
    String jsonString = output;
    jsonString = jsonString.trim();
    jsonString = jsonString.substring(7, jsonString.length - 4);
    // ここまで

    // JSON 文字列をデコードしてフロントで扱いやすくした PostalCodeInfo オブジェクトに変換
    final Map<String, dynamic> resultData = json.decode(jsonString);
    final postalCodeInfo = PostalCodeInfo.fromJson(resultData);
    return Destination(
      destinationId: destinationId,
      placeInfo: placeInfo,
      postalCodeInfo: postalCodeInfo,
      createdAt: createdAt,
    );
  }
}
