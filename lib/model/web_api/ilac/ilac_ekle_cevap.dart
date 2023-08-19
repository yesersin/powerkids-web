// To parse this JSON data, do
//
//     final modelIlacEkleCevap = modelIlacEkleCevapFromJson(jsonString);

import 'dart:convert';

ModelIlacEkleCevap modelIlacEkleCevapFromJson(String str) =>
    ModelIlacEkleCevap.fromJson(json.decode(str));

String modelIlacEkleCevapToJson(ModelIlacEkleCevap data) => json.encode(data.toJson());

class ModelIlacEkleCevap {
  ModelIlacEkleCevap({
    required this.success,
    required this.data,
  });

  int success;
  IlacEkleCevapData data;

  factory ModelIlacEkleCevap.fromJson(Map<String, dynamic> json) => ModelIlacEkleCevap(
        success: json["success"],
        data: IlacEkleCevapData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class IlacEkleCevapData {
  IlacEkleCevapData({
    required this.sinifId,
    required this.ogrenciId,
    required this.ogrenciAdSoyad,
    required this.veliId,
    required this.veliAdSoyad,
    required this.ogretmenId,
    required this.ogretmenAdSoyad,
    required this.yil,
    required this.ay,
    required this.gun,
    required this.saat,
    required this.ilacAdi,
    required this.not,
    required this.tip,
    required this.secenek,
    required this.goruldu,
    required this.dil,
    required this.durum,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String sinifId;
  String ogrenciId;
  String ogrenciAdSoyad;
  String veliId;
  String veliAdSoyad;
  String ogretmenId;
  String ogretmenAdSoyad;
  int yil;
  int ay;
  int gun;
  int saat;
  String ilacAdi;
  String not;
  int tip;
  String secenek;
  bool goruldu;
  String dil;
  bool durum;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory IlacEkleCevapData.fromJson(Map<String, dynamic> json) => IlacEkleCevapData(
        sinifId: json["sinifId"],
        ogrenciId: json["ogrenciId"],
        ogrenciAdSoyad: json["ogrenciAdSoyad"],
        veliId: json["veliId"],
        veliAdSoyad: json["veliAdSoyad"],
        ogretmenId: json["ogretmenId"],
        ogretmenAdSoyad: json["ogretmenAdSoyad"],
        yil: json["yil"],
        ay: json["ay"],
        gun: json["gun"],
        saat: json["saat"],
        ilacAdi: json["ilacAdi"],
        not: json["not"],
        tip: json["tip"],
        secenek: json["secenek"],
        goruldu: json["goruldu"],
        dil: json["dil"],
        durum: json["durum"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "sinifId": sinifId,
        "ogrenciId": ogrenciId,
        "ogrenciAdSoyad": ogrenciAdSoyad,
        "veliId": veliId,
        "veliAdSoyad": veliAdSoyad,
        "ogretmenId": ogretmenId,
        "ogretmenAdSoyad": ogretmenAdSoyad,
        "yil": yil,
        "ay": ay,
        "gun": gun,
        "saat": saat,
        "ilacAdi": ilacAdi,
        "not": not,
        "tip": tip,
        "secenek": secenek,
        "goruldu": goruldu,
        "dil": dil,
        "durum": durum,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
