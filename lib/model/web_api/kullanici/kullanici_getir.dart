// To parse this JSON data, do
//
//     final modelKullaniciGet = modelKullaniciGetFromJson(jsonString);

import 'dart:convert';

ModelKullaniciGetir modelKullaniciGetFromJson(String str) =>
    ModelKullaniciGetir.fromJson(json.decode(str));

String modelKullaniciGetToJson(ModelKullaniciGetir data) => json.encode(data.toJson());

class ModelKullaniciGetir {
  ModelKullaniciGetir({
    required this.success,
    required this.data,
  });

  int success;
  KullaniciGetirData data;

  factory ModelKullaniciGetir.fromJson(Map<String, dynamic> json) => ModelKullaniciGetir(
        success: json["success"],
        data: KullaniciGetirData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class KullaniciGetirData {
  KullaniciGetirData({
    required this.id,
    required this.okulId,
    required this.telefon,
    required this.notificationId,
    required this.adSoyad,
    required this.fotografUrl,
    required this.ozelNot,
    required this.sinifId,
    required this.ogrenciId,
    required this.ebeveynMi,
    required this.onkayitMi,
    required this.gorunme,
    required this.dogumTarihi,
    required this.cv,
    required this.yetki,
    required this.arsiv,
    required this.bildirim,
    required this.durum,
    required this.onkayitTarihi,
    required this.sifreGuncellemeTarihi,
    required this.sonGirisTarihi,
    required this.kayitZamani,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  List<String> okulId;
  String telefon;
  String notificationId;
  String adSoyad;
  String fotografUrl;
  String ozelNot;
  List<String> sinifId;
  List<String> ogrenciId;
  bool ebeveynMi;
  bool onkayitMi;
  bool gorunme;
  DateTime dogumTarihi;
  String cv;
  Yetki yetki;
  bool arsiv;
  bool bildirim;
  bool durum;
  DateTime onkayitTarihi;
  DateTime sifreGuncellemeTarihi;
  DateTime sonGirisTarihi;
  DateTime kayitZamani;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory KullaniciGetirData.fromJson(Map<String, dynamic> json) => KullaniciGetirData(
        id: json["_id"],
        okulId: List<String>.from(json["okulId"].map((x) => x)),
        telefon: json["telefon"],
        notificationId: json["notificationId"],
        adSoyad: json["adSoyad"],
        fotografUrl: json["fotografUrl"],
        ozelNot: json["ozelNot"],
        sinifId: List<String>.from(json["sinifId"].map((x) => x)),
        ogrenciId: List<String>.from(json["ogrenciId"].map((x) => x)),
        ebeveynMi: json["ebeveynMi"],
        onkayitMi: json["onkayitMi"],
        gorunme: json["gorunme"],
        dogumTarihi: DateTime.parse(json["dogumTarihi"]),
        cv: json["cv"],
        yetki: Yetki.fromJson(json["yetki"]),
        arsiv: json["arsiv"],
        bildirim: json["bildirim"],
        durum: json["durum"],
        onkayitTarihi: DateTime.parse(json["onkayitTarihi"]),
        sifreGuncellemeTarihi: DateTime.parse(json["sifreGuncellemeTarihi"]),
        sonGirisTarihi: DateTime.parse(json["sonGirisTarihi"]),
        kayitZamani: DateTime.parse(json["kayitZamani"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": List<dynamic>.from(okulId.map((x) => x)),
        "telefon": telefon,
        "notificationId": notificationId,
        "adSoyad": adSoyad,
        "fotografUrl": fotografUrl,
        "ozelNot": ozelNot,
        "sinifId": List<dynamic>.from(sinifId.map((x) => x)),
        "ogrenciId": List<dynamic>.from(ogrenciId.map((x) => x)),
        "ebeveynMi": ebeveynMi,
        "onkayitMi": onkayitMi,
        "gorunme": gorunme,
        "dogumTarihi": dogumTarihi.toIso8601String(),
        "cv": cv,
        "yetki": yetki.toJson(),
        "arsiv": arsiv,
        "bildirim": bildirim,
        "durum": durum,
        "onkayitTarihi": onkayitTarihi.toIso8601String(),
        "sifreGuncellemeTarihi": sifreGuncellemeTarihi.toIso8601String(),
        "sonGirisTarihi": sonGirisTarihi.toIso8601String(),
        "kayitZamani": kayitZamani.toIso8601String(),
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
