// To parse this JSON data, do
//
//     final modelYoklama = modelYoklamaFromJson(jsonString);

import 'dart:convert';

ModelYoklama modelYoklamaFromJson(String str) => ModelYoklama.fromJson(json.decode(str));

String modelYoklamaToJson(ModelYoklama data) => json.encode(data.toJson());

class ModelYoklama {
  ModelYoklama({
    required this.success,
    required this.data,
  });

  int success;
  List<ModelYoklamaOgrenci> data;

  factory ModelYoklama.fromJson(Map<String, dynamic> json) => ModelYoklama(
        success: json["success"],
        data: List<ModelYoklamaOgrenci>.from(
            json["data"].map((x) => ModelYoklamaOgrenci.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ModelYoklamaOgrenci {
  ModelYoklamaOgrenci({
    required this.id,
    required this.okulId,
    required this.sinifId,
    required this.yoklamaDurum,
    required this.ogretmenAdi,
    required this.ogretmenId,
    required this.ogrenciId,
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
  String yoklamaDurum;
  String ogretmenAdi;
  OgreId ogretmenId;
  OgreId ogrenciId;
  String dil;
  int tip;
  bool durum;
  DateTime zaman;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory ModelYoklamaOgrenci.fromJson(Map<String, dynamic> json) => ModelYoklamaOgrenci(
        id: json["_id"],
        okulId: json["okulId"],
        sinifId: json["sinifId"],
        yoklamaDurum: json["yoklamaDurum"],
        ogretmenAdi: json["ogretmenAdi"],
        ogretmenId: OgreId.fromJson(json["ogretmenId"]),
        ogrenciId: OgreId.fromJson(json["ogrenciId"]),
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
        "yoklamaDurum": yoklamaDurum,
        "ogretmenAdi": ogretmenAdi,
        "ogretmenId": ogretmenId.toJson(),
        "ogrenciId": ogrenciId.toJson(),
        "dil": dil,
        "tip": tip,
        "durum": durum,
        "zaman": zaman.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class OgreId {
  OgreId({
    required this.id,
    required this.adSoyad,
  });

  String id;
  String adSoyad;

  factory OgreId.fromJson(Map<String, dynamic> json) => OgreId(
        id: json["_id"],
        adSoyad: json["adSoyad"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adSoyad": adSoyad,
      };
}
