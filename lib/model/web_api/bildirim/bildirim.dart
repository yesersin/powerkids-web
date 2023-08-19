// To parse this JSON data, do
//
//     final modelBildirim = modelBildirimFromJson(jsonString);

import 'dart:convert';

ModelBildirim modelBildirimFromJson(String str) => ModelBildirim.fromJson(json.decode(str));

String modelBildirimToJson(ModelBildirim data) => json.encode(data.toJson());

class ModelBildirim {
  ModelBildirim({
    required this.success,
    required this.data,
  });

  int success;
  List<BildirimData> data;

  factory ModelBildirim.fromJson(Map<String, dynamic> json) => ModelBildirim(
        success: json["success"],
        data: List<BildirimData>.from(json["data"].map((x) => BildirimData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BildirimData {
  BildirimData({
    required this.id,
    required this.okulId,
    required this.zaman,
    required this.gonderenId,
    required this.alanId,
    required this.alanNotificationId,
    required this.mesaj,
    required this.tip,
    required this.secenek,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String okulId;
  DateTime zaman;
  String gonderenId;
  String alanId;
  String alanNotificationId;
  String mesaj;
  int tip;
  String secenek;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory BildirimData.fromJson(Map<String, dynamic> json) => BildirimData(
        id: json["_id"],
        okulId: json["okulId"],
        zaman: DateTime.parse(json["zaman"]),
        gonderenId: json["gonderenId"],
        alanId: json["alanId"],
        alanNotificationId: json["alanNotificationId"],
        mesaj: json["mesaj"],
        tip: json["tip"],
        secenek: json["secenek"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "zaman": zaman.toIso8601String(),
        "gonderenId": gonderenId,
        "alanId": alanId,
        "alanNotificationId": alanNotificationId,
        "mesaj": mesaj,
        "tip": tip,
        "secenek": secenek,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
