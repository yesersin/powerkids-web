// To parse this JSON data, do
//
//     final modelVeliYemekNotUpdateCevap = modelVeliYemekNotUpdateCevapFromJson(jsonString);

import 'dart:convert';

ModelVeliYemekNotUpdateCevap modelVeliYemekNotUpdateCevapFromJson(String str) =>
    ModelVeliYemekNotUpdateCevap.fromJson(json.decode(str));

String modelVeliYemekNotUpdateCevapToJson(ModelVeliYemekNotUpdateCevap data) =>
    json.encode(data.toJson());

class ModelVeliYemekNotUpdateCevap {
  ModelVeliYemekNotUpdateCevap({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelVeliYemekNotUpdateCevap.fromJson(Map<String, dynamic> json) =>
      ModelVeliYemekNotUpdateCevap(
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
    required this.ogrenciId,
    required this.ogrenciAdSoyad,
    required this.veliAdSoyad,
    required this.veliId,
    required this.yil,
    required this.ay,
    required this.gun,
    required this.ogun,
    required this.not,
    required this.goruldu,
    required this.dil,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.sinifId,
  });

  String id;
  String okulId;
  String ogrenciId;
  String ogrenciAdSoyad;
  String veliAdSoyad;
  String veliId;
  int yil;
  int ay;
  int gun;
  int ogun;
  String not;
  bool goruldu;
  String dil;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String sinifId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        okulId: json["okulId"],
        ogrenciId: json["ogrenciId"],
        ogrenciAdSoyad: json["ogrenciAdSoyad"],
        veliAdSoyad: json["veliAdSoyad"],
        veliId: json["veliId"],
        yil: json["yil"],
        ay: json["ay"],
        gun: json["gun"],
        ogun: json["ogun"],
        not: json["not"],
        goruldu: json["goruldu"],
        dil: json["dil"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        sinifId: json["sinifId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "ogrenciId": ogrenciId,
        "ogrenciAdSoyad": ogrenciAdSoyad,
        "veliAdSoyad": veliAdSoyad,
        "veliId": veliId,
        "yil": yil,
        "ay": ay,
        "gun": gun,
        "ogun": ogun,
        "not": not,
        "goruldu": goruldu,
        "dil": dil,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "sinifId": sinifId,
      };
}
