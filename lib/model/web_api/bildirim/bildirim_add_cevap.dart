// To parse this JSON data, do
//
//     final modelBildirimAddCevap = modelBildirimAddCevapFromJson(jsonString);

import 'dart:convert';

ModelBildirimAddCevap modelBildirimAddCevapFromJson(String str) =>
    ModelBildirimAddCevap.fromJson(json.decode(str));

String modelBildirimAddCevapToJson(ModelBildirimAddCevap data) => json.encode(data.toJson());

class ModelBildirimAddCevap {
  ModelBildirimAddCevap({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelBildirimAddCevap.fromJson(Map<String, dynamic> json) => ModelBildirimAddCevap(
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
    required this.okulId,
    required this.zaman,
    required this.gonderenId,
    required this.alanId,
    required this.alanNotificationId,
    required this.mesaj,
    required this.tip,
    required this.secenek,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String okulId;
  DateTime zaman;
  String gonderenId;
  String alanId;
  String alanNotificationId;
  String mesaj;
  int tip;
  String secenek;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        okulId: json["okulId"],
        zaman: DateTime.parse(json["zaman"]),
        gonderenId: json["gonderenId"],
        alanId: json["alanId"],
        alanNotificationId: json["alanNotificationId"],
        mesaj: json["mesaj"],
        tip: json["tip"],
        secenek: json["secenek"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "okulId": okulId,
        "zaman": zaman.toIso8601String(),
        "gonderenId": gonderenId,
        "alanId": alanId,
        "alanNotificationId": alanNotificationId,
        "mesaj": mesaj,
        "tip": tip,
        "secenek": secenek,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
