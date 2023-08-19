// To parse this JSON data, do
//
//     final modelKullaniciEkleCevap = modelKullaniciEkleCevapFromJson(jsonString);

import 'dart:convert';

ModelKullaniciEkleCevap modelKullaniciEkleCevapFromJson(String str) =>
    ModelKullaniciEkleCevap.fromJson(json.decode(str));

String modelKullaniciEkleCevapToJson(ModelKullaniciEkleCevap data) =>
    json.encode(data.toJson());

class ModelKullaniciEkleCevap {
  ModelKullaniciEkleCevap({
    required this.success,
    required this.data,
  });

  int success;
  KullaniciEkleData data;

  factory ModelKullaniciEkleCevap.fromJson(Map<String, dynamic> json) =>
      ModelKullaniciEkleCevap(
        success: json["success"],
        data: KullaniciEkleData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class KullaniciEkleData {
  KullaniciEkleData({
    required this.okulId,
    required this.telefon,
    required this.notificationId,
    required this.smsSifre,
    required this.sifre,
    required this.ozelNot,
    required this.adSoyad,
    required this.fotografUrl,
    required this.sinifId,
    required this.ogrenciId,
    required this.ebeveynMi,
    required this.onkayitMi,
    required this.cv,
    required this.yetki,
    required this.arsiv,
    required this.bildirim,
    required this.gorunme,
    required this.durum,
    required this.id,
    required this.onkayitTarihi,
    required this.sifreGuncellemeTarihi,
    required this.sonGirisTarihi,
    required this.kayitZamani,
    required this.dogumTarihi,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  List<String> okulId;
  String telefon;
  String notificationId;
  String smsSifre;
  String sifre;
  String ozelNot;
  String adSoyad;
  String fotografUrl;
  List<dynamic> sinifId;
  List<String> ogrenciId;
  bool ebeveynMi;
  bool onkayitMi;
  String cv;
  Yetki yetki;
  bool arsiv;
  bool bildirim;
  bool gorunme;
  bool durum;
  String id;
  DateTime onkayitTarihi;
  DateTime sifreGuncellemeTarihi;
  DateTime sonGirisTarihi;
  DateTime kayitZamani;
  DateTime dogumTarihi;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory KullaniciEkleData.fromJson(Map<String, dynamic> json) => KullaniciEkleData(
        okulId: List<String>.from(json["okulId"].map((x) => x)),
        telefon: json["telefon"],
        notificationId: json["notificationId"],
        smsSifre: json["smsSifre"],
        sifre: json["sifre"],
        ozelNot: json["ozelNot"],
        adSoyad: json["adSoyad"],
        fotografUrl: json["fotografUrl"],
        sinifId: List<dynamic>.from(json["sinifId"].map((x) => x)),
        ogrenciId: List<String>.from(json["ogrenciId"].map((x) => x)),
        ebeveynMi: json["ebeveynMi"],
        onkayitMi: json["onkayitMi"],
        cv: json["cv"],
        yetki: Yetki.fromJson(json["yetki"]),
        arsiv: json["arsiv"],
        bildirim: json["bildirim"],
        gorunme: json["gorunme"],
        durum: json["durum"],
        id: json["_id"],
        onkayitTarihi: DateTime.parse(json["onkayitTarihi"]),
        sifreGuncellemeTarihi: DateTime.parse(json["sifreGuncellemeTarihi"]),
        sonGirisTarihi: DateTime.parse(json["sonGirisTarihi"]),
        kayitZamani: DateTime.parse(json["kayitZamani"]),
        dogumTarihi: DateTime.parse(json["dogumTarihi"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "okulId": List<dynamic>.from(okulId.map((x) => x)),
        "telefon": telefon,
        "notificationId": notificationId,
        "smsSifre": smsSifre,
        "sifre": sifre,
        "ozelNot": ozelNot,
        "adSoyad": adSoyad,
        "fotografUrl": fotografUrl,
        "sinifId": List<dynamic>.from(sinifId.map((x) => x)),
        "ogrenciId": List<dynamic>.from(ogrenciId.map((x) => x)),
        "ebeveynMi": ebeveynMi,
        "onkayitMi": onkayitMi,
        "cv": cv,
        "yetki": yetki.toJson(),
        "arsiv": arsiv,
        "bildirim": bildirim,
        "gorunme": gorunme,
        "durum": durum,
        "_id": id,
        "onkayitTarihi": onkayitTarihi.toIso8601String(),
        "sifreGuncellemeTarihi": sifreGuncellemeTarihi.toIso8601String(),
        "sonGirisTarihi": sonGirisTarihi.toIso8601String(),
        "kayitZamani": kayitZamani.toIso8601String(),
        "dogumTarihi": dogumTarihi.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Yetki {
  Yetki({
    required this.veli,
    required this.ogretmen,
    required this.admin,
    required this.brans,
  });

  bool veli;
  bool ogretmen;
  bool admin;
  bool brans;

  factory Yetki.fromJson(Map<String, dynamic> json) => Yetki(
        veli: json["veli"],
        ogretmen: json["ogretmen"],
        admin: json["admin"],
        brans: json["brans"],
      );

  Map<String, dynamic> toJson() => {
        "veli": veli,
        "ogretmen": ogretmen,
        "admin": admin,
        "brans": brans,
      };
}
