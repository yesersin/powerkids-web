// To parse this JSON data, do
//
//     final modelEtkinlik = modelEtkinlikFromJson(jsonString);

import 'dart:convert';

ModelEtkinlik modelEtkinlikFromJson(String str) => ModelEtkinlik.fromJson(json.decode(str));

String modelEtkinlikToJson(ModelEtkinlik data) => json.encode(data.toJson());

class ModelEtkinlik {
  ModelEtkinlik({
    required this.success,
    required this.data,
  });

  int success;
  List<Etkinlik> data;

  factory ModelEtkinlik.fromJson(Map<String, dynamic> json) => ModelEtkinlik(
        success: json["success"],
        data: List<Etkinlik>.from(json["data"].map((x) => Etkinlik.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Etkinlik {
  Etkinlik({
    required this.id,
    required this.okulId,
    required this.tip,
    required this.seciliSecenek,
    required this.etkinlikAdi,
    required this.secenekBir,
    required this.secenekIki,
    required this.secenekUc,
    required this.secenekDort,
    required this.dil,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String okulId;
  String tip;
  String seciliSecenek;
  String etkinlikAdi;
  String secenekBir;
  String secenekIki;
  String secenekUc;
  String secenekDort;
  String dil;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Etkinlik.fromJson(Map<String, dynamic> json) => Etkinlik(
        id: json["_id"],
        okulId: json["okulId"],
        tip: json["tip"],
        seciliSecenek: json["seciliSecenek"],
        etkinlikAdi: json["etkinlikAdi"],
        secenekBir: json["secenekBir"],
        secenekIki: json["secenekIki"] == null ? null : json["secenekIki"],
        secenekUc: json["secenekUc"],
        secenekDort: json["secenekDort"],
        dil: json["dil"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "tip": tip,
        "seciliSecenek": seciliSecenek,
        "etkinlikAdi": etkinlikAdi,
        "secenekBir": secenekBir,
        "secenekIki": secenekIki == null ? null : secenekIki,
        "secenekUc": secenekUc,
        "secenekDort": secenekDort,
        "dil": dil,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
