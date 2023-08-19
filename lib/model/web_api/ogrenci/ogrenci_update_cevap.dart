// To parse this JSON data, do
//
//     final modelOgrenciUpdateCevap = modelOgrenciUpdateCevapFromJson(jsonString);

import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/sinif_ogrencileri.dart';

ModelOgrenciUpdateCevap modelOgrenciUpdateCevapFromJson(String str) =>
    ModelOgrenciUpdateCevap.fromJson(json.decode(str));

String modelOgrenciUpdateCevapToJson(ModelOgrenciUpdateCevap data) =>
    json.encode(data.toJson());

class ModelOgrenciUpdateCevap {
  ModelOgrenciUpdateCevap({
    required this.success,
    required this.data,
  });

  int success;
  OgrenciUpdateData data;

  factory ModelOgrenciUpdateCevap.fromJson(Map<String, dynamic> json) =>
      ModelOgrenciUpdateCevap(
        success: json["success"],
        data: OgrenciUpdateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class OgrenciUpdateData {
  OgrenciUpdateData({
    required this.id,
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
    required this.onkayitTarihi,
    required this.kayitZamani,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
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
  DateTime onkayitTarihi;
  DateTime kayitZamani;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory OgrenciUpdateData.fromJson(Map<String, dynamic> json) => OgrenciUpdateData(
        id: json["_id"],
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
        onkayitTarihi: DateTime.parse(json["onkayitTarihi"]),
        kayitZamani: DateTime.parse(json["kayitZamani"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "arsiv": arsiv,
        "kimlikNo": kimlikNo,
        "cinsiyet": cinsiyet,
        "adSoyad": adSoyad,
        "dogumTarihi":
            "${dogumTarihi.year.toString().padLeft(4, '0')}-${dogumTarihi.month.toString().padLeft(2, '0')}-${dogumTarihi.day.toString().padLeft(2, '0')}",
        "servis": servis,
        "fotografUrl": fotografUrl,
        "sinifId": sinifId,
        "ozelBeslenme": ozelBeslenme,
        "ozelNot": ozelNot,
        "onkayitMi": onkayitMi,
        "durum": durum,
        "onkayitTarihi": onkayitTarihi.toIso8601String(),
        "kayitZamani": kayitZamani.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };

  //update yapılan öğrenci bilgisi öğrenci modeline dönüştürülür
  ModelOgrenci ogrenciyeDonustur() {
    return ModelOgrenci(
        id: id,
        okulId: okulId,
        arsiv: arsiv,
        kimlikNo: kimlikNo,
        cinsiyet: cinsiyet,
        adSoyad: adSoyad,
        dogumTarihi: dogumTarihi,
        servis: servis,
        fotografUrl: fotografUrl,
        sinifId: sinifId,
        ozelBeslenme: ozelBeslenme,
        ozelNot: ozelNot,
        onkayitMi: onkayitMi,
        durum: durum,
        onkayitTarihi: onkayitTarihi,
        kayitZamani: kayitZamani,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v);
  }
}
