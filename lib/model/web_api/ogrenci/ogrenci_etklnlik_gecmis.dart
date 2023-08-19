// To parse this JSON data, do
//
//     final modelOgrenciEtkinlikGecmis = modelOgrenciEtkinlikGecmisFromJson(jsonString);

import 'dart:convert';

ModelOgrenciEtkinlikGecmis modelOgrenciEtkinlikGecmisFromJson(String str) =>
    ModelOgrenciEtkinlikGecmis.fromJson(json.decode(str));

String modelOgrenciEtkinlikGecmisToJson(ModelOgrenciEtkinlikGecmis data) =>
    json.encode(data.toJson());

class ModelOgrenciEtkinlikGecmis {
  ModelOgrenciEtkinlikGecmis({
    required this.success,
    required this.data,
  });

  int success;
  List<OgrenciEtkinlikGecmis> data;

  factory ModelOgrenciEtkinlikGecmis.fromJson(Map<String, dynamic> json) =>
      ModelOgrenciEtkinlikGecmis(
        success: json["success"],
        data: List<OgrenciEtkinlikGecmis>.from(
            json["data"].map((x) => OgrenciEtkinlikGecmis.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OgrenciEtkinlikGecmis {
  OgrenciEtkinlikGecmis({
    required this.tip,
    required this.id,
    required this.okulId,
    required this.sinifId,
    required this.etkinlikId,
    required this.etkinlikAdi,
    required this.ogretmenAdi,
    required this.ogrenciId,
    required this.tercih,
    required this.dil,
    required this.durum,
    required this.zaman,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String tip;
  String id;
  String okulId;
  String sinifId;
  String etkinlikId;
  String etkinlikAdi;
  String ogretmenAdi;
  String ogrenciId;
  String tercih;
  String dil;
  bool durum;
  DateTime zaman;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory OgrenciEtkinlikGecmis.fromJson(Map<String, dynamic> json) => OgrenciEtkinlikGecmis(
        tip: json["tip"],
        id: json["_id"],
        okulId: json["okulId"],
        sinifId: json["sinifId"],
        etkinlikId: json["etkinlikId"],
        etkinlikAdi: json["etkinlikAdi"],
        ogretmenAdi: json["ogretmenAdi"],
        ogrenciId: json["ogrenciId"],
        tercih: json["tercih"],
        dil: json["dil"],
        durum: json["durum"],
        zaman: DateTime.parse(json["zaman"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tip": tip,
        "_id": id,
        "okulId": okulId,
        "sinifId": sinifId,
        "etkinlikId": etkinlikId,
        "etkinlikAdi": etkinlikAdi,
        "ogretmenAdi": ogretmenAdi,
        "ogrenciId": ogrenciId,
        "tercih": tercih,
        "dil": dil,
        "durum": durum,
        "zaman": zaman.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
