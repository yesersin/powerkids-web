// To parse this JSON data, do
//
//     final modelOgrenciIlac = modelOgrenciIlacFromJson(jsonString);

import 'dart:convert';

ModelOgrenciIlac modelOgrenciIlacFromJson(String str) =>
    ModelOgrenciIlac.fromJson(json.decode(str));

String modelOgrenciIlacToJson(ModelOgrenciIlac data) => json.encode(data.toJson());

class ModelOgrenciIlac {
  ModelOgrenciIlac({
    required this.success,
    required this.data,
  });

  int success;
  OgrenciIlacData data;

  factory ModelOgrenciIlac.fromJson(Map<String, dynamic> json) => ModelOgrenciIlac(
        success: json["success"],
        data: OgrenciIlacData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class OgrenciIlacData {
  OgrenciIlacData({
    required this.id,
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
    required this.tip,
    required this.not,
    required this.secenek,
    required this.goruldu,
    required this.dil,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.mesaj,
  });

  String id;
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
  int tip;
  String not;
  String secenek;
  bool goruldu;
  String dil;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String mesaj;

  factory OgrenciIlacData.fromJson(Map<String, dynamic> json) => OgrenciIlacData(
        id: json["_id"],
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
        tip: json["tip"],
        not: json["not"],
        secenek: json["secenek"],
        goruldu: json["goruldu"],
        dil: json["dil"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        mesaj: json["mesaj"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
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
        "tip": tip,
        "not": not,
        "secenek": secenek,
        "goruldu": goruldu,
        "dil": dil,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "mesaj": mesaj,
      };
}
