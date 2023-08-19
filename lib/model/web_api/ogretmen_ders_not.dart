// To parse this JSON data, do
//
//     final modelOgretmenDersNot = modelOgretmenDersNotFromJson(jsonString);

import 'dart:convert';

ModelOgretmenDersNot modelOgretmenDersNotFromJson(String str) =>
    ModelOgretmenDersNot.fromJson(json.decode(str));

String modelOgretmenDersNotToJson(ModelOgretmenDersNot data) => json.encode(data.toJson());

class ModelOgretmenDersNot {
  ModelOgretmenDersNot({
    required this.success,
    required this.data,
  });

  int success;
  List<OgretmenDersNot> data;

  factory ModelOgretmenDersNot.fromJson(Map<String, dynamic> json) => ModelOgretmenDersNot(
        success: json["success"],
        data: List<OgretmenDersNot>.from(json["data"].map((x) => OgretmenDersNot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OgretmenDersNot {
  OgretmenDersNot({
    required this.id,
    required this.okulId,
    required this.sinifId,
    required this.dersId,
    required this.ogretmenAdSoyad,
    required this.ogretmenId,
    required this.yil,
    required this.ay,
    required this.gun,
    required this.not,
    required this.dosya,
    required this.ders,
    required this.baslik,
    required this.goruldu,
    required this.dil,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String okulId;
  String sinifId;
  String dersId;
  String ogretmenAdSoyad;
  String ogretmenId;
  int yil;
  int ay;
  int gun;
  String not;
  List<dynamic> dosya;
  String ders;
  String baslik;
  List<dynamic> goruldu;
  String dil;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory OgretmenDersNot.fromJson(Map<String, dynamic> json) => OgretmenDersNot(
        id: json["_id"],
        okulId: json["okulId"],
        sinifId: json["sinifId"],
        dersId: json["dersId"],
        ogretmenAdSoyad: json["ogretmenAdSoyad"],
        ogretmenId: json["ogretmenId"],
        yil: json["yil"],
        ay: json["ay"],
        gun: json["gun"],
        not: json["not"],
        dosya: List<dynamic>.from(json["dosya"].map((x) => x)),
        ders: json["ders"],
        baslik: json["baslik"],
        goruldu: List<dynamic>.from(json["goruldu"].map((x) => x)),
        dil: json["dil"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "sinifId": sinifId,
        "dersId": dersId,
        "ogretmenAdSoyad": ogretmenAdSoyad,
        "ogretmenId": ogretmenId,
        "yil": yil,
        "ay": ay,
        "gun": gun,
        "not": not,
        "dosya": List<dynamic>.from(dosya.map((x) => x)),
        "ders": ders,
        "baslik": baslik,
        "goruldu": List<dynamic>.from(goruldu.map((x) => x)),
        "dil": dil,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
