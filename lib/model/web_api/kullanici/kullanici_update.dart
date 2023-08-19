// To parse this JSON data, do
//
//     final modelKullaniciUpdate = modelKullaniciUpdateFromJson(jsonString);

import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/kullanici/kullanici_giris.dart';

ModelKullaniciUpdate modelKullaniciUpdateFromJson(String str) =>
    ModelKullaniciUpdate.fromJson(json.decode(str));

String modelKullaniciUpdateToJson(ModelKullaniciUpdate data) => json.encode(data.toJson());

class ModelKullaniciUpdate {
  ModelKullaniciUpdate({
    required this.success,
    required this.data,
  });

  int success;
  KullaniciUpdateData data;

  factory ModelKullaniciUpdate.fromJson(Map<String, dynamic> json) => ModelKullaniciUpdate(
        success: json["success"],
        data: KullaniciUpdateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class KullaniciUpdateData {
  KullaniciUpdateData({
    required this.id,
    required this.okulId,
    required this.telefon,
    required this.notificationId,
    required this.smsSifre,
    required this.sifre,
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
  String smsSifre;
  String sifre;
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
  UpdateYetki yetki;
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

  factory KullaniciUpdateData.fromJson(Map<String, dynamic> json) => KullaniciUpdateData(
        id: json["_id"],
        okulId: List<String>.from(json["okulId"].map((x) => x)),
        telefon: json["telefon"],
        notificationId: json["notificationId"],
        smsSifre: json["smsSifre"],
        sifre: json["sifre"],
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
        yetki: UpdateYetki.fromJson(json["yetki"]),
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
        "smsSifre": smsSifre,
        "sifre": sifre,
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

  KullaniciData kullaniciDataDonustur() {
    return KullaniciData(
        id: id,
        okulId: okulId,
        telefon: telefon,
        notificationId: notificationId,
        smsSifre: smsSifre,
        sifre: sifre,
        adSoyad: adSoyad,
        fotografUrl: fotografUrl,
        ozelNot: ozelNot,
        sinifId: sinifId,
        ogrenciId: ogrenciId,
        ebeveynMi: ebeveynMi,
        onkayitMi: onkayitMi,
        gorunme: gorunme,
        dogumTarihi: dogumTarihi,
        cv: cv,
        yetki: Yetki(
            veli: yetki.veli,
            ogretmen: yetki.ogretmen,
            admin: yetki.admin,
            brans: yetki.brans),
        arsiv: arsiv,
        bildirim: bildirim,
        durum: durum,
        onkayitTarihi: onkayitTarihi,
        sifreGuncellemeTarihi: sifreGuncellemeTarihi,
        sonGirisTarihi: sonGirisTarihi,
        kayitZamani: kayitZamani,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v);
  }
}

class UpdateYetki {
  UpdateYetki({
    required this.veli,
    required this.ogretmen,
    required this.admin,
    required this.brans,
  });

  bool veli;
  bool ogretmen;
  bool admin;
  bool brans;

  factory UpdateYetki.fromJson(Map<String, dynamic> json) => UpdateYetki(
        veli: json["veli"],
        ogretmen: json["ogretmen"],
        admin: json["admin"],
        brans: json["brans"],
      );

  Yetki yetkiyeDonustur() {
    return Yetki(veli: veli, ogretmen: ogretmen, admin: admin, brans: brans);
  }

  Map<String, dynamic> toJson() => {
        "veli": veli,
        "ogretmen": ogretmen,
        "admin": admin,
        "brans": brans,
      };
}
