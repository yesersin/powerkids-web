// To parse this JSON data, do
//
//     final modelAnket = modelAnketFromJson(jsonString);

import 'dart:convert';

ModelAnket modelAnketFromJson(String str) => ModelAnket.fromJson(json.decode(str));

String modelAnketToJson(ModelAnket data) => json.encode(data.toJson());

class ModelAnket {
  ModelAnket({
    required this.success,
    required this.data,
  });

  int success;
  List<AnketData> data;

  factory ModelAnket.fromJson(Map<String, dynamic> json) => ModelAnket(
        success: json["success"],
        data: List<AnketData>.from(json["data"].map((x) => AnketData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AnketData {
  AnketData({
    required this.id,
    required this.okulId,
    required this.bir,
    required this.iki,
    required this.uc,
    required this.dort,
    required this.dil,
    required this.puan,
    required this.durum,
    required this.zaman,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String okulId;
  String bir;
  String iki;
  String uc;
  String dort;
  String dil;
  bool puan;
  bool durum;
  DateTime zaman;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory AnketData.fromJson(Map<String, dynamic> json) => AnketData(
        id: json["_id"],
        okulId: json["okulId"],
        bir: json["bir"],
        iki: json["iki"],
        uc: json["uc"],
        dort: json["dort"],
        dil: json["dil"],
        puan: json["puan"],
        durum: json["durum"],
        zaman: DateTime.parse(json["zaman"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "bir": bir,
        "iki": iki,
        "uc": uc,
        "dort": dort,
        "dil": dil,
        "puan": puan,
        "durum": durum,
        "zaman": zaman.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
