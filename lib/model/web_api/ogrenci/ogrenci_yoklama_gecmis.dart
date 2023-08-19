// To parse this JSON data, do
//
//     final modelOgrenciYoklamaGecmis = modelOgrenciYoklamaGecmisFromJson(jsonString);

import 'dart:convert';

ModelOgrenciYoklamaGecmis modelOgrenciYoklamaGecmisFromJson(String str) =>
    ModelOgrenciYoklamaGecmis.fromJson(json.decode(str));

String modelOgrenciYoklamaGecmisToJson(ModelOgrenciYoklamaGecmis data) =>
    json.encode(data.toJson());

class ModelOgrenciYoklamaGecmis {
  ModelOgrenciYoklamaGecmis({
    required this.success,
    required this.data,
  });

  int success;
  List<OgrenciYoklamaGecmis> data;

  factory ModelOgrenciYoklamaGecmis.fromJson(Map<String, dynamic> json) =>
      ModelOgrenciYoklamaGecmis(
        success: json["success"],
        data: List<OgrenciYoklamaGecmis>.from(
            json["data"].map((x) => OgrenciYoklamaGecmis.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OgrenciYoklamaGecmis {
  OgrenciYoklamaGecmis({
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
    required this.mesaj,
  });

  String id;
  String okulId;
  String sinifId;
  String yoklamaDurum;
  String ogretmenAdi;
  OgreId ogretmenId;
  OgreId ogrenciId;
  DateTime zaman;
  String dil;
  int tip;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String mesaj;

  factory OgrenciYoklamaGecmis.fromJson(Map<String, dynamic> json) => OgrenciYoklamaGecmis(
        id: json["_id"],
        okulId: json["okulId"],
        sinifId: json["sinifId"],
        yoklamaDurum: json["yoklamaDurum"],
        ogretmenAdi: json["ogretmenAdi"],
        ogretmenId: OgreId.fromJson(json["ogretmenId"]),
        ogrenciId: OgreId.fromJson(json["ogrenciId"]),
        zaman: DateTime.parse(json["zaman"]),
        dil: json["dil"],
        tip: json["tip"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        mesaj: json["mesaj"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "sinifId": sinifId,
        "yoklamaDurum": yoklamaDurum,
        "ogretmenAdi": ogretmenAdi,
        "ogretmenId": ogretmenId.toJson(),
        "ogrenciId": ogrenciId.toJson(),
        "zaman": zaman.toIso8601String(),
        "dil": dil,
        "tip": tip,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "mesaj": mesaj,
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
