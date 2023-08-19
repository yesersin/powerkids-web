// To parse this JSON data, do
//
//     final modelEtkinlikAkisAddCevap = modelEtkinlikAkisAddCevapFromJson(jsonString);

import 'dart:convert';

ModelEtkinlikAkisAddCevap modelEtkinlikAkisAddCevapFromJson(String str) =>
    ModelEtkinlikAkisAddCevap.fromJson(json.decode(str));

String modelEtkinlikAkisAddCevapToJson(ModelEtkinlikAkisAddCevap data) =>
    json.encode(data.toJson());

class ModelEtkinlikAkisAddCevap {
  ModelEtkinlikAkisAddCevap({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelEtkinlikAkisAddCevap.fromJson(Map<String, dynamic> json) =>
      ModelEtkinlikAkisAddCevap(
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
    required this.etkinlikId,
    required this.etkinlikAdi,
    required this.ogretmenAdi,
    required this.ogrenciId,
    required this.tercih,
    required this.dil,
    required this.tip,
    required this.durum,
    required this.zaman,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String okulId;
  String sinifId;
  String etkinlikId;
  String etkinlikAdi;
  String ogretmenAdi;
  String ogrenciId;
  String tercih;
  String dil;
  String tip;
  bool durum;
  DateTime zaman;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        okulId: json["okulId"],
        sinifId: json["sinifId"],
        etkinlikId: json["etkinlikId"],
        etkinlikAdi: json["etkinlikAdi"],
        ogretmenAdi: json["ogretmenAdi"],
        ogrenciId: json["ogrenciId"],
        tercih: json["tercih"],
        dil: json["dil"],
        tip: json["tip"],
        durum: json["durum"],
        zaman: DateTime.parse(json["zaman"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "sinifId": sinifId,
        "etkinlikId": etkinlikId,
        "etkinlikAdi": etkinlikAdi,
        "ogretmenAdi": ogretmenAdi,
        "ogrenciId": ogrenciId,
        "tercih": tercih,
        "dil": dil,
        "tip": tip,
        "durum": durum,
        "zaman": zaman.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
