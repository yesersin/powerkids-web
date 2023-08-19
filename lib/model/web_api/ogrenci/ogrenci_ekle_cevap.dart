// To parse this JSON data, do
//
//     final modelOgrenciEkleCevap = modelOgrenciEkleCevapFromJson(jsonString);

import 'dart:convert';

ModelOgrenciEkleCevap modelOgrenciEkleCevapFromJson(String str) =>
    ModelOgrenciEkleCevap.fromJson(json.decode(str));

String modelOgrenciEkleCevapToJson(ModelOgrenciEkleCevap data) => json.encode(data.toJson());

class ModelOgrenciEkleCevap {
  ModelOgrenciEkleCevap({
    required this.success,
    required this.data,
  });

  int success;
  OgrenciEkleData data;

  factory ModelOgrenciEkleCevap.fromJson(Map<String, dynamic> json) => ModelOgrenciEkleCevap(
        success: json["success"],
        data: OgrenciEkleData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class OgrenciEkleData {
  OgrenciEkleData({
    required this.okulId,
    required this.arsiv,
    required this.kimlikNo,
    required this.cinsiyet,
    required this.adSoyad,
    required this.dogumTarihi,
    required this.servis,
    required this.fotografUrl,
    required this.sinifId,
    required this.ozelBeslenme,
    required this.ozelNot,
    required this.onkayitMi,
    required this.durum,
    required this.id,
    required this.onkayitTarihi,
    required this.kayitZamani,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String okulId;
  bool arsiv;
  String kimlikNo;
  String cinsiyet;
  String adSoyad;
  DateTime dogumTarihi;
  int servis;
  String fotografUrl;
  String sinifId;
  bool ozelBeslenme;
  String ozelNot;
  bool onkayitMi;
  bool durum;
  String id;
  DateTime onkayitTarihi;
  DateTime kayitZamani;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory OgrenciEkleData.fromJson(Map<String, dynamic> json) => OgrenciEkleData(
        okulId: json["okulId"],
        arsiv: json["arsiv"],
        kimlikNo: json["kimlikNo"],
        cinsiyet: json["cinsiyet"],
        adSoyad: json["adSoyad"],
        dogumTarihi: DateTime.parse(json["dogumTarihi"]),
        servis: json["servis"],
        fotografUrl: json["fotografUrl"],
        sinifId: json["sinifId"],
        ozelBeslenme: json["ozelBeslenme"],
        ozelNot: json["ozelNot"],
        onkayitMi: json["onkayitMi"],
        durum: json["durum"],
        id: json["_id"],
        onkayitTarihi: DateTime.parse(json["onkayitTarihi"]),
        kayitZamani: DateTime.parse(json["kayitZamani"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "okulId": okulId,
        "arsiv": arsiv,
        "kimlikNo": kimlikNo,
        "cinsiyet": cinsiyet,
        "adSoyad": adSoyad,
        "dogumTarihi": dogumTarihi.toIso8601String(),
        "servis": servis,
        "fotografUrl": fotografUrl,
        "sinifId": sinifId,
        "ozelBeslenme": ozelBeslenme,
        "ozelNot": ozelNot,
        "onkayitMi": onkayitMi,
        "durum": durum,
        "_id": id,
        "onkayitTarihi": onkayitTarihi.toIso8601String(),
        "kayitZamani": kayitZamani.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
