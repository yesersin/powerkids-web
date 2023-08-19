// To parse this JSON data, do
//
//     final modelOgrenciYoklamaUpCevap = modelOgrenciYoklamaUpCevapFromJson(jsonString);

import 'dart:convert';

ModelOgrenciYoklamaUpCevap modelOgrenciYoklamaUpCevapFromJson(String str) =>
    ModelOgrenciYoklamaUpCevap.fromJson(json.decode(str));

String modelOgrenciYoklamaUpCevapToJson(ModelOgrenciYoklamaUpCevap data) =>
    json.encode(data.toJson());

class ModelOgrenciYoklamaUpCevap {
  ModelOgrenciYoklamaUpCevap({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelOgrenciYoklamaUpCevap.fromJson(Map<String, dynamic> json) =>
      ModelOgrenciYoklamaUpCevap(
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
    required this.okulId,
    required this.sinifId,
    required this.yoklamaDurum,
    required this.ogretmenAdi,
    required this.ogretmenId,
    required this.ogrenciId,
    required this.zaman,
    required this.dil,
    required this.tip,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String okulId;
  String sinifId;
  String yoklamaDurum;
  String ogretmenAdi;
  String ogretmenId;
  String ogrenciId;
  DateTime zaman;
  String dil;
  int tip;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        okulId: json["okulId"],
        sinifId: json["sinifId"],
        yoklamaDurum: json["yoklamaDurum"],
        ogretmenAdi: json["ogretmenAdi"],
        ogretmenId: json["ogretmenId"],
        ogrenciId: json["ogrenciId"],
        zaman: DateTime.parse(json["zaman"]),
        dil: json["dil"],
        tip: json["tip"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "sinifId": sinifId,
        "yoklamaDurum": yoklamaDurum,
        "ogretmenAdi": ogretmenAdi,
        "ogretmenId": ogretmenId,
        "ogrenciId": ogrenciId,
        "zaman": zaman.toIso8601String(),
        "dil": dil,
        "tip": tip,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
