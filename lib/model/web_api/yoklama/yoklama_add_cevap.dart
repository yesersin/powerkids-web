// To parse this JSON data, do
//
//     final modelYoklamaAddCevap = modelYoklamaAddCevapFromJson(jsonString);

import 'dart:convert';

ModelYoklamaAddCevap modelYoklamaAddCevapFromJson(String str) =>
    ModelYoklamaAddCevap.fromJson(json.decode(str));

String modelYoklamaAddCevapToJson(ModelYoklamaAddCevap data) => json.encode(data.toJson());

class ModelYoklamaAddCevap {
  ModelYoklamaAddCevap({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelYoklamaAddCevap.fromJson(Map<String, dynamic> json) => ModelYoklamaAddCevap(
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
    required this.sinifId,
    required this.yoklamaDurum,
    required this.ogretmenAdi,
    required this.ogretmenId,
    required this.ogrenciId,
    // required this.ogrenci,
    // required this.ogretmen,
    required this.dil,
    required this.tip,
    required this.durum,
    required this.id,
    required this.zaman,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String okulId;
  String sinifId;
  String yoklamaDurum;
  String ogretmenAdi;
  String ogretmenId;
  String ogrenciId;

  // String ogrenci;
  // String ogretmen;
  String dil;
  int tip;
  bool durum;
  String id;
  DateTime zaman;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        okulId: json["okulId"],
        sinifId: json["sinifId"],
        yoklamaDurum: json["yoklamaDurum"],
        ogretmenAdi: json["ogretmenAdi"],
        ogretmenId: json["ogretmenId"],
        ogrenciId: json["ogrenciId"],
        // ogrenci: json["ogrenci"],
        // ogretmen: json["ogretmen"],
        dil: json["dil"],
        tip: json["tip"],
        durum: json["durum"],
        id: json["_id"],
        zaman: DateTime.parse(json["zaman"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "okulId": okulId,
        "sinifId": sinifId,
        "yoklamaDurum": yoklamaDurum,
        "ogretmenAdi": ogretmenAdi,
        "ogretmenId": ogretmenId,
        "ogrenciId": ogrenciId,
        // "ogrenci": ogrenci,
        // "ogretmen": ogretmen,
        "dil": dil,
        "tip": tip,
        "durum": durum,
        "_id": id,
        "zaman": zaman.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
