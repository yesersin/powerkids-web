// To parse this JSON data, do
//
//     final modelOkulDurum = modelOkulDurumFromJson(jsonString);

import 'dart:convert';

ModelOkulDurum modelOkulDurumFromJson(String str) => ModelOkulDurum.fromJson(json.decode(str));

String modelOkulDurumToJson(ModelOkulDurum data) => json.encode(data.toJson());

class ModelOkulDurum {
  ModelOkulDurum({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelOkulDurum.fromJson(Map<String, dynamic> json) => ModelOkulDurum(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.durum,
  });

  String id;
  bool durum;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        durum: json["durum"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "durum": durum,
      };
}
